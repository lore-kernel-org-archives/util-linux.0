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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BF9C433DF
	for <util-linux@archiver.kernel.org>; Tue, 19 May 2020 12:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB74F2081A
	for <util-linux@archiver.kernel.org>; Tue, 19 May 2020 12:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlQZApum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgESMvw (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 19 May 2020 08:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgESMvw (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 19 May 2020 08:51:52 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD76EC08C5C0
        for <util-linux@vger.kernel.org>; Tue, 19 May 2020 05:51:51 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id z72so3428100wmc.2
        for <util-linux@vger.kernel.org>; Tue, 19 May 2020 05:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Nn/9FXKjb6NzHggMqN42QCzVh6GEOHg0trQAkK5oQ7s=;
        b=KlQZApumxRyWfIIysJRVy9wF8dI+PRPGBerBIpzcJkRjCQAj+o/YPtVVsl/YVj241B
         0dRhObjhXhMfoxu1k4JG4In/JNZvlBkJX8Lt83lfrPUBw5SoUYG0L19xgRJyneY2y1LQ
         SEn6o+EVnY9DxG/3bpHNDePw4f8brNahKDIJlQPjFyu+LQMbi13opmoYVzMa4eloF8V3
         pzR+iZGAP8TxbUxRwFCPdmpgWyDNF+x2tH0iaShCdsH7ZXIEyOiEyamEqnqrWWs3gkWx
         fAPAy1PczDFaOxJ9d2R+9ANIxAGBL6hZfOYoC/zsXvdAk51mG6trnaC2wP7vY5FuS9X1
         zgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Nn/9FXKjb6NzHggMqN42QCzVh6GEOHg0trQAkK5oQ7s=;
        b=oKUPFKM02KaxHpJq99GF20gmqAOYmG2AzcGnF13RNxMW62yHAkSo7ojVHXWgGoj9IO
         S/QbxQpZRx9PBjxf3Zp4KDetwVFNr5EX++0kBeLZG6KQGQ1GbEwvIaGkt5PQlXBzQjnr
         DFjnRqosCcVvDhTp97I2VQrN5z8HlWVgdJbtG8HbcAsqhRcR1d8/Q8ZnOjkjq8Ffrcbz
         O9sKvhtVHJIhknLV/MnWOAOD9jK8JGrUg5KuWmFtzKX3mVXQazpB6PeYTF2kszUK4jyp
         1B5/HRo/njNnxgu0S8D1KDc5U23LnSiA6TtTzh2SpFcuI/KPTYTEMPZQI5D9tTN9V9eV
         AZkQ==
X-Gm-Message-State: AOAM532NJDxubl0zYTeeUUxUhHOwmeLlY9XCdu9AHMRQm9Y3uyXKmzNo
        +QhhbcK0lMOqNZ7UMHQLChxpG2CS3ZM=
X-Google-Smtp-Source: ABdhPJyKCTfdCPybs8bXDbzI5JO5wxGQEGvgEPrV/6B9Ed62xd5QaQ6OfaRatd+Vq3fFQ03BD5MYZg==
X-Received: by 2002:a7b:ce08:: with SMTP id m8mr5086096wmc.97.1589892709585;
        Tue, 19 May 2020 05:51:49 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id f123sm3798532wmf.44.2020.05.19.05.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 05:51:49 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, util-linux@vger.kernel.org
To:     Karel Zak <kzak@redhat.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: [PATCH 2/7] Manual pages: Standardize on EXAMPLE as section title
Message-ID: <c8f0f358-64e9-0ae3-1fdb-e3822dbfd0fa@gmail.com>
Date:   Tue, 19 May 2020 14:51:48 +0200
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

Currently we have EXAMPLE (10) or EXAMPLES (23).
Let's standardize on the EXAMPLE (which is also what is
suggested in man-pages(7)) and used consistently across
a large number of pages in the Linux man-pages project.

(I realize the choice to go EXAMPLE, rather than EXAMPLES,
may be debatable. If necessary, I'd write a patch that instead
goes the other way, but I'd prefer to follow man-pages(7).)

Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
---
 disk-utils/partx.8      | 2 +-
 lib/terminal-colors.d.5 | 2 +-
 misc-utils/findmnt.8    | 2 +-
 misc-utils/logger.1     | 2 +-
 misc-utils/rename.1     | 2 +-
 misc-utils/uuidgen.1    | 2 +-
 misc-utils/wipefs.8     | 4 ++--
 schedutils/ionice.1     | 2 +-
 sys-utils/chmem.8       | 2 +-
 sys-utils/flock.1       | 2 +-
 sys-utils/pivot_root.8  | 2 +-
 sys-utils/prlimit.1     | 2 +-
 sys-utils/readprofile.8 | 2 +-
 sys-utils/renice.1      | 2 +-
 sys-utils/rfkill.8      | 2 +-
 sys-utils/setarch.8     | 2 +-
 sys-utils/unshare.1     | 4 ++--
 term-utils/agetty.8     | 2 +-
 text-utils/colcrt.1     | 2 +-
 text-utils/column.1     | 2 +-
 text-utils/hexdump.1    | 2 +-
 21 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/disk-utils/partx.8 b/disk-utils/partx.8
index d6ff52f08..e07787b10 100644
--- a/disk-utils/partx.8
+++ b/disk-utils/partx.8
@@ -144,7 +144,7 @@ Display version information and exit.
 .TP
 .BR \-h , " \-\-help"
 Display help text and exit.
-.SH EXAMPLES
+.SH EXAMPLE
 .TP
 partx \-\-show /dev/sdb3
 .TQ
diff --git a/lib/terminal-colors.d.5 b/lib/terminal-colors.d.5
index 4747ca268..73dff6a47 100644
--- a/lib/terminal-colors.d.5
+++ b/lib/terminal-colors.d.5
@@ -50,7 +50,7 @@ or
 .I $HOME/.config/terminal-colors.d
 overrides the global setting.
 
-.SH EXAMPLES
+.SH EXAMPLE
 Disable colors for all compatible utilities:
 .RS
 .br
diff --git a/misc-utils/findmnt.8 b/misc-utils/findmnt.8
index 6fe35ab86..3e49c5be1 100644
--- a/misc-utils/findmnt.8
+++ b/misc-utils/findmnt.8
@@ -260,7 +260,7 @@ It's possible to specify source (device) or target (mountpoint) to filter mount
 .TP
 .B \-\-verbose
 Force findmnt to print more information (\fB\-\-verify\fP only for now).
-.SH EXAMPLES
+.SH EXAMPLE
 .IP "\fBfindmnt \-\-fstab \-t nfs\fP"
 Prints all NFS filesystems defined in
 .IR /etc/fstab .
diff --git a/misc-utils/logger.1 b/misc-utils/logger.1
index e4a52228e..731695aed 100644
--- a/misc-utils/logger.1
+++ b/misc-utils/logger.1
@@ -345,7 +345,7 @@ l l.
 .PP
 For the priority order and intended purposes of these facilities and levels, see
 .BR syslog (3).
-.SH EXAMPLES
+.SH EXAMPLE
 .B logger System rebooted
 .br
 .B logger \-p local0.notice \-t HOSTIDM \-f /dev/idmc
diff --git a/misc-utils/rename.1 b/misc-utils/rename.1
index 7963a79b7..8067017f2 100644
--- a/misc-utils/rename.1
+++ b/misc-utils/rename.1
@@ -40,7 +40,7 @@ Display version information and exit.
 .TP
 .BR \-h , " \-\-help"
 Display help text and exit.
-.SH EXAMPLES
+.SH EXAMPLE
 Given the files
 .IR foo1 ", ..., " foo9 ", " foo10 ", ..., " foo278 ,
 the commands
diff --git a/misc-utils/uuidgen.1 b/misc-utils/uuidgen.1
index 0189587a3..07d646104 100644
--- a/misc-utils/uuidgen.1
+++ b/misc-utils/uuidgen.1
@@ -89,7 +89,7 @@ Generate the hash of the \fIname\fR.
 Interpret name \fIname\fR as a hexadecimal string.
 .SH CONFORMING TO
 OSF DCE 1.1
-.SH EXAMPLES
+.SH EXAMPLE
 uuidgen \-\-sha1 \-\-namespace @dns \-\-name "www.example.com"
 .SH AUTHORS
 .B uuidgen
diff --git a/misc-utils/wipefs.8 b/misc-utils/wipefs.8
index 8882ed84a..39e9c9f96 100644
--- a/misc-utils/wipefs.8
+++ b/misc-utils/wipefs.8
@@ -65,7 +65,7 @@ restricted with the \fB\-t\fR option.
 .TP
 .BR \-b , " \-\-backup"
 Create a signature backup to the file $HOME/wipefs-<devname>-<offset>.bak.
-For more details see the \fBEXAMPLES\fR section.
+For more details see the \fBEXAMPLE\fR section.
 .TP
 .BR \-f , " \-\-force"
 Force erasure, even if the filesystem is mounted.  This is required in
@@ -112,7 +112,7 @@ taken.  For more details see mount(8).
 .TP
 .BR \-V , " \-\-version"
 Display version information and exit.
-.SH EXAMPLES
+.SH EXAMPLE
 .TP
 .B wipefs /dev/sda*
 Prints information about sda and all partitions on sda.
diff --git a/schedutils/ionice.1 b/schedutils/ionice.1
index fa5c1ad19..0b2daba6c 100644
--- a/schedutils/ionice.1
+++ b/schedutils/ionice.1
@@ -113,7 +113,7 @@ scheduling parameters.
 .TP
 .BR \-V , " \-\-version"
 Display version information and exit.
-.SH EXAMPLES
+.SH EXAMPLE
 .LP
 .TP 7
 # \fBionice\fP \-c 3 \-p 89
diff --git a/sys-utils/chmem.8 b/sys-utils/chmem.8
index c0941ea70..c11514007 100644
--- a/sys-utils/chmem.8
+++ b/sys-utils/chmem.8
@@ -91,7 +91,7 @@ failure
 .TP
 .B 64
 partial success
-.SH EXAMPLES
+.SH EXAMPLE
 .TP
 .B chmem \-\-enable 1024
 This command requests 1024 MiB of memory to be set online.
diff --git a/sys-utils/flock.1 b/sys-utils/flock.1
index fba4ec8c0..abcbc73ee 100644
--- a/sys-utils/flock.1
+++ b/sys-utils/flock.1
@@ -124,7 +124,7 @@ Display version information and exit.
 .TP
 .BR \-h , " \-\-help"
 Display help text and exit.
-.SH EXAMPLES
+.SH EXAMPLE
 Note that "shell> " in examples is a command line prompt.
 .TP
 shell1> flock /tmp \-c cat
diff --git a/sys-utils/pivot_root.8 b/sys-utils/pivot_root.8
index b1395e04f..ea98f3b3d 100644
--- a/sys-utils/pivot_root.8
+++ b/sys-utils/pivot_root.8
@@ -39,7 +39,7 @@ Display version information and exit.
 .TP
 \fB\-h\fR, \fB\-\-help\fR
 Display help text and exit.
-.SH EXAMPLES
+.SH EXAMPLE
 Change the root file system to /dev/hda1 from an interactive shell:
 .sp
 .nf
diff --git a/sys-utils/prlimit.1 b/sys-utils/prlimit.1
index 71dd7faa3..fb784377b 100644
--- a/sys-utils/prlimit.1
+++ b/sys-utils/prlimit.1
@@ -89,7 +89,7 @@ Maximum number of file locks held.
 .IP "\fB\-y, \-\-rttime\fP[=\fIlimits\fR]"
 Timeout for real-time tasks.
 
-.SH EXAMPLES
+.SH EXAMPLE
 .IP "\fBprlimit \-\-pid 13134\fP"
 Display limit values for all current resources.
 .IP "\fBprlimit \-\-pid 13134 \-\-rss \-\-nofile=1024:4095\fP"
diff --git a/sys-utils/readprofile.8 b/sys-utils/readprofile.8
index 9aef1bfba..7b7b2ab41 100644
--- a/sys-utils/readprofile.8
+++ b/sys-utils/readprofile.8
@@ -90,7 +90,7 @@ Display version information and exit.
 .TP
 \fB\-h\fR, \fB\-\-help\fR
 Display help text and exit.
-.SH EXAMPLES
+.SH EXAMPLE
 Browse the profiling buffer ordering by clock ticks:
 .nf
    readprofile | sort \-nr | less
diff --git a/sys-utils/renice.1 b/sys-utils/renice.1
index 3ef3512f4..12a0f608d 100644
--- a/sys-utils/renice.1
+++ b/sys-utils/renice.1
@@ -77,7 +77,7 @@ Display version information and exit.
 .TP
 .BR \-h , " \-\-help"
 Display help text and exit.
-.SH EXAMPLES
+.SH EXAMPLE
 The following command would change the priority of the processes with
 PIDs 987 and 32, plus all processes owned by the users daemon and root:
 .TP
diff --git a/sys-utils/rfkill.8 b/sys-utils/rfkill.8
index 0d37523bb..373af79ac 100644
--- a/sys-utils/rfkill.8
+++ b/sys-utils/rfkill.8
@@ -74,7 +74,7 @@ Disable the corresponding device.
 Enable the corresponding device.  If the device is hard\-blocked, for example
 via a hardware switch, it will remain unavailable though it is now
 soft\-unblocked.
-.SH EXAMPLES
+.SH EXAMPLE
 rfkill --output ID,TYPE
 .br
 rfkill block all
diff --git a/sys-utils/setarch.8 b/sys-utils/setarch.8
index a5e8b1f79..7040ac003 100644
--- a/sys-utils/setarch.8
+++ b/sys-utils/setarch.8
@@ -113,7 +113,7 @@ Display version information and exit.
 .TP
 .BR \-h , " \-\-help"
 Display help text and exit.
-.SH EXAMPLES
+.SH EXAMPLE
 setarch \-\-addr-no-randomize mytestprog
 .br
 setarch ppc32 rpmbuild \-\-target=ppc \-\-rebuild foo.src.rpm
diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index 86506ffa3..b22329d9e 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -18,7 +18,7 @@ even after the \fIprogram\fR terminates (except PID namespaces where
 permanently running init process is required).
 Once a persistent \%namespace is no longer needed, it can be unpersisted with
 .BR umount (8).
-See the \fBEXAMPLES\fR section for more details.
+See the \fBEXAMPLE\fR section for more details.
 .PP
 .B unshare
 since util-linux version 2.36 uses /\fIproc/[pid]/ns/pid_for_children\fP and \fI/proc/[pid]/ns/time_for_children\fP
@@ -259,7 +259,7 @@ The proc and sysfs filesystems mounting as root in a user namespace have to be
 restricted so that a less privileged user can not get more access to sensitive
 files that a more privileged user made unavailable. In short the rule for proc
 and sysfs is as close to a bind mount as possible.
-.SH EXAMPLES
+.SH EXAMPLE
 .TP
 .B # unshare \-\-fork \-\-pid \-\-mount-proc readlink /proc/self
 .TQ
diff --git a/term-utils/agetty.8 b/term-utils/agetty.8
index 1ad1cddff..c8d9796c5 100644
--- a/term-utils/agetty.8
+++ b/term-utils/agetty.8
@@ -305,7 +305,7 @@ Display version information and exit.
 \-\-help
 Display help text and exit.
 .PP
-.SH EXAMPLES
+.SH EXAMPLE
 This section shows examples for the process field of an entry in the
 \fI/etc/inittab\fP file.  You'll have to prepend appropriate values
 for the other fields.  See \fIinittab(5)\fP for more details.
diff --git a/text-utils/colcrt.1 b/text-utils/colcrt.1
index dbfffb41d..341d34c83 100644
--- a/text-utils/colcrt.1
+++ b/text-utils/colcrt.1
@@ -66,7 +66,7 @@ Display version information and exit.
 .TP
 \fB\-h\fR, \fB\-\-help\fR
 Display help text and exit.
-.SH EXAMPLES
+.SH EXAMPLE
 A typical use of
 .B colcrt
 would be:
diff --git a/text-utils/column.1 b/text-utils/column.1
index e880f08b2..7ca8a8b31 100644
--- a/text-utils/column.1
+++ b/text-utils/column.1
@@ -126,7 +126,7 @@ Display help text and exit.
 .SH ENVIRONMENT
 The environment variable \fBCOLUMNS\fR is used to determine the size of
 the screen if no other information is available.
-.SH EXAMPLES
+.SH EXAMPLE
 Print fstab with header line and align number to the right:
 .EX
 \fBsed 's/#.*//' /etc/fstab | column \-\-table \-\-table-columns SOURCE,TARGET,TYPE,OPTIONS,PASS,FREQ \-\-table-right PASS,FREQ\fR
diff --git a/text-utils/hexdump.1 b/text-utils/hexdump.1
index 8e0b278a9..66ff157f7 100644
--- a/text-utils/hexdump.1
+++ b/text-utils/hexdump.1
@@ -343,7 +343,7 @@ used between format units than in the default output).
 .SH EXIT STATUS
 .B hexdump
 exits 0 on success and >0 if an error occurred.
-.SH EXAMPLES
+.SH EXAMPLE
 Display the input in perusal format:
 .nf
    "%06.6_ao "  12/1 "%3_u "
-- 
2.26.2

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
