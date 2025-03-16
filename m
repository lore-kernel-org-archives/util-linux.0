Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A751A0731
	for <util-linux@vger.kernel.org>; Sun, 16 Mar 2025 15:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742138482; cv=none; b=pWRI8J3FIIjSUscfaNmQFxwiOnE6MnYZRQ2ifKIF4OZvAvlWWKFyhwo5Zc0Ies4UXy/Wa2EtMGD0Z2RCy5oEt/KzKZ4jnGtPZKXA+Xuwyh+fy/FQRRuHAjgwFZbcXF8B0kLNDVWZYhsMAnxzQ72yFm4bc5Gq5nmHtt3MJvArjHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742138482; c=relaxed/simple;
	bh=rY/1mbX6Gw3pXA0xYp3nWq794yDQEk0iFHL6gso+Az4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GfofetFLGQl14709u0bTWpB1Z5IFNUGGcp30jqQXE+Bw0BhKgfbqoJE+vTGZFRCEKzeHjVawy9er7U5328Jnv0P/GH6SMw3ONyVRlTjrOGFkVqm5+8jcZ7YcOMkGG5Sid/AAz69Jncyvf8vqOX97FZ2QDHAAp4XMmmV+g9RHqeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=cEkCZICX; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="cEkCZICX"
X-KPN-MessageId: 575a295a-027a-11f0-86c9-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 575a295a-027a-11f0-86c9-005056aba152;
	Sun, 16 Mar 2025 16:21:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=acP51AnXBDzAKRTcKkHn+y/YlmC4YD8ovQJ2Y4GUwqA=;
	b=cEkCZICXVx6/aHsrk77BMnlUmgLEhglJIEX159qkgmg/htJM4FYjcSpQ+WofcwfeFfeTsVctMfApq
	 LhLBAFfuszpr3/fUES2EM36izI7eDZ9Os7ld1bsnbmlZfB0Gq0FuZ8KhgAAdvMsRjkI3m+lgrvlmCH
	 sLeq1JzcFx4KQ8os=
X-KPN-MID: 33|yWiOZTks97NtYQIocjDy6nCs/DsOZyOD7+g6lY5a/AYwcQsk8eQWsjEqGp37shx
 WW6eOj24uqiYQ7MHkc7FPzy4PTBWq6n96kxO9onzI80Q=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|+PfGhT4dVJyVfsn44uCrgi3U0FDDgwGl+sj4YGBfVicSSgCA3YLRFyHcpm4WbIR
 AUgJfssZht9CG747UdcvddA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 4cf3b5e1-027a-11f0-958e-005056abf0db;
	Sun, 16 Mar 2025 16:21:15 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/3] various: (man) list --help and --version last among the options
Date: Sun, 16 Mar 2025 16:20:39 +0100
Message-ID: <20250316152040.44163-3-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316152040.44163-1-bensberg@telfort.nl>
References: <20250316152040.44163-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Almost all util-linux man pages mention -h/--help and -V/--version
last in the list of options.  Make the few deviant pages conform.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 disk-utils/cfdisk.8.adoc    | 4 ++--
 disk-utils/fdisk.8.adoc     | 5 +----
 disk-utils/swaplabel.8.adoc | 4 ++--
 misc-utils/hardlink.1.adoc  | 3 +--
 misc-utils/look.1.adoc      | 2 ++
 misc-utils/lsblk.8.adoc     | 4 ++--
 misc-utils/uuidgen.1.adoc   | 4 ++--
 sys-utils/eject.1.adoc      | 4 ++--
 sys-utils/lsmem.1.adoc      | 4 ++--
 text-utils/bits.1.adoc      | 4 ++--
 text-utils/rev.1.adoc       | 4 ++--
 11 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/disk-utils/cfdisk.8.adoc b/disk-utils/cfdisk.8.adoc
index 5ab560a4a..0075fd472 100644
--- a/disk-utils/cfdisk.8.adoc
+++ b/disk-utils/cfdisk.8.adoc
@@ -44,8 +44,6 @@ If you want to remove an old partition table from a device, use *wipefs*(8).
 
 == OPTIONS
 
-include::man-common/help-version.adoc[]
-
 *-L*, *--color*[**=**__when__]::
 Colorize the output. The optional argument _when_ can be *auto*, *never* or *always*. If the _when_ argument is omitted, it defaults to *auto*. The colors can be disabled, for the current built-in default see *--help* output. See also the *COLORS* section.
 
@@ -61,6 +59,8 @@ Specify the sector size of the disk. Valid values are 512, 1024, 2048, and 4096.
 *-z*, *--zero*::
 Start with an in-memory zeroed partition table. This option does not zero the partition table on the disk; rather, it simply starts the program without reading the existing partition table. This option allows you to create a new partition table from scratch or from an *sfdisk*(8)-compatible script.
 
+include::man-common/help-version.adoc[]
+
 == COMMANDS
 
 The commands for *cfdisk* can be entered by pressing the corresponding key (pressing _Enter_ after the command is not necessary). Here is a list of the available commands:
diff --git a/disk-utils/fdisk.8.adoc b/disk-utils/fdisk.8.adoc
index 1644f7bd9..c18c38273 100644
--- a/disk-utils/fdisk.8.adoc
+++ b/disk-utils/fdisk.8.adoc
@@ -48,8 +48,6 @@ Don't erase the beginning of the first disk sector when creating a new disk labe
 *-c*, *--compatibility*[**=**_mode_]::
 Specify the compatibility mode, 'dos' or 'nondos'. The default is non-DOS mode. For backward compatibility, it is possible to use the option without the _mode_ argument -- then the default is used. Note that the optional _mode_ argument cannot be separated from the *-c* option by a space, the correct form is for example *-c*=_dos_.
 
-include::man-common/help-version.adoc[]
-
 *-L*, *--color*[**=**_when_]::
 Colorize the output. The optional argument _when_ can be *auto*, *never* or *always*. If the _when_ argument is omitted, it defaults to *auto*. The colors can be disabled; for the current built-in default see the *--help* output. See also the *COLORS* section.
 
@@ -97,8 +95,7 @@ Wipe filesystem, RAID and partition-table signatures from the device, in order t
 *-W*, *--wipe-partitions* _when_::
 Wipe filesystem, RAID and partition-table signatures from a newly created partitions, in order to avoid possible collisions. The argument _when_ can be *auto*, *never* or *always*. When this option is not given, the default is *auto*, in which case signatures are wiped only when in interactive mode and after confirmation by user. In all cases detected signatures are reported by warning messages before a new partition is created. See also *wipefs*(8) command.
 
-*-V*, *--version*::
-Display version information and exit.
+include::man-common/help-version.adoc[]
 
 == DEVICES
 
diff --git a/disk-utils/swaplabel.8.adoc b/disk-utils/swaplabel.8.adoc
index de440d394..0a1a1136f 100644
--- a/disk-utils/swaplabel.8.adoc
+++ b/disk-utils/swaplabel.8.adoc
@@ -28,14 +28,14 @@ If an optional argument is present, then *swaplabel* will change the appropriate
 
 == OPTIONS
 
-include::man-common/help-version.adoc[]
-
 *-L*, *--label* _label_::
   Specify a new _label_ for the device. Swap partition labels can be at most 16 characters long. If _label_ is longer than 16 characters, *swaplabel* will truncate it and print a warning message.
 
 *-U*, *--uuid* _UUID_::
   Specify a new _UUID_ for the device. The _UUID_ must be in the standard 8-4-4-4-12 character format, such as is output by *uuidgen*(1).
 
+include::man-common/help-version.adoc[]
+
 == ENVIRONMENT
 
 LIBBLKID_DEBUG=all::
diff --git a/misc-utils/hardlink.1.adoc b/misc-utils/hardlink.1.adoc
index 98b29a3b3..e09572f6c 100644
--- a/misc-utils/hardlink.1.adoc
+++ b/misc-utils/hardlink.1.adoc
@@ -40,8 +40,6 @@ are very often different from the beginning.
 
 == OPTIONS
 
-include::man-common/help-version.adoc[]
-
 *-c*, *--content*::
 Consider only file content, not attributes, when determining whether two files are equal. Same as *-pot*.
 
@@ -146,6 +144,7 @@ only reflinks are allowed.
 *--skip-reflinks*::
 Ignore already cloned files. This option may be used without *--reflink* when creating classic hardlinks.
 
+include::man-common/help-version.adoc[]
 
 == ARGUMENTS
 
diff --git a/misc-utils/look.1.adoc b/misc-utils/look.1.adoc
index 35b8978bc..0ef71ece3 100644
--- a/misc-utils/look.1.adoc
+++ b/misc-utils/look.1.adoc
@@ -72,6 +72,8 @@ Specify a string termination character, i.e., only the characters in _string_ up
 
 include::man-common/help-version.adoc[]
 
+== EXIT STATUS
+
 The *look* utility exits 0 if one or more lines were found and displayed, 1 if no lines were found, and >1 if an error occurred.
 
 == ENVIRONMENT
diff --git a/misc-utils/lsblk.8.adoc b/misc-utils/lsblk.8.adoc
index a67eb292e..7a0a15d3a 100644
--- a/misc-utils/lsblk.8.adoc
+++ b/misc-utils/lsblk.8.adoc
@@ -166,8 +166,6 @@ Output info about block-device topology. This option is equivalent to
 +
 *-o NAME,ALIGNMENT,MIN-IO,OPT-IO,PHY-SEC,LOG-SEC,ROTA,SCHED,RQ-SIZE,RA,WSAME*.
 
-include::man-common/help-version.adoc[]
-
 *-w*, *--width* _number_::
 Specifies output width as a number of characters. The default is the number of the terminal columns, and if not executed on a terminal, then output width is not restricted at all by default. This option also forces *lsblk* to assume that terminal control characters and unsafe characters are not allowed. The expected use-case is for example when *lsblk* is used by the *watch*(1) command.
 
@@ -197,6 +195,8 @@ Reads data from a file. This method is only used if the --sysroot option is spec
 *none*;;
 Does not probe. This method always stops probing.
 
+include::man-common/help-version.adoc[]
+
 == EXIT STATUS
 
 0::
diff --git a/misc-utils/uuidgen.1.adoc b/misc-utils/uuidgen.1.adoc
index 1d89fe43d..e061d8a94 100644
--- a/misc-utils/uuidgen.1.adoc
+++ b/misc-utils/uuidgen.1.adoc
@@ -34,8 +34,6 @@ Generate a random-based UUID. This method creates a UUID consisting mostly of ra
 *-t*, *--time*::
 Generate a time-based UUID. This method creates a UUID based on the system clock plus the system's ethernet hardware address, if present.
 
-include::man-common/help-version.adoc[]
-
 *-m*, *--md5*::
 Use MD5 as the hash algorithm.
 
@@ -60,6 +58,8 @@ Generate multiple UUIDs using the enhanced capability of the libuuid to cache ti
 *-x*, *--hex*::
 Interpret name _name_ as a hexadecimal string.
 
+include::man-common/help-version.adoc[]
+
 == CONFORMING TO
 
 OSF DCE 1.1
diff --git a/sys-utils/eject.1.adoc b/sys-utils/eject.1.adoc
index dd99ae524..52988601d 100644
--- a/sys-utils/eject.1.adoc
+++ b/sys-utils/eject.1.adoc
@@ -79,8 +79,6 @@ With this option the drive is given a CD-ROM tray close command if it's opened,
 *-t*, *--trayclose*::
 With this option the drive is given a CD-ROM tray close command. Not all devices support this command.
 
-include::man-common/help-version.adoc[]
-
 *-v*, *--verbose*::
 Run in verbose mode; more information is displayed about what the command is doing.
 
@@ -90,6 +88,8 @@ With this option the CD-ROM drive will be probed to detect the available speeds.
 *-x*, *--cdspeed* _speed_::
 With this option the drive is given a CD-ROM select speed command. The _speed_ argument is a number indicating the desired speed (e.g., 8 for 8X speed), or 0 for maximum data rate. Not all devices support this command and you can only specify speeds that the drive is capable of. Every time the media is changed this option is cleared. This option can be used alone, or with the *-t* and *-c* options.
 
+include::man-common/help-version.adoc[]
+
 == EXIT STATUS
 
 Returns 0 if operation was successful, 1 if operation failed or command syntax was not valid.
diff --git a/sys-utils/lsmem.1.adoc b/sys-utils/lsmem.1.adoc
index 3e5577ee7..337c8b4b7 100644
--- a/sys-utils/lsmem.1.adoc
+++ b/sys-utils/lsmem.1.adoc
@@ -60,11 +60,11 @@ Specify which columns (attributes) use to split memory blocks to ranges. The sup
 *-s*, *--sysroot* _directory_::
 Gather memory data for a Linux instance other than the instance from which the *lsmem* command is issued. The specified _directory_ is the system root of the Linux instance to be inspected.
 
-include::man-common/help-version.adoc[]
-
 *--summary*[**=**_when_]::
 This option controls summary lines output. The optional argument _when_ can be *never*, *always* or *only*. If the _when_ argument is omitted, it defaults to *"only"*. The summary output is suppressed for *--raw*, *--pairs* and *--json*.
 
+include::man-common/help-version.adoc[]
+
 == AUTHORS
 
 *lsmem* was originally written by Gerald Schaefer for s390-tools in Perl. The C version for util-linux was written by Clemens von Mann, Heiko Carstens and Karel Zak.
diff --git a/text-utils/bits.1.adoc b/text-utils/bits.1.adoc
index 8501bd19c..0a55583ec 100644
--- a/text-utils/bits.1.adoc
+++ b/text-utils/bits.1.adoc
@@ -67,12 +67,12 @@ groups so far.
 
 == OPTIONS
 
-include::man-common/help-version.adoc[]
-
 *-w* __<NUM>__, *--width* __<NUM>__::
 Maximum number of bits in the masks handled by *bits* (default __8192__). Any
 bit larger than this number will be truncated.
 
+include::man-common/help-version.adoc[]
+
 == CONVERSION MODE
 
 One of the following conversion modes can be specified. If not specified, it
diff --git a/text-utils/rev.1.adoc b/text-utils/rev.1.adoc
index 3d4027390..1cf375c27 100644
--- a/text-utils/rev.1.adoc
+++ b/text-utils/rev.1.adoc
@@ -56,11 +56,11 @@ This utility is a line-oriented tool and it uses in-memory allocated buffer for
 
 == OPTIONS
 
-include::man-common/help-version.adoc[]
-
 *-0*, *--zero*::
 _Zero termination_. Use the byte '\0' as line separator.
 
+include::man-common/help-version.adoc[]
+
 == SEE ALSO
 
 *tac*(1)
-- 
2.48.1

