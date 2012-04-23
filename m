Return-Path: util-linux-owner@vger.kernel.org
Received: from senmx12-mx.siemens-enterprise.com ([62.134.46.10]:43327 "EHLO
	senmx12-mx.siemens-enterprise.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754241Ab2DWJtm convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 23 Apr 2012 05:49:42 -0400
From: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
To: Karel Zak <kzak@redhat.com>
CC: util-linux <util-linux@vger.kernel.org>
Date: Mon, 23 Apr 2012 11:49:37 +0200
Subject: RE: eject on Cygwin?
Message-ID: <7856072A9D04C24B82DFE2B1112FE38A0F0FD7A0B9@MCHP058A.global-ad.net>
References: <7856072A9D04C24B82DFE2B1112FE38A0F0FD7A097@MCHP058A.global-ad.net>
 <20120423094420.GA8144@x2.net.home>
In-Reply-To: <20120423094420.GA8144@x2.net.home>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:

> On Mon, Apr 23, 2012 at 11:31:11AM +0200, Voelker, Bernhard wrote:
> > Is there a specific reason for this line in configure.ac?
> >   UL_REQUIRES_LINUX([eject])
> > 
> > Can't Cygwin handle /dev/scd0 correctly? 
> 
>  I don't know, the code also depends on /sys to detect if the device
>  is removable, it calls umount(2) syscall, etc.

okay, thanks.
Anyway, porting u-l to cygwin is not much fun anymore,
e.g. due to new close_stdout() which needs __fpending, and
lib/randutils.c needs sys/syscall.h to check if __NR_gettid
is defined etc.

Have a nice day,
Berny
