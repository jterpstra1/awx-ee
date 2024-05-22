# Ansible AWX Execution Environment with AWS, AWS CLI, AWS SSM
[![Publish Docker image](https://github.com/jterpstra1/ansible-awx-ee/actions/workflows/main.yml/badge.svg)](https://github.com/jterpstra1/ansible-awx-ee/actions/workflows/main.yml)
## Table of contents

* [What is it?](#what-is-it)
* [Versioning](#versioning)
* [AWX configuration](#awx-configuration)
* [Installation details](#installation-details)
* [Troubleshooting](#troubleshooting)
    * [Job is not using the correct execution environment](#job-is-not-using-the-correct-execution-environment)
* [Please contribute!](#please-contribute)

-----

<a name="what-is-it"></a>

## What is it?

This project contains the configuration of an Ansible AWX Execution Environment container image with commonly used libraries.

It is based on the official Ansible AWX EE image and mainly includes:

* Cloud provider dependencies:

    * Amazon Web Services (AWS)
    * AWS CLI
    * AWS SSM

<a name="versioning"></a>

## Versioning

The versioning of this project is based on semantic versioning, and will start with development from version v0.0.1 and once the first offical release will be made, the versioning will switch to v1.0.0. 

After that we'll follow the normal semantic version ways.

<a name="awx-configuration"></a>

## AWX configuration

This image can be set up in AWX by:

1. Navigating to AWX > `Administration` > `Execution Environments`
2. Adding a new Execution Environment with the following details:

    * Name: `Custom AWX Execution Environment`
    * Image: `docker.io/mpjt/awx-ee:latest`
    * Pull policy: `Only pull if not present before running`

3. Applying the execution environment on the relevant job templates.

<a name="installation-details"></a>

## Installation details

In addition to using this image for AWX's execution environment, remember to define the list of Ansible Galaxy packages your project relies on in `/collections/requirements.yml`. That file has the following format:

    ---
    # Official documentation:
    # https://docs.ansible.com/ansible/devel/user_guide/collections_using.html
    
    collections:
    - collection1
    - collection2

In this example, `collection1` and `collection2` must of course be replaced by one of the values listed below.

Depending on your needs, the following collections are supported and can be added to the above file:

* Cloud providers:

    * [AWS](https://galaxy.ansible.com/amazon/aws): `amazon.aws`
    * [Azure](https://galaxy.ansible.com/azure/azcollection): `azure.azcollection`
    * [GCP](https://galaxy.ansible.com/google/cloud): `google.cloud`

* [Cryptography](https://galaxy.ansible.com/community/crypto): `community.crypto`
* [General](https://galaxy.ansible.com/community/general): `community.general`
* [Kubernetes](https://galaxy.ansible.com/kubernetes/core): `kubernetes.core`
* [PostgreSQL](https://galaxy.ansible.com/community/postgresql): `community.postgresql`
* [Terraform](https://galaxy.ansible.com/community/general): `community.general`

<a name="troubleshooting"></a>

## Troubleshooting

<a name="job-is-not-using-the-correct-execution-environment"></a>

### Job is not using the correct execution environment

Upon running a job, errors might appear which seem to be pointing to missing dependencies.

This is a common misconfiguration, remember to make sure your job templates are using the correct execution environment.

<a name="please-contribute"></a>

## Please contribute!

Have you found an issue? Do you have an idea for an improvement? Feel free to contribute by submitting it [on the GitHub project](https://github.com/jterpstra1/awx-ee/issues).
