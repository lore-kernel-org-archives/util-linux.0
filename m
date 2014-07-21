Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52994 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750832AbaGUXtl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 21 Jul 2014 19:49:41 -0400
Date: Tue, 22 Jul 2014 01:49:36 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: mount.8: mtab as symlink
Message-ID: <20140721234936.GH17373@x2.net.home>
References: <53CCADA9.3020703@bernhard-voelker.de>
 <20140721082859.GD17373@x2.net.home>
 <1405977369.18035.144118445.737362A9@webmail.messagingengine.com>
 <53CD86FC.7000808@bernhard-voelker.de>
 <1405981133.2561.144137253.6000B5B5@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405981133.2561.144137253.6000B5B5@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 22, 2014 at 12:18:53AM +0200, Benno Schulenberg wrote:
> 
> On Mon, Jul 21, 2014, at 23:32, Bernhard Voelker wrote:
> > On 07/21/2014 11:16 PM, Benno Schulenberg wrote:
> > > So how does umount determine that a device was mounted by a user
> > > and thus that the user is alllowed to unmount it again?
> > 
> > man sys-utils/mount.8  # the new one! ;-)
> 
> :)  Ah, the man page is too big!
> 
> >    user   Allow  an  ordinary user to mount the filesystem.
> >           The name of the mounting user is written to mtab
> >           (or to the private libmount file in /run/mount on
> >           system without regular mtab) so that he can unmount
> >           the filesystem again.
> 
> There is no /run directory on my system.  So this probably means
> that this mechanism requires a minimum kernel version?  Or should
> that be /var/run/mount?

All this is userspace stuff only, if you don't have /run than it uses
old obsolete /dev/.mount/utab

> By the way, Karel, what are these 'helper=' and 'uhelper=' things
> that are mentioned in umount.8?  Shouldn't these be mentioned in
> mount.8 too, and more extensively? 

Not sure, it's implemented for very special purpose when udisks mount
a device that should be umounted again by udisks. I don't think we
want to do any advertisement for this functionality.

> But... how can uhelper ever
> be specified when a mountpoint isn't defined in /etc/fstab?

It's never specified in fstab, it's specified by udisks when it calls
mount(8).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
