Received: from cloudsdale.the-delta.net.eu.org (cloudsdale.the-delta.net.eu.org [138.201.117.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4203530E85D
	for <util-linux@vger.kernel.org>; Sat, 21 Jun 2025 23:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.201.117.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750548884; cv=none; b=rRY2r6M5CHuy+mhrdPIKP1gALgy0DPzIploZOmghE2k4tgFaeHX8t+aqRNpf4prn4/xUCO8QcFdaw8WKOIIGukKW7whuVndsBiGeSA6QGa6VcCFZmrEO7yfnvttFRr85OgTIBTcSn42ArapflYB/REDU+5Jwu4uyE+nZjA8Wbtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750548884; c=relaxed/simple;
	bh=3xbZbQ8hceOo9o7uWvG+4W058uX3QFZQ+RYlXQwZQNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VfsetzsGZds24YwY/pAF+PIYeEgptograXhFV2PzVHwBroTK28xgJ8u87U5cezYCYBON4CG/yDVkgk1oKpC2vq4lPWr2pIka6kasOxyoWNv2ueI97tfAnfdQAIwfdeM1fZpKE7oGzoZP/2VMdHpgEsNTeQTk+NFDdw6fepejwsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hacktivis.me; spf=pass smtp.mailfrom=hacktivis.me; arc=none smtp.client-ip=138.201.117.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hacktivis.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hacktivis.me
Received: 
	by cloudsdale.the-delta.net.eu.org (OpenSMTPD) with ESMTP id af9e830a;
	Sat, 21 Jun 2025 23:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=hacktivis.me; h=from:to
	:cc:date:message-id:mime-version:content-transfer-encoding; s=
	20241213_132553; bh=3xbZbQ8hceOo9o7uWvG+4W058uX3QFZQ+RYlXQwZQNA=; b=
	dOmTnjWcqBSOtcTxdcVIYrFHI855O8GhyHx/bQnDHJASc3TwAVPioUvB6Xz5BWhn
	BbKsd6EbeSZN3xGh+tG1sclEjchyAhnA1G0+mXAmMDApM999olxZ6s9gCXNK+Ufu
	CQ7Xi9o5ZgxWHX52dokFl/myNchhPDL63cTKOXaAJLrwTDLKQgqzTtNNh2iBewy3
	14xx7onp7G3sNBydWRrAJWVpHEPjXc5DEnZefo5GbdvQqGKsDmZuYwyIbFhV82bO
	ETgEapz1YigdkPYNZFJUrqZFqXPWMbblcTZFKqHt+TbGMoxPwKYkxgWiw7HEjxyJ
	iCL+NRT6b5i1jEX5iSMfUrRcwUmqY9F23hFyquuXy2AfUlh4/s1jM3PhAnIhVhyj
	GHx0OA6Y69CQrdajW+Q7ZW8POJoAywLaucdplRJ7+vxreo98A3wQJsHj2Azf6gKV
	m5nER+Y6237jphC8Zzh3b0tzygAL5uqSovg85gU2ywmMqlY+fwTLRagtzhHZ3Xuu
	JFXALfemgFBJKHm90fAMfYorB8GbMj8SirhLQFG2+3eyBg6Kh91u5s+VQns1G163
	CZ+Ip2q/73VGcYuK05U/6WeD63sFouBpSNfo18NSIYS/JuPM3pXrGCSz5gch7OCF
	dboPJu1nLaHZRvJUMyh8GfO6aWh/ffxPJijfyO2TBnk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=hacktivis.me; h=from:to:cc
	:date:message-id:mime-version:content-transfer-encoding; q=dns;
	 s=20241213_132553; b=JTU0hDTsLZBaoxQcUroJYdswY8VGxe6dQxmajwtacT
	Hc4r8tE2KXKL0YTIgXlv5OVR8MP00mTNMf2nBPJs/rO0nrpKHASpeJCqfynBlA2v
	lBjKOYHGFhOQu2+gVPL8J2HxyKvNYheirDxmdakConHxzOEZS0ka8bmzkxEQjEQt
	FEwiaaAiCsxZpXz71+KJhbZaDo91lHOLkHUWyu45+62xHPfWvhh5SQxfIjU12+LG
	q9FCzRTsch9lR2xV14i8rK1P1inWGnokuH4JliNbva7aE1K9cndj81U0y0N+2ZWn
	D0teN1uXaQvwANMRSpwof12wOlgvx2V1Q5mEK9OF79fHrq46sgejbN14ABTYECbt
	M4uBfr7yl2dn4POqg++IuCfOWg7EsMaZgPnxhDAEWFDGt2rEcG35GLdBE7xFVjuS
	QQgz+b7ZVw299TSY9dZXpKHdy4SfDoQBaMGybT44sFTrpoVtYv4vZ5n4AiHe+w4f
	3IayUovGyVjBJXro3hotrDXZjBtpyMOuD0QXaCcxifEQc9oYCK0NKsZsDmMqNejB
	tpio/ViAgzJQASj2Jv2BKHj2YsTmdHebsEVeGHHXMomIMmxmHvD6jieDqYoRVyft
	YjFZBpsoIIZW7M9rfywe57Up7s0TTuC0im+MMA3Z2i68lIu2mx6dzuabASWJc/ve
	s=
Received: from localhost (cloudsdale.the-delta.net.eu.org [local])
	by cloudsdale.the-delta.net.eu.org (OpenSMTPD) with ESMTPA id 25c1d243;
	Sat, 21 Jun 2025 23:27:54 +0000 (UTC)
From: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>
To: util-linux@vger.kernel.org
Cc: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>
Subject: [PATCH] rename: change "expression" to "original"
Date: Sun, 22 Jun 2025 01:26:43 +0200
Message-ID: <20250621232642.17613-2-contact@hacktivis.me>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As rename(1) doesn't uses an expression (like regex or glob) but rather a substring.
---
Note: Not on the mailing-list so CC me on replies

 misc-utils/rename.1.adoc | 12 ++++++------
 misc-utils/rename.c      |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/misc-utils/rename.1.adoc b/misc-utils/rename.1.adoc
index b8ea2bfdf..e5ba17e7a 100644
--- a/misc-utils/rename.1.adoc
+++ b/misc-utils/rename.1.adoc
@@ -20,11 +20,11 @@ rename - rename files
 
 == SYNOPSIS
 
-*rename* [options] _expression replacement file_...
+*rename* [options] _original replacement file_...
 
 == DESCRIPTION
 
-*rename* will rename the specified files by replacing the first occurrence of _expression_ in their name by _replacement_.
+*rename* will rename the specified files by replacing the first occurrence of the _original_ substring in their name by _replacement_.
 
 == OPTIONS
 
@@ -38,10 +38,10 @@ Show which files were renamed, if any.
 Do not make any changes; add *--verbose* to see what would be made.
 
 *-a*, *--all*::
-Replace all occurrences of _expression_ rather than only the first one.
+Replace all occurrences of _original_ rather than only the first one.
 
 *-l*, *--last*::
-Replace the last occurrence of _expression_ rather than the first one.
+Replace the last occurrence of _original_ rather than the first one.
 
 *-o*, *--no-overwrite*::
 Do not overwrite existing files. When *--symlink* is active, do not overwrite symlinks pointing to existing targets.
@@ -57,9 +57,9 @@ The renaming has no safeguards by default or without any one of the options *--n
 
 == EDGE CASES
 
-If the _expression_ is empty, then by default _replacement_ will be added to the start of the filename. With *--all*, _replacement_ will be inserted in between every two characters of the filename, as well as at the start and end.
+If the _original_ is empty, then by default _replacement_ will be added to the start of the filename. With *--all*, _replacement_ will be inserted in between every two characters of the filename, as well as at the start and end.
 
-Normally, only the final path component of a filename is updated. (Or with *--symlink*, only the final path component of the link.) But if either _expression_ or _replacement_ contains a _/_, the full path is updated. This can cause a file to be moved between folders. Creating folders, and moving files between filesystems, is not supported.
+Normally, only the final path component of a filename is updated. (Or with *--symlink*, only the final path component of the link.) But if either _original_ or _replacement_ contains a _/_, the full path is updated. This can cause a file to be moved between folders. Creating folders, and moving files between filesystems, is not supported.
 
 == INTERACTIVE MODE
 
diff --git a/misc-utils/rename.c b/misc-utils/rename.c
index bb2e3103d..5eb8f4429 100644
--- a/misc-utils/rename.c
+++ b/misc-utils/rename.c
@@ -251,7 +251,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	FILE *out = stdout;
 	fputs(USAGE_HEADER, out);
 	fprintf(out,
-	      _(" %s [options] <expression> <replacement> <file>...\n"),
+	      _(" %s [options] <original> <replacement> <file>...\n"),
 		program_invocation_short_name);
 
 	fputs(USAGE_SEPARATOR, out);

base-commit: c8e5b8a818323af30ec656f079c7feadaeeb13c3
-- 
2.49.0

