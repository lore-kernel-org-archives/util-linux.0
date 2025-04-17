Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0709229B1A
	for <util-linux@vger.kernel.org>; Thu, 17 Apr 2025 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744883433; cv=none; b=JkOcnGTAzq1HpoIerYPVzuvPdFV/FwbfpYQHSY+avZzehWPxJJxeM4vO8mNhA3PJAf3oMC8i8VES4Huj6/hgGyG9/QnSkYC79SE9OqFVF+LkRzeIiu3L4UrWVWa+251eAt/hUYc4uoK/zMn9Yb3cxGUZvRArsLNQbE+n8sGKr14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744883433; c=relaxed/simple;
	bh=PvQZRcDJI+1FgRcLAStP9958KgHoiM/jNJObdPqBK1E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwzG4SiKVDStDWwFtnKTEI+h59tC7kDlY+YQJngAYWP0jvCSL+Bm0MHukVFcTLbfXc75LmOAOqv+A8n31eyanvtRlOEa0LbqMdfOnydlqKzczPdvwBgMC0RBEUwrh0V3YSDl8//wLE8l/HviA/AXGD8zXRYilVNC4vK4blXPE2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=V5uGrxRL; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="V5uGrxRL"
X-KPN-MessageId: 4c7a1837-1b71-11f0-a9b5-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 4c7a1837-1b71-11f0-a9b5-00505699b430;
	Thu, 17 Apr 2025 11:49:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=4A0CLocKJpJIMteCZHVNQnglok68/LVv3SPMQJsgFYA=;
	b=V5uGrxRL0JoKh589XvV9Jj5UWX+cN4aFsiQBcaLGSfFN+jimRMjK0RrZwh+WLBDHldqJIW4JcxZaw
	 uhlq5cKPD37hJ9KS3+Wx2lw8RU1uijXjo3PCNaiq4IJAfKfd0GWURoWr7q2PGYM5/Cv1B32+DLchCg
	 Wruk1dLo0DmKvVG0=
X-KPN-MID: 33|PIFmMRa+tH2jxiGnSPDu66uV6V1+5oL1m73gYtbRQsw1M7Jw2sUh4fQujVz6dKf
 Gkyla4zLT1WtfG6lvUAJkq5AFPufKgrRJ678RS4Cnusk=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|E3YtfZDmKK18IShziCNmy25WohpPrZ7K+JfoBBrEivgEuwHRSMd5yrJdh/llYqt
 UEsdoCAfb9Yna2YR8fSlVIg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 3ddce245-1b71-11f0-afa6-005056998788;
	Thu, 17 Apr 2025 11:49:23 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 09/10] docs: correct misspellings of "may be" and mistaken uses of "overwritten"
Date: Thu, 17 Apr 2025 11:48:23 +0200
Message-ID: <20250417094825.20870-9-bensberg@telfort.nl>
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

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 disk-utils/sfdisk.8.adoc    | 10 ++++++++--
 login-utils/lslogins.1.adoc |  8 ++++++--
 misc-utils/cal.1.adoc       |  8 ++++----
 sys-utils/lscpu.1.adoc      |  2 +-
 sys-utils/nsenter.1.adoc    |  4 +++-
 term-utils/agetty.8.adoc    |  4 +++-
 6 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/disk-utils/sfdisk.8.adoc b/disk-utils/sfdisk.8.adoc
index d61a031c2..1ffc61588 100644
--- a/disk-utils/sfdisk.8.adoc
+++ b/disk-utils/sfdisk.8.adoc
@@ -148,7 +148,9 @@ Move GPT backup header behind the last partition. Note that UEFI standard requir
 *-a*, *--append*::
 Don't create a new partition table, but only append the specified partitions.
 +
-Note that unused partition maybe be re-used in this case although it is not the last partition in the partition table. See also *-N* to specify entry in the partition table.
+Note that in this case an unused partition may be re-used even though it is
+not the last partition in the partition table. See also *-N* for addressing a
+specific entry in the partition table.
 
 *-b*, *--backup*::
 Back up the current partition table sectors before starting the partitioning. The default backup file name is _~/sfdisk-<device>-<offset>.bak_; to use another name see option *-O*, *--backup-file*. See section *BACKING UP THE PARTITION TABLE* for more details.
@@ -215,7 +217,11 @@ Specify the sector size of the disk. Valid values are 512, 1024, 2048, and 4096.
 Deprecated option. Only the sector unit is supported. This option is not supported when using the *--show-size* command.
 
 *-X*, *--label* _type_::
-Specify the disk label type (e.g., *dos*, *gpt*, ...). If this option is not given, then *sfdisk* defaults to the existing label, but if there is no label on the device yet, then the type defaults to *dos*. The default or the current label may be overwritten by the "label: <name>" script header line. The option *--label* does not force *sfdisk* to create empty disk label (see the *EMPTY DISK LABEL* section below).
+Specify the disk-label type (e.g., *dos*, *gpt*, ...). If this option is not given,
+then *sfdisk* defaults to the type of the existing label, but if there is no label
+on the device yet, then the type defaults to *dos*. This default may be overridden
+by the "label: <name>" script-header line. The option *--label* does not force
+*sfdisk* to create an empty disk label (see the *EMPTY DISK LABEL* section below).
 
 *-Y*, *--label-nested* _type_::
 Force editing of a nested disk label. The primary disk label has to exist already. This option allows editing for example a hybrid/protective MBR on devices with GPT.
diff --git a/login-utils/lslogins.1.adoc b/login-utils/lslogins.1.adoc
index debd87f5a..7a344a7f4 100644
--- a/login-utils/lslogins.1.adoc
+++ b/login-utils/lslogins.1.adoc
@@ -79,13 +79,17 @@ Display information related to login by password (see also *-afL*).
 Raw output (no columnation).
 
 *-s*, *--system-accs*::
-Show system accounts. These are by default all accounts with a UID between 101 and 999 (inclusive), with the exception of either nobody or nfsnobody (UID 65534). This hardcoded default may be overwritten by parameters *SYS_UID_MIN* and *SYS_UID_MAX* in the file _/etc/login.defs_.
+Show system accounts. These are by default all accounts with a UID between 101 and 999 (inclusive),
+with the exception of either nobody or nfsnobody (UID 65534). This hardcoded default may be
+overridden by the parameters *SYS_UID_MIN* and *SYS_UID_MAX* in the file _/etc/login.defs_.
 
 *--time-format* _type_::
 Display dates in short, full or iso format. The default is short, this time format is designed to be space efficient and human readable.
 
 *-u*, *--user-accs*::
-Show user accounts. These are by default all accounts with UID above 1000 (inclusive), with the exception of either nobody or nfsnobody (UID 65534). This hardcoded default maybe overwritten by parameters UID_MIN and UID_MAX in the file _/etc/login.defs_.
+Show user accounts. These are by default all accounts with a UID above 1000 (inclusive),
+with the exception of either nobody or nfsnobody (UID 65534). This hardcoded default may be
+overridden by the parameters *UID_MIN* and *UID_MAX* in the file _/etc/login.defs_.
 
 include::man-common/help-version.adoc[]
 
diff --git a/misc-utils/cal.1.adoc b/misc-utils/cal.1.adoc
index 9f1740620..43a9a3902 100644
--- a/misc-utils/cal.1.adoc
+++ b/misc-utils/cal.1.adoc
@@ -113,10 +113,10 @@ Display a calendar for the whole year.
 Display a calendar for the next twelve months.
 
 *-w*, *--week*[**=**_number_]::
-Display week numbers in the calendar according to the US or ISO-8601 format. If
-a _number_ is specified, the requested week will be printed in the desired or
-current year. The _number_ may be overwritten if _day_ and _month_ are also
-specified.
+Display week numbers in the calendar according to the US or ISO-8601 format.
+If a _number_ is specified, the requested week in the desired or current year
+will be printed and its number highlighted.
+The _number_ may be ignored if _month_ is also specified.
 +
 See the *NOTES* section for more details.
 
diff --git a/sys-utils/lscpu.1.adoc b/sys-utils/lscpu.1.adoc
index 940b1bfeb..795c3938b 100644
--- a/sys-utils/lscpu.1.adoc
+++ b/sys-utils/lscpu.1.adoc
@@ -18,7 +18,7 @@ lscpu - display information about the CPU architecture
 
 *lscpu* gathers CPU architecture information from _sysfs_, _/proc/cpuinfo_ and any applicable architecture-specific libraries (e.g. *librtas* on Powerpc). The command output can be optimized for parsing or for easy readability by humans. The information includes, for example, the number of CPUs, threads, cores, sockets, and Non-Uniform Memory Access (NUMA) nodes. There is also information about the CPU caches and cache sharing, family, model, bogoMIPS, byte order, and stepping.
 
-The default output formatting on terminal is subject to change and maybe optimized for better readability. The output for non-terminals (e.g., pipes) is never affected by this optimization and it is always in "Field: data\n" format. Use for example "*lscpu | less*" to see the default output without optimizations.
+The default output formatting on a terminal is subject to change and may be optimized for better readability. The output for non-terminals (e.g., pipes) is never affected by this optimization and it is always in "Field: data\n" format. Use for example "*lscpu | less*" to see the default output without optimizations.
 
 In virtualized environments, the CPU architecture information displayed reflects the configuration of the guest operating system which is typically different from the physical (host) system. On architectures that support retrieving physical topology information, *lscpu* also displays the number of physical sockets, chips, cores in the host system.
 
diff --git a/sys-utils/nsenter.1.adoc b/sys-utils/nsenter.1.adoc
index cb6419fda..c717d0ceb 100644
--- a/sys-utils/nsenter.1.adoc
+++ b/sys-utils/nsenter.1.adoc
@@ -51,7 +51,9 @@ Various of the options below that relate to namespaces take an optional _file_ a
 
 //TRANSLATORS: Keep {asterisk} untranslated.
 *-a*, *--all*::
-Enter all namespaces of the target process by the default _/proc/[pid]/ns/{asterisk}_ namespace paths. The default paths to the target process namespaces may be overwritten by namespace specific options (e.g., *--all --mount*=[_path_]).
+Enter all namespaces of the target process by the default _/proc/<pid>/ns/{asterisk}_
+namespace paths. The default paths to the target process namespaces may be overridden
+by namespace-specific options (e.g., **--all --mount=**_path_).
 +
 The user namespace will be ignored if the same as the caller's current user namespace. It prevents a caller that has dropped capabilities from regaining those capabilities via a call to setns(). See *setns*(2) for more details.
 
diff --git a/term-utils/agetty.8.adoc b/term-utils/agetty.8.adoc
index 988915865..a33f12a3f 100644
--- a/term-utils/agetty.8.adoc
+++ b/term-utils/agetty.8.adoc
@@ -237,7 +237,9 @@ Since version 2.35, additional locations for the issue file and directory are su
 
 Note that in versions 2.35 to 2.40, the additional locations were only read if the default _/etc/issue_ file did not exist. However, since version 2.41, the additional locations are always read, regardless of the existence of the _/etc/issue_ file. This change allows for the generation of issue files by default.
 
-The default paths maybe completely overridden by *--issue-file* option. In this case specified path has to be file or directory and all the default issue file and directory locations are ignored.
+The default paths may be completely overridden by the *--issue-file* option.
+In this case the specified path has to be a file or directory and
+all the default issue file and directory locations are ignored.
 
 The issue file feature can be completely disabled by *--noissue* option.
 
-- 
2.48.1

