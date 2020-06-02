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