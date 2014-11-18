Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37310 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753169AbaKRLDg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 18 Nov 2014 06:03:36 -0500
Date: Tue, 18 Nov 2014 12:03:29 +0100
From: Karel Zak <kzak@redhat.com>
To: Lutz Vieweg <lvml@5t9.de>
Cc: util-linux@vger.kernel.org
Subject: Re: fstrim tries to discard data beyond the last sector of a device
Message-ID: <20141118110329.GG6704@x2.net.home>
References: <m3qnrg$5gc$1@ger.gmane.org>
 <m4f77a$ivg$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m4f77a$ivg$1@ger.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Nov 18, 2014 at 11:32:10AM +0100, Lutz Vieweg wrote:
> I'm kind of concerned that there was no reaction on my recent
> post - maybe the subject I chose wasn't colorful enough to
> draw attention on what I think is a real threat to data integrity
> on persistent storage.

This is upstream development mailing list, it's better to report bugs
to distribution specific mailing lists or bug tracking systems.

what is your fstrim command line, it would be nice to see strace
output to verify the ioctl return code. 

> The "Logical block address out of range" error amongst the (cited below)
> messages says no less than that fstrim issued a fitrim ioctl that
> was asking the device to discard the content of sectors well beyond
> the boundaries of the device. If it wasn't for the "end of the physical
> device" making the SSD return an error, if instead there was another
> partition behind a filesystem to trim, then valuable, live data
> would have been discarded.
> 
> If email to this list is not a suitable form to report such issues,
> please let me know where I can report this issue better.

Maybe you can ask linux-fs mailing list. It really does not seem like
fstrim command issue.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
