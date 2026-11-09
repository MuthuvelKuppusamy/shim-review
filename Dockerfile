FROM ubuntu:noble


RUN apt-get -qq update && DEBIAN_FRONTEND=noninteractive apt-get -qq --no-install-recommends install build-essential ca-certificates curl gpg gpg-agent git pesign

COPY . /shim-review

RUN mkdir -p /shimx64 /shimia32

#checkout the source
RUN curl -L -O https://github.com/rhboot/shim/releases/download/16.1/shim-16.1.tar.bz2 && tar -xvjf shim-16.1.tar.bz2 -C /shimx64

WORKDIR /shimx64/shim-16.1

RUN git apply /shim-review/patches/*.patch

RUN cp /shim-review/opentext.der /shimx64/shim-16.1/ && cp /shim-review/sbat.otzenworks.csv  /shimx64/shim-16.1/data/sbat.csv
RUN make DEBUG=1 ENABLE_SHIM_HASH=true VENDOR_CERT_FILE=opentext.der ARCH=x86_64 'DEFAULT_LOADER=\\\\otgrubx64.efi'
RUN mkdir -p /shim-16.1/build-x64 && cp shimx64.efi /shim-16.1/build-x64/

#Build for ia32 from fresh code
WORKDIR /

RUN tar -xvjf shim-16.1.tar.bz2 -C /shimia32

WORKDIR /shimia32/shim-16.1


RUN git apply /shim-review/patches/*.patch

RUN cp /shim-review/opentext.der /shimia32/shim-16.1 && cp /shim-review/sbat.otzenworks.csv  /shimia32/shim-16.1/data/sbat.csv
RUN setarch linux32 && make  ENABLE_SHIM_HASH=true VENDOR_CERT_FILE=opentext.der ARCH=ia32 'DEFAULT_LOADER=\\\\otgrubia32.efi'
RUN mkdir -p /shim-16.1/build-ia32 && cp shimia32.efi /shim-16.1/build-ia32/

#Compare current build with  submitted shim-review binaries
RUN sha256sum /shim-16.1/build-ia32/shimia32.efi /shim-review/shimia32.efi /shim-16.1/build-x64/shimx64.efi /shim-review/shimx64.efi

