Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36078 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526AbbH2D6O (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 28 Aug 2015 23:58:14 -0400
Received: by padhm10 with SMTP id hm10so25728539pad.3
        for <util-linux@vger.kernel.org>; Fri, 28 Aug 2015 20:58:13 -0700 (PDT)
Date: Fri, 28 Aug 2015 20:58:11 -0700
From: Isaac Dunham <ibid.ag@gmail.com>
To: james harvey <jamespharvey20@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Expected behavior of "mount /mnt/root /mnt/root --bind"
Message-ID: <20150829035810.GB1616@localhost>
References: <CA+X5Wn45VNhXYztEVxrccF6uePshfFv3X3isB39y5RYT1-uUAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+X5Wn45VNhXYztEVxrccF6uePshfFv3X3isB39y5RYT1-uUAg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Aug 29, 2015 at 03:32:30AM +0000, james harvey wrote:
> If /dev/vda is a btrfs volume (not using partitioning) and is mounted to /mnt
> 
> And if /mnt/root is made as a normal directory (not a subdirectory)
> 
> And if an nfs share is mounted to /mnt/root/mnt
> 
> And for some reason "mount /mnt/root /mnt/root --bind" is ran
> 
> ... Should /mnt/root/mnt now be viewable as an empty mountpoint,
> hiding the nfs share?

Yes, since you used --bind not --rbind.

> Right now it does that.  Not sure what the expected behavior would be.
> Not sure if "mount x x" is ever desired to be allowed, or if it should
> refuse to do that.

It's a documented and used feature that you can bind mount a directory
over itself.

HTH,
Isaac Dunham
