Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43389 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750914AbaIBHa2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 2 Sep 2014 03:30:28 -0400
Date: Tue, 2 Sep 2014 09:30:20 +0200
From: Karel Zak <kzak@redhat.com>
To: Francis Moreau <francis.moro@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Weird behaviour with lsblk and freshly created loop device
Message-ID: <20140902073020.GB21325@x2.net.home>
References: <54049344.4010502@gmail.com>
 <20140901175609.GA21325@x2.net.home>
 <54056BD1.1080205@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54056BD1.1080205@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Sep 02, 2014 at 09:03:45AM +0200, Francis Moreau wrote:
> It seems that lsblk uses udev to get some block device metadata and asks
> some others to the kernel. If so, it makes the whole process racy
> because udev might not have handled the events sent by the kernel yet.
> 
> I'm not sure why udev is used by default in the first place, what are

 * info from udev is accessible for non-root users
 * it's better to scan devices only once on one place only
 * udev is able to gather information from more sources (for example
   libblkid does not provide WWN)

> the benefits ? Using libblkid, at least by default seems the right thing
> to do.
> 
> Otherwise maybe lsblk should do the equivalent of 'udevadm settle' to
> handle correctly freshly created devices ?

That's question, now (because it's not hardcoded to lsblk) everyone is
able to control this behavior, all you need is to add 'udevadm settle'
to your use-case. 

The problem I see is that there is no any hint about this behavior in
lsblk man page.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
