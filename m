Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8FA257421
	for <util-linux@vger.kernel.org>; Thu, 24 Apr 2025 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745487264; cv=none; b=NlYlXg69nM55KglKwBU3oX/p1BcxzzP35X2S2g+F4r0w4hwbbsHXCjBGuGlFTRReMGnI5LMsvZt+pgfvw8kFTVLbwKDInhduaX0Kt7jy2qVcpIk5VGUiquPKl1o9POZOLLdd/CVxXcuQGqeQEz4bTYBdFZRi41aE2nYXBoOr2B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745487264; c=relaxed/simple;
	bh=DBFG+QlmfUznpy+igvD/qCJt8ON9KaPY3tUFiX/aPNQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URw86JIyMMiXavWue4wfdqrWbHEHJgWajcYw7ed/+UTgMz4QWl7EL32sd+trNJVthD86UWL9Y2IqvNhHuwCEZ+7PzpNdjY8VJIFRrGG5H5mfNQGHvhEt0tpsGz3Fey9J0WWSQ+8IDZmX2XS+9pSwHXnFKwTdf6qnPy2//ZE1cmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=v9y440sd; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="v9y440sd"
X-KPN-MessageId: 4b5f2165-20ef-11f0-b9a0-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 4b5f2165-20ef-11f0-b9a0-005056abbe64;
	Thu, 24 Apr 2025 11:34:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=apsEsyRF1vJbjuBJnkAnFLgMvZawIP/JgTssbzXGdxw=;
	b=v9y440sdQkL++EZcP3f6EE8OWdJatjLX1GZSzg+vKpFmKAXqBuvrtqESEox3SJpidk52DOCCTb0qF
	 AINsZlDxEqkYo5OeONPAksXFPpl14ZIEk0NtaSLpZRNVdOyNfVLd8ClFO8S7v7Y/sxKLBgv2wq+4mQ
	 KYMwxZRKUaQpeVvY=
X-KPN-MID: 33|nVgOevmx6Zbj5+5hg5j2Q22gs9cjm0zdmkWHl/43qBBtRVibx7ZQWSNpTatrFCo
 HnUVW76o8hf0qlR8k6O9Fk3V5gq6VBEfjs+IArYDssAA=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|7POYSqs03eYehS/1IAWG4J92IDVNHy2fzQph3+JkYYvBcew3zdGC+tsvcV7Ki6l
 JEOlg0tQZ0K5j87BS7tsBlQ==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 2415f465-20ef-11f0-95a4-005056abf0db;
	Thu, 24 Apr 2025 11:33:12 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/7] docs,usage: harmonize description of --hyperlink, and add 2 missing ones
Date: Thu, 24 Apr 2025 11:32:34 +0200
Message-ID: <20250424093237.6432-4-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250424093237.6432-1-bensberg@telfort.nl>
References: <20250424093237.6432-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also, consistently use _when_/<when> as the optional argument,
since the possible values are: "always", "never", "auto".

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 lsfd-cmd/lsfd.1.adoc      | 6 ++++--
 lsfd-cmd/lsfd.c           | 2 +-
 misc-utils/findmnt.8.adoc | 9 ++++-----
 misc-utils/findmnt.c      | 2 ++
 misc-utils/lsblk.8.adoc   | 6 ++++--
 misc-utils/lsblk.c        | 2 ++
 6 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/lsfd-cmd/lsfd.1.adoc b/lsfd-cmd/lsfd.1.adoc
index b0ba2ba53..db228a09e 100644
--- a/lsfd-cmd/lsfd.1.adoc
+++ b/lsfd-cmd/lsfd.1.adoc
@@ -110,8 +110,10 @@ only for *lsfd* developers.
 *--dump-counters*::
 Dump the definition of counters used in *--summary* output.
 
-*--hyperlink*[=_mode_]::
-Print paths as terminal hyperlinks. The _mode_ can be set to "always", "never", or "auto". The optional argument _when_ can be set to "auto", "never", or "always". If the _when_ argument is omitted, it will default to "auto". The "auto" setting means that hyperlinks will only be used if the output is on a terminal.
+*--hyperlink*[**=**_when_]::
+Print paths as terminal hyperlinks. The optional _when_ argument can be
+*always*, *never*, or *auto*. If the argument is omitted, it defaults to *auto*,
+which means that hyperlinks will only be used when the output goes to a terminal.
 
 *-H*, *--list-columns*::
 List the columns that can be specified with the *--output* option.
diff --git a/lsfd-cmd/lsfd.c b/lsfd-cmd/lsfd.c
index 3610de8dd..847a0ac8a 100644
--- a/lsfd-cmd/lsfd.c
+++ b/lsfd-cmd/lsfd.c
@@ -2196,7 +2196,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_("     --debug-filter           dump the internal data structure of filter and exit\n"), out);
 	fputs(_(" -C, --counter <name>:<expr>  define custom counter for --summary output\n"), out);
 	fputs(_("     --dump-counters          dump counter definitions\n"), out);
-	fputs(_("     --hyperlink[=<when>]     print paths as terminal hyperlinks (always|never|auto)\n"), out);
+	fputs(_("     --hyperlink[=<when>]     print paths as hyperlinks (always|never|auto)\n"), out);
 	fputs(_("     --summary[=<mode>]       print summary information (append|only|never)\n"), out);
 	fputs(_("     --_drop-privilege        (testing purpose) do setuid(1) just after starting\n"), out);
 
diff --git a/misc-utils/findmnt.8.adoc b/misc-utils/findmnt.8.adoc
index a26fb8ca2..025a311e9 100644
--- a/misc-utils/findmnt.8.adoc
+++ b/misc-utils/findmnt.8.adoc
@@ -67,11 +67,10 @@ Print the first matching filesystem only.
 List the columns that can be specified with the *--output* option.
 Can be used with *--json* or *--raw* to get the list in a machine-readable format.
 
-*--hyperlink*[**=**_mode_]::
-Print mountpoint paths as terminal hyperlinks. The optional _mode_ argument
-can be *always*, *never*, or *auto*. If the argument is omitted, it defaults
-to *auto*, which means that hyperlinks will only be used when the output goes
-to a terminal.
+*--hyperlink*[**=**_when_]::
+Print mountpoint paths as terminal hyperlinks. The optional _when_ argument can be
+*always*, *never*, or *auto*. If the argument is omitted, it defaults to *auto*,
+which means that hyperlinks will only be used when the output goes to a terminal.
 
 *-I*, *--dfi*::
 Imitate the output of *df*(1) with its *-i* option. This option is equivalent to *-o SOURCE,FSTYPE,INO.TOTAL,INO.USED,INO.AVAIL,INO.USE%,TARGET* but excludes all pseudo filesystems. Use *--all* to print all filesystems.
diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index 86258dfd3..862f00c63 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -1567,6 +1567,8 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -D, --df               imitate the output of df(1)\n"), out);
 	fputs(_(" -e, --evaluate         convert tags (LABEL,UUID,PARTUUID,PARTLABEL) \n"
 	        "                          to device names\n"), out);
+	fputs(_("     --hyperlink[=<when>]\n"
+		"                        print paths as hyperlinks (always|never|auto)\n"), out);
 	fputs(_(" -I, --dfi              imitate the output of df(1) with -i option\n"), out);
 	fputs(_(" -J, --json             use JSON output format\n"), out);
 	fputs(_(" -l, --list             use list format output\n"), out);
diff --git a/misc-utils/lsblk.8.adoc b/misc-utils/lsblk.8.adoc
index 8151525af..0e9734247 100644
--- a/misc-utils/lsblk.8.adoc
+++ b/misc-utils/lsblk.8.adoc
@@ -62,8 +62,10 @@ Exclude the devices specified by the comma-separated _list_ of major device numb
 *-f*, *--fs*::
 Output info about filesystems. This option is equivalent to *-o NAME,FSTYPE,FSVER,LABEL,UUID,FSAVAIL,FSUSE%,MOUNTPOINTS*. The authoritative information about filesystems and raids is provided by the *blkid*(8) command.
 
-*--hyperlink*[**=**_mode_]::
-Print mountpoint paths as terminal hyperlinks. The _mode_ can be set to "always", "never", or "auto". The optional argument _when_ can be set to "auto", "never", or "always". If the _when_ argument is omitted, it will default to "auto". The "auto" setting means that hyperlinks will only be used if the output is on a terminal.
+*--hyperlink*[**=**_when_]::
+Print mountpoint paths as terminal hyperlinks. The optional _when_ argument can be
+*always*, *never*, or *auto*. If the argument is omitted, it defaults to *auto*,
+which means that hyperlinks will only be used when the output goes to a terminal.
 
 *-I*, *--include* _list_::
 Include devices specified by the comma-separated _list_ of major device numbers. The filter is applied to the top-level devices only. This may be confusing for *--list* output format where hierarchy of the devices is not obvious.
diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 9f252d079..128217d62 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -2329,6 +2329,8 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -d, --nodeps         don't print slaves or holders\n"), out);
 	fputs(_(" -e, --exclude <list> exclude devices by major number (default: RAM disks)\n"), out);
 	fputs(_(" -f, --fs             output info about filesystems\n"), out);
+	fputs(_("     --hyperlink[=<when>]\n"
+		"                      print paths as hyperlinks (always|never|auto)\n"), out);
 	fputs(_(" -i, --ascii          use ascii characters only\n"), out);
 	fputs(_(" -l, --list           use list format output\n"), out);
 	fputs(_(" -m, --perms          output info about permissions\n"), out);
-- 
2.48.1

