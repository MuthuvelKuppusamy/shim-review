This repo is for review of requests for signing shim.  To create a request for review:

- clone this repo
- edit the template below
- add the shim.efi to be signed
- add build logs
- add any additional binaries/certificates/SHA256 hashes that may be needed
- commit all of that
- tag it with a tag of the form "myorg-shim-arch-YYYYMMDD"
- push that to github
- file an issue at https://github.com/rhboot/shim-review/issues with a link to your tag
- approval is ready when the "accepted" label is added to your issue

Note that we really only have experience with using GRUB2 on Linux, so asking
us to endorse anything else for signing is going to require some convincing on
your part.

Check the docs directory in this repo for guidance on submission and
getting your shim signed.

Here's the template:

*******************************************************************************
### What organization or people are asking to have this signed?
*******************************************************************************
OpenText

*******************************************************************************
### What product or service is this for?
*******************************************************************************
ZENworks - Unified Endpoint Management Solution (Imaging)

*******************************************************************************
### What's the justification that this really does need to be signed for the whole world to be able to boot it?
*******************************************************************************
We support software tools for OS Backup/Restore/Deployment for Windows and Linux. This tool is used on millions of end-point devices to manage day-to-day IT activities. Minimal Suse Linux Enterprise(SLE) distro (or) Windows Preboot Environment(WinPE) distro used to secure-boot the device in USB/CD/PXE mode.

*******************************************************************************
### Why are you unable to reuse shim from another distro that is already signed?
*******************************************************************************
We have custom code added in shim to prefer the proxyOffer instead of DhcpAck
We have second stage boot loader, which talks to our server to get the work type and loads WinPE or SLES to do imaging and other tasks.

*******************************************************************************
### Who is the primary contact for security updates, etc.?
The security contacts need to be verified before the shim can be accepted. For subsequent requests, contact verification is only necessary if the security contacts or their PGP keys have changed since the last successful verification.

An authorized reviewer will initiate contact verification by sending each security contact a PGP-encrypted email containing random words.
You will be asked to post the contents of these mails in your `shim-review` issue to prove ownership of the email addresses and PGP keys.
*******************************************************************************
- Name: Muthuvel K
- Position: Principal Engineer
- Email address: mkuppusamy@opentext.com
- PGP key fingerprint:

(Key should be signed by the other security contacts, pushed to a keyserver
like keyserver.ubuntu.com, and preferably have signatures that are reasonably
well known in the Linux community.)

*******************************************************************************
### Who is the secondary contact for security updates, etc.?
*******************************************************************************
- Name: Anand Navale
- Position: Product Architect
- Email address: anavale@opentext.com
- PGP key fingerprint:

(Key should be signed by the other security contacts, pushed to a keyserver
like keyserver.ubuntu.com, and preferably have signatures that are reasonably
well known in the Linux community.)

*******************************************************************************
### Were these binaries created from the 15.7 shim release tar?
Please create your shim binaries starting with the 15.7 shim release tar file: https://github.com/rhboot/shim/releases/download/15.7/shim-15.7.tar.bz2

This matches https://github.com/rhboot/shim/releases/tag/15.7 and contains the appropriate gnu-efi source.

*******************************************************************************
Yes, Used the source from https://github.com/rhboot/shim/releases/download/15.7/shim-15.7.tar.bz2 
Patches:
       patches/1_Enable_the_NX_compatibility_flag_by_default.patch
       patches/2_Add_validation_function_for_Microsoft_signing.patch
       patches/3_Make-sbat_var.S-parse-right-with-buggy-gcc-binutils.patch
       patches/4_prefer_proxyOfferReceived.patch - Our custom patch to precedence for ProxyOfferReceived in IPV4/6

*******************************************************************************
### URL for a repo that contains the exact code which was built to get this binary:
*******************************************************************************
https://github.com/rhboot/shim/releases/download/15.7/shim-15.7.tar.bz2

*******************************************************************************
### What patches are being applied and why:
*******************************************************************************
1. 1_Enable_the_NX_compatibility_flag_by_default.patch
   2_Add_validation_function_for_Microsoft_signing.patch
   3_Make-sbat_var.S-parse-right-with-buggy-gcc-binutils.patch

2. Our custom patch - Code added to prefer proxyDhcpOfferReceived over dhcpAck in case IPv4/6

*******************************************************************************
### If shim is loading GRUB2 bootloader what exact implementation of Secureboot in GRUB2 do you have? (Either Upstream GRUB2 shim_lock verifier or Downstream RHEL/Fedora/Debian/Canonical-like implementation)
*******************************************************************************
Downstream RHEL/Fedora/Debian/Canonical like implementation

*******************************************************************************
### If shim is loading GRUB2 bootloader and your previously released shim booted a version of grub affected by any of the CVEs in the July 2020 grub2 CVE list, the March 2021 grub2 CVE list, the June 7th 2022 grub2 CVE list, or the November 15th 2022 list, have fixes for all these CVEs been applied?

* CVE-2020-14372
* CVE-2020-25632
* CVE-2020-25647
* CVE-2020-27749
* CVE-2020-27779
* CVE-2021-20225
* CVE-2021-20233
* CVE-2020-10713
* CVE-2020-14308
* CVE-2020-14309
* CVE-2020-14310
* CVE-2020-14311
* CVE-2020-15705
* CVE-2021-3418 (if you are shipping the shim_lock module)

* CVE-2021-3695
* CVE-2021-3696
* CVE-2021-3697
* CVE-2022-28733
* CVE-2022-28734
* CVE-2022-28735
* CVE-2022-28736
* CVE-2022-28737

* CVE-2022-2601
* CVE-2022-3775
*******************************************************************************
Yes.

*******************************************************************************
### If these fixes have been applied, have you set the global SBAT generation on your GRUB binary to 3?
*******************************************************************************
Yes.

*******************************************************************************
### Were old shims hashes provided to Microsoft for verification and to be added to future DBX updates?
### Does your new chain of trust disallow booting old GRUB2 builds affected by the CVEs?
*******************************************************************************
Older shim hashes provided to Microsoft
We switched to new certificate now for shim15.7 signing, which blocks all the older signed grub2 binaries.

*******************************************************************************
### If your boot chain of trust includes a Linux kernel:
### Is upstream commit [1957a85b0032a81e6482ca4aab883643b8dae06e "efi: Restrict efivar_ssdt_load when the kernel is locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1957a85b0032a81e6482ca4aab883643b8dae06e) applied?
### Is upstream commit [75b0cea7bf307f362057cc778efe89af4c615354 "ACPI: configfs: Disallow loading ACPI tables when locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=75b0cea7bf307f362057cc778efe89af4c615354) applied?
### Is upstream commit [eadb2f47a3ced5c64b23b90fd2a3463f63726066 "lockdown: also lock down previous kgdb use"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eadb2f47a3ced5c64b23b90fd2a3463f63726066) applied?
*******************************************************************************
We will use SuSE Linux Enterprise Server kernel(SLES15SP5) 5.14.21-150400.53-default , First two patches present in this kernel. 
3rd one is not applicable as kernel debugging not allowed in kernel, as we are using PXE booted minimal distro environment to do imaging.

*******************************************************************************
### Do you build your signed kernel with additional local patches? What do they do?
*******************************************************************************
No, We consume kernel built by SUSE.

*******************************************************************************
### Do you use an ephemeral key for signing kernel modules?
### If not, please describe how you ensure that one kernel build does not load modules built for another kernel.
*******************************************************************************
We have not used ephemeral keys for kernel modules signing, We take as it is kernel and initrd from SUSE build images.

*******************************************************************************
### If you use vendor_db functionality of providing multiple certificates and/or hashes please briefly describe your certificate setup.
### If there are allow-listed hashes please provide exact binaries for which hashes are created via file sharing service, available in public with anonymous access for verification.
*******************************************************************************
No.

*******************************************************************************
### If you are re-using a previously used (CA) certificate, you will need to add the hashes of the previous GRUB2 binaries exposed to the CVEs to vendor_dbx in shim in order to prevent GRUB2 from being able to chainload those older GRUB2 binaries. If you are changing to a new (CA) certificate, this does not apply.
### Please describe your strategy.
*******************************************************************************
We switched to new certificate now for shim15.7 signing.

*******************************************************************************
### What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as closely as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
### If the shim binaries can't be reproduced using the provided Dockerfile, please explain why that's the case and what the differences would be.
*******************************************************************************
Dockerfile with this repo used to build the shimx64.efi and shimia32.efi.

*******************************************************************************
### Which files in this repo are the logs for your build?
This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
*******************************************************************************
build.log file has comeplete build information for shimx64.efi,shimia32.efi build and sha256sum validation at the end for submitted and built binaries.

*******************************************************************************
### What changes were made since your SHIM was last signed?
*******************************************************************************
No changes added. Only the version update from shim 15.4 to 15.7.

*******************************************************************************
### What is the SHA256 hash of your final SHIM binary?
*******************************************************************************
c11e597213af28f78c2f231ea9764748a84e49747993e7a9c24f73875516ef8b  shimia32.efi
f88931998d2ee41e50671ba2528d93b1fcad2aa25706fbfe8bc9720fb0764b73  shimx64.efi


*******************************************************************************
### How do you manage and protect the keys used in your SHIM?
*******************************************************************************
Keys are stored in HSM with restricted access.

*******************************************************************************
### Do you use EV certificates as embedded certificates in the SHIM?
*******************************************************************************
No.

*******************************************************************************
### Do you add a vendor-specific SBAT entry to the SBAT section in each binary that supports SBAT metadata ( grub2, fwupd, fwupdate, shim + all child shim binaries )?
### Please provide exact SBAT entries for all SBAT binaries you are booting or planning to boot directly through shim.
### Where your code is only slightly modified from an upstream vendor's, please also preserve their SBAT entries to simplify revocation.
*******************************************************************************
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
shim,3,UEFI shim,shim,1,https://github.com/rhboot/shim
shim.MFZENworks,1,MicroFocus,shim,15.7,https://www.microfocus.com/

grub:
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
grub,3,Free Software Foundation,grub,2.06,https://www.gnu.org/software/grub/
grub.sle,1,SUSE Linux Enterprise,grub2,2.06,mail:security-team@suse.de
grub.MFZENworks,1,MicroFocus,grub2,2.06-0-ZENworks1,https://www.microfocus.com/
### Which modules are built into your signed grub image?
*******************************************************************************
grub-core all_video boot cat chain configfile echo true efinet font gfxmenu gfxterm gzio halt iso9660 jpeg 
minicmd normal part_apple part_msdos part_gpt password_pbkdf2 png reboot search search_fs_uuid search_fs_file 
search_label sleep test video fat loadenv linuxefi btrfs ext2 xfs jfs reiserfs efinet tftp http luks gcry_rijndael 
gcry_sha1 gcry_sha256 mdraid09 mdraid1x lvm serial

*******************************************************************************
### What is the origin and full version number of your bootloader (GRUB or other)?
*******************************************************************************
https://github.com/MuthuvelKuppusamy/shim-review/tree/opentext-shim-x64-ia32-20230929/grub2
*******************************************************************************
### If your SHIM launches any other components, please provide further details on what is launched.
*******************************************************************************
In case of PXE boot, we launch our custom efi binary, which talks to our server and get the work details and loads WinPE(Windows Preboot Environment) or Suse-Linux based on the work type.

*******************************************************************************
### If your GRUB2 launches any other binaries that are not the Linux kernel in SecureBoot mode, please provide further details on what is launched and how it enforces Secureboot lockdown.
*******************************************************************************
No.

*******************************************************************************
### How do the launched components prevent execution of unauthenticated code?
*******************************************************************************
Used shim_lock to validate the chain loaded binaries.

*******************************************************************************
### Does your SHIM load any loaders that support loading unsigned kernels (e.g. GRUB)?
*******************************************************************************
No.

*******************************************************************************
### What kernel are you using? Which patches does it includes to enforce Secure Boot?
*******************************************************************************
Suse Linux Enterprise kernel SLES15SP5 5.14.21-150400.53-default, which has the all the required patches to enforce the secure boot.

*******************************************************************************
### Add any additional information you think we may need to validate this shim.
*******************************************************************************
NA
