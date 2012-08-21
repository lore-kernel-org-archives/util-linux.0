Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcbef.dreamhost.com ([208.97.132.145]:58668 "EHLO
	homiemail-a6.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756936Ab2HUMDV (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 21 Aug 2012 08:03:21 -0400
Subject: [PATCH 1/3] fdisk: add guid
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 21 Aug 2012 14:03:14 +0200
Message-ID: <1345550594.2664.5.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Add a GUID structure to the partition types (struct systypes). This is particularly
important to accommodate GPT. For those labels that do not use it, like DOS, SUN and
SGI, just ignore it.

Reviewed-by: Petr Uzel <petr.uzel@suze.cz>
Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisks/cfdisk.c         |    2 +-
 fdisks/common.h         |   16 ++++-
 fdisks/fdiskbsdlabel.h  |   38 +++++-----
 fdisks/fdisksgilabel.c  |   38 +++++-----
 fdisks/fdisksunlabel.c  |   34 ++++----
 fdisks/i386_sys_types.c |  198 +++++++++++++++++++++++-----------------------
 6 files changed, 169 insertions(+), 157 deletions(-)

diff --git a/fdisks/cfdisk.c b/fdisks/cfdisk.c
index 0ceed33..3efa42c 100644
--- a/fdisks/cfdisk.c
+++ b/fdisks/cfdisk.c
@@ -373,7 +373,7 @@ my_basename(char *devname) {
     return s ? s+1 : devname;
 }
 
-static char *
+static const char *
 partition_type_name(unsigned char type) {
     struct systypes *s = i386_sys_types;
 
diff --git a/fdisks/common.h b/fdisks/common.h
index 352b9a5..0e22d8e 100644
--- a/fdisks/common.h
+++ b/fdisks/common.h
@@ -2,10 +2,22 @@
 #define FDISK_COMMON_H
 
 /* common stuff for fdisk, cfdisk, sfdisk */
+#include <inttypes.h>
+
+/* Globally unique identifier */
+struct fdisk_guid {
+	uint32_t   time_low;
+	uint16_t   time_mid;
+	uint16_t   time_hi_and_version;
+	uint8_t    clock_seq_hi;
+	uint8_t    clock_seq_low;
+	uint8_t    node[6];
+};
 
 struct systypes {
-	unsigned char type;
-	char *name;
+	uint16_t          type;
+	struct fdisk_guid guid;
+	const char        *name;
 };
 
 extern struct systypes i386_sys_types[];
diff --git a/fdisks/fdiskbsdlabel.h b/fdisks/fdiskbsdlabel.h
index ab6877e..8cdc6eb 100644
--- a/fdisks/fdiskbsdlabel.h
+++ b/fdisks/fdiskbsdlabel.h
@@ -201,28 +201,28 @@ static char *xbsd_dktypenames[] = {
 
 #ifdef	DKTYPENAMES
 static struct systypes xbsd_fstypes[] = {
-        {BSD_FS_UNUSED, "unused"},
-	{BSD_FS_SWAP,   "swap"},
-	{BSD_FS_V6,     "Version 6"},
-	{BSD_FS_V7,     "Version 7"},
-	{BSD_FS_SYSV,   "System V"},
-	{BSD_FS_V71K,   "4.1BSD"},
-	{BSD_FS_V8,     "Eighth Edition"},
-	{BSD_FS_BSDFFS, "4.2BSD"},
+        {BSD_FS_UNUSED, {0}, N_("unused")},
+	{BSD_FS_SWAP,   {0}, N_("swap")},
+	{BSD_FS_V6,     {0}, N_("Version 6")},
+	{BSD_FS_V7,     {0}, N_("Version 7")},
+	{BSD_FS_SYSV,   {0}, N_("System V")},
+	{BSD_FS_V71K,   {0}, N_("4.1BSD")},
+	{BSD_FS_V8,     {0}, N_("Eighth Edition")},
+	{BSD_FS_BSDFFS, {0}, N_("4.2BSD")},
 #ifdef __alpha__
-	{BSD_FS_EXT2,   "ext2"},
+	{BSD_FS_EXT2,   {0}, N_("ext2")},
 #else
-	{BSD_FS_MSDOS,  "MS-DOS"},
+	{BSD_FS_MSDOS,  {0}, N_("MS-DOS")},
 #endif
-	{BSD_FS_BSDLFS, "4.4LFS"},
-	{BSD_FS_OTHER,  "unknown"},
-	{BSD_FS_HPFS,   "HPFS"},
-	{BSD_FS_ISO9660,"ISO-9660"},
-	{BSD_FS_BOOT,   "boot"},
-	{BSD_FS_ADOS,   "ADOS"},
-	{BSD_FS_HFS,    "HFS"},
-	{BSD_FS_ADVFS,	"AdvFS"},
-	{ 0, NULL }
+	{BSD_FS_BSDLFS, {0}, N_("4.4LFS")},
+	{BSD_FS_OTHER,  {0}, N_("unknown")},
+	{BSD_FS_HPFS,   {0}, N_("HPFS")},
+	{BSD_FS_ISO9660,{0}, N_("ISO-9660")},
+	{BSD_FS_BOOT,   {0}, N_("boot")},
+	{BSD_FS_ADOS,   {0}, N_("ADOS")},
+	{BSD_FS_HFS,    {0}, N_("HFS")},
+	{BSD_FS_ADVFS,	{0}, N_("AdvFS")},
+	{ 0, {0}, NULL }
 };
 #define BSD_FSMAXTYPES (ARRAY_SIZE(xbsd_fstypes)-1)
 
diff --git a/fdisks/fdisksgilabel.c b/fdisks/fdisksgilabel.c
index 7253d21..3e466be 100644
--- a/fdisks/fdisksgilabel.c
+++ b/fdisks/fdisksgilabel.c
@@ -88,25 +88,25 @@ isinfreelist(unsigned int b) {
  * end of free blocks section
  */
 struct systypes sgi_sys_types[] = {
-	{SGI_VOLHDR,	N_("SGI volhdr")},
-	{0x01,		N_("SGI trkrepl")},
-	{0x02,		N_("SGI secrepl")},
-	{SGI_SWAP,	N_("SGI raw")},
-	{0x04,		N_("SGI bsd")},
-	{0x05,		N_("SGI sysv")},
-	{ENTIRE_DISK,	N_("SGI volume")},
-	{SGI_EFS,	N_("SGI efs")},
-	{0x08,		N_("SGI lvol")},
-	{0x09,		N_("SGI rlvol")},
-	{SGI_XFS,	N_("SGI xfs")},
-	{SGI_XFSLOG,	N_("SGI xfslog")},
-	{SGI_XLV,	N_("SGI xlv")},
-	{SGI_XVM,	N_("SGI xvm")},
-	{LINUX_SWAP,	N_("Linux swap")},
-	{LINUX_NATIVE,	N_("Linux native")},
-	{LINUX_LVM,	N_("Linux LVM")},
-	{LINUX_RAID,	N_("Linux RAID")},
-	{0, NULL }
+	{SGI_VOLHDR,	{0}, N_("SGI volhdr")},
+	{0x01,		{0}, N_("SGI trkrepl")},
+	{0x02,		{0}, N_("SGI secrepl")},
+	{SGI_SWAP,	{0}, N_("SGI raw")},
+	{0x04,		{0}, N_("SGI bsd")},
+	{0x05,		{0}, N_("SGI sysv")},
+	{ENTIRE_DISK,	{0}, N_("SGI volume")},
+	{SGI_EFS,	{0}, N_("SGI efs")},
+	{0x08,		{0}, N_("SGI lvol")},
+	{0x09,		{0}, N_("SGI rlvol")},
+	{SGI_XFS,	{0}, N_("SGI xfs")},
+	{SGI_XFSLOG,	{0}, N_("SGI xfslog")},
+	{SGI_XLV,	{0}, N_("SGI xlv")},
+	{SGI_XVM,	{0}, N_("SGI xvm")},
+	{LINUX_SWAP,	{0}, N_("Linux swap")},
+	{LINUX_NATIVE,	{0}, N_("Linux native")},
+	{LINUX_LVM,	{0}, N_("Linux LVM")},
+	{LINUX_RAID,	{0}, N_("Linux RAID")},
+	{0, {0}, NULL }
 };
 
 static int
diff --git a/fdisks/fdisksunlabel.c b/fdisks/fdisksunlabel.c
index 9d17ed2..8246c57 100644
--- a/fdisks/fdisksunlabel.c
+++ b/fdisks/fdisksunlabel.c
@@ -28,23 +28,23 @@
 static int     other_endian = 0;
 
 struct systypes sun_sys_types[] = {
-	{SUN_TAG_UNASSIGNED, N_("Unassigned")},
-	{SUN_TAG_BOOT, N_("Boot")},
-	{SUN_TAG_ROOT, N_("SunOS root")},
-	{SUN_TAG_SWAP, N_("SunOS swap")},
-	{SUN_TAG_USR, N_("SunOS usr")},
-	{SUN_TAG_BACKUP, N_("Whole disk")},
-	{SUN_TAG_STAND, N_("SunOS stand")},
-	{SUN_TAG_VAR, N_("SunOS var")},
-	{SUN_TAG_HOME, N_("SunOS home")},
-	{SUN_TAG_ALTSCTR, N_("SunOS alt sectors")},
-	{SUN_TAG_CACHE, N_("SunOS cachefs")},
-	{SUN_TAG_RESERVED, N_("SunOS reserved")},
-	{SUN_TAG_LINUX_SWAP, N_("Linux swap")},
-	{SUN_TAG_LINUX_NATIVE, N_("Linux native")},
-	{SUN_TAG_LINUX_LVM, N_("Linux LVM")},
-	{SUN_TAG_LINUX_RAID, N_("Linux raid autodetect")},
-	{ 0, NULL }
+	{SUN_TAG_UNASSIGNED,     {0}, N_("Unassigned")},
+	{SUN_TAG_BOOT,           {0}, N_("Boot")},
+	{SUN_TAG_ROOT,           {0}, N_("SunOS root")},
+	{SUN_TAG_SWAP,           {0}, N_("SunOS swap")},
+	{SUN_TAG_USR,            {0}, N_("SunOS usr")},
+	{SUN_TAG_BACKUP,         {0}, N_("Whole disk")},
+	{SUN_TAG_STAND,          {0}, N_("SunOS stand")},
+	{SUN_TAG_VAR,            {0}, N_("SunOS var")},
+	{SUN_TAG_HOME,           {0}, N_("SunOS home")},
+	{SUN_TAG_ALTSCTR,        {0}, N_("SunOS alt sectors")},
+	{SUN_TAG_CACHE,          {0}, N_("SunOS cachefs")},
+	{SUN_TAG_RESERVED,       {0}, N_("SunOS reserved")},
+	{SUN_TAG_LINUX_SWAP,     {0}, N_("Linux swap")},
+	{SUN_TAG_LINUX_NATIVE,   {0}, N_("Linux native")},
+	{SUN_TAG_LINUX_LVM,      {0}, N_("Linux LVM")},
+	{SUN_TAG_LINUX_RAID,     {0}, N_("Linux raid autodetect")},
+	{ 0, {0}, NULL }
 };
 
 static inline unsigned short __swap16(unsigned short x) {
diff --git a/fdisks/i386_sys_types.c b/fdisks/i386_sys_types.c
index 916daf6..c606f1c 100644
--- a/fdisks/i386_sys_types.c
+++ b/fdisks/i386_sys_types.c
@@ -3,108 +3,108 @@
 #include "nls.h"
 
 struct systypes i386_sys_types[] = {
-	{0x00, N_("Empty")},
-	{0x01, N_("FAT12")},
-	{0x02, N_("XENIX root")},
-	{0x03, N_("XENIX usr")},
-	{0x04, N_("FAT16 <32M")},
-	{0x05, N_("Extended")},		/* DOS 3.3+ extended partition */
-	{0x06, N_("FAT16")},		/* DOS 16-bit >=32M */
-	{0x07, N_("HPFS/NTFS/exFAT")},	/* OS/2 IFS, eg, HPFS or NTFS or QNX or exFAT */
-	{0x08, N_("AIX")},		/* AIX boot (AIX -- PS/2 port) or SplitDrive */
-	{0x09, N_("AIX bootable")},	/* AIX data or Coherent */
-	{0x0a, N_("OS/2 Boot Manager")},/* OS/2 Boot Manager */
-	{0x0b, N_("W95 FAT32")},
-	{0x0c, N_("W95 FAT32 (LBA)")},/* LBA really is `Extended Int 13h' */
-	{0x0e, N_("W95 FAT16 (LBA)")},
-	{0x0f, N_("W95 Ext'd (LBA)")},
-	{0x10, N_("OPUS")},
-	{0x11, N_("Hidden FAT12")},
-	{0x12, N_("Compaq diagnostics")},
-	{0x14, N_("Hidden FAT16 <32M")},
-	{0x16, N_("Hidden FAT16")},
-	{0x17, N_("Hidden HPFS/NTFS")},
-	{0x18, N_("AST SmartSleep")},
-	{0x1b, N_("Hidden W95 FAT32")},
-	{0x1c, N_("Hidden W95 FAT32 (LBA)")},
-	{0x1e, N_("Hidden W95 FAT16 (LBA)")},
-	{0x24, N_("NEC DOS")},
-	{0x27, N_("Hidden NTFS WinRE")},
-	{0x39, N_("Plan 9")},
-	{0x3c, N_("PartitionMagic recovery")},
-	{0x40, N_("Venix 80286")},
-	{0x41, N_("PPC PReP Boot")},
-	{0x42, N_("SFS")},
-	{0x4d, N_("QNX4.x")},
-	{0x4e, N_("QNX4.x 2nd part")},
-	{0x4f, N_("QNX4.x 3rd part")},
-	{0x50, N_("OnTrack DM")},
-	{0x51, N_("OnTrack DM6 Aux1")},	/* (or Novell) */
-	{0x52, N_("CP/M")},		/* CP/M or Microport SysV/AT */
-	{0x53, N_("OnTrack DM6 Aux3")},
-	{0x54, N_("OnTrackDM6")},
-	{0x55, N_("EZ-Drive")},
-	{0x56, N_("Golden Bow")},
-	{0x5c, N_("Priam Edisk")},
-	{0x61, N_("SpeedStor")},
-	{0x63, N_("GNU HURD or SysV")},	/* GNU HURD or Mach or Sys V/386 (such as ISC UNIX) */
-	{0x64, N_("Novell Netware 286")},
-	{0x65, N_("Novell Netware 386")},
-	{0x70, N_("DiskSecure Multi-Boot")},
-	{0x75, N_("PC/IX")},
-	{0x80, N_("Old Minix")},	/* Minix 1.4a and earlier */
-	{0x81, N_("Minix / old Linux")},/* Minix 1.4b and later */
-	{0x82, N_("Linux swap / Solaris")},
-	{0x83, N_("Linux")},
-	{0x84, N_("OS/2 hidden C: drive")},
-	{0x85, N_("Linux extended")},
-	{0x86, N_("NTFS volume set")},
-	{0x87, N_("NTFS volume set")},
-	{0x88, N_("Linux plaintext")},
-	{0x8e, N_("Linux LVM")},
-	{0x93, N_("Amoeba")},
-	{0x94, N_("Amoeba BBT")},	/* (bad block table) */
-	{0x9f, N_("BSD/OS")},		/* BSDI */
-	{0xa0, N_("IBM Thinkpad hibernation")},
-	{0xa5, N_("FreeBSD")},		/* various BSD flavours */
-	{0xa6, N_("OpenBSD")},
-	{0xa7, N_("NeXTSTEP")},
-	{0xa8, N_("Darwin UFS")},
-	{0xa9, N_("NetBSD")},
-	{0xab, N_("Darwin boot")},
-	{0xaf, N_("HFS / HFS+")},
-	{0xb7, N_("BSDI fs")},
-	{0xb8, N_("BSDI swap")},
-	{0xbb, N_("Boot Wizard hidden")},
-	{0xbe, N_("Solaris boot")},
-	{0xbf, N_("Solaris")},
-	{0xc1, N_("DRDOS/sec (FAT-12)")},
-	{0xc4, N_("DRDOS/sec (FAT-16 < 32M)")},
-	{0xc6, N_("DRDOS/sec (FAT-16)")},
-	{0xc7, N_("Syrinx")},
-	{0xda, N_("Non-FS data")},
-	{0xdb, N_("CP/M / CTOS / ...")},/* CP/M or Concurrent CP/M or
+	{0x00, {0}, N_("Empty")},
+	{0x01, {0}, N_("FAT12")},
+	{0x02, {0}, N_("XENIX root")},
+	{0x03, {0}, N_("XENIX usr")},
+	{0x04, {0}, N_("FAT16 <32M")},
+	{0x05, {0}, N_("Extended")},		/* DOS 3.3+ extended partition */
+	{0x06, {0}, N_("FAT16")},		/* DOS 16-bit >=32M */
+	{0x07, {0}, N_("HPFS/NTFS/exFAT")},	/* OS/2 IFS, eg, HPFS or NTFS or QNX or exFAT */
+	{0x08, {0}, N_("AIX")},		/* AIX boot (AIX -- PS/2 port) or SplitDrive */
+	{0x09, {0}, N_("AIX bootable")},	/* AIX data or Coherent */
+	{0x0a, {0}, N_("OS/2 Boot Manager")},/* OS/2 Boot Manager */
+	{0x0b, {0}, N_("W95 FAT32")},
+	{0x0c, {0}, N_("W95 FAT32 (LBA)")},/* LBA really is `Extended Int 13h' */
+	{0x0e, {0}, N_("W95 FAT16 (LBA)")},
+	{0x0f, {0}, N_("W95 Ext'd (LBA)")},
+	{0x10, {0}, N_("OPUS")},
+	{0x11, {0}, N_("Hidden FAT12")},
+	{0x12, {0}, N_("Compaq diagnostics")},
+	{0x14, {0}, N_("Hidden FAT16 <32M")},
+	{0x16, {0}, N_("Hidden FAT16")},
+	{0x17, {0}, N_("Hidden HPFS/NTFS")},
+	{0x18, {0}, N_("AST SmartSleep")},
+	{0x1b, {0}, N_("Hidden W95 FAT32")},
+	{0x1c, {0}, N_("Hidden W95 FAT32 (LBA)")},
+	{0x1e, {0}, N_("Hidden W95 FAT16 (LBA)")},
+	{0x24, {0}, N_("NEC DOS")},
+	{0x27, {0}, N_("Hidden NTFS WinRE")},
+	{0x39, {0}, N_("Plan 9")},
+	{0x3c, {0}, N_("PartitionMagic recovery")},
+	{0x40, {0}, N_("Venix 80286")},
+	{0x41, {0}, N_("PPC PReP Boot")},
+	{0x42, {0}, N_("SFS")},
+	{0x4d, {0}, N_("QNX4.x")},
+	{0x4e, {0}, N_("QNX4.x 2nd part")},
+	{0x4f, {0}, N_("QNX4.x 3rd part")},
+	{0x50, {0}, N_("OnTrack DM")},
+	{0x51, {0}, N_("OnTrack DM6 Aux1")},	/* (or Novell) */
+	{0x52, {0}, N_("CP/M")},		/* CP/M or Microport SysV/AT */
+	{0x53, {0}, N_("OnTrack DM6 Aux3")},
+	{0x54, {0}, N_("OnTrackDM6")},
+	{0x55, {0}, N_("EZ-Drive")},
+	{0x56, {0}, N_("Golden Bow")},
+	{0x5c, {0}, N_("Priam Edisk")},
+	{0x61, {0}, N_("SpeedStor")},
+	{0x63, {0}, N_("GNU HURD or SysV")},	/* GNU HURD or Mach or Sys V/386 (such as ISC UNIX) */
+	{0x64, {0}, N_("Novell Netware 286")},
+	{0x65, {0}, N_("Novell Netware 386")},
+	{0x70, {0}, N_("DiskSecure Multi-Boot")},
+	{0x75, {0}, N_("PC/IX")},
+	{0x80, {0}, N_("Old Minix")},	/* Minix 1.4a and earlier */
+	{0x81, {0}, N_("Minix / old Linux")},/* Minix 1.4b and later */
+	{0x82, {0}, N_("Linux swap / Solaris")},
+	{0x83, {0}, N_("Linux")},
+	{0x84, {0}, N_("OS/2 hidden C: drive")},
+	{0x85, {0}, N_("Linux extended")},
+	{0x86, {0}, N_("NTFS volume set")},
+	{0x87, {0}, N_("NTFS volume set")},
+	{0x88, {0}, N_("Linux plaintext")},
+	{0x8e, {0}, N_("Linux LVM")},
+	{0x93, {0}, N_("Amoeba")},
+	{0x94, {0}, N_("Amoeba BBT")},	/* (bad block table) */
+	{0x9f, {0}, N_("BSD/OS")},		/* BSDI */
+	{0xa0, {0}, N_("IBM Thinkpad hibernation")},
+	{0xa5, {0}, N_("FreeBSD")},		/* various BSD flavours */
+	{0xa6, {0}, N_("OpenBSD")},
+	{0xa7, {0}, N_("NeXTSTEP")},
+	{0xa8, {0}, N_("Darwin UFS")},
+	{0xa9, {0}, N_("NetBSD")},
+	{0xab, {0}, N_("Darwin boot")},
+	{0xaf, {0}, N_("HFS / HFS+")},
+	{0xb7, {0}, N_("BSDI fs")},
+	{0xb8, {0}, N_("BSDI swap")},
+	{0xbb, {0}, N_("Boot Wizard hidden")},
+	{0xbe, {0}, N_("Solaris boot")},
+	{0xbf, {0}, N_("Solaris")},
+	{0xc1, {0}, N_("DRDOS/sec (FAT-12)")},
+	{0xc4, {0}, N_("DRDOS/sec (FAT-16 < 32M)")},
+	{0xc6, {0}, N_("DRDOS/sec (FAT-16)")},
+	{0xc7, {0}, N_("Syrinx")},
+	{0xda, {0}, N_("Non-FS data")},
+	{0xdb, {0}, N_("CP/M / CTOS / ...")},/* CP/M or Concurrent CP/M or
 					   Concurrent DOS or CTOS */
-	{0xde, N_("Dell Utility")},	/* Dell PowerEdge Server utilities */
-	{0xdf, N_("BootIt")},		/* BootIt EMBRM */
-	{0xe1, N_("DOS access")},	/* DOS access or SpeedStor 12-bit FAT
+	{0xde, {0}, N_("Dell Utility")},	/* Dell PowerEdge Server utilities */
+	{0xdf, {0}, N_("BootIt")},		/* BootIt EMBRM */
+	{0xe1, {0}, N_("DOS access")},	/* DOS access or SpeedStor 12-bit FAT
 					   extended partition */
-	{0xe3, N_("DOS R/O")},		/* DOS R/O or SpeedStor */
-	{0xe4, N_("SpeedStor")},	/* SpeedStor 16-bit FAT extended
+	{0xe3, {0}, N_("DOS R/O")},		/* DOS R/O or SpeedStor */
+	{0xe4, {0}, N_("SpeedStor")},	/* SpeedStor 16-bit FAT extended
 					   partition < 1024 cyl. */
-	{0xeb, N_("BeOS fs")},
-	{0xee, N_("GPT")},		/* Intel EFI GUID Partition Table */
-	{0xef, N_("EFI (FAT-12/16/32)")},/* Intel EFI System Partition */
-	{0xf0, N_("Linux/PA-RISC boot")},/* Linux/PA-RISC boot loader */
-	{0xf1, N_("SpeedStor")},
-	{0xf4, N_("SpeedStor")},	/* SpeedStor large partition */
-	{0xf2, N_("DOS secondary")},	/* DOS 3.3+ secondary */
-	{0xfb, N_("VMware VMFS")},
-	{0xfc, N_("VMware VMKCORE")},	/* VMware kernel dump partition */
-	{0xfd, N_("Linux raid autodetect")},/* New (2.2.x) raid partition with
+	{0xeb, {0}, N_("BeOS fs")},
+	{0xee, {0}, N_("GPT")},		/* Intel EFI GUID Partition Table */
+	{0xef, {0}, N_("EFI (FAT-12/16/32)")},/* Intel EFI System Partition */
+	{0xf0, {0}, N_("Linux/PA-RISC boot")},/* Linux/PA-RISC boot loader */
+	{0xf1, {0}, N_("SpeedStor")},
+	{0xf4, {0}, N_("SpeedStor")},	/* SpeedStor large partition */
+	{0xf2, {0}, N_("DOS secondary")},	/* DOS 3.3+ secondary */
+	{0xfb, {0}, N_("VMware VMFS")},
+	{0xfc, {0}, N_("VMware VMKCORE")},	/* VMware kernel dump partition */
+	{0xfd, {0}, N_("Linux raid autodetect")},/* New (2.2.x) raid partition with
 					       autodetect using persistent
 					       superblock */
-	{0xfe, N_("LANstep")},		/* SpeedStor >1024 cyl. or LANstep */
-	{0xff, N_("BBT")},		/* Xenix Bad Block Table */
-	{ 0, 0 }
+	{0xfe, {0}, N_("LANstep")},		/* SpeedStor >1024 cyl. or LANstep */
+	{0xff, {0}, N_("BBT")},		/* Xenix Bad Block Table */
+	{ 0, {0}, 0 }
 };
-- 
1.7.4.1




