Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EFD1C84AD
	for <util-linux@vger.kernel.org>; Thu, 17 Apr 2025 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744883374; cv=none; b=QNY+rxOHJXm0lpk/ZfFmIdxlXPhte6KD1WZ94khShm6GvUsK7hKulGZ2BRk6iBVCLUEDT2SglzilcOQDVZK/3AJPYOphMfVQADalVNQ/6Fv3rCZ0sddl2Ec6TOmt8dTeDQIlFnsS0HNieMtwW5OKI0efxqBAtukK+e8YYnGHYBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744883374; c=relaxed/simple;
	bh=q+j5GUXWG9YB9o3FOEI369EBRMKq/zcpYRnnOEMLB/4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srIiBS6vFci6JoZpK2iiKMjEAXaWyK2x/am/zvFQIC7Oj7ZpC3qD8reXPcGaMdANgSrqHKB1kifLWYgnXAbK8IJno3VU1UUbsw0v0JirFfEctENEOD7tIPTm7DNEMJy1uBbpEEI57MkcYRXenepCpzeMUoMqbsb8ReacCUhzxYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=nrDkMzap; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="nrDkMzap"
X-KPN-MessageId: 4fef0e41-1b71-11f0-a9b5-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 4fef0e41-1b71-11f0-a9b5-00505699b430;
	Thu, 17 Apr 2025 11:49:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=5YhrgYcD2MXC18qlhgmhEOf/7BgkunAWFfkuFOrKW0A=;
	b=nrDkMzapTAbtsnzrun866S0doE7mQz6UXavqHsuEaxKZSzS4ft5fxdkFhp1329RWcs1YTDSj9+O+W
	 3iac0E91GC+EBRSuiC0o+MTfGZTQexqDlopKmYRtHNbGhhie1H4V7LquThcHGh5Tm6t3Ivwk2xpbml
	 8Fa3MUBUmSl3aXrM=
X-KPN-MID: 33|PTCnuVIEWEoaM5i2u3dTwtiTYbS6NU9nOWeu3AVxngJG8ey6SIs1PRxlfsSjHnd
 abPtWEn0m7iUrcElgZ8MWrXId8VcjSovTuZCGN/hyIU4=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|3c50dHKS58lNAgFPViLhxUJq+d7U3F7DmP7ZNSm5mdzEiLkF2mS2euKXF7QYMIb
 nVpsmWE/J+Xh39JykP+7AZg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 4150be45-1b71-11f0-97de-00505699d6e5;
	Thu, 17 Apr 2025 11:49:29 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 10/10] docs: correct mistaken uses of "overwrite" to say "override" instead
Date: Thu, 17 Apr 2025 11:48:24 +0200
Message-ID: <20250417094825.20870-10-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250417094825.20870-1-bensberg@telfort.nl>
References: <20250417094825.20870-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This mostly comes down to harmonizing the wording and markup of the
various --lock options.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 disk-utils/cfdisk.8.adoc      |  7 ++++++-
 disk-utils/fdisk.8.adoc       |  7 ++++++-
 disk-utils/mkfs.bfs.8.adoc    |  7 ++++++-
 disk-utils/mkfs.cramfs.8.adoc |  4 ++--
 disk-utils/mkfs.minix.8.adoc  |  7 ++++++-
 disk-utils/mkswap.8.adoc      |  7 ++++++-
 disk-utils/sfdisk.8.adoc      |  7 ++++++-
 misc-utils/logger.1.adoc      |  2 +-
 misc-utils/wipefs.8.adoc      |  7 ++++++-
 sys-utils/hwclock.8.adoc      | 12 ++++++++++--
 sys-utils/losetup.8.adoc      | 11 +++++++++--
 sys-utils/mount.8.adoc        |  3 ++-
 12 files changed, 66 insertions(+), 15 deletions(-)

diff --git a/disk-utils/cfdisk.8.adoc b/disk-utils/cfdisk.8.adoc
index 0075fd472..121d023ab 100644
--- a/disk-utils/cfdisk.8.adoc
+++ b/disk-utils/cfdisk.8.adoc
@@ -48,7 +48,12 @@ If you want to remove an old partition table from a device, use *wipefs*(8).
 Colorize the output. The optional argument _when_ can be *auto*, *never* or *always*. If the _when_ argument is omitted, it defaults to *auto*. The colors can be disabled, for the current built-in default see *--help* output. See also the *COLORS* section.
 
 *--lock*[**=**_mode_]::
-Use exclusive BSD lock for device or file it operates. The optional argument _mode_ can be *yes*, *no* (or 1 and 0) or *nonblock*. If the _mode_ argument is omitted, it defaults to *yes*. This option overwrites environment variable *$LOCK_BLOCK_DEVICE*. The default is not to use any lock at all, but it's recommended to avoid collisions with *systemd-udevd*(8) or other tools.
+Use an exclusive BSD lock for the device or file that is operated upon.
+The optional argument _mode_ can be *yes* (*1*), *no* (*0*), or *nonblock*.
+If the _mode_ argument is omitted, it defaults to *yes*.
+This option overrides the environment variable *$LOCK_BLOCK_DEVICE*.
+The default is to not use any lock at all, but using a lock is recommended
+to avoid collisions with *systemd-udevd*(8) or other tools.
 
 *-r*, *--read-only*::
 Forced open in read-only mode.
diff --git a/disk-utils/fdisk.8.adoc b/disk-utils/fdisk.8.adoc
index c18c38273..13e7147bb 100644
--- a/disk-utils/fdisk.8.adoc
+++ b/disk-utils/fdisk.8.adoc
@@ -60,7 +60,12 @@ If no devices are given, the devices mentioned in _/proc/partitions_ (if this fi
 Like *--list*, but provides more details.
 
 *--lock*[**=**_mode_]::
-Use exclusive BSD lock for device or file it operates. The optional argument _mode_ can be *yes*, *no* (or 1 and 0) or *nonblock*. If the _mode_ argument is omitted, it defaults to *yes*. This option overwrites environment variable *$LOCK_BLOCK_DEVICE*. The default is not to use any lock at all, but it's recommended to avoid collisions with *systemd-udevd*(8) or other tools.
+Use an exclusive BSD lock for the device or file that is operated upon.
+The optional argument _mode_ can be *yes* (*1*), *no* (*0*), or *nonblock*.
+If the _mode_ argument is omitted, it defaults to *yes*.
+This option overrides the environment variable *$LOCK_BLOCK_DEVICE*.
+The default is to not use any lock at all, but using a lock is recommended
+to avoid collisions with *systemd-udevd*(8) or other tools.
 
 *-n*, *--noauto-pt*::
 Don't automatically create a default partition table on empty device. The partition table has to be explicitly created by user (by command like 'o', 'g', etc.).
diff --git a/disk-utils/mkfs.bfs.8.adoc b/disk-utils/mkfs.bfs.8.adoc
index 248013731..e66f8e0b5 100644
--- a/disk-utils/mkfs.bfs.8.adoc
+++ b/disk-utils/mkfs.bfs.8.adoc
@@ -36,7 +36,12 @@ Specify the volume _label_. I have no idea if/where this is used.
 Specify the filesystem _name_. I have no idea if/where this is used.
 
 *--lock*[**=**_mode_]::
-Use exclusive BSD lock for device or file it operates. The optional argument _mode_ can be *yes*, *no* (or 1 and 0) or *nonblock*. If the _mode_ argument is omitted, it defaults to *yes*. This option overwrites environment variable *$LOCK_BLOCK_DEVICE*. The default is not to use any lock at all, but it's recommended to avoid collisions with *systemd-udevd*(8) or other tools.
+Use an exclusive BSD lock for the device or file that is operated upon.
+The optional argument _mode_ can be *yes* (*1*), *no* (*0*), or *nonblock*.
+If the _mode_ argument is omitted, it defaults to *yes*.
+This option overrides the environment variable *$LOCK_BLOCK_DEVICE*.
+The default is to not use any lock at all, but using a lock is recommended
+to avoid collisions with *systemd-udevd*(8) or other tools.
 
 *-v*, *--verbose*::
 Explain what is being done.
diff --git a/disk-utils/mkfs.cramfs.8.adoc b/disk-utils/mkfs.cramfs.8.adoc
index 8a2c4a79e..bca5e8f62 100644
--- a/disk-utils/mkfs.cramfs.8.adoc
+++ b/disk-utils/mkfs.cramfs.8.adoc
@@ -67,8 +67,8 @@ Use an exclusive BSD lock for the device or file that is operated upon.
 The optional argument _mode_ can be *yes* (*1*), *no* (*0*), or *nonblock*.
 If the _mode_ argument is omitted, it defaults to *yes*.
 This option overrides the environment variable *$LOCK_BLOCK_DEVICE*.
-The default is to not use any lock at all, but using a lock
-is recommended to avoid collisions with udevd or other tools.
+The default is to not use any lock at all, but using a lock is recommended
+to avoid collisions with *systemd-udevd*(8) or other tools.
 
 include::man-common/help-version.adoc[]
 
diff --git a/disk-utils/mkfs.minix.8.adoc b/disk-utils/mkfs.minix.8.adoc
index 4b8426f3e..f747ee40f 100644
--- a/disk-utils/mkfs.minix.8.adoc
+++ b/disk-utils/mkfs.minix.8.adoc
@@ -47,7 +47,12 @@ Check the device for bad blocks before creating the filesystem. If any are found
 Specify the maximum length of filenames. Currently, the only allowable values are 14 and 30 for file system versions 1 and 2. Version 3 allows only value 60. The default is 30.
 
 *--lock*[**=**_mode_]::
-Use exclusive BSD lock for device or file it operates. The optional argument _mode_ can be *yes*, *no* (or 1 and 0) or *nonblock*. If the _mode_ argument is omitted, it defaults to *yes*. This option overwrites environment variable *$LOCK_BLOCK_DEVICE*. The default is not to use any lock at all, but it's recommended to avoid collisions with *systemd-udevd*(8) or other tools.
+Use an exclusive BSD lock for the device or file that is operated upon.
+The optional argument _mode_ can be *yes* (*1*), *no* (*0*), or *nonblock*.
+If the _mode_ argument is omitted, it defaults to *yes*.
+This option overrides the environment variable *$LOCK_BLOCK_DEVICE*.
+The default is to not use any lock at all, but using a lock is recommended
+to avoid collisions with *systemd-udevd*(8) or other tools.
 
 *-i*, *--inodes* _number_::
 Specify the number of inodes for the filesystem.
diff --git a/disk-utils/mkswap.8.adoc b/disk-utils/mkswap.8.adoc
index 974a5af4e..a7838ae91 100644
--- a/disk-utils/mkswap.8.adoc
+++ b/disk-utils/mkswap.8.adoc
@@ -58,7 +58,12 @@ Suppress output and warning messages.
 Specify a _label_ for the device, to allow *swapon*(8) by label.
 
 *--lock*[**=**_mode_]::
-Use exclusive BSD lock for device or file it operates. The optional argument _mode_ can be *yes*, *no* (or 1 and 0) or *nonblock*. If the _mode_ argument is omitted, it defaults to *yes*. This option overwrites environment variable *$LOCK_BLOCK_DEVICE*. The default is not to use any lock at all, but it's recommended to avoid collisions with *systemd-udevd*(8) or other tools.
+Use an exclusive BSD lock for the device or file that is operated upon.
+The optional argument _mode_ can be *yes* (*1*), *no* (*0*), or *nonblock*.
+If the _mode_ argument is omitted, it defaults to *yes*.
+This option overrides the environment variable *$LOCK_BLOCK_DEVICE*.
+The default is to not use any lock at all, but using a lock is recommended
+to avoid collisions with *systemd-udevd*(8) or other tools.
 
 *-p*, *--pagesize* _size_::
 Specify the page _size_ (in bytes) to use. This option is usually unnecessary; *mkswap* reads the size from the kernel.
diff --git a/disk-utils/sfdisk.8.adoc b/disk-utils/sfdisk.8.adoc
index 1ffc61588..ac81ec939 100644
--- a/disk-utils/sfdisk.8.adoc
+++ b/disk-utils/sfdisk.8.adoc
@@ -165,7 +165,12 @@ Disable all consistency checking.
 Deprecated and ignored option. Partitioning that is compatible with Linux (and other modern operating systems) is the default.
 
 *--lock*[**=**_mode_]::
-Use exclusive BSD lock for device or file it operates. The optional argument _mode_ can be *yes*, *no* (or 1 and 0) or *nonblock*. If the _mode_ argument is omitted, it defaults to *yes*. This option overwrites environment variable *$LOCK_BLOCK_DEVICE*. The default is not to use any lock at all, but it's recommended to avoid collisions with *systemd-udevd*(8) or other tools.
+Use an exclusive BSD lock for the device or file that is operated upon.
+The optional argument _mode_ can be *yes* (*1*), *no* (*0*), or *nonblock*.
+If the _mode_ argument is omitted, it defaults to *yes*.
+This option overrides the environment variable *$LOCK_BLOCK_DEVICE*.
+The default is to not use any lock at all, but using a lock is recommended
+to avoid collisions with *systemd-udevd*(8) or other tools.
 
 *-n*, *--no-act*::
 Do everything except writing to the device.
diff --git a/misc-utils/logger.1.adoc b/misc-utils/logger.1.adoc
index 0c4edbeac..e63f5eff8 100644
--- a/misc-utils/logger.1.adoc
+++ b/misc-utils/logger.1.adoc
@@ -73,7 +73,7 @@ Log the PID of the *logger* process with each line.
 *--id*[**=**__id__]::
 Log the PID of the *logger* process with each line. When the optional argument _id_ is specified, then it is used instead of the *logger* command's PID. The use of *--id=$$* (PPID) is recommended in scripts that send several messages.
 +
-Note that the system logging infrastructure (for example *systemd* when listening on _/dev/log_) may follow local socket credentials to overwrite the PID specified in the message. *logger*(1) is able to set those socket credentials to the given _id_, but only if you have root permissions and a process with the specified PID exists, otherwise the socket credentials are not modified and the problem is silently ignored.
+Note that the system logging infrastructure (for example *systemd* when listening on _/dev/log_) may follow local socket credentials to override the PID specified in the message. *logger*(1) is able to set those socket credentials to the given _id_, but only if you have root permissions and a process with the specified PID exists, otherwise the socket credentials are not modified and the problem is silently ignored.
 
 *--journald*[**=**__file__]::
 Write a *systemd* journal entry. The entry is read from the given _file_, when specified, otherwise from standard input. Each line must begin with a field that is accepted by *journald*; see *systemd.journal-fields*(7) for details. The use of a MESSAGE_ID field is generally a good idea, as it makes finding entries easy. Examples:
diff --git a/misc-utils/wipefs.8.adoc b/misc-utils/wipefs.8.adoc
index 88efaeca5..5226ea8b4 100644
--- a/misc-utils/wipefs.8.adoc
+++ b/misc-utils/wipefs.8.adoc
@@ -50,7 +50,12 @@ Force erasure, even if the filesystem is mounted. This is required in order to e
 Use JSON output format.
 
 *--lock*[**=**_mode_]::
-Use exclusive BSD lock for device or file it operates. The optional argument _mode_ can be *yes*, *no* (or 1 and 0) or *nonblock*. If the _mode_ argument is omitted, it defaults to *"yes"*. This option overwrites environment variable *$LOCK_BLOCK_DEVICE*. The default is not to use any lock at all, but it's recommended to avoid collisions with udevd or other tools.
+Use an exclusive BSD lock for the device or file that is operated upon.
+The optional argument _mode_ can be *yes* (*1*), *no* (*0*), or *nonblock*.
+If the _mode_ argument is omitted, it defaults to *yes*.
+This option overrides the environment variable *$LOCK_BLOCK_DEVICE*.
+The default is to not use any lock at all, but using a lock is recommended
+to avoid collisions with *systemd-udevd*(8) or other tools.
 
 *-i*, *--noheadings*::
 Do not print a header line.
diff --git a/sys-utils/hwclock.8.adoc b/sys-utils/hwclock.8.adoc
index e30fb5e90..3ad02054f 100644
--- a/sys-utils/hwclock.8.adoc
+++ b/sys-utils/hwclock.8.adoc
@@ -124,9 +124,17 @@ This option must be used with the *--set* or *--predict* functions, otherwise it
 The argument must be in local time, even if you keep your Hardware Clock in UTC. See the *--localtime* option. Therefore, the argument should not include any timezone information. It also should not be a relative time like "+5 minutes", because *hwclock*'s precision depends upon correlation between the argument's value and when the enter key is pressed. Fractional seconds are silently dropped. This option is capable of understanding many time and date formats, but the previous parameters should be observed.
 
 **--delay=**__seconds__::
-This option can be used to overwrite the internally used delay when setting the clock time. The default is 0.5 (500ms) for rtc_cmos, for another RTC types the delay is 0. If RTC type is impossible to determine (from sysfs) then it defaults also to 0.5 to be backwardly compatible.
+This option overrides the default delay used when setting the clock time.
+The default is *0.5* (500 ms) for rtc_cmos; for other RTC types the delay is *0*.
+If the RTC type cannot be determined (from sysfs), then the delay defaults
+also to *0.5* to be backwardly compatible.
 +
-The 500ms default is based on commonly used MC146818A-compatible (x86) hardware clock. This Hardware Clock can only be set to any integer time plus one half second. The integer time is required because there is no interface to set or get a fractional second. The additional half second delay is because the Hardware Clock updates to the following second precisely 500 ms after setting the new time. Unfortunately, this behavior is hardware specific and in some cases another delay is required.
+The 500 ms default is based on the commonly used MC146818A-compatible (x86) hardware clock.
+This Hardware Clock can only be set to an integer time plus one half second.
+The integer time is required because there is no interface to get or set a fractional second.
+The additional half second is because the Hardware Clock updates to the following second
+precisely 500 ms after setting the new time. Unfortunately, this behavior is hardware specific
+and in some cases a different delay is required.
 
 *-D*, *--debug*::
 Use *--verbose*. The *--debug* option has been deprecated and may be repurposed or removed in a future release.
diff --git a/sys-utils/losetup.8.adoc b/sys-utils/losetup.8.adoc
index e549ddf1a..48d71ec18 100644
--- a/sys-utils/losetup.8.adoc
+++ b/sys-utils/losetup.8.adoc
@@ -42,7 +42,9 @@ Resize a loop device:
 
 Note that the old output format (i.e., *losetup -a*) with comma-delimited strings is deprecated in favour of the *--list* output format.
 
-It's possible to create more independent loop devices for the same backing file. *This setup may be dangerous, can cause data loss, corruption and overwrites.* Use *--nooverlap* with *--find* during setup to avoid this problem.
+It is possible to create multiple independent loop devices for the same backing file.
+*This setup may be dangerous, can cause data loss, corruption, and overwrites.*
+Use *--nooverlap* with *--find* during setup to avoid this problem.
 
 The loop device setup is not an atomic operation when used with *--find*, and *losetup* does not protect this operation by any lock. The number of attempts is internally restricted to a maximum of 16. It is recommended to use for example *flock*(1) to avoid a collision in heavily parallel use cases.
 
@@ -75,7 +77,12 @@ Show the status of all loop devices associated with the given _file_.
 The data start is moved _offset_ bytes into the specified file or device. The _offset_ may be followed by the multiplicative suffixes; see above.
 
 *--loop-ref* _string_::
-Set reference string. The backwardly compatible default is to use the backing filename as a reference in loop setup ioctl (aka lo_file_name). This option can overwrite this default behavior and set the reference to the _string_. The reference may be used by udevd in /dev/loop/by-ref. Linux kernel does not use the reference at all, but it could be used by some old utils that cannot read the backing file from sysfs. The reference is readable only for the root user (see *--output* +REF) and it is restricted to 64 bytes.
+Set the reference string. The backwardly compatible default is to use the backing filename
+as a reference in the loop setup ioctl (aka lo_file_name). This option overrides this default
+behavior and sets the reference to the _string_. The reference may be used by udevd in
+/dev/loop/by-ref. The Linux kernel does not use the reference at all, but it could be used
+by some old utils that cannot read the backing file from sysfs. The reference is readable
+only for the root user (see *--output* +REF) and it is restricted to 64 bytes.
 
 *--sizelimit* _size_::
 The data end is set to no more than _size_ bytes after the data start. The _size_ may be followed by the multiplicative suffixes; see above.
diff --git a/sys-utils/mount.8.adoc b/sys-utils/mount.8.adoc
index 95998ce2a..e827b212a 100644
--- a/sys-utils/mount.8.adoc
+++ b/sys-utils/mount.8.adoc
@@ -385,7 +385,8 @@ Use the specified mount options. The _opts_ argument is a comma-separated list.
 +
 *mount LABEL=mydisk -o noatime,nodev,nosuid*
 +
-Note that the order of the options matters, as the last option wins if there are conflicting ones. The options from the command line also overwrite options from fstab by default.
+Note that the order of the options matters, as the last option wins if there are conflicting ones.
+Also, options on the command line override options from fstab.
 +
 For more details, see the *FILESYSTEM-INDEPENDENT MOUNT OPTIONS* and *FILESYSTEM-SPECIFIC MOUNT OPTIONS* sections.
 
-- 
2.48.1

