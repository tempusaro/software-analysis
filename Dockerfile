FROM ubuntu:18.04

# Set the work directory 
WORKDIR /root

# Stop questions about geography
ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Etc/UTC

# enable man pages
RUN sed -i 's:^path-exclude=/usr/share/man:#path-exclude=/usr/share/man:' \
        /etc/dpkg/dpkg.cfg.d/excludes

# Minimal setup
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    lsb-release \
    locales \
    gnupg2 \
    git \
    wget \
    vim \
    man \
    manpages-posix \
    python3 \
    python3-pip \
    tzdata \
    dnsutils \ 
    cmake \ 
    curl 

RUN dpkg-reconfigure locales


# CS6888 General 
RUN apt-get update && \
    apt-get install -y \
    afl \
    afl-cov \
    lcov \
    gcc 
    #cppcheck 


# infer (versions >=1 require newer glibc that isn't compatible with building tcc) 
RUN wget https://github.com/facebook/infer/releases/download/v0.17.0/infer-linux64-v0.17.0.tar.xz && \
    tar -xf infer-linux64-v*.tar.xz && \
    rm infer-linux64-v*.tar.xz && \ 
    mv infer-* infer 

# cppcheck (repo/oss version doesn't have `--bug-hunting`)
RUN wget https://www.cs.virginia.edu/~rm5tx/6888/cppc.tar.gz && \
    tar -xzf cppc.tar.gz && \
    rm cppc.tar.gz && \
    cd cppcheck && \
    mkdir build && \
    cd build && \
    cmake .. && \
    cmake --build . && \
    mkdir /usr/local/share/Cppcheck && \
    cp -r /root/cppcheck/build/bin/* /usr/local/share/Cppcheck

## tcc
#RUN git clone git://repo.or.cz/tinycc.git && \
#    cd tinycc && \
#    ./configure --prefix=/root/tcc-cov --extra-cflags="-fprofile-arcs -ftest-coverage" --extra-ldflags="-coverage" && \
#    make && \
#    #make test && \ i
#    make install 





# KLEE
#RUN git clone https://github.com/klee/klee.git && \ 
#    cd klee && \
#    BASE=$HOME/klee_deps COVERAGE=0 ENABLE_DOXYGEN=0 USE_TCMALLOC=1 LLVM_VERSION=11 ENABLE_OPTIMIZED=1 ENABLE_DEBUG=0 DISABLE_ASSERTIONS=1 REQUIRES_RTTI=1 SOLVERS=STP:Z3 GTEST_VERSION=1.11.0 UCLIBC_VERSION=klee_0_9_29 TCMALLOC_VERSION=2.9.1 SANITIZER_BUILD= STP_VERSION=master MINISAT_VERSION=master Z3_VERSION=4.8.15 USE_LIBCXX=1 KLEE_RUNTIME_BUILD="Debug+Asserts" ./scripts/build/build.sh klee --install-system-deps



# https://github.com/AlexandreCarlton/afl-docker/blob/master/Dockerfile
# We set AFL_I_DONT_CARE_ABOUT_MISSING_CRASHES and AFL_SKIP_CPUFREQ
# since we cannot respectively do without sudo privileges:
#   echo core >/proc/sys/kernel/core_pattern
# and
#   cd /sys/devices/system/cpu
#   echo performance | tee cpu*/cpufreq/scaling_governor
ENV AFL_I_DONT_CARE_ABOUT_MISSING_CRASHES=1 \
    AFL_SKIP_CPUFREQ=1 \
    CC=afl-gcc \
    CXX=afl-g++
