FROM golang:alpine

RUN apk add --update docker openrc \
    && rc-update add docker boot

RUN cd $HOME \
    && GO111MODULE="on" go get sigs.k8s.io/kind@v0.11.0

RUN apk add --update curl openssl \
    && curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
    && chmod 700 get_helm.sh \
    && sh get_helm.sh \
    && rm get_helm.sh

RUN curl -sLO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
    && rm -rf kubectl

COPY ./*.sh ./tools/

ENTRYPOINT [ "/bin/sh" ]
CMD [ "./tools/create-helm.sh" ]
