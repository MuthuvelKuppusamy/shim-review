This repo is for review of requests for signing shim.  To create a request for review:

- clone this repo
- edit the template below
- add the shim.efi to be signed
- add build logs
- add any additional binaries/certificates/SHA256 hashes that may be needed
- commit all of that
- tag it with a tag of the form "myorg-shim-arch-YYYYMMDD"
- push that to github
- file an issue at https://github.com/rhboot/shim-review/issues with a link to your branch
- approval is ready when you have accepted tag

Note that we really only have experience with using GRUB2 on Linux, so asking
us to endorse anything else for signing is going to require some convincing on
your part.

Here's the template:

-------------------------------------------------------------------------------
What organization or people are asking to have this signed:
-------------------------------------------------------------------------------
Micro Focus

-------------------------------------------------------------------------------
What product or service is this for:
-------------------------------------------------------------------------------
ZENworks - Unified Endpoint Management solution - (Imaging)

-------------------------------------------------------------------------------
What's the justification that this really does need to be signed for the whole world to be able to boot it:
-------------------------------------------------------------------------------
We support software tools for Operating Systems Backup/Restore/Deployment for Windows and Linux. This tool is used on millions of end-point devices to manage day-to-day IT activities.
Minimal Suse Linux Enterprise(SLE) distro (or) Windows Preboot Environment(WinPE) distro used to secure-boot the device in USB/CD/PXE mode.

-------------------------------------------------------------------------------
Who is the primary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Muthuvel K
- Position: Principal Engineer
- Email address: muthuvel.kuppusamy@microfocus.com
- PGP key, signed by the other security contacts, and preferably also with signatures that are reasonably well known in the Linux community:

-------------------------------------------------------------------------------
Who is the secondary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Anand Navale
- Position: Product Architect
- Email address: Anand.Navale@microfocus.com
- PGP key, signed by the other security contacts, and preferably also with signatures that are reasonably well known in the Linux community:

-------------------------------------------------------------------------------
Please create your shim binaries starting with the 15.4 shim release tar file:
https://github.com/rhboot/shim/releases/download/15.4/shim-15.4.tar.bz2

This matches https://github.com/rhboot/shim/releases/tag/15.4 and contains
the appropriate gnu-efi source.
-------------------------------------------------------------------------------
Yes, Used the https://github.com/rhboot/shim/releases/download/15.4/shim-15.4.tar.bz2 
and 
Critical patches:
        0001-mok-allocate-MOK-config-table-as-BootServicesData.patch
        0001-Fix-handling-of-ignore_db-and-user_insecure_mode.patch
        0001-Fix-a-broken-file-header-on-ia32.patch
        0001-Dont-call-QueryVariableInfo-on-EFI-1.10-machines.patch
Custom patch for,
         precedence for ProxyOfferReceived in IPv4/6

-------------------------------------------------------------------------------
URL for a repo that contains the exact code which was built to get this binary:
-------------------------------------------------------------------------------
https://github.com/MuthuvelKuppusamy/shim.git  branch microfocus-shim154-new

-------------------------------------------------------------------------------
What patches are being applied and why:
-------------------------------------------------------------------------------
Code added to prefer proxyDhcpOfferReceived over dhcpAck in case IPv4/6

-------------------------------------------------------------------------------
If bootloader, shim loading is, GRUB2: is CVE-2020-14372, CVE-2020-25632,
 CVE-2020-25647, CVE-2020-27749, CVE-2020-27779, CVE-2021-20225, CVE-2021-20233,
 CVE-2020-10713, CVE-2020-14308, CVE-2020-14309, CVE-2020-14310, CVE-2020-14311,
 CVE-2020-15705, and if you are shipping the shim_lock module CVE-2021-3418
-------------------------------------------------------------------------------
Using grub2.04 with all the applicable patches from suse,which includes all these fixes.


-------------------------------------------------------------------------------
What exact implementation of Secureboot in GRUB2 ( if this is your bootloader ) you have ?
* Upstream GRUB2 shim_lock verifier or * Downstream RHEL/Fedora/Debian/Canonical like implementation ?
-------------------------------------------------------------------------------
Downstream RHEL/Fedora/Debian/Canonical like implementation

-------------------------------------------------------------------------------
If bootloader, shim loading is, GRUB2, and previous shims were trusting affected
by CVE-2020-14372, CVE-2020-25632, CVE-2020-25647, CVE-2020-27749,
  CVE-2020-27779, CVE-2021-20225, CVE-2021-20233, CVE-2020-10713,
  CVE-2020-14308, CVE-2020-14309, CVE-2020-14310, CVE-2020-14311, CVE-2020-15705,
  and if you were shipping the shim_lock module CVE-2021-3418
  ( July 2020 grub2 CVE list + March 2021 grub2 CVE list )
  grub2:
* were old shims hashes provided to Microsoft for verification
  and to be added to future DBX update ?
* Does your new chain of trust disallow booting old, affected by CVE-2020-14372,
  CVE-2020-25632, CVE-2020-25647, CVE-2020-27749,
  CVE-2020-27779, CVE-2021-20225, CVE-2021-20233, CVE-2020-10713,
  CVE-2020-14308, CVE-2020-14309, CVE-2020-14310, CVE-2020-14311, CVE-2020-15705,
  and if you were shipping the shim_lock module CVE-2021-3418
  ( July 2020 grub2 CVE list + March 2021 grub2 CVE list )
  grub2 builds ?
-------------------------------------------------------------------------------
We switched to new certificate now for shim15.4 signing, which blocks all the older signed grub2 binaries.

-------------------------------------------------------------------------------
If your boot chain of trust includes linux kernel, is
"efi: Restrict efivar_ssdt_load when the kernel is locked down"
upstream commit 1957a85b0032a81e6482ca4aab883643b8dae06e applied ?
Is "ACPI: configfs: Disallow loading ACPI tables when locked down"
upstream commit 75b0cea7bf307f362057cc778efe89af4c615354 applied ?
-------------------------------------------------------------------------------
We will use SuSE Linux Enterprise Server kernel(SLES15SP3),which has all the fixes.

-------------------------------------------------------------------------------
If you use vendor_db functionality of providing multiple certificates and/or
hashes please briefly describe your certificate setup. If there are allow-listed hashes
please provide exact binaries for which hashes are created via file sharing service,
available in public with anonymous access for verification
-------------------------------------------------------------------------------
No.

-------------------------------------------------------------------------------
If you are re-using a previously used (CA) certificate, you will need
to add the hashes of the previous GRUB2 binaries to vendor_dbx in shim
in order to prevent GRUB2 from being able to chainload those older GRUB2
binaries. If you are changing to a new (CA) certificate, this does not
apply. Please describe your strategy.
-------------------------------------------------------------------------------
We switched to new certificate now for shim15.4 signing. 

-------------------------------------------------------------------------------
What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as close as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
If the shim binaries can't be reproduced using the provided Dockerfile, please explain why that's the case and the differences would be.
-------------------------------------------------------------------------------
Dockerfile with this repo used to build the shimx64.efi and shimia32.efi.

-------------------------------------------------------------------------------
Which files in this repo are the logs for your build?   This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
-------------------------------------------------------------------------------
build.log file has comeplete build information for shimx64.efi,shimia32.efi build and sha256sum validation at the end for submitted and built binaries.

-------------------------------------------------------------------------------
Add any additional information you think we may need to validate this shim
-------------------------------------------------------------------------------
sha256sum:
69934ecab81e77a24282fee2810dc904d2b1ee42366f3fd5e127ab3e5b6f394b  shimia32.efi
57e9dd10206ad704516349813cc223cd8b2e6910e86b6d196ccd3e27b1763a86  shimx64.efi

shimia32.efi hash: ecaee8b2de1c6dc1d9ef0aab74b75b13a913caa32cb06488b314be3270512e9f
shimx64.efi  hash: 41cb299fe8b93f188a8bf53fdbf0aa2d2742b31421f951e4ad41232ebc319394

