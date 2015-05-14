Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52935 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751978AbbENGae (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 May 2015 02:30:34 -0400
Date: Thu, 14 May 2015 08:30:31 +0200
From: Karel Zak <kzak@redhat.com>
To: Ron <ron@debian.org>
Cc: Andreas Henriksson <andreas@fatal.se>, 785116@bugs.debian.org,
        util-linux@vger.kernel.org
Subject: Re: Bug#785116: util-linux: blkid -s returns too much information
Message-ID: <20150514063031.GG4834@ws.net.home>
References: <20150512132634.1127.8640.reportbug@hex.shelbyville.oz>
 <20150513063604.GA466@fatal.se>
 <20150513103706.GE4834@ws.net.home>
 <20150513212052.GM27477@hex.shelbyville.oz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150513212052.GM27477@hex.shelbyville.oz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, May 14, 2015 at 06:50:52AM +0930, Ron wrote:
> Right, in the situation where you *do* want multiple values, caring
> about the order should be less of a problem, since you'd just access
> the variables being set rather than trying to parse or interpret
> them literally.  If for some reason you did care about the order,
> you'd run that multiple times with one value for each invocation.
> 
> Which, right now if you do that, you'll end up with something like:
> 
>  # blkid -s UUID -o export /dev/sda2; blkid -s TYPE -o export /dev/sda2
>  DEVNAME=/dev/sda2
>  UUID=9621a7e3-14a1-4d03-8250-b4fbeb79999b
>  DEVNAME=/dev/sda2
>  TYPE=ext4
> 
> I guess the other case where that might bite you is if you were already
> using DEVNAME as a local variable for something else ...

I'd like to keep blkid as very basic command line interface to
libblkid and as the library test program. For standard use cases 
and scripts it's better to use lsblk(8) command which provides 
more information and better control on output format:

        # lsblk --pairs -o FSTYPE,UUID /dev/sda2
        FSTYPE="ext4" UUID="c5490147-2a6c-4c8a-aa1b-33492034f927"

        # lsblk --pairs -o UUID,FSTYPE /dev/sda2
        UUID="c5490147-2a6c-4c8a-aa1b-33492034f927" FSTYPE="ext4"

and it reads information from udev db or from libblkid.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
