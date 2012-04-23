Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:27984 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754052Ab2DWJoY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 23 Apr 2012 05:44:24 -0400
Date: Mon, 23 Apr 2012 11:44:20 +0200
From: Karel Zak <kzak@redhat.com>
To: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: eject on Cygwin?
Message-ID: <20120423094420.GA8144@x2.net.home>
References: <7856072A9D04C24B82DFE2B1112FE38A0F0FD7A097@MCHP058A.global-ad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7856072A9D04C24B82DFE2B1112FE38A0F0FD7A097@MCHP058A.global-ad.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Apr 23, 2012 at 11:31:11AM +0200, Voelker, Bernhard wrote:
> Is there a specific reason for this line in configure.ac?
>   UL_REQUIRES_LINUX([eject])
> 
> Can't Cygwin handle /dev/scd0 correctly? 

 I don't know, the code also depends on /sys to detect if the device
 is removable, it calls umount(2) syscall, etc.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
