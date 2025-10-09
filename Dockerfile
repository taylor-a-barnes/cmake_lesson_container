FROM taylorabarnes/devenv

ENV DEBIAN_FRONTEND=noninteractive

# Install CMake for the correct architecture (x86_64 or aarch64)
# It is possible to pin the version by passing, for example, --build-arg CMAKE_VERSION=4.0.3
ARG CMAKE_VERSION=
RUN set -eux; \
    # Resolve latest stable if not provided
    if [ -z "${CMAKE_VERSION}" ]; then \
      CMAKE_VERSION="$(curl -fsSL https://api.github.com/repos/Kitware/CMake/releases/latest \
        | grep -oP '"tag_name":\s*"\Kv[0-9.]+' \
        | sed 's/^v//')"; \
    fi; \
    # Map native arch to CMake asset suffix
    arch="$(uname -m)"; \
    case "$arch" in \
      x86_64|amd64) cmake_arch="linux-x86_64" ;; \
      aarch64|arm64) cmake_arch="linux-aarch64" ;; \
      *) echo "Unsupported arch: $arch" >&2; exit 1 ;; \
    esac; \
    curl -fL -o /tmp/cmake.tar.gz \
      "https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-${cmake_arch}.tar.gz"; \
    tar -xzf /tmp/cmake.tar.gz -C /usr --strip-components=1; \
    rm -f /tmp/cmake.tar.gz

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
