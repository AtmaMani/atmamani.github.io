# Docker tutorial
#### Need for Docker
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

## Docker commands
 - list all images held locally - `docker images`
 - run an image - `docker run busybox:1.23 echo "hello world"` which is of syntax `docker run image <command to run on image>` 