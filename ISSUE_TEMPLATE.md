Confirm the following are included in your repo, checking each box:

 - [x] completed README.md file with the necessary information
 - [x] shim.efi to be signed
 - [x] public portion of your certificate(s) embedded in shim (the file passed to VENDOR_CERT_FILE)
 - [x] binaries, for which hashes are added to vendor_db ( if you use vendor_db and have hashes allow-listed )
 - [x] any extra patches to shim via your own git tree or as files
 - [x] any extra patches to grub via your own git tree or as files
 - [x] build logs
 - [x] a Dockerfile to reproduce the build of the provided shim EFI binaries

*******************************************************************************
### What is the link to your tag in a repo cloned from rhboot/shim-review?
*******************************************************************************
https://github.com/MuthuvelKuppusamy/shim-review/tree/opentext-shim-x64-ia32-20240223

*******************************************************************************
### What is the SHA256 hash of your final SHIM binary?
*******************************************************************************
ba8dc7f458e67f7a06345bd9989552c92d5bf7547ed6a0ba78032701b41320e4  shimia32.efi
efe378a2f706296e60ba55e3d4aa0a826950857b82c8135bc74302b43dd61c04  shimx64.efi

*******************************************************************************
### What is the link to your previous shim review request (if any, otherwise N/A)?
*******************************************************************************
https://github.com/rhboot/shim-review/issues/320
