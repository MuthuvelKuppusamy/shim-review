FROM ubuntu:20.04

COPY . /shim-review
RUN sed -i 's/# deb-src/deb-src/' /etc/apt/sources.list && \
    apt update -y && \
    DEBIAN_FRONTEND=noninteractive apt install -y devscripts git-buildpackage software-properties-common pesign && \
    apt build-dep -y shim

#checkout the source
RUN curl -L -O https://github.com/rhboot/shim/releases/download/15.6/shim-15.6.tar.bz2 && tar -xvjf shim-15.6.tar.bz2


WORKDIR /shim-15.6
RUN git apply /shim-review/*.patch
RUN cp /shim-review/microfocus_zenworks_secureboot1.cer /shim-15.6/ && cp /shim-review/sbat.mfzenworks.csv  /shim-15.6/data/sbat.csv
RUN make ENABLE_SHIM_HASH=true VENDOR_CERT_FILE=microfocus_zenworks_secureboot1.cer 'DEFAULT_LOADER=\\\\mfgrubx64.efi'
RUN mkdir -p /shim-15.6/build-x64 && cp shimx64.efi /shim-15.6/build-x64/
RUN mv /shim-15.6 /shimx64
WORKDIR /


#build for ia32 from fresh code
RUN tar -xvjf shim-15.6.tar.bz2
WORKDIR /shim-15.6
RUN git apply /shim-review/*.patch
RUN cp /shim-review/microfocus_zenworks_secureboot1.cer /shim-15.6/ && cp /shim-review/sbat.mfzenworks.csv  /shim-15.6/data/sbat.csv
RUN setarch linux32 && make  ENABLE_SHIM_HASH=true VENDOR_CERT_FILE=microfocus_zenworks_secureboot1.cer ARCH=ia32 'DEFAULT_LOADER=\\\\mfgrubia32.efi'
RUN mkdir -p /shim-15.6/build-ia32 && cp shimia32.efi /shim-15.6/build-ia32/
RUN mv /shim-15.6 /shimia32

#compare current build with  submitted shim-review binaries
RUN sha256sum /shimia32/build-ia32/shimia32.efi /shim-review/shimia32.efi /shimx64/build-x64/shimx64.efi /shim-review/shimx64.efi

