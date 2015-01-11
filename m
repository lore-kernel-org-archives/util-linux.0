Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:56765 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751063AbbAKQT1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 11 Jan 2015 11:19:27 -0500
Message-ID: <54B2A27A.50401@gmx.com>
Date: Sun, 11 Jan 2015 11:19:06 -0500
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Benno Schulenberg <bensberg@justemail.net>, util-linux@vger.kernel.org
CC: karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 2/4] docs: mention that setarch may not be able to set
 all listed architectures
References: <1420897295-17573-1-git-send-email-bensberg@justemail.net> <1420897295-17573-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1420897295-17573-2-git-send-email-bensberg@justemail.net>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 01/10/2015 08:41 AM, Benno Schulenberg wrote:
> Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
> ---
>  sys-utils/setarch.8 |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/sys-utils/setarch.8 b/sys-utils/setarch.8
> index a9a126a..d0f1cba 100644
> --- a/sys-utils/setarch.8
> +++ b/sys-utils/setarch.8
> @@ -24,11 +24,12 @@ It also allows to set various personality options.
>  The default \fIprogram\fR is \fB/bin/sh\fR.
>  .SH OPTIONS
>  .TP
> -\fB\-\-list\fR
> -List the architectures that can be set.
> +.B \-\-list
> +List the architectures that \fBsetarch\fR knows about.  Whether \fBsetarch\fR
> +can actually set each of these architectures depends on the running kernel.
>  .TP
> -\fB\-\-uname\-2.6\fR
> -Causes the program to see a kernel version number beginning with 2.6.
> +.B \-\-uname-2.6

This is incorrect. Options are always constructed with minus signs never a hyphens.
The only time a hyphen should be used in man-pages is for normally hyphenated 
dictionary words. Commands, options, variables, paths, urls, etc. all use the
minus sign character. For troff that is \-.

groff(7)
       \-     The - (minus) sign in the current font.


> +Causes the \fIprogram\fR to see a kernel version number beginning with 2.6.
>  .TP
>  .BR \-v , " \-\-verbose"
>  Be verbose.
> 
