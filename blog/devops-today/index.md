Title: DevOps Today
Date: 2017-07-20 10:20
Category: technology
Tags: devops, chef, automation, containers, version-control
Slug: devops-today

As software development matures as an industry, there arose a need to identify and a group a set of tasks and folks, typically in back office, that are required to keep the rest of the software development shop running. These are the folks that keep the servers spinning, repositories and build process going, plumb and connect the various automation tools into a giant contraption. The industry came around to classify the various roles as `DevOps` short for Developers in Operations.

This blog is a short compendium of tools used by DevOps today (early 2017).

<!-- TEASER_END -->

## Version control systems
![github](https://assets-cdn.github.com/images/modules/logos_page/GitHub-Mark.png)
Called VCS in short form, this is where the sourcecode comes to live. Many popular VCS exist today, but you are more likely to have heard about `git` or `github` which are arguably the most popular today. VCS mark every change made to the source code and record who changed it, why and how each changes are linked to one another in a time line. In a large shop, about 50 or so developers can edit the same file yet stay sane and not overwrite or trample on other's work.

As the product reaches an important milestone, the team would pull the source code into a build process, convert it into a finished product so the sales team can sell it to customers. But today, in the world of agile software development the philosophy is to build often, ship often and get feedback and implement it immediately thereby reducing the risk of catastrophic failure or going irrelevant. Thus, the shipping process which was once in two years, now has to be performed every day! To enable this the DevOps use two of the following tools in abundance.

## Containerization
Traditionally software was sold in CD-ROMs which customers would buy and install in their computer. The software was as much a physical entity as it got to be. When the user installed, the software made tangible changes to the customer's operating systems as it copied numerous files into different places and took anywhere from an hour to several. This process was slow, error prone and made it very hard to build software for different operating systems (Windows vs MacOS vs Linux vs Solaris). As the internet and cloud computing came about, server software was installed on computers running on the cloud which the customers accessed as a service, hence the name `Saas` Software as a Service. With SaaS when the demand rose, the same software had to be installed on additional machines to meet the demand, then removed when the surge dropped. This process of mustering additional machines had to be performed in a matter of seconds if the company wanted to give a seamless experience to the customers and the traditional sense of shipping software as an installable file quickly became impossible.

The industry tried various solutions for this problem, one of which was to pre-create additional computers with the necessary software installed and have them turn on only when demand rose. But this meant a number of your assets are sitting idle for the most part and used sub-optimally. To combat this problem, a concept of virtualization was invented. In virtualization, the software and all the necessary dependencies including the operating system are compressed into an `image` file. When the demand spiked, any computer hardware can be quickly programmed to power up that image and serve the software. This was way faster than installing the full software and is used widely even today. 

As the containerization technology matured, the DevOps engineers found ways to shed the weight of the image. They invented a leaner method where they hand pick only the necessary parts of the operating sytem and the dependencies and the actual software and put them into something called `containers`. Containers turned out to be much smaller than images and they were able to power up and run much faster than virtual machines. Further, containers would run the same no matter the flavor of the host computer's architecture, which meant, software engineers can build software for linux and have them sold to a customer which is primarily a Windows shop.

### Docker
.. image:: /images/docker_logo.png

`Docker` is one of the most popular containerization technologies. A `docker repository` contains a bunch of such container images that a software sells. The `docker registry` is a place where such repositories are hosted so customers can search for, buy and use. The `docker hub` and more recently `docker store` are public websites which host registries.

When the customer wants to use a software shipped as a `docker image`, he/she has to install a `docker engine` which will act as a host to power up the `docker images` into `containers`. Increasingly customers identify a powerful computer which they designate for docker engine so it can power up a number of containers which the rest of the company can use as a service. In such cases they use `docker swarm` which is a cluster of docker engines running in `swarm mode`.

Some companies might lease a cloud from `docker cloud` and run their containers on hardware leased from docker company while other larger companies can by `docker datacenter` software so they can power up an entire datacenter using docker based technology.

## Continuous integration
![Jenkins](https://wiki.jenkins-ci.org/download/attachments/2916393/logo.png?version=1&modificationDate=1302753947000)
At the turn of this decade (2011), the software industry embraced a new concept of reducing the gap between software build process and customer involvement. In the old water fall model, the build process had definite stages of planning, constructions, testing and deployment. Often with the pace at which technology evolved, the software being built went out of date before it got delivered. To solve this problem, the industry adopted an `agile` framework where the build cycles are reduced to a short 3 week period and at the end of it, a fully build software was shipped to the customer. The customer would use, provide feedback which the development team would work on and in another 3 weeks, send out an increment.

This model works well, but it also means some tasks which were performed once a year such as build, test, etc. has to be performed every day and in some cases every hour. Thus the devops engineers devised a procedure where at every time a change is made to the source code (or at set intervals) the entire source code gets compiled, built into a finished product, run tests against it and pushed into the deployment phase. This is called `continuous integration`. To orchestrate this complex process a number of tools are available in the market, some of which are `Jenkins`, `CircleCI`, `TravisCI`, `TeamCity` etc.
 
## Chef
![chef](http://s3.amazonaws.com/opscode-corpsite/assets/121/pic-chef-logo.png)

Continuous integration solved the problem of keeping the agile software development in a loop. However, when the business model is to sell software as a service, devop engineers had to also automate the process of updating the service with the latest software, something I call `agile deployment`. To meet these needs, devop engineers need an all overseeing automation platform which can orchestrate the entire process of `agile development` and `agile deployment`. `Chef` is one such product that is popular in the industry today. Though a set of `cookbooks`, engineers can automate the creation and deployment of containers that result from the continuous integration framework.

# Conclusion
Thus this blog outlined some of the popular tools in the devops tool belt. By no means this is a complete or exhaustive list and I have grossly generalized a lot of the processes involved. However the idea of software development in today's world is portrayed to the best accuracy as possible.