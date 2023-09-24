---
date: 2020-06-18
category:
  - aws
  - lambda
  - serverless
slug: aws-lambda-functions-with-sam-cli
---

# Building AWS Lambda Functions with SAM CLI
The [SAM (Serverless Application Model)](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html) allows you to build complex and production ready lambda functions that are performant yet light-weight. If you are new to serverless computing or lambda functions, checkout my [quick start guide](/blog/aws-lambda-functions-quickstart/). This article helps you with getting started with SAM CLI.

<!-- more -->

The SAM CLI provides you a development environment that is identical to lambda execution environment. This is possible via a Docker image. Thus before installing SAM, you need a few prerequisites met:

## Installing SAM CLI
The prerequisites are

 - Docker desktop
 - Shared drive space between host and Docker
 - Homebrew

The [SAM installation guide](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install-mac.html) walks you through the steps involved for various platforms. After installation, you need to configure it with your AWS account info as [explained here](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-getting-started-set-up-credentials.html)

```cmd
>> sam --version
SAM CLI, version 1.31.0
```
When installing SAM using `brew`, I noticed the install is global and not restricted to a particular `conda` env.

## Setting up a SAM APP
SAM makes it easy to get started with guided CLI set ups and deploys. To start a project, run `sam init` and answer the questions as shown below:

```cmd
(aws_lambda_default) ➜  sam-try git:(master) sam init
Which template source would you like to use?
	1 - AWS Quick Start Templates
	2 - Custom Template Location
Choice: 1
What package type would you like to use?
	1 - Zip (artifact is a zip uploaded to S3)	
	2 - Image (artifact is an image uploaded to an ECR image repository)
Package type: 1

Which runtime would you like to use?
	1 - nodejs14.x
	2 - python3.9
	3 - ruby2.7
	4 - go1.x
	5 - java11
	6 - dotnetcore3.1
	7 - nodejs12.x
	8 - nodejs10.x
	9 - python3.8
	10 - python3.7
	11 - python3.6
	12 - python2.7
	13 - ruby2.5
	14 - java8.al2
	15 - java8
	16 - dotnetcore2.1
Runtime: 9

Project name [sam-app]: try-sam-app

Cloning from https://github.com/aws/aws-sam-cli-app-templates

AWS quick start application templates:
	1 - Hello World Example
	2 - EventBridge Hello World
	3 - EventBridge App from scratch (100+ Event Schemas)
	4 - Step Functions Sample App (Stock Trader)
	5 - Elastic File System Sample App
Template selection: 1

    -----------------------
    Generating application:
    -----------------------
    Name: try-sam-app
    Runtime: python3.8
    Dependency Manager: pip
    Application Template: hello-world
    Output Directory: .
    
    Next steps can be found in the README file at ./try-sam-app/README.md
```
This creates a folder by the name you provided for the project name during the interactive setup. The structure of the project looks like below:

```
(aws_lambda_default) ➜  sam-try git:(master) ✗ exa -T try-sam-app -R -I venv
try-sam-app
├── __init__.py
├── events
│  └── event.json
├── hello_world
│  ├── __init__.py
│  ├── app.py             # The main app which has the lambda_handler fn
│  └── requirements.txt   # pip install pkgs
├── README.md
├── template.yaml         # cloud formation template pre populated
└── tests
   ├── __init__.py
   ├── integration
   │  ├── __init__.py
   │  └── test_api_gateway.py
   ├── requirements.txt
   └── unit
      ├── __init__.py
      └── test_handler.py
```

You can now edit the files from here. For more info on this, skip to the [SAM spec model](#sam-specification-the-model) topic.

### Build SAM app

The app can be built by calling `sam build` from inside the app dir (which has the `template.json` file.)

```
(aws_lambda_default) ➜  try-sam-app git:(master) ✗ sam build
Building codeuri: ~/.../try-sam-app/hello_world runtime: python3.8 metadata: {} functions: ['HelloWorldFunction']
Running PythonPipBuilder:ResolveDependencies
Running PythonPipBuilder:CopySource

Build Succeeded

Built Artifacts  : .aws-sam/build
Built Template   : .aws-sam/build/template.yaml

Commands you can use next
=========================
[*] Invoke Function: sam local invoke
[*] Deploy: sam deploy --guided
```

### Testing App locally
There are 2 ways to test the app locally. One is the simpler `invoke` command which builds the app in a Docker image, calls the handler (based on what's defined in `events.json`), reports the output and exits. It looks like below:

```
(aws_lambda_default) ➜  try-sam-app git:(master) ✗ sam local invoke
Invoking app.lambda_handler (python3.8)
Image was not found.
Removing rapid images for repo public.ecr.aws/sam/emulation-python3.8
Building image...................
Skip pulling image and use local one: public.ecr.aws/sam/emulation-python3.8:rapid-1.31.0.

Mounting ~/.../try-sam-app/.aws-sam/build/HelloWorldFunction as /var/task:ro,delegated inside runtime container
START RequestId: e027b54f-86ea-4a31-83ed-ce09d83b9053 Version: $LATEST
END RequestId: e027b54f-86ea-4a31-83ed-ce09d83b9053
REPORT RequestId: e027b54f-86ea-4a31-83ed-ce09d83b9053	Init Duration: 0.11 ms	Duration: 98.97 ms	Billed Duration: 100 ms	Memory Size: 128 MB	Max Memory Used: 128 MB	
{"statusCode": 200, "body": "{\"message\": \"hello world\"}"}%                                                                                                                                            (aws_lambda_default) ➜  try-sam-app git:(master) ✗ 
```

The second method is to use the app interactively: Run `sam local start-api`

```
>> sam local start-api
Mounting HelloWorldFunction at http://127.0.0.1:3000/hello [GET]
You can now browse to the above endpoints to invoke your functions. You do not need to restart/reload SAM CLI while working on your functions, changes will be reflected instantly/automatically. You only need to restart SAM CLI if you update your AWS SAM template
2021-09-27 16:12:15  * Running on http://127.0.0.1:3000/ (Press CTRL+C to quit)

>> curl http://127.0.0.1:3000/hello
{"message": "hello world"}%
```
Now, if you go to **[http://127.0.0.1:3000/hello](http://127.0.0.1:3000/hello)**, you get back the default "hello world" message.

### Deploying to production
Now that we have verified the local build works (using `sam local start-api`), we can use SAM to deploy the function to production. This is achieved by calling **`sam deploy`**. The first time this is called, SAM recommends calling it using the guided approach -> **`sam deploy --guided`**. This takes you through a series of questions which helps set up the deployment or cloud formation stack. Once deployment is complete, it returns with a publicly invocable URL that you can distribute to your users.

Often, you might find that some set up which works in the local dev environment breaks in production. You might end up patching the function multiple times. During such cases, you can simply call **`sam deploy`** or better, `sam deploy --no-confirm-changeset` and let SAM build, configure the changesets and deploy them to production. The function is restarted and will get the updates.

## SAM specification (the model)
The model is specified in a template while in YAML format as shown below:

```yaml
Transform: AWS::Serverless-2016-10-31

Globals:
  set of globals
  Defines whether product is a Function, API, SimpleTable, HttpApi

Description:
  String

Metadata:
  template metadata

Parameters:
  set of parameters # values to pass to the template at runtime

Mappings:
  set of mappings # kvp to pass based on conditions

Conditions:
  set of conditions # conditions, logic statements

Resources:
  set of resources # stack resources such as EC2 instance or S3 bucket info or details of the lambda runtime

Outputs:
  set of outputs # describe the values returned when you view the stack's properties
```
Only the `Transform` and `Resources` is required. Since this template is derived from AWS CloudFormation template, there are some overlaps. For example, below is the template created by the hello world application

```yaml
AWSTemplateFormatVersion: '2010-09-09'
Transform: AWS::Serverless-2016-10-31
Description: >
  try-sam-app

  Sample SAM Template for try-sam-app

Globals:
  Function:
    Timeout: 3

Resources:
  HelloWorldFunction:
    Type: AWS::Serverless::Function
    Properties:
      CodeUri: hello_world/
      Handler: app.lambda_handler
      Runtime: python3.7
      Events:
        HelloWorld:
          Type: Api
          Properties:
            Path: /hello
            Method: get

Outputs:
  HelloWorldApi:
    Description: "API Gateway endpoint URL for Prod stage for Hello World function"
    Value: !Sub "https://${ServerlessRestApi}.execute-api.${AWS::Region}.amazonaws.com/Prod/hello/"
  HelloWorldFunction:
    Description: "Hello World Lambda Function ARN"
    Value: !GetAtt HelloWorldFunction.Arn
  HelloWorldFunctionIamRole:
    Description: "Implicit IAM Role created for Hello World function"
    Value: !GetAtt HelloWorldFunctionRole.Arn
```

This blog is a quick overview of authoring, testing and deploying as simple Python based Lambda function using the SAM CLI.