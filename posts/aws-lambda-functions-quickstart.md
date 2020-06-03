Title: AWS Lambda Functions - a Quick Start guide
Date: 2020-06-02 14:05
Category: technology
Tags: aws, lambda, serverless, cloud, cloud-compute
Slug: aws-lambda-functions-quickstart
status: draft

Lambda functions from AWS sit at the heart of its serverless compute services. It lets you run code without you as a developer having to procure, host, maintain and secure servers on the cloud. All you need to worry about is just the code and the business logic. This guide will help you get started creating simple lambda functions.

AWS promotes several services under its serverless platform as shown below:
<img src="/images/aws-serverless-services.jpg">

To create a lambda function, you need not learn a new language. You can code in one of many supported languages, including Python, Java, Node.JS etc. Your code can perform traditional compute as well as use AWS libraries to talk to the rest of AWS platform services. Scaling (compute scaling, network scaling, IO throughput scaling) happens automatically based on demand. System logs are written to AWS Cloudwatch service. As with any serverless compute service on AWS, you don't pay for idle time. Before we create a new function, we need to clear some concepts:

## Concepts
### Lambda function permissions
There are two types of permissions - a. what is allowed to invoke the function, and b. what the function is allowed to do (or talk to).

<img src="/images/aws-lambda-policies.png">

### Lambda event sources
Events are the triggers that cause a lambda function to run. For instance, a file being stored in S3, a cloud watch event etc. are event sources. Broadly, these triggers can be classified into two types: **a. Push events** (where the source is external to the fn) and **b. Poll events** (where the lambda will poll a service on a set interval).

<img src="/images/aws-lambda-event-types.png">

**Push events** can be `synchronous` or `asynchronous`. Sync events expect an immediate response, while async can do not. Async are suited for batch processing.

### Lifecycle of a lambda function
From the AWS training site: 
1. When a function is first invoked, an execution environment is launched and bootstrapped. Once the environment is bootstrapped, your function code executes. Then, Lambda freezes the execution environment, expecting additional invocations.

2. If another invocation request for the function is made while the environment is in this state, that request goes through a warm start. With a warm start, the available frozen container is thawed and immediately begins code execution without going through the bootstrap process.

3. This thaw and freeze cycle continues as long as requests continue to come in consistently. But if the environment becomes idle for too long, the execution environment is recycled.

4. A subsequent request starts the lifecycle over, requiring the environment to be launched and bootstrapped. This is a cold start.

<img src="/images/aws-lambda-lifecycle.gif">

## Authoring lambda functions
This is a simple lambda function that returns the current date:

```python
import json
from datetime import datetime

now_date = datetime.now().strftime('%y-%m-%d')

def lambda_handler(event, context):
    # TODO implement
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda! Now the time is: ' + now_date)
    }
```
The filename is `lambda_function.py` and the invocation is to `lambda_function.lambda_handler`.

At the core of a lambda function is the **`handler(event, context)`** method. The `event` object can either be AWS generated obj (when AWS services invoke) or custom user-defined obj. The `context` obj provides information about the current execution, such as remaining time etc.

You author lambda functions in 3 ways:
 1. use the Lambda Management Console web app, which is based off the **Cloud9** web IDE service.
 2. Upload code package after you author it using your IDE of choice
 3. Upload code package to a S3 bucket and give Lambda the url to the code.

Uploading to S3 bucket might be suitable if your package is >10 MB in size, or if the code is part of a CICD pipeline.

### Principles of a good lambda function
[AWS Lambda developer guide](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html) has more information on best practices. Below is the gist:

 - Functions in your code should be modular, testable and stateless. Separate out business logic from the handler function. If you can identify two separate tasks in your function, break them down and create two separate functions if that's possible. This makes it modular, just like a microservice.
 - To benefit from warm start, store data locally in `/tmp` directory. But don't assume it is always available.
 - To write data permanently, use **DynamoDB** service which is serverless and has millisecond latency.
 - To take advantage of **CloudWatch**, use Python's `logging` module. 
 - To pass sensitive information, use **environment variables**
 - While recursion might be elegant in regular programming, it can lead to uncontrolled behavior in lambda functions. So, avoid them.

### Lambda configurations
Lambda functions are billed for memory and duration of execution. The default memory is `128 MB` and you can request up to `2 GB`. When you request for a larger size, you get proportionally higher compute power and also a higher cost rate. Services are billed for execution duration, or until timeout. Default timeout is `3 sec` and the current max is `15 min`. Thus, you need to optimize for cost of higher memory and cost of exec duration. Sometimes, a higher memory might end up costing less, because it finishes in shorter duration. This comes down to profiling your function and understanding how you can speed it up.