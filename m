Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f179.google.com ([209.85.192.179]:48410 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933959AbaJ2Qkw (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 29 Oct 2014 12:40:52 -0400
Received: by mail-pd0-f179.google.com with SMTP id g10so3294138pdj.38
        for <util-linux@vger.kernel.org>; Wed, 29 Oct 2014 09:40:52 -0700 (PDT)
Received: from [192.168.1.2] ([117.208.69.53])
        by mx.google.com with ESMTPSA id dx10sm4819106pab.38.2014.10.29.09.40.49
        for <util-linux@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 Oct 2014 09:40:51 -0700 (PDT)
Message-ID: <5451187A.3000304@gmail.com>
Date: Wed, 29 Oct 2014 22:10:26 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: fdisk and 2048 sectors obsession.
References: <544E923E.6050406@gmail.com> <20141028075308.GI10134@x2.net.home> <yq138a8pdxh.fsf@sermon.lab.mkp.net> <544FAE07.6080605@gmail.com> <20141028153557.GA20378@thunk.org>
In-Reply-To: <20141028153557.GA20378@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 10/28/14 21:05, Theodore Ts'o wrote:
> On Tue, Oct 28, 2014 at 08:23:59PM +0530, dE wrote:
>>> Not only that. It was an explicit request from IDEMA. The disk drive and
>>> RAID vendors asked all operating system vendors to ensure 1MB alignment
>>> by default.
>>>
>> Ok, it's an IDEMA recommendation. That's why.
> One additional reason why it's a good idea is for better compatibility
> with drive-managed or host-aware SMR (Shingled Magnetic Recording)
> disks, it's a really good idea if partitions are aligned on 256 MiB
> boundaries.
>
> And in the future, the hard drive vendors hope to promulgate 32k or
> 64k native sector size.  If we adopted the suggestion to align new
> partitions at 4k after the MBR, it would be disastrous for SMR disks
> (some of which will be shipping soon, or may be shipping already but
> you might know it, especially for some high-capacity USB attached
> storage), and for these larger sector disks.
>
> Or if you are using very low-end flash (i.e., on SD cards) which have
> a very primitive FTL, if the partitions aren't aligned on the erase
> block, you will also have terrible performance --- and this is true
> today.
>
> Given the painful history of how long it took to get OS vendors to
> move off of a sector 63 offset (a decade, thanks to Windows XP), it's
> not surprising IDEMA has requested that all OS vendors use a 1MB
> alignment for partitions going forward.
>
> So I don't think we want to change the default.  If you're so hard up
> for space that clawing back that extra 1020k with of disks on a 2T or
> 6T disk is significant, you can manually adjust the starting offset of
> the partition.  But I really don't think it's worth it, at least for
> myself....
>
> Cheers,
>
> 						- Ted

Thanks for all the answers everyone!

Now I get the point.

This conversation will get a lot of hits.
