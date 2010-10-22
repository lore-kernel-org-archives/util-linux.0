Return-Path: util-linux-ng-owner@vger.kernel.org
Received: from rcsinet10.oracle.com ([148.87.113.121]:29756 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757199Ab0JVUQe convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Fri, 22 Oct 2010 16:16:34 -0400
Subject: Re: NFS remount bug
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <6BEE826D-5AC3-4CA7-A954-6255A6BD7AED@oracle.com>
Date: Fri, 22 Oct 2010 16:14:53 -0400
Cc: util-linux-ng@vger.kernel.org
Message-Id: <9706D446-5B62-42FC-A3D7-23046AB96822@oracle.com>
References: <6BEE826D-5AC3-4CA7-A954-6255A6BD7AED@oracle.com>
To: kzak@redhat.com
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux-ng.vger.kernel.org>


On Oct 19, 2010, at 1:32 PM, Chuck Lever wrote:

> Hi-
> 
> I'm working on the NFS submount commands.  These are found in the nfs-utils package, but they inherited a bunch of code from utils-linux to read fstab and manage mtab.
> 
> We've got a little problem with "-o remount".
> 
> At mount time, mount.nfs can negotiate with the target NFS server to determine how to contact it to send the MNT request and set up the communication parameters for the NFS protocol.  If the mount process succeeds, mount.nfs puts the command line options in /etc/mtab.
> 
> At umount time, umount.nfs reads these options back from /etc/mtab so that it can figure out how to send a UMNT request.  There are some problem cases, though.
> 
> If /etc/mtab is a link to /proc/mounts, the final fixed negotiated options appear there, not necessarily what was on the command line.  If the server reboots, some of those options might become stale.
> 
> If a remount is done, the options in /etc/mtab are wiped, so umount.nfs has no way to know how to contact the server.
> 
> We also know that everyone wants to toss /etc/mtab.
> 
> So: what future-proof mechanism do we use to preserve the mount command line so umount.nfs has a chance of working reliably?
> 
> In the meantime, is there a straightforward way to merge the old and new mount options during a remount?

This is documented in

  https://bugzilla.linux-nfs.org/show_bug.cgi?id=188

There are some interesting test results posted there.

This looks like behavior that is totally controlled by mount(8), since mount(8) passes the correct options to mount.nfs in some cases, and sometimes it doesn't.

If the mount point is not already in /etc/fstab, and the remount command line does not include the "device" (it looks like "mount -o remount,foo /mntdir") then it gets it right (that is, it adds the correct set of mount options back to /etc/mtab).  Other combinations don't get it right.

Is there a reason why the set of mount options that appear in /etc/mtab should be different depending on how the remount command is specified and whether the mount point appears in /etc/fstab?  Any chance this can be made to work consistently in each of these cases?

Thanks for any advice, or history lessons.

-- 
chuck[dot]lever[at]oracle[dot]com




