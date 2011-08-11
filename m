Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33915 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751041Ab1HKSO5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 11 Aug 2011 14:14:57 -0400
Date: Thu, 11 Aug 2011 20:14:54 +0200
From: Karel Zak <kzak@redhat.com>
To: Florian Pritz <bluewind@xinu.at>
Cc: util-linux@vger.kernel.org
Subject: Re: mkswap fails to use more than 2GiB and doesn't recognize LVM
Message-ID: <20110811181454.GD32051@nb.net.home>
References: <4E43F629.6040408@xinu.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E43F629.6040408@xinu.at>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Aug 11, 2011 at 05:32:57PM +0200, Florian Pritz wrote:
> mkswap displays the following output when trying to create swap on a
> 8GiB logical volume.
> > # mkswap /dev/mapper/vg_brynhild-swap
> > mkswap: warning: truncating swap area to 2097144 KiB

 It seems correct. The swap header does not allow to address more than
 UINT_MAX pages. You have to create more swap areas or use system with
 bigger pages.

> > mkswap: /dev/mapper/vg_brynhild-swap: warning: don't erase bootbits sectors
> >         on whole disk. Use -f to force.
> > Setting up swapspace version 1, size = 2097140 KiB
> > no label, UUID=5eae2d8b-f664-46f5-983c-bdcd4301fa66
> 
> I tried adding -p 8589934592 to force 8GiB, but that doesn't change
> anything.

 :-)

> busybox mkswap crates the expected 8GiB swap, so I think this is a bug.

 Do you see see 8GiB swap area in /proc/swaps after swapon? I don't
 think so...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
