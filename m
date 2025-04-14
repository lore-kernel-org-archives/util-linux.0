Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C238E17A314
	for <util-linux@vger.kernel.org>; Mon, 14 Apr 2025 09:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744623960; cv=none; b=N/w3FrMR/JELZdfMtmKQyh1WmcxP73JrIFAL8WW2rnpyLrTcNHeq6mooiytbfInQNuqvLjIop4MaaVLawTuj9dYNX8qXiYcevADnxWYG9pJB9k4/WuDtuYN4/JNvfnnz8/oIOTnnYY4GJtSdRjji5VHP8zgZXOY44y9Wdz0bkiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744623960; c=relaxed/simple;
	bh=qv8F4omKuLejC04V0+rQ08aTxYdPVxMNANILDQXw6rc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bz2yKEgZWLbq4uGFRY2rPj2N3zW/KBaEj1pBctN13xjnGphj/7lPwlm6+D+e7a5Sy3zNxu41MeoQ1pdDuLBPcmouCEnMfHv41k95K2EwnHs91BbihnDqDoGr40Appv+7TQ3T7uPrpfni6VQvnkVUvkbsGGgNNTqnI6DOtC7EAe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=mBk86hky; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="mBk86hky"
X-KPN-MessageId: 5c07adc2-1915-11f0-bc28-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 5c07adc2-1915-11f0-bc28-005056ab378f;
	Mon, 14 Apr 2025 11:46:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=hPKjYtLToTZiRnvfWci+bkghJ7oZNGTX9lT4hDp8mXY=;
	b=mBk86hkyX1hFXIGolvmEqyYKDFFx+dYr3YkWLIWkm8hRD+CJs0dmpISfEdnlCD5KrxNIB6AoKj6Ui
	 EpFI5BH4u/gFksVKAla8M/TuX3tfiRHvEjp5oQrK0pbDDS/ePV/oNGGCYbhniM6ymEViCsR0gtfB/R
	 cibyrSnxLSzRGLbw=
X-KPN-MID: 33|nokKdFAKzsVdMeeYkwmsBz9QfCpc7DvNd7GyuvrtVOH2mVZVrQNx3t2qNpyWtNA
 l5w8JoMj7oL6Y+mtjm1asdxrK1+V9XRh+/ms8+9VP6pk=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|jr7A3qUhgwav80qsNhPMLFRpDBsHzZAgG8UWZ13/wty0CfX7oUJXUmMeEPcwsV8
 cPEreg677fg9YGQDNKrCbjg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 41ab113c-1915-11f0-959e-005056abf0db;
	Mon, 14 Apr 2025 11:45:53 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/8] docs: improve and harmonize the description of -H / --list-columns
Date: Mon, 14 Apr 2025 11:45:28 +0200
Message-ID: <20250414094534.9504-2-bensberg@telfort.nl>
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

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 lsfd-cmd/lsfd.1.adoc      | 3 ++-
 misc-utils/findmnt.8.adoc | 3 ++-
 misc-utils/lsblk.8.adoc   | 3 ++-
 misc-utils/lslocks.8.adoc | 3 ++-
 sys-utils/lsns.8.adoc     | 3 ++-
 5 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/lsfd-cmd/lsfd.1.adoc b/lsfd-cmd/lsfd.1.adoc
index d1a78f105..b0ba2ba53 100644
--- a/lsfd-cmd/lsfd.1.adoc
+++ b/lsfd-cmd/lsfd.1.adoc
@@ -114,7 +114,8 @@ Dump the definition of counters used in *--summary* output.
 Print paths as terminal hyperlinks. The _mode_ can be set to "always", "never", or "auto". The optional argument _when_ can be set to "auto", "never", or "always". If the _when_ argument is omitted, it will default to "auto". The "auto" setting means that hyperlinks will only be used if the output is on a terminal.
 
 *-H*, *--list-columns*::
-List available columns that you can specify at *--output* option.
+List the columns that can be specified with the *--output* option.
+Can be used with *--json* or *--raw* to get the list in a machine-readable format.
 
 include::man-common/help-version.adoc[]
 
diff --git a/misc-utils/findmnt.8.adoc b/misc-utils/findmnt.8.adoc
index 9ac9316e3..a26fb8ca2 100644
--- a/misc-utils/findmnt.8.adoc
+++ b/misc-utils/findmnt.8.adoc
@@ -64,7 +64,8 @@ Search in an alternative file. If used with *--fstab*, *--mtab* or *--kernel*, t
 Print the first matching filesystem only.
 
 *-H*, *--list-columns*::
-List the available columns, use with *--json* or *--raw* to get output in machine-readable format.
+List the columns that can be specified with the *--output* option.
+Can be used with *--json* or *--raw* to get the list in a machine-readable format.
 
 *--hyperlink*[**=**_mode_]::
 Print mountpoint paths as terminal hyperlinks. The optional _mode_ argument
diff --git a/misc-utils/lsblk.8.adoc b/misc-utils/lsblk.8.adoc
index 742fe5f68..8151525af 100644
--- a/misc-utils/lsblk.8.adoc
+++ b/misc-utils/lsblk.8.adoc
@@ -42,7 +42,8 @@ Disable all built-in filters and list all empty devices and RAM disk devices too
 include::man-common/in-bytes.adoc[]
 
 *-H*, *--list-columns*::
-List the available columns, use with *--json* or *--raw* to get output in machine-readable format.
+List the columns that can be specified with the *--output* option.
+Can be used with *--json* or *--raw* to get the list in a machine-readable format.
 
 *-D*, *--discard*::
 Print information about the discarding capabilities (TRIM, UNMAP) for each device.
diff --git a/misc-utils/lslocks.8.adoc b/misc-utils/lslocks.8.adoc
index 2084d96c0..2395d86fb 100644
--- a/misc-utils/lslocks.8.adoc
+++ b/misc-utils/lslocks.8.adoc
@@ -35,7 +35,8 @@ lslocks - list local system locks
 include::man-common/in-bytes.adoc[]
 
 *-H*, *--list-columns*::
-List the available columns, use with *--json* or *--raw* to get output in machine-readable format.
+List the columns that can be specified with the *--output* option.
+Can be used with *--json* or *--raw* to get the list in a machine-readable format.
 
 *-i*, *--noinaccessible*::
 Ignore lock files which are inaccessible for the current user.
diff --git a/sys-utils/lsns.8.adoc b/sys-utils/lsns.8.adoc
index 88c2b848f..3cbe3504e 100644
--- a/sys-utils/lsns.8.adoc
+++ b/sys-utils/lsns.8.adoc
@@ -32,7 +32,8 @@ Note that *lsns* reads information directly from the _/proc_ filesystem and for
 == OPTIONS
 
 *-H*, *--list-columns*::
-List the available columns, use with *--json* or *--raw* to get output in machine-readable format.
+List the columns that can be specified with the *--output* option.
+Can be used with *--json* or *--raw* to get the list in a machine-readable format.
 
 *-J*, *--json*::
 Use JSON output format.
-- 
2.48.1

