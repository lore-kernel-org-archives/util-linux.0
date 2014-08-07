Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:50971 "EHLO
	Ishtar.hs.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760AbaHGTPU (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 7 Aug 2014 15:15:20 -0400
Message-ID: <53E3D02F.5040300@tlinx.org>
Date: Thu, 07 Aug 2014 12:14:55 -0700
From: Linda Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: Bernhard Voelker <mail@bernhard-voelker.de>
CC: util-linux@vger.kernel.org
Subject: Re: Specifying a generic and per-fs mount line in /etc/fstab as well as no-canonicalize.
References: <53E2B27C.9020305@tlinx.org> <53E2B3FB.8050409@bernhard-voelker.de>
In-Reply-To: <53E2B3FB.8050409@bernhard-voelker.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Bernhard Voelker wrote:
> On 08/07/2014 12:55 AM, Linda A. Walsh wrote:
>   
>> if "/usr/src" is a symlink pointing to /home/src,
>> and under /home/src, packages points to ../packages, then when I
>> switch to /usr/src/packages, I see my path listed as /usr/src/packages:
>>
>>     
>>>>  cd /usr/src/packages
>>>>         
>> /usr/src/packages> pwd
>> /usr/src/packages
>>
>> Only by asking an external util can I find the real name:
>>     
> OT, but: no, "pwd -P" (pwd, the shell built-in) does.
>   
Yeah... by asking the builtin for the physical path, I could see
mount -p showing you the physical path.  But wouldn't
that be "/dev/dm-x"?  Where is it coming up with /dev/mapper/<mangledname>?

It's not the link the user gave, and it's not the real device, seems like
those are "dm" internal names?

maybe mount -d? for those?

or put all of them under 1 mountop  -D{d|p|s}?



