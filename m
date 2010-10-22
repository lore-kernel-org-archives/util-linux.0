Return-Path: util-linux-ng-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:32536 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753947Ab0JVU5d (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Fri, 22 Oct 2010 16:57:33 -0400
Date: Fri, 22 Oct 2010 22:57:27 +0200
From: Karel Zak <kzak@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: util-linux-ng@vger.kernel.org
Subject: Re: NFS remount bug
Message-ID: <20101022205726.GE1730@nb.net.home>
References: <6BEE826D-5AC3-4CA7-A954-6255A6BD7AED@oracle.com> <9706D446-5B62-42FC-A3D7-23046AB96822@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9706D446-5B62-42FC-A3D7-23046AB96822@oracle.com>
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux-ng.vger.kernel.org>

On Fri, Oct 22, 2010 at 04:14:53PM -0400, Chuck Lever wrote:
 
> This is documented in
> 
>   https://bugzilla.linux-nfs.org/show_bug.cgi?id=188
> 
> There are some interesting test results posted there.
> 
> This looks like behavior that is totally controlled by mount(8),
> since mount(8) passes the correct options to mount.nfs in some
> cases, and sometimes it doesn't.

 Yes (but it does not mean that you cannot read the original options
 from mtab in mount.nfs).

> If the mount point is not already in /etc/fstab, and the remount
> command line does not include the "device" (it looks like "mount -o
> remount,foo /mntdir") then it gets it right (that is, it adds the
> correct set of mount options back to /etc/mtab).  Other combinations
> don't get it right.
> 
> Is there a reason why the set of mount options that appear in
> /etc/mtab should be different depending on how the remount command
> is specified and whether the mount point appears in /etc/fstab?  Any
> chance this can be made to work consistently in each of these cases?
> 
> Thanks for any advice, or history lessons.

This is old and documented behaviour. There is not a difference
between remount and normal mount.

    # mount <source> <target>

means that you want to bypass fstab (mount(8) has all necessary
information on command line), but

    # mount <source> | <target>

means that you have to use fstab (command line does not contain all
information). 

If fstab does not contain <source> or <target> then it lookups mtab,
it's was probably added because

    # mount /dev/sda1 /mnt 
    # mount -o remount,ro /mnt

is expected to work independently on fstab.

I see only one problem -- many many years ago there probably wasn't
difference between mount options in fstab and mtab, so it was correct
to lookup fstab before mtab on remount. This is problem now.

IMHO mount(8) should be fixed to read mount options only from mtab
on remount. The fstab file should be ignore at all.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
