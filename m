Return-Path: util-linux-owner@vger.kernel.org
Received: from atl4mhob12.myregisteredsite.com ([209.17.115.50]:46206 "EHLO
	atl4mhob12.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755018Ab3EJAPG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 9 May 2013 20:15:06 -0400
Received: from mailpod1.hostingplatform.com ([10.30.71.117])
	by atl4mhob12.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id r4A0F4XH005638
	for <util-linux@vger.kernel.org>; Thu, 9 May 2013 20:15:04 -0400
Message-ID: <518C3C0E.7040008@chinilu.com>
Date: Thu, 09 May 2013 17:15:10 -0700
From: George Mitchell <george@chinilu.com>
Reply-To: george@chinilu.com
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: umount and findmnt commands not working with btrfs labels ...
References: <51882EA5.9080805@chinilu.com> <20130507094835.GB7086@x2.net.home> <51891448.5010804@chinilu.com> <20130509094226.GD17527@x2.net.home> <518BC86D.2050702@chinilu.com> <20130509195414.GU21041@codelibre.net>
In-Reply-To: <20130509195414.GU21041@codelibre.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 05/09/2013 12:54 PM, Roger Leigh wrote:
> If the filesystem could expose real devices to userspace, that would 
> IMO be a big improvement. Even if it's just a virtual "proxy" for the 
> filesystem. Regards, Roger 

On 05/09/2013 12:07 PM, Karel Zak wrote:
>
> Do you mean abstract (virtual) block device (like we have for 
> device-mapper, e.g /dev/dm0)? I think it's btrfs *feature* that there 
> is not any virtual block device :)

To address both of these comments, let me say this.  btrfs provides many 
of the capabilities of traditional RAID, THAT is a FEATURE. btrfs 
provides many of the capabilities of traditional LVM.  THAT is a 
FEATURE.  IF btrfs would provide a virtual "hook" (yes Karel, an 
abstract virtual block device, exactly!) that would be UNCHANGING, THAT 
would be a FEATURE.  The fact that it does not is NOT a feature, is 
rather a shortcoming.  It is like the used car salesman telling you that 
the fact the car he is selling is missing the spare tire is a "feature" 
(imagine all the gas you will save by not having to tow it around or 
maintain it).  FEATURES are about capabilities, not just lack of 
complexity.  Lack of complexity IS a feature IF it retains capability.  
In the case of btrfs, if my mount point drive breaks in service and I 
remove it, my mount point has just changed since the previous mount 
point is no longer even part of the volume anymore.  Those are the kind 
of issues that irritate me to no end. All the partitions involved in a 
btrfs volume are, in effect, "mounted" whether or not they appear on the 
mount table, whenever the volume is mounted.  But if I use a drive 
partitioning tool, IT doesn't know they are mounted because it is 
looking in the usual places.  On the other hand if they were assigned a 
virtual mount point all this would get taken care of.  I have used 
traditional RAID both software and hardware for years now.  With 
software RAID the virtual mount point is actually /dev/mdX.  Its been 
long enough since I last used software RAID that I had forgotten the 
label format.  In the case of LVM, which I have never used, you can 
apparently make the label whatever you want it to be and can use them to 
describe subvolumes as well.  THAT WOULD BE A FEATURE!  They carry the 
format /dev/FOO/SUB1 or just /dev/FOO for example.  But they describe 
the whole volume and whether you add partitions or subtract partitions, 
the device name remains virtually immutable. IMHO, a LOT of the problems 
we are experiencing now with btrfs can in some way be traced back to 
this arcane approach (my own opinion of course) of doing things without 
reliable virtual mount points. In some ways trying to contain btrfs is 
like trying to contain a jellyfish.  But I have seen a lot of things 
come and go over the years.  I started out back in the mid 1980s doing 
system administration on PDP 1170s running programmers workbench UNIX.  
And the more things change, the more they stay the same.  But eventually 
I suppose it will work itself out.  In the mean time we will all just 
have to be creative.

