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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70B1C433E1
	for <util-linux@archiver.kernel.org>; Tue, 19 May 2020 12:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B8AB2081A
	for <util-linux@archiver.kernel.org>; Tue, 19 May 2020 12:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kc3ARN35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgESMxZ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 19 May 2020 08:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbgESMxY (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 19 May 2020 08:53:24 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3EDC08C5C0
        for <util-linux@vger.kernel.org>; Tue, 19 May 2020 05:53:24 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id v12so15722122wrp.12
        for <util-linux@vger.kernel.org>; Tue, 19 May 2020 05:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=2UnBIIbK69w5A1F9ztKSNvS8pqLtzITANpRgu3eHlKw=;
        b=Kc3ARN35uT2D9Tc0NImqJoS2Dk3XbCv06Hv4dZM6lCrkfasAGyNjHqrHgFWEoPcBd7
         V1JGbV58247TJBoeHePfbHEXmzci0FAM5OLQ90cXFBt6WLvaMghXoEXB+qf3JvtD74eS
         mfxpXvHE8hIuy37uKG1b0cA9sNtM1WJmIO322MZu8Djx+85X58rvQVoy4jVUCoqZqQGc
         36W9CdxUmmd1AiJzGfZC8UlILJQl+gahAr98Fo7hLqxzjMp+RTA/fch8E/bsJ9VDG5ib
         48L1rzLdmZQxaa5vetLtQ1yvm1uUQ9xu4Xo0csvVLoS0WMF28qwEvCAP+2owbCLNeI1A
         G+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=2UnBIIbK69w5A1F9ztKSNvS8pqLtzITANpRgu3eHlKw=;
        b=apynpUkUo9cEACrCpYvoCMBfjGhULEvFQ2vPS5WGECyZdnikgsl/ij2nymN7EcLj7Y
         CbM/Eh68cSLv1M/rLk0GWTNpslBhqVoTS2kJk17SSFrcYdEmmxSdwtTohGFCSCLpO6/0
         KoelwmARBJTtap0wfQ06c9wN5kiaGbyj2jvokYAzdIbSVcEnKB5YWXjKxl/o5XLWdiMG
         LpZ8Vl6Qv7VQArnKjysGzYV0x3WJRRGDpNsXhYulqfx4kShuBh60tDWp2/OKAx5cl/aq
         oMWLkvsS0VmJrxss/ujdNgp30hk5PQK9WchCOMUbKu5s/7eBEcQ2XrvIGbBNrgS7k6Qk
         7OUQ==
X-Gm-Message-State: AOAM533eOWpx50zLWeuyPPCYM14oEVMP3We1OwSiEuoeG4DaJdh6mWuv
        roThpTR/0IUUb/275d0LxlYWJor5Nyk=
X-Google-Smtp-Source: ABdhPJym3bK7RJ3ufSjXde2Qk0+yRXOw8nXmydkX8yPe7m+9DhC86ILhmINCk/PrptXjy4l/iUQMvg==
X-Received: by 2002:adf:d0d1:: with SMTP id z17mr27224812wrh.175.1589892802862;
        Tue, 19 May 2020 05:53:22 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id 61sm8349337wrp.92.2020.05.19.05.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 05:53:22 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, util-linux@vger.kernel.org
To:     Karel Zak <kzak@redhat.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: [PATCH 6/7] Manual pages: Standardize on EXIT STATUS as section title
Message-ID: <66d7092d-db34-e531-8b48-4e74bdfcb061@gmail.com>
Date:   Tue, 19 May 2020 14:53:21 +0200
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

Currently we have EXIT STATUS (18), EXIT CODES (3), RETURN CODE (7),
RETURN CODES (1), or RETURN VALUE (4 instances in pages that document
commands, rather than functions).

Let's standardize on the EXIT STATUS (which is also what is
suggested in man-pages(7), and is the POSIX terminology).

A subsequent patch will clean up corresponding miswordings in
manual page text.

Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
---
 disk-utils/fsck.minix.8 | 2 +-
 disk-utils/mkfs.bfs.8   | 2 +-
 disk-utils/mkfs.minix.8 | 2 +-
 misc-utils/blkid.8      | 2 +-
 misc-utils/kill.1       | 2 +-
 misc-utils/logger.1     | 2 +-
 misc-utils/lsblk.8      | 2 +-
 sys-utils/chcpu.8       | 2 +-
 sys-utils/chmem.8       | 2 +-
 sys-utils/fstrim.8      | 2 +-
 sys-utils/losetup.8     | 2 +-
 sys-utils/mount.8       | 2 +-
 sys-utils/switch_root.8 | 2 +-
 sys-utils/zramctl.8     | 2 +-
 14 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/disk-utils/fsck.minix.8 b/disk-utils/fsck.minix.8
index 2aabd2fa3..600b1e2da 100644
--- a/disk-utils/fsck.minix.8
+++ b/disk-utils/fsck.minix.8
@@ -92,7 +92,7 @@ will print "unable to read super block".  If the device exists, but is not
 a MINIX filesystem,
 .B fsck.minix
 will print "bad magic number in super-block".
-.SH EXIT CODES
+.SH EXIT STATUS
 The exit code returned by
 .B fsck.minix
 is the sum of the following:
diff --git a/disk-utils/mkfs.bfs.8 b/disk-utils/mkfs.bfs.8
index 9f2e7bb87..ca0847227 100644
--- a/disk-utils/mkfs.bfs.8
+++ b/disk-utils/mkfs.bfs.8
@@ -47,7 +47,7 @@ Option
 only works as
 .B \-\-version
 when it is the only option.
-.SH EXIT CODES
+.SH EXIT STATUS
 The exit code returned by
 .B mkfs.bfs
 is 0 when all went well, and 1 when something went wrong.
diff --git a/disk-utils/mkfs.minix.8 b/disk-utils/mkfs.minix.8
index 7486ca5bc..9a6b26c54 100644
--- a/disk-utils/mkfs.minix.8
+++ b/disk-utils/mkfs.minix.8
@@ -70,7 +70,7 @@ with other options.
 .TP
 \fB\-h\fR, \fB\-\-help\fR
 Display help text and exit.
-.SH EXIT CODES
+.SH EXIT STATUS
 The exit code returned by
 .B mkfs.minix
 is one of the following:
diff --git a/misc-utils/blkid.8 b/misc-utils/blkid.8
index 6ef73f33c..6c0bbe43d 100644
--- a/misc-utils/blkid.8
+++ b/misc-utils/blkid.8
@@ -286,7 +286,7 @@ Look up the device that uses this filesystem \fIuuid\fR.  For more details see t
 .TP
 \fB\-V\fR, \fB\-\-version\fR
 Display version number and exit.
-.SH RETURN CODE
+.SH EXIT STATUS
 If the specified device or device addressed by specified token (option
 \fB\-\-match\-token\fR) was found and it's possible to gather any information about the
 device, an exit code 0 is returned.  Note the option \fB\-\-match\-tag\fR filters output
diff --git a/misc-utils/kill.1 b/misc-utils/kill.1
index 27258d293..c0383faca 100644
--- a/misc-utils/kill.1
+++ b/misc-utils/kill.1
@@ -171,7 +171,7 @@ preferred in relation to the
 executable described by this manual.  Easiest way to ensure one is executing
 the executable is to use full path when calling the command, for example:
 .B "/bin/kill \-\-version"
-.SH RETURN CODES
+.SH EXIT STATUS
 .B kill
 has the following return codes:
 .PP
diff --git a/misc-utils/logger.1 b/misc-utils/logger.1
index b2f2133ae..501ed938d 100644
--- a/misc-utils/logger.1
+++ b/misc-utils/logger.1
@@ -294,7 +294,7 @@ Display version information and exit.
 .TP
 .BR \-h , " \-\-help"
 Display help text and exit.
-.SH RETURN VALUE
+.SH EXIT STATUS
 The
 .B logger
 utility exits 0 on success, and >0 if an error occurs.
diff --git a/misc-utils/lsblk.8 b/misc-utils/lsblk.8
index 1b73e6f25..cca345f1a 100644
--- a/misc-utils/lsblk.8
+++ b/misc-utils/lsblk.8
@@ -180,7 +180,7 @@ This sysfs block directory appeared in kernel 2.6.27 (October 2008).
 In case of problems with a new enough kernel, check that CONFIG_SYSFS
 was enabled at the time of the kernel build.
 
-.SH RETURN CODES
+.SH EXIT STATUS
 .IP 0
 success
 .IP 1
diff --git a/sys-utils/chcpu.8 b/sys-utils/chcpu.8
index 23191e2b9..7f94de535 100644
--- a/sys-utils/chcpu.8
+++ b/sys-utils/chcpu.8
@@ -77,7 +77,7 @@ Display version information and exit.
 .BR \-h , " \-\-help"
 Display help text and exit.
 
-.SH RETURN CODES
+.SH EXIT STATUS
 .B chcpu
 has the following return codes:
 .TP
diff --git a/sys-utils/chmem.8 b/sys-utils/chmem.8
index c11514007..21a8152c0 100644
--- a/sys-utils/chmem.8
+++ b/sys-utils/chmem.8
@@ -79,7 +79,7 @@ progress.
 .TP
 .BR \-V ", " \-\-version
 Print the version number, then exit.
-.SH RETURN CODES
+.SH EXIT STATUS
 .B chmem
 has the following return codes:
 .TP
diff --git a/sys-utils/fstrim.8 b/sys-utils/fstrim.8
index e3857f9d0..f8e4ebc6f 100644
--- a/sys-utils/fstrim.8
+++ b/sys-utils/fstrim.8
@@ -115,7 +115,7 @@ Display version information and exit.
 .BR \-h , " \-\-help"
 Display help text and exit.
 
-.SH RETURN CODES
+.SH EXIT STATUS
 .IP 0
 success
 .IP 1
diff --git a/sys-utils/losetup.8 b/sys-utils/losetup.8
index 4cf548741..6c4f603da 100644
--- a/sys-utils/losetup.8
+++ b/sys-utils/losetup.8
@@ -170,7 +170,7 @@ Display help text and exit.
 .B Cryptoloop is no longer supported in favor of dm-crypt.
 .B For more details see cryptsetup(8).
 
-.SH RETURN VALUE
+.SH EXIT STATUS
 .B losetup
 returns 0 on success, nonzero on failure.  When
 .B losetup
diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index e31660baa..a9df585ce 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -2501,7 +2501,7 @@ initialize a new device if the same backing file is already used for some loop
 device with the same offset and sizelimit. This is necessary to avoid
 a filesystem corruption.
 
-.SH RETURN CODES
+.SH EXIT STATUS
 .B mount
 has the following return codes (the bits can be ORed):
 .TP
diff --git a/sys-utils/switch_root.8 b/sys-utils/switch_root.8
index b194a262f..b169817e9 100644
--- a/sys-utils/switch_root.8
+++ b/sys-utils/switch_root.8
@@ -28,7 +28,7 @@ Display help text and exit.
 .IP "\fB\-V, \-\-version\fP"
 Display version information and exit.
 
-.SH RETURN VALUE
+.SH EXIT STATUS
 .B switch_root
 returns 0 on success and 1 on failure.
 
diff --git a/sys-utils/zramctl.8 b/sys-utils/zramctl.8
index 12983f144..97e3f4118 100644
--- a/sys-utils/zramctl.8
+++ b/sys-utils/zramctl.8
@@ -95,7 +95,7 @@ Display version information and exit.
 .BR \-h , " \-\-help"
 Display help text and exit.
 
-.SH RETURN VALUE
+.SH EXIT STATUS
 .B zramctl
 returns 0 on success, nonzero on failure.
 
-- 
2.26.2

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
