Confirm the following are included in your repo, checking each box:

 - [x] completed README.md file with the necessary information
 - [x] shim.efi to be signed
 - [x] public portion of your certificate(s) embedded in shim (the file passed to VENDOR_CERT_FILE)
 - [x] binaries, for which hashes are added to vendor_db ( if you use vendor_db and have hashes allow-listed )
 - [x] any extra patches to shim via your own git tree or as files
 - [x] any extra patches to grub via your own git tree or as files
 - [x] build logs
 - [x] a Dockerfile to reproduce the build of the provided shim EFI binaries

(If you don't have anything to include in one of these cases, then
check that case and mention this in your submission.)

*******************************************************************************
### What is the link to your tag in a repo cloned from rhboot/shim-review?
*******************************************************************************
https://github.com/MuthuvelKuppusamy/shim-review/tree/opentext-shim-x64-ia32-20261109

*******************************************************************************
### What is the SHA256 hash of your final SHIM binary?
*******************************************************************************
2359afa4d7fcc060772424443af215ffef563acd64e3c0817456084bf25e90a0  shimia32.efi
f2cc8270cf2af0558bfa118d9c0862c25cacda7836b7c0d9dda578b3cf0ce740  shimx64.efi

*******************************************************************************
### What is the link to your previous shim review request (if any, otherwise N/A)?
*******************************************************************************
https://github.com/rhboot/shim-review/issues/516

*******************************************************************************
### If no security contacts have changed since verification, what is the link to your request, where they've been verified (if any, otherwise N/A)?
*******************************************************************************
https://github.com/rhboot/shim-review/issues/516
