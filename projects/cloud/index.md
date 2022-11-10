Title: Cloud computing

Some useful resources for building on the cloud. This page will primarily contain resources on AWS and GCP.

## Pages
- [Argo for Kubernetes](argo)
- [Google cloud platform](gcp-1)
- [Intro to Kubernetes](gke-1)
- [Kubernetes objects and specification](gke-2)
- [`kubectl` commands](k8s-1)
- [`gsutil` commands](gsutil-1)

## A little bit of history

**Cloud** is a general purpose definition used to refer to everything from compute, storage, networking and security on the cloud. Cloud is the current paradigm shift in computing. The shift of the early 21st century. Arguably, AI is the second paradigm shift. The shift to cloud computing involves a leap-of-faith move for most companies and those which embrace this are set to survive this tech era. The tech space is always evolving. The evolution here is especially noticeable due to its speed. The practice of moving to newer (and better) technologies involves abandoning the old ways of building software systems and rebuilding them on newer paradigms. This practice is called the **burning-platform-effect**. While the name sounds sounds ominous, the move is essential for survival in today's tech scene.

As companies migrated from on-premises to cloud, they saw a switch from **capital expenditures (CapEx) to operational expenditures (OpEx)**. This shift meant lower up-front cost and leveled the field for big and small companies to start up and expand globally. While earlier, you needed to have geo-political presence if you wanted to spread multi-nationally, today you can rent hardware / platform from cloud providers and accomplish the same. This benefit also meant, smaller, leaner companies can have an out-sized impact if they leveraged the power of cloud (and had everything else right - such as product market fit, demand, incentives, marketing, funding, staffing etc.)

The most profound effect of cloud tech is the vast amounts of data that is collected and consumed. Increasingly, humankind is switching from "connecting to online" to "living online". The result is the highly accurate and highly personalized predictive models that can be built. This leads us to the second paradigm shift - **Artificial Intelligence**.

AI requires not-only vast amounts of data, but also commiserate compute power. AI's compute demand has led to newer generations of processors be developed. The newer GPU based processors (such as TPU) break **Moore's law**. Instead of being 2x powerful, each subsequent generation is ~50x powerful.

## Cloud is in layers
- **IaaS**: Infrastructure as a Service - is the rawest form of cloud offering. Users get access to compute, storage and networking. They pay for what they **allocate**.
- **PaaS**: Platform as a Service - is an offering that wraps a layer over IaaS. PaaS is a bunch of **managed** services and users pay for what they **consume** rather than allocate.
- **SaaS**: Software as a Service - can be thought of a layer on top of PaaS. This is typically managed, server-less and oriented toward consumers. Most web applications can be considered as SaaS. Users pay for a service model / subscription tier rather than allocation or consumption.