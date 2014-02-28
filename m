Return-Path: util-linux-owner@vger.kernel.org
Received: from g9t1613g.houston.hp.com ([15.240.0.71]:46296 "EHLO
	g9t1613g.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbaB1CcX (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 27 Feb 2014 21:32:23 -0500
Received: from g5t1625.atlanta.hp.com (g5t1625.atlanta.hp.com [15.192.137.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by g9t1613g.houston.hp.com (Postfix) with ESMTPS id C3BB36181B
	for <util-linux@vger.kernel.org>; Fri, 28 Feb 2014 02:32:22 +0000 (UTC)
Message-ID: <1393554731.2899.15.camel@buesod1.americas.hpqcorp.net>
Subject: Re: [PATCH 1/2] fdisk: warn if opening a device in write mode failed
From: Davidlohr Bueso <davidlohr@hp.com>
To: Maciej =?UTF-8?Q?Ma=C5=82ecki?= <me@mmalecki.com>
Cc: util-linux@vger.kernel.org
Date: Thu, 27 Feb 2014 18:32:11 -0800
In-Reply-To: <1393471600-17777-1-git-send-email-me@mmalecki.com>
References: <1393471600-17777-1-git-send-email-me@mmalecki.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, 2014-02-27 at 04:26 +0100, Maciej Małecki wrote:
> Otherwise, `fdisk` fails silently with "Bad file descriptor" when
> writing the partition table.
> 
> Signed-off-by: Maciej Małecki <me@mmalecki.com>
> ---
>  libfdisk/src/context.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/libfdisk/src/context.c b/libfdisk/src/context.c
> index c405403..40f9080 100644
> --- a/libfdisk/src/context.c
> +++ b/libfdisk/src/context.c
> @@ -248,17 +248,26 @@ static int warn_wipe(struct fdisk_context *cxt)
>  int fdisk_context_assign_device(struct fdisk_context *cxt,
>  				const char *fname, int readonly)
>  {
> -	int fd;
> +	int fd, mode;
>  
>  	DBG(CONTEXT, dbgprint("assigning device %s", fname));
>  	assert(cxt);
>  
>  	reset_context(cxt);
>  
> -	if (readonly == 1 || (fd = open(fname, O_RDWR|O_CLOEXEC)) < 0) {
> -		if ((fd = open(fname, O_RDONLY|O_CLOEXEC)) < 0)
> +retry:
> +	mode = (readonly ? O_RDONLY : O_RDWR) | O_CLOEXEC;
> +	fd = open(fname, mode);
> +	if (fd < 0) {
> +		if (readonly)
>  			return -errno;
> -		readonly = 1;
> +		else {
> +			fdisk_warn(cxt,
> +			    _("%s: opening device in read write mode failed"),
> +			    fname);
> +			readonly = 1;
> +			goto retry;
> +		}
>  	}

This is 1) obscenely ugly and 2) not the place for such message. There's
no reason to pollute output like this. Why do I care how the device is
opened when I'm not going to write anything to it?

The correct way is to do what you do in patch 2, inform the user that
the device is only for opened for reading and just skip the write
operation.

So, NAK for this patch.

Thanks,
Davidlohr


