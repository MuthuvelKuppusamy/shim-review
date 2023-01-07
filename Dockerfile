FROM ubuntu:20.04

COPY . /shim-review
RUN sed -i 's/# deb-src/deb-src/' /etc/apt/sources.list && \
    apt update -y && \
    DEBIAN_FRONTEND=noninteractive apt install -y devscripts git-buildpackage software-properties-common pesign && \
    apt build-dep -y shim

#checkout the source
RUN git clone --recursive -b 15.7 https://github.com/rhboot/shim.git shim-15.7

WORKDIR /shim-15.7

#For Patch 535 binutils 
RUN git checkout 657b2483ca6e9fcf2ad8ac7ee577ff546d24c3aa

#For patch 530, 531
RUN git apply /shim-review/*.patch

RUN cp /shim-review/microfocus_zenworks_secureboot1.cer /shim-15.7/ && cp /shim-review/sbat.mfzenworks.csv  /shim-15.7/data/sbat.csv
RUN make ENABLE_SHIM_HASH=true VENDOR_CERT_FILE=microfocus_zenworks_secureboot1.cer 'DEFAULT_LOADER=\\\\mfgrubx64.efi'
RUN mkdir -p /shim-15.7/build-x64 && cp shimx64.efi /shim-15.7/build-x64/
RUN mv /shim-15.7 /shimx64


#Build for ia32 from fresh code
WORKDIR /

RUN git clone --recursive -b 15.7 https://github.com/rhboot/shim.git shim-15.7

WORKDIR /shim-15.7

#For Patch 535 binutils 
RUN git checkout 657b2483ca6e9fcf2ad8ac7ee577ff546d24c3aa

#For patch 530, 531
RUN git apply /shim-review/*.patch

RUN cp /shim-review/microfocus_zenworks_secureboot1.cer /shim-15.7/ && cp /shim-review/sbat.mfzenworks.csv  /shim-15.7/data/sbat.csv
RUN setarch linux32 && make  ENABLE_SHIM_HASH=true VENDOR_CERT_FILE=microfocus_zenworks_secureboot1.cer ARCH=ia32 'DEFAULT_LOADER=\\\\mfgrubia32.efi'
RUN mkdir -p /shim-15.7/build-ia32 && cp shimia32.efi /shim-15.7/build-ia32/
RUN mv /shim-15.7 /shimia32

#Compare current build with  submitted shim-review binaries
RUN sha256sum /shimia32/build-ia32/shimia32.efi /shim-review/shimia32.efi /shimx64/build-x64/shimx64.efi /shim-review/shimx64.efi

