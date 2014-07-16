Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38262 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932720AbaGPL2Q (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Jul 2014 07:28:16 -0400
Message-Id: <1405509773.32592.142240757.286353E5@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Karel Zak <kzak@redhat.com>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <20140715105920.GS30288@x2.net.home>
References: <1405350470.21924.141447857.78268FC5@webmail.messagingengine.com>
 <20140715105920.GS30288@x2.net.home>
Subject: Re: some comments about the new cfdisk
Date: Wed, 16 Jul 2014 13:22:53 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Tue, Jul 15, 2014, at 12:59, Karel Zak wrote:
> On Mon, Jul 14, 2014 at 05:07:50PM +0200, Benno Schulenberg wrote:
> > Running cfdisk without an argument no longer works - it just
> > blurts out the usage text, instead of picking the first and only
> > hard drive in the system.
> 
> Yes, this is expected change. I think it's better to force
> users to type the disk path than hardcode "sda" to the code,
> but I have no strong opinion about it... no problem to change it.

It would be nice to have the old behaviour back.  Either that,
or show an error message saying "expecting a device argument"
instead of blasting out the entire usage text.

> > I have two megabytes of free space at the tail of the disk.  If
> > with the old cfdisk I delete the last partition, it will create
> > a single expanse of free space.  But with the new cfdisk it will
> > then have two free spaces:
> > 
> > >>  `-Free space      282779648 312576704  29797057  14.2G                      
> >     Free space        312578048 312581807      3760   1.9M
> 
> I guess the last partition is a logical partition. It's because
> the extended partition (container for logical partitions) has
> explicitly specified size and the new cfdisk does not change the 
> size. 

Yes, I figured that out too, after a while.

> It would be possible to add some extra optimization for MBR to
> enlarge/reduce the extended partition if there is a free space behind
> the partition and no possibility to create another primary partition.
> Not sure... I'll think about it.

Don't bother for now.  Somehow the current way feels more
precise.

Benno

-- 
http://www.fastmail.fm - The way an email service should be

