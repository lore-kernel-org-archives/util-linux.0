Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60877 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754904AbaG3H0q (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 30 Jul 2014 03:26:46 -0400
Date: Wed, 30 Jul 2014 09:26:39 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: helper= and uhelper=
Message-ID: <20140730072639.GY8533@x2.net.home>
References: <53CCADA9.3020703@bernhard-voelker.de>
 <20140721082859.GD17373@x2.net.home>
 <1405977369.18035.144118445.737362A9@webmail.messagingengine.com>
 <53CD86FC.7000808@bernhard-voelker.de>
 <1405981133.2561.144137253.6000B5B5@webmail.messagingengine.com>
 <20140721234936.GH17373@x2.net.home>
 <1406487424.22794.146193409.16E8F3E3@webmail.messagingengine.com>
 <20140729102122.GU8533@x2.net.home>
 <1406662890.522051.146931049.1CA56A43@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406662890.522051.146931049.1CA56A43@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 29, 2014 at 09:41:30PM +0200, Benno Schulenberg wrote:
> Well, you applied the third patch in the series of six anyway, :)

oh, I usually check if the patch applies to code to do more
detailed review and I forgot you have talked about uhelper= too.

> so the mention of those [u]helper markers was removed.  I'll submit
> a patch later to restore them, worded more clearly.  But first let's

please

> make sure that I understand what they mean.
> 
> So, if I understand well, uhelper= and helper= would behave
> exactly the same under all circumstances?

We have three types of umount helpers

 umount.<type>    where <type> is filesystem type (e.g. umount.nfs)

 umount.<helper>  this is exactly the same like mount.<type> but the name is 
                  from helper= mtab option

 If you want to umount any filesystem and you have no root permissions
 then the filesystem has to be in fstab (and in mtab with 'user'
 option).

 umount.<uhelper> helper for unprivileged users, the filesystem does
                  not have to be in fstab, the entry in mtab is enough.
 
 Note that all helpers are always executed without root permissions,
 the helper has to be suid or use any other way to do umount(2).

> $ udisks --mount /dev/sda3
> Mounted /org/freedesktop/UDisks/devices/sda3 at /media/Mint Petra
> 
> $ grep sda3 /etc/mtab
> /dev/sda3 /media/Mint\040Petra ext4 rw,nosuid,nodev,uhelper=udisks 0 0
> 
> $ ./umount -v /dev/sda3
>
> (Oh, that last command is surprising: it doesn't say anything.  I would
> expect it to say that /dev/sda3 was successfully unmounted.  Oh, and

 well, report it to udisk

> why isn't sda3 'noexec' here although it was mounted by a user?)

 udisks have any policy for this purpose ... and "noexec" is pseudo
 security optimization, you can copy the file to you $HOME and
 execute. The options nosuid,nodev are more important. Anyway, all
 this is controlled by udisks.

> So when using udisks, a uhelper= marker will be put into the /etc/mtab
> file (the real one).  Is there any program that will put a helper= marker
> in the /etc/mtab file?

 I don't remember any program with "helper=", but it means nothing.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
