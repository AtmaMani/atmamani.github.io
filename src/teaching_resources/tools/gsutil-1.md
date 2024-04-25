# `gsutil` commands

## Introduction
[`gsutil`](https://cloud.google.com/storage/docs/gsutil) is a CLI tool to work with data on Google Storage Service. Using the tool, you can query public data anonymously. However, to query private data, you need to authenticate. Gsutil can inherit the auth from `gcloud` CLI.

The general syntax to represent a bucket is:

```
gs://BUCKET_NAME/<FOLDER_NAME>/OBJECT_NAME
```
You can have any number of nested sub-folders within a bucket.

Buckets in GCS are **globally-unique**, even for private buckets.

## Commands
Adapted from https://cloud.google.com/storage/docs/discover-object-storage-gsutil

#### Creating a bucket
```
gsutil mb -b on -l us-east1 gs://my-awesome-bucket/

>>> Creating gs://my-awesome-bucket/...
```
#### Uploading objects to a bucket
```
gsutil cp <path>/<file> gs://<bucket>/folder
```

#### Downloading objects from a bucket
```
gsutil cp gs://<bucket>/folder/file <local dest>/<path>
```

You can also copy content from one bucket / folder to another using the same command.

```
gsutil cp gs://my-awesome-bucket/kitten.png gs://my-awesome-bucket/just-a-folder/kitten3.png
```

#### List contents of a bucket
```
gsutil ls gs://<bucket>

# returns
gs://my-awesome-bucket/kitten.png
gs://my-awesome-bucket/just-a-folder/
```
You can use `-l` flag for details.

#### Deleting objects
```
gsutil rm gs://<bucket>/file
```
You can use the `-r` recursive flag to remove folders, and even buckets.