Confirm the following are included in your repo, checking each box:

 - [x] completed README.md file with the necessary information
 - [x] shim.efi to be signed
 - [x] public portion of your certificate(s) embedded in shim (the file passed to VENDOR_CERT_FILE)
 - [x] binaries, for which hashes are added to vendor_db ( if you use vendor_db and have hashes allow-listed )
       N/A
 - [x] any extra patches to shim via your own git tree or as files
       N/A
 - [x] any extra patches to grub via your own git tree or as files
       N/A
 - [x] build logs
 - [x] a Dockerfile to reproduce the build of the provided shim EFI binaries

*******************************************************************************
### What is the link to your tag in a repo cloned from rhboot/shim-review?
*******************************************************************************
https://github.com/MuthuvelKuppusamy/shim-review/tree/microfocus-shim-x64-ia32-20230109

*******************************************************************************
### What is the SHA256 hash of your final SHIM binary?
*******************************************************************************
923ea4c27ae6cfe219097b5e9468353dfbab29f6fc5c1c18f75b54fccc525d19  shimia32.efi
2c8af042ab1b099ed92cf30a8f0ddc61f381e9f8b19c704464098b61fe4a306f  shimx64.efi

*******************************************************************************
### What is the link to your previous shim review request (if any, otherwise N/A)?
*******************************************************************************
https://github.com/rhboot/shim-review/issues/166
