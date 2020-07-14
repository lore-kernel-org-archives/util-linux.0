Return-Path: <SRS0=vFYQ=AZ=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A25C433E2
	for <util-linux@archiver.kernel.org>; Tue, 14 Jul 2020 12:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DCA2222D9
	for <util-linux@archiver.kernel.org>; Tue, 14 Jul 2020 12:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxW+cQjL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgGNMNU (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbgGNMNN (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 14 Jul 2020 08:13:13 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95266C061755
        for <util-linux@vger.kernel.org>; Tue, 14 Jul 2020 05:13:13 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g37so12849177otb.9
        for <util-linux@vger.kernel.org>; Tue, 14 Jul 2020 05:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=G6tanCUSBzHEzIRdgKwDtSmM2EdJDw9JIKuLT/L+n04=;
        b=ZxW+cQjLv7poTQnd/w9Rubu82d/MGWfSRUaKllPf88drOkDFbzMfZQglZFYcSU1Z25
         EA0UZ8wk6Pkhw61sThxavySEJ/MtITGKu2khPMGOg1KlsQrvlON5b8feg4SL1yUBvRj+
         v626aoNrYuj+FC4CX8iLFPFoXcoQl92qFY4QuICLVzjbGTFiCC5npsXGM7gs+8u6/WK4
         1YmfHgJDm+gXfifec/vy5o8bvQtR2JPlZIix9Iu9G//7m7xKgfHB8brre1lGLioO2aEz
         itglFLuADJnCaLqHl6G9nSNiUIX9bqRXaY2Mh/+k4RZ/7jpAm9F0fA3esRYLkCc6t83p
         5cHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=G6tanCUSBzHEzIRdgKwDtSmM2EdJDw9JIKuLT/L+n04=;
        b=AL3l5G50toQO/zUE7UqGqVzaO/wlImlOTiXrHjAAGihGgOGXM3kNbIH32IT4mGVuky
         wkpadsPbwu4RaczFOpXT4AlSKr0zorXLi+x5M6+ofnb4xZGR46AfGURLID7qgeFnDBkY
         uaOQaCx9uCg6EtSd15SGj7sTuFGMXFAQzytOOtKgRfbz3JpXRPKJbGs3tGdy8xFrAIzA
         Bem+qHdR4KzQ6uV/exsrBLS9WjELdZgB60Ki1c/RwRu53BCLu8HlpsO4z8Q/r1/KhIbl
         ubpfhE358ldKUnzg35AwtcTGzIFSn8H6aNlmHDW7ArD9loCJayftq31W8s8uZHAQVHZY
         dXfA==
X-Gm-Message-State: AOAM533sbahzm2TDUKTyQKcEqlMLY2mAtfVDZXPD5BDD1LhlQ88lkJOD
        7AQoTviZraCETc7Jk6SntbrH6rMYtY9sDhqe9lo=
X-Google-Smtp-Source: ABdhPJxazMJUKiLwcRk2jv9eslsbmIZsjTgY8MI91uiQYSQO2kYeswjzSCa8zqo/qaGuM7Ll5zFYDDkL5ZlslczOvoU=
X-Received: by 2002:a9d:66d7:: with SMTP id t23mr3913665otm.323.1594728792706;
 Tue, 14 Jul 2020 05:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200714095741.45292-1-mtk.manpages@gmail.com> <20200714095741.45292-5-mtk.manpages@gmail.com>
In-Reply-To: <20200714095741.45292-5-mtk.manpages@gmail.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Tue, 14 Jul 2020 14:13:01 +0200
Message-ID: <CAKgNAkhWAe-VDRQwkXC=crfZ117EfRd0Vw3keU2WYdrXkOSsTw@mail.gmail.com>
Subject: Re: [PATCH 5/5] Manual pages: various: reword "allow(s) to"
To:     Michael Kerrisk <mtk.manpages@gmail.com>,
        Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Karel,

I noticed a mistake in this patch, in the change to su.1:

-allows to run commands with a substitute user and group ID.
+allows commands to be with a substitute user and group ID.

Should be:

+allows commands to be run with a substitute user and group ID.

Shall I resend the patch, or will you edit?

Thanks,

Michael


On Tue, 14 Jul 2020 at 11:58, Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> The wording "allow(s) to" is not grammatical English. Reword various
> pages to use a more correct form such "can be use to" or "allows
> the [noun] of".
>
> Aklong the way, fix a few nearby wording errors in some pages.
>
> Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
> ---
>  disk-utils/fdisk.8     | 3 ++-
>  disk-utils/sfdisk.8    | 3 ++-
>  disk-utils/swaplabel.8 | 2 +-
>  libblkid/libblkid.3    | 3 ++-
>  login-utils/login.1    | 8 ++++----
>  login-utils/su.1       | 6 +++---
>  misc-utils/findmnt.8   | 2 +-
>  sys-utils/hwclock.8.in | 3 ++-
>  sys-utils/mount.8      | 6 +++---
>  sys-utils/setarch.8    | 2 +-
>  sys-utils/umount.8     | 6 ++++--
>  term-utils/agetty.8    | 7 ++++---
>  term-utils/script.1    | 2 +-
>  text-utils/column.1    | 6 ++++--
>  14 files changed, 34 insertions(+), 25 deletions(-)
>
> diff --git a/disk-utils/fdisk.8 b/disk-utils/fdisk.8
> index f683bcaaa..9d6443873 100644
> --- a/disk-utils/fdisk.8
> +++ b/disk-utils/fdisk.8
> @@ -200,7 +200,8 @@ are deprecated.
>
>  .SH SCRIPT FILES
>  .B fdisk
> -allows to read (by 'I' command) sfdisk compatible script files. The script is
> +can be used to read (by 'I' command) sfdisk compatible script files.
> +The script is
>  applied to in-memory partition table, and then it is possible to modify the
>  partition table before you write it to the device.
>  .PP
> diff --git a/disk-utils/sfdisk.8 b/disk-utils/sfdisk.8
> index 6c278afb6..f2346fb4f 100644
> --- a/disk-utils/sfdisk.8
> +++ b/disk-utils/sfdisk.8
> @@ -295,7 +295,8 @@ disk label (see the \fBEMPTY DISK LABEL\fR section below).
>  .TP
>  .BR \-Y , " \-\-label\-nested " \fItype
>  Force editing of a nested disk label.  The primary disk label has to exist already.
> -This option allows to edit for example a hybrid/protective MBR on devices with GPT.
> +For example,
> +this option allows you to edit a hybrid/protective MBR on devices with GPT.
>
>  .TP
>  .BR \-w , " \-\-wipe "\fIwhen
> diff --git a/disk-utils/swaplabel.8 b/disk-utils/swaplabel.8
> index b623a5020..c43a9b22a 100644
> --- a/disk-utils/swaplabel.8
> +++ b/disk-utils/swaplabel.8
> @@ -35,7 +35,7 @@ These values can also be set during swap creation using
>  .BR mkswap (8).
>  The
>  .B swaplabel
> -utility allows to change the label or UUID on an actively used swap device.
> +utility can be used to change the label or UUID on an actively used swap device.
>  .SH OPTIONS
>  .TP
>  .BR \-h , " \-\-help"
> diff --git a/libblkid/libblkid.3 b/libblkid/libblkid.3
> index a3795ab79..7fa1539b8 100644
> --- a/libblkid/libblkid.3
> +++ b/libblkid/libblkid.3
> @@ -24,7 +24,8 @@ filesystem labels/volume names, unique identifiers/serial numbers.
>  A common use is to allow use of LABEL= and UUID= tags instead of hard-coding
>  specific block device names into configuration files.
>  .P
> -The low-level part of the library also allows to extract information about
> +The low-level part of the library also allows the extraction
> +of information about
>  partitions and block device topology.
>  .P
>  The high-level part of the library keeps information about block devices in a
> diff --git a/login-utils/login.1 b/login-utils/login.1
> index 73c59462a..3f5a05ee7 100644
> --- a/login-utils/login.1
> +++ b/login-utils/login.1
> @@ -133,9 +133,9 @@ to tell
>  that printing the hostname should be suppressed in the login: prompt.
>  See also
>  .B LOGIN_PLAIN_PROMPT
> -below if your server does not allow to configure
> +below if your server does not allow the
>  .B login
> -command line.
> +command line to be configured.
>  .TP
>  \fB\-\-help\fR
>  Display help text and exit.
> @@ -193,9 +193,9 @@ to stop display content specified by
>  .B MOTD_FILE
>  after the first accessible item in the list.
>  Note that a directory is one item in this case.
> -This option allows to configure
> +This option allows
>  .B login
> -semantic to be more compatible with pam_motd.
> +semantics to be configured to be more compatible with pam_motd.
>  .RE
>  .PP
>  .B LOGIN_PLAIN_PROMPT
> diff --git a/login-utils/su.1 b/login-utils/su.1
> index 1589eb4a3..80949dae1 100644
> --- a/login-utils/su.1
> +++ b/login-utils/su.1
> @@ -6,7 +6,7 @@ su \- run a command with substitute user and group ID
>  .RI [ user " [" argument ...]]
>  .SH DESCRIPTION
>  .B su
> -allows to run commands with a substitute user and group ID.
> +allows commands to be with a substitute user and group ID.
>  .PP
>  When called with no
>  .I user
> @@ -122,7 +122,7 @@ This option is ignored if the option \fB\-\-login\fR is specified.
>  .BR \-P , " \-\-pty"
>  Create pseudo-terminal for the session. The independent terminal provides
>  better security as user does not share terminal with the original
> -session.  This allow to avoid TIOCSTI ioctl terminal injection and other
> +session.  This can be used to avoid TIOCSTI ioctl terminal injection and other
>  security attacks against terminal file descriptors. The all session is also
>  possible to move to background (e.g., "su \-\-pty \- username \-c
>  application &"). If the pseudo-terminal is enabled then su command works
> @@ -280,7 +280,7 @@ global logindef config file
>  For security reasons
>  .B su
>  always logs failed log-in attempts to the btmp file, but it does not write to
> -the lastlog file at all.  This solution allows to control
> +the lastlog file at all.  This solution can be used to control
>  .B su
>  behavior by PAM configuration.  If you want to use the pam_lastlog module to
>  print warning message about failed log-in attempts then the pam_lastlog has to
> diff --git a/misc-utils/findmnt.8 b/misc-utils/findmnt.8
> index 128793451..dda6c13bf 100644
> --- a/misc-utils/findmnt.8
> +++ b/misc-utils/findmnt.8
> @@ -170,7 +170,7 @@ The standard columns always use the new version of the information from the
>  mountinfo file, except the umount action which is based on the original
>  information cached by
>  .BR findmnt (8).
> -The poll mode allows to use extra columns:
> +The poll mode allows the use of extra columns:
>  .RS
>  .TP
>  .B ACTION
> diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
> index e62b4ad09..9912b48d5 100644
> --- a/sys-utils/hwclock.8.in
> +++ b/sys-utils/hwclock.8.in
> @@ -281,7 +281,8 @@ parameters should be observed.
>  .
>  .TP
>  .BI \%\-\-delay= seconds
> -This option allows to overwrite internally used delay when set clock time. The
> +This option can be used to overwrite the internally used delay
> +when setting the clock time. The
>  default is 0.5 (500ms) for rtc_cmos, for another RTC types the delay is 0. If
>  RTC type is impossible to determine (from sysfs) then it defaults also to 0.5
>  to be backwardly compatible.
> diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
> index 190335c23..d232896f6 100644
> --- a/sys-utils/mount.8
> +++ b/sys-utils/mount.8
> @@ -584,7 +584,7 @@ with a single
>  .BR mount (2)
>  system call, and the flags cannot be mixed with other mount options and operations.
>
> -Since util-linux 2.23 the \fBmount\fR command allows to do more propagation
> +Since util-linux 2.23 the \fBmount\fR command can be used to do more propagation
>  (topology) changes by one mount(8) call and do it also together with other
>  mount operations.  This feature is EXPERIMENTAL.  The propagation flags are applied
>  by additional \fBmount\fR(2) system calls when the preceding mount operations
> @@ -891,9 +891,9 @@ explicitly define that the argument is the mount target.
>  .TP
>  .BI \-\-target\-prefix " directory"
>  Prepend the specified directory to all mount targets.
> -This option allows to follow
> +This option can be used to follow
>  .IR fstab ,
> -but mount operations is done on another place, for example:
> +but mount operations are done in another place, for example:
>  .RS
>  .RS
>  .sp
> diff --git a/sys-utils/setarch.8 b/sys-utils/setarch.8
> index 7040ac003..7276fdd55 100644
> --- a/sys-utils/setarch.8
> +++ b/sys-utils/setarch.8
> @@ -22,7 +22,7 @@ modifies execution domains and process personality flags.
>  The execution domains currently only affects the output of \fBuname \-m\fR.
>  For example, on an AMD64 system, running \fBsetarch i386 \fIprogram\fR
>  will cause \fIprogram\fR to see i686 instead of x86_64 as the machine type.
> -It also allows to set various personality options.
> +It can also be used to set various personality options.
>  The default \fIprogram\fR is \fB/bin/sh\fR.
>  .PP
>  Since version 2.33 the
> diff --git a/sys-utils/umount.8 b/sys-utils/umount.8
> index 6f402fd67..a66d11961 100644
> --- a/sys-utils/umount.8
> +++ b/sys-utils/umount.8
> @@ -215,13 +215,15 @@ option on a line, anybody can umount the corresponding filesystem.  For more det
>  .BR mount (8)
>  man page.
>  .PP
> -Since version 2.34 \fBumount\fR command allows to perform umount operation also
> +Since version 2.34 the \fBumount\fR command can be used to
> +perform umount operation also
>  for fuse filesystems if kernel mount table contains user's ID.  In this case fstab
>  user= mount option is not required.
>  .PP
>  Since version 2.35 \fBumount\fR command does not exit when user permissions are
>  inadequate by internal libmount security rules.  It drops suid permissions
> -and continue as regular non-root user. It allows to support use-cases where
> +and continue as regular non-root user.
> +This can be used to support use-cases where
>  root permissions are not necessary (e.g., fuse filesystems, user namespaces,
>  etc).
>  .SH LOOP DEVICE
> diff --git a/term-utils/agetty.8 b/term-utils/agetty.8
> index 76ba9e280..902914197 100644
> --- a/term-utils/agetty.8
> +++ b/term-utils/agetty.8
> @@ -241,7 +241,8 @@ Call vhangup() to do a virtual hangup of the specified terminal.
>  Try to keep the existing baud rate.  The baud rates from the command line are
>  used when agetty receives a BREAK character.  If another baud rates specified
>  then the original baud rate is also saved to the end of the wanted baud rates
> -list.  It allows to return to the original baud rate after unexpected BREAKs.
> +list.
> +This can be used to return to the original baud rate after unexpected BREAKs.
>  .TP
>  \-t, \-\-timeout \fItimeout\fP
>  Terminate if no user name could be read within \fItimeout\fP seconds.
> @@ -357,7 +358,7 @@ checks for \fI/etc/issue.d\fP directory. The directory is optional extension to
>  the default issue file and content of the directory is printed after
>  \fI/etc/issue\fP content. If the \fI/etc/issue\fP does not exist than the
>  directory is ignored. All files \fBwith .issue extension\fP from the directory are
> -printed in version-sort order. The directory allow to maintain 3rd-party
> +printed in version-sort order. The directory can be used to maintain 3rd-party
>  messages independently on the primary system \fI/etc/issue\fP file.
>
>  Since version 2.35 additional locations for issue file and directory are
> @@ -413,7 +414,7 @@ S or S{VARIABLE}
>  Insert the VARIABLE data from \fI/etc/os-release\fP.  If this file does not exist
>  then fall back to \fI/usr/lib/os-release\fP.  If the VARIABLE argument is not
>  specified, then use PRETTY_NAME from the file or the system name (see \\s).
> -This escape code allows to keep \fI/etc/issue\fP distribution and release
> +This escape code can be used to keep \fI/etc/issue\fP distribution and release
>  independent.  Note that \\S{ANSI_COLOR} is converted to the real terminal
>  escape sequence.
>  .TP
> diff --git a/term-utils/script.1 b/term-utils/script.1
> index 59c8b2572..8eda4a58b 100644
> --- a/term-utils/script.1
> +++ b/term-utils/script.1
> @@ -49,7 +49,7 @@ and to store additional information about the session.
>  .PP
>  Since version 2.35
>  .B script
> -supports multiple streams and allows to log input and output to separate
> +supports multiple streams and allows the logging of input and output to separate
>  files or all the one file.  This version also supports new timing file
>  which records additional information.  The command
>  .B scriptreplay \-\-summary
> diff --git a/text-utils/column.1 b/text-utils/column.1
> index 4c2de1cc5..18696954b 100644
> --- a/text-utils/column.1
> +++ b/text-utils/column.1
> @@ -67,7 +67,9 @@ Output is formatted to a width specified as number of characters. The original
>  name of this option is \-\-columns; this name is deprecated since v2.30. Note that input
>  longer than \fIwidth\fP is not truncated by default.
>  .IP "\fB\-d, \-\-table\-noheadings\fP"
> -Do not print header. This option allows to use logical column names on command line, but keep the header hidden when print the table.
> +Do not print header.
> +This option allows the use of logical column names on the command line,
> +but keeps the header hidden when printing the table.
>  .IP "\fB\-o, \-\-output\-separator\fP \fIstring\fP"
>  Specify the columns delimiter for table output (default is two spaces).
>  .IP "\fB\-s, \-\-separator\fP \fIseparators\fP"
> @@ -83,7 +85,7 @@ for the table header or to address column in option arguments.
>  .IP "\fB\-R, \-\-table-right\fP \fIcolumns\fP"
>  Right align text in the specified columns.
>  .IP "\fB\-T, \-\-table-truncate\fP \fIcolumns\fP"
> -Specify columns where is allowed to truncate text when necessary, otherwise
> +Specify columns where text can be truncated when necessary, otherwise
>  very long table entries may be printed on multiple lines.
>  .IP "\fB\-E, \-\-table-noextreme\fP \fIcolumns\fP"
>  Specify columns where is possible to ignore unusually long (longer than
> --
> 2.26.2
>


--
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
