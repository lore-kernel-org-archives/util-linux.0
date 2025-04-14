Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8180317A2FC
	for <util-linux@vger.kernel.org>; Mon, 14 Apr 2025 09:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744623986; cv=none; b=l0Nm0G4Q8tdk0W+CBmB4M7z4NFQN6EWhARMNxSYbJezZVKVLBEzmRiC3runzd9i0xy/R6pI8pobNVwTp3AA8tZJesywyvS8c2XjyblMReDlP8Ouw7EkRNYKTQRwmSmgUAFbzTpoxgpd6Xv/znN9hqLmmVjTxE7Az5eN/ODJb11k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744623986; c=relaxed/simple;
	bh=S0WJ499W8o5MGcciDNOZBSbJ54BpSJz4Eiu62F6WH8Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QwaXQW2JCuf7BCMR8TBkgbJNNqw1QqBif4j5DGQjEByr9YpVnwQk9yIFNH2AwmgK2mHzf69Tib4IwWS31mZOpIQZNlt9OqJrbKABGf1um8REwDXow2uwXfoje7qIAHFMzG+FC4psPlObDuwKkeGJjOnyrR6sQuclqqf917R89I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=C7mgkTLE; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="C7mgkTLE"
X-KPN-MessageId: 5ec52b11-1915-11f0-a82e-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 5ec52b11-1915-11f0-a82e-005056abad63;
	Mon, 14 Apr 2025 11:46:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=AOGmEj9650sMsMQpPjcjwU0Im1N1+czxjTKtcOVLemo=;
	b=C7mgkTLEPrqWSlI1/qbcn5bgXR3Q2GRC0OECrxgj/eNXFLLBrzPNdN7lXvEC0H8QXGy81fWxhffuH
	 wutGaI6EjT7HTbki5U08zvO/1dkHh2ijoyz6OD91MqajxlQZboi6eBu6ZVtIuMgu1eSjJJ3GG7ctXN
	 1mgSpWE/qU3vlQvQ=
X-KPN-MID: 33|oHlxWpIpONG1r7YgFqECW97Xb1VI6Pv7bODcPoTJkZMttNmEqQfSlYDApE/SRkJ
 HbyaVIhny2u/cqqKZ+/5ZAc6SxxrqGOHtvD0AcwxIc08=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|T/ZPA2GSr4MJE/NCjgQqjrmkNOmM7E281RxNcIAYcM1v6q41bWFNWWlq0iXtWdG
 c+sgPp0SFgUYeoS27v+9T0Q==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 52653783-1915-11f0-9bf3-005056ab7447;
	Mon, 14 Apr 2025 11:46:21 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 6/8] docs: add -h/--help and -V/--version to three man pages that lacked them
Date: Mon, 14 Apr 2025 11:45:32 +0200
Message-ID: <20250414094534.9504-6-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250414094534.9504-1-bensberg@telfort.nl>
References: <20250414094534.9504-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also, harmonize the wording and placement of these options in
a few other man pages, and use an `include` where possible.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 disk-utils/fsck.8.adoc     | 2 +-
 disk-utils/sfdisk.8.adoc   | 6 +++---
 misc-utils/kill.1.adoc     | 2 ++
 misc-utils/lastlog2.8.adoc | 8 ++++----
 sys-utils/blkpr.8.adoc     | 6 +-----
 sys-utils/setsid.1.adoc    | 6 +-----
 sys-utils/tunelp.8.adoc    | 2 ++
 text-utils/line.1.adoc     | 6 +++++-
 8 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/disk-utils/fsck.8.adoc b/disk-utils/fsck.8.adoc
index bf6a0ec26..8631bcd79 100644
--- a/disk-utils/fsck.8.adoc
+++ b/disk-utils/fsck.8.adoc
@@ -113,7 +113,7 @@ Produce verbose output, including all filesystem-specific commands that are exec
 Display help text and exit.
 
 *--version*::
-Display version information and exit.
+Display version and exit.
 
 == FILESYSTEM SPECIFIC OPTIONS
 
diff --git a/disk-utils/sfdisk.8.adoc b/disk-utils/sfdisk.8.adoc
index 0bd04ba3e..d61a031c2 100644
--- a/disk-utils/sfdisk.8.adoc
+++ b/disk-utils/sfdisk.8.adoc
@@ -226,12 +226,12 @@ Wipe filesystem, RAID and partition-table signatures from the device, in order t
 *-W*, *--wipe-partitions* _when_::
 Wipe filesystem, RAID and partition-table signatures from a newly created partition, in order to avoid possible collisions. The argument _when_ can be *auto*, *never* or *always*. When this option is not given, the default is *auto*, in which case signatures are wiped only when in interactive mode and after confirmation by user. In all cases detected signatures are reported by warning messages after a new partition is created. See also *wipefs*(8) command.
 
-*-v*, *--version*::
-Display version information and exit.
-
 *-h*, *--help*::
 Display help text and exit.
 
+*-v*, *--version*::
+Display version and exit.
+
 == INPUT FORMATS
 
 *sfdisk* supports two input formats and generic header lines.
diff --git a/misc-utils/kill.1.adoc b/misc-utils/kill.1.adoc
index 5421fe16f..76027fb52 100644
--- a/misc-utils/kill.1.adoc
+++ b/misc-utils/kill.1.adoc
@@ -104,6 +104,8 @@ Ignored: TERM TSTP TTIN TTOU
 Caught: HUP INT PIPE ALRM CHLD WINCH
 ....
 
+include::man-common/help-version.adoc[]
+
 == EXIT STATUS
 
 *kill* has the following exit status values:
diff --git a/misc-utils/lastlog2.8.adoc b/misc-utils/lastlog2.8.adoc
index 5e3289db7..fb0cf52c9 100644
--- a/misc-utils/lastlog2.8.adoc
+++ b/misc-utils/lastlog2.8.adoc
@@ -44,9 +44,6 @@ Clear last login record of a user. This option can be used only together with
 *-d*, *--database _FILE_::
 Use _FILE_ as lastlog2 database.
 
-*-h*, *--help*::
-Display help message and exit.
-
 *-i*, *--import* _FILE_::
 Import data from old lastlog file _FILE_. Existing entries in the lastlog2
 database will be overwritten.
@@ -67,8 +64,11 @@ Print only last login records more recent than _DAYS_.
 *-u*, *--users* _LOGINS_::
 Print only the last login record of the user _LOGIN_.
 
+*-h*, *--help*::
+Display help text and exit.
+
 *-v*, *--version*::
-Print version number and exit.
+Display version and exit.
 
 If the user has never logged in the message **Never logged in** will be displayed
 in the latest login time row.
diff --git a/sys-utils/blkpr.8.adoc b/sys-utils/blkpr.8.adoc
index db2b8a0a9..98983b779 100644
--- a/sys-utils/blkpr.8.adoc
+++ b/sys-utils/blkpr.8.adoc
@@ -40,11 +40,7 @@ Supported flag is *ignore-key*.
 Supported types are *write-exclusive*, *exclusive-access*, *write-exclusive-reg-only*,
 *exclusive-access-reg-only*, *write-exclusive-all-regs*, and *exclusive-access-all-regs*.
 
-*-V*, *--version*::
-Display version information and exit.
-
-*-h*, *--help*::
-Display help text and exit.
+include::man-common/help-version.adoc[]
 
 == AUTHORS
 
diff --git a/sys-utils/setsid.1.adoc b/sys-utils/setsid.1.adoc
index 3eddcab79..5cf49a597 100644
--- a/sys-utils/setsid.1.adoc
+++ b/sys-utils/setsid.1.adoc
@@ -31,11 +31,7 @@ Always create a new process.
 *-w*, *--wait*::
 Wait for the execution of the program to end, and return the exit status of this program as the exit status of *setsid*.
 
-*-V*, *--version*::
-Display version information and exit.
-
-*-h*, *--help*::
-Display help text and exit.
+include::man-common/help-version.adoc[]
 
 == AUTHORS
 
diff --git a/sys-utils/tunelp.8.adoc b/sys-utils/tunelp.8.adoc
index 37140b31f..c2787889d 100644
--- a/sys-utils/tunelp.8.adoc
+++ b/sys-utils/tunelp.8.adoc
@@ -56,6 +56,8 @@ This option resets the port. It requires a Linux kernel version of 1.1.80 or lat
 *-q*, *--print-irq* _<on|off>_::
 This option sets printing the display of the current IRQ setting.
 
+include::man-common/help-version.adoc[]
+
 == FILES
 
 _/dev/lp?_,
diff --git a/text-utils/line.1.adoc b/text-utils/line.1.adoc
index bed0d0d31..5ad85812d 100644
--- a/text-utils/line.1.adoc
+++ b/text-utils/line.1.adoc
@@ -17,12 +17,16 @@ line - read one line
 
 == SYNOPSIS
 
-*line*
+*line* [*-h*|*-V*]
 
 == DESCRIPTION
 
 The utility *line* copies one line (up to a newline) from standard input to standard output. It always prints at least a newline and returns an exit status of 1 on EOF or read error.
 
+== OPTIONS
+
+include::man-common/help-version.adoc[]
+
 == SEE ALSO
 
 *read*(1p)
-- 
2.48.1

