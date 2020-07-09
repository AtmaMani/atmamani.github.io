Title: Building AWS Lambda Functions with SAM CLI
Date: 2020-06-18 14:05
Category: technology
Tags: aws, lambda, serverless, cloud, cloud-compute
Slug: aws-lambda-functions-with-sam-cli
status: draft

The [SAM (Serverless Application Model)](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/what-is-sam.html) allows you to build complex and production ready lambda functions that are performant yet light-weight. If you are new to serverless computing or lambda functions, checkout my [quick start guide](/blog/aws-lambda-functions-quickstart/). This article helps you with getting started with SAM CLI.

<!--TEASER_END-->

[TOC]

The SAM CLI provides you a development environment that is identical to lambda execution environment. This is possible via a Docker image. Thus before installing SAM, you need a few prerequisites met:

## Installing SAM CLI
The prerequisites are

 - Docker desktop
 - Shared drive space between host and Docker
 - Homebrew

The [SAM installation guide](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install-mac.html) walks you through the steps involved for various platforms. After installation, you need to configure it with your AWS account info as [explained here](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-getting-started-set-up-credentials.html)

## SAM specification (the model)
The model is specified in a template while in YAML format as shown below:

```yaml
Transform: AWS::Serverless-2016-10-31

Globals:
  set of globals

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