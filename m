Return-Path: util-linux-owner@vger.kernel.org
Received: from iolanthe.rowland.org ([192.131.102.54]:33945 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751017AbbFVOcq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 22 Jun 2015 10:32:46 -0400
Date: Mon, 22 Jun 2015 10:32:45 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Tom Yan <tom.ty89@gmail.com>
cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, Karel Zak <kzak@redhat.com>,
        <util-linux@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: Re: optimal io size / custom alignment
In-Reply-To: <CAGnHSE=DGa24TPox8wp4k264jnXjMOq7kzf-tCRf1eJt9kN0ZQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1506221029260.1799-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, 21 Jun 2015, Tom Yan wrote:

> I was not saying RAIDs are virtual devices. I just mentioned it
> because I saw things like virtio-blk or zram use blk_queue_io_opt().
> 
> I know they all use VPDs, but the main point is whether those hardware
> RAIDs or so are handled by sd_mod, and whether those "transfer
> lengths" info are still important when it's just a simple drive. To me
> they look like to be of different nature. That's why I think it's
> inappropraite that they use the same "variable" / "file" to report
> because that makes tools like fdisk have trouble determining when does
> those values really matters.
> 
> In fact, (maybe I am just unlucky :P) VPDs of all my devices are to
> some extent broken. I just found out today my Intel 530 SSD connecting
> directly to SATA also reports totally garbage values for TRIM : (
> 
> To be honest the UAS thing doesn't really affect me a lot, I mostly
> use gdisk now (which doesn't care about i/o size AFAIK). I can also
> disable uas with the quirk so that VPDs are skipped when I really need
> fdisk for msdos/mbr. It's just I think that it kind of reveal a
> problem that has to be dealt with sooner or later, though you can
> optimistically think that vendors would do better on VPDs in the
> future.

Regardless of all these issues, it is clear that a lot of devices don't 
implement the VPD data correctly.  Therefore the information in the 
kernel will often be wrong.

And consequently, fdisk needs to offer the user an option to override 
the default partition-alignment setting.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe util-linux" in
