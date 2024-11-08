FROM python:3.13-slim
ARG MOLECULE_VERSION="24.9.0"
ARG YAMLLINT_VERSION="1.35.1"
ARG ANSIBLELINT_VERSION="24.9.2"
ARG ANSIBLE_VERSION="10.5.0"

RUN pip3 install --no-cache-dir --upgrade pip setuptools \
  && pip3 install --no-cache-dir --upgrade ansible==${ANSIBLE_VERSION}  molecule==${MOLECULE_VERSION} yamllint==${YAMLLINT_VERSION} docker 'molecule-plugins[docker]' dnspython \
  && pip3 install ansible-lint==${ANSIBLELINT_VERSION} \
  && rm -rf /var/cache/apt/* \
  && rm -r /root/.cache \ 
  && apt update -y \
  && apt install apt-transport-https ca-certificates curl software-properties-common -y \
  && curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
  && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb\_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null \
  && apt update -y \
  && apt install docker-ce -y

CMD ["/bin/sh"]

