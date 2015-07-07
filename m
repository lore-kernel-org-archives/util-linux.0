Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35437 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760AbbGGFFl (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 7 Jul 2015 01:05:41 -0400
Received: by oihr66 with SMTP id r66so77674502oih.2
        for <util-linux@vger.kernel.org>; Mon, 06 Jul 2015 22:05:40 -0700 (PDT)
Received: from [192.168.0.75] (cpe-70-123-244-133.satx.res.rr.com. [70.123.244.133])
        by mx.google.com with ESMTPSA id p205sm11371959oia.23.2015.07.06.22.05.39
        for <util-linux@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2015 22:05:39 -0700 (PDT)
Message-ID: <559B5E22.2050902@gmail.com>
Date: Tue, 07 Jul 2015 00:05:38 -0500
From: Bruce Dubbs <bruce.dubbs@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: [PATCH] agetty: Reprompt once the network addresses
 change if address displayed
References: <1435928288-25644-1-git-send-email-stefw@redhat.com> <20150706140711.GF17734@vapier> <559ACFC3.6050303@gmail.com> <20150707042512.GI17734@vapier>
In-Reply-To: <20150707042512.GI17734@vapier>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Mike Frysinger wrote:
> On 06 Jul 2015 13:58, Bruce Dubbs wrote:
>> Mike Frysinger wrote:
>>> On 03 Jul 2015 14:58, Stef Walter wrote:
>>>     #ifdef AGETTY_RELOAD
>>>>    # include <sys/inotify.h>
>>>> +# include <linux/netlink.h>
>>>> +# include <linux/rtnetlink.h>
>>>
>>> why not use libmnl instead ?
>>> 	http://netfilter.org/projects/libmnl
>>
>> That would not work for the LinuxFromScratch project.  At the time
>> util-linux is built, libmnl is not available.
>
> then update the LFS insns to include libmnl, or build util-linux with the
> reload option disabled.  i don't see how LFS's decisions are relevant here.
> -mike

Yes, we can do either, but it seems like a lot of overhead to add a new 
package for 95 lines of code that are already written.

We already manage about 1000 packages and are volunteers. Many of my 
users would call adding a new library for one minor function bloat.
None of the packages we support now use that library although that could 
change in the future if others start to use it.

Yes, our decisions are only a minor input to upstream packages, but 
there may be others that have similar concerns that don't monitor this list.

   -- Bruce

