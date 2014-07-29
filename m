Return-Path: util-linux-owner@vger.kernel.org
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:50623 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751165AbaG2Tlb (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 29 Jul 2014 15:41:31 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by gateway1.nyi.internal (Postfix) with ESMTP id 691962108D
	for <util-linux@vger.kernel.org>; Tue, 29 Jul 2014 15:41:30 -0400 (EDT)
Message-Id: <1406662890.522051.146931049.1CA56A43@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Karel Zak <kzak@redhat.com>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <20140729102122.GU8533@x2.net.home>
References: <53CCADA9.3020703@bernhard-voelker.de>
 <20140721082859.GD17373@x2.net.home>
 <1405977369.18035.144118445.737362A9@webmail.messagingengine.com>
 <53CD86FC.7000808@bernhard-voelker.de>
 <1405981133.2561.144137253.6000B5B5@webmail.messagingengine.com>
 <20140721234936.GH17373@x2.net.home>
 <1406487424.22794.146193409.16E8F3E3@webmail.messagingengine.com>
 <20140729102122.GU8533@x2.net.home>
Subject: helper= and uhelper=
Date: Tue, 29 Jul 2014 21:41:30 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Tue, Jul 29, 2014, at 12:21, Karel Zak wrote:
> On Sun, Jul 27, 2014 at 08:57:04PM +0200, Benno Schulenberg wrote:
> > So... should it be removed from the man page of umount too?
> > If so, the third patch in the upcoming series does that.
> 
>  Please, no. It's described in the section where is description of the
>  API between umount(8) and external helpers. IMHO 'helper=' and
>  'uhelper=' makes sense there.

Well, you applied the third patch in the series of six anyway, :)
so the mention of those [u]helper markers was removed.  I'll submit
a patch later to restore them, worded more clearly.  But first let's
make sure that I understand what they mean.

First there was commit f19c952b2fc07ddd7a698cf3a213a9a16d13e7ba
"umount: use helper= for all UIDs", where 'phelper' is renamed
to 'helper', because it serves not just for root.  But two weeks
earlier there was commit c56226697342ddd663492f77768e7a7cb8e579a1
"umount: call /sbin/umount.<uhelper> for root user too".

So, if I understand well, uhelper= and helper= would behave
exactly the same under all circumstances?

$ udisks --mount /dev/sda3
Mounted /org/freedesktop/UDisks/devices/sda3 at /media/Mint Petra

$ grep sda3 /etc/mtab
/dev/sda3 /media/Mint\040Petra ext4 rw,nosuid,nodev,uhelper=udisks 0 0

$ ./umount -v /dev/sda3

(Oh, that last command is surprising: it doesn't say anything.  I would
expect it to say that /dev/sda3 was successfully unmounted.  Oh, and
why isn't sda3 'noexec' here although it was mounted by a user?)

So when using udisks, a uhelper= marker will be put into the /etc/mtab
file (the real one).  Is there any program that will put a helper= marker
in the /etc/mtab file?  (I call it a 'marker' because it is not a mount
option: putting it in /etc/fstab makes no sense, and using it on the
command line does not work).

$ ./mount -o uhelper=udisks /dev/sda3
lt-mount: only root can use "--options" option

$ sudo ./mount -o uhelper=udisks /dev/sda3
lt-mount: can't find /dev/sda3 in /etc/fstab

Benno

-- 
http://www.fastmail.fm - Choose from over 50 domains or use your own

