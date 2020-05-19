Return-Path: <SRS0=ZMjy=7B=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CC2C433E1
	for <util-linux@archiver.kernel.org>; Tue, 19 May 2020 12:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B77392081A
	for <util-linux@archiver.kernel.org>; Tue, 19 May 2020 12:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcRMKQ/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgESMvf (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 19 May 2020 08:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgESMvc (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 19 May 2020 08:51:32 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E45EC08C5C0
        for <util-linux@vger.kernel.org>; Tue, 19 May 2020 05:51:32 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h17so15744490wrc.8
        for <util-linux@vger.kernel.org>; Tue, 19 May 2020 05:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=perIxy9eNUNwp7iq/Msz5mVNdoPDXuJfnjmFBHs/2SA=;
        b=lcRMKQ/5LXP0196RC9YV1i8DV0Il+FbvH/uZ8faTfNbuIMLrXtjVx91j/N+yj4Eobs
         gq1srSkaDZ8n1r0CysMPRz/nYeTh101cj9g7cBhWljhUq0VQN8ZWIt6j/lTftJuz7n9w
         3B6AFZVVBlGbFqET7iuSl9xO8U+0UCtx1cES0ILlEO6ErHQauajgVaRo2pbaZxvUUJeG
         avIEKWU9+zEGsj0UamZIPug201GrB1+MU/9KKQ4Z0gHmkui4IKPXQRksuP4waJdn48AP
         02E66+cA6epOnYwflg+TgJ76T2aEDaYG81L4yn7fzqDii3rJUj3dsTlE88TwnAtw7t3+
         pddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=perIxy9eNUNwp7iq/Msz5mVNdoPDXuJfnjmFBHs/2SA=;
        b=Tqq6Lz15jwtFyC59n8mrzhqP+azR7sSOI/tm+jVuiFnwjnnJisySPykUIaL7o77sK5
         smR0EXXqvpj9q0tC9z+N2PNxd9OBMNAAVg2WeuMa8Cm9pBIj826uUTF0HFTUNR9gutC+
         BZo6TTIwU+qTKWNUS2WD0RK5zc9zsMIiuJhLLx+cOlGkv7V8XFrjY73BC2UIbQWPP1of
         nZ1MBLWB4Tyv8GP9Xch8EUCFGDkV8EyII1dBRbSZlTtRQZn5WODhGI+U2dcJfr1H8RvS
         StAi7DkO+9MKNYenqi/jRzJXnmPWRvAnw8uCCpNuzKMozPlL7VOz1zAgXMZCSqIqz/Q3
         BgeA==
X-Gm-Message-State: AOAM532sgXJTSrAiATOpvWSqxRv7xXXJxvisBDJH3ukdBkbfblG5cH9D
        GNPuBn8kLQlqegRQY9eYdjNH8BHoN6s=
X-Google-Smtp-Source: ABdhPJwNWl8LGcsdZb0IbQJMlTL7oHdcr5Se0iPS1wtemlEkyi8FQx8mvd1wn+R7EORGib/HdNkhxA==
X-Received: by 2002:a5d:4b4d:: with SMTP id w13mr27293989wrs.178.1589892689829;
        Tue, 19 May 2020 05:51:29 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id 5sm3906260wmz.16.2020.05.19.05.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 05:51:28 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, util-linux@vger.kernel.org
To:     Karel Zak <kzak@redhat.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: [PATCH 1/7] Manual pages: Standardize on AUTHORS as section title
Message-ID: <4bfbe76e-4bde-289c-2a8f-b29e1d3aaae1@gmail.com>
Date:   Tue, 19 May 2020 14:51:28 +0200
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

There is quite some value (in terms of readability and user
expectations) if consistent names are used for the sections
within manual pages. This patch is one of a series to bring
about this consistency.

In the Linux man-pages project, I long ago did away with the
AUTHOR(S) section, but I realize some projects like to keep this.

But, let's make sure that the section is consistently titled
across pages. Currently we have AUTHOR (47) or AUTHORS (41).
Let's standardize on the latter (which is also what is
suggested in man-pages(7)).

Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
---
 disk-utils/blockdev.8       | 2 +-
 disk-utils/cfdisk.8         | 2 +-
 disk-utils/fdformat.8       | 2 +-
 disk-utils/raw.8            | 2 +-
 disk-utils/sfdisk.8         | 2 +-
 disk-utils/swaplabel.8      | 2 +-
 libblkid/libblkid.3         | 2 +-
 libuuid/man/uuid.3          | 2 +-
 libuuid/man/uuid_clear.3    | 2 +-
 libuuid/man/uuid_compare.3  | 2 +-
 libuuid/man/uuid_copy.3     | 2 +-
 libuuid/man/uuid_generate.3 | 2 +-
 libuuid/man/uuid_is_null.3  | 2 +-
 libuuid/man/uuid_parse.3    | 2 +-
 libuuid/man/uuid_time.3     | 2 +-
 libuuid/man/uuid_unparse.3  | 2 +-
 login-utils/chfn.1          | 2 +-
 login-utils/chsh.1          | 2 +-
 login-utils/last.1          | 2 +-
 login-utils/login.1         | 2 +-
 login-utils/newgrp.1        | 2 +-
 login-utils/sulogin.8       | 2 +-
 login-utils/utmpdump.1      | 2 +-
 misc-utils/blkid.8          | 2 +-
 misc-utils/findfs.8         | 2 +-
 misc-utils/hardlink.1       | 2 +-
 misc-utils/namei.1          | 2 +-
 misc-utils/uuidgen.1        | 2 +-
 misc-utils/wipefs.8         | 2 +-
 schedutils/taskset.1        | 2 +-
 sys-utils/blkdiscard.8      | 2 +-
 sys-utils/chcpu.8           | 2 +-
 sys-utils/ctrlaltdel.8      | 2 +-
 sys-utils/flock.1           | 2 +-
 sys-utils/fsfreeze.8        | 2 +-
 sys-utils/fstrim.8          | 2 +-
 sys-utils/ipcmk.1           | 2 +-
 sys-utils/ipcs.1            | 2 +-
 sys-utils/ldattach.8        | 2 +-
 sys-utils/lscpu.1           | 2 +-
 sys-utils/lsmem.1           | 2 +-
 sys-utils/mountpoint.1      | 2 +-
 sys-utils/setarch.8         | 2 +-
 sys-utils/setpriv.1         | 2 +-
 sys-utils/setsid.1          | 2 +-
 term-utils/scriptlive.1     | 2 +-
 term-utils/scriptreplay.1   | 2 +-
 47 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/disk-utils/blockdev.8 b/disk-utils/blockdev.8
index 5d85c01b7..361e6aad7 100644
--- a/disk-utils/blockdev.8
+++ b/disk-utils/blockdev.8
@@ -86,7 +86,7 @@ Set read-only. The currently active access to the device may not be affected by
 filesystem already mounted in read-write mode will not be affected. The change applies after remount.
 .IP "\fB\-\-setrw\fP"
 Set read-write.
-.SH AUTHOR
+.SH AUTHORS
 blockdev was written by Andries E.\& Brouwer and rewritten by Karel Zak.
 .SH AVAILABILITY
 The blockdev command is part of the util-linux package and is available from
diff --git a/disk-utils/cfdisk.8 b/disk-utils/cfdisk.8
index ae874fb89..231a877c6 100644
--- a/disk-utils/cfdisk.8
+++ b/disk-utils/cfdisk.8
@@ -193,7 +193,7 @@ use visible padding characters. Requires enabled LIBSMARTCOLS_DEBUG.
 .BR partprobe (8),
 .BR partx (8),
 .BR sfdisk (8)
-.SH AUTHOR
+.SH AUTHORS
 Karel Zak <kzak@redhat.com>
 .PP
 The current cfdisk implementation is based on the original cfdisk
diff --git a/disk-utils/fdformat.8 b/disk-utils/fdformat.8
index ecff66280..97c67a01a 100644
--- a/disk-utils/fdformat.8
+++ b/disk-utils/fdformat.8
@@ -67,7 +67,7 @@ Display help text and exit.
 .BR emkfs (8),
 .BR mkfs (8),
 .BR setfdprm (8)
-.SH AUTHOR
+.SH AUTHORS
 Werner Almesberger (almesber@nessie.cs.id.ethz.ch)
 .SH AVAILABILITY
 The fdformat command is part of the util-linux package and is available from
diff --git a/disk-utils/raw.8 b/disk-utils/raw.8
index 5a3b96e3c..fcf996c5b 100644
--- a/disk-utils/raw.8
+++ b/disk-utils/raw.8
@@ -92,7 +92,7 @@ but is regarded either a bug or a feature depending on who you ask!
 Rather than using raw devices applications should prefer
 .BR open (2)
 devices, such as /dev/sda1, with the O_DIRECT flag.
-.SH AUTHOR
+.SH AUTHORS
 Stephen Tweedie (sct@redhat.com)
 .SH AVAILABILITY
 The raw command is part of the util-linux package and is available from
diff --git a/disk-utils/sfdisk.8 b/disk-utils/sfdisk.8
index ead807b8d..ff2a42aaf 100644
--- a/disk-utils/sfdisk.8
+++ b/disk-utils/sfdisk.8
@@ -627,7 +627,7 @@ enables libsmartcols debug output.
 .BR partprobe (8),
 .BR partx (8)
 
-.SH AUTHOR
+.SH AUTHORS
 Karel Zak <kzak@redhat.com>
 .PP
 The current sfdisk implementation is based on the original sfdisk
diff --git a/disk-utils/swaplabel.8 b/disk-utils/swaplabel.8
index d96d507af..cea8fc356 100644
--- a/disk-utils/swaplabel.8
+++ b/disk-utils/swaplabel.8
@@ -55,7 +55,7 @@ The \fI UUID\fR
 must be in the standard 8-4-4-4-12 character format, such as is output by
 .BR uuidgen (1).
 .PP
-.SH AUTHOR
+.SH AUTHORS
 .B swaplabel
 was written by Jason Borden <jborden@bluehost.com> and Karel Zak <kzak@redhat.com>.
 .SH ENVIRONMENT
diff --git a/libblkid/libblkid.3 b/libblkid/libblkid.3
index 4b9e74bba..a3795ab79 100644
--- a/libblkid/libblkid.3
+++ b/libblkid/libblkid.3
@@ -61,7 +61,7 @@ config file can be overridden by the environment variable BLKID_CONF.  For more
 details about the config file see
 .BR blkid (8)
 man page.
-.SH AUTHOR
+.SH AUTHORS
 .B libblkid
 was written by Andreas Dilger for the ext2 filesystem utilities, with input
 from Ted Ts'o.  The library was subsequently heavily modified by Ted Ts'o.
diff --git a/libuuid/man/uuid.3 b/libuuid/man/uuid.3
index a596e42e7..be2a63adb 100644
--- a/libuuid/man/uuid.3
+++ b/libuuid/man/uuid.3
@@ -49,7 +49,7 @@ of a name clash.
 .SH CONFORMING TO
 This library generates UUIDs compatible with OSF DCE 1.1, and hash based UUIDs
 V3 and V5 compatible with RFC-4122.
-.SH AUTHOR
+.SH AUTHORS
 Theodore Y.\& Ts'o
 .SH AVAILABILITY
 .B libuuid
diff --git a/libuuid/man/uuid_clear.3 b/libuuid/man/uuid_clear.3
index 9cc9b5db1..84c88838a 100644
--- a/libuuid/man/uuid_clear.3
+++ b/libuuid/man/uuid_clear.3
@@ -44,7 +44,7 @@ The
 function sets the value of the supplied uuid variable
 .I uu
 to the NULL value.
-.SH AUTHOR
+.SH AUTHORS
 Theodore Y.\& Ts'o
 .SH AVAILABILITY
 .B libuuid
diff --git a/libuuid/man/uuid_compare.3 b/libuuid/man/uuid_compare.3
index 46759e282..ddac24849 100644
--- a/libuuid/man/uuid_compare.3
+++ b/libuuid/man/uuid_compare.3
@@ -50,7 +50,7 @@ Returns an integer less than, equal to, or greater than zero if
 is found,  respectively, to be lexicographically less than, equal, or
 greater than
 .IR uu2 .
-.SH AUTHOR
+.SH AUTHORS
 Theodore Y.\& Ts'o
 .SH AVAILABILITY
 .B libuuid
diff --git a/libuuid/man/uuid_copy.3 b/libuuid/man/uuid_copy.3
index 09fb30cfe..fc03e00eb 100644
--- a/libuuid/man/uuid_copy.3
+++ b/libuuid/man/uuid_copy.3
@@ -46,7 +46,7 @@ function copies the UUID variable
 .SH RETURN VALUE
 The copied UUID is returned in the location pointed to by
 .IR dst .
-.SH AUTHOR
+.SH AUTHORS
 Theodore Y.\& Ts'o
 .SH AVAILABILITY
 .B libuuid
diff --git a/libuuid/man/uuid_generate.3 b/libuuid/man/uuid_generate.3
index 544a96e67..78206d9c0 100644
--- a/libuuid/man/uuid_generate.3
+++ b/libuuid/man/uuid_generate.3
@@ -118,7 +118,7 @@ returns zero if the UUID has been generated in a safe manner, \-1 otherwise.
 .SH CONFORMING TO
 This library generates UUIDs compatible with OSF DCE 1.1, and hash based UUIDs
 V3 and V5 compatible with RFC-4122.
-.SH AUTHOR
+.SH AUTHORS
 Theodore Y.\& Ts'o
 .SH AVAILABILITY
 .B libuuid
diff --git a/libuuid/man/uuid_is_null.3 b/libuuid/man/uuid_is_null.3
index fea469e46..2842174da 100644
--- a/libuuid/man/uuid_is_null.3
+++ b/libuuid/man/uuid_is_null.3
@@ -45,7 +45,7 @@ function compares the value of the supplied UUID variable
 .I uu
 to the NULL value.  If the value is equal to the NULL UUID, 1 is returned,
 otherwise 0 is returned.
-.SH AUTHOR
+.SH AUTHORS
 Theodore Y.\& Ts'o
 .SH AVAILABILITY
 .B libuuid
diff --git a/libuuid/man/uuid_parse.3 b/libuuid/man/uuid_parse.3
index c3a5f8801..1cab7b8d8 100644
--- a/libuuid/man/uuid_parse.3
+++ b/libuuid/man/uuid_parse.3
@@ -67,7 +67,7 @@ otherwise \-1 is returned.
 .SH CONFORMING TO
 This library parses UUIDs compatible with OSF DCE 1.1, and hash based UUIDs V3
 and V5 compatible with RFC-4122.
-.SH AUTHOR
+.SH AUTHORS
 Theodore Y.\& Ts'o
 .SH AVAILABILITY
 .B libuuid
diff --git a/libuuid/man/uuid_time.3 b/libuuid/man/uuid_time.3
index 91e29e8bb..9c1fdea4e 100644
--- a/libuuid/man/uuid_time.3
+++ b/libuuid/man/uuid_time.3
@@ -59,7 +59,7 @@ the epoch, is also stored in the location pointed to by
 .I ret_tv
 (see
 .BR gettimeofday "(2))."
-.SH AUTHOR
+.SH AUTHORS
 Theodore Y.\& Ts'o
 .SH AVAILABILITY
 .B libuuid
diff --git a/libuuid/man/uuid_unparse.3 b/libuuid/man/uuid_unparse.3
index 4a7096e92..5f4ed5e00 100644
--- a/libuuid/man/uuid_unparse.3
+++ b/libuuid/man/uuid_unparse.3
@@ -62,7 +62,7 @@ and
 may be used.
 .SH CONFORMING TO
 This library unparses UUIDs compatible with OSF DCE 1.1.
-.SH AUTHOR
+.SH AUTHORS
 Theodore Y.\& Ts'o
 .SH AVAILABILITY
 .B libuuid
diff --git a/login-utils/chfn.1 b/login-utils/chfn.1
index 592ca8ff7..8ac9c2c22 100644
--- a/login-utils/chfn.1
+++ b/login-utils/chfn.1
@@ -101,7 +101,7 @@ Returns 0 if operation was successful, 1 if operation failed or command syntax w
 .BR finger (1),
 .BR login.defs (5),
 .BR passwd (5)
-.SH AUTHOR
+.SH AUTHORS
 Salvatore Valente <svalente@mit.edu>
 .SH AVAILABILITY
 The chfn command is part of the util-linux package and is available from
diff --git a/login-utils/chsh.1 b/login-utils/chsh.1
index eefcdb958..e6642084a 100644
--- a/login-utils/chsh.1
+++ b/login-utils/chsh.1
@@ -60,7 +60,7 @@ Returns 0 if operation was successful, 1 if operation failed or command syntax w
 .BR login.defs (5),
 .BR passwd (5),
 .BR shells (5)
-.SH AUTHOR
+.SH AUTHORS
 Salvatore Valente <svalente@mit.edu>
 .SH AVAILABILITY
 The chsh command is part of the util-linux package and is available from
diff --git a/login-utils/last.1 b/login-utils/last.1
index 2fca5a159..852d82aa6 100644
--- a/login-utils/last.1
+++ b/login-utils/last.1
@@ -182,7 +182,7 @@ command (for example,
 /var/log/wtmp
 .br
 /var/log/btmp
-.SH AUTHOR
+.SH AUTHORS
 .MT miquels@cistron.nl
 Miquel van Smoorenburg
 .ME
diff --git a/login-utils/login.1 b/login-utils/login.1
index 43175f6a6..ef893f602 100644
--- a/login-utils/login.1
+++ b/login-utils/login.1
@@ -363,7 +363,7 @@ then the surrounding shell gets killed by vhangup() because it's no
 longer the true owner of the tty.  This can be avoided by using
 .B exec login
 in a top-level shell or xterm.
-.SH AUTHOR
+.SH AUTHORS
 Derived from BSD login 5.40 (5/9/89) by
 .MT glad@\:daimi.\:dk
 Michael Glad
diff --git a/login-utils/newgrp.1 b/login-utils/newgrp.1
index c29461010..b4b308d1f 100644
--- a/login-utils/newgrp.1
+++ b/login-utils/newgrp.1
@@ -25,7 +25,7 @@ If no group is specified, the GID is changed to the login GID.
 .BR login (1),
 .BR group (5)
 
-.SH AUTHOR
+.SH AUTHORS
 Originally by Michael Haardt. Currently maintained by
 Peter Orbaek (poe@daimi.aau.dk).
 
diff --git a/login-utils/sulogin.8 b/login-utils/sulogin.8
index 7998b4aca..d5b24383d 100644
--- a/login-utils/sulogin.8
+++ b/login-utils/sulogin.8
@@ -84,7 +84,7 @@ will try to execute root's shell from
 If that fails, it
 will fall back to
 .IR /bin/sh .
-.SH AUTHOR
+.SH AUTHORS
 .B sulogin
 was written by Miquel van Smoorenburg for sysvinit and later ported
 to util-linux by Dave Reisner and Karel Zak.
diff --git a/login-utils/utmpdump.1 b/login-utils/utmpdump.1
index 19835de31..4085f1760 100644
--- a/login-utils/utmpdump.1
+++ b/login-utils/utmpdump.1
@@ -78,7 +78,7 @@ option, as the format for the utmp/wtmp files strongly depends on the input
 format.  This tool was
 .B not
 written for normal use, but for debugging only.
-.SH AUTHOR
+.SH AUTHORS
 Michael Krapp
 .SH SEE ALSO
 .BR last (1),
diff --git a/misc-utils/blkid.8 b/misc-utils/blkid.8
index e95e75038..6ef73f33c 100644
--- a/misc-utils/blkid.8
+++ b/misc-utils/blkid.8
@@ -327,7 +327,7 @@ a comma-separated list.  Default is "udev,scan".  The "udev" method uses udev
 symlinks and the "scan" method scans all block devices from the
 .I /proc/partitions
 file.
-.SH AUTHOR
+.SH AUTHORS
 .B blkid
 was written by Andreas Dilger for libblkid and improved by Theodore Ts'o
 and Karel Zak.
diff --git a/misc-utils/findfs.8 b/misc-utils/findfs.8
index 1d15d4939..22c7c3ddc 100644
--- a/misc-utils/findfs.8
+++ b/misc-utils/findfs.8
@@ -60,7 +60,7 @@ label or uuid cannot be found
 usage error, wrong number of arguments or unknown option
 .PD
 .RE
-.SH AUTHOR
+.SH AUTHORS
 .B findfs
 was originally written by
 .MT tytso@mit.edu
diff --git a/misc-utils/hardlink.1 b/misc-utils/hardlink.1
index 58e48c7df..26db12d9b 100644
--- a/misc-utils/hardlink.1
+++ b/misc-utils/hardlink.1
@@ -48,7 +48,7 @@ Display help text and exit.
 .TP
 .BR \-V , " \-\-version"
 Display version information and exit.
-.SH AUTHOR
+.SH AUTHORS
 .PP
 \fBhardlink\fR was written by Jakub Jelinek <jakub@redhat.com> and later modified by
 Ruediger Meier <ruediger.meier@ga-group.nl> and Karel Zak <kzak@redhat.com> for util-linux.
diff --git a/misc-utils/namei.1 b/misc-utils/namei.1
index f8ac8cc2d..f44f80476 100644
--- a/misc-utils/namei.1
+++ b/misc-utils/namei.1
@@ -63,7 +63,7 @@ Display version information and exit.
 .TP
 .BR \-h , " \-\-help"
 Display help text and exit.
-.SH AUTHOR
+.SH AUTHORS
 The original
 .B namei
 program was written by Roger Southwick <rogers@amadeus.wr.tek.com>.
diff --git a/misc-utils/uuidgen.1 b/misc-utils/uuidgen.1
index b9c265901..0189587a3 100644
--- a/misc-utils/uuidgen.1
+++ b/misc-utils/uuidgen.1
@@ -91,7 +91,7 @@ Interpret name \fIname\fR as a hexadecimal string.
 OSF DCE 1.1
 .SH EXAMPLES
 uuidgen \-\-sha1 \-\-namespace @dns \-\-name "www.example.com"
-.SH AUTHOR
+.SH AUTHORS
 .B uuidgen
 was written by Andreas Dilger for libuuid.
 .SH SEE ALSO
diff --git a/misc-utils/wipefs.8 b/misc-utils/wipefs.8
index b755df903..8882ed84a 100644
--- a/misc-utils/wipefs.8
+++ b/misc-utils/wipefs.8
@@ -123,7 +123,7 @@ file ~/wipefs-sdb-<offset>.bak for each signature.
 .TP
 .B dd if=~/wipefs-sdb-0x00000438.bak of=/dev/sdb seek=$((0x00000438)) bs=1 conv=notrunc
 Restores an ext2 signature from the backup file  ~/wipefs-sdb-0x00000438.bak.
-.SH AUTHOR
+.SH AUTHORS
 Karel Zak <kzak@redhat.com>
 .SH ENVIRONMENT
 .IP LIBBLKID_DEBUG=all
diff --git a/schedutils/taskset.1 b/schedutils/taskset.1
index dc3d25666..e73000bf3 100644
--- a/schedutils/taskset.1
+++ b/schedutils/taskset.1
@@ -129,7 +129,7 @@ A user can retrieve the affinity mask of any process.
 See
 .BR sched (7)
 for a description of the Linux scheduling scheme.
-.SH AUTHOR
+.SH AUTHORS
 Written by Robert M. Love.
 .SH COPYRIGHT
 Copyright \(co 2004 Robert M. Love.
diff --git a/sys-utils/blkdiscard.8 b/sys-utils/blkdiscard.8
index bd3950b1f..d39e85522 100644
--- a/sys-utils/blkdiscard.8
+++ b/sys-utils/blkdiscard.8
@@ -77,7 +77,7 @@ Display version information and exit.
 .TP
 .BR \-h , " \-\-help"
 Display help text and exit.
-.SH AUTHOR
+.SH AUTHORS
 .MT lczerner@redhat.com
 Lukas Czerner
 .ME
diff --git a/sys-utils/chcpu.8 b/sys-utils/chcpu.8
index 3626fc910..23191e2b9 100644
--- a/sys-utils/chcpu.8
+++ b/sys-utils/chcpu.8
@@ -89,7 +89,7 @@ failure
 .TP
 .B 64
 partial success
-.SH AUTHOR
+.SH AUTHORS
 .MT heiko.carstens@de.ibm.com
 Heiko Carstens
 .ME
diff --git a/sys-utils/ctrlaltdel.8 b/sys-utils/ctrlaltdel.8
index 9310af974..7cd340d09 100644
--- a/sys-utils/ctrlaltdel.8
+++ b/sys-utils/ctrlaltdel.8
@@ -47,7 +47,7 @@ Display help text and exit.
 .SH SEE ALSO
 .BR init (8),
 .BR systemd (1)
-.SH AUTHOR
+.SH AUTHORS
 .UR poe@daimi.aau.dk
 Peter Orbaek
 .UE
diff --git a/sys-utils/flock.1 b/sys-utils/flock.1
index d0e17fe01..fba4ec8c0 100644
--- a/sys-utils/flock.1
+++ b/sys-utils/flock.1
@@ -188,7 +188,7 @@ option, or 1 by default.
 .PP
 When using the \fIcommand\fR variant, and executing the child worked, then
 the exit status is that of the child command.
-.SH AUTHOR
+.SH AUTHORS
 .UR hpa@zytor.com
 H. Peter Anvin
 .UE
diff --git a/sys-utils/fsfreeze.8 b/sys-utils/fsfreeze.8
index 3cd67382e..2ca445aeb 100644
--- a/sys-utils/fsfreeze.8
+++ b/sys-utils/fsfreeze.8
@@ -75,7 +75,7 @@ and
 Previous list may be incomplete, as more filesystems get support.  If in
 doubt easiest way to know if a filesystem has support is create a small
 loopback mount and test freezing it.
-.SH AUTHOR
+.SH AUTHORS
 .PP
 Written by Hajime Taira.
 .SH NOTES
diff --git a/sys-utils/fstrim.8 b/sys-utils/fstrim.8
index ef6772a96..e3857f9d0 100644
--- a/sys-utils/fstrim.8
+++ b/sys-utils/fstrim.8
@@ -129,7 +129,7 @@ The command
 .B fstrim \-\-all
 returns 0 (all succeeded), 32 (all failed) or 64 (some failed, some succeeded).
 
-.SH AUTHOR
+.SH AUTHORS
 .nf
 Lukas Czerner <lczerner@redhat.com>
 Karel Zak <kzak@redhat.com>
diff --git a/sys-utils/ipcmk.1 b/sys-utils/ipcmk.1
index b71054e69..c1e8fe47c 100644
--- a/sys-utils/ipcmk.1
+++ b/sys-utils/ipcmk.1
@@ -43,7 +43,7 @@ Display help text and exit.
 .SH SEE ALSO
 .BR ipcrm (1),
 .BR ipcs (1)
-.SH AUTHOR
+.SH AUTHORS
 .MT hayden.james@gmail.com
 Hayden A. James
 .ME
diff --git a/sys-utils/ipcs.1 b/sys-utils/ipcs.1
index 4b3baaaa5..745d33832 100644
--- a/sys-utils/ipcs.1
+++ b/sys-utils/ipcs.1
@@ -123,7 +123,7 @@ options not defined by POSIX.  A portable application shall not use the
 and
 .B \-u
 options.
-.SH AUTHOR
+.SH AUTHORS
 .UR balasub@cis.ohio-state.edu
 Krishna Balasubramanian
 .UE
diff --git a/sys-utils/ldattach.8 b/sys-utils/ldattach.8
index 03ef8fd93..ee3d54998 100644
--- a/sys-utils/ldattach.8
+++ b/sys-utils/ldattach.8
@@ -145,7 +145,7 @@ Display help text and exit.
 .SH SEE ALSO
 .BR inputattach (1),
 .BR ttys (4)
-.SH AUTHOR
+.SH AUTHORS
 .nf
 Tilman Schmidt (tilman@imap.cc)
 .fi
diff --git a/sys-utils/lscpu.1 b/sys-utils/lscpu.1
index 989b1f831..1ef6ce021 100644
--- a/sys-utils/lscpu.1
+++ b/sys-utils/lscpu.1
@@ -191,7 +191,7 @@ CPU only.
 Sometimes in Xen Dom0 the kernel reports wrong data.
 
 On virtual hardware the number of cores per socket, etc. can be wrong.
-.SH AUTHOR
+.SH AUTHORS
 .nf
 Cai Qian <qcai@redhat.com>
 Karel Zak <kzak@redhat.com>
diff --git a/sys-utils/lsmem.1 b/sys-utils/lsmem.1
index 0e563daf5..9d0b07398 100644
--- a/sys-utils/lsmem.1
+++ b/sys-utils/lsmem.1
@@ -86,7 +86,7 @@ This option controls summary lines output.  The optional argument \fIwhen\fP can
 \fBnever\fR, \fBalways\fR or \fBonly\fR.  If the \fIwhen\fR argument is
 omitted, it defaults to \fB"only"\fR. The summary output is suppressed for
 \fB\-\-raw\fR, \fB\-\-pairs\fR and \fB\-\-json\fR.
-.SH AUTHOR
+.SH AUTHORS
 .B lsmem
 was originally written by Gerald Schaefer for s390-tools in Perl. The C version
 for util-linux was written by Clemens von Mann, Heiko Carstens and Karel Zak.
diff --git a/sys-utils/mountpoint.1 b/sys-utils/mountpoint.1
index 23e4536fc..cfb5916fe 100644
--- a/sys-utils/mountpoint.1
+++ b/sys-utils/mountpoint.1
@@ -43,7 +43,7 @@ Display version information and exit.
 Display help text and exit.
 .SH EXIT STATUS
 Zero if the directory or file is a mountpoint, non-zero if not.
-.SH AUTHOR
+.SH AUTHORS
 .PP
 Karel Zak <kzak@redhat.com>
 .SH ENVIRONMENT
diff --git a/sys-utils/setarch.8 b/sys-utils/setarch.8
index f0978d6ad..a5e8b1f79 100644
--- a/sys-utils/setarch.8
+++ b/sys-utils/setarch.8
@@ -121,7 +121,7 @@ setarch ppc32 rpmbuild \-\-target=ppc \-\-rebuild foo.src.rpm
 setarch ppc32 \-v \-vL3 rpmbuild \-\-target=ppc \-\-rebuild bar.src.rpm
 .br
 setarch ppc32 \-\-32bit rpmbuild \-\-target=ppc \-\-rebuild foo.src.rpm
-.SH AUTHOR
+.SH AUTHORS
 .MT sopwith@redhat.com
 Elliot Lee
 .ME
diff --git a/sys-utils/setpriv.1 b/sys-utils/setpriv.1
index 7b7110381..ae68d3a55 100644
--- a/sys-utils/setpriv.1
+++ b/sys-utils/setpriv.1
@@ -209,7 +209,7 @@ try:
 .BR su (1),
 .BR prctl (2),
 .BR capabilities (7)
-.SH AUTHOR
+.SH AUTHORS
 .MT luto@amacapital.net
 Andy Lutomirski
 .ME
diff --git a/sys-utils/setsid.1 b/sys-utils/setsid.1
index 01590279d..e4a915454 100644
--- a/sys-utils/setsid.1
+++ b/sys-utils/setsid.1
@@ -35,7 +35,7 @@ Display version information and exit.
 Display help text and exit.
 .SH SEE ALSO
 .BR setsid (2)
-.SH AUTHOR
+.SH AUTHORS
 Rick Sladkey <jrs@world.std.com>
 .SH AVAILABILITY
 The setsid command is part of the util-linux package and is available from
diff --git a/term-utils/scriptlive.1 b/term-utils/scriptlive.1
index 6fc8ebdbb..190724eef 100644
--- a/term-utils/scriptlive.1
+++ b/term-utils/scriptlive.1
@@ -86,7 +86,7 @@ warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
 PURPOSE.
 .PP
 Released under the GNU General Public License version 2 or later.
-.SH AUTHOR
+.SH AUTHORS
 .MT kzak@\:redhat.com
 Karel Zak
 .ME .
diff --git a/term-utils/scriptreplay.1 b/term-utils/scriptreplay.1
index 9f0b57afa..e02e2cb14 100644
--- a/term-utils/scriptreplay.1
+++ b/term-utils/scriptreplay.1
@@ -133,7 +133,7 @@ warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
 PURPOSE.
 .PP
 Released under the GNU General Public License version 2 or later.
-.SH AUTHOR
+.SH AUTHORS
 The original
 .B scriptreplay
 program was written by
-- 
2.26.2

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
