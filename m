Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34128 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932309AbbFPI7V (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 16 Jun 2015 04:59:21 -0400
Date: Tue, 16 Jun 2015 10:59:19 +0200
From: Karel Zak <kzak@redhat.com>
To: Tom Yan <tom.ty89@gmail.com>
Cc: james harvey <jamespharvey20@gmail.com>, util-linux@vger.kernel.org
Subject: Re: Mount doesn't show subvol option for btrfs
Message-ID: <20150616085919.GW1992@ws.net.home>
References: <CA+X5Wn71btX_teX7AF-RJjo_2te5_VEZABAQSa6uWuYCtna1+g@mail.gmail.com>
 <20150615112827.GS1992@ws.net.home>
 <CAGnHSEntiMk3f1PPLj8RUJU+T0EeVP0-KqsVLwVWpPVPkzgDhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGnHSEntiMk3f1PPLj8RUJU+T0EeVP0-KqsVLwVWpPVPkzgDhQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 16, 2015 at 01:42:54PM +0800, Tom Yan wrote:
> [tom@localhost ~]$ mount | grep sda2
> /dev/sda2 on / type btrfs (rw,relatime,ssd,space_cache)
> 
> [tom@localhost ~]$ cat /proc/self/mountinfo | grep sda2
> 19 0 0:17 /arch / rw,relatime shared:1 - btrfs /dev/sda2 rw,ssd,space_cache
> 
> [tom@localhost ~]$ findmnt /dev/sda2
> TARGET SOURCE           FSTYPE OPTIONS
> /      /dev/sda2[/arch] btrfs  rw,relatime,ssd,space_cache
> 
> It won't be shown as a mount option.

Ah, good point. Yes, the subvolume directory is interpreted as FS
mount root, I forgot this btrfs feature.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
