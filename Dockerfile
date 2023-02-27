FROM ubuntu:18.04

# Set the work directory 
WORKDIR /root

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
    python3 \
    python3-pip

# Stop questions about geography
ARG DEBIAN_FRONTEND=noninteractive
RUN dpkg-reconfigure locales


# CS6888 General 
RUN apt-get update && \
    apt-get install -y \
    afl \
    afl-cov \
    lcov \
    gcc \
    cppcheck 


# infer 
RUN wget https://github.com/facebook/infer/releases/download/v1.1.0/infer-linux64-v1.1.0.tar.xz && \
    tar -xf infer-linux64-v1.1.0.tar.xz && \
    rm infer-linux64-v1.1.0.tar.xz && \ 
    mv infer-* infer 

# tcc
RUN git clone git://repo.or.cz/tinycc.git && \
    cd tinycc && \
    ./configure --prefix=/root/tcc-cov --extra-cflags="-fprofile-arcs -ftest-coverage" --extra-ldflags="-coverage" && \
    make && \
    #make test && \ i
    make install 

#0 9.962 ./tcc2: symbol lookup error: ./libtcc2.so: undefined symbol: __gcov_merge_add
#0 9.963 make[2]: *** [dlltest] Error 127
#0 9.963 Makefile:157: recipe for target 'dlltest' failed



# KLEE
#RUN git clone https://github.com/klee/klee.git && \ 
#    cd klee && \
#    BASE=$HOME/klee_deps COVERAGE=0 ENABLE_DOXYGEN=0 USE_TCMALLOC=1 LLVM_VERSION=11 ENABLE_OPTIMIZED=1 ENABLE_DEBUG=0 DISABLE_ASSERTIONS=1 REQUIRES_RTTI=1 SOLVERS=STP:Z3 GTEST_VERSION=1.11.0 UCLIBC_VERSION=klee_0_9_29 TCMALLOC_VERSION=2.9.1 SANITIZER_BUILD= STP_VERSION=master MINISAT_VERSION=master Z3_VERSION=4.8.15 USE_LIBCXX=1 KLEE_RUNTIME_BUILD="Debug+Asserts" ./scripts/build/build.sh klee --install-system-deps
