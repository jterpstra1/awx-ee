# The source of the parent container can be found here:
# https://github.com/ansible/awx-ee

FROM quay.io/ansible/awx-ee:24.3.1

LABEL maintainer="Jurre van der Gaag - Terpstra <info@terpstra.tech>"
LABEL description="Ansible AWX Execution Environment container with Cloud providers, Terraform, Kubernetes and other common tools."

ENV ANSIBLE_COLLECTION_AWS_VERSION     7.2.0

USER root

# Cloud: Amazon Web Services (AWS)
RUN pip3 install -r https://raw.githubusercontent.com/ansible-collections/amazon.aws/${ANSIBLE_COLLECTION_AWS_VERSION}/requirements.txt

# Cloud: AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \\
  && unzip awscliv2.zip \\
    && ./aws/install


# Cloud: Amazon Session Manager
RUN dnf install -y https://s3.amazonaws.com/session-manager-downloads/plugin/latest/linux_64bit/session-manager-plugin.rpm

# Fix a bug in the runner's home directory
RUN chown -R 1000:1000 /runner

# Drop back to the regular user (good practice)
USER 1000
