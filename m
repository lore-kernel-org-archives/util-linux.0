Return-Path: util-linux-owner@vger.kernel.org
Received: from a.ns.miles-group.at ([95.130.255.143]:47834 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755886Ab3BMPDz (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 13 Feb 2013 10:03:55 -0500
Date: Wed, 13 Feb 2013 16:03:48 +0100
From: Richard Weinberger <richard@nod.at>
To: Dave Reisner <d@falconindy.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] [RFC] switch_root: Add a sanity check
Message-ID: <20130213160348.026682b7@spider.haslach.nod.at>
In-Reply-To: <20130213145246.GR594@rampage>
References: <1360434170-27206-1-git-send-email-richard@nod.at>
	<20130213142536.GA30987@x2.net.home>
	<20130213145246.GR594@rampage>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Am Wed, 13 Feb 2013 09:52:46 -0500
schrieb Dave Reisner <d@falconindy.com>:

> On Wed, Feb 13, 2013 at 03:25:36PM +0100, Karel Zak wrote:
> > On Sat, Feb 09, 2013 at 07:22:50PM +0100, Richard Weinberger wrote:
> > > As switch_root basically does rm -Rf / we should make sure
> > > that / is really an initramfs.
> > 
> > Oh, nice (we should not ask for details, right? :-) Applied, thanks.
> > 
> >     Karel
> > 
> 
> Wouldn't it be better to check that / is tmpfs or ramfs instead of
> insistence on being a very specific device?

Not really.

switch_root is designed for initramfs only, so the check against
tmpfs is useless.
We can identify an initramfs only because it is the very first mounted
filesystem. The kernel mounts it as rootfs very early, see
fs/namespace.c
So the device 0,1 allows us to identify initramfs nicely.

Checking against type ramfs does not make much sense. It would allow
false positives, If someone overmounted / with an ramfs (or
even tmpfs) then there is no need at all to use switch_root, just use
pivot_root.

Thanks,
//richard
