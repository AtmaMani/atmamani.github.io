Title: Docker tutorial
## Need for Docker
Pre-virtualization had a number of problems
 - huge cost of VMs
 - slow deployment, hard to manage
 - VMWare and VirtualBox provided virtualization software which improved the process
 - things improved when Azure, AWS started providing VMs for hire. They provided pay-as-you-go model. Also deployment was extremely fast.

Virtualization changed the game as they allowed to almost eliminate the virtual OS.
 - all containers run on the same linux kernel. However, isolation is provided at runtime.
 - containers pack up only the needed parts of the OS. Thus they are faster to deploy, scale up
 - containers are fully portable

## Docker architecture
There are 2 distinct parts
 - `docker client` - you interact with this layer, typically via CLI apps
 - `docker daemon` - the background process which powers the containers. We don't talk to this directly, but only via the `docker client`.

Typically, the docker client and daemon run on the same machine, but it is possible from the client to connect to a remote daemon.

### Images and Containers, Registries and Repositories
**Images** are read-only templates composed by stacking up other images. They are hosted on docker registry.

**Containers** is an instance of an image.

**Registry** is where we store our images. You can host this yourself or use Docker's public registry called `DockerHub`. **Repositories** are repos within the registry where images of a particular type are stored.

**Docker Hub** - is a public registry. Official repos are encouraged to be used as they are vetted by Docker and ensure they get security updates frequently. Generally, user created repos have a prefixing `username/repo_name/image_name`. Usually, `tags` are used to specify docker versions.

## Docker commands - quickstart
 - list all images held locally - `docker images`
 - run an image - `docker run busybox:1.23 echo "hello world"` which is of syntax `docker run image <command to run on image> <argument for command>` On running this, Docker will try to find the image locally, if not found, will download from docker hub and run. Example output below:

```cmd
open-geo [master] $ docker run busybox:latest echo "hello atma"
Unable to find image 'busybox:latest' locally
latest: Pulling from library/busybox
697743189b6d: Pull complete 
Digest: sha256:061ca9704a714ee3e8b80523ec720c64f6209ad3f97c0ff7cb9ec7d19f15149f
Status: Downloaded newer image for busybox:latest
hello atma
open-geo [master] $ 
```
 - if you run the same command agin, it will run faster as there is no downloading.
 - you can do other things like look at the contents of the image by calling `docker run busybox:latest ls /`

#### Running docker in interactive mode
 - run the image with `-i`, `-t` commands for interactive, TTY mode.
 - `docker run -i -t busybox:latest`. You can exit by typing `exit`

#### Running in foreground vs detached modes
The default mode is to run in foreground. Docker will start the process in container, attaches the console to this process' std output. You terminate the process and the connection together. When running, the terminal cannot be used for other things.

Background / detached mode on the other hand can be stared with `-d ` flag. The container is killed when the root process of container terminates. You can use the terminal to do other things while the container is running.

 - `docker run -d busybox:latest sleep 100` will run it in background mode.
 - You can list the running **containers** using `docker ps` command. Add the `-a` to list all containers that are stopped as well.
 - By default, docker remembers both your containers and images. So you can rerun a docker container. If you do not want to retain a container, use `docker run --rm` option. The container is removed after it is run.
 - to remove a container, run `docker rm <name of container>`.
 - to run a container with a custom name, run `docker run --name <custom_name> <commands>`. Then you can verify this using `docker ps -a` command.
 - When running in **background mode**, you cannot see the logs. Thus, you can call `docker logs <container_name_or_id>` to view the logs.

#### Docker inspect
Use inspect to display low level information about a container or image.
 
 - to get low level details, run `docker inspect <container_id>` or `docker inspect <conatiner_name>`

#### Port mapping
We can expose a port on the container and map that to port on host using `-p` option. For instance: `docker run -it -p 8888:8080 tomcat:8.0` will run tomcat and map its `8888` port to the default `80` port on host.

## Docker images in detail
### Docker image layers
A docker image is built as a list of read-only layers. At the bottom is a **base layer** on which other docker images or custom apps are installed. You can see all the **layers** of an image using `docker history <image name:tag>` command.

When a new container is instantiated, a new **editable, writable (container) layer** is added on top of this read-only image layers. Thus when container is deleted, all changes are lost and the image remains unchanged. Thus different containers instantiated from same image can have different **data states** emanating from their thin, editable layers.

### Build docker image
There are 2 ways of building an image
  1. commit changes made to a container (yay!)
  2. by writing a **`Dockerfile`**.

#### Build docker image by committing a container
Here we make changes to the container, typically running it in interactive mode. Then after exiting the container (container can be stopped at this point), we call `docker commit <container name or id> <username/image_name:tag>`. Thus in this ex for example, I did the following
 - `docker run -it debian:jessie` which downloads and runs debian OS in interactive mode
 - from within the container, run `apt-get update && apt-get install -y git` to install GIT
 - exit container and to commit, I do `docker commit hopeful_ellis atmamani/debian:0.1`
 - then running `docker images` will report the `atmamani/debian` image.
 - finally, running `docker history atmamani/debian:0.1` lists the changes I made. Note, it only states modification as bash, meaning it was a bash command, but not what the command is.

#### Build docker image using `Dockerfile`
Dockerfile is a text based manifest. The file should not have any extension and must start with a capital `D`. Below is a sample Dockerfile
```docker
FROM debain:jessie
RUN apt-get update
RUN apt-get install -y git
RUN apt-get install -y vim
```
Then build it using command `docker build -t <username/imagename:tag> <buildcontext>` The build context here needs path to the dockerfile on disk. You can also use the build context to package up additional files into the docker image. Docker daemon will create a tarball of these files, send it to the contain, unpack. So I ran `docker build -t atmamani/debian:frmdckfile .` from the folder containing the Dockerfile.

Once built, you can inspect the history and now it reports it correctly:
```
docker-trials $ docker history atmamani/debian:frmdckfile
IMAGE               CREATED              CREATED BY                                      SIZE                COMMENT
a9d62a3217ae        25 seconds ago       /bin/sh -c apt-get install -y vim               29.7MB              
a4c2ad02f957        39 seconds ago       /bin/sh -c apt-get install -y git               85MB                
cdfcdde0ccab        About a minute ago   /bin/sh -c apt-get update                       10.3MB              
b6ebaf83dd59        8 days ago           /bin/sh -c #(nop)  CMD ["bash"]                 0B                  
<missing>           8 days ago           /bin/sh -c #(nop) ADD file:e044496893d9e2cbf…   129MB               
docker-trials $ 
```

##### Optimizing docker images
One aspect is to reduce the number of layers a docker image has. Each line in the Dockerfile corresponds to a layer. Thus chaining the lines into a single line will reduce this to 1 layer. For instance, the earlier Dockerfile can be trimmed to
```
FROM debian:jessie
RUN apt-get update && apt-get instal -y git vim
```

#### Baking run commands into Docker image
We can bake commands to be run when a container starts up from an image. The preferred way is to use `exec` commands, an alternate is to specify `bash` commands. We prefix such with `CMD` keyword. If you do not specify a CMD, the default is to bring up `bash`.

```
FROM debian:jessie
RUN apt-get update && apt-get install -y \
    git \
    python \
    vim
CMD ["echo", "helllo world"]
```
When a container is created, it runs this `helllo world` with a typo. You can also modify this at runtime, by specifying `docker run <image_name> <commands> <arguments>` such as `docker run atmamani/echoer echo hello hello`.

#### Copying files into the image
```
FROM debian:jessie
RUN apt-get update && apt-get install -y \
    git \
    python \
    vim
COPY ./abc.txt /tmp/abc.txt
```
The above will copy `abc.txt` from local dir into the `tmp` dir of the image. This will be available for all containers spun up from this image.

#### Pushing images to Docker hub
Some people say don't use `latest` tag, instead use a real SEMVER version. To tag an image before pushing to hub or production, you need to tag it appropriately. `docker tag <image name> <reponame/newname:tag>` Thus, `docker tag atmamani/debian:frmdckfile atmamani/debian:0.2`

Then push using `docker push <imagename>` as `docker push atmamani/debian:0.2`

## A Hello world app using Flask
Download the repo using `git clone -b v0.1 https://github.com/jleetutorial/dockerapp.git`. Then build the docker image using `docker build -t tut-dockerapp:v0.1 .`

Run the container as `docker run -d -p 5000:5000 tut-dockerapp:v0.1` this spins up the container and maps the port. You can use the web app at `localhost:5000`. If for some reason, this is not available or unknown, you can find the IP address of the docker using `docker-machine ls` or find which port is mapped using `docker ps`.

To **step into a running container**, use `docker exec -it <cont name or id> <command>`, such as `docker exec -it keen_noyce bash`. The `-i` flag makes it interactive. To **see the running process within the container** do `ps axu` from within the `home` directory:

```
dockerapp [(no branch)] $ docker exec -it keen_noyce bash
admin@dd29aef6445a:/app$ cd ~
admin@dd29aef6445a:~$ ps axu
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
admin        1  0.0  1.2 102852 25080 ?        Ss   19:33   0:00 python app.py
admin       17  0.1  0.1  19964  3680 pts/0    Ss   19:47   0:00 bash
admin       24  0.0  0.1  38380  3216 pts/0    R+   19:47   0:00 ps axu
admin@dd29aef6445a:~$ 
```
To exit out of the container's bash, type `exit`. To stop the container running as daemon, type `docker stop <container_name>`.

## KVP lookup app using Flask

## Linking containers using `redis`
`redis` is a message broker, inmemory cache, db service that is containerized. We need a redis Python client.

## Linking with Docker compose
`docker-compose.yml` is a YAML file. Verison 3 is up to date. You start with a version number. Then specify the services that needs to be run. The `dockerapp` contains the main, user facing app, the `depends_on` contains all other microservices that need to be spun up and the order in which they need to be spun up.
A sample looks like:

```yaml
verison: '3'
services:
  dockerapp:
    build: .
    ports:
      - "5000:5000"
    depends_on:
      - redis
  redis:
    image: redis:3.2.0
```
To build and run using docker compose, run `docker-compose up -d` from dir that contains the yaml file. Once done, you can run `docker ps` to see the containers created and being run.

To rebuild a docker compose, you may have to force it if are changing just the python stack. To force rebuild use `docker-compose build`.