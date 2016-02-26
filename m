Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:54672 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751070AbcBZLh1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 26 Feb 2016 06:37:27 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0M9NIY-1alsgl1yso-00CgTJ for
 <util-linux@vger.kernel.org>; Fri, 26 Feb 2016 12:37:25 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH 05/14] misc: fix some includes
Date: Fri, 26 Feb 2016 12:37:24 +0100
References: <1456455812-19453-1-git-send-email-sweet_f_a@gmx.de> <1456455812-19453-6-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1456455812-19453-6-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201602261237.24424.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Friday 26 February 2016, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
>
> features.h:  any glibc header includes this already
> libgen.h:    was unused there
> sys/uio.h:   for writev(3p)
> sys/queue.h  seems like it was never used
>
> [...]
> diff --git a/lib/blkdev.c b/lib/blkdev.c
> index 403e9e4..ddd6e9b 100644
> --- a/lib/blkdev.c
> +++ b/lib/blkdev.c
> @@ -18,13 +18,6 @@
>  #include <sys/disklabel.h>
>  #endif
>
> -#ifdef HAVE_SYS_DISK_H
> -# ifdef HAVE_SYS_QUEUE_H
> -#  include <sys/queue.h>	/* for LIST_HEAD */
> -# endif
> -# include <sys/disk.h>
> -#endif
> -

It was a mistake to remove <sys/disk.h> too, already fixed on github. 
