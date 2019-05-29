Return-Path: <SRS0=zfJU=T5=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BF9C28CC0
	for <util-linux@archiver.kernel.org>; Wed, 29 May 2019 22:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00832429E
	for <util-linux@archiver.kernel.org>; Wed, 29 May 2019 22:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfE2WaS (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 29 May 2019 18:30:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:35162 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726018AbfE2WaS (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 29 May 2019 18:30:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 609A7AF86
        for <util-linux@vger.kernel.org>; Wed, 29 May 2019 22:30:16 +0000 (UTC)
To:     util-linux@vger.kernel.org
Cc:     Frederic Crozat <fcrozat@suse.com>
From:   Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] raw: Add raw.service
Openpgp: preference=signencrypt
Autocrypt: addr=sbrabec@suse.cz; prefer-encrypt=mutual; keydata=
 mQGiBD6v2X0RBAD3rKn9S5s4iKX9KwKPIE1GCEG0qE1UomcIxYhey5oKEVoQoHtJkKvZpOVH
 zXNoPIMdwegZI++89UqY1jz6gI1pyBYRs4qmdnltXToO7NXdCr+LC5XNCStewoCE46gJIsb+
 8DpgK+wPoK/k1bF4HbnImTmkWaRLZKjaFsU4dR3+zwCgxqZXdZMiAYA+1mIjiGRZubOctQUE
 AIZ51+tT+FPkpR8ld+qjHNh1F42y0nCj4dL1oHjWpcq2tzuK+BHzpePsM4rM9ZeYqDSsZIFC
 5ol61NYmKaKDMRjwY5KK+tABm/ha+OCl4twcxtHCoLOcK1N/8/kqZ75x3/NLJwL/BRwaoE0Y
 NsD+BxCW0Rjbiztg2KwkdDWFcCVmBADc/Ka7mKdimHzY6XJ3gIHgFS9fa2rcxKaleajH+dXh
 SPRW8Qil2n/FaAdUIBWL/woF78BAgDfaOGt7Ize+pRVia0e6KD9aUBjRz3ZXmvG17xv83UmW
 ZRP0fpVqA28ou+NvjRNKJtd144OUeMLyEhy82YlkGPwn7r6WhaWo6UIpSLQsU3RhbmlzbGF2
 IEJyYWJlYyAoU3VTRSBDUikgPHNicmFiZWNAc3VzZS5jej6IXwQTEQIAHwQLBwMCAxUCAwMW
 AgECHgECF4AFAlHS/kkFCSE/csAACgkQcXwgn6BPzXZY/gCghbxE4uexFHVP7qho9TDNxGGR
 xxgAoKCipPrJQrnXKhFG4RDeRcVE0PoBuQENBD6v2YIQBACt62O2lXle2CPxw2LpdT557Rvr
 UdoYJ1AeLAn1iDy67rDsGumxJxW254x9CKVsU3609PG58gDKSQ7CvHzErtOdz9xsJLfCCxbk
 6LsOhBdCWgYs7HV2xYCkUvKSVQGZN95skfv1aSsO6dXzXISXen4KqY5AnFa+pXDAqMJTGLwp
 GwADBgQAkZ2/zz99L224sNcFgM+6TuGIQ57fNhKJxYG2HbBqh3oBiiZI9224dKLNCv/2aoV8
 qd9QUMKQCO7kQKkSH7+Ti1KnCyaDi3SoeFcsV4Z99Xb1bN2EBS1C4qohNUbouTsYEG5qsZPe
 uRDKekFTiilRRVyiXWDt+zY2aNNMknKBACeIRgQYEQIABgUCPq/ZggAKCRBxfCCfoE/Ndi+t
 AJ958OvQedgG0gsRG1wX/HKXmRZ0dwCfUk0F4qeP5dCiETIHh3gxNIsx8YQ=
Organization: SUSE Linux, s. r. o.
Message-ID: <f4c8feb9-2bdc-8a40-7bc1-d24fcd94d0a7@suse.cz>
Date:   Thu, 30 May 2019 00:30:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Add raw.service that allows to initialize raw devices on boot.

Author: Frederic Crozat <fcrozat@suse.com>
Author: Stanislav Brabec <sbrabec@suse.cz>
Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 configure.ac                 |  9 +++++++++
 disk-utils/.gitignore        |  3 +++
 disk-utils/Makemodule.am     |  9 ++++++++-
 disk-utils/raw.service.8.in  | 27 +++++++++++++++++++++++++++
 disk-utils/raw.service.in.in | 19 +++++++++++++++++++
 5 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 disk-utils/.gitignore
 create mode 100644 disk-utils/raw.service.8.in
 create mode 100644 disk-utils/raw.service.in.in

diff --git a/configure.ac b/configure.ac
index 4b6cacf88..fc7094cd9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -2209,6 +2209,14 @@ AS_IF([test "x$with_systemdsystemunitdir" != "xno"], [
   AC_SUBST([systemdsystemunitdir], [$with_systemdsystemunitdir])
 ])
 
+# Binaries needed by raw.service
+ac_save_PATH="$PATH"
+PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:$PATH"
+AC_PATH_PROG([MODPROBE], [modprobe], [/sbin/modprobe])
+AC_PATH_PROG([UDEVADM], [udevadm], [/sbin/udevadm])
+AC_SUBST([AT], [@])
+PATH="$ac_save_PATH"
+
 
 AC_ARG_WITH([smack],
   AS_HELP_STRING([--with-smack], [build with SMACK support]),
@@ -2428,6 +2436,7 @@ libmount/src/libmount.h
 libsmartcols/docs/Makefile
 libsmartcols/docs/version.xml
 libsmartcols/src/libsmartcols.h
+disk-utils/raw.service.in
 po/Makefile.in
 ])
 
diff --git a/disk-utils/.gitignore b/disk-utils/.gitignore
new file mode 100644
index 000000000..352d191f9
--- /dev/null
+++ b/disk-utils/.gitignore
@@ -0,0 +1,3 @@
+raw.service
+raw.service.8
+raw.service.in
diff --git a/disk-utils/Makemodule.am b/disk-utils/Makemodule.am
index bea0ed6a6..7121f3fd5 100644
--- a/disk-utils/Makemodule.am
+++ b/disk-utils/Makemodule.am
@@ -82,7 +82,7 @@ if BUILD_LIBUUID
 swaplabel_LDADD += libuuid.la
 swaplabel_CFLAGS += -I$(ul_libuuid_incdir)
 endif
-endif #BUILD_SWAPLABEL
+endif # BUILD_SWAPLABEL
 
 
 if BUILD_FSCK
@@ -98,7 +98,14 @@ if BUILD_RAW
 sbin_PROGRAMS += raw
 dist_man_MANS += disk-utils/raw.8
 raw_SOURCES = disk-utils/raw.c
+if HAVE_SYSTEMD
+systemdsystemunit_DATA += \
+		disk-utils/raw.service
+dist_man_MANS += disk-utils/raw.service.8
 endif
+endif # BUILD_RAW
+
+PATHFILES += disk-utils/raw.service disk-utils/raw.service.8
 
 
 if BUILD_CRAMFS
diff --git a/disk-utils/raw.service.8.in b/disk-utils/raw.service.8.in
new file mode 100644
index 000000000..56a4df702
--- /dev/null
+++ b/disk-utils/raw.service.8.in
@@ -0,0 +1,27 @@
+.TH RAW.SERVICE "util-linux" "System Administration"
+.SH NAME
+raw.service \- bind Linux raw character devices on boot
+.SH SYNOPSIS
+.B raw.service
+.SH DESCRIPTION
+.B raw.service
+is used to bind Linux raw character devices to a block devices on boot.
+.SH FILES
+.TP
+.I @sysconfdir@/raw
+List of raw devices to be initialized. Format of lines:
+.sp
+\fIraw_device\fR:\fIbind_device\fR
+.sp
+Devices are specified without leading \fI /dev/raw/\fR resp. \fI/dev/\fR.
+Lines starting with \fI#\fR are interpreted as comments.
+.SH SEE ALSO
+.BR raw (8)
+.SH AUTHORS
+.nf
+Frederic Crozat <fcrozat@suse.com>
+Stanislav Brabec <sbrabec@suse.cz>
+.fi
+.SH AVAILABILITY
+The raw command is part of the util-linux package and is available from
+https://www.kernel.org/pub/linux/utils/util-linux/.
diff --git a/disk-utils/raw.service.in.in b/disk-utils/raw.service.in.in
new file mode 100644
index 000000000..7f2ce865c
--- /dev/null
+++ b/disk-utils/raw.service.in.in
@@ -0,0 +1,19 @@
+[Unit]
+Description=Initialize raw devices
+After=local-fs.target remote-fs.target
+Documentation=man:raw.service(8)
+
+[Service]
+Type=oneshot
+RemainAfterExit=yes
+ExecStart=/bin/sh -c "\
+	@MODPROBE@ raw;\
+	@UDEVADM@ settle;\
+	for i in `grep -v ^# @AT@sysconfdir@AT@/raw`; do\
+		rawdev=`echo $i | cut -f1 -d:`;\
+		rawbind=`echo $i | cut -f2- -d:`;\
+		@AT@sbindir@AT@/raw /dev/raw/$rawdev /dev/$rawbind;\
+	done"
+
+[Install]
+WantedBy=multi-user.target
-- 
2.21.0

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Køi¾íkova 148/34 (Corso IIa)                    tel: +420 284 084 060
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
