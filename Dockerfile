FROM ubuntu:jammy

ENV KUBECTL_VERSION=1.26.0

RUN apt update && apt install -y \
  python3 \
  python3-pip \
  npm \
  iputils-ping \
  net-tools \
  curl

# install gcloud cli
RUN apt install -y apt-transport-https ca-certificates gnupg && \
  echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - && \
  apt update && apt install -y google-cloud-sdk

# install kubectl
RUN curl -LO https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
  chmod +x ./kubectl && \
  mv ./kubectl /usr/local/bin/kubectl

# install helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && \
  chmod 700 get_helm.sh && \
  ./get_helm.sh

# install aws cli
RUN pip3 install awscli

# install ansible
RUN pip3 install ansible

# install autocannon
RUN npm install -g autocannon

# install speedtest-cli
RUN pip3 install speedtest-cli

# tail for /tmp/log
RUN touch /tmp/log
CMD tail -f /tmp/log
