title: A Gentle Introduction to Cloud Computing
date: 11/12/2019
slug: gentle-introduction-cloud-computing
categories: technology
tags: cloud, python, serverless

# Computing mindset for the 2010s
Cloud computing took off in the decade of 2010s. Up until then, when people wanted to run an application, they had to buy computers, databases, switches, network, domains, software, hire IT staff to deploy and maintain anything on the internet. This is similar to learning everything about electricity before you can learn to turn on and off the power switch. Cloud computing changed all of this and allowed developers to build things on the internet without having to worry about hardware and networking.

## What is cloud computing?
Cloud computing is renting of resources like storage, CPU, GPU from a server farm. You only pay for what you use - time or storage.

### 3 compute patterns
We can group compute patterns on the cloud to 3 categories:

 - Virtual Machines - where you rent VMs of certain guest OS and manage all the software, OS updates, driver updates etc on it.
 - Containers - similar to VMs, but lack a separate guest OS. All the app logic and data is bundled into an image that is run directly on the host OS
 - Serverless - this is just code, not even images. You write your app to constitute a bunch of functions which are called on demand.

<img src='/images/vm-vs-container-vs-serverless.png'>

Unlike VMs and containers, when using serverless, you only pay for **function execution time**. In VMs and containers, you pay for **run time** of container and VM, even if they are idle.

### Characteristics of cloud compute
Cloud computing is **cost effective** as there is no up-front infrastructure cost, no fixed rent, no spearate electricity or utility bills for your servers.

It is **scalable** on demand. You can **vertically scale** by switching to a host machine with more RAM and CPUs or **horizontally scale** by distributing load to many servers and scaling out.

Scaling can be automatic or manual and can be based off a threshold such as CPU load or traffic per second. Thus, the cloud provider can add more resources during peak times and remove unused resources during down time. This nature of scalling is called **being elastic**.

Cloud gives the promise of being **current** - with respect to security patches, OS updates, hardware improvements etc and **reliable** - as redundancy is built-in by replicating / backing up periodically. This makes it fault tolerant and recoverable from disasters.

All of these happen automatically, in the background, without any interruption to your apps or to the users consuming your apps. Further, cloud makes your app go **global** as it can replicate content across multiple data centers, allowing for minimal network lag when accessed from across the globe.

On top of all this, cloud is **secure** as they have some of the best firewalls, anti viruses and dedicated team working to thwart attacks. They are also physically secure as they are remote in secure facilities.


## References
1. [Azure - principles of cloud computing](https://docs.microsoft.com/en-us/learn/modules/principles-cloud-computing)