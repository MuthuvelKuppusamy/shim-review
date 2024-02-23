FROM ubuntu:jammy

RUN apt update -y && \
    DEBIAN_FRONTEND=noninteractive apt install -y bsdmainutils gcc gcc-aarch64-linux-gnu  git lcab make dos2unix curl bzip2 pesign


COPY . /shim-review

#checkout the source
RUN curl -L -O https://github.com/rhboot/shim/releases/download/15.8/shim-15.8.tar.bz2 && tar -xvjf shim-15.8.tar.bz2

WORKDIR /shim-15.8

RUN git apply /shim-review/patches/*.patch

RUN cp /shim-review/microfocus_zenworks_secureboot1.cer /shim-15.8/ && cp /shim-review/sbat.mfzenworks.csv  /shim-15.8/data/sbat.csv
RUN make ENABLE_SHIM_HASH=true VENDOR_CERT_FILE=microfocus_zenworks_secureboot1.cer 'DEFAULT_LOADER=\\\\mfgrubx64.efi'
RUN mkdir -p /shim-15.8/build-x64 && cp shimx64.efi /shim-15.8/build-x64/
RUN mv /shim-15.8 /shimx64


#Build for ia32 from fresh code
WORKDIR /

RUN tar -xvjf shim-15.8.tar.bz2

WORKDIR /shim-15.8


RUN git apply /shim-review/patches/*.patch

RUN cp /shim-review/microfocus_zenworks_secureboot1.cer /shim-15.8/ && cp /shim-review/sbat.mfzenworks.csv  /shim-15.8/data/sbat.csv
RUN setarch linux32 && make  ENABLE_SHIM_HASH=true VENDOR_CERT_FILE=microfocus_zenworks_secureboot1.cer ARCH=ia32 'DEFAULT_LOADER=\\\\mfgrubia32.efi'
RUN mkdir -p /shim-15.8/build-ia32 && cp shimia32.efi /shim-15.8/build-ia32/
RUN mv /shim-15.8 /shimia32

#Compare current build with  submitted shim-review binaries
RUN sha256sum /shimia32/build-ia32/shimia32.efi /shim-review/shimia32.efi /shimx64/build-x64/shimx64.efi /shim-review/shimx64.efi

