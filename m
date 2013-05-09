Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:11616 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898Ab3EITHr (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 9 May 2013 15:07:47 -0400
Date: Thu, 9 May 2013 21:07:43 +0200
From: Karel Zak <kzak@redhat.com>
To: George Mitchell <george@chinilu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: umount and findmnt commands not working with btrfs labels ...
Message-ID: <20130509190743.GB9821@x2.net.home>
References: <51882EA5.9080805@chinilu.com>
 <20130507094835.GB7086@x2.net.home>
 <51891448.5010804@chinilu.com>
 <20130509094226.GD17527@x2.net.home>
 <518BC86D.2050702@chinilu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <518BC86D.2050702@chinilu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, May 09, 2013 at 09:01:49AM -0700, George Mitchell wrote:
> Karel,  Your answer left me really frustrated, but after rethinking the
> whole thing, I am left wondering if this whole issue, including the broader
> issue of what should appear on the mount table in the first place, would be
> better addressed by the btrfs group simply abstracting the mount point like
> software raid has always done and handling all the details internally within
> btrfs.  I already have seen applications that didn't understand btrfs
> partitions were in use and bad things could result from that.  It would be
> nice if btrfs would just lock all of these partitions out and represent them
> collectively to the broader system as /dev/mntX or whatever.  That would

 Do you mean abstract (virtual) block device (like we have for
 device-mapper, e.g /dev/dm0)? I think it's btrfs *feature* that there
 is not any virtual block device :-)

> surely greatly simplify things for everybody.  I am going broach that idea
> on the btrfs list.

 Well, it depends, nothing is perfect. The things like /dev/dm0 have
 some disadvantages (it's extra layer, extra support in userspace,
 etc.)

 Maybe possible solution would be to export more information about the
 btrfs filesystem in /proc, for example add complete list of all used
 (mapped) devices to /proc/self/mountinfo.

> Thanks so much for taking the time to discuss this with
> me.  It is much appreciated even though at the time I was not so happy with
> some of your answers.  - George

 We will see more problems with btrfs, because it provides completely
 new and different point of view where filesystem != device,
 multi-root filesystems, raids, subvolumes, etc.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
