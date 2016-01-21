Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51276 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758970AbcAUKS2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 21 Jan 2016 05:18:28 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id B1B538E92B
	for <util-linux@vger.kernel.org>; Thu, 21 Jan 2016 10:18:28 +0000 (UTC)
Received: from ws (ovpn-204-36.brq.redhat.com [10.40.204.36])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u0LAIRYw018230
	for <util-linux@vger.kernel.org>; Thu, 21 Jan 2016 05:18:28 -0500
Date: Thu, 21 Jan 2016 11:18:27 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: Re: mount nofail: what failures should we allow ?
Message-ID: <20160121101827.o5qlpa53ftmwbzkt@ws.net.home>
References: <20160119232458.GO14840@vapier.lan>
 <20160120102845.olo242uqrfzld6rh@ws.net.home>
 <20160120200028.GE14840@vapier.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160120200028.GE14840@vapier.lan>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 20, 2016 at 03:00:28PM -0500, Mike Frysinger wrote:
> On 20 Jan 2016 11:28, Karel Zak wrote:
> > On Tue, Jan 19, 2016 at 06:24:58PM -0500, Mike Frysinger wrote:
> > > i've received two requests for the "nofail" option.  the doc for the
> > > option is a bit ... terse ... so it's hard to guess at the overall
> > > intention.
> > 
> > man mount:
> >    nofail Do not report errors for this device if it does not exist.
> > 
> > from my point of view this description is pretty explicit :-)
> 
> does it mean the device node doesn't exist (ENOENT) ?  or does it also
> accept the node being there, but returning other errors like ENXIO (the
> driver isn't loaded) or ENOTDIR (bad path) or ENOTBLK (used a bad path
> like /dev/zero) or ENOMEDIUM (the node & hardware exists, but is not
> loaded) ?  there's probably other errno values you could catch here.
> 
> surely you agree that "does not exist" does not cover all these cases.
> or at the very least, it's pretty ambiguous/fuzzy.

now we use "nofail" if:

 - impossible to translate UUID/LABEL/etc to device name
 - mount(2) returns ENOENT and stat() on source fails
 - mount(2) returns ENOTDIR and stat() on source fails with ENOTDIR
 - mount(2) returns ENOTBLK
 - mount(2) returns ENXIO
 - and ENOMEDIUM now

... well, maybe we can improve the description in the man page to make
it more user friendly.

> > > (2) ignore unknown fs types.  e.g. when a kernel config/module is missing
> > > support for the requested filesystem type.  so a fstab entry like:
> > > 	..src..  /mnt/foo  somefs defaults,nofail
> > > rather than error out with:
> > > 	mount: unknown filesystem type 'somefs'
> > > it would just issue a warning like it does for other nofail options.
> > 
> > I'm not sure with this. It's unusual situation when any filesystem is unknown
> > for libblkid, but it's pretty common that kernel returns EINVAL. This
> > happen when a kernel config/module is missing, but also if you specify
> > wrong mount options and in some another situations. I don't think we
> > want to hide such problems. It's too generic...
> 
> i think there's a lot going on in this response.  let me distill it a
> bit.  if i have a reiserfs that is usable, but i forgot to enable or
> load the reiserfs kernel driver, should nofail be allowed to skip ?
> or is this a hard failure ?

 Now it's hard failure and I'm fine with it ;)

 In this case kernel returns EINVAL -- the problem is that kernel uses
 EINVAL it in another situations too. It makes "nofail" very
 problematic for this use-case, because we're not able to detect that
 you have no reiserfs driver.

 Frankly, people will ask for "nofail" extension all time...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
