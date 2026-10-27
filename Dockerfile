# The source of the parent container can be found here:
# https://github.com/ansible/awx-ee
# Upstream stopped publishing version tags after 24.6.1, so "latest" is pinned by digest
# and Renovate proposes digest updates.
FROM quay.io/ansible/awx-ee:latest@sha256:eaab9b09f731e3561ee0d932123a9971c76095555520f71da7ff4f2d433b4c99

LABEL maintainer="Jurre van der Gaag - Terpstra <info@terpstra.tech>"
LABEL description="Ansible AWX Execution Environment with the AWS collection's Python dependencies, the AWS CLI and the Session Manager plugin."

# renovate: datasource=galaxy-collection depName=amazon.aws
ARG ANSIBLE_COLLECTION_AWS_VERSION=12.0.0
# renovate: datasource=github-tags depName=aws/aws-cli
ARG AWS_CLI_VERSION=2.38.6
# renovate: datasource=github-releases depName=aws/session-manager-plugin versioning=loose
ARG SSM_PLUGIN_VERSION=1.2.896.0

USER root

# Cloud: Amazon Web Services (AWS) collection dependencies
RUN pip3 install --no-cache-dir -r "https://raw.githubusercontent.com/ansible-collections/amazon.aws/${ANSIBLE_COLLECTION_AWS_VERSION}/requirements.txt"

# Cloud: AWS CLI
RUN curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_CLI_VERSION}.zip" -o /tmp/awscliv2.zip \
  && unzip -q /tmp/awscliv2.zip -d /tmp \
  && /tmp/aws/install \
  && rm -rf /tmp/awscliv2.zip /tmp/aws \
  && aws --version

# Cloud: AWS Session Manager plugin
RUN dnf install -y "https://s3.amazonaws.com/session-manager-downloads/plugin/${SSM_PLUGIN_VERSION}/linux_64bit/session-manager-plugin.rpm" \
  && dnf clean all \
  && session-manager-plugin --version

# Fix a bug in the runner's home directory
RUN chown -R 1000:1000 /runner

# Drop back to the regular user (good practice)
USER 1000
