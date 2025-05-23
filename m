Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC76239585
	for <util-linux@vger.kernel.org>; Fri, 23 May 2025 12:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748001885; cv=none; b=DshHeCnZltj+GVZz357S8Fi70KaR+Rd8NYPuKHTQu1ZY0spAiVmgOIJDECWzOacw2lTY7WmRm5txRxkpPH39q73DqGUCsAMhdQhQXHFr77AhM5vgTi81KSyUg5nMpGzebZ+A/hzkSfI3ktit3GgHVir7agQA5V2pwhz5JPm8/hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748001885; c=relaxed/simple;
	bh=N1eXWLCh6HuQQQlWonvlIUxebV1q2iSsgqagKBHVO3c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vr9yM2TS1V2bywv5EJmW28cAJibRCPLEqb1ue/LFvJLEDHGg1dqshwk7gkKBORUbXZ21tNlJzOYlckG7CX6fOthyoduUDYdGBSt4UzIn9fP+gOIGobIsIOv62oo1uliyDwpiXkm5XD+zZpxvvLf70acqjN8jUMfXZdGUIFzSU1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=Du6yY69m; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="Du6yY69m"
X-KPN-MessageId: 3df7e833-37ce-11f0-bc2b-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 3df7e833-37ce-11f0-bc2b-005056ab378f;
	Fri, 23 May 2025 14:05:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=XzWlifeLJ9xlr5NGSAZehsEFNCDnuLV8mxoLHBCCJoI=;
	b=Du6yY69mzuQR2m0tR10qucsNbQisb93kxNVEsj8vgHYueM3iV7JIotkDdmFlMzdFYGInjRXlU8uZ7
	 o12ufeywvfe3cVrP8GQwPyuztMTDKDJy3Ka8VEerE0CnsLKY4PnpKVIJmk1yrtW+5J6qk1nBFosIGZ
	 iFP9BNZwMWWFG3bs=
X-KPN-MID: 33|yvvucndCEbX100URUErR9DW6JtFawFZaK2w6pux2nnH5hRszHAzPJavnkFhMEXo
 hBwWI8uIJ5qGI8P9dukjYXRvLx4ove+nEoeK5YN7B56s=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Igloby7bmW311oPQ672no4bFPzo+FTRH8DRVcCmei6RBIgFwcIEO1XJpasfzRJF
 ZXhVBKe6UQ1TLP+O7wxh/sg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 1b86e727-37ce-11f0-9bd3-005056ab1411;
	Fri, 23 May 2025 14:04:41 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/4] hardlink: (man,usage) sort the options mostly alphabetically
Date: Fri, 23 May 2025 14:04:07 +0200
Message-ID: <20250523120407.75188-4-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250523120407.75188-1-bensberg@telfort.nl>
References: <20250523120407.75188-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also, improve some markup and wording and grammar.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc-utils/hardlink.1.adoc | 55 +++++++++++++++++++-------------------
 misc-utils/hardlink.c      | 22 +++++++--------
 2 files changed, 39 insertions(+), 38 deletions(-)

diff --git a/misc-utils/hardlink.1.adoc b/misc-utils/hardlink.1.adoc
index e09572f6c..5788014d2 100644
--- a/misc-utils/hardlink.1.adoc
+++ b/misc-utils/hardlink.1.adoc
@@ -65,21 +65,21 @@ For example, *hardlink foo/ bar/* will link files in bar/ to equal files in the
 *-i*, *--include* _regex_::
 A regular expression to include files. If the option *--exclude* has been given, this option re-includes files which would otherwise be excluded. If the option is used without *--exclude*, only files matched by the pattern are included.
 
+*-l*, *--list-duplicates*::
+Don't link anything, but list the absolute path of every duplicate file, one per line, preceded by a unique 16-byte discriminator and a tab.
+
 *-m*, *--maximize*::
 Among equal files, keep the file with the highest link count.
 
 *-M*, *--minimize*::
 Among equal files, keep the file with the lowest link count.
 
+*--mount*::
+Do not traverse directories on different filesystems (remain within the same filesystem).
+
 *-n*, *--dry-run*::
 Do not act, just print what would happen.
 
-*-l*, *--list-duplicates*::
-Don't link anything, but list the absolute path of every duplicate file, one per line, preceded by a unique 16-byte discriminator and a tab.
-
-*-z*, *--zero*::
-Separate lines with a NUL instead of a newline in *-l* mode.
-
 *-o*, *--ignore-owner*::
 Link and compare files even if their owner information (user and group) differs. Results may be unpredictable.
 
@@ -98,6 +98,22 @@ file content block (see *--io-size*), these checksums are cached for the next co
 size is important for large files or a large sets of files of the same size. The default is
 10MiB.
 
+*--reflink*[**=**_when_]::
+Create copy-on-write clones (aka reflinks) rather than hardlinks. The reflinked files
+share only on-disk data, but the file mode and owner can be different. It's recommended
+to use this option together with the *--ignore-owner* and *--ignore-mode* options.
+This option implies *--skip-reflinks* to ignore already cloned files.
++
+The optional argument _when_ can be *never*, *always*, or *auto*. If the _when_ argument
+is omitted, it defaults to *auto*, which means that *hardlink* checks the filesystem type
+and uses reflinks on BTRFS and XFS only, and falls back to hardlinks when creating a
+reflink is impossible.
+The argument *always* disables filesystem-type detection and the fallback to hardlinks,
+which means that only reflinks are allowed.
+
+*--skip-reflinks*::
+Ignore already cloned files. This option may be used without *--reflink* when creating classic hardlinks.
+
 *-s*, *--minimum-size* _size_::
 The minimum size to consider. By default this is 1, so empty files will not be linked. The _size_ argument may be followed by the multiplicative suffixes KiB (=1024), MiB (=1024*1024), and so on for GiB, TiB, PiB, EiB, ZiB and YiB (the "iB" is optional, e.g., "K" has the same meaning as "KiB").
 
@@ -116,33 +132,18 @@ A regular expression that excludes files from being compared and linked. This op
 *--exclude-subtree* _regex_::
 A regular expression that excludes entire directories from being compared and linked. This option can also be used multiple times.
 
-*--mount*::
-Do not traverse directories on different filesystems (remain within the same filesystem).
-
 *-X*, *--respect-xattrs*::
 Only try to link files with the same extended attributes.
 
 *-y*, *--method* _name_::
 Set the file content comparison method. The currently supported methods are
-sha256, sha1, crc32c and memcmp. The default is sha256, or memcmp if Linux
-Crypto API is not available. The methods based on checksums are implemented in
-zero-copy way, in this case file contents are not copied to the userspace and all
-calculation is done in kernel.
+*sha256*, *sha1*, *crc32c*, and *memcmp*. The default is *sha256*, or *memcmp* if the
+Linux Crypto API is not available. The methods based on checksums are implemented in
+a zero-copy way, which means that file contents are not copied to userspace and all
+calculation is done in the kernel.
 
-*--reflink*[**=**_when_]::
-Create copy-on-write clones (aka reflinks) rather than hardlinks. The reflinked files
-share only on-disk data, but the file mode and owner can be different. It's recommended
-to use it with *--ignore-owner* and *--ignore-mode* options. This option implies
-*--skip-reflinks* to ignore already cloned files.
-+
-The optional argument _when_ can be *never*, *always*, or *auto*. If the _when_ argument
-is omitted, it defaults to *auto*, in this case, *hardlink* checks filesystem type and
-uses reflinks on BTRFS and XFS only, and fallback to hardlinks when creating reflink is impossible.
-The argument *always* disables filesystem type detection and fallback to hardlinks, in this case,
-only reflinks are allowed.
-
-*--skip-reflinks*::
-Ignore already cloned files. This option may be used without *--reflink* when creating classic hardlinks.
+*-z*, *--zero*::
+Separate lines with a NUL byte instead of a newline (for *-l*).
 
 include::man-common/help-version.adoc[]
 
diff --git a/misc-utils/hardlink.c b/misc-utils/hardlink.c
index 5365e5370..cd28fe018 100644
--- a/misc-utils/hardlink.c
+++ b/misc-utils/hardlink.c
@@ -1191,24 +1191,28 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -c, --content              compare only file contents, same as -pot\n"), out);
 	fputs(_(" -b, --io-size <size>       I/O buffer size for file reading\n"
-	        "                              (speedup, using more RAM)\n"), out);
+		"                              (speedup, using more RAM)\n"), out);
 	fputs(_(" -d, --respect-dir          directory names have to be identical\n"), out);
 	fputs(_(" -f, --respect-name         filenames have to be identical\n"), out);
+	fputs(_(" -F, --prioritize-trees     files found in the earliest specified top-level\n"
+		"                              directory have higher priority (but this has\n"
+		"                              lower precedence than --maximize/--minimize)\n"), out);
 	fputs(_(" -i, --include <regex>      regular expression to include files/dirs\n"), out);
+	fputs(_(" -l, --list-duplicates      just list paths of duplicates, don't link them\n"), out);
 	fputs(_(" -m, --maximize             keep the file with the most links\n"), out);
 	fputs(_(" -M, --minimize             keep the file with the fewest links\n"), out);
+	fputs(_("     --mount                stay within the same filesystem\n"), out);
 	fputs(_(" -n, --dry-run              don't actually link anything\n"), out);
-	fputs(_(" -l, --list-duplicates      just list paths of duplicates, don't link them\n"), out);
-	fputs(_(" -z, --zero                 delimit output with NULs instead of newlines\n"), out);
 	fputs(_(" -o, --ignore-owner         ignore owner changes\n"), out);
-	fputs(_(" -F, --prioritize-trees     files found in the earliest specified top-level\n"
-                "                              directory have higher priority (lower precedence\n"
-		"                              than minimize/maximize)\n"), out);
 	fputs(_(" -O, --keep-oldest          keep the oldest file of multiple equal files\n"
 		"                              (lower precedence than minimize/maximize)\n"), out);
 	fputs(_(" -p, --ignore-mode          ignore changes of file mode\n"), out);
 	fputs(_(" -q, --quiet                quiet mode - don't print anything\n"), out);
 	fputs(_(" -r, --cache-size <size>    memory limit for cached file content data\n"), out);
+#ifdef USE_REFLINK
+	fputs(_("     --reflink[=<when>]     create clone/CoW copies (auto, always, never)\n"), out);
+	fputs(_("     --skip-reflinks        skip already cloned files (enabled on --reflink)\n"), out);
+#endif
 	fputs(_(" -s, --minimum-size <size>  minimum size for files\n"), out);
 	fputs(_(" -S, --maximum-size <size>  maximum size for files\n"), out);
 	fputs(_(" -t, --ignore-time          ignore timestamps (when testing for equality)\n"), out);
@@ -1217,16 +1221,12 @@ static void __attribute__((__noreturn__)) usage(void)
 #ifdef USE_SKIP_SUBTREE
 	fputs(_("     --exclude-subtree <regex>  regular expression to exclude directories\n"), out);
 #endif
-	fputs(_("     --mount                stay within the same filesystem\n"), out);
 #ifdef USE_XATTR
 	fputs(_(" -X, --respect-xattrs       respect extended attributes\n"), out);
 #endif
 	fputs(_(" -y, --method <name>        file content comparison method\n"), out);
+	fputs(_(" -z, --zero                 delimit output with NULs instead of newlines\n"), out);
 
-#ifdef USE_REFLINK
-	fputs(_("     --reflink[=<when>]     create clone/CoW copies (auto, always, never)\n"), out);
-	fputs(_("     --skip-reflinks        skip already cloned files (enabled on --reflink)\n"), out);
-#endif
 	fputs(USAGE_SEPARATOR, out);
 	fprintf(out, USAGE_HELP_OPTIONS(28));
 	fprintf(out, USAGE_MAN_TAIL("hardlink(1)"));
-- 
2.48.1

