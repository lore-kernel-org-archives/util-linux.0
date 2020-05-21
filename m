Return-Path: <SRS0=+NO+=7D=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02098C433E1
	for <util-linux@archiver.kernel.org>; Thu, 21 May 2020 07:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C07FC20738
	for <util-linux@archiver.kernel.org>; Thu, 21 May 2020 07:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRX/mI+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgEUH2c (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 21 May 2020 03:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728476AbgEUH21 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 21 May 2020 03:28:27 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B35AC061A0E
        for <util-linux@vger.kernel.org>; Thu, 21 May 2020 00:28:27 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a2so7591023ejb.10
        for <util-linux@vger.kernel.org>; Thu, 21 May 2020 00:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=jLJMKqn7mKR+hY+VHK2jTv45xgM3LFcB2NRvVZLK/dQ=;
        b=LRX/mI+GbS2PWEoj73ewBq33dcOFsU+VFIzcn1sr9G0TUWochYOqUdNrK0H7iukkbZ
         FBYACIH0gWYE3dicdc6X1+pK/Fz6cor4S31KVvy+KPpk6s4yU9Bc9DlEcixY0vY9wFnh
         UCZ5eF2k4Yzl1EBGkZnSDS9Z4Gm67SQpe6M74dCeXj42+2UTycEQAPF16lW+Orkf4Oqb
         j8tbqDB6otujLmHg0Lfgg5C+TK3VT04bevNyAUTiFwK9HQFiS6suSI5Mf/2SaeGkQiK5
         OKIHkaI18lB9ElD/JtOai2dqF8fH9tPUC9E3cvgizkv4byLkEnQzDfotunNnmlYegkFL
         rj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=jLJMKqn7mKR+hY+VHK2jTv45xgM3LFcB2NRvVZLK/dQ=;
        b=j3oP4msjafQlRew5+g1V041xmXEbeaWCpbjRNeUD5xsyqxaMCyN48LDh7fl/PTTn/A
         GwXeNfeUGHO57qOTViK3rAjI5scSqC+WpRCQiNeNWocmQF4UQ4rCpkNvBZ2Ad/nkqEhl
         MBjL0NQQBS9mGf12eNQRicngguMz1lJ6SafrHAs073+eS2EQIDqWlpB91gm3UuAkAcVv
         xJvt9h3Pspxrxh9BePc90BMOmeGrhUPmuLy/qTxYsFtX+g5Y29gFxKzsXWFWIVbvK7m8
         Iq/e8r1pVaIQYa/yyb0SnXZ1gH7vEVjVkxIkggNrNv1JLgUuphfkuUyHCAXzAAFkw8G5
         8G4Q==
X-Gm-Message-State: AOAM531qzXM5xhwTyHu5hx8B8n8ueamHcu3ru5cT5v1qYtW2xvtVJoci
        Bl1Og0RSuIvMcTMKFnadWy4RJM5WnOI=
X-Google-Smtp-Source: ABdhPJyoo2FswXLBrkuTB77wV8ohrfQJk2aP8ocVkNPMQzD4qXYn/wUuiSsto08NZqSt2dSHhUP/Sw==
X-Received: by 2002:a17:906:600a:: with SMTP id o10mr2471734ejj.544.1590046102637;
        Thu, 21 May 2020 00:28:22 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id gx25sm4016806ejb.63.2020.05.21.00.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 00:28:22 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, util-linux@vger.kernel.org
To:     Karel Zak <kzak@redhat.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: [PATCH 1/4] Manual pages: order AUTHORS / COPYRIGHT / SEE ALSO /
 AVAILABILITY consistently
Message-ID: <265058f0-3091-4f7f-1853-59f634210c33@gmail.com>
Date:   Thu, 21 May 2020 09:28:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


There is value in ensuring that manual page sections use consistently
named sections, as far as possible, and also that sections have a
consistent order within manual pages. This is one of a series of patches
to place manual page sections in a consistent order.

In this patch, we ensure that the AUTHORS, COPYRIGHT, SEE ALSO, and
AVAILABILITY sections are always placed at the end of the page.

Testing that no gross editing mistake (causing accidental loss or addition
of text) was performed as follows:

    $ cat $(grep '\.SH' -l $(find . -name '*.[1-9]') |sort) | sort > a
    [Apply patch]
    $ cat $(grep '\.SH' -l $(find . -name '*.[1-9]') |sort) | sort > b
    $ diff a b
    $ echo $?
    0

Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
---
 disk-utils/cfdisk.8         | 12 ++++++------
 disk-utils/fdformat.8       |  4 ++--
 disk-utils/fdisk.8          | 24 ++++++++++++------------
 disk-utils/fsck.8           | 10 +++++-----
 disk-utils/partx.8          | 18 +++++++++---------
 disk-utils/sfdisk.8         | 12 ++++++------
 disk-utils/swaplabel.8      | 12 ++++++------
 libuuid/man/uuid.3          |  8 ++++----
 libuuid/man/uuid_clear.3    | 10 +++++-----
 libuuid/man/uuid_compare.3  | 10 +++++-----
 libuuid/man/uuid_copy.3     | 10 +++++-----
 libuuid/man/uuid_generate.3 |  8 ++++----
 libuuid/man/uuid_is_null.3  | 10 +++++-----
 libuuid/man/uuid_parse.3    | 10 +++++-----
 libuuid/man/uuid_time.3     | 10 +++++-----
 libuuid/man/uuid_unparse.3  | 10 +++++-----
 login-utils/chfn.1          |  4 ++--
 login-utils/chsh.1          |  4 ++--
 login-utils/last.1          | 10 +++++-----
 login-utils/login.1         | 16 ++++++++--------
 login-utils/lslogins.1      |  4 ++--
 login-utils/newgrp.1        |  8 ++++----
 login-utils/nologin.8       |  8 ++++----
 login-utils/runuser.1       |  8 ++++----
 login-utils/su.1            |  8 ++++----
 login-utils/vipw.8          | 10 +++++-----
 misc-utils/blkid.8          |  4 ++--
 misc-utils/findfs.8         |  6 +++---
 misc-utils/hardlink.1       | 12 ++++++------
 misc-utils/kill.1           | 16 ++++++++--------
 misc-utils/logger.1         |  8 ++++----
 misc-utils/look.1           |  6 +++---
 misc-utils/lsblk.8          | 10 +++++-----
 misc-utils/namei.1          |  4 ++--
 misc-utils/wipefs.8         |  6 +++---
 schedutils/chrt.1           | 16 ++++++++--------
 schedutils/taskset.1        | 12 ++++++------
 sys-utils/ctrlaltdel.8      |  6 +++---
 sys-utils/dmesg.1           |  6 +++---
 sys-utils/fsfreeze.8        |  6 +++---
 sys-utils/fstab.5           | 10 +++++-----
 sys-utils/ipcmk.1           |  6 +++---
 sys-utils/ipcs.1            | 20 ++++++++++----------
 sys-utils/ldattach.8        |  6 +++---
 sys-utils/lsipc.1           | 20 ++++++++++----------
 sys-utils/mount.8           | 36 ++++++++++++++++++------------------
 sys-utils/mountpoint.1      |  6 +++---
 sys-utils/nsenter.1         |  8 ++++----
 sys-utils/prlimit.1         |  8 ++++----
 sys-utils/renice.1          |  8 ++++----
 sys-utils/setpriv.1         |  8 ++++----
 sys-utils/setsid.1          |  4 ++--
 sys-utils/swapon.8          | 18 +++++++++---------
 sys-utils/switch_root.8     | 10 +++++-----
 sys-utils/umount.8          |  8 ++++----
 sys-utils/unshare.1         | 10 +++++-----
 sys-utils/zramctl.8         |  8 ++++----
 term-utils/mesg.1           | 10 +++++-----
 term-utils/script.1         | 14 +++++++-------
 term-utils/scriptlive.1     | 14 +++++++-------
 term-utils/scriptreplay.1   | 26 +++++++++++++-------------
 term-utils/setterm.1        |  4 ++--
 term-utils/wall.1           |  8 ++++----
 term-utils/write.1          |  8 ++++----
 text-utils/col.1            |  8 ++++----
 text-utils/colcrt.1         | 12 ++++++------
 text-utils/colrm.1          |  8 ++++----
 text-utils/column.1         |  4 ++--
 text-utils/more.1           | 18 +++++++++---------
 text-utils/pg.1             | 16 ++++++++--------
 text-utils/ul.1             | 14 +++++++-------
 71 files changed, 367 insertions(+), 367 deletions(-)

diff --git a/disk-utils/cfdisk.8 b/disk-utils/cfdisk.8
index 231a877c6..902861a5b 100644
--- a/disk-utils/cfdisk.8
+++ b/disk-utils/cfdisk.8
@@ -187,18 +187,18 @@ enables libsmartcols debug output.
 .IP LIBSMARTCOLS_DEBUG_PADDING=on
 use visible padding characters. Requires enabled LIBSMARTCOLS_DEBUG.
 
-.SH SEE ALSO
-.BR fdisk (8),
-.BR parted (8),
-.BR partprobe (8),
-.BR partx (8),
-.BR sfdisk (8)
 .SH AUTHORS
 Karel Zak <kzak@redhat.com>
 .PP
 The current cfdisk implementation is based on the original cfdisk
 from Kevin E. Martin (martin@cs.unc.edu).
 
+.SH SEE ALSO
+.BR fdisk (8),
+.BR parted (8),
+.BR partprobe (8),
+.BR partx (8),
+.BR sfdisk (8)
 .SH AVAILABILITY
 The cfdisk command is part of the util-linux package and is available from
 https://www.kernel.org/pub/linux/utils/util-linux/.
diff --git a/disk-utils/fdformat.8 b/disk-utils/fdformat.8
index 97c67a01a..44b494dbb 100644
--- a/disk-utils/fdformat.8
+++ b/disk-utils/fdformat.8
@@ -62,13 +62,13 @@ Display version information and exit.
 .TP
 \fB\-h\fR, \fB\-\-help\fR
 Display help text and exit.
+.SH AUTHORS
+Werner Almesberger (almesber@nessie.cs.id.ethz.ch)
 .SH SEE ALSO
 .BR fd (4),
 .BR emkfs (8),
 .BR mkfs (8),
 .BR setfdprm (8)
-.SH AUTHORS
-Werner Almesberger (almesber@nessie.cs.id.ethz.ch)
 .SH AVAILABILITY
 The fdformat command is part of the util-linux package and is available from
 https://www.kernel.org/pub/linux/utils/util-linux/.
diff --git a/disk-utils/fdisk.8 b/disk-utils/fdisk.8
index 93a7d7ac7..bb6e0588b 100644
--- a/disk-utils/fdisk.8
+++ b/disk-utils/fdisk.8
@@ -346,6 +346,18 @@ The warning messages.
 .B welcome
 The welcome message.
 
+.SH ENVIRONMENT
+.IP FDISK_DEBUG=all
+enables fdisk debug output.
+.IP LIBFDISK_DEBUG=all
+enables libfdisk debug output.
+.IP LIBBLKID_DEBUG=all
+enables libblkid debug output.
+.IP LIBSMARTCOLS_DEBUG=all
+enables libsmartcols debug output.
+.IP LIBSMARTCOLS_DEBUG_PADDING=on
+use visible padding characters. Requires enabled LIBSMARTCOLS_DEBUG.
+
 .SH AUTHORS
 .MT kzak@redhat.com
 Karel Zak
@@ -359,18 +371,6 @@ Davidlohr Bueso
 The original version was written by
 Andries E. Brouwer, A. V. Le Blanc and others.
 
-.SH ENVIRONMENT
-.IP FDISK_DEBUG=all
-enables fdisk debug output.
-.IP LIBFDISK_DEBUG=all
-enables libfdisk debug output.
-.IP LIBBLKID_DEBUG=all
-enables libblkid debug output.
-.IP LIBSMARTCOLS_DEBUG=all
-enables libsmartcols debug output.
-.IP LIBSMARTCOLS_DEBUG_PADDING=on
-use visible padding characters. Requires enabled LIBSMARTCOLS_DEBUG.
-
 .SH SEE ALSO
 .BR cfdisk (8),
 .BR mkfs (8),
diff --git a/disk-utils/fsck.8 b/disk-utils/fsck.8
index e9eec2851..012c51f6e 100644
--- a/disk-utils/fsck.8
+++ b/disk-utils/fsck.8
@@ -388,6 +388,11 @@ enables libblkid debug output.
 .TP
 .B LIBMOUNT_DEBUG=all
 enables libmount debug output.
+.SH AUTHORS
+.nf
+Theodore Ts'o <tytso@mit.edu>
+Karel Zak <kzak@redhat.com>
+.fi
 .SH SEE ALSO
 .na
 .BR fstab (5),
@@ -406,11 +411,6 @@ or
 .BR fsck.xfs (8),
 .BR reiserfsck (8)
 .ad
-.SH AUTHORS
-.nf
-Theodore Ts'o <tytso@mit.edu>
-Karel Zak <kzak@redhat.com>
-.fi
 .SH AVAILABILITY
 The fsck command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
diff --git a/disk-utils/partx.8 b/disk-utils/partx.8
index e07787b10..e70d1fae1 100644
--- a/disk-utils/partx.8
+++ b/disk-utils/partx.8
@@ -144,6 +144,9 @@ Display version information and exit.
 .TP
 .BR \-h , " \-\-help"
 Display help text and exit.
+.SH ENVIRONMENT
+.IP LIBBLKID_DEBUG=all
+enables libblkid debug output.
 .SH EXAMPLE
 .TP
 partx \-\-show /dev/sdb3
@@ -169,12 +172,6 @@ Adds all available partitions from 3 to 5 (inclusive) on /dev/sdd.
 .TP
 partx \-d \-\-nr :\-1 /dev/sdd
 Removes the last partition on /dev/sdd.
-.SH SEE ALSO
-.BR addpart (8),
-.BR delpart (8),
-.BR fdisk (8),
-.BR parted (8),
-.BR partprobe (8)
 .SH AUTHORS
 .MT dave@gnu.org
 Davidlohr Bueso
@@ -188,9 +185,12 @@ The original version was written by
 .MT aeb@cwi.nl
 Andries E.\& Brouwer
 .ME .
-.SH ENVIRONMENT
-.IP LIBBLKID_DEBUG=all
-enables libblkid debug output.
+.SH SEE ALSO
+.BR addpart (8),
+.BR delpart (8),
+.BR fdisk (8),
+.BR parted (8),
+.BR partprobe (8)
 .SH AVAILABILITY
 The partx command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
diff --git a/disk-utils/sfdisk.8 b/disk-utils/sfdisk.8
index ff2a42aaf..4859fc9c2 100644
--- a/disk-utils/sfdisk.8
+++ b/disk-utils/sfdisk.8
@@ -620,6 +620,12 @@ enables libblkid debug output.
 .IP LIBSMARTCOLS_DEBUG=all
 enables libsmartcols debug output.
 
+.SH AUTHORS
+Karel Zak <kzak@redhat.com>
+.PP
+The current sfdisk implementation is based on the original sfdisk
+from Andries E. Brouwer.
+
 .SH SEE ALSO
 .BR fdisk (8),
 .BR cfdisk (8),
@@ -627,12 +633,6 @@ enables libsmartcols debug output.
 .BR partprobe (8),
 .BR partx (8)
 
-.SH AUTHORS
-Karel Zak <kzak@redhat.com>
-.PP
-The current sfdisk implementation is based on the original sfdisk
-from Andries E. Brouwer.
-
 .SH AVAILABILITY
 The sfdisk command is part of the util-linux package and is available from
 https://www.kernel.org/pub/linux/utils/util-linux/.
diff --git a/disk-utils/swaplabel.8 b/disk-utils/swaplabel.8
index cea8fc356..f22b8f443 100644
--- a/disk-utils/swaplabel.8
+++ b/disk-utils/swaplabel.8
@@ -55,16 +55,16 @@ The \fI UUID\fR
 must be in the standard 8-4-4-4-12 character format, such as is output by
 .BR uuidgen (1).
 .PP
-.SH AUTHORS
-.B swaplabel
-was written by Jason Borden <jborden@bluehost.com> and Karel Zak <kzak@redhat.com>.
 .SH ENVIRONMENT
 .IP LIBBLKID_DEBUG=all
 enables libblkid debug output.
-.SH AVAILABILITY
-The swaplabel command is part of the util-linux package and is available from
-https://www.kernel.org/pub/linux/utils/util-linux/.
+.SH AUTHORS
+.B swaplabel
+was written by Jason Borden <jborden@bluehost.com> and Karel Zak <kzak@redhat.com>.
 .SH SEE ALSO
 .BR uuidgen (1),
 .BR mkswap (8),
 .BR swapon (8)
+.SH AVAILABILITY
+The swaplabel command is part of the util-linux package and is available from
+https://www.kernel.org/pub/linux/utils/util-linux/.
diff --git a/libuuid/man/uuid.3 b/libuuid/man/uuid.3
index be2a63adb..1dbe29b37 100644
--- a/libuuid/man/uuid.3
+++ b/libuuid/man/uuid.3
@@ -51,10 +51,6 @@ This library generates UUIDs compatible with OSF DCE 1.1, and hash based UUIDs
 V3 and V5 compatible with RFC-4122.
 .SH AUTHORS
 Theodore Y.\& Ts'o
-.SH AVAILABILITY
-.B libuuid
-is part of the util-linux package since version 2.15.1 and is available from
-https://www.kernel.org/pub/linux/utils/util-linux/.
 .SH SEE ALSO
 .BR uuid_clear (3),
 .BR uuid_compare (3),
@@ -64,3 +60,7 @@ https://www.kernel.org/pub/linux/utils/util-linux/.
 .BR uuid_parse (3),
 .BR uuid_time (3),
 .BR uuid_unparse (3)
+.SH AVAILABILITY
+.B libuuid
+is part of the util-linux package since version 2.15.1 and is available from
+https://www.kernel.org/pub/linux/utils/util-linux/.
diff --git a/libuuid/man/uuid_clear.3 b/libuuid/man/uuid_clear.3
index 84c88838a..be6b24917 100644
--- a/libuuid/man/uuid_clear.3
+++ b/libuuid/man/uuid_clear.3
@@ -46,12 +46,8 @@ function sets the value of the supplied uuid variable
 to the NULL value.
 .SH AUTHORS
 Theodore Y.\& Ts'o
-.SH AVAILABILITY
-.B libuuid
-is part of the util-linux package since version 2.15.1 and is available from
-https://www.kernel.org/pub/linux/utils/util-linux/.
-.na
 .SH SEE ALSO
+.na
 .BR uuid (3),
 .BR uuid_compare (3),
 .BR uuid_copy (3),
@@ -60,3 +56,7 @@ https://www.kernel.org/pub/linux/utils/util-linux/.
 .BR uuid_parse (3),
 .BR uuid_unparse (3)
 .ad
+.SH AVAILABILITY
+.B libuuid
+is part of the util-linux package since version 2.15.1 and is available from
+https://www.kernel.org/pub/linux/utils/util-linux/.
diff --git a/libuuid/man/uuid_compare.3 b/libuuid/man/uuid_compare.3
index ddac24849..f659c0ccc 100644
--- a/libuuid/man/uuid_compare.3
+++ b/libuuid/man/uuid_compare.3
@@ -52,12 +52,8 @@ greater than
 .IR uu2 .
 .SH AUTHORS
 Theodore Y.\& Ts'o
-.SH AVAILABILITY
-.B libuuid
-is part of the util-linux package since version 2.15.1 and is available from
-https://www.kernel.org/pub/linux/utils/util-linux/.
-.na
 .SH SEE ALSO
+.na
 .BR uuid (3),
 .BR uuid_clear (3),
 .BR uuid_copy (3),
@@ -66,3 +62,7 @@ https://www.kernel.org/pub/linux/utils/util-linux/.
 .BR uuid_parse (3),
 .BR uuid_unparse (3)
 .ad
+.SH AVAILABILITY
+.B libuuid
+is part of the util-linux package since version 2.15.1 and is available from
+https://www.kernel.org/pub/linux/utils/util-linux/.
diff --git a/libuuid/man/uuid_copy.3 b/libuuid/man/uuid_copy.3
index fc03e00eb..71b00b9ad 100644
--- a/libuuid/man/uuid_copy.3
+++ b/libuuid/man/uuid_copy.3
@@ -48,12 +48,8 @@ The copied UUID is returned in the location pointed to by
 .IR dst .
 .SH AUTHORS
 Theodore Y.\& Ts'o
-.SH AVAILABILITY
-.B libuuid
-is part of the util-linux package since version 2.15.1 and is available from
-https://www.kernel.org/pub/linux/utils/util-linux/.
-.na
 .SH SEE ALSO
+.na
 .BR uuid (3),
 .BR uuid_clear (3),
 .BR uuid_compare (3),
@@ -62,3 +58,7 @@ https://www.kernel.org/pub/linux/utils/util-linux/.
 .BR uuid_parse (3),
 .BR uuid_unparse (3)
 .ad
+.SH AVAILABILITY
+.B libuuid
+is part of the util-linux package since version 2.15.1 and is available from
+https://www.kernel.org/pub/linux/utils/util-linux/.
diff --git a/libuuid/man/uuid_generate.3 b/libuuid/man/uuid_generate.3
index 78206d9c0..e06df48f6 100644
--- a/libuuid/man/uuid_generate.3
+++ b/libuuid/man/uuid_generate.3
@@ -120,10 +120,6 @@ This library generates UUIDs compatible with OSF DCE 1.1, and hash based UUIDs
 V3 and V5 compatible with RFC-4122.
 .SH AUTHORS
 Theodore Y.\& Ts'o
-.SH AVAILABILITY
-.B libuuid
-is part of the util-linux package since version 2.15.1 and is available from
-https://www.kernel.org/pub/linux/utils/util-linux/.
 .SH SEE ALSO
 .BR uuidgen (1),
 .BR uuid (3),
@@ -135,3 +131,7 @@ https://www.kernel.org/pub/linux/utils/util-linux/.
 .BR uuid_time (3),
 .BR uuid_unparse (3),
 .BR uuidd (8)
+.SH AVAILABILITY
+.B libuuid
+is part of the util-linux package since version 2.15.1 and is available from
+https://www.kernel.org/pub/linux/utils/util-linux/.
diff --git a/libuuid/man/uuid_is_null.3 b/libuuid/man/uuid_is_null.3
index 2842174da..f802228b5 100644
--- a/libuuid/man/uuid_is_null.3
+++ b/libuuid/man/uuid_is_null.3
@@ -47,12 +47,8 @@ to the NULL value.  If the value is equal to the NULL UUID, 1 is returned,
 otherwise 0 is returned.
 .SH AUTHORS
 Theodore Y.\& Ts'o
-.SH AVAILABILITY
-.B libuuid
-is part of the util-linux package since version 2.15.1 and is available from
-https://www.kernel.org/pub/linux/utils/util-linux/.
-.na
 .SH SEE ALSO
+.na
 .BR uuid (3),
 .BR uuid_clear (3),
 .BR uuid_compare (3),
@@ -62,3 +58,7 @@ https://www.kernel.org/pub/linux/utils/util-linux/.
 .BR uuid_parse (3),
 .BR uuid_unparse (3)
 .ad
+.SH AVAILABILITY
+.B libuuid
+is part of the util-linux package since version 2.15.1 and is available from
+https://www.kernel.org/pub/linux/utils/util-linux/.
diff --git a/libuuid/man/uuid_parse.3 b/libuuid/man/uuid_parse.3
index 1cab7b8d8..a7dff5ce0 100644
--- a/libuuid/man/uuid_parse.3
+++ b/libuuid/man/uuid_parse.3
@@ -69,12 +69,8 @@ This library parses UUIDs compatible with OSF DCE 1.1, and hash based UUIDs V3
 and V5 compatible with RFC-4122.
 .SH AUTHORS
 Theodore Y.\& Ts'o
-.SH AVAILABILITY
-.B libuuid
-is part of the util-linux package since version 2.15.1 and is available from
-https://www.kernel.org/pub/linux/utils/util-linux/.
-.na
 .SH SEE ALSO
+.na
 .BR uuid (3),
 .BR uuid_clear (3),
 .BR uuid_compare (3),
@@ -84,3 +80,7 @@ https://www.kernel.org/pub/linux/utils/util-linux/.
 .BR uuid_time (3),
 .BR uuid_unparse (3)
 .ad
+.SH AVAILABILITY
+.B libuuid
+is part of the util-linux package since version 2.15.1 and is available from
+https://www.kernel.org/pub/linux/utils/util-linux/.
diff --git a/libuuid/man/uuid_time.3 b/libuuid/man/uuid_time.3
index 9c1fdea4e..77110c40b 100644
--- a/libuuid/man/uuid_time.3
+++ b/libuuid/man/uuid_time.3
@@ -61,12 +61,8 @@ the epoch, is also stored in the location pointed to by
 .BR gettimeofday "(2))."
 .SH AUTHORS
 Theodore Y.\& Ts'o
-.SH AVAILABILITY
-.B libuuid
-is part of the util-linux package since version 2.15.1 and is available from
-https://www.kernel.org/pub/linux/utils/util-linux/.
-.na
 .SH SEE ALSO
+.na
 .BR uuid (3),
 .BR uuid_clear (3),
 .BR uuid_compare (3),
@@ -76,3 +72,7 @@ https://www.kernel.org/pub/linux/utils/util-linux/.
 .BR uuid_parse (3),
 .BR uuid_unparse (3)
 .ad
+.SH AVAILABILITY
+.B libuuid
+is part of the util-linux package since version 2.15.1 and is available from
+https://www.kernel.org/pub/linux/utils/util-linux/.
diff --git a/libuuid/man/uuid_unparse.3 b/libuuid/man/uuid_unparse.3
index 5f4ed5e00..1573c230c 100644
--- a/libuuid/man/uuid_unparse.3
+++ b/libuuid/man/uuid_unparse.3
@@ -64,12 +64,8 @@ may be used.
 This library unparses UUIDs compatible with OSF DCE 1.1.
 .SH AUTHORS
 Theodore Y.\& Ts'o
-.SH AVAILABILITY
-.B libuuid
-is part of the util-linux package since version 2.15.1 and is available from
-https://www.kernel.org/pub/linux/utils/util-linux/.
-.na
 .SH SEE ALSO
+.na
 .BR uuid (3),
 .BR uuid_clear (3),
 .BR uuid_compare (3),
@@ -79,3 +75,7 @@ https://www.kernel.org/pub/linux/utils/util-linux/.
 .BR uuid_is_null (3),
 .BR uuid_parse (3)
 .ad
+.SH AVAILABILITY
+.B libuuid
+is part of the util-linux package since version 2.15.1 and is available from
+https://www.kernel.org/pub/linux/utils/util-linux/.
diff --git a/login-utils/chfn.1 b/login-utils/chfn.1
index 8ac9c2c22..23f048325 100644
--- a/login-utils/chfn.1
+++ b/login-utils/chfn.1
@@ -96,13 +96,13 @@ This is the default.
 .PP
 .SH EXIT STATUS
 Returns 0 if operation was successful, 1 if operation failed or command syntax was not valid.
+.SH AUTHORS
+Salvatore Valente <svalente@mit.edu>
 .SH SEE ALSO
 .BR chsh (1),
 .BR finger (1),
 .BR login.defs (5),
 .BR passwd (5)
-.SH AUTHORS
-Salvatore Valente <svalente@mit.edu>
 .SH AVAILABILITY
 The chfn command is part of the util-linux package and is available from
 https://www.kernel.org/pub/linux/utils/util-linux/.
diff --git a/login-utils/chsh.1 b/login-utils/chsh.1
index e6642084a..5efdde080 100644
--- a/login-utils/chsh.1
+++ b/login-utils/chsh.1
@@ -55,13 +55,13 @@ at compile-time to only issue a warning for all users.
 
 .SH EXIT STATUS
 Returns 0 if operation was successful, 1 if operation failed or command syntax was not valid.
+.SH AUTHORS
+Salvatore Valente <svalente@mit.edu>
 .SH SEE ALSO
 .BR login (1),
 .BR login.defs (5),
 .BR passwd (5),
 .BR shells (5)
-.SH AUTHORS
-Salvatore Valente <svalente@mit.edu>
 .SH AVAILABILITY
 The chsh command is part of the util-linux package and is available from
 https://www.kernel.org/pub/linux/utils/util-linux/.
diff --git a/login-utils/last.1 b/login-utils/last.1
index 852d82aa6..bd632a7bb 100644
--- a/login-utils/last.1
+++ b/login-utils/last.1
@@ -186,13 +186,13 @@ command (for example,
 .MT miquels@cistron.nl
 Miquel van Smoorenburg
 .ME
-.SH AVAILABILITY
-The last command is part of the util-linux package and is available from
-.UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
-Linux Kernel Archive
-.UE .
 .SH SEE ALSO
 .BR login (1),
 .BR wtmp (5),
 .BR init (8),
 .BR shutdown (8)
+.SH AVAILABILITY
+The last command is part of the util-linux package and is available from
+.UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
+Linux Kernel Archive
+.UE .
diff --git a/login-utils/login.1 b/login-utils/login.1
index ef893f602..c108ced25 100644
--- a/login-utils/login.1
+++ b/login-utils/login.1
@@ -336,14 +336,6 @@ the superuser logs in.  ENV_ROOTPATH takes precedence.  The default value is
 .I /etc/hushlogins
 .I .hushlogin
 .fi
-.SH SEE ALSO
-.BR mail (1),
-.BR passwd (1),
-.BR passwd (5),
-.BR environ (7),
-.BR getty (8),
-.BR init (8),
-.BR shutdown (8)
 .SH BUGS
 The undocumented BSD
 .B \-r
@@ -379,6 +371,14 @@ Rewritten to a PAM-only version by
 .MT kzak@\:redhat.\:com
 Karel Zak
 .ME
+.SH SEE ALSO
+.BR mail (1),
+.BR passwd (1),
+.BR passwd (5),
+.BR environ (7),
+.BR getty (8),
+.BR init (8),
+.BR shutdown (8)
 .SH AVAILABILITY
 The login command is part of the util-linux package and is
 available from
diff --git a/login-utils/lslogins.1 b/login-utils/lslogins.1
index fbeaacedf..3ca9162eb 100644
--- a/login-utils/lslogins.1
+++ b/login-utils/lslogins.1
@@ -135,8 +135,6 @@ if incorrect arguments specified,
 .TP
 2
 if a serious error occurs (e.g., a corrupt log).
-.SH SEE ALSO
-\fBgroup\fP(5), \fBpasswd\fP(5), \fBshadow\fP(5), \fButmp\fP(5)
 .SH HISTORY
 The \fBlslogins\fP utility is inspired by the \fBlogins\fP utility, which first appeared in FreeBSD 4.10.
 .SH AUTHORS
@@ -148,6 +146,8 @@ Ondrej Oprala
 Karel Zak
 .ME
 
+.SH SEE ALSO
+\fBgroup\fP(5), \fBpasswd\fP(5), \fBshadow\fP(5), \fButmp\fP(5)
 .SH AVAILABILITY
 The lslogins command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
diff --git a/login-utils/newgrp.1 b/login-utils/newgrp.1
index b4b308d1f..9902cd547 100644
--- a/login-utils/newgrp.1
+++ b/login-utils/newgrp.1
@@ -21,14 +21,14 @@ If no group is specified, the GID is changed to the login GID.
 .br
 .I /etc/passwd
 
-.SH SEE ALSO
-.BR login (1),
-.BR group (5)
-
 .SH AUTHORS
 Originally by Michael Haardt. Currently maintained by
 Peter Orbaek (poe@daimi.aau.dk).
 
+.SH SEE ALSO
+.BR login (1),
+.BR group (5)
+
 .SH AVAILABILITY
 The newgrp command is part of the util-linux package and is available from
 https://www.kernel.org/pub/linux/utils/util-linux/.
diff --git a/login-utils/nologin.8 b/login-utils/nologin.8
index d7be1f90e..6fc6fc68f 100644
--- a/login-utils/nologin.8
+++ b/login-utils/nologin.8
@@ -56,6 +56,10 @@ access is always refused independently of the file.
 PAM module usually prevents all non-root users from logging into the system.
 .BR pam_nologin (8)
 functionality is controlled by /var/run/nologin or the /etc/nologin file.
+.SH HISTORY
+The
+.B nologin
+command appeared in 4.4BSD.
 .SH AUTHORS
 .UR kzak@redhat.com
 Karel Zak
@@ -64,10 +68,6 @@ Karel Zak
 .BR login (1),
 .BR passwd (5),
 .BR pam_nologin (8)
-.SH HISTORY
-The
-.B nologin
-command appeared in 4.4BSD.
 .SH AVAILABILITY
 The nologin command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
diff --git a/login-utils/runuser.1 b/login-utils/runuser.1
index 4a4e19dde..251a6d153 100644
--- a/login-utils/runuser.1
+++ b/login-utils/runuser.1
@@ -255,16 +255,16 @@ runuser specific logindef config file
 /etc/login.defs
 global logindef config file
 .PD 1
+.SH HISTORY
+This \fB runuser\fR command was
+derived from coreutils' \fBsu\fR, which was based on an implementation by
+David MacKenzie, and the Fedora \fBrunuser\fR command by Dan Walsh.
 .SH SEE ALSO
 .BR setpriv (1),
 .BR su (1),
 .BR login.defs (5),
 .BR shells (5),
 .BR pam (8)
-.SH HISTORY
-This \fB runuser\fR command was
-derived from coreutils' \fBsu\fR, which was based on an implementation by
-David MacKenzie, and the Fedora \fBrunuser\fR command by Dan Walsh.
 .SH AVAILABILITY
 The runuser command is part of the util-linux package and is
 available from
diff --git a/login-utils/su.1 b/login-utils/su.1
index 6ff8d1e64..9e3154ea4 100644
--- a/login-utils/su.1
+++ b/login-utils/su.1
@@ -290,16 +290,16 @@ be configured to update the lastlog file as well. For example by:
 .br
 session  required  pam_lastlog.so nowtmp
 .RE
+.SH HISTORY
+This \fBsu\fR command was
+derived from coreutils' \fBsu\fR, which was based on an implementation by
+David MacKenzie. The util-linux has been refactored by Karel Zak.
 .SH SEE ALSO
 .BR setpriv (1),
 .BR login.defs (5),
 .BR shells (5),
 .BR pam (8),
 .BR runuser (1)
-.SH HISTORY
-This \fBsu\fR command was
-derived from coreutils' \fBsu\fR, which was based on an implementation by
-David MacKenzie. The util-linux has been refactored by Karel Zak.
 .SH AVAILABILITY
 The su command is part of the util-linux package and is
 available from
diff --git a/login-utils/vipw.8 b/login-utils/vipw.8
index 41aa36e2e..6f9695ae4 100644
--- a/login-utils/vipw.8
+++ b/login-utils/vipw.8
@@ -69,11 +69,6 @@ The editor specified by the string
 .B EDITOR
 will be invoked instead of the default editor
 .BR vi (1).
-.SH SEE ALSO
-.BR vi (1),
-.BR passwd (1),
-.BR flock (2),
-.BR passwd (5)
 .SH HISTORY
 The
 .B vipw
@@ -82,6 +77,11 @@ command appeared in 4.0BSD.
 The
 .B vigr
 command appeared in Util-Linux 2.6.
+.SH SEE ALSO
+.BR vi (1),
+.BR passwd (1),
+.BR flock (2),
+.BR passwd (5)
 .SH AVAILABILITY
 The vigr and vipw commands are part of the util-linux package and are available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
diff --git a/misc-utils/blkid.8 b/misc-utils/blkid.8
index e6f2ec8fe..53becc42f 100644
--- a/misc-utils/blkid.8
+++ b/misc-utils/blkid.8
@@ -327,12 +327,12 @@ a comma-separated list.  Default is "udev,scan".  The "udev" method uses udev
 symlinks and the "scan" method scans all block devices from the
 .I /proc/partitions
 file.
+.SH ENVIRONMENT
+.IP "Setting LIBBLKID_DEBUG=all enables debug output."
 .SH AUTHORS
 .B blkid
 was written by Andreas Dilger for libblkid and improved by Theodore Ts'o
 and Karel Zak.
-.SH ENVIRONMENT
-.IP "Setting LIBBLKID_DEBUG=all enables debug output."
 .SH SEE ALSO
 .BR libblkid (3),
 .BR findfs (8),
diff --git a/misc-utils/findfs.8 b/misc-utils/findfs.8
index 22c7c3ddc..26762f83d 100644
--- a/misc-utils/findfs.8
+++ b/misc-utils/findfs.8
@@ -60,6 +60,9 @@ label or uuid cannot be found
 usage error, wrong number of arguments or unknown option
 .PD
 .RE
+.SH ENVIRONMENT
+.IP LIBBLKID_DEBUG=all
+enables libblkid debug output.
 .SH AUTHORS
 .B findfs
 was originally written by
@@ -70,9 +73,6 @@ and re-written for the util-linux package by
 .MT kzak@redhat.com
 Karel Zak
 .ME .
-.SH ENVIRONMENT
-.IP LIBBLKID_DEBUG=all
-enables libblkid debug output.
 .SH SEE ALSO
 .BR blkid (8),
 .BR lsblk (8),
diff --git a/misc-utils/hardlink.1 b/misc-utils/hardlink.1
index 26db12d9b..cb23ab190 100644
--- a/misc-utils/hardlink.1
+++ b/misc-utils/hardlink.1
@@ -48,12 +48,6 @@ Display help text and exit.
 .TP
 .BR \-V , " \-\-version"
 Display version information and exit.
-.SH AUTHORS
-.PP
-\fBhardlink\fR was written by Jakub Jelinek <jakub@redhat.com> and later modified by
-Ruediger Meier <ruediger.meier@ga-group.nl> and Karel Zak <kzak@redhat.com> for util-linux.
-.PP
-Man page written by Brian Long and later updated by Jindrich Novy <jnovy@redhat.com>
 .SH BUGS
 .PP
 \fBhardlink\fR assumes that its target directory trees do not change from under
@@ -67,6 +61,12 @@ Historically \fBhardlink\fR silently excluded any names beginning with
 other characters. That prior behavior can be achieved by specifying
 .br
 \-x '^(\\.in\\.|\\.[^.]{6}$)'
+.SH AUTHORS
+.PP
+\fBhardlink\fR was written by Jakub Jelinek <jakub@redhat.com> and later modified by
+Ruediger Meier <ruediger.meier@ga-group.nl> and Karel Zak <kzak@redhat.com> for util-linux.
+.PP
+Man page written by Brian Long and later updated by Jindrich Novy <jnovy@redhat.com>
 .SH AVAILABILITY
 The hardlink command is part of the util-linux package and is available from
 https://www.kernel.org/pub/linux/utils/util-linux/.
diff --git a/misc-utils/kill.1 b/misc-utils/kill.1
index 5c74301f5..7f542ce0a 100644
--- a/misc-utils/kill.1
+++ b/misc-utils/kill.1
@@ -188,14 +188,6 @@ failure
 partial success (when more than one process specified)
 .PD
 .RE
-.SH SEE ALSO
-.BR bash (1),
-.BR tcsh (1),
-.BR sigaction (2),
-.BR kill (2),
-.BR sigqueue (3),
-.BR signal (7)
-
 .SH AUTHORS
 .MT svalente@mit.edu
 Salvatore Valente
@@ -208,6 +200,14 @@ Karel Zak
 .PP
 The original version was taken from BSD 4.4.
 
+.SH SEE ALSO
+.BR bash (1),
+.BR tcsh (1),
+.BR sigaction (2),
+.BR kill (2),
+.BR sigqueue (3),
+.BR signal (7)
+
 .SH AVAILABILITY
 The kill command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
diff --git a/misc-utils/logger.1 b/misc-utils/logger.1
index 67ca2111f..6c3d94d62 100644
--- a/misc-utils/logger.1
+++ b/misc-utils/logger.1
@@ -351,10 +351,6 @@ For the priority order and intended purposes of these facilities and levels, see
 .B logger \-p local0.notice \-t HOSTIDM \-f /dev/idmc
 .br
 .B logger \-n loghost.example.com System rebooted
-.SH SEE ALSO
-.BR journalctl (1),
-.BR syslog (3),
-.BR systemd.journal-fields (7)
 .SH CONFORMING TO
 The
 .B logger
@@ -375,6 +371,10 @@ and
 .MT kerolasa@iki.fi
 Sami Kerola
 .ME .
+.SH SEE ALSO
+.BR journalctl (1),
+.BR syslog (3),
+.BR systemd.journal-fields (7)
 .SH AVAILABILITY
 The logger command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
diff --git a/misc-utils/look.1 b/misc-utils/look.1
index 56963c84d..539e9f6a1 100644
--- a/misc-utils/look.1
+++ b/misc-utils/look.1
@@ -111,13 +111,13 @@ than the dictionary path defined in FILES segment.
 the dictionary
 .IP "\fB/usr/share/dict/web2\fR" 4
 the alternative dictionary
-.SH SEE ALSO
-.BR grep (1),
-.BR sort (1)
 .SH HISTORY
 The
 .B look
 utility appeared in Version 7 AT&T Unix.
+.SH SEE ALSO
+.BR grep (1),
+.BR sort (1)
 .SH AVAILABILITY
 The look command is part of the util-linux package and is available from
 https://www.kernel.org/pub/linux/utils/util-linux/.
diff --git a/misc-utils/lsblk.8 b/misc-utils/lsblk.8
index cca345f1a..76c64b625 100644
--- a/misc-utils/lsblk.8
+++ b/misc-utils/lsblk.8
@@ -190,11 +190,6 @@ none of specified devices found
 .IP 64
 some specified devices found, some not found
 
-.SH AUTHORS
-.nf
-Milan Broz <mbroz@redhat.com>
-Karel Zak <kzak@redhat.com>
-.fi
 .SH ENVIRONMENT
 .IP LSBLK_DEBUG=all
 enables lsblk debug output.
@@ -206,6 +201,11 @@ enables libmount debug output.
 enables libsmartcols debug output.
 .IP LIBSMARTCOLS_DEBUG_PADDING=on
 use visible padding characters. Requires enabled LIBSMARTCOLS_DEBUG.
+.SH AUTHORS
+.nf
+Milan Broz <mbroz@redhat.com>
+Karel Zak <kzak@redhat.com>
+.fi
 .SH SEE ALSO
 .BR ls (1),
 .BR blkid (8),
diff --git a/misc-utils/namei.1 b/misc-utils/namei.1
index f44f80476..84eae8b91 100644
--- a/misc-utils/namei.1
+++ b/misc-utils/namei.1
@@ -63,14 +63,14 @@ Display version information and exit.
 .TP
 .BR \-h , " \-\-help"
 Display help text and exit.
+.SH BUGS
+To be discovered.
 .SH AUTHORS
 The original
 .B namei
 program was written by Roger Southwick <rogers@amadeus.wr.tek.com>.
 .sp
 The program was rewritten by Karel Zak <kzak@redhat.com>.
-.SH BUGS
-To be discovered.
 .SH SEE ALSO
 .BR ls (1),
 .BR stat (1),
diff --git a/misc-utils/wipefs.8 b/misc-utils/wipefs.8
index 39e9c9f96..01081fa8e 100644
--- a/misc-utils/wipefs.8
+++ b/misc-utils/wipefs.8
@@ -112,6 +112,9 @@ taken.  For more details see mount(8).
 .TP
 .BR \-V , " \-\-version"
 Display version information and exit.
+.SH ENVIRONMENT
+.IP LIBBLKID_DEBUG=all
+enables libblkid debug output.
 .SH EXAMPLE
 .TP
 .B wipefs /dev/sda*
@@ -125,9 +128,6 @@ file ~/wipefs-sdb-<offset>.bak for each signature.
 Restores an ext2 signature from the backup file  ~/wipefs-sdb-0x00000438.bak.
 .SH AUTHORS
 Karel Zak <kzak@redhat.com>
-.SH ENVIRONMENT
-.IP LIBBLKID_DEBUG=all
-enables libblkid debug output.
 .SH SEE ALSO
 .BR blkid (8),
 .BR findfs (8)
diff --git a/schedutils/chrt.1 b/schedutils/chrt.1
index cad5dacd7..83e57070c 100644
--- a/schedutils/chrt.1
+++ b/schedutils/chrt.1
@@ -151,6 +151,14 @@ may be ignored on some systems.
 .P
 Linux' default scheduling policy is
 .BR SCHED_OTHER .
+.SH AUTHORS
+.UR rml@tech9.net
+Robert Love
+.UE
+.br
+.UR kzak@redhat.com
+Karel Zak
+.UE
 .SH SEE ALSO
 .BR nice (1),
 .BR renice (1),
@@ -160,14 +168,6 @@ Linux' default scheduling policy is
 See
 .BR sched_setscheduler (2)
 for a description of the Linux scheduling scheme.
-.SH AUTHORS
-.UR rml@tech9.net
-Robert Love
-.UE
-.br
-.UR kzak@redhat.com
-Karel Zak
-.UE
 .SH AVAILABILITY
 The chrt command is part of the util-linux package and is available from
 https://www.kernel.org/pub/linux/utils/util-linux/.
diff --git a/schedutils/taskset.1 b/schedutils/taskset.1
index e73000bf3..7fdc50898 100644
--- a/schedutils/taskset.1
+++ b/schedutils/taskset.1
@@ -119,6 +119,12 @@ A user must possess
 .B CAP_SYS_NICE
 to change the CPU affinity of a process belonging to another user.
 A user can retrieve the affinity mask of any process.
+.SH AUTHORS
+Written by Robert M. Love.
+.SH COPYRIGHT
+Copyright \(co 2004 Robert M. Love.
+This is free software; see the source for copying conditions.  There is NO
+warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 .SH SEE ALSO
 .BR chrt (1),
 .BR nice (1),
@@ -129,12 +135,6 @@ A user can retrieve the affinity mask of any process.
 See
 .BR sched (7)
 for a description of the Linux scheduling scheme.
-.SH AUTHORS
-Written by Robert M. Love.
-.SH COPYRIGHT
-Copyright \(co 2004 Robert M. Love.
-This is free software; see the source for copying conditions.  There is NO
-warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 .SH AVAILABILITY
 The taskset command is part of the util-linux package and is available from
 https://www.kernel.org/pub/linux/utils/util-linux/.
diff --git a/sys-utils/ctrlaltdel.8 b/sys-utils/ctrlaltdel.8
index 7cd340d09..3f6657ee7 100644
--- a/sys-utils/ctrlaltdel.8
+++ b/sys-utils/ctrlaltdel.8
@@ -44,13 +44,13 @@ Display version information and exit.
 Display help text and exit.
 .SH FILES
 .I /etc/rc.local
-.SH SEE ALSO
-.BR init (8),
-.BR systemd (1)
 .SH AUTHORS
 .UR poe@daimi.aau.dk
 Peter Orbaek
 .UE
+.SH SEE ALSO
+.BR init (8),
+.BR systemd (1)
 .SH AVAILABILITY
 The ctrlaltdel command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
diff --git a/sys-utils/dmesg.1 b/sys-utils/dmesg.1
index 2afc07890..31bfb56f3 100644
--- a/sys-utils/dmesg.1
+++ b/sys-utils/dmesg.1
@@ -242,9 +242,6 @@ can fail reporting permission denied error.  This is usually caused by
 kernel setting, please see
 .BR syslog (2)
 for more details.
-.SH SEE ALSO
-.BR terminal-colors.d (5),
-.BR syslogd (8)
 .SH AUTHORS
 .MT kzak@redhat.com
 Karel Zak
@@ -256,6 +253,9 @@ was originally written by
 .MT tytso@athena.mit.edu
 Theodore Ts'o
 .ME
+.SH SEE ALSO
+.BR terminal-colors.d (5),
+.BR syslogd (8)
 .SH AVAILABILITY
 The dmesg command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
diff --git a/sys-utils/fsfreeze.8 b/sys-utils/fsfreeze.8
index 2ca445aeb..eb3214769 100644
--- a/sys-utils/fsfreeze.8
+++ b/sys-utils/fsfreeze.8
@@ -75,13 +75,13 @@ and
 Previous list may be incomplete, as more filesystems get support.  If in
 doubt easiest way to know if a filesystem has support is create a small
 loopback mount and test freezing it.
-.SH AUTHORS
-.PP
-Written by Hajime Taira.
 .SH NOTES
 .PP
 This man page is based on
 .BR xfs_freeze (8).
+.SH AUTHORS
+.PP
+Written by Hajime Taira.
 .SH SEE ALSO
 .BR mount (8)
 .SH AVAILABILITY
diff --git a/sys-utils/fstab.5 b/sys-utils/fstab.5
index 67243f6b4..9e73d4349 100644
--- a/sys-utils/fstab.5
+++ b/sys-utils/fstab.5
@@ -232,17 +232,17 @@ libmount based mount utility (since util-linux v2.22).
 .SH FILES
 .IR /etc/fstab ,
 .I <fstab.h>
+.SH HISTORY
+The ancestor of this
+.B fstab
+file format appeared in 4.0BSD.
+.\" But without comment convention, and options and vfs_type.
 .SH SEE ALSO
 .BR getmntent (3),
 .BR fs (5),
 .BR findmnt (8),
 .BR mount (8),
 .BR swapon (8)
-.SH HISTORY
-The ancestor of this
-.B fstab
-file format appeared in 4.0BSD.
-.\" But without comment convention, and options and vfs_type.
 .\" Instead there was a type rw/ro/rq/sw/xx, where xx is the present 'ignore'.
 .SH AVAILABILITY
 This man page is part of the util-linux package and is available from
diff --git a/sys-utils/ipcmk.1 b/sys-utils/ipcmk.1
index c1e8fe47c..6102693ca 100644
--- a/sys-utils/ipcmk.1
+++ b/sys-utils/ipcmk.1
@@ -40,13 +40,13 @@ Display version information and exit.
 .BR \-h , " \-\-help"
 Display help text and exit.
 .PP
-.SH SEE ALSO
-.BR ipcrm (1),
-.BR ipcs (1)
 .SH AUTHORS
 .MT hayden.james@gmail.com
 Hayden A. James
 .ME
+.SH SEE ALSO
+.BR ipcrm (1),
+.BR ipcs (1)
 .SH AVAILABILITY
 The ipcmk command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
diff --git a/sys-utils/ipcs.1 b/sys-utils/ipcs.1
index 745d33832..a7fcb540e 100644
--- a/sys-utils/ipcs.1
+++ b/sys-utils/ipcs.1
@@ -94,16 +94,6 @@ A limitation of the
 .B IPC_STAT
 mechanism is that it can only be used to retrieve information about
 IPC resources for which the user has read permission.
-.SH SEE ALSO
-.BR ipcmk (1),
-.BR ipcrm (1),
-.BR msgrcv (2),
-.BR msgsnd (2),
-.BR semget (2),
-.BR semop (2),
-.BR shmat (2),
-.BR shmdt (2),
-.BR shmget (2)
 .SH CONFORMING TO
 The Linux ipcs utility is not fully compatible to the POSIX ipcs utility.
 The Linux version does not support the POSIX
@@ -127,6 +117,16 @@ options.
 .UR balasub@cis.ohio-state.edu
 Krishna Balasubramanian
 .UE
+.SH SEE ALSO
+.BR ipcmk (1),
+.BR ipcrm (1),
+.BR msgrcv (2),
+.BR msgsnd (2),
+.BR semget (2),
+.BR semop (2),
+.BR shmat (2),
+.BR shmdt (2),
+.BR shmget (2)
 .SH AVAILABILITY
 The ipcs command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
diff --git a/sys-utils/ldattach.8 b/sys-utils/ldattach.8
index ee3d54998..eb3b0b6c9 100644
--- a/sys-utils/ldattach.8
+++ b/sys-utils/ldattach.8
@@ -142,13 +142,13 @@ Display version information and exit.
 .TP
 .BR \-h , " \-\-help"
 Display help text and exit.
-.SH SEE ALSO
-.BR inputattach (1),
-.BR ttys (4)
 .SH AUTHORS
 .nf
 Tilman Schmidt (tilman@imap.cc)
 .fi
+.SH SEE ALSO
+.BR inputattach (1),
+.BR ttys (4)
 .SH AVAILABILITY
 The ldattach command is part of the util-linux package
 and is available from
diff --git a/sys-utils/lsipc.1 b/sys-utils/lsipc.1
index 9bb1dce91..71cf0cf74 100644
--- a/sys-utils/lsipc.1
+++ b/sys-utils/lsipc.1
@@ -111,16 +111,6 @@ if incorrect arguments specified,
 .TP
 2
 if a serious error occurs.
-.SH SEE ALSO
-.BR ipcmk (1),
-.BR ipcrm (1),
-.BR msgrcv (2),
-.BR msgsnd (2),
-.BR semget (2),
-.BR semop (2),
-.BR shmat (2),
-.BR shmdt (2),
-.BR shmget (2)
 .SH HISTORY
 The \fBlsipc\fP utility is inspired by the \fBipcs\fP utility.
 .SH AUTHORS
@@ -132,6 +122,16 @@ Ondrej Oprala
 Karel Zak
 .ME
 
+.SH SEE ALSO
+.BR ipcmk (1),
+.BR ipcrm (1),
+.BR msgrcv (2),
+.BR msgsnd (2),
+.BR semget (2),
+.BR semop (2),
+.BR shmat (2),
+.BR shmdt (2),
+.BR shmget (2)
 .SH AVAILABILITY
 The lsipc command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index d3170ec71..2ffbfe812 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -2605,24 +2605,6 @@ enables libmount debug output
 enables libblkid debug output
 .IP LOOPDEV_DEBUG=all
 enables loop device setup debug output
-.SH SEE ALSO
-.na
-.BR mount (2),
-.BR umount (2),
-.BR umount (8),
-.BR fstab (5),
-.BR nfs (5),
-.BR xfs (5),
-.BR e2label (8),
-.BR findmnt (8),
-.BR losetup (8),
-.BR mke2fs (8),
-.BR mountd (8),
-.BR nfsd (8),
-.BR swapon (8),
-.BR tune2fs (8),
-.BR xfs_admin (8)
-.ad
 .SH BUGS
 It is possible for a corrupted filesystem to cause a crash.
 .PP
@@ -2690,6 +2672,24 @@ command existed in Version 5 AT&T UNIX.
 .nf
 Karel Zak <kzak@redhat.com>
 .fi
+.SH SEE ALSO
+.na
+.BR mount (2),
+.BR umount (2),
+.BR umount (8),
+.BR fstab (5),
+.BR nfs (5),
+.BR xfs (5),
+.BR e2label (8),
+.BR findmnt (8),
+.BR losetup (8),
+.BR mke2fs (8),
+.BR mountd (8),
+.BR nfsd (8),
+.BR swapon (8),
+.BR tune2fs (8),
+.BR xfs_admin (8)
+.ad
 .SH AVAILABILITY
 The mount command is part of the util-linux package and is available from
 https://www.kernel.org/pub/linux/utils/util-linux/.
diff --git a/sys-utils/mountpoint.1 b/sys-utils/mountpoint.1
index cfb5916fe..cadb026da 100644
--- a/sys-utils/mountpoint.1
+++ b/sys-utils/mountpoint.1
@@ -43,9 +43,6 @@ Display version information and exit.
 Display help text and exit.
 .SH EXIT STATUS
 Zero if the directory or file is a mountpoint, non-zero if not.
-.SH AUTHORS
-.PP
-Karel Zak <kzak@redhat.com>
 .SH ENVIRONMENT
 .IP LIBMOUNT_DEBUG=all
 enables libmount debug output.
@@ -56,6 +53,9 @@ The util-linux
 implementation was written from scratch for libmount.  The original version
 for sysvinit suite was written by Miquel van Smoorenburg.
 
+.SH AUTHORS
+.PP
+Karel Zak <kzak@redhat.com>
 .SH SEE ALSO
 .BR mount (8)
 .SH AVAILABILITY
diff --git a/sys-utils/nsenter.1 b/sys-utils/nsenter.1
index c51d9b04a..424e22dc9 100644
--- a/sys-utils/nsenter.1
+++ b/sys-utils/nsenter.1
@@ -269,10 +269,6 @@ Display version information and exit.
 .TP
 \fB\-h\fR, \fB\-\-help\fR
 Display help text and exit.
-.SH SEE ALSO
-.BR clone (2),
-.BR setns (2),
-.BR namespaces (7)
 .SH AUTHORS
 .UR biederm@xmission.com
 Eric Biederman
@@ -281,6 +277,10 @@ Eric Biederman
 .UR kzak@redhat.com
 Karel Zak
 .UE
+.SH SEE ALSO
+.BR clone (2),
+.BR setns (2),
+.BR namespaces (7)
 .SH AVAILABILITY
 The nsenter command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
diff --git a/sys-utils/prlimit.1 b/sys-utils/prlimit.1
index fb784377b..0f2b49f37 100644
--- a/sys-utils/prlimit.1
+++ b/sys-utils/prlimit.1
@@ -103,10 +103,6 @@ processes to unlimited.
 .IP "\fBprlimit \-\-cpu=10 sort \-u hugefile\fP"
 Set both the soft and hard CPU time limit to ten seconds and run 'sort'.
 
-.SH SEE ALSO
-.BR ulimit (1p),
-.BR prlimit (2)
-
 .SH NOTES
 The prlimit system call is supported since Linux 2.6.36, older kernels will
 break this program.
@@ -115,6 +111,10 @@ break this program.
 .nf
 Davidlohr Bueso <dave@gnu.org> - In memory of Dennis M. Ritchie.
 .fi
+.SH SEE ALSO
+.BR ulimit (1p),
+.BR prlimit (2)
+
 .SH AVAILABILITY
 The prlimit command is part of the util-linux package and is available from
 https://www.kernel.org/pub/linux/utils/util-linux/.
diff --git a/sys-utils/renice.1 b/sys-utils/renice.1
index 12a0f608d..cfba47ff8 100644
--- a/sys-utils/renice.1
+++ b/sys-utils/renice.1
@@ -102,6 +102,10 @@ negative (to make things go very fast).
 .TP
 .I /etc/passwd
 to map user names to user IDs
+.SH HISTORY
+The
+.B renice
+command appeared in 4.0BSD.
 .SH SEE ALSO
 .BR nice (1),
 .BR chrt (1),
@@ -109,10 +113,6 @@ to map user names to user IDs
 .BR setpriority (2),
 .BR credentials (7),
 .BR sched (7)
-.SH HISTORY
-The
-.B renice
-command appeared in 4.0BSD.
 .SH AVAILABILITY
 The renice command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
diff --git a/sys-utils/setpriv.1 b/sys-utils/setpriv.1
index 39d274a2f..222fa6388 100644
--- a/sys-utils/setpriv.1
+++ b/sys-utils/setpriv.1
@@ -204,15 +204,15 @@ If you want to mimic daemontools'
 try:
 .sp
 .B "    setpriv \-\-reuid=1000 \-\-regid=1000 \-\-clear\-groups"
+.SH AUTHORS
+.MT luto@amacapital.net
+Andy Lutomirski
+.ME
 .SH SEE ALSO
 .BR runuser (1),
 .BR su (1),
 .BR prctl (2),
 .BR capabilities (7)
-.SH AUTHORS
-.MT luto@amacapital.net
-Andy Lutomirski
-.ME
 .SH AVAILABILITY
 The
 .B setpriv
diff --git a/sys-utils/setsid.1 b/sys-utils/setsid.1
index e694ef801..c025076ce 100644
--- a/sys-utils/setsid.1
+++ b/sys-utils/setsid.1
@@ -33,10 +33,10 @@ Display version information and exit.
 .TP
 .BR \-h , " \-\-help"
 Display help text and exit.
-.SH SEE ALSO
-.BR setsid (2)
 .SH AUTHORS
 Rick Sladkey <jrs@world.std.com>
+.SH SEE ALSO
+.BR setsid (2)
 .SH AVAILABILITY
 The setsid command is part of the util-linux package and is available from
 https://www.kernel.org/pub/linux/utils/util-linux/.
diff --git a/sys-utils/swapon.8 b/sys-utils/swapon.8
index c8ad3bfff..157bbcd95 100644
--- a/sys-utils/swapon.8
+++ b/sys-utils/swapon.8
@@ -226,15 +226,6 @@ enables libmount debug output.
 .IP LIBBLKID_DEBUG=all
 enables libblkid debug output.
 
-.SH SEE ALSO
-.BR swapoff (2),
-.BR swapon (2),
-.BR fstab (5),
-.BR init (8),
-.BR fallocate (1),
-.BR mkswap (8),
-.BR mount (8),
-.BR rc (8)
 .SH FILES
 .br
 .I /dev/sd??
@@ -246,6 +237,15 @@ ascii filesystem description table
 The
 .B swapon
 command appeared in 4.0BSD.
+.SH SEE ALSO
+.BR swapoff (2),
+.BR swapon (2),
+.BR fstab (5),
+.BR init (8),
+.BR fallocate (1),
+.BR mkswap (8),
+.BR mount (8),
+.BR rc (8)
 .SH AVAILABILITY
 The swapon command is part of the util-linux package and is available from
 https://www.kernel.org/pub/linux/utils/util-linux/.
diff --git a/sys-utils/switch_root.8 b/sys-utils/switch_root.8
index b169817e9..d345349b3 100644
--- a/sys-utils/switch_root.8
+++ b/sys-utils/switch_root.8
@@ -45,17 +45,17 @@ mount --bind $DIR $DIR
 .RE
 .fi
 
-.SH SEE ALSO
-.BR chroot (2),
-.BR init (8),
-.BR mkinitrd (8),
-.BR mount (8)
 .SH AUTHORS
 .nf
 Peter Jones <pjones@redhat.com>
 Jeremy Katz <katzj@redhat.com>
 Karel Zak <kzak@redhat.com>
 .fi
+.SH SEE ALSO
+.BR chroot (2),
+.BR init (8),
+.BR mkinitrd (8),
+.BR mount (8)
 .SH AVAILABILITY
 The switch_root command is part of the util-linux package and is available from
 https://www.kernel.org/pub/linux/utils/util-linux/.
diff --git a/sys-utils/umount.8 b/sys-utils/umount.8
index dff62dee4..434877afc 100644
--- a/sys-utils/umount.8
+++ b/sys-utils/umount.8
@@ -271,14 +271,14 @@ overrides the default location of the fstab file (ignored for suid)
 overrides the default location of the mtab file (ignored for suid)
 .IP LIBMOUNT_DEBUG=all
 enables libmount debug output
-.SH SEE ALSO
-.BR umount (2),
-.BR losetup (8),
-.BR mount (8)
 .SH HISTORY
 A
 .B umount
 command appeared in Version 6 AT&T UNIX.
+.SH SEE ALSO
+.BR umount (2),
+.BR losetup (8),
+.BR mount (8)
 .SH AVAILABILITY
 The umount command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index b22329d9e..7b35bc0b6 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -315,11 +315,6 @@ been re-parented to PID 1.
 .TQ
  10:58:48 up 1158 days,  6:05,  1 user,  load average: 0.00, 0.00, 0.00
 
-.SH SEE ALSO
-.BR clone (2),
-.BR unshare (2),
-.BR namespaces (7),
-.BR mount (8)
 .SH AUTHORS
 .UR dottedmag@dottedmag.net
 Mikhail Gusarov
@@ -328,6 +323,11 @@ Mikhail Gusarov
 .UR kzak@redhat.com
 Karel Zak
 .UE
+.SH SEE ALSO
+.BR clone (2),
+.BR unshare (2),
+.BR namespaces (7),
+.BR mount (8)
 .SH AVAILABILITY
 The unshare command is part of the util-linux package and is available from
 https://www.kernel.org/pub/linux/utils/util-linux/.
diff --git a/sys-utils/zramctl.8 b/sys-utils/zramctl.8
index 97e3f4118..abd6507b9 100644
--- a/sys-utils/zramctl.8
+++ b/sys-utils/zramctl.8
@@ -117,15 +117,15 @@ and use it as swap device.
 # swapoff /dev/zram0
 # zramctl --reset /dev/zram0
 .fi
-.SH SEE ALSO
-.UR http://git.\:kernel.\:org\:/cgit\:/linux\:/kernel\:/git\:/torvalds\:/linux.git\:/tree\:/Documentation\:/admin-guide\:/blockdev\:/zram.rst
-Linux kernel documentation
-.UE .
 .SH AUTHORS
 .nf
 Timofey Titovets <nefelim4ag@gmail.com>
 Karel Zak <kzak@redhat.com>
 .fi
+.SH SEE ALSO
+.UR http://git.\:kernel.\:org\:/cgit\:/linux\:/kernel\:/git\:/torvalds\:/linux.git\:/tree\:/Documentation\:/admin-guide\:/blockdev\:/zram.rst
+Linux kernel documentation
+.UE .
 .SH AVAILABILITY
 The zramctl command is part of the util-linux package and is available from
 https://www.kernel.org/pub/linux/utils/util-linux/.
diff --git a/term-utils/mesg.1 b/term-utils/mesg.1
index 9d11137ca..075097152 100644
--- a/term-utils/mesg.1
+++ b/term-utils/mesg.1
@@ -102,17 +102,17 @@ An error has occurred.
 .RE
 .SH FILES
 .I /dev/[pt]ty[pq]?
+.SH HISTORY
+A
+.B mesg
+command appeared in Version 6 AT&T UNIX.
+
 .SH SEE ALSO
 .BR login (1),
 .BR talk (1),
 .BR write (1),
 .BR wall (1),
 .BR xterm (1)
-.SH HISTORY
-A
-.B mesg
-command appeared in Version 6 AT&T UNIX.
-
 .SH AVAILABILITY
 The mesg command is part of the util-linux package and is available from
 https://www.kernel.org/pub/linux/utils/util-linux/.
diff --git a/term-utils/script.1 b/term-utils/script.1
index 52f624754..73ec27c2e 100644
--- a/term-utils/script.1
+++ b/term-utils/script.1
@@ -259,13 +259,6 @@ will be that shell.  If
 .B SHELL
 is not set, the Bourne shell is assumed.  (Most shells set this variable
 automatically).
-.SH SEE ALSO
-.BR csh (1)
-(for the
-.I history
-mechanism),
-.BR scriptreplay (1),
-.BR scriptlive (1),
 .SH HISTORY
 The
 .B script
@@ -283,6 +276,13 @@ is not a terminal (for example: \fBecho foo | script\fR), then the session
 can hang, because the interactive shell within the script session misses EOF and
 .B script
 has no clue when to close the session.  See the \fBNOTES\fR section for more information.
+.SH SEE ALSO
+.BR csh (1)
+(for the
+.I history
+mechanism),
+.BR scriptreplay (1),
+.BR scriptlive (1),
 .SH AVAILABILITY
 The script command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
diff --git a/term-utils/scriptlive.1 b/term-utils/scriptlive.1
index 190724eef..6639c73d1 100644
--- a/term-utils/scriptlive.1
+++ b/term-utils/scriptlive.1
@@ -75,9 +75,10 @@ Script started, file is script.out
 Script done, file is script.out
 % scriptlive --log-timing file.tm --log-in script.in
 .nf
-.SH SEE ALSO
-.BR script (1),
-.BR scriptreplay (1)
+.SH AUTHORS
+.MT kzak@\:redhat.com
+Karel Zak
+.ME .
 .SH COPYRIGHT
 Copyright \(co 2019 Karel Zak
 .PP
@@ -86,10 +87,9 @@ warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
 PURPOSE.
 .PP
 Released under the GNU General Public License version 2 or later.
-.SH AUTHORS
-.MT kzak@\:redhat.com
-Karel Zak
-.ME .
+.SH SEE ALSO
+.BR script (1),
+.BR scriptreplay (1)
 .SH AVAILABILITY
 The scriptlive command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
diff --git a/term-utils/scriptreplay.1 b/term-utils/scriptreplay.1
index e02e2cb14..4505ef836 100644
--- a/term-utils/scriptreplay.1
+++ b/term-utils/scriptreplay.1
@@ -120,19 +120,6 @@ Script started, file is script.out
 Script done, file is script.out
 % scriptreplay --log-timing file.tm --log-out script.out
 .nf
-.SH SEE ALSO
-.BR script (1),
-.BR scriptlive (1)
-.SH COPYRIGHT
-Copyright \(co 2008 James Youngman
-.br
-Copyright \(co 2008-2019 Karel Zak
-.PP
-This is free software; see the source for copying conditions.  There is NO
-warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
-PURPOSE.
-.PP
-Released under the GNU General Public License version 2 or later.
 .SH AUTHORS
 The original
 .B scriptreplay
@@ -148,6 +135,19 @@ and
 .MT kzak@\:redhat.com
 Karel Zak
 .ME .
+.SH COPYRIGHT
+Copyright \(co 2008 James Youngman
+.br
+Copyright \(co 2008-2019 Karel Zak
+.PP
+This is free software; see the source for copying conditions.  There is NO
+warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
+PURPOSE.
+.PP
+Released under the GNU General Public License version 2 or later.
+.SH SEE ALSO
+.BR script (1),
+.BR scriptlive (1)
 .SH AVAILABILITY
 The scriptreplay command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
diff --git a/term-utils/setterm.1 b/term-utils/setterm.1
index bad4ab0e1..42bad04d5 100644
--- a/term-utils/setterm.1
+++ b/term-utils/setterm.1
@@ -293,13 +293,13 @@ beside the historical long options with a single hyphen, for example
 In scripts it is better to use the backward-compatible single hyphen
 rather than the double hyphen.  Currently there are no plans nor good
 reasons to discontinue single-hyphen compatibility.
+.SH BUGS
+Differences between the Minix and Linux versions are not documented.
 .SH SEE ALSO
 .BR stty (1),
 .BR tput (1),
 .BR tty (4),
 .BR terminfo (5)
-.SH BUGS
-Differences between the Minix and Linux versions are not documented.
 .SH AVAILABILITY
 The setterm command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
diff --git a/term-utils/wall.1 b/term-utils/wall.1
index 048de996e..aada25c74 100644
--- a/term-utils/wall.1
+++ b/term-utils/wall.1
@@ -87,15 +87,15 @@ Some sessions, such as wdm, that have in the beginning of
 ut_type data a ':' character will not get the message from
 .BR wall .
 This is done to avoid write errors.
+.SH HISTORY
+A
+.B wall
+command appeared in Version 7 AT&T UNIX.
 .SH SEE ALSO
 .BR mesg (1),
 .BR talk (1),
 .BR write (1),
 .BR shutdown (8)
-.SH HISTORY
-A
-.B wall
-command appeared in Version 7 AT&T UNIX.
 .SH AVAILABILITY
 The wall command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
diff --git a/term-utils/write.1 b/term-utils/write.1
index 8f6ccec3b..caadbcb93 100644
--- a/term-utils/write.1
+++ b/term-utils/write.1
@@ -88,14 +88,14 @@ The traditional protocol for writing to someone is that the string `\-o',
 either at the end of a line or on a line by itself, means that it's the
 other person's turn to talk.  The string `oo' means that the person
 believes the conversation to be over.
-.SH SEE ALSO
-.BR mesg (1),
-.BR talk (1),
-.BR who (1)
 .SH HISTORY
 A
 .B write
 command appeared in Version 6 AT&T UNIX.
+.SH SEE ALSO
+.BR mesg (1),
+.BR talk (1),
+.BR who (1)
 .SH AVAILABILITY
 The write command is part of the util-linux package and is available from
 https://www.kernel.org/pub/linux/utils/util-linux/.
diff --git a/text-utils/col.1 b/text-utils/col.1
index 2a9c4dce5..322f0afe5 100644
--- a/text-utils/col.1
+++ b/text-utils/col.1
@@ -137,10 +137,6 @@ character set is correct when they are output.
 If the input attempts to back up to the last flushed line,
 .B col
 will display a warning message.
-.SH SEE ALSO
-.BR expand (1),
-.BR nroff (1),
-.BR tbl (1)
 .SH CONFORMING TO
 The
 .B col
@@ -151,6 +147,10 @@ option is an extension to the standard.
 A
 .B col
 command appeared in Version 6 AT&T UNIX.
+.SH SEE ALSO
+.BR expand (1),
+.BR nroff (1),
+.BR tbl (1)
 .SH AVAILABILITY
 The col command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
diff --git a/text-utils/colcrt.1 b/text-utils/colcrt.1
index 341d34c83..5f8bf445b 100644
--- a/text-utils/colcrt.1
+++ b/text-utils/colcrt.1
@@ -74,12 +74,6 @@ would be:
 .RS
 .B tbl exum2.n \&| nroff \-ms \&| colcrt \- \&| more
 .RE
-.SH SEE ALSO
-.BR col (1),
-.BR more (1),
-.BR nroff (1),
-.BR troff (1),
-.BR ul (1)
 .SH BUGS
 Should fold underlines onto blanks even with the
 .B '\-'
@@ -98,6 +92,12 @@ documents which are already double-spaced.
 The
 .B colcrt
 command appeared in 3.0BSD.
+.SH SEE ALSO
+.BR col (1),
+.BR more (1),
+.BR nroff (1),
+.BR troff (1),
+.BR ul (1)
 .SH AVAILABILITY
 The colcrt command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
diff --git a/text-utils/colrm.1 b/text-utils/colrm.1
index 4950f2885..979137f71 100644
--- a/text-utils/colrm.1
+++ b/text-utils/colrm.1
@@ -59,15 +59,15 @@ Display version information and exit.
 .TP
 \fB\-h\fR, \fB\-\-help\fR
 Display help text and exit.
+.SH HISTORY
+The
+.B colrm
+command appeared in 3.0BSD.
 .SH SEE ALSO
 .BR awk (1p),
 .BR column (1),
 .BR expand (1),
 .BR paste (1)
-.SH HISTORY
-The
-.B colrm
-command appeared in 3.0BSD.
 .SH AVAILABILITY
 The colrm command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
diff --git a/text-utils/column.1 b/text-utils/column.1
index 7ca8a8b31..23f582b37 100644
--- a/text-utils/column.1
+++ b/text-utils/column.1
@@ -177,13 +177,13 @@ has since been corrected (see above). Other implementations of
 .B column
 may continue to use the older documentation, but the behavior should be
 identical in any case.
+.SH HISTORY
+The column command appeared in 4.3BSD-Reno.
 .SH SEE ALSO
 .BR colrm (1),
 .BR ls (1),
 .BR paste (1),
 .BR sort (1)
-.SH HISTORY
-The column command appeared in 4.3BSD-Reno.
 .SH AVAILABILITY
 The column command is part of the util-linux package and is available from
 https://www.kernel.org/pub/linux/utils/util-linux/.
diff --git a/text-utils/more.1 b/text-utils/more.1
index 4cf445f87..046c2c4c6 100644
--- a/text-utils/more.1
+++ b/text-utils/more.1
@@ -234,15 +234,6 @@ is pressed.
 The editor of choice when
 .B VISUAL
 is not specified.
-.SH SEE ALSO
-.BR less (1),
-.BR vi (1)
-.SH AUTHORS
-Eric Shienbrood, UC Berkeley
-.br
-Modified by Geoff Peck, UCB to add underlining, single spacing
-.br
-Modified by John Foderaro, UCB to add \-c and MORE environment variable
 .SH HISTORY
 The
 .B more
@@ -251,6 +242,15 @@ command appeared in 3.0BSD.  This man page documents
 version 5.19 (Berkeley 6/29/88), which is currently in use in the Linux
 community.  Documentation was produced using several other versions of the
 man page, and extensive inspection of the source code.
+.SH AUTHORS
+Eric Shienbrood, UC Berkeley
+.br
+Modified by Geoff Peck, UCB to add underlining, single spacing
+.br
+Modified by John Foderaro, UCB to add \-c and MORE environment variable
+.SH SEE ALSO
+.BR less (1),
+.BR vi (1)
 .SH AVAILABILITY
 The more command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
diff --git a/text-utils/pg.1 b/text-utils/pg.1
index a7fd60134..1200ab81a 100644
--- a/text-utils/pg.1
+++ b/text-utils/pg.1
@@ -217,14 +217,6 @@ Used by the
 .TP
 .B TERM
 Determines the terminal type.
-.SH SEE ALSO
-.BR cat (1),
-.BR more (1),
-.BR sh (1p),
-.BR terminfo (5),
-.BR locale (7),
-.BR regex (7),
-.BR term (7)
 .SH NOTES
 .B pg
 expects the terminal tabulators to be set every eight positions.
@@ -233,6 +225,14 @@ Files that include
 .SM NUL
 characters cannot be displayed by
 .BR pg .
+.SH SEE ALSO
+.BR cat (1),
+.BR more (1),
+.BR sh (1p),
+.BR terminfo (5),
+.BR locale (7),
+.BR regex (7),
+.BR term (7)
 .SH AVAILABILITY
 The pg command is part of the util-linux package and is available from
 https://www.kernel.org/pub/linux/utils/util-linux/.
diff --git a/text-utils/ul.1 b/text-utils/ul.1
index 172844ce1..7dc9ddd7b 100644
--- a/text-utils/ul.1
+++ b/text-utils/ul.1
@@ -90,13 +90,6 @@ or as set during the login process by the user in their
 .B login
 file (see
 .BR setenv (3)).
-.SH SEE ALSO
-.BR colcrt (1),
-.BR login (1),
-.BR man (1),
-.BR nroff (1),
-.BR setenv (3),
-.BR terminfo (5)
 .SH BUGS
 .B nroff
 usually outputs a series of backspaces and underlines intermixed with the
@@ -106,6 +99,13 @@ motion.
 The
 .B ul
 command appeared in 3.0BSD.
+.SH SEE ALSO
+.BR colcrt (1),
+.BR login (1),
+.BR man (1),
+.BR nroff (1),
+.BR setenv (3),
+.BR terminfo (5)
 .SH AVAILABILITY
 The ul command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
-- 
2.26.2

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
