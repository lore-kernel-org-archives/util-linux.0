Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47112 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932671AbbAILQu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 9 Jan 2015 06:16:50 -0500
Date: Fri, 9 Jan 2015 12:16:48 +0100
From: Karel Zak <kzak@redhat.com>
To: Kay Sievers <kay@vrfy.org>
Cc: util-linux@vger.kernel.org
Subject: Re: cfdisk created GPT tables are not recognized by the Windows 8.1
 installer
Message-ID: <20150109111648.GC1314@x2.net.home>
References: <CAPXgP1300xmdYHCbBpdbRiFDAKvab4w33Jt5ZEGdkrQ4_9tj_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPXgP1300xmdYHCbBpdbRiFDAKvab4w33Jt5ZEGdkrQ4_9tj_A@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Dec 25, 2014 at 11:57:56PM +0100, Kay Sievers wrote:
> the Windows 8.1 installer does not recognize the GPT partition tables
> created with cfdisk. It claims it will need to initialize the entire
> disk to install Windows.

hmm... the difference which I see is that libparted uses HeaderSize=92
and libfdisk HeaderSize=512. In libfdisk we count reserved area at the 
end of the first sector to header. The both solutions are pretty
valid according to standard, but I guess that Windows installer does
not real all the sector so crazy things may happen (crc, ...).

> Reading-in the cfdisk-created table and writing-back the very same
> table with parted, makes the Windows installer recognizes it, and
> Windows just its two additional partitions.
> 
> I've installed Windows on that box now and don't want to try this
> again

Sure, Christmas time with Windows 8... seems like Santa Claus hates
you; be better this year :-))

> but maybe looking at the difference what parted will change in
> the cfdisk created table is sufficient to find the bug.

Yep, thanks!

    Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
