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
https://github.com/MuthuvelKuppusamy/shim-review/tree/microfocus-shim-x64-ia32-20230929

*******************************************************************************
### What is the SHA256 hash of your final SHIM binary?
*******************************************************************************
c11e597213af28f78c2f231ea9764748a84e49747993e7a9c24f73875516ef8b  shimia32.efi
f88931998d2ee41e50671ba2528d93b1fcad2aa25706fbfe8bc9720fb0764b73  shimx64.efi

*******************************************************************************
### What is the link to your previous shim review request (if any, otherwise N/A)?
*******************************************************************************
https://github.com/rhboot/shim-review/issues/166
