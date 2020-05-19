Return-Path: <SRS0=ZMjy=7B=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57804C433DF
	for <util-linux@archiver.kernel.org>; Tue, 19 May 2020 08:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CB8A20709
	for <util-linux@archiver.kernel.org>; Tue, 19 May 2020 08:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpBDpZFF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgESIb1 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 19 May 2020 04:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgESIb1 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 19 May 2020 04:31:27 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0ACC061A0C
        for <util-linux@vger.kernel.org>; Tue, 19 May 2020 01:31:25 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id n5so2463696wmd.0
        for <util-linux@vger.kernel.org>; Tue, 19 May 2020 01:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=BIMQTJ8ZWrWMCGb2Uz2zJ6njcMuXHAVu1XEZULhuRCA=;
        b=YpBDpZFFn11s+tXRByCOFPYAxewG+Kx29le4XrXUp0J7ajMNMga4dTpXAm9wAo+o2Y
         JMoXN3iTvfqKmZi17dtSpk2KfoCF/4AsWqvHhVUkURkykLiiaL1E86ufSMZvtaVEAenv
         VrNCgnHgBaMUMGGBkuMLBTASrwcQ1vzEv958HNU4ok4mPStHns5toM8oaBHR09sYiEg5
         9S+gO2W+HXPUxbWfegKelZi9QKAxfH/8x0HhSHP21GCx8dtlwZMsaRlCwO7ufODknBl6
         6ej52gWLF2kaePh60RTR6F8ypjiDTPalYFZLmaI24LxpSqL/VHAe92jRQid2UC2+t3TQ
         j//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=BIMQTJ8ZWrWMCGb2Uz2zJ6njcMuXHAVu1XEZULhuRCA=;
        b=K6XwWAs8dC7i0XZ2atMc5cFv4DlqSz1gejE97C6De1yN4XatSIu6YgBsFoNAsoMRYy
         d6qFUOrSh5rZJFNajYj9hNA9DNRuhhIrXbnaya7mm3ZQzJ3O6NV6A0twDVzRtcJmUcQ5
         4iVOpUOZzK/y4fXP1HOE/EwsqpSGCTfMAIjMkW4+P6jRpDT3n3IyqDXePTvkZOobMbEI
         lNqz5Zagt/yeDHvp4bfbNLtrT3n77QPDGlePC8bJiojkYVMFX9q5FSCpbJ5doLY5thN4
         R3Lj0MmX+osIIXjofMuNvQkXvitW4b7HjeV7qBqeUF9O736laoGYIJeO/RoOdL04Bvow
         3MKA==
X-Gm-Message-State: AOAM532d8+IKVj/VG5NgrE5FvwvkIzryv7caqRYMwHwLVionBm726jLB
        gmQvPfDoaE0v6V3dzyGQp/E43VAuEiw=
X-Google-Smtp-Source: ABdhPJyF94UZcoXl1ANTHCZeOk+CVXSBkAPYLW1YcyUWp9i3bRLreEQ1EXC5saoNo9abI1/5g+2G6w==
X-Received: by 2002:a7b:c62a:: with SMTP id p10mr3769200wmk.143.1589877082884;
        Tue, 19 May 2020 01:31:22 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id z12sm14425358wrq.7.2020.05.19.01.31.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 01:31:22 -0700 (PDT)
Cc:     mtk.manpages@gmail.com
To:     Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
        Helge Kreutzmann <debian@helgefjell.de>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: [PATCH] Global fix to manual pages: remove double quotes (") in .SH
 lines
Message-ID: <1ac1c5eb-a2db-ed1d-9c3e-147bfe65a591@gmail.com>
Date:   Tue, 19 May 2020 10:31:19 +0200
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


Using double quotes in .SH lines containing multiple words is unneeded,
and in any case is not consistently done in the util-linux manual pages,
where double quotes are used in only around half of the cases.
(This usage was long ago elminated in the man-pages project, with
no ill effects reported to date.)

Remove these quotes, so that .SH lines are more uniform, in preparation
for some (more easily) scripted doiscovery of consistency problems in
(and possibly global fixes to) the manual pages.

Other than stripping the double quotes, this patch makes no changes to
the content of the manual pages.

Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
---
 disk-utils/cfdisk.8         |  2 +-
 disk-utils/fdformat.8       |  2 +-
 disk-utils/fdisk.8          |  4 ++--
 disk-utils/fsck.cramfs.8    |  4 ++--
 disk-utils/fsck.minix.8     |  4 ++--
 disk-utils/isosize.8        |  2 +-
 disk-utils/mkfs.bfs.8       |  4 ++--
 disk-utils/mkfs.cramfs.8    |  4 ++--
 disk-utils/mkfs.minix.8     |  4 ++--
 disk-utils/mkswap.8         |  2 +-
 disk-utils/sfdisk.8         |  8 ++++----
 lib/terminal-colors.d.5     |  6 +++---
 libblkid/libblkid.3         |  2 +-
 libuuid/man/uuid.3          |  4 ++--
 libuuid/man/uuid_clear.3    |  2 +-
 libuuid/man/uuid_compare.3  |  2 +-
 libuuid/man/uuid_copy.3     |  2 +-
 libuuid/man/uuid_generate.3 |  4 ++--
 libuuid/man/uuid_is_null.3  |  2 +-
 libuuid/man/uuid_parse.3    |  4 ++--
 libuuid/man/uuid_time.3     |  4 ++--
 libuuid/man/uuid_unparse.3  |  4 ++--
 login-utils/chfn.1          |  4 ++--
 login-utils/chsh.1          |  6 +++---
 login-utils/last.1          |  2 +-
 login-utils/login.1         |  2 +-
 login-utils/newgrp.1        |  2 +-
 login-utils/runuser.1       |  2 +-
 login-utils/su.1            |  2 +-
 login-utils/utmpdump.1      |  2 +-
 misc-utils/blkid.8          |  2 +-
 misc-utils/fincore.1        |  2 +-
 misc-utils/findfs.8         |  2 +-
 misc-utils/hardlink.1       | 12 ++++++------
 misc-utils/look.1           |  2 +-
 misc-utils/lslocks.8        |  2 +-
 misc-utils/mcookie.1        |  2 +-
 misc-utils/namei.1          |  2 +-
 misc-utils/rename.1         |  4 ++--
 misc-utils/uuidgen.1        |  2 +-
 misc-utils/uuidparse.1      |  2 +-
 misc-utils/whereis.1        |  2 +-
 schedutils/chrt.1           |  2 +-
 sys-utils/adjtime_config.5  |  2 +-
 sys-utils/chcpu.8           |  2 +-
 sys-utils/ctrlaltdel.8      |  2 +-
 sys-utils/flock.1           |  4 ++--
 sys-utils/fstab.5           |  2 +-
 sys-utils/ipcmk.1           | 14 +++++++-------
 sys-utils/ldattach.8        |  2 +-
 sys-utils/lscpu.1           |  2 +-
 sys-utils/lsns.8            |  2 +-
 sys-utils/mount.8           | 10 +++++-----
 sys-utils/pivot_root.8      |  2 +-
 sys-utils/prlimit.1         |  2 +-
 sys-utils/rfkill.8          |  2 +-
 sys-utils/setarch.8         |  2 +-
 sys-utils/setsid.1          |  2 +-
 sys-utils/switch_root.8     |  2 +-
 sys-utils/umount.8          |  6 +++---
 term-utils/mesg.1           |  2 +-
 term-utils/scriptlive.1     | 14 +++++++-------
 term-utils/scriptreplay.1   | 14 +++++++-------
 term-utils/setterm.1        |  2 +-
 term-utils/write.1          |  2 +-
 text-utils/column.1         |  2 +-
 text-utils/hexdump.1        |  2 +-
 text-utils/line.1           |  2 +-
 text-utils/pg.1             |  4 ++--
 69 files changed, 120 insertions(+), 120 deletions(-)

diff --git a/disk-utils/cfdisk.8 b/disk-utils/cfdisk.8
index 89d932143..ae874fb89 100644
--- a/disk-utils/cfdisk.8
+++ b/disk-utils/cfdisk.8
@@ -187,7 +187,7 @@ enables libsmartcols debug output.
 .IP LIBSMARTCOLS_DEBUG_PADDING=on
 use visible padding characters. Requires enabled LIBSMARTCOLS_DEBUG.
 
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR fdisk (8),
 .BR parted (8),
 .BR partprobe (8),
diff --git a/disk-utils/fdformat.8 b/disk-utils/fdformat.8
index 8cc72bd99..ecff66280 100644
--- a/disk-utils/fdformat.8
+++ b/disk-utils/fdformat.8
@@ -62,7 +62,7 @@ Display version information and exit.
 .TP
 \fB\-h\fR, \fB\-\-help\fR
 Display help text and exit.
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR fd (4),
 .BR emkfs (8),
 .BR mkfs (8),
diff --git a/disk-utils/fdisk.8 b/disk-utils/fdisk.8
index 07b17073e..93a7d7ac7 100644
--- a/disk-utils/fdisk.8
+++ b/disk-utils/fdisk.8
@@ -273,7 +273,7 @@ Linux.
 A sync() and an ioctl(BLKRRPART) (rereading the partition table from disk)
 are performed before exiting when the partition table has been updated.
 
-.SH "DOS mode and DOS 6.x WARNING"
+.SH DOS mode and DOS 6.x WARNING
 .B Note that all this is deprecated.  You don't have to care about things like
 .B geometry and cylinders on modern operating systems.  If you really want
 .B DOS-compatible partitioning then you have to enable DOS mode and cylinder
@@ -371,7 +371,7 @@ enables libsmartcols debug output.
 .IP LIBSMARTCOLS_DEBUG_PADDING=on
 use visible padding characters. Requires enabled LIBSMARTCOLS_DEBUG.
 
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR cfdisk (8),
 .BR mkfs (8),
 .BR partx (8),
diff --git a/disk-utils/fsck.cramfs.8 b/disk-utils/fsck.cramfs.8
index ec486d614..1beabd81b 100644
--- a/disk-utils/fsck.cramfs.8
+++ b/disk-utils/fsck.cramfs.8
@@ -34,7 +34,7 @@ Display version information and exit.
 .TP
 \fB\-h\fR, \fB\-\-help\fR
 Display help text and exit.
-.SH "EXIT STATUS"
+.SH EXIT STATUS
 .RS
 .PD 0
 .TP
@@ -51,7 +51,7 @@ operation error, such as unable to allocate memory
 usage information was printed
 .PD
 .RE
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR mount (8),
 .BR mkfs.cramfs (8)
 .SH AVAILABILITY
diff --git a/disk-utils/fsck.minix.8 b/disk-utils/fsck.minix.8
index f7abb9b37..2aabd2fa3 100644
--- a/disk-utils/fsck.minix.8
+++ b/disk-utils/fsck.minix.8
@@ -92,7 +92,7 @@ will print "unable to read super block".  If the device exists, but is not
 a MINIX filesystem,
 .B fsck.minix
 will print "bad magic number in super-block".
-.SH "EXIT CODES"
+.SH EXIT CODES
 The exit code returned by
 .B fsck.minix
 is the sum of the following:
@@ -154,7 +154,7 @@ Portability patch by
 .MT rmk@\:ecs.\:soton.\:ac.\:uk
 Russell King
 .ME .
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR fsck (8),
 .BR fsck.ext2 (8),
 .BR mkfs (8),
diff --git a/disk-utils/isosize.8 b/disk-utils/isosize.8
index baa5f7d2a..6e072f943 100644
--- a/disk-utils/isosize.8
+++ b/disk-utils/isosize.8
@@ -32,7 +32,7 @@ filesystem can be marginally larger than the actual size of the
 iso9660 filesystem.  One reason for this is that cd writers
 are allowed to add "run out" sectors at the end of an iso9660
 image.
-.SH "EXIT STATUS"
+.SH EXIT STATUS
 .RS
 .PD 0
 .TP
diff --git a/disk-utils/mkfs.bfs.8 b/disk-utils/mkfs.bfs.8
index f32202a5b..9f2e7bb87 100644
--- a/disk-utils/mkfs.bfs.8
+++ b/disk-utils/mkfs.bfs.8
@@ -47,11 +47,11 @@ Option
 only works as
 .B \-\-version
 when it is the only option.
-.SH "EXIT CODES"
+.SH EXIT CODES
 The exit code returned by
 .B mkfs.bfs
 is 0 when all went well, and 1 when something went wrong.
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR mkfs (8)
 .SH AVAILABILITY
 The mkfs.bfs command is part of the util-linux package and is available from
diff --git a/disk-utils/mkfs.cramfs.8 b/disk-utils/mkfs.cramfs.8
index 31cf84bf6..da7085027 100644
--- a/disk-utils/mkfs.cramfs.8
+++ b/disk-utils/mkfs.cramfs.8
@@ -69,7 +69,7 @@ Display help text and exit.
 .TP
 \fB\-V\fR, \fB\-\-version\fR
 Display version information and exit.
-.SH "EXIT STATUS"
+.SH EXIT STATUS
 .RS
 .PD 0
 .TP
@@ -80,7 +80,7 @@ success
 operation error, such as unable to allocate memory
 .PD
 .RE
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR fsck.cramfs (8),
 .BR mount (8)
 .SH AVAILABILITY
diff --git a/disk-utils/mkfs.minix.8 b/disk-utils/mkfs.minix.8
index a640deb55..7486ca5bc 100644
--- a/disk-utils/mkfs.minix.8
+++ b/disk-utils/mkfs.minix.8
@@ -70,7 +70,7 @@ with other options.
 .TP
 \fB\-h\fR, \fB\-\-help\fR
 Display help text and exit.
-.SH "EXIT CODES"
+.SH EXIT CODES
 The exit code returned by
 .B mkfs.minix
 is one of the following:
@@ -80,7 +80,7 @@ No errors
 Operational error
 .IP 16
 Usage or syntax error
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR fsck (8),
 .BR mkfs (8),
 .BR reboot (8)
diff --git a/disk-utils/mkswap.8 b/disk-utils/mkswap.8
index b57433388..d464341ef 100644
--- a/disk-utils/mkswap.8
+++ b/disk-utils/mkswap.8
@@ -140,7 +140,7 @@ about
 .IP LIBBLKID_DEBUG=all
 enables libblkid debug output.
 
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR fdisk (8),
 .BR swapon (8)
 .SH AVAILABILITY
diff --git a/disk-utils/sfdisk.8 b/disk-utils/sfdisk.8
index af5780540..ead807b8d 100644
--- a/disk-utils/sfdisk.8
+++ b/disk-utils/sfdisk.8
@@ -330,7 +330,7 @@ Display version information and exit.
 .BR \-h , " \-\-help"
 Display help text and exit.
 
-.SH "INPUT FORMATS"
+.SH INPUT FORMATS
 .B sfdisk
 supports two input formats and generic header lines.
 
@@ -522,7 +522,7 @@ For backward compatibility the \fBId=\fR field has the same meaning.
 .RE
 .RE
 
-.SH "EMPTY DISK LABEL"
+.SH EMPTY DISK LABEL
 .B sfdisk
 does not create partition table without partitions by default. The lines with
 partitions are expected in the script by default. The empty partition table has
@@ -535,7 +535,7 @@ partitions lines. For example:
 .RE
 creates empty GPT partition table. Note that the \fB\-\-append\fR disables this feature.
 
-.SH "BACKING UP THE PARTITION TABLE"
+.SH BACKING UP THE PARTITION TABLE
 It is recommended to save the layout of your devices.
 .B sfdisk
 supports two ways.
@@ -620,7 +620,7 @@ enables libblkid debug output.
 .IP LIBSMARTCOLS_DEBUG=all
 enables libsmartcols debug output.
 
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR fdisk (8),
 .BR cfdisk (8),
 .BR parted (8),
diff --git a/lib/terminal-colors.d.5 b/lib/terminal-colors.d.5
index a8fe08e09..4747ca268 100644
--- a/lib/terminal-colors.d.5
+++ b/lib/terminal-colors.d.5
@@ -4,11 +4,11 @@
 .\" Copyright 2014 Red Hat, Inc.
 .\" May be distributed under the GNU General Public License
 .TH "TERMINAL_COLORS.D" "5" "January 2014" "util-linux" "terminal-colors.d"
-.SH "NAME"
+.SH NAME
 terminal-colors.d \- Configure output colorization for various utilities
-.SH "SYNOPSIS"
+.SH SYNOPSIS
 /etc/terminal-colors\&.d/[[\fIname\fR][@\fIterm\fR]\&.][\fItype\fR]
-.SH "DESCRIPTION"
+.SH DESCRIPTION
 Files in this directory determine the default behavior for utilities
 when coloring output.
 
diff --git a/libblkid/libblkid.3 b/libblkid/libblkid.3
index 6b58b1670..4b9e74bba 100644
--- a/libblkid/libblkid.3
+++ b/libblkid/libblkid.3
@@ -71,7 +71,7 @@ The low-level probing code was rewritten by Karel Zak.
 .B libblkid
 is available under the terms of the GNU Library General Public License (LGPL),
 version 2 (or at your discretion any later version).
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR blkid (8),
 .BR findfs (8)
 .SH AVAILABILITY
diff --git a/libuuid/man/uuid.3 b/libuuid/man/uuid.3
index 7d6aeb126..a596e42e7 100644
--- a/libuuid/man/uuid.3
+++ b/libuuid/man/uuid.3
@@ -46,7 +46,7 @@ unique within a system, and unique across all systems.  They could
 be used, for instance, to generate unique HTTP cookies across multiple
 web servers without communication between the servers, and without fear
 of a name clash.
-.SH "CONFORMING TO"
+.SH CONFORMING TO
 This library generates UUIDs compatible with OSF DCE 1.1, and hash based UUIDs
 V3 and V5 compatible with RFC-4122.
 .SH AUTHOR
@@ -55,7 +55,7 @@ Theodore Y.\& Ts'o
 .B libuuid
 is part of the util-linux package since version 2.15.1 and is available from
 https://www.kernel.org/pub/linux/utils/util-linux/.
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR uuid_clear (3),
 .BR uuid_compare (3),
 .BR uuid_copy (3),
diff --git a/libuuid/man/uuid_clear.3 b/libuuid/man/uuid_clear.3
index 6decb3bd2..9cc9b5db1 100644
--- a/libuuid/man/uuid_clear.3
+++ b/libuuid/man/uuid_clear.3
@@ -51,7 +51,7 @@ Theodore Y.\& Ts'o
 is part of the util-linux package since version 2.15.1 and is available from
 https://www.kernel.org/pub/linux/utils/util-linux/.
 .na
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR uuid (3),
 .BR uuid_compare (3),
 .BR uuid_copy (3),
diff --git a/libuuid/man/uuid_compare.3 b/libuuid/man/uuid_compare.3
index 41d601c42..46759e282 100644
--- a/libuuid/man/uuid_compare.3
+++ b/libuuid/man/uuid_compare.3
@@ -57,7 +57,7 @@ Theodore Y.\& Ts'o
 is part of the util-linux package since version 2.15.1 and is available from
 https://www.kernel.org/pub/linux/utils/util-linux/.
 .na
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR uuid (3),
 .BR uuid_clear (3),
 .BR uuid_copy (3),
diff --git a/libuuid/man/uuid_copy.3 b/libuuid/man/uuid_copy.3
index 38dee44d0..09fb30cfe 100644
--- a/libuuid/man/uuid_copy.3
+++ b/libuuid/man/uuid_copy.3
@@ -53,7 +53,7 @@ Theodore Y.\& Ts'o
 is part of the util-linux package since version 2.15.1 and is available from
 https://www.kernel.org/pub/linux/utils/util-linux/.
 .na
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR uuid (3),
 .BR uuid_clear (3),
 .BR uuid_compare (3),
diff --git a/libuuid/man/uuid_generate.3 b/libuuid/man/uuid_generate.3
index e93dc79e1..544a96e67 100644
--- a/libuuid/man/uuid_generate.3
+++ b/libuuid/man/uuid_generate.3
@@ -115,7 +115,7 @@ The newly created UUID is returned in the memory location pointed to by
 .IR out .
 .B uuid_generate_time_safe
 returns zero if the UUID has been generated in a safe manner, \-1 otherwise.
-.SH "CONFORMING TO"
+.SH CONFORMING TO
 This library generates UUIDs compatible with OSF DCE 1.1, and hash based UUIDs
 V3 and V5 compatible with RFC-4122.
 .SH AUTHOR
@@ -124,7 +124,7 @@ Theodore Y.\& Ts'o
 .B libuuid
 is part of the util-linux package since version 2.15.1 and is available from
 https://www.kernel.org/pub/linux/utils/util-linux/.
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR uuidgen (1),
 .BR uuid (3),
 .BR uuid_clear (3),
diff --git a/libuuid/man/uuid_is_null.3 b/libuuid/man/uuid_is_null.3
index 924905538..fea469e46 100644
--- a/libuuid/man/uuid_is_null.3
+++ b/libuuid/man/uuid_is_null.3
@@ -52,7 +52,7 @@ Theodore Y.\& Ts'o
 is part of the util-linux package since version 2.15.1 and is available from
 https://www.kernel.org/pub/linux/utils/util-linux/.
 .na
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR uuid (3),
 .BR uuid_clear (3),
 .BR uuid_compare (3),
diff --git a/libuuid/man/uuid_parse.3 b/libuuid/man/uuid_parse.3
index ee36c27f7..c3a5f8801 100644
--- a/libuuid/man/uuid_parse.3
+++ b/libuuid/man/uuid_parse.3
@@ -64,7 +64,7 @@ Upon successfully parsing the input string, 0 is returned, and the UUID is
 stored in the location pointed to by
 .IR uu ,
 otherwise \-1 is returned.
-.SH "CONFORMING TO"
+.SH CONFORMING TO
 This library parses UUIDs compatible with OSF DCE 1.1, and hash based UUIDs V3
 and V5 compatible with RFC-4122.
 .SH AUTHOR
@@ -74,7 +74,7 @@ Theodore Y.\& Ts'o
 is part of the util-linux package since version 2.15.1 and is available from
 https://www.kernel.org/pub/linux/utils/util-linux/.
 .na
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR uuid (3),
 .BR uuid_clear (3),
 .BR uuid_compare (3),
diff --git a/libuuid/man/uuid_time.3 b/libuuid/man/uuid_time.3
index 374d239f7..91e29e8bb 100644
--- a/libuuid/man/uuid_time.3
+++ b/libuuid/man/uuid_time.3
@@ -50,7 +50,7 @@ extract the creation time for UUIDs created with the
 and
 .BR uuid_generate_time_safe (3)
 functions.  It may or may not work with UUIDs created by other mechanisms.
-.SH "RETURN VALUES"
+.SH RETURN VALUES
 The time at which the UUID was created, in seconds since January 1, 1970 GMT
 (the epoch), is returned (see
 .BR time "(2))."
@@ -66,7 +66,7 @@ Theodore Y.\& Ts'o
 is part of the util-linux package since version 2.15.1 and is available from
 https://www.kernel.org/pub/linux/utils/util-linux/.
 .na
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR uuid (3),
 .BR uuid_clear (3),
 .BR uuid_compare (3),
diff --git a/libuuid/man/uuid_unparse.3 b/libuuid/man/uuid_unparse.3
index 7f708f057..4a7096e92 100644
--- a/libuuid/man/uuid_unparse.3
+++ b/libuuid/man/uuid_unparse.3
@@ -60,7 +60,7 @@ hex digits is important then the functions
 and
 .B uuid_unparse_lower
 may be used.
-.SH "CONFORMING TO"
+.SH CONFORMING TO
 This library unparses UUIDs compatible with OSF DCE 1.1.
 .SH AUTHOR
 Theodore Y.\& Ts'o
@@ -69,7 +69,7 @@ Theodore Y.\& Ts'o
 is part of the util-linux package since version 2.15.1 and is available from
 https://www.kernel.org/pub/linux/utils/util-linux/.
 .na
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR uuid (3),
 .BR uuid_clear (3),
 .BR uuid_compare (3),
diff --git a/login-utils/chfn.1 b/login-utils/chfn.1
index afc29c36c..592ca8ff7 100644
--- a/login-utils/chfn.1
+++ b/login-utils/chfn.1
@@ -94,9 +94,9 @@ If CHFN_RESTRICT is undefined, then all finger information is read-only.
 This is the default.
 .RE
 .PP
-.SH "EXIT STATUS"
+.SH EXIT STATUS
 Returns 0 if operation was successful, 1 if operation failed or command syntax was not valid.
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR chsh (1),
 .BR finger (1),
 .BR login.defs (5),
diff --git a/login-utils/chsh.1 b/login-utils/chsh.1
index c523c665f..eefcdb958 100644
--- a/login-utils/chsh.1
+++ b/login-utils/chsh.1
@@ -43,7 +43,7 @@ Display help text and exit.
 .TP
 .BR \-v , " \-\-version"
 Display version information and exit.
-.SH "VALID SHELLS"
+.SH VALID SHELLS
 .B chsh
 will accept the full pathname of any executable file on the system.
 .sp
@@ -53,9 +53,9 @@ listed in the
 file, and issue a warning for root user.  It can also be configured
 at compile-time to only issue a warning for all users.
 
-.SH "EXIT STATUS"
+.SH EXIT STATUS
 Returns 0 if operation was successful, 1 if operation failed or command syntax was not valid.
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR login (1),
 .BR login.defs (5),
 .BR passwd (5),
diff --git a/login-utils/last.1 b/login-utils/last.1
index 619be3f3d..2fca5a159 100644
--- a/login-utils/last.1
+++ b/login-utils/last.1
@@ -191,7 +191,7 @@ The last command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
 Linux Kernel Archive
 .UE .
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR login (1),
 .BR wtmp (5),
 .BR init (8),
diff --git a/login-utils/login.1 b/login-utils/login.1
index 8dc77fa43..d60ffd22c 100644
--- a/login-utils/login.1
+++ b/login-utils/login.1
@@ -336,7 +336,7 @@ the superuser logs in.  ENV_ROOTPATH takes precedence.  The default value is
 .I /etc/hushlogins
 .I .hushlogin
 .fi
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR mail (1),
 .BR passwd (1),
 .BR passwd (5),
diff --git a/login-utils/newgrp.1 b/login-utils/newgrp.1
index f85a8d3b0..c29461010 100644
--- a/login-utils/newgrp.1
+++ b/login-utils/newgrp.1
@@ -21,7 +21,7 @@ If no group is specified, the GID is changed to the login GID.
 .br
 .I /etc/passwd
 
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR login (1),
 .BR group (5)
 
diff --git a/login-utils/runuser.1 b/login-utils/runuser.1
index 17bab28d8..4a4e19dde 100644
--- a/login-utils/runuser.1
+++ b/login-utils/runuser.1
@@ -255,7 +255,7 @@ runuser specific logindef config file
 /etc/login.defs
 global logindef config file
 .PD 1
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR setpriv (1),
 .BR su (1),
 .BR login.defs (5),
diff --git a/login-utils/su.1 b/login-utils/su.1
index 6d41b0f94..6ff8d1e64 100644
--- a/login-utils/su.1
+++ b/login-utils/su.1
@@ -290,7 +290,7 @@ be configured to update the lastlog file as well. For example by:
 .br
 session  required  pam_lastlog.so nowtmp
 .RE
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR setpriv (1),
 .BR login.defs (5),
 .BR shells (5),
diff --git a/login-utils/utmpdump.1 b/login-utils/utmpdump.1
index d98117da4..19835de31 100644
--- a/login-utils/utmpdump.1
+++ b/login-utils/utmpdump.1
@@ -80,7 +80,7 @@ format.  This tool was
 written for normal use, but for debugging only.
 .SH AUTHOR
 Michael Krapp
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR last (1),
 .BR w (1),
 .BR who (1),
diff --git a/misc-utils/blkid.8 b/misc-utils/blkid.8
index b3db17707..e95e75038 100644
--- a/misc-utils/blkid.8
+++ b/misc-utils/blkid.8
@@ -286,7 +286,7 @@ Look up the device that uses this filesystem \fIuuid\fR.  For more details see t
 .TP
 \fB\-V\fR, \fB\-\-version\fR
 Display version number and exit.
-.SH "RETURN CODE"
+.SH RETURN CODE
 If the specified device or device addressed by specified token (option
 \fB\-\-match\-token\fR) was found and it's possible to gather any information about the
 device, an exit code 0 is returned.  Note the option \fB\-\-match\-tag\fR filters output
diff --git a/misc-utils/fincore.1 b/misc-utils/fincore.1
index ce4d37d28..c01b5de0f 100644
--- a/misc-utils/fincore.1
+++ b/misc-utils/fincore.1
@@ -51,7 +51,7 @@ Display help text and exit.
 .MT yamato@\:redhat.com
 Masatake YAMATO
 .ME
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR mincore (2),
 .BR getpagesize (2),
 .BR getconf (1p)
diff --git a/misc-utils/findfs.8 b/misc-utils/findfs.8
index 33bb242d7..1d15d4939 100644
--- a/misc-utils/findfs.8
+++ b/misc-utils/findfs.8
@@ -46,7 +46,7 @@ by
 .RE
 
 .PP
-.SH "EXIT STATUS"
+.SH EXIT STATUS
 .RS
 .PD 0
 .TP
diff --git a/misc-utils/hardlink.1 b/misc-utils/hardlink.1
index dcef8080e..58e48c7df 100644
--- a/misc-utils/hardlink.1
+++ b/misc-utils/hardlink.1
@@ -1,11 +1,11 @@
 .TH "hardlink" "1"
-.SH "NAME"
+.SH NAME
 hardlink \- Consolidate duplicate files via hardlinks
-.SH "SYNOPSIS"
+.SH SYNOPSIS
 .B hardlink
 [options]
 .RI [ directory ...]
-.SH "DESCRIPTION"
+.SH DESCRIPTION
 .PP
 This manual page documents \fBhardlink\fR, a
 program which consolidates duplicate files in one or more directories
@@ -20,7 +20,7 @@ on a single filesystem contain many duplicate files.
 .PP
 Since hard links can only span a single filesystem, \fBhardlink\fR
 is only useful when all directories specified are on the same filesystem.
-.SH "OPTIONS"
+.SH OPTIONS
 .TP
 .BR \-c , " \-\-content"
 Compare only the contents of the files being considered for consolidation.
@@ -48,13 +48,13 @@ Display help text and exit.
 .TP
 .BR \-V , " \-\-version"
 Display version information and exit.
-.SH "AUTHOR"
+.SH AUTHOR
 .PP
 \fBhardlink\fR was written by Jakub Jelinek <jakub@redhat.com> and later modified by
 Ruediger Meier <ruediger.meier@ga-group.nl> and Karel Zak <kzak@redhat.com> for util-linux.
 .PP
 Man page written by Brian Long and later updated by Jindrich Novy <jnovy@redhat.com>
-.SH "BUGS"
+.SH BUGS
 .PP
 \fBhardlink\fR assumes that its target directory trees do not change from under
 it.  If a directory tree does change, this may result in \fBhardlink\fR
diff --git a/misc-utils/look.1 b/misc-utils/look.1
index eb3e2103f..56963c84d 100644
--- a/misc-utils/look.1
+++ b/misc-utils/look.1
@@ -111,7 +111,7 @@ than the dictionary path defined in FILES segment.
 the dictionary
 .IP "\fB/usr/share/dict/web2\fR" 4
 the alternative dictionary
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR grep (1),
 .BR sort (1)
 .SH HISTORY
diff --git a/misc-utils/lslocks.8 b/misc-utils/lslocks.8
index f48feba19..89b1686ed 100644
--- a/misc-utils/lslocks.8
+++ b/misc-utils/lslocks.8
@@ -98,7 +98,7 @@ since 2001.
 Davidlohr Bueso <dave@gnu.org>
 .fi
 
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR flock (1),
 .BR fcntl (2),
 .BR lockf (3)
diff --git a/misc-utils/mcookie.1 b/misc-utils/mcookie.1
index 73be11ab5..d907a79aa 100644
--- a/misc-utils/mcookie.1
+++ b/misc-utils/mcookie.1
@@ -57,7 +57,7 @@ It is assumed that none of the randomness sources will block.
 .I /dev/urandom
 .br
 .I /dev/random
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR md5sum (1),
 .BR X (7),
 .BR xauth (1),
diff --git a/misc-utils/namei.1 b/misc-utils/namei.1
index f09e95781..f8ac8cc2d 100644
--- a/misc-utils/namei.1
+++ b/misc-utils/namei.1
@@ -71,7 +71,7 @@ program was written by Roger Southwick <rogers@amadeus.wr.tek.com>.
 The program was rewritten by Karel Zak <kzak@redhat.com>.
 .SH BUGS
 To be discovered.
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR ls (1),
 .BR stat (1),
 .BR symlink (7)
diff --git a/misc-utils/rename.1 b/misc-utils/rename.1
index d8fdd6d94..7963a79b7 100644
--- a/misc-utils/rename.1
+++ b/misc-utils/rename.1
@@ -96,7 +96,7 @@ sh \-c 'stty \-icanon min 1; "$0" "$@"; stty icanon' rename \-i from to files
 .fi
 .PP
 .RE
-.SH "EXIT STATUS"
+.SH EXIT STATUS
 .RS
 .PD 0
 .TP
@@ -116,7 +116,7 @@ nothing was renamed
 unanticipated error occurred
 .PD
 .RE
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR mv (1)
 .SH AVAILABILITY
 The rename command is part of the util-linux package and is available from
diff --git a/misc-utils/uuidgen.1 b/misc-utils/uuidgen.1
index 75fef5df6..b9c265901 100644
--- a/misc-utils/uuidgen.1
+++ b/misc-utils/uuidgen.1
@@ -87,7 +87,7 @@ Generate the hash of the \fIname\fR.
 .TP
 .BR \-x , " \-\-hex"
 Interpret name \fIname\fR as a hexadecimal string.
-.SH "CONFORMING TO"
+.SH CONFORMING TO
 OSF DCE 1.1
 .SH EXAMPLES
 uuidgen \-\-sha1 \-\-namespace @dns \-\-name "www.example.com"
diff --git a/misc-utils/uuidparse.1 b/misc-utils/uuidparse.1
index 516f45836..9194ace60 100644
--- a/misc-utils/uuidparse.1
+++ b/misc-utils/uuidparse.1
@@ -65,7 +65,7 @@ Display help text and exit.
 .MT kerolasa@iki.fi
 Sami Kerola
 .ME
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR uuidgen (1),
 .BR libuuid (3),
 .UR https://\:tools.ietf.org\:/html\:/rfc4122
diff --git a/misc-utils/whereis.1 b/misc-utils/whereis.1
index 83182b067..dee143f99 100644
--- a/misc-utils/whereis.1
+++ b/misc-utils/whereis.1
@@ -143,7 +143,7 @@ or have no source in
 .B cd /usr/bin
 .br
 .B whereis \-u \-ms \-M /usr/man/man1 \-S /usr/src \-f *
-.SH "FILE SEARCH PATHS"
+.SH FILE SEARCH PATHS
 By default
 .B whereis
 tries to find files from hard-coded paths, which are defined with glob
diff --git a/schedutils/chrt.1 b/schedutils/chrt.1
index 6dbb0ec03..cad5dacd7 100644
--- a/schedutils/chrt.1
+++ b/schedutils/chrt.1
@@ -80,7 +80,7 @@ It means that at least \fB\-\-sched\-period\fR has to be specified.  See
 .BR sched (7)
 for more details.
 
-.SH "SCHEDULING OPTIONS"
+.SH SCHEDULING OPTIONS
 .TP
 \fB\-T\fR, \fB\-\-sched\-runtime\fR \fInanoseconds\fR
 Specifies runtime parameter for SCHED_DEADLINE policy (Linux-specific).
diff --git a/sys-utils/adjtime_config.5 b/sys-utils/adjtime_config.5
index b03aeddfe..9482e25f9 100644
--- a/sys-utils/adjtime_config.5
+++ b/sys-utils/adjtime_config.5
@@ -56,7 +56,7 @@ value with options on the hwclock command line.
 
 .SH FILES
 .I /etc/adjtime
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR hwclock (8),
 .BR rtcwake (8)
 .SH AVAILABILITY
diff --git a/sys-utils/chcpu.8 b/sys-utils/chcpu.8
index 832881d84..3626fc910 100644
--- a/sys-utils/chcpu.8
+++ b/sys-utils/chcpu.8
@@ -96,7 +96,7 @@ Heiko Carstens
 .SH COPYRIGHT
 Copyright IBM Corp. 2011
 .br
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR lscpu (1)
 .SH AVAILABILITY
 The chcpu command is part of the util-linux package and is available from
diff --git a/sys-utils/ctrlaltdel.8 b/sys-utils/ctrlaltdel.8
index a44ad1942..9310af974 100644
--- a/sys-utils/ctrlaltdel.8
+++ b/sys-utils/ctrlaltdel.8
@@ -44,7 +44,7 @@ Display version information and exit.
 Display help text and exit.
 .SH FILES
 .I /etc/rc.local
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR init (8),
 .BR systemd (1)
 .SH AUTHOR
diff --git a/sys-utils/flock.1 b/sys-utils/flock.1
index a85862f46..d0e17fe01 100644
--- a/sys-utils/flock.1
+++ b/sys-utils/flock.1
@@ -175,7 +175,7 @@ shell> flock -n 4
 This form is convenient for locking a file without spawning a subprocess.
 The shell opens the lock file for reading and writing as file descriptor 4,
 then flock is used to lock the descriptor.
-.SH "EXIT STATUS"
+.SH EXIT STATUS
 The command uses
 .B sysexits.h
 return values for everything, except when using either of the options
@@ -197,7 +197,7 @@ Copyright \(co 2003\-2006 H. Peter Anvin.
 .br
 This is free software; see the source for copying conditions.  There is NO
 warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR flock (2)
 .SH AVAILABILITY
 The flock command is part of the util-linux package and is available from
diff --git a/sys-utils/fstab.5 b/sys-utils/fstab.5
index 9bb5f49f9..67243f6b4 100644
--- a/sys-utils/fstab.5
+++ b/sys-utils/fstab.5
@@ -232,7 +232,7 @@ libmount based mount utility (since util-linux v2.22).
 .SH FILES
 .IR /etc/fstab ,
 .I <fstab.h>
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR getmntent (3),
 .BR fs (5),
 .BR findmnt (8),
diff --git a/sys-utils/ipcmk.1 b/sys-utils/ipcmk.1
index e6ed4347d..b71054e69 100644
--- a/sys-utils/ipcmk.1
+++ b/sys-utils/ipcmk.1
@@ -1,16 +1,16 @@
 .\" Copyright 2008 Hayden A. James (hayden.james@gmail.com)
 .\" May be distributed under the GNU General Public License
 .TH IPCMK "1" "July 2014" "util-linux" "User Commands"
-.SH "NAME"
+.SH NAME
 ipcmk \- make various IPC resources
-.SH "SYNOPSIS"
+.SH SYNOPSIS
 .B ipcmk
 [options]
-.SH "DESCRIPTION"
+.SH DESCRIPTION
 .B ipcmk
 allows you to create shared memory segments, message queues,
 and semaphore arrays.
-.SH "OPTIONS"
+.SH OPTIONS
 .TP
 Resources can be specified with these options:
 .TP
@@ -40,14 +40,14 @@ Display version information and exit.
 .BR \-h , " \-\-help"
 Display help text and exit.
 .PP
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR ipcrm (1),
 .BR ipcs (1)
-.SH "AUTHOR"
+.SH AUTHOR
 .MT hayden.james@gmail.com
 Hayden A. James
 .ME
-.SH "AVAILABILITY"
+.SH AVAILABILITY
 The ipcmk command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
 Linux Kernel Archive
diff --git a/sys-utils/ldattach.8 b/sys-utils/ldattach.8
index 5c71dbcab..03ef8fd93 100644
--- a/sys-utils/ldattach.8
+++ b/sys-utils/ldattach.8
@@ -142,7 +142,7 @@ Display version information and exit.
 .TP
 .BR \-h , " \-\-help"
 Display help text and exit.
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR inputattach (1),
 .BR ttys (4)
 .SH AUTHOR
diff --git a/sys-utils/lscpu.1 b/sys-utils/lscpu.1
index 8f45997c2..989b1f831 100644
--- a/sys-utils/lscpu.1
+++ b/sys-utils/lscpu.1
@@ -197,7 +197,7 @@ Cai Qian <qcai@redhat.com>
 Karel Zak <kzak@redhat.com>
 Heiko Carstens <heiko.carstens@de.ibm.com>
 .fi
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR chcpu (8)
 .SH AVAILABILITY
 The lscpu command is part of the util-linux package and is available from
diff --git a/sys-utils/lsns.8 b/sys-utils/lsns.8
index eed50d043..30ee2040e 100644
--- a/sys-utils/lsns.8
+++ b/sys-utils/lsns.8
@@ -81,7 +81,7 @@ Display help text and exit.
 Karel Zak <kzak@redhat.com>
 .fi
 
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR nsenter (1),
 .BR unshare (1),
 .BR clone (2),
diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 271c1e2b4..e31660baa 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -1320,7 +1320,7 @@ in octal notation.  The default mode is 0755.  This functionality is supported
 only for root users or when mount executed without suid permissions.  The option
 is also supported as x-mount.mkdir, this notation is deprecated since v2.30.
 
-.SH "FILESYSTEM-SPECIFIC MOUNT OPTIONS"
+.SH FILESYSTEM-SPECIFIC MOUNT OPTIONS
 You should consult the respective man page for the filesystem first.
 If you want to know what options the ext4 filesystem supports, then check the
 .BR ext4 (5)
@@ -2379,7 +2379,7 @@ Set the owner and group and mode of the file
 .I devices
 (default: uid=gid=0, mode=0444).  The mode is given in octal.
 
-.SH "DM-VERITY SUPPORT (experimental)"
+.SH DM-VERITY SUPPORT (experimental)
 The device-mapper verity target provides read-only transparent integrity
 checking of block devices using kernel crypto API.  The mount command can open
 the dm-verity device and do the integrity verification before on the device
@@ -2443,7 +2443,7 @@ create squashfs image from /etc directory, verity hash device
 and mount verified filesystem image to /mnt.
 The kernel will verify that the root hash is signed by a key from the kernel keyring if roothashsig is used.
 
-.SH "LOOP-DEVICE SUPPORT"
+.SH LOOP-DEVICE SUPPORT
 One further possible type is a mount via the loop device.  For example,
 the command
 .RS
@@ -2534,7 +2534,7 @@ some mount succeeded
 The command \fBmount \-a\fR returns 0 (all succeeded), 32 (all failed), or 64 (some
 failed, some succeeded).
 
-.SH "EXTERNAL HELPERS"
+.SH EXTERNAL HELPERS
 The syntax of external mount helpers is:
 .sp
 .in +4
@@ -2605,7 +2605,7 @@ enables libmount debug output
 enables libblkid debug output
 .IP LOOPDEV_DEBUG=all
 enables loop device setup debug output
-.SH "SEE ALSO"
+.SH SEE ALSO
 .na
 .BR mount (2),
 .BR umount (2),
diff --git a/sys-utils/pivot_root.8 b/sys-utils/pivot_root.8
index ace49dac7..b1395e04f 100644
--- a/sys-utils/pivot_root.8
+++ b/sys-utils/pivot_root.8
@@ -64,7 +64,7 @@ pivot_root . old_root
 exec chroot . sh \-c 'umount /old_root; exec /sbin/init' \\
   <dev/console >dev/console 2>&1
 .fi
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR chroot (1),
 .BR pivot_root (2),
 .BR mount (8),
diff --git a/sys-utils/prlimit.1 b/sys-utils/prlimit.1
index 96cb92d44..71dd7faa3 100644
--- a/sys-utils/prlimit.1
+++ b/sys-utils/prlimit.1
@@ -103,7 +103,7 @@ processes to unlimited.
 .IP "\fBprlimit \-\-cpu=10 sort \-u hugefile\fP"
 Set both the soft and hard CPU time limit to ten seconds and run 'sort'.
 
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR ulimit (1p),
 .BR prlimit (2)
 
diff --git a/sys-utils/rfkill.8 b/sys-utils/rfkill.8
index eb640954f..0d37523bb 100644
--- a/sys-utils/rfkill.8
+++ b/sys-utils/rfkill.8
@@ -107,7 +107,7 @@ This manual page was written by
 Darren Salt
 .ME ,
 for the Debian project (and may be used by others).
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR powertop (8),
 .BR systemd-rfkill (8),
 .UR https://\:git.\:kernel.\:org/\:pub/\:scm/\:linux/\:kernel/\:git/\:torvalds/\:linux.git/\:tree/\:Documentation/\:driver-api/\:rfkill.rst
diff --git a/sys-utils/setarch.8 b/sys-utils/setarch.8
index cee9717f2..f0978d6ad 100644
--- a/sys-utils/setarch.8
+++ b/sys-utils/setarch.8
@@ -133,7 +133,7 @@ Jindrich Novy
 .MT kzak@redhat.com
 Karel Zak
 .ME
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR personality (2),
 .BR select (2)
 .SH AVAILABILITY
diff --git a/sys-utils/setsid.1 b/sys-utils/setsid.1
index 64f055571..01590279d 100644
--- a/sys-utils/setsid.1
+++ b/sys-utils/setsid.1
@@ -33,7 +33,7 @@ Display version information and exit.
 .TP
 .BR \-h , " \-\-help"
 Display help text and exit.
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR setsid (2)
 .SH AUTHOR
 Rick Sladkey <jrs@world.std.com>
diff --git a/sys-utils/switch_root.8 b/sys-utils/switch_root.8
index 4e162b3ed..b194a262f 100644
--- a/sys-utils/switch_root.8
+++ b/sys-utils/switch_root.8
@@ -45,7 +45,7 @@ mount --bind $DIR $DIR
 .RE
 .fi
 
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR chroot (2),
 .BR init (8),
 .BR mkinitrd (8),
diff --git a/sys-utils/umount.8 b/sys-utils/umount.8
index b075467d5..dff62dee4 100644
--- a/sys-utils/umount.8
+++ b/sys-utils/umount.8
@@ -190,7 +190,7 @@ Display version information and exit.
 .TP
 .BR \-h , " \-\-help"
 Display help text and exit.
-.SH "NON-SUPERUSER UMOUNTS"
+.SH NON-SUPERUSER UMOUNTS
 Normally, only the superuser can umount filesystems.
 However, when
 .I fstab
@@ -209,7 +209,7 @@ inadequate by internal libmount security rules.  It drops suid permissions
 and continue as regular non-root user. It allows to support use-cases where
 root permissions are not necessary (e.g., fuse filesystems, user namespaces,
 etc).
-.SH "LOOP DEVICE"
+.SH LOOP DEVICE
 The
 .B umount
 command will automatically detach loop device previously initialized by
@@ -271,7 +271,7 @@ overrides the default location of the fstab file (ignored for suid)
 overrides the default location of the mtab file (ignored for suid)
 .IP LIBMOUNT_DEBUG=all
 enables libmount debug output
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR umount (2),
 .BR losetup (8),
 .BR mount (8)
diff --git a/term-utils/mesg.1 b/term-utils/mesg.1
index 18e7c2451..9d11137ca 100644
--- a/term-utils/mesg.1
+++ b/term-utils/mesg.1
@@ -102,7 +102,7 @@ An error has occurred.
 .RE
 .SH FILES
 .I /dev/[pt]ty[pq]?
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR login (1),
 .BR talk (1),
 .BR write (1),
diff --git a/term-utils/scriptlive.1 b/term-utils/scriptlive.1
index 0ee95a2df..6fc8ebdbb 100644
--- a/term-utils/scriptlive.1
+++ b/term-utils/scriptlive.1
@@ -1,14 +1,14 @@
 .TH SCRIPTLIVE 1 "October 2019" "util-linux" "User Commands"
-.SH "NAME"
+.SH NAME
 scriptlive \- re-run session typescripts, using timing information
-.SH "SYNOPSIS"
+.SH SYNOPSIS
 .B scriptlive
 [options]
 .RB [ \-t ]
 .I timingfile
 .RB [ \-I|\-B ]
 .I typescript
-.SH "DESCRIPTION"
+.SH DESCRIPTION
 This program re-run a typescript, using stdin typescript and timing information to ensure that
 input happens in the same rhythm as it originally appeared when the script
 was recorded.
@@ -65,7 +65,7 @@ Display version information and exit.
 .TP
 .BR \-h , " \-\-help"
 Display help text and exit.
-.SH "EXAMPLE"
+.SH EXAMPLE
 .nf
 % script --log-timing file.tm --log-in script.in
 Script started, file is script.out
@@ -75,10 +75,10 @@ Script started, file is script.out
 Script done, file is script.out
 % scriptlive --log-timing file.tm --log-in script.in
 .nf
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR script (1),
 .BR scriptreplay (1)
-.SH "COPYRIGHT"
+.SH COPYRIGHT
 Copyright \(co 2019 Karel Zak
 .PP
 This is free software; see the source for copying conditions.  There is NO
@@ -86,7 +86,7 @@ warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
 PURPOSE.
 .PP
 Released under the GNU General Public License version 2 or later.
-.SH "AUTHOR"
+.SH AUTHOR
 .MT kzak@\:redhat.com
 Karel Zak
 .ME .
diff --git a/term-utils/scriptreplay.1 b/term-utils/scriptreplay.1
index ea4c9b81a..9f0b57afa 100644
--- a/term-utils/scriptreplay.1
+++ b/term-utils/scriptreplay.1
@@ -1,14 +1,14 @@
 .TH SCRIPTREPLAY 1 "October 2019" "util-linux" "User Commands"
-.SH "NAME"
+.SH NAME
 scriptreplay \- play back typescripts, using timing information
-.SH "SYNOPSIS"
+.SH SYNOPSIS
 .B scriptreplay
 [options]
 .RB [ \-t ]
 .I timingfile
 .RI [ typescript
 .RI [ divisor ]]
-.SH "DESCRIPTION"
+.SH DESCRIPTION
 This program replays a typescript, using timing information to ensure that
 output happens in the same rhythm as it originally appeared when the script
 was recorded.
@@ -110,7 +110,7 @@ Display version information and exit.
 .TP
 .BR \-h , " \-\-help"
 Display help text and exit.
-.SH "EXAMPLE"
+.SH EXAMPLE
 .nf
 % script --log-timing file.tm --log-out script.out
 Script started, file is script.out
@@ -120,10 +120,10 @@ Script started, file is script.out
 Script done, file is script.out
 % scriptreplay --log-timing file.tm --log-out script.out
 .nf
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR script (1),
 .BR scriptlive (1)
-.SH "COPYRIGHT"
+.SH COPYRIGHT
 Copyright \(co 2008 James Youngman
 .br
 Copyright \(co 2008-2019 Karel Zak
@@ -133,7 +133,7 @@ warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
 PURPOSE.
 .PP
 Released under the GNU General Public License version 2 or later.
-.SH "AUTHOR"
+.SH AUTHOR
 The original
 .B scriptreplay
 program was written by
diff --git a/term-utils/setterm.1 b/term-utils/setterm.1
index 3ab6756e6..bad4ab0e1 100644
--- a/term-utils/setterm.1
+++ b/term-utils/setterm.1
@@ -293,7 +293,7 @@ beside the historical long options with a single hyphen, for example
 In scripts it is better to use the backward-compatible single hyphen
 rather than the double hyphen.  Currently there are no plans nor good
 reasons to discontinue single-hyphen compatibility.
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR stty (1),
 .BR tput (1),
 .BR tty (4),
diff --git a/term-utils/write.1 b/term-utils/write.1
index eb8475e7a..8f6ccec3b 100644
--- a/term-utils/write.1
+++ b/term-utils/write.1
@@ -88,7 +88,7 @@ The traditional protocol for writing to someone is that the string `\-o',
 either at the end of a line or on a line by itself, means that it's the
 other person's turn to talk.  The string `oo' means that the person
 believes the conversation to be over.
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR mesg (1),
 .BR talk (1),
 .BR who (1)
diff --git a/text-utils/column.1 b/text-utils/column.1
index 237b26b36..e880f08b2 100644
--- a/text-utils/column.1
+++ b/text-utils/column.1
@@ -177,7 +177,7 @@ has since been corrected (see above). Other implementations of
 .B column
 may continue to use the older documentation, but the behavior should be
 identical in any case.
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR colrm (1),
 .BR ls (1),
 .BR paste (1),
diff --git a/text-utils/hexdump.1 b/text-utils/hexdump.1
index eb508f6d4..8e0b278a9 100644
--- a/text-utils/hexdump.1
+++ b/text-utils/hexdump.1
@@ -340,7 +340,7 @@ conversion flag characters removed, and referencing a NULL string.
 If no format strings are specified, the default display is very similar to
 the \fB\-x\fR output format (the \fB\-x\fR option causes more space to be
 used between format units than in the default output).
-.SH "EXIT STATUS"
+.SH EXIT STATUS
 .B hexdump
 exits 0 on success and >0 if an error occurred.
 .SH EXAMPLES
diff --git a/text-utils/line.1 b/text-utils/line.1
index 5620cc0a1..a7667910e 100644
--- a/text-utils/line.1
+++ b/text-utils/line.1
@@ -10,7 +10,7 @@ The utility
 copies one line (up to a newline) from standard input to standard output.
 It always prints at least a newline and returns an exit status of 1
 on EOF or read error.
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR read (1p)
 .SH AVAILABILITY
 The line command is part of the util-linux package and is available from
diff --git a/text-utils/pg.1 b/text-utils/pg.1
index 7d2e1317f..4c9a759eb 100644
--- a/text-utils/pg.1
+++ b/text-utils/pg.1
@@ -196,7 +196,7 @@ input file or writes on the terminal,
 will immediately display the prompt.
 In all other situations these keys will terminate
 .BR pg .
-.SH "ENVIRONMENT VARIABLES"
+.SH ENVIRONMENT VARIABLES
 The following environment variables
 affect the behavior of
 .BR pg :
@@ -217,7 +217,7 @@ Used by the
 .TP
 .B TERM
 Determines the terminal type.
-.SH "SEE ALSO"
+.SH SEE ALSO
 .BR cat (1),
 .BR more (1),
 .BR sh (1p),
-- 
2.26.2

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
