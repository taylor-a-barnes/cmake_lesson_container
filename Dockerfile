FROM taylorabarnes/devenv

ENV DEBIAN_FRONTEND=noninteractive

# Install CMake
RUN curl -L --output cmake.tar.gz \
    https://github.com/Kitware/CMake/releases/download/v4.0.3/cmake-4.0.3-linux-x86_64.tar.gz && \
    tar -xzf cmake.tar.gz -C /usr --strip-components=1 && \
    rm cmake.tar.gz

RUN apt-get clean && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
                       catch2 \
                       g++ \
                       googletest \
                       libcli11-dev \
                       libeigen3-dev \
                       libspdlog-dev \
                       libxtensor-dev \
                       libyaml-cpp-dev \
                       libzstd-dev \
                       make \
                       pdqsort-dev && \
   apt-get clean && \
   rm -rf /var/lib/apt/lists/*
