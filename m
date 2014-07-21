Return-Path: util-linux-owner@vger.kernel.org
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:33559 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752067AbaGUWS5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 21 Jul 2014 18:18:57 -0400
Message-Id: <1405981133.2561.144137253.6000B5B5@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: Karel Zak <kzak@redhat.com>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        =?ISO-8859-1?Q?P=E1draig=20Brady?= <P@draigbrady.com>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <53CD86FC.7000808@bernhard-voelker.de>
References: <53CCADA9.3020703@bernhard-voelker.de>
 <20140721082859.GD17373@x2.net.home>
 <1405977369.18035.144118445.737362A9@webmail.messagingengine.com>
 <53CD86FC.7000808@bernhard-voelker.de>
Subject: Re: mount.8: mtab as symlink
Date: Tue, 22 Jul 2014 00:18:53 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Mon, Jul 21, 2014, at 23:32, Bernhard Voelker wrote:
> On 07/21/2014 11:16 PM, Benno Schulenberg wrote:
> > So how does umount determine that a device was mounted by a user
> > and thus that the user is alllowed to unmount it again?
> 
> man sys-utils/mount.8  # the new one! ;-)

:)  Ah, the man page is too big!

>    user   Allow  an  ordinary user to mount the filesystem.
>           The name of the mounting user is written to mtab
>           (or to the private libmount file in /run/mount on
>           system without regular mtab) so that he can unmount
>           the filesystem again.

There is no /run directory on my system.  So this probably means
that this mechanism requires a minimum kernel version?  Or should
that be /var/run/mount?

By the way, Karel, what are these 'helper=' and 'uhelper=' things
that are mentioned in umount.8?  Shouldn't these be mentioned in
mount.8 too, and more extensively?  But... how can uhelper ever
be specified when a mountpoint isn't defined in /etc/fstab?

Benno

-- 
http://www.fastmail.fm - The way an email service should be

