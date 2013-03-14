Return-Path: util-linux-owner@vger.kernel.org
Received: from toccata.ens-lyon.fr ([140.77.166.68]:40982 "EHLO
	toccata.ens-lyon.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755609Ab3CNBPz (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 13 Mar 2013 21:15:55 -0400
Date: Thu, 14 Mar 2013 02:06:20 +0100
From: Samuel Thibault <sthibault@debian.org>
To: Jeff Epler <jepler@unpythonic.net>
Cc: LaMont Jones <lamont@debian.org>, Roger Leigh <rleigh@codelibre.net>,
        util-linux@vger.kernel.org
Subject: Re: Enable findmnt on kfreebsd
Message-ID: <20130314010620.GI5867@type.youpi.perso.aquilenet.fr>
References: <20130314003946.GB4068@unpythonic.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20130314003946.GB4068@unpythonic.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Jeff Epler, le Wed 13 Mar 2013 19:39:47 -0500, a écrit :
> --- util-linux-2.20.1.orig/libmount/src/context_umount.c
> +++ util-linux-2.20.1/libmount/src/context_umount.c
> @@ -439,6 +439,9 @@
>  /* Check whether the kernel supports UMOUNT_NOFOLLOW flag */
>  static int umount_nofollow_support(void)
>  {
> +#ifdef __FreeBSD_kernel__
> +	return  0;
> +#else
>  	int res = umount2("", UMOUNT_UNUSED);
>  	if (res != -1 || errno != EINVAL)
>  		return 0;
> @@ -448,10 +451,14 @@
>  		return 0;
>  
>  	return 1;
> +#endif

Perhaps rather turn all these into
#ifdef __linux__
  linux stuff
#else
  return 0;
#endif
?

Samuel
