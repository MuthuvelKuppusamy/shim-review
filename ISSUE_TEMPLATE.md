Make sure you have provided the following information:

 - [X] link to your code branch cloned from rhboot/shim-review in the form user/repo@tag
 - [X] completed README.md file with the necessary information
 - [X] shim.efi to be signed
 - [X] public portion of your certificate(s) embedded in shim (the file passed to VENDOR_CERT_FILE)
 - [ ] binaries, for which hashes are added do vendor_db ( if you use vendor_db and have hashes allow-listed )
 - [ ] any extra patches to shim via your own git tree or as files
 - [ ] any extra patches to grub via your own git tree or as files
 - [X] build logs
 - [X] a Dockerfile to reproduce the build of the provided shim EFI binaries


###### What organization or people are asking to have this signed:
Micro Focus

###### What product or service is this for:
ZENworks - Unified Endpoint Management Solution (Imaging)

###### Please create your shim binaries starting with the 15.4 shim release tar file:
###### https://github.com/rhboot/shim/releases/download/15.4/shim-15.4.tar.bz2
###### This matches https://github.com/rhboot/shim/releases/tag/15.4 and contains
###### the appropriate gnu-efi source.
###### Please confirm this as the origin your shim.
Yes, Used https://github.com/rhboot/shim/releases/download/15.4/shim-15.4.tar.bz2
And added
Critical patches:
	0001-mok-allocate-MOK-config-table-as-BootServicesData.patch
	0001-Fix-handling-of-ignore_db-and-user_insecure_mode.patch
	0001-Fix-a-broken-file-header-on-ia32.patch
	0001-Dont-call-QueryVariableInfo-on-EFI-1.10-machines.patch
Custom patch for,
	 precedence for ProxyOfferReceived in IPv4/6

###### What's the justification that this really does need to be signed for the whole world to be able to boot it:
We support software tools for OS Backup/Restore/Deployment for Windows and Linux.This tool is used on millions of end-point devices to manage day-to-day IT activities.
Minimal Suse Linux Enterprise(SLE) distro (or) Windows Preboot Environment(WinPE) distro used to secure-boot the device in USB/CD/PXE mode.

###### How do you manage and protect the keys used in your SHIM?
Keys are stored in HSM with restricted  access.

###### Do you use EV certificates as embedded certificates in the SHIM?
No.

###### If you use new vendor_db functionality, are any hashes allow-listed, and if yes: for what binaries ?
No.

###### Is kernel upstream commit 75b0cea7bf307f362057cc778efe89af4c615354 present in your kernel, if you boot chain includes a Linux kernel ?
Yes, latest Suse Linux Enterprise Server kernel ( SLES15SP3 ) has this fix.

###### if SHIM is loading GRUB2 bootloader, are CVEs CVE-2020-14372,
###### CVE-2020-25632, CVE-2020-25647, CVE-2020-27749, CVE-2020-27779,
###### CVE-2021-20225, CVE-2021-20233, CVE-2020-10713, CVE-2020-14308,
###### CVE-2020-14309, CVE-2020-14310, CVE-2020-14311, CVE-2020-15705,
###### ( July 2020 grub2 CVE list + March 2021 grub2 CVE list )
###### and if you are shipping the shim_lock module CVE-2021-3418
###### fixed ?
Yes, using grub2.04+patches from suse build,which has this all patches included.

###### "Please specifically confirm that you add a vendor specific SBAT entry for SBAT header in each binary that supports SBAT metadata
###### ( grub2, fwupd, fwupdate, shim + all child shim binaries )" to shim review doc ?
###### Please provide exact SBAT entries for all SBAT binaries you are booting or planning to boot directly through shim
For shim:

sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
shim,1,UEFI shim,shim,1,https://github.com/rhboot/shim
shim.MFZENworks,1,MicroFocus,shim,15.4-0-ZENworks1,https://www.microfocus.com/

For grub:

sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
grub,1,Free Software Foundation,grub,2.04,https://www.gnu.org/software/grub/
grub.sle,1,SUSE Linux Enterprise,grub2,2.04,mail:security-team@suse.de
grub.MFZENworks,1,MicroFocus,grub2,2.04-0-ZENworks1,https://www.microfocus.com/

##### Were your old SHIM hashes provided to Microsoft ?
Yes.

##### Did you change your certificate strategy, so that affected by CVE-2020-14372, CVE-2020-25632, CVE-2020-25647, CVE-2020-27749,
##### CVE-2020-27779, CVE-2021-20225, CVE-2021-20233, CVE-2020-10713,
##### CVE-2020-14308, CVE-2020-14309, CVE-2020-14310, CVE-2020-14311, CVE-2020-15705 ( July 2020 grub2 CVE list + March 2021 grub2 CVE list )
##### grub2 bootloaders can not be verified ?
We switched to new certificate now for shim15.4 signing, which blocks all the older signed grub2 binaries.

##### What exact implementation of Secureboot in grub2 ( if this is your bootloader ) you have ?
##### * Upstream grub2 shim_lock verifier or * Downstream RHEL/Fedora/Debian/Canonical like implementation ?
Downstream RHEL/Fedora/Debian/Canonical like implementation

###### What is the origin and full version number of your bootloader (GRUB or other)?
grub2.04 and all the applicable patches from suse, which includes ( July 2020 grub2 CVE list + Marh 2021 grub2 CVE list)

###### If your SHIM launches any other components, please provide further details on what is launched
In case of PXE boot, we launch our custom efi binary, which talks to our server and get the work details and loads the Suse-Linux or WinPE based on the work type.

###### If your GRUB2 launches any other binaries that are not Linux kernel in SecureBoot mode,
###### please provide further details on what is launched and how it enforces Secureboot lockdown
No.

###### If you are re-using a previously used (CA) certificate, you
###### will need to add the hashes of the previous GRUB2 binaries
###### exposed to the CVEs to vendor_dbx in shim in order to prevent
###### GRUB2 from being able to chainload those older GRUB2 binaries. If
###### you are changing to a new (CA) certificate, this does not
###### apply. Please describe your strategy.
We switched to new certificate now for shim15.4 signing, which blocks all the older signed grub2 binaries.

###### How do the launched components prevent execution of unauthenticated code?
Used shim_lock to validate the chain loaded binaries.

###### Does your SHIM load any loaders that support loading unsigned kernels (e.g. GRUB)?
No.

###### What kernel are you using? Which patches does it includes to enforce Secure Boot?
Suse Linux Enterprise kernel SLES15SP3, which has the all the required patches to enforce the secure boot.


###### What changes were made since your SHIM was last signed?
Added precedence for proxyDhcpOfferRecieved patch for IPv6.

###### What is the SHA256 hash of your final SHIM binary?
shimx64.efi  hash : 41cb299fe8b93f188a8bf53fdbf0aa2d2742b31421f951e4ad41232ebc319394
shimia32.efi hash : ecaee8b2de1c6dc1d9ef0aab74b75b13a913caa32cb06488b314be3270512e9f
