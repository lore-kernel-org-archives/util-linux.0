Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:16401 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756783Ab2ECO3J (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 3 May 2012 10:29:09 -0400
Message-ID: <4FA29633.70508@ubuntu.com>
Date: Thu, 03 May 2012 10:29:07 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Mike Frysinger <vapier@gentoo.org>
CC: Thomas Orgis <thomas-forum@orgis.org>, util-linux@vger.kernel.org
Subject: Re: losetup -d --force for zombie loop devices?
References: <20120417100346.2a0b8301@orgis.org> <201204301607.22712.vapier@gentoo.org> <4F9FFFFE.5070404@ubuntu.com> <201205030043.21697.vapier@gentoo.org>
In-Reply-To: <201205030043.21697.vapier@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 5/3/2012 12:43 AM, Mike Frysinger wrote:
>> When you detach it entirely from the namespace, you can't even be aware
>> that the mount still exists, let alone change your mind and reattach it.
>
> you can re-attach it by mounting it again

The last time I tried this, you couldn't and that made sense because 
most filesystems require exclusive access to the block device, which 
they can't get with the other ghost mount still hanging around. 
Mounting the same block device twice would cause massive corruption. 
Now that I try it again, it appears to let you.  Based on the kernel 
prints, it looks like it is somehow magically reattaching the existing 
mount instead of creating a new one.  Oddly though, the reattached mount 
can be unmounted without -l, even though it is still in use.

I'll have to test with removable media again.  Presumably this new 
reattach behavior would cause the contents of the old cd to show up 
again while dmesg spews IO errors, which may be slightly better than the 
old behavior of simply being unable to mount the drive with no 
explanation as to why, but is still very much not good.

> conversely, having a mount point removed from the perspective of userspace can
> be useful.  like with tools that stubbornly enumerate all mounts, or
> attempting to shutdown your system with known unreachable network mounts.
> you, as the admin, know these things are gone and beyond accessible, so having
> the ability to remove them all manually and reboot cleanly (w/out ridiculous
> long retries/timeouts) is a good thing.

If you want to hide mounts from certain processes, that is what unshare 
is for.  Hiding a mount from all processes does not make sense.  If you 
know a mount is gone and beyond recovery ( like in this loop over nfs 
case, or removed media ), then it should be forcibly unmounted, not 
simply made invisible and doomed to remain a zombie mount until the 
system is rebooted.

>> It is very confusing when you later try to change the cd in the drive
>> and can't mount it because the old one is still mounted, yet lsof,
>> mount, etc offer no evidence that this is the case, and you can't track
>> down the process that is still holding an open fd and kill it.
>
> are you sure that's true ?  `lsof -n` seems to report open handles to
> unmounted filesystems to me.
> -mike

It does, but they have been reparrented as if the filesystem was mounted 
in the root, so you can't search for the files using their previous 
mount point.

