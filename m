Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:6287 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750821AbaGRK7T (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 18 Jul 2014 06:59:19 -0400
Date: Fri, 18 Jul 2014 12:59:13 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: some comments about the new cfdisk
Message-ID: <20140718105913.GB17373@x2.net.home>
References: <1405350470.21924.141447857.78268FC5@webmail.messagingengine.com>
 <20140715105920.GS30288@x2.net.home>
 <1405509773.32592.142240757.286353E5@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405509773.32592.142240757.286353E5@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jul 16, 2014 at 01:22:53PM +0200, Benno Schulenberg wrote:
> 
> On Tue, Jul 15, 2014, at 12:59, Karel Zak wrote:
> > On Mon, Jul 14, 2014 at 05:07:50PM +0200, Benno Schulenberg wrote:
> > > Running cfdisk without an argument no longer works - it just
> > > blurts out the usage text, instead of picking the first and only
> > > hard drive in the system.
> > 
> > Yes, this is expected change. I think it's better to force
> > users to type the disk path than hardcode "sda" to the code,
> > but I have no strong opinion about it... no problem to change it.
> 
> It would be nice to have the old behaviour back.  Either that,
> or show an error message saying "expecting a device argument"
> instead of blasting out the entire usage text.

 OK, fixed. For v2.25 we're going use the original solution from old
 cfdisk (default to /dev/sda). For v2.26 I'd like to implement dialog
 where you can select the disk (if you have more disks).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
