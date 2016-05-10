Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34487 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbcEJTvV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 10 May 2016 15:51:21 -0400
Received: by mail-oi0-f65.google.com with SMTP id d139so3276985oig.1
        for <util-linux@vger.kernel.org>; Tue, 10 May 2016 12:51:21 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1462908414-11449-1-git-send-email-vapier@gentoo.org>
References: <1462908414-11449-1-git-send-email-vapier@gentoo.org>
Date: Tue, 10 May 2016 20:51:20 +0100
Message-ID: <CAG27Bk3MnPabuFKpAtGnjms=fhC5ZqM=xQCT0rYx9P2Ye2Fk_A@mail.gmail.com>
Subject: Re: [PATCH] man pages: fix spacing between man page name & section number
From: Sami Kerola <kerolasa@iki.fi>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 10 May 2016 at 20:26, Mike Frysinger <vapier@gentoo.org> wrote:
> Most have standardized correctly, but fix a few latent ones.
>
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---
>  disk-utils/cfdisk.8 | 2 +-
>  disk-utils/sfdisk.8 | 4 ++--
>  misc-utils/kill.1   | 2 +-
>  misc-utils/logger.1 | 2 +-
>  sys-utils/losetup.8 | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/disk-utils/cfdisk.8 b/disk-utils/cfdisk.8
> index ff95aa9..68cec94 100644
> --- a/disk-utils/cfdisk.8
> +++ b/disk-utils/cfdisk.8
> @@ -190,7 +190,7 @@ enables libsmartcols debug output.
>  .BR sfdisk (8),
>  .BR parted (8),
>  .BR partprobe (8),
> -.BR partx(8)
> +.BR partx (8)
>  .SH AUTHOR
>  Karel Zak <kzak@redhat.com>
>  .PP
> diff --git a/disk-utils/sfdisk.8 b/disk-utils/sfdisk.8
> index 79424c5..0c13a48 100644
> --- a/disk-utils/sfdisk.8
> +++ b/disk-utils/sfdisk.8
> @@ -441,7 +441,7 @@ The GPT header can later be restored by:
>  .RE
>  Note that \fBsfdisk\fR since version 2.26 no longer provides the \fB\-I\fR option to
>  restore sectors.
> -.B dd (1)
> +.BR dd (1)
>  provides all necessary functionality.
>
>  .SH COLORS
> @@ -487,7 +487,7 @@ enables libsmartcols debug output.
>  .BR cfdisk (8),
>  .BR parted (8),
>  .BR partprobe (8),
> -.BR partx(8)
> +.BR partx (8)
>
>  .SH AUTHOR
>  Karel Zak <kzak@redhat.com>
> diff --git a/misc-utils/kill.1 b/misc-utils/kill.1
> index 2d8c883..d3dc20e 100644
> --- a/misc-utils/kill.1
> +++ b/misc-utils/kill.1
> @@ -118,7 +118,7 @@ It is not possible to send a signal to an explicitly selected thread in a
>  multithreaded process using the
>  .BR kill (2)
>  syscall.  If
> -.BR kill(2)
> +.BR kill (2)
>  is used to send a signal to a thread group, then the kernel selects an arbitrary
>  member of the thread group that has not blocked the signal.  For more details
>  see
> diff --git a/misc-utils/logger.1 b/misc-utils/logger.1
> index 0417b93..2c58c15 100644
> --- a/misc-utils/logger.1
> +++ b/misc-utils/logger.1
> @@ -75,7 +75,7 @@ command's PID.  The use of \fB\-\-id=$$\fR
>  Note that the system logging infrastructure (for example \fBsystemd\fR when
>  listening on /dev/log) may follow local socket credentials to overwrite the
>  PID specified in the message.
> -.BR logger(1)
> +.BR logger (1)
>  is able to set those socket credentials to the given \fIid\fR, but only if you
>  have root permissions and a process with the specified PID exists, otherwise
>  the socket credentials are not modified and the problem is silently ignored.
> diff --git a/sys-utils/losetup.8 b/sys-utils/losetup.8
> index dbc9095..b614416 100644
> --- a/sys-utils/losetup.8
> +++ b/sys-utils/losetup.8
> @@ -151,7 +151,7 @@ Display help text and exit.
>
>  .SH ENCRYPTION
>  .B Cryptoloop is no longer supported in favor of dm-crypt.
> -.B For more details see cryptsetup (8).
> +.B For more details see cryptsetup(8).

The above is overly bold statement to my taste. I would prefer the text this way

-- snip
diff --git a/sys-utils/losetup.8 b/sys-utils/losetup.8
index dbc9095..817e204 100644
--- a/sys-utils/losetup.8
+++ b/sys-utils/losetup.8
@@ -150,8 +150,9 @@ Display version information and exit.
 Display help text and exit.

 .SH ENCRYPTION
-.B Cryptoloop is no longer supported in favor of dm-crypt.
-.B For more details see cryptsetup (8).
+Cryptoloop is no longer supported in favor of dm-crypt.
+For more details see
+.BR cryptsetup (8).

 .SH RETURN VALUE
 .B losetup
-- snip

Just for record, this is the commit that added all the .B to that text.

https://github.com/karelzak/util-linux/commit/23b85230e7bf53881b265ef8bf03ec05ac5cefd2

>  .SH RETURN VALUE
>  .B losetup
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Sami Kerola
http://www.iki.fi/kerolasa/
