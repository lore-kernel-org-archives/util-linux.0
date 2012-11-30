Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56920 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932392Ab2K3UeU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 30 Nov 2012 15:34:20 -0500
Date: Fri, 30 Nov 2012 21:34:16 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: BUG: fdisk fails silently if EBR is outside of disk
Message-ID: <20121130203416.GC25818@x2.net.home>
References: <20121130105659.GA21271@x2.net.home>
 <50B8E344.9080405@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50B8E344.9080405@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Nov 30, 2012 at 11:48:04AM -0500, Phillip Susi wrote:
> > Device       Boot      Start         End      Blocks   Id   System 
> > /dev/loop0p1             256   462748159   231373952   83    Linux 
> > /dev/loop0p2       462748414   464843519     1047553    5 Extended 
> > /dev/loop0p5   ?   883823639  1304898863   210537612+  19  Unknown
> 
> If it could not read the EBR, where did it come up with the p5 entry?

 Sorry, I forgot to fix this nonsense. Fixed now.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
