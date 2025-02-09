Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D2B6FBF
	for <util-linux@vger.kernel.org>; Sun,  9 Feb 2025 08:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739089474; cv=none; b=JSV9do6oohf+Ydzm0sX6pmZtAtIk17GIJaIeJWJ3qaATWjMDO5W2jkTWE7H1I2T0IRR3twEfI4a6Zk+guSXdAR/NmUD1NVjUV7AzluXyhYbunIy7L5MsWcUYjx3Hx5ghsZ/hKyqIwMKE/65+2Zq46R1hV6qqMXVi3myloXJq1E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739089474; c=relaxed/simple;
	bh=okbJb4u+QfgPvf0U1/5m95BT2oJ1/fOAz2uVkAPcZQ0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eb2TgfGIoquH4kykOP5HMMyO2AOgPwLgJqNL07e+cnakTCtM/lxwkzed+7OMEu1RUCrdytnmrxLbeFzb7poFhFG5LjtSiHimTDNg9LUMJVMOMmMKrrB6jFXFWpq404ydPMFW8bBMqa4Rj0ApblSqsmUkVGkxxP4d9ulVJDAMgGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=xXPMDoNU; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="xXPMDoNU"
X-KPN-MessageId: 88c78042-e6bf-11ef-aff5-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 88c78042-e6bf-11ef-aff5-005056abad63;
	Sun, 09 Feb 2025 09:26:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=N29Vve9FR3xvIJ2gAWPyqi4XNbVComKzKYbDwqhjvGU=;
	b=xXPMDoNUXFqenYYqC4d2b++2LpfBHqVGntAIzTHU0Ov0MWo213/26WtbUl3zkGpaz68P9QU+PxjI0
	 5SizooB8eUVOpbq6+eIg6nul3SMcaukFi+PBmVHtp3zNrFxb+tHj++oDKQeF1tmQAmDOo2KQIV/qEO
	 BH0mXHbxjpS7a0+0=
X-KPN-MID: 33|sO5WNjAKPWBuXltQ80+dqEd419kjpwbGkIWT9r0eVBTzbKno3CFlxaqDNY/sZfh
 HWEEBbFWEMvtdWQB2TILOfNomy3iltjil2F2a2wDNWRw=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|eoeGStph1XC7TWLu8kpsrsha9KM//gtX8AygU/E2wtPd3Ms5ffc/Vibcnj8LnZt
 sAhuZ3wwucBU8xgn687AEjQ==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 47e6e861-e6bf-11ef-a31b-005056abf0db;
	Sun, 09 Feb 2025 09:24:29 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 05/14] textual: consistently mark "=" as literal before an optional argument
Date: Sun,  9 Feb 2025 09:23:21 +0100
Message-ID: <20250209082330.4235-5-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250209082330.4235-1-bensberg@telfort.nl>
References: <20250209082330.4235-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

See, for example, how in `man cfdisk` the "=" after --color and after
--lock were differently marked.

(Basically done with `sed -i 's/\*\[=/\*\[\*\*=\*\*/' *utils/*.adoc`.)

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 disk-utils/cfdisk.8.adoc      |  2 +-
 disk-utils/fdisk.8.adoc       |  8 ++++----
 disk-utils/fsck.cramfs.8.adoc |  2 +-
 disk-utils/mkfs.bfs.8.adoc    |  2 +-
 disk-utils/mkfs.cramfs.8.adoc |  2 +-
 disk-utils/mkfs.minix.8.adoc  |  2 +-
 disk-utils/mkswap.8.adoc      |  2 +-
 disk-utils/sfdisk.8.adoc      |  2 +-
 login-utils/lslogins.1.adoc   |  2 +-
 misc-utils/cal.1.adoc         |  4 ++--
 misc-utils/enosys.1.adoc      |  2 +-
 misc-utils/findmnt.8.adoc     |  2 +-
 misc-utils/hardlink.1.adoc    |  2 +-
 misc-utils/lsblk.8.adoc       |  2 +-
 misc-utils/uuidd.8.adoc       |  2 +-
 misc-utils/wipefs.8.adoc      |  4 ++--
 sys-utils/dmesg.1.adoc        |  2 +-
 sys-utils/lscpu.1.adoc        |  8 ++++----
 sys-utils/lsmem.1.adoc        |  2 +-
 sys-utils/mount.8.adoc        |  4 ++--
 sys-utils/nsenter.1.adoc      | 22 ++++++++++-----------
 sys-utils/prlimit.1.adoc      | 36 +++++++++++++++++------------------
 term-utils/agetty.8.adoc      |  2 +-
 term-utils/script.1.adoc      |  2 +-
 term-utils/setterm.1.adoc     | 18 +++++++++---------
 text-utils/hexdump.1.adoc     |  2 +-
 26 files changed, 70 insertions(+), 70 deletions(-)

diff --git a/disk-utils/cfdisk.8.adoc b/disk-utils/cfdisk.8.adoc
index 759f39f0e..5ab560a4a 100644
--- a/disk-utils/cfdisk.8.adoc
+++ b/disk-utils/cfdisk.8.adoc
@@ -49,7 +49,7 @@ include::man-common/help-version.adoc[]
 *-L*, *--color*[**=**__when__]::
 Colorize the output. The optional argument _when_ can be *auto*, *never* or *always*. If the _when_ argument is omitted, it defaults to *auto*. The colors can be disabled, for the current built-in default see *--help* output. See also the *COLORS* section.
 
-*--lock*[=_mode_]::
+*--lock*[**=**_mode_]::
 Use exclusive BSD lock for device or file it operates. The optional argument _mode_ can be *yes*, *no* (or 1 and 0) or *nonblock*. If the _mode_ argument is omitted, it defaults to *yes*. This option overwrites environment variable *$LOCK_BLOCK_DEVICE*. The default is not to use any lock at all, but it's recommended to avoid collisions with *systemd-udevd*(8) or other tools.
 
 *-r*, *--read-only*::
diff --git a/disk-utils/fdisk.8.adoc b/disk-utils/fdisk.8.adoc
index 5941aa349..6c59aa1a4 100644
--- a/disk-utils/fdisk.8.adoc
+++ b/disk-utils/fdisk.8.adoc
@@ -45,12 +45,12 @@ Specify the sector size of the disk. Valid values are 512, 1024, 2048, and 4096.
 *-B*, *--protect-boot*::
 Don't erase the beginning of the first disk sector when creating a new disk label. This feature is supported for GPT and MBR.
 
-*-c*, *--compatibility*[=_mode_]::
+*-c*, *--compatibility*[**=**_mode_]::
 Specify the compatibility mode, 'dos' or 'nondos'. The default is non-DOS mode. For backward compatibility, it is possible to use the option without the _mode_ argument -- then the default is used. Note that the optional _mode_ argument cannot be separated from the *-c* option by a space, the correct form is for example *-c*=_dos_.
 
 include::man-common/help-version.adoc[]
 
-*-L*, *--color*[=_when_]::
+*-L*, *--color*[**=**_when_]::
 Colorize the output. The optional argument _when_ can be *auto*, *never* or *always*. If the _when_ argument is omitted, it defaults to *auto*. The colors can be disabled; for the current built-in default see the *--help* output. See also the *COLORS* section.
 
 *-l*, *--list*::
@@ -61,7 +61,7 @@ If no devices are given, the devices mentioned in _/proc/partitions_ (if this fi
 *-x*, *--list-details*::
 Like *--list*, but provides more details.
 
-*--lock*[=_mode_]::
+*--lock*[**=**_mode_]::
 Use exclusive BSD lock for device or file it operates. The optional argument _mode_ can be *yes*, *no* (or 1 and 0) or *nonblock*. If the _mode_ argument is omitted, it defaults to *yes*. This option overwrites environment variable *$LOCK_BLOCK_DEVICE*. The default is not to use any lock at all, but it's recommended to avoid collisions with *systemd-udevd*(8) or other tools.
 
 *-n*, *--noauto-pt*::
@@ -79,7 +79,7 @@ Print the size in 512-byte sectors of each given block device. This option is DE
 *-t*, *--type* _type_::
 Enable support only for disklabels of the specified _type_, and disable support for all other types.
 
-*-u*, *--units*[=_unit_]::
+*-u*, *--units*[**=**_unit_]::
 When listing partition tables, show sizes in 'sectors' or in 'cylinders'. The default is to show sizes in sectors. For backward compatibility, it is possible to use the option without the _unit_ argument -- then the default is used. Note that the optional _unit_ argument cannot be separated from the *-u* option by a space, the correct form is for example '**-u=**__cylinders__'.
 
 *-C*, *--cylinders* _number_::
diff --git a/disk-utils/fsck.cramfs.8.adoc b/disk-utils/fsck.cramfs.8.adoc
index ec7526259..59681fe18 100644
--- a/disk-utils/fsck.cramfs.8.adoc
+++ b/disk-utils/fsck.cramfs.8.adoc
@@ -26,7 +26,7 @@ Enable verbose messaging.
 *-b*, *--blocksize* _blocksize_::
 Use this blocksize, defaults to page size. Must be equal to what was set at creation time. Only used for *--extract*.
 
-*--extract*[=_directory_]::
+*--extract*[**=**_directory_]::
 Test to uncompress the whole file system. Optionally extract contents of the _file_ to _directory_.
 
 *-a*::
diff --git a/disk-utils/mkfs.bfs.8.adoc b/disk-utils/mkfs.bfs.8.adoc
index 198d61f5e..248013731 100644
--- a/disk-utils/mkfs.bfs.8.adoc
+++ b/disk-utils/mkfs.bfs.8.adoc
@@ -35,7 +35,7 @@ Specify the volume _label_. I have no idea if/where this is used.
 *-F*, *--fname* _name_::
 Specify the filesystem _name_. I have no idea if/where this is used.
 
-*--lock*[=_mode_]::
+*--lock*[**=**_mode_]::
 Use exclusive BSD lock for device or file it operates. The optional argument _mode_ can be *yes*, *no* (or 1 and 0) or *nonblock*. If the _mode_ argument is omitted, it defaults to *yes*. This option overwrites environment variable *$LOCK_BLOCK_DEVICE*. The default is not to use any lock at all, but it's recommended to avoid collisions with *systemd-udevd*(8) or other tools.
 
 *-v*, *--verbose*::
diff --git a/disk-utils/mkfs.cramfs.8.adoc b/disk-utils/mkfs.cramfs.8.adoc
index c5ffa2073..56e5065b9 100644
--- a/disk-utils/mkfs.cramfs.8.adoc
+++ b/disk-utils/mkfs.cramfs.8.adoc
@@ -62,7 +62,7 @@ This option is ignored. Originally the *-s* turned on directory entry sorting.
 *-z*::
 Make explicit holes.
 
-*-l*[=_mode_]::
+*-l*[**=**_mode_]::
  Use exclusive BSD lock for device or file it operates.  The optional argument
  _mode_ can be _yes_, _no_ (or 1 and 0) or _nonblock_.  If the _mode_
  argument is omitted, it defaults to _"yes"_.  This option overwrites
diff --git a/disk-utils/mkfs.minix.8.adoc b/disk-utils/mkfs.minix.8.adoc
index c1628ac03..4b8426f3e 100644
--- a/disk-utils/mkfs.minix.8.adoc
+++ b/disk-utils/mkfs.minix.8.adoc
@@ -46,7 +46,7 @@ Check the device for bad blocks before creating the filesystem. If any are found
 *-n*, *--namelength* _length_::
 Specify the maximum length of filenames. Currently, the only allowable values are 14 and 30 for file system versions 1 and 2. Version 3 allows only value 60. The default is 30.
 
-*--lock*[=_mode_]::
+*--lock*[**=**_mode_]::
 Use exclusive BSD lock for device or file it operates. The optional argument _mode_ can be *yes*, *no* (or 1 and 0) or *nonblock*. If the _mode_ argument is omitted, it defaults to *yes*. This option overwrites environment variable *$LOCK_BLOCK_DEVICE*. The default is not to use any lock at all, but it's recommended to avoid collisions with *systemd-udevd*(8) or other tools.
 
 *-i*, *--inodes* _number_::
diff --git a/disk-utils/mkswap.8.adoc b/disk-utils/mkswap.8.adoc
index 70d0fb315..974a5af4e 100644
--- a/disk-utils/mkswap.8.adoc
+++ b/disk-utils/mkswap.8.adoc
@@ -57,7 +57,7 @@ Suppress output and warning messages.
 *-L*, *--label* _label_::
 Specify a _label_ for the device, to allow *swapon*(8) by label.
 
-*--lock*[=_mode_]::
+*--lock*[**=**_mode_]::
 Use exclusive BSD lock for device or file it operates. The optional argument _mode_ can be *yes*, *no* (or 1 and 0) or *nonblock*. If the _mode_ argument is omitted, it defaults to *yes*. This option overwrites environment variable *$LOCK_BLOCK_DEVICE*. The default is not to use any lock at all, but it's recommended to avoid collisions with *systemd-udevd*(8) or other tools.
 
 *-p*, *--pagesize* _size_::
diff --git a/disk-utils/sfdisk.8.adoc b/disk-utils/sfdisk.8.adoc
index ce9e97b76..0bd04ba3e 100644
--- a/disk-utils/sfdisk.8.adoc
+++ b/disk-utils/sfdisk.8.adoc
@@ -162,7 +162,7 @@ Disable all consistency checking.
 *--Linux*::
 Deprecated and ignored option. Partitioning that is compatible with Linux (and other modern operating systems) is the default.
 
-*--lock*[=_mode_]::
+*--lock*[**=**_mode_]::
 Use exclusive BSD lock for device or file it operates. The optional argument _mode_ can be *yes*, *no* (or 1 and 0) or *nonblock*. If the _mode_ argument is omitted, it defaults to *yes*. This option overwrites environment variable *$LOCK_BLOCK_DEVICE*. The default is not to use any lock at all, but it's recommended to avoid collisions with *systemd-udevd*(8) or other tools.
 
 *-n*, *--no-act*::
diff --git a/login-utils/lslogins.1.adoc b/login-utils/lslogins.1.adoc
index 4aeef7cf8..debd87f5a 100644
--- a/login-utils/lslogins.1.adoc
+++ b/login-utils/lslogins.1.adoc
@@ -14,7 +14,7 @@ lslogins - display information about known users in the system
 
 == SYNOPSIS
 
-*lslogins* [options] [*-s*|*-u*[=_UID_]] [*-g* _groups_] [*-l* _logins_] [_username_]
+*lslogins* [options] [*-s*|*-u*[**=**_UID_]] [*-g* _groups_] [*-l* _logins_] [_username_]
 
 == DESCRIPTION
 
diff --git a/misc-utils/cal.1.adoc b/misc-utils/cal.1.adoc
index fe4f7e670..06b4238df 100644
--- a/misc-utils/cal.1.adoc
+++ b/misc-utils/cal.1.adoc
@@ -111,7 +111,7 @@ Display a calendar for the whole year.
 *-Y, --twelve*::
 Display a calendar for the next twelve months.
 
-*-w*, *--week*[=_number_]::
+*-w*, *--week*[**=**_number_]::
 Display week numbers in the calendar according to the US or ISO-8601 format. If
 a _number_ is specified, the requested week will be printed in the desired or
 current year. The _number_ may be overwritten if _day_ and _month_ are also
@@ -119,7 +119,7 @@ specified.
 +
 See the *NOTES* section for more details.
 
-*--color*[=_when_]::
+*--color*[**=**_when_]::
 Colorize the output. The optional argument _when_ can be *auto*, *never* or *always*. If the _when_ argument is omitted, it defaults to *auto*. The colors can be disabled; for the current built-in default see the *--help* output. See also the *COLORS* section.
 
 *-c, --columns*=_columns_::
diff --git a/misc-utils/enosys.1.adoc b/misc-utils/enosys.1.adoc
index c8d213a14..9ffd9129b 100644
--- a/misc-utils/enosys.1.adoc
+++ b/misc-utils/enosys.1.adoc
@@ -38,7 +38,7 @@ List syscalls known to *enosys*.
 *-m*, *--list-ioctl*::
 List ioctls known to *enosys*.
 
-*-d*, *--dump*[=_file_]::
+*-d*, *--dump*[**=**_file_]::
 Dump seccomp bytecode filter to standard output.
 +
 The dump can for example be used by *setpriv --seccomp-filter*.
diff --git a/misc-utils/findmnt.8.adoc b/misc-utils/findmnt.8.adoc
index f2d6dbe5c..fe29afe77 100644
--- a/misc-utils/findmnt.8.adoc
+++ b/misc-utils/findmnt.8.adoc
@@ -57,7 +57,7 @@ The search direction, either *forward* or *backward*.
 *-e*, *--evaluate*::
 Convert all tags (LABEL, UUID, PARTUUID, or PARTLABEL) to the corresponding device names for the SOURCE column.  It's an unusual situation, but the same tag may be duplicated (used for more devices). For this purpose, there is SOURCES (pl.) column. This column displays by multi-line cell all devices where the tag is detected by libblkid. This option makes sense for _fstab_ only.
 
-*--hyperlink*[=_mode_]::
+*--hyperlink*[**=**_mode_]::
 Print mountpoint paths as terminal hyperlinks. The _mode_ can be set to "always", "never", or "auto". The optional argument _when_ can be set to "auto", "never", or "always". If the _when_ argument is omitted, it will default to "auto". The "auto" setting means that hyperlinks will only be used if the output is on a terminal.
 
 *-F*, *--tab-file* _path_::
diff --git a/misc-utils/hardlink.1.adoc b/misc-utils/hardlink.1.adoc
index 49e7e3e07..98b29a3b3 100644
--- a/misc-utils/hardlink.1.adoc
+++ b/misc-utils/hardlink.1.adoc
@@ -131,7 +131,7 @@ Crypto API is not available. The methods based on checksums are implemented in
 zero-copy way, in this case file contents are not copied to the userspace and all
 calculation is done in kernel.
 
-*--reflink*[=_when_]::
+*--reflink*[**=**_when_]::
 Create copy-on-write clones (aka reflinks) rather than hardlinks. The reflinked files
 share only on-disk data, but the file mode and owner can be different. It's recommended
 to use it with *--ignore-owner* and *--ignore-mode* options. This option implies
diff --git a/misc-utils/lsblk.8.adoc b/misc-utils/lsblk.8.adoc
index d92d3fb44..a67eb292e 100644
--- a/misc-utils/lsblk.8.adoc
+++ b/misc-utils/lsblk.8.adoc
@@ -61,7 +61,7 @@ Exclude the devices specified by the comma-separated _list_ of major device numb
 *-f*, *--fs*::
 Output info about filesystems. This option is equivalent to *-o NAME,FSTYPE,FSVER,LABEL,UUID,FSAVAIL,FSUSE%,MOUNTPOINTS*. The authoritative information about filesystems and raids is provided by the *blkid*(8) command.
 
-*--hyperlink*[=_mode_]::
+*--hyperlink*[**=**_mode_]::
 Print mountpoint paths as terminal hyperlinks. The _mode_ can be set to "always", "never", or "auto". The optional argument _when_ can be set to "auto", "never", or "always". If the _when_ argument is omitted, it will default to "auto". The "auto" setting means that hyperlinks will only be used if the output is on a terminal.
 
 *-I*, *--include* _list_::
diff --git a/misc-utils/uuidd.8.adoc b/misc-utils/uuidd.8.adoc
index 7a2f6ae54..f8001f986 100644
--- a/misc-utils/uuidd.8.adoc
+++ b/misc-utils/uuidd.8.adoc
@@ -24,7 +24,7 @@ The *uuidd* daemon is used by the UUID library to generate universally unique id
 
 == OPTIONS
 
-*-C*, *--cont-clock*[=_time_]::
+*-C*, *--cont-clock*[**=**_time_]::
 Activate continuous clock handling for time based UUIDs. *uuidd* could use all possible clock values, beginning with the daemon's start time. The optional argument can be used to set a value for the max_clock_offset. This guarantees, that a clock value of a UUID will always be within the range of the max_clock_offset.
 +
 The option *-C* or *--cont-clock* enables the feature with a default max_clock_offset of 2 hours.
diff --git a/misc-utils/wipefs.8.adoc b/misc-utils/wipefs.8.adoc
index 886ddb62e..88efaeca5 100644
--- a/misc-utils/wipefs.8.adoc
+++ b/misc-utils/wipefs.8.adoc
@@ -40,7 +40,7 @@ Note that by default *wipefs* does not erase nested partition tables on non-whol
 *-a*, *--all*::
 Erase all available signatures. The set of erased signatures can be restricted with the *-t* option.
 
-*-b*, *--backup*[=_dir_]::
+*-b*, *--backup*[**=**_dir_]::
 Create a signature backup to the file _wipefs-<devname>-<offset>.bak_ in _$HOME_ or the directory specified as the optional argument. For more details see the *EXAMPLE* section.
 
 *-f*, *--force*::
@@ -49,7 +49,7 @@ Force erasure, even if the filesystem is mounted. This is required in order to e
 *-J*, *--json*::
 Use JSON output format.
 
-*--lock*[=_mode_]::
+*--lock*[**=**_mode_]::
 Use exclusive BSD lock for device or file it operates. The optional argument _mode_ can be *yes*, *no* (or 1 and 0) or *nonblock*. If the _mode_ argument is omitted, it defaults to *"yes"*. This option overwrites environment variable *$LOCK_BLOCK_DEVICE*. The default is not to use any lock at all, but it's recommended to avoid collisions with udevd or other tools.
 
 *-i*, *--noheadings*::
diff --git a/sys-utils/dmesg.1.adoc b/sys-utils/dmesg.1.adoc
index ccdeefa8f..364c4aca4 100644
--- a/sys-utils/dmesg.1.adoc
+++ b/sys-utils/dmesg.1.adoc
@@ -78,7 +78,7 @@ Read the /dev/kmsg messages from the given _file_. Different record as expected
 *-k*, *--kernel*::
 Print kernel messages.
 
-*-L*, *--color*[=_when_]::
+*-L*, *--color*[**=**_when_]::
 Colorize the output. The optional argument _when_ can be *auto*, *never* or *always*. If the _when_ argument is omitted, it defaults to *auto*. The colors can be disabled; for the current built-in default see the *--help* output. See also the *COLORS* section below.
 
 *-l*, *--level* _list_::
diff --git a/sys-utils/lscpu.1.adoc b/sys-utils/lscpu.1.adoc
index 60c769c04..f7d9ccf0d 100644
--- a/sys-utils/lscpu.1.adoc
+++ b/sys-utils/lscpu.1.adoc
@@ -39,7 +39,7 @@ include::man-common/in-bytes.adoc[]
 *-b*, *--online*::
 Limit the output to online CPUs (default for *-p*). This option may only be specified together with option *-e* or *-p*.
 
-*-C*, *--caches*[=_list_]::
+*-C*, *--caches*[**=**_list_]::
 Display details about CPU caches. For details about available information see *--help* output.
 +
 If the _list_ argument is omitted, all columns for which data is available are included in the command output.
@@ -51,10 +51,10 @@ The default list of columns may be extended if list is specified in the format +
 *-c*, *--offline*::
 Limit the output to offline CPUs. This option may only be specified together with option *-e* or *-p*.
 
-*--hierarchic*[=_when_]::
+*--hierarchic*[**=**_when_]::
 Use subsections in summary output. For backward compatibility, the default is to use subsections only when output on a terminal and flattened output on a non-terminal. The optional argument _when_ can be *never*, *always* or *auto*. If the _when_ argument is omitted, it defaults to "always".
 
-*-e*, *--extended*[=_list_]::
+*-e*, *--extended*[**=**_list_]::
 Display the CPU information in human-readable format.
 +
 If the _list_ argument is omitted, the default columns are included in the command output.  The default output is subject to change.
@@ -69,7 +69,7 @@ Use JSON output format for the default summary or extended output (see
 summary behavior for non-terminals (e.g., pipes) where subsections are missing. See
 also *--hierarchic*.
 
-*-p*, *--parse*[=_list_]::
+*-p*, *--parse*[**=**_list_]::
 Optimize the command output for easy parsing.
 +
 If the _list_ argument is omitted, the command output is compatible with earlier versions of *lscpu*. In this compatible format, two commas are used to separate CPU cache columns. If no CPU caches are identified the cache column is omitted. If the _list_ argument is used, cache columns are separated with a colon (:).
diff --git a/sys-utils/lsmem.1.adoc b/sys-utils/lsmem.1.adoc
index f1ece8f7d..3e5577ee7 100644
--- a/sys-utils/lsmem.1.adoc
+++ b/sys-utils/lsmem.1.adoc
@@ -62,7 +62,7 @@ Gather memory data for a Linux instance other than the instance from which the *
 
 include::man-common/help-version.adoc[]
 
-*--summary*[=_when_]::
+*--summary*[**=**_when_]::
 This option controls summary lines output. The optional argument _when_ can be *never*, *always* or *only*. If the _when_ argument is omitted, it defaults to *"only"*. The summary output is suppressed for *--raw*, *--pairs* and *--json*.
 
 == AUTHORS
diff --git a/sys-utils/mount.8.adoc b/sys-utils/mount.8.adoc
index 08a2e731c..1ec795056 100644
--- a/sys-utils/mount.8.adoc
+++ b/sys-utils/mount.8.adoc
@@ -750,10 +750,10 @@ ____
 mount -t auto -o'X-mount.auto-fstypes="noext2,ext3"'  /dev/sdc1 /mnt/test
 ____
 
-*X-mount.mkdir*[=_mode_]::
+*X-mount.mkdir*[**=**_mode_]::
 Allow to make a target directory (mountpoint) if it does not exist yet. The optional argument _mode_ specifies the filesystem access mode used for *mkdir*(2) in octal notation. The default mode is 0755. This functionality is supported only for root users or when *mount* is executed without suid permissions. The option is also supported as *x-mount.mkdir*, but this notation is deprecated since v2.30. See also *--mkdir* command line option.
 
-*X-mount.nocanonicalize*[=_type_]::
+*X-mount.nocanonicalize*[**=**_type_]::
 Allows disabling of canonicalization for mount source and target paths. By default, the `mount` command resolves all paths to their absolute paths without symlinks. However, this behavior may not be desired in certain situations, such as when binding a mount over a symlink, or a symlink over a directory or another symlink. The optional argument _type_ can be either "source" or "target" (mountpoint). If no _type_ is specified, then canonicalization is disabled for both types. This mount option does not affect the conversion of source tags (e.g. LABEL= or UUID=) and fstab processing.
 +
 The command line option *--no-canonicalize* overrides this mount option and affects all path and tag conversions in all situations, but it does not modify flags for open_tree syscalls.
diff --git a/sys-utils/nsenter.1.adoc b/sys-utils/nsenter.1.adoc
index 5246daecd..cb6419fda 100644
--- a/sys-utils/nsenter.1.adoc
+++ b/sys-utils/nsenter.1.adoc
@@ -79,35 +79,35 @@ the root directory
 _/proc/pid/cwd_;;
 the working directory respectively
 
-*-m*, *--mount*[=_file_]::
+*-m*, *--mount*[**=**_file_]::
 Enter the mount namespace. If no file is specified, enter the mount namespace of the target process. If _file_ is specified, enter the mount namespace specified by _file_.
 
-*-u*, *--uts*[=_file_]::
+*-u*, *--uts*[**=**_file_]::
 Enter the UTS namespace. If no file is specified, enter the UTS namespace of the target process. If _file_ is specified, enter the UTS namespace specified by _file_.
 
-*-i*, *--ipc*[=_file_]::
+*-i*, *--ipc*[**=**_file_]::
 Enter the IPC namespace. If no file is specified, enter the IPC namespace of the target process. If _file_ is specified, enter the IPC namespace specified by _file_.
 
-*-n*, *--net*[=_file_]::
+*-n*, *--net*[**=**_file_]::
 Enter the network namespace. If no file is specified, enter the network namespace of the target process. If _file_ is specified, enter the network namespace specified by _file_.
 
 *-N*, *--net-socket* _fd_::
 Enter the network namespace of the target process's socket. It requires *--target* process specified. Supported since Linux 5.6.
 
-*-p*, *--pid*[=_file_]::
+*-p*, *--pid*[**=**_file_]::
 Enter the PID namespace. If no file is specified, enter the PID namespace of the target process. If _file_ is specified, enter the PID namespace specified by _file_.
 
-*-U*, *--user*[=_file_]::
+*-U*, *--user*[**=**_file_]::
 Enter the user namespace. If no file is specified, enter the user namespace of the target process. If _file_ is specified, enter the user namespace specified by _file_. See also the *--setuid* and *--setgid* options.
 
 *--user-parent*::
 Enter the parent user namespace. Parent user namespace will be acquired from any other enabled namespace.
 If combined with *--user* option the parent user namespace will be fetched from the user namespace and replace it.
 
-*-C*, *--cgroup*[=_file_]::
+*-C*, *--cgroup*[**=**_file_]::
 Enter the cgroup namespace. If no file is specified, enter the cgroup namespace of the target process. If _file_ is specified, enter the cgroup namespace specified by _file_.
 
-*-T*, *--time*[=_file_]::
+*-T*, *--time*[**=**_file_]::
 Enter the time namespace. If no file is specified, enter the time namespace of the target process. If _file_ is specified, enter the time namespace specified by _file_.
 
 *-G*, *--setgid* _gid_::
@@ -126,13 +126,13 @@ When the *--user* option is given, ensure that capabilities granted in the user
 *--preserve-credentials*::
 Don't modify UID and GID when enter user namespace. The default is to drops supplementary groups and sets GID and UID to 0.
 
-*-r*, *--root*[=_directory_]::
+*-r*, *--root*[**=**_directory_]::
 Set the root directory. If no directory is specified, set the root directory to the root directory of the target process. If directory is specified, set the root directory to the specified directory. The specified _directory_ is open before it switches to the requested namespaces.
 
-*-w*, *--wd*[=_directory_]::
+*-w*, *--wd*[**=**_directory_]::
 Set the working directory. If no directory is specified, set the working directory to the working directory of the target process. If directory is specified, set the working directory to the specified directory. The specified _directory_ is open before it switches to the requested namespaces, it means the specified directory works as "tunnel" to the current namespace. See also *--wdns*.
 
-*-W*, *--wdns*[=_directory_]::
+*-W*, *--wdns*[**=**_directory_]::
 Set the working directory. The _directory_ is open after switch to the requested namespaces and after *chroot*(2) call. The options *--wd* and *--wdns* are mutually exclusive.
 
 *-e*, *--env*::
diff --git a/sys-utils/prlimit.1.adoc b/sys-utils/prlimit.1.adoc
index 86e06a279..49534cd52 100644
--- a/sys-utils/prlimit.1.adoc
+++ b/sys-utils/prlimit.1.adoc
@@ -18,9 +18,9 @@ prlimit - get and set process resource limits
 
 == SYNOPSIS
 
-*prlimit* [options] [*--resource*[=_limits_]] [*--pid* _PID_]
+*prlimit* [options] [*--resource*[**=**_limits_]] [*--pid* _PID_]
 
-*prlimit* [options] [*--resource*[=_limits_]] _command_ [_argument_...]
+*prlimit* [options] [*--resource*[**=**_limits_]] _command_ [_argument_...]
 
 == DESCRIPTION
 
@@ -59,52 +59,52 @@ include::man-common/help-version.adoc[]
 
 == RESOURCE OPTIONS
 
-*-c*, *--core*[=_limits_]::
+*-c*, *--core*[**=**_limits_]::
 Maximum size of a core file.
 
-*-d*, *--data*[=_limits_]::
+*-d*, *--data*[**=**_limits_]::
 Maximum data size.
 
-*-e*, *--nice*[=_limits_]::
+*-e*, *--nice*[**=**_limits_]::
 Maximum nice priority allowed to raise.
 
-*-f*, *--fsize*[=_limits_]::
+*-f*, *--fsize*[**=**_limits_]::
 Maximum file size.
 
-*-i*, *--sigpending*[=_limits_]::
+*-i*, *--sigpending*[**=**_limits_]::
 Maximum number of pending signals.
 
-*-l*, *--memlock*[=_limits_]::
+*-l*, *--memlock*[**=**_limits_]::
 Maximum locked-in-memory address space.
 
-*-m*, *--rss*[=_limits_]::
+*-m*, *--rss*[**=**_limits_]::
 Maximum Resident Set Size (RSS).
 
-*-n*, *--nofile*[=_limits_]::
+*-n*, *--nofile*[**=**_limits_]::
 Maximum number of open files.
 
-*-q*, *--msgqueue*[=_limits_]::
+*-q*, *--msgqueue*[**=**_limits_]::
 Maximum number of bytes in POSIX message queues.
 
-*-r*, *--rtprio*[=_limits_]::
+*-r*, *--rtprio*[**=**_limits_]::
 Maximum real-time priority.
 
-*-s*, *--stack*[=_limits_]::
+*-s*, *--stack*[**=**_limits_]::
 Maximum size of the stack.
 
-*-t*, *--cpu*[=_limits_]::
+*-t*, *--cpu*[**=**_limits_]::
 CPU time, in seconds.
 
-*-u*, *--nproc*[=_limits_]::
+*-u*, *--nproc*[**=**_limits_]::
 Maximum number of processes.
 
-*-v*, *--as*[=_limits_]::
+*-v*, *--as*[**=**_limits_]::
 Address space limit.
 
-*-x*, *--locks*[=_limits_]::
+*-x*, *--locks*[**=**_limits_]::
 Maximum number of file locks held.
 
-*-y*, *--rttime*[=_limits_]::
+*-y*, *--rttime*[**=**_limits_]::
 Timeout for real-time tasks.
 
 == NOTES
diff --git a/term-utils/agetty.8.adoc b/term-utils/agetty.8.adoc
index 627f858a2..d34bd746c 100644
--- a/term-utils/agetty.8.adoc
+++ b/term-utils/agetty.8.adoc
@@ -99,7 +99,7 @@ Do not clear the screen before prompting for the login name. By default the scre
 *-l*, *--login-program* _login_program_::
 Invoke the specified _login_program_ instead of /bin/login. This allows the use of a non-standard login program. Such a program could, for example, ask for a dial-up password or use a different password file. See *--login-options*.
 
-*-L*, *--local-line*[=__mode__]::
+*-L*, *--local-line*[**=**__mode__]::
 Control the CLOCAL line flag. The optional _mode_ argument is *auto*, *always* or *never*. If the _mode_ argument is omitted, then the default is *always*. If the *--local-line* option is not given at all, then the default is *auto*.
 
 _always_;;
diff --git a/term-utils/script.1.adoc b/term-utils/script.1.adoc
index d7840cd41..7d9fa0eac 100644
--- a/term-utils/script.1.adoc
+++ b/term-utils/script.1.adoc
@@ -115,7 +115,7 @@ Limit the size of the typescript and timing files to _size_ and stop the child p
 *-q*, *--quiet*::
 Be quiet (do not write start and done messages to standard output).
 
-*-t*[_file_], *--timing*[=_file_]::
+*-t*[_file_], *--timing*[**=**_file_]::
 Output timing data to standard error, or to _file_ when given. This option is deprecated in favour of *--log-timing* where the _file_ argument is not optional.
 
 include::man-common/help-version.adoc[]
diff --git a/term-utils/setterm.1.adoc b/term-utils/setterm.1.adoc
index 365c4bb00..38dc81ab5 100644
--- a/term-utils/setterm.1.adoc
+++ b/term-utils/setterm.1.adoc
@@ -46,17 +46,17 @@ Like *--dump*, but appends to the snapshot file instead of overwriting it. Only
 *--background* __8-color__|default::
 Sets the background text color.
 
-*--blank*[=0-60|force|poke]::
+*--blank*[**=**0-60|force|poke]::
 Sets the interval of inactivity, in minutes, after which the screen will be automatically blanked (using APM if available). Without an argument, it gets the blank status (returns which vt was blanked, or zero for an unblanked vt). Virtual consoles only.
 +
 The *force* argument keeps the screen blank even if a key is pressed.
 +
 The *poke* argument unblanks the screen.
 
-*--bfreq*[=_number_]::
+*--bfreq*[**=**_number_]::
 Sets the bell frequency in Hertz. Without an argument, it defaults to *0*. Virtual consoles only.
 
-*--blength*[=0-2000]::
+*--blength*[**=**0-2000]::
 Sets the bell duration in milliseconds. Without an argument, it defaults to *0*. Virtual consoles only.
 
 *--blink* on|off::
@@ -65,10 +65,10 @@ Turns blink mode on or off. Except on a virtual console, *--blink off* turns off
 *--bold* on|off::
 urns bold (extra bright) mode on or off. Except on a virtual console, *--bold off* turns off all attributes (bold, half-brightness, blink, reverse).
 
-*--clear*[=all|rest]::
+*--clear*[**=**all|rest]::
 Without an argument or with the argument *all*, the entire screen is cleared and the cursor is set to the home position, just like *clear*(1) does. With the argument *rest*, the screen is cleared from the current cursor position to the end.
 
-*--clrtabs*[=_tab1 tab2 tab3_ ...]::
+*--clrtabs*[**=**_tab1 tab2 tab3_ ...]::
 Clears tab stops from the given horizontal cursor positions, in the range *1-160*. Without arguments, it clears all tab stops. Virtual consoles only.
 
 *--cursor* on|off::
@@ -77,7 +77,7 @@ Turns the terminal's cursor on or off.
 *--default*::
 Sets the terminal's rendering options to the default values.
 
-*--dump*[=_console_number_]::
+*--dump*[**=**_console_number_]::
 Writes a snapshot of the virtual console with the given number to the file specified with the *--file* option, overwriting its contents; the default is _screen.dump_. Without an argument, it dumps the current virtual console. This overrides *--append*.
 
 *--file* _filename_::
@@ -109,7 +109,7 @@ Sets the console logging level for kernel *printk()* messages. All messages stri
 +
 Virtual consoles only.
 
-*--powerdown*[=0-60]::
+*--powerdown*[**=**0-60]::
 Sets the VESA powerdown interval in minutes. Without an argument, it defaults to *0* (disable powerdown). If the console is blanked or the monitor is in suspend mode, then the monitor will go into vsync suspend mode or powerdown mode respectively after this period of time has elapsed.
 
 *--powersave* _mode_::
@@ -124,7 +124,7 @@ Puts the monitor into VESA powerdown mode.
 *off*;;
 Turns monitor VESA powersaving features.
 
-*--regtabs*[=1-160]::
+*--regtabs*[**=**1-160]::
 Clears all tab stops, then sets a regular tab stop pattern, with one tab every specified number of positions. Without an argument, it defaults to *8*. Virtual consoles only.
 
 *--repeat* on|off::
@@ -142,7 +142,7 @@ Turns reverse video mode on or off. Except on a virtual console, *--reverse off*
 *--store*::
 Stores the terminal's current rendering options (foreground and background colors) as the values to be used at reset-to-default. Virtual consoles only.
 
-*--tabs*[=_tab1 tab2 tab3_ ...]::
+*--tabs*[**=**_tab1 tab2 tab3_ ...]::
 Sets tab stops at the given horizontal cursor positions, in the range *1-160*. Without arguments, it shows the current tab stop settings.
 
 *--term* _terminal_name_::
diff --git a/text-utils/hexdump.1.adoc b/text-utils/hexdump.1.adoc
index dd6247e3a..153953817 100644
--- a/text-utils/hexdump.1.adoc
+++ b/text-utils/hexdump.1.adoc
@@ -82,7 +82,7 @@ Specify a format string to be used for displaying data.
 *-f*, *--format-file* _file_::
 Specify a file that contains one or more newline-separated format strings. Empty lines and lines whose first non-blank character is a hash mark (#) are ignored.
 
-*-L*, *--color*[=_when_]::
+*-L*, *--color*[**=**_when_]::
 Accept color units for the output. The optional argument _when_ can be *auto*, *never* or *always*. If the _when_ argument is omitted, it defaults to *auto*. The colors can be disabled; for the current built-in default see the *--help* output. See also the *Colors* subsection and the *COLORS* section below.
 
 *-n*, *--length* _length_::
-- 
2.48.1

