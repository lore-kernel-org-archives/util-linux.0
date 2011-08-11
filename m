Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:16745 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751845Ab1HKVq1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 11 Aug 2011 17:46:27 -0400
Date: Thu, 11 Aug 2011 23:46:24 +0200
From: Karel Zak <kzak@redhat.com>
To: Florian Pritz <bluewind@xinu.at>
Cc: util-linux@vger.kernel.org
Subject: Re: mkswap fails to use more than 2GiB and doesn't recognize LVM
Message-ID: <20110811214624.GE32051@nb.net.home>
References: <4E43F629.6040408@xinu.at> <20110811181454.GD32051@nb.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110811181454.GD32051@nb.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Aug 11, 2011 at 08:14:54PM +0200, Karel Zak wrote:
> On Thu, Aug 11, 2011 at 05:32:57PM +0200, Florian Pritz wrote:
> > mkswap displays the following output when trying to create swap on a
> > 8GiB logical volume.
> > > # mkswap /dev/mapper/vg_brynhild-swap
> > > mkswap: warning: truncating swap area to 2097144 KiB
> 
>  It seems correct.

 Ah... sorry, I didn't read your e-mail too carefully.

>  The swap header does not allow to address more than
>  UINT_MAX pages. You have to create more swap areas or use system with
>  bigger pages.

 Right, so if you have 4096 page size, then 4096 * 4294967295 is the
 max size...

 I think the problem is kernel version string -- "3.0". The mkswap
 code uses the version string to set the limit.

 The problem should be fixed in 2.20-rc1, commit
 fa7e0d6d442de9f5940f99fd93f4522602439131.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
