Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34201 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751198AbcFXJTQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 24 Jun 2016 05:19:16 -0400
Date: Fri, 24 Jun 2016 11:19:14 +0200
From: Karel Zak <kzak@redhat.com>
To: Yigal Korman <yigal@plexistor.com>
Cc: util-linux@vger.kernel.org
Subject: Re: blkid partition infomartion
Message-ID: <20160624091914.ekiska2x77n2euqu@ws.net.home>
References: <CACTTzNa3aTiCrHBQrvwVvFwLQpTdGTDLGt+G3wycpMXEzXbXcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACTTzNa3aTiCrHBQrvwVvFwLQpTdGTDLGt+G3wycpMXEzXbXcw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 21, 2016 at 04:59:39PM +0300, Yigal Korman wrote:
> I have a question regarding this patch in util-linux:
> "blkid: don't ignore info about partitions on non-formated devices"
> (commit f8098e2b2c0a8a98ccb603f53dfba0cc05683a39)
> 
> I wanted to know what was the trigger for this change? what's the reasoning
> behind it?

I guess inconsistency with man page:

  Note that low-level probing also returns information about partition
  table type (PTTYPE tag) and partitions (PART_ENTRY_* tags).

.. and I'm not able to found if someone complained on mailing list.

> Background:
> I have an Linux automation script that formats a given partition and mounts
> it.
> In order to verify that the partition is empty (ie no other data exists
> there) I've been using 'blkid -p <partition>;  [[ $? != 2 ]] && fail".
> Which stopped working correctly when I moved to Ubuntu 16.04.
> I've tracked the issue to the patch mentioned above.
> 
> To me this patch seems to counter blkid behavior - returning the partition
> information when the given device is the partition doesn't describe what
> the device contains.

Yes, the patch seems pretty controversial. I'll think about revert.

> The same way that if /dev/sda is part of LVM, then 'blkid -p /dev/sda' will
> return the LVM information, but doing 'blkid -p /dev/mapper/vg-lv' will
> return what's inside the logical volume and not the logical volume
> information (and nothing if the empty).
> 
> Do you have a suggestion for a different method for testing if a device is
> empty?

 lsblk -n -o FSTYPE /dev/sda1

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
