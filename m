Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39042 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754046AbbFOL23 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 15 Jun 2015 07:28:29 -0400
Date: Mon, 15 Jun 2015 13:28:27 +0200
From: Karel Zak <kzak@redhat.com>
To: james harvey <jamespharvey20@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Mount doesn't show subvol option for btrfs
Message-ID: <20150615112827.GS1992@ws.net.home>
References: <CA+X5Wn71btX_teX7AF-RJjo_2te5_VEZABAQSa6uWuYCtna1+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+X5Wn71btX_teX7AF-RJjo_2te5_VEZABAQSa6uWuYCtna1+g@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 14, 2015 at 04:50:09PM -0400, james harvey wrote:
> Not sure if this could be a linux-unionfs (btrfs) bug instead...
> 
> On arch, /etc/fstab includes:
> 
> /dev/sda1   /.snapshots   btrfs
> rw,noatime,compress=lzo,ssd,discard,space_cache,subvol=.snapshots   0
>  0
> 
> But mount includes:
> 
> /dev/sda1 on /.snapshots type btrfs
> (rw,noatime,compress=lzo,ssd,discard,space_cache)
> 
> The subvol option isn't reported in mount.


 mount(8) uses /proc/self/mountinfo as source, do you see the subvol=
 mount option there?

 (well, I guess you have system without mtab and recent util-linux.)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
