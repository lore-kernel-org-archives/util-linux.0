Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39568 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933127AbcATK2r (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 20 Jan 2016 05:28:47 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 193BF8F262
	for <util-linux@vger.kernel.org>; Wed, 20 Jan 2016 10:28:47 +0000 (UTC)
Received: from ws (ovpn-204-36.brq.redhat.com [10.40.204.36])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u0KASk9o000480
	for <util-linux@vger.kernel.org>; Wed, 20 Jan 2016 05:28:46 -0500
Date: Wed, 20 Jan 2016 11:28:45 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: Re: mount nofail: what failures should we allow ?
Message-ID: <20160120102845.olo242uqrfzld6rh@ws.net.home>
References: <20160119232458.GO14840@vapier.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160119232458.GO14840@vapier.lan>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jan 19, 2016 at 06:24:58PM -0500, Mike Frysinger wrote:
> i've received two requests for the "nofail" option.  the doc for the
> option is a bit ... terse ... so it's hard to guess at the overall
> intention.

man mount:
   nofail Do not report errors for this device if it does not exist.


from my point of view this description is pretty explicit :-)

> (1) ignore ENOMEDIUM like:
> sys-utils/mount.c could be updated to do:
>     case ENOMEDIUM:
>         if (uflags & MNT_MS_NOFAIL)
>             return MOUNT_EX_SUCCESS;
>         warnx(_("no medium found on %s"), src);
>         break;
> this is for cases like cd/dvd drives which happens to have no disk loaded.

It seems like a good idea, send patch :-)

> (2) ignore unknown fs types.  e.g. when a kernel config/module is missing
> support for the requested filesystem type.  so a fstab entry like:
> 	..src..  /mnt/foo  somefs defaults,nofail
> rather than error out with:
> 	mount: unknown filesystem type 'somefs'
> it would just issue a warning like it does for other nofail options.

I'm not sure with this. It's unusual situation when any filesystem is unknown
for libblkid, but it's pretty common that kernel returns EINVAL. This
happen when a kernel config/module is missing, but also if you specify
wrong mount options and in some another situations. I don't think we
want to hide such problems. It's too generic...

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
