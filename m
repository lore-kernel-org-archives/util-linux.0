Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0AD245028
	for <util-linux@vger.kernel.org>; Fri, 25 Apr 2025 10:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745577150; cv=none; b=UtybrkhUcRsukPaUyKtn7lgB2jzQYfJH6I/Z2JuiFdLKe4qjFJe4KUiV/+dkRRJPe+7MXENO4O7+FnbJ4kHyl2CUaSgni0lWJZAzm1jG6WukGG8UfiKH3uXcgDGDx+O4n91IAEmna+vkLcwtaBrZSEc1p0/w2nAC6R8f4WjlM88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745577150; c=relaxed/simple;
	bh=I/Q85oIvqFxrQuNFiR5X7Ug7unTVFJKxLHuScrjV2yo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=csW6kMXy0Dwx0Xt1ySGRA7vJnauf2F+3xvRX6DGXjRYpan3N2kndg4DvBKUV77r1n9rDxO9XrH7ert0G0CeQkdJ9lQho8nvD2qqJMINYxvucscjIwa599D2A0TKz+VZYs/EnPLP0HBog7qIHtMpB2jss8vu10cSsmX3WwQzjB6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=C6trBNiO; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="C6trBNiO"
X-KPN-MessageId: a8e48589-21c0-11f0-86cc-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id a8e48589-21c0-11f0-86cc-005056aba152;
	Fri, 25 Apr 2025 12:32:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=ZYH2Ow62qqR7zn6TVal1c5XR917EMseN/eoJKY7PrHE=;
	b=C6trBNiOkwoIErguRh1HO3jNo+A9JNN0FQUpdq9glJAEHr455em49mjgrMk/+Sk6Ir853jI38d62Z
	 A9EI9SGIE+LWfsIcxI/yA94fxwPcY9YMzClDFLVnShThj1Q4Su4EopJ5iuVcwBOyHJfxi9pBchNYOG
	 EK8RrQLsuqiLbfRk=
X-KPN-MID: 33|uhqWR6d9HQVZKIBwfgIVBQWdNbkUnOJUpWZVikPp7AO86isS7JuqqGEwnwVNBGi
 mdNQELv1mZKBAPCWnCrokhVQS36Cn5BgROh8XDEuV/YA=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Le5wc9ZvIdP9qev/pkQStAzuHOKdX+d9HoP1XoIi7EIIhC/uQQq+CEC5GAi36+I
 ULSZqOGbeWzAZfQffcfnK2g==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 8fd7231b-21c0-11f0-95a4-005056abf0db;
	Fri, 25 Apr 2025 12:32:18 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/7 V2] docs,usage: harmonize description of --hyperlink, and add 2 missing ones
Date: Fri, 25 Apr 2025 12:32:09 +0200
Message-ID: <20250425103209.11876-2-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250425103209.11876-1-bensberg@telfort.nl>
References: <20250425103209.11876-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Harmonize the description by placing the option in a separate file.

Also, use _when_/<when> (instead of _mode_/<mode>) as the optional
argument, since the possible values are: "always", "never", "auto".

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 lsfd-cmd/lsfd.1.adoc      | 3 +--
 lsfd-cmd/lsfd.c           | 2 +-
 man-common/hyperlink.adoc | 5 +++++
 man-common/meson.build    | 1 +
 misc-utils/findmnt.8.adoc | 6 +-----
 misc-utils/findmnt.c      | 2 ++
 misc-utils/lsblk.8.adoc   | 3 +--
 misc-utils/lsblk.c        | 2 ++
 8 files changed, 14 insertions(+), 10 deletions(-)
 create mode 100644 man-common/hyperlink.adoc

diff --git a/lsfd-cmd/lsfd.1.adoc b/lsfd-cmd/lsfd.1.adoc
index 2654e8eaf..9c4b8a0b5 100644
--- a/lsfd-cmd/lsfd.1.adoc
+++ b/lsfd-cmd/lsfd.1.adoc
@@ -109,8 +109,7 @@ only for *lsfd* developers.
 *--dump-counters*::
 Dump the definition of counters used in *--summary* output.
 
-*--hyperlink*[=_mode_]::
-Print paths as terminal hyperlinks. The _mode_ can be set to "always", "never", or "auto". The optional argument _when_ can be set to "auto", "never", or "always". If the _when_ argument is omitted, it will default to "auto". The "auto" setting means that hyperlinks will only be used if the output is on a terminal.
+include::man-common/hyperlink.adoc[]
 
 *-H*, *--list-columns*::
 List the columns that can be specified with the *--output* option.
diff --git a/lsfd-cmd/lsfd.c b/lsfd-cmd/lsfd.c
index 9e9cb52ac..d05a09396 100644
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
 
diff --git a/man-common/hyperlink.adoc b/man-common/hyperlink.adoc
new file mode 100644
index 000000000..476c4b2f3
--- /dev/null
+++ b/man-common/hyperlink.adoc
@@ -0,0 +1,5 @@
+*--hyperlink*[**=**_when_]::
+Print mountpoint paths as terminal hyperlinks. The optional _when_ argument
+can be *always*, *never*, or *auto*. If the argument is omitted, it defaults
+to *auto*, which means that hyperlinks will only be used when the output goes
+to a terminal.
diff --git a/man-common/meson.build b/man-common/meson.build
index 647f54c68..b9fc92730 100644
--- a/man-common/meson.build
+++ b/man-common/meson.build
@@ -5,6 +5,7 @@ man_common_adocs = files(
   'footer-config.adoc',
   'footer-lib.adoc',
   'help-version.adoc',
+  'hyperlink.adoc',
   'in-bytes.adoc',
   'manpage-stub.adoc',
   'translation.adoc',
diff --git a/misc-utils/findmnt.8.adoc b/misc-utils/findmnt.8.adoc
index a26fb8ca2..8c8ffa2cc 100644
--- a/misc-utils/findmnt.8.adoc
+++ b/misc-utils/findmnt.8.adoc
@@ -67,11 +67,7 @@ Print the first matching filesystem only.
 List the columns that can be specified with the *--output* option.
 Can be used with *--json* or *--raw* to get the list in a machine-readable format.
 
-*--hyperlink*[**=**_mode_]::
-Print mountpoint paths as terminal hyperlinks. The optional _mode_ argument
-can be *always*, *never*, or *auto*. If the argument is omitted, it defaults
-to *auto*, which means that hyperlinks will only be used when the output goes
-to a terminal.
+include::man-common/hyperlink.adoc[]
 
 *-I*, *--dfi*::
 Imitate the output of *df*(1) with its *-i* option. This option is equivalent to *-o SOURCE,FSTYPE,INO.TOTAL,INO.USED,INO.AVAIL,INO.USE%,TARGET* but excludes all pseudo filesystems. Use *--all* to print all filesystems.
diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index 2682de1d7..130ac1b13 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -1568,6 +1568,8 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -D, --df               imitate the output of df(1)\n"), out);
 	fputs(_(" -e, --evaluate         convert tags (LABEL,UUID,PARTUUID,PARTLABEL) \n"
 	        "                          to device names\n"), out);
+	fputs(_("     --hyperlink[=<when>]\n"
+		"                        print paths as hyperlinks (always|never|auto)\n"), out);
 	fputs(_(" -I, --dfi              imitate the output of df(1) with -i option\n"), out);
 	fputs(_(" -J, --json             use JSON output format\n"), out);
 	fputs(_(" -l, --list             use list format output\n"), out);
diff --git a/misc-utils/lsblk.8.adoc b/misc-utils/lsblk.8.adoc
index 8151525af..04efa276c 100644
--- a/misc-utils/lsblk.8.adoc
+++ b/misc-utils/lsblk.8.adoc
@@ -62,8 +62,7 @@ Exclude the devices specified by the comma-separated _list_ of major device numb
 *-f*, *--fs*::
 Output info about filesystems. This option is equivalent to *-o NAME,FSTYPE,FSVER,LABEL,UUID,FSAVAIL,FSUSE%,MOUNTPOINTS*. The authoritative information about filesystems and raids is provided by the *blkid*(8) command.
 
-*--hyperlink*[**=**_mode_]::
-Print mountpoint paths as terminal hyperlinks. The _mode_ can be set to "always", "never", or "auto". The optional argument _when_ can be set to "auto", "never", or "always". If the _when_ argument is omitted, it will default to "auto". The "auto" setting means that hyperlinks will only be used if the output is on a terminal.
+include::man-common/hyperlink.adoc[]
 
 *-I*, *--include* _list_::
 Include devices specified by the comma-separated _list_ of major device numbers. The filter is applied to the top-level devices only. This may be confusing for *--list* output format where hierarchy of the devices is not obvious.
diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 7daa7f58f..a65f5e4e6 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -2330,6 +2330,8 @@ static void __attribute__((__noreturn__)) usage(void)
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

