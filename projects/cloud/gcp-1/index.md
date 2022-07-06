Title: An introduction to Google Cloud Platform - part 1

## Basics - logging in and getting set up.

### GCP "Project"
A **Google Cloud project** is an organizing entity for your Google Cloud resources. It often contains resources and services; for example, it may hold a pool of virtual machines, a set of databases, and a network that connects them together. Projects also contain **settings and permissions**, which specify security rules and who has access to what resources.

A Project ID is a unique identifier that is used to link Google Cloud resources and APIs to your specific project. **Project IDs are unique across Google Cloud**.

## About GCP
### `7` main categories of services
There are seven categories of Google Cloud services:

- **Compute**: A variety of machine types that support any type of workload. The different computing options let you decide how much control you want over operational details and infrastructure.
- **Storage**: Data storage and database options for structured or unstructured, relational or non relational data.
- **Networking**: Services that balance application traffic and provision security rules.
- **Cloud Operations**: A suite of cross-cloud logging, monitoring, trace, and other service reliability tools.
- **Tools**: Services that help developers manage deployments and application build pipelines.
- **Big Data**: Services that allow you to process and analyze large datasets.
- **Artificial Intelligence**: A suite of APIs that run specific artificial intelligence and machine learning tasks on Google Cloud.

[Here](https://googlecloudcheatsheet.withgoogle.com) is a cheetsheat containing all GCP services.

### IAM - Identity and Access management
GCP has `3` main types of roles:

Role                            | Permission                       
--------------------------------|--------------------------------------------
`roles/viewer` |	Permissions for read-only actions that do not affect state, such as viewing (but not modifying) existing resources or data.
`roles/editor` |	All viewer permissions, plus permissions for actions that modify state, such as changing existing resources.
`roles/owner`	| All editor permissions and permissions for the following actions: manage roles and permissions for a project and all resources within the project; set up billing for a project.


