FROM centos:7

RUN yum install wget perl-Digest-SHA -y

RUN mkdir "/var/lib/elasticsearch" && chmod -R 777 /var/lib/elasticsearch

RUN groupadd -r elasticsearch && useradd -r -g  elasticsearch elasticsearch
USER elasticsearch

WORKDIR /home/elasticsearch

RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.9.0-linux-x86_64.tar.gz && \
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.9.0-linux-x86_64.tar.gz.sha512 && \
    shasum -a 512 -c elasticsearch-8.9.0-linux-x86_64.tar.gz.sha512 && \
    tar -xzf elasticsearch-8.9.0-linux-x86_64.tar.gz

RUN mkdir "/home/elasticsearch/elasticsearch-8.9.0/snapshots"

COPY ./elasticsearch.yml ./elasticsearch-8.9.0/config

EXPOSE 9200

ENTRYPOINT ./elasticsearch-8.9.0/bin/elasticsearch
