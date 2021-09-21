Title: AWS Lambda Functions - authoring with Docker images
Date: 2021-09-20 14:05
Category: technology
Tags: aws, lambda, serverless, cloud, cloud-compute
Slug: aws-lambda-functions-with-docker-images

At re:Invent 2020, AWS announced support for authoring, shipping and deploying the popular serverless Lambda services via Docker images. Further, they allow images up to `10GB` in size. As multiple authorities noted, this is a game changer, particularly for the scientific Python community as this would allow us to author machine learning and even deep learning inferencing functions using AWS Lambdas. This blog takes a quick look at authoring a "hello-world" style lambda using Docker.

<!--TEASER_END-->

To understand how Docker works or how to build Docker images, checkout my [Docker 101 cheatsheet](/cheatsheets/docker-1). Having said that, you do not need to know much about Docker or containerization for simple functions.

## The Lambda runtime images
AWS provides the runtime images for different languages, including Python. The images are shared at `DockerHub: amazon/aws-lambda-provided` and `ECR Public: public.ecr.aws/lambda/provided`. As expected, the base image is a flavor of linux called **Amazon Linux**.

### The RIC and the RIE
The Python Docker images come with two important components pre-loaded. The **RIC - Runtime Interface Client** provides the interface between Lambda (infrastructure) & the function code. Think about the invoker from API gateway that runs your handler function. The **RIE - Runtime Interface Emulator** is a tool that allows you to test the code locally.

## High-level workflow
The steps involved in publishing a Lambda function using Docker images will look like below

1. Download base images in your language of choice
2. Package your code + dependencies + resource files into the image using Docker CLI
3. Push the image into **AWS ECR - AWS Elastic Container Registry**. *Note: You are not charged storage for these images*.
4. Create a function, choose 'Container Image' and the rest should be similar

### Gotchas
 - Image max size is `10 GB`
 - Application code should run on a read-only file system. Only the `/tmp` dir is writable with `512 MB` storage
 - The container is instantiated with a user with least set of permissions. Ensure app code conforms with this.
 - Container settings

```
ENTRYPOINT – Specifies the absolute path to the entry point of the application.
CMD – Specifies parameters that you want to pass in with ENTRYPOINT.
WORKDIR – Specifies the absolute path to the working directory.
ENV – Specifies an environment variable for the Lambda function. 
```

## Steps

* Install [Docker for desktop](https://docs.docker.com/get-docker) and [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
* Create your regular Lambda function into a folder called `app`. Store your `app.py`, `requirements.txt` files into it. See sample below:

**app.py**:
```python
try:
    import json
    import sys
    import requests
    print("All imports ok ...")
except Exception as e:
    print("Error Imports : {} ".format(e))


def lambda_handler(event, context):

    print("Hello AWS!")
    print("event = {}".format(event))
    return {
        'statusCode': 200,
        'message': 'hello from docker lambda'
    }
```

**requirements.txt**:
```
requests
```

* Create a docker file as below:

```dockerfile
FROM public.ecr.aws/lambda/python:3.8

# Copy function code
COPY app.py ${LAMBDA_TASK_ROOT}

# Install the function's deps
COPY requirements.txt  .
RUN pip3 install -r requirements.txt --target "${LAMBDA_TASK_ROOT}"

# set the CMD to handler
CMD [ "app.lambda_handler" ]
```

* Build Docker image using syntax `docker build -t <username/imagename:tag> <build context>`. For example: `docker build -t atmamani/aws-lambda-docker:v1 .`. This prints an output like below:

```docker
[+] Building 20.7s (9/9) FINISHED                                                                                                 
 => [internal] load build definition from Dockerfile                                                                         0.0s
 => => transferring dockerfile: 44B                                                                                          0.0s
 => [internal] load .dockerignore                                                                                            0.0s
 => => transferring context: 2B                                                                                              0.0s
 => [internal] load metadata for public.ecr.aws/lambda/python:3.8                                                            0.4s
 => [internal] load build context                                                                                            0.0s
 => => transferring context: 81B                                                                                             0.0s
 => [1/4] FROM public.ecr.aws/lambda/python:3.8@sha256:44c0de45aa1927eecd519ad48faa27fe3318717160b5f7560475d12abea7b427     18.0s
 => => resolve public.ecr.aws/lambda/python:3.8@sha256:44c0de45aa1927eecd519ad48faa27fe3318717160b5f7560475d12abea7b427      0.0s
 => => sha256:20666df3e004b212ed97db3bb9bc7cc0251d842f8b672f1722dc55c0d5f45367 74.99kB / 74.99kB                             0.8s
 => => sha256:f7ad8276137021bb0b0cbd6826ec86b0f04c78367e486f3c1728e389d1d400bc 415B / 415B                                   0.8s
 => => sha256:44c0de45aa1927eecd519ad48faa27fe3318717160b5f7560475d12abea7b427 1.58kB / 1.58kB                               0.0s
 => => sha256:80342c69b467fef0607f90fd75c631fb351da1049b71faaaf98c8c1ce859c7b2 3.00kB / 3.00kB                               0.0s
 => => sha256:af4b61775d4cf0f587278cfbc2cbbc9afc3480f5fed5a455a9289c2c387c7187 100.74MB / 100.74MB                           7.5s
 => => sha256:bb2e44738d79a6afd429e2a103f081ad47783de7a6f7305664aee8a2e9e3976b 3.32MB / 3.32MB                               2.4s
 => => sha256:891c7fcaabb6a1090e28f4d967f1e423aa7cfd1217267b7e9bfe6636cd7b08ef 54.77MB / 54.77MB                            10.0s
 => => sha256:c1ae0f49cb65052f0d9674682af2b3bbe09c34fa37004930ef2e8019b76fa2d5 16.10MB / 16.10MB                             6.6s
 => => extracting sha256:af4b61775d4cf0f587278cfbc2cbbc9afc3480f5fed5a455a9289c2c387c7187                                    4.9s
 => => extracting sha256:20666df3e004b212ed97db3bb9bc7cc0251d842f8b672f1722dc55c0d5f45367                                    0.0s
 => => extracting sha256:f7ad8276137021bb0b0cbd6826ec86b0f04c78367e486f3c1728e389d1d400bc                                    0.0s
 => => extracting sha256:bb2e44738d79a6afd429e2a103f081ad47783de7a6f7305664aee8a2e9e3976b                                    0.1s
 => => extracting sha256:891c7fcaabb6a1090e28f4d967f1e423aa7cfd1217267b7e9bfe6636cd7b08ef                                    3.0s
 => => extracting sha256:c1ae0f49cb65052f0d9674682af2b3bbe09c34fa37004930ef2e8019b76fa2d5                                    1.5s
 => [2/4] COPY app.py /var/task                                                                                              0.1s
 => [3/4] COPY requirements.txt  .                                                                                           0.0s
 => [4/4] RUN pip3 install -r requirements.txt --target "/var/task"                                                          2.0s
 => exporting to image                                                                                                       0.1s
 => => exporting layers                                                                                                      0.1s
 => => writing image sha256:ac4783629d43f0d1f2c641133419bf47b52531b7535bc2ad25dca73ab126f4ce                                 0.0s 
 => => naming to docker.io/atmamani/aws-lambda-docker:v1                                                                     0.0s
```
* Run the container locally using the command:

```
(base) ➜  app git:(master) docker run -p 9000:8080 atmamani/aws-lambda-docker:v1
```

* You can test by posting `curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{}'`
* If you notice any errors, you can edit the files and rebuild the image and update the tag. THen you can retest the application.
* Authenticate the AWS CLI by following [this help](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html).
* Pass the auth from AWS CLI to Docker CLI, so Docker can tag and later push the images. Docker CLI normally pushes to the default DockerHub registry. However, for Lambda to work, you need to push to Amazon ECR registry. In ECR, I used the web UI to make a repository called `ml2web`.
* Run below, where you replace `--region us-west-2` with your AWS region. You also replace `--profile <aws_profile_name>` with your AWS CLI profile name. If you are using just 1 account for all (don't do this), then you can skip this argument. The Docker username needs to be `AWS` always. The URL like string is the name of your ECR registry.

```
sudo aws ecr get-login-password --region us-west-2 --profile <aws_profile_name> | docker login --username AWS --password-stdin <your_ECR_registry_name>.dkr.ecr.us-west-2.amazonaws.com
```
This threw an error saying permission denied, however it still works for me.

* Then tag your image using the command `docker tag atmamani/aws-lambda-docker:v2 <your_ecr_name>.dkr.ecr.us-west-2.amazonaws.com/ml2web:v2`

* Then push to ECR using the command: `docker push <your_ECR_name>.dkr.ecr.us-west-2.amazonaws.com/ml2web:v2`

```
The push refers to repository [your_ecr_name.dkr.ecr.us-west-2.amazonaws.com/ml2web]
6b5cd20ea590: Pushed 
aef77c8c9312: Pushed 
623b1ac50c4e: Pushed 
a1f8e0568112: Pushed 
bcf453d1de13: Pushed 
f6ae2f36d5d7: Pushed 
5959c8f9752b: Pushed 
3e5452c20c48: Pushed 
9c4b6b04eac3: Pushed 
v2: digest: sha256:abcdefgh_some_sha size: 2206
```

* Finally, use the Lambda web UI to create a new function. The only difference is, you choose 'container image' in the radio and provide the URI to the ECR registry. You can then browse for your image and tag and choose it.


## Sources
 - [Runtime images](https://docs.aws.amazon.com/lambda/latest/dg/runtimes-images.html)
 - [Using container images with lambda](https://docs.aws.amazon.com/lambda/latest/dg/lambda-images.html)
 - [Announcement blog](https://aws.amazon.com/blogs/aws/new-for-aws-lambda-container-image-support/)
 - [Creating images using AWS base images](https://docs.aws.amazon.com/lambda/latest/dg/images-create.html)