Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52894 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751141Ab3EMMl1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 13 May 2013 08:41:27 -0400
Date: Mon, 13 May 2013 14:41:24 +0200
From: Karel Zak <kzak@redhat.com>
To: Bruce Dubbs <bruce.dubbs@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: umount -r
Message-ID: <20130513124010.GA1865@x2.net.home>
References: <518C7226.7020407@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <518C7226.7020407@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, May 09, 2013 at 11:05:58PM -0500, Bruce Dubbs wrote:
> We have as a part of our shutdown scripts:
> 
> umount -a -d -r -t notmpfs,nosysfs,nodevtmpfs,noproc
> 
> What we expect is that the rootfs (/) will fail, but be remounted read only.
> This doesn't seem to be happening because we get messages about recovery
> needed during the next boot.
> 
> We can work around it by adding
> 
> mount -n -o remount,ro /
> 
> I have a report that umount works as expected in version 2.21.2, but not in
> 2.22.2 or later.  I this a misunderstanding about umount or a bug?

Please, run

 LIBMOUNT_DEBUG=0xffff umount -a -d -r -t notmpfs,nosysfs,nodevtmpfs,noproc &> umount.log

and send me the log file.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
