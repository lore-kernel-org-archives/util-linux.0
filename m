Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39203 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751416AbaAMN4l (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 13 Jan 2014 08:56:41 -0500
Date: Mon, 13 Jan 2014 14:56:30 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] fallocate: avoid preprocessor token redefinitions
Message-ID: <20140113135630.GD12700@x2.net.home>
References: <1389132299-12109-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389132299-12109-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jan 07, 2014 at 10:04:59PM +0000, Sami Kerola wrote:
> The FALLOC_FL_KEEP_SIZE and FALLOC_FL_PUNCH_HOLE are part of
> bits/fcntl-linux.h, and one should prefer use of libc rather than
> kernel header linux/falloc.h when possible.
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  sys-utils/fallocate.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/sys-utils/fallocate.c b/sys-utils/fallocate.c
> index 6a87673..9fa1e58 100644
> --- a/sys-utils/fallocate.c
> +++ b/sys-utils/fallocate.c
> @@ -36,8 +36,10 @@
>  # include <sys/syscall.h>
>  #endif
>  
> -#ifdef HAVE_LINUX_FALLOC_H
> -# include <linux/falloc.h>	/* for FALLOC_FL_* flags */
> +#ifndef HAVE_LINUX_FALLOC_H
    ^^^^^
> +# ifndef FALLOC_FL_KEEP_SIZE	/* FALLOC_FL_* should be part of */
> +#  include <linux/falloc.h>	/* bits/fcntl-linux.h that is */
> +# endif				/* included by fcntl.h */
>  #endif

Maybe I read the patch incorrectly, but you're trying to include
<linux/falloc.h> when HAVE_LINUX_FALLOC_H is undefined :-)

I have applied the patch below.

    Karel

commit bc5ddf0c0011d1ffc21e29cef9d07420013697b0
Author: Karel Zak <kzak@redhat.com>
Date:   Mon Jan 13 14:53:18 2014 +0100

    fallocate: prefer FALLOC_FL_* flags from libc headers
    
    Reported-by: Sami Kerola <kerolasa@iki.fi>
    Signed-off-by: Karel Zak <kzak@redhat.com>

diff --git a/sys-utils/fallocate.c b/sys-utils/fallocate.c
index 6a87673..cd35b2d 100644
--- a/sys-utils/fallocate.c
+++ b/sys-utils/fallocate.c
@@ -36,8 +36,9 @@
 # include <sys/syscall.h>
 #endif
 
-#ifdef HAVE_LINUX_FALLOC_H
-# include <linux/falloc.h>	/* for FALLOC_FL_* flags */
+#if defined(HAVE_LINUX_FALLOC_H) && \
+    (!defined(FALLOC_FL_KEEP_SIZE) || !defined(FALLOC_FL_PUNCH_HOLE))
+# include <linux/falloc.h>	/* non-libc fallback for FALLOC_FL_* flags */
 #endif
 
 #ifndef FALLOC_FL_KEEP_SIZE
