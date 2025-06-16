FROM taylorabarnes/devenv

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get clean && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
                       catch2 \
                       cmake \
                       g++ \
                       googletest \
                       libcli11-dev \                       
                       libeigen3-dev \
                       libspdlog-dev \
                       libxtensor-dev \
                       libyaml-cpp-dev \
                       pdqsort-dev \
                       valgrind && \
   apt-get clean && \
   rm -rf /var/lib/apt/lists/*
