Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:15741 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758039AbaGOJ4I (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 Jul 2014 05:56:08 -0400
Date: Tue, 15 Jul 2014 11:56:03 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: umount: --types does not limit
Message-ID: <20140715095603.GR30288@x2.net.home>
References: <1405331864.10850.141333833.2F92BBFD@webmail.messagingengine.com>
 <20140714145759.GM30288@x2.net.home>
 <1405351467.26224.141460601.7C1F0818@webmail.messagingengine.com>
 <20140715080234.GP30288@x2.net.home>
 <1405414924.13201.141769101.02687AE4@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405414924.13201.141769101.02687AE4@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 15, 2014 at 11:02:04AM +0200, Benno Schulenberg wrote:
> 
> On Tue, Jul 15, 2014, at 10:02, Karel Zak wrote:
> >    umount -t <type>
> > 
> >  the <type> is filesystem type (so you can force umount to use for
> >  example /sbin/umount.<type>).
> 
> Hmm.  But it's not working for me, the --types option does not limit
> umount in any way.  In the man page it says: "Indicate  that the
> actions should *only* be taken on filesystems of the specified type."
> 
> But, for example, here Suse is of type ext4 and gets mounted:
> 
> # ./mount -t ext4 /suse
> # ./mount | grep suse
> /dev/sda2 on /suse type ext4 (rw,noatime,noexec,nosuid,nodev,user)
> 
> Now I want to unmount all btrfs systems:
> 
> # ./umount -t btrfs /suse /zero /other
> # ./mount | grep suse
> 
> It just unmounts everything that is mentioned, the -t has no
> limiting effect.  So it is useful only with -a.

 grrr... you're right, I see.. libmount always overwrites the setting 
 by stuff from mtab.
 
 IMHO it would be nice to restrict the all the umount actions (like
 --recursive, --all-targets or when more mountpoints specified) by the
 pattern. I'll add this to the TODO file for v2.26.
 
 Thanks!
 
    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
