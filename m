Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63733 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578Ab2BWQy3 convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 23 Feb 2012 11:54:29 -0500
Received: by yhoo21 with SMTP id o21so692759yho.19
        for <util-linux@vger.kernel.org>; Thu, 23 Feb 2012 08:54:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1330011815-18517-1-git-send-email-petr.uzel@suse.cz>
References: <1330011815-18517-1-git-send-email-petr.uzel@suse.cz>
From: Keshav P R <the.ridikulus.rat@gmail.com>
Date: Thu, 23 Feb 2012 22:24:09 +0530
Message-ID: <CAMPnHXzmn=cUWmLQRvfJXnGMvjoLBAXE-HqhckMOsLXZhf_WSg@mail.gmail.com>
Subject: Re: [PATCH] fdisk.8: update information about GNU Parted
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Feb 23, 2012 at 21:13, Petr Uzel <petr.uzel@suse.cz> wrote:
> The support for resizing partitions and filesystems has been
> removed from parted since version 3.0.
>

http://git.savannah.gnu.org/cgit/parted.git/commit/?id=42f3d8e9b9aa686a4849be8837b0837e19f84445

> Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
> ---
>  fdisk/fdisk.8 |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/fdisk/fdisk.8 b/fdisk/fdisk.8
> index 2b12f34..fdaa050 100644
> --- a/fdisk/fdisk.8
> +++ b/fdisk/fdisk.8
> @@ -256,10 +256,9 @@ is for hackers only -- the user interface is terrible, but it is
>  more correct than fdisk and more powerful than both fdisk and cfdisk.
>  Moreover, it can be used noninteractively.)
>  .PP
> -These days there also is
> -.BR parted .
> -The cfdisk interface is nicer, but parted does much more: it not only
> -resizes partitions, but also the filesystems that live in them.
> +There also is
> +.BR parted
> +which supports many types of different partition table formats.
>  .PP
>  The IRIX/SGI-type disklabel is currently not supported by the kernel.
>  Moreover, IRIX/SGI header directories are not fully supported yet.
> --
> 1.7.7
>
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
