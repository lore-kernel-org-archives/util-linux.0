Return-Path: util-linux-owner@vger.kernel.org
Received: from g9t1613g.houston.hp.com ([15.240.0.71]:54784 "EHLO
	g9t1613g.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948AbaB1S1q (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 28 Feb 2014 13:27:46 -0500
Received: from g4t3425.houston.hp.com (g4t3425.houston.hp.com [15.201.208.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by g9t1613g.houston.hp.com (Postfix) with ESMTPS id 4D67B61F5F
	for <util-linux@vger.kernel.org>; Fri, 28 Feb 2014 18:27:46 +0000 (UTC)
Message-ID: <1393612047.2899.31.camel@buesod1.americas.hpqcorp.net>
Subject: Re: [PATCH 1/2] fdisk: warn if opening a device in write mode failed
From: Davidlohr Bueso <davidlohr@hp.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: Maciej =?UTF-8?Q?Ma=C5=82ecki?= <me@mmalecki.com>,
        util-linux@vger.kernel.org
Date: Fri, 28 Feb 2014 10:27:27 -0800
In-Reply-To: <5310B80C.7000205@ubuntu.com>
References: <1393471600-17777-1-git-send-email-me@mmalecki.com>
		<1393554731.2899.15.camel@buesod1.americas.hpqcorp.net>
	 <CAKC8-7xwz+SZ_TPYx8EbzRbqqErHkaVJ=rOJRG+gvJnu9zdzyQ@mail.gmail.com>
	 <5310B80C.7000205@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, 2014-02-28 at 11:23 -0500, Phillip Susi wrote:
> On 2/28/2014 6:00 AM, Maciej Małecki wrote:
> >>> libfdisk/src/context.c | 17 +++++++++++++---- 1 file changed,
> >>> 13 insertions(+), 4 deletions(-)
> >>> 
> >>> diff --git a/libfdisk/src/context.c b/libfdisk/src/context.c 
> >>> index c405403..40f9080 100644 --- a/libfdisk/src/context.c +++
> >>> b/libfdisk/src/context.c @@ -248,17 +248,26 @@ static int
> >>> warn_wipe(struct fdisk_context *cxt) int
> >>> fdisk_context_assign_device(struct fdisk_context *cxt, const
> >>> char *fname, int readonly) { -     int fd; +     int fd, mode;
> >>> 
> >>> DBG(CONTEXT, dbgprint("assigning device %s", fname)); 
> >>> assert(cxt);
> >>> 
> >>> reset_context(cxt);
> >>> 
> >>> -     if (readonly == 1 || (fd = open(fname, O_RDWR|O_CLOEXEC))
> >>> < 0) { -             if ((fd = open(fname, O_RDONLY|O_CLOEXEC))
> >>> < 0) +retry: +     mode = (readonly ? O_RDONLY : O_RDWR) |
> >>> O_CLOEXEC; +     fd = open(fname, mode); +     if (fd < 0) { +
> >>> if (readonly) return -errno; -             readonly = 1; +
> >>> else { +                     fdisk_warn(cxt, +
> >>> _("%s: opening device in read write mode failed"), +
> >>> fname); +                     readonly = 1; +
> >>> goto retry; +             } }
> >> 
> >> This is 1) obscenely ugly and 2) not the place for such message.
> >> There's no reason to pollute output like this. Why do I care how
> >> the device is opened when I'm not going to write anything to it?
> >> 
> >> The correct way is to do what you do in patch 2, inform the user
> >> that the device is only for opened for reading and just skip the
> >> write operation.
> 
> You really want to tell the user that they aren't going to be able to
> write up front.

Sure why not, just not in a library! You can do this in the fdisk
program. And if Karel doesn't agree and wants to apply this patch
anyway, then it should *at least* be in DBG context.

Thanks,
Davidlohr

