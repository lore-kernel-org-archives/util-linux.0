Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49570 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751972AbcIAXWX (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 1 Sep 2016 19:22:23 -0400
Date: Fri, 2 Sep 2016 01:22:21 +0200
From: Karel Zak <kzak@redhat.com>
To: Scott Moser <smoser@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: request for sfdisk --no-blkrrpart
Message-ID: <20160901232221.ldznwbbh2bprcjt3@ws.net.home>
References: <alpine.DEB.2.20.1609011256580.13370@milhouse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.20.1609011256580.13370@milhouse>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Sep 01, 2016 at 01:08:46PM -0400, Scott Moser wrote:
> Hi,
> 
> I maintain 'growpart' in cloud-utils, which handles growing partitions to
> fill up extra space.  Its common that disk images in vms will have
> additional space added to the end, and growpart just resizes the partition
> to take advantage of that if it is present.
> 
> Ubuntu just updated to 2.28.1 and cloud-utils and that caused bug
> http://pad.lv/1619285.  I see that we are now now running with this in
> place:
>   commit e0d30ef4c sfdisk: exit with error if rereading partition table fails
> 
> Then i see in trunk that that is reverted:
> 
>   commit 78e7f7889 Revert "sfdisk: exit with error if rereading partition table fails"

Yes, already reported for Fedora. It was mistake to add the patch to
2.28.1, I'm going to release 2.28.2 without this patch next week.

> 
> In the past I had put some hacky error message output string matching
> handle failure due only to BLKRRPART having failed, since the partition
> i'm resizing usually is mounted as /.
> 
> Long story short, could you add a '--no-blkrrpart' flag that growpart
> could add in its usage.  Then it wouldn't have to deal with ignoring an
> expected failure.  Growpart handles calling
>    partx --update --nr <PART> <DEVICE>

I'd like to add more smart re-read partition code to libfdisk to avoid
global re-read ioctl and use per-partition BLKPG_{ADD,RESIZE,DEL}
ioctls, so call "partx --update" will be unnecessary.

And yes, --no-blkrrpart makes sense too.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
