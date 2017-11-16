Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35020 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932997AbdKPKlX (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 16 Nov 2017 05:41:23 -0500
Date: Thu, 16 Nov 2017 11:41:20 +0100
From: Karel Zak <kzak@redhat.com>
To: kalle <kalle@projektwerkstatt.de>
Cc: util-linux@vger.kernel.org
Subject: Re: mount: how to identify filesystems to mount them
Message-ID: <20171116104120.a4clmwg5uu4lbkps@ws.net.home>
References: <ff28d2dd-c527-3d5f-e804-1ce468518b83@projektwerkstatt.de>
 <20171115163729.ihe4vnhmxbj2jprz@ws.net.home>
 <cdc6aeb0-7263-e80a-1f3c-87521de7fca9@projektwerkstatt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cdc6aeb0-7263-e80a-1f3c-87521de7fca9@projektwerkstatt.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 15, 2017 at 11:58:44PM +0100, kalle wrote:
> On 15.11.2017 17:37, Karel Zak wrote:
> > On Wed, Nov 15, 2017 at 05:18:17PM +0100, kalle wrote:
> > > hello,
> > > -i think it would be good, if it would be explained shortly, what a file
> > > system is
> > > -what would be good would be an explanation, how to find out filesystem,
> > > label, UUID or device name of a given device...
> > man mount, section "Indicating the device" is not enough?
> No. given the case I have a usb-stick. If I would recognize the label, the
> files on it or the size because they are written outside on the hardware of
> the stick or because I recognize my files stored on the stick. Now if I plug
> it in, how do I know which device to mount? "mount -L" doesn't help me
> further, since I don't know the label exactly by heart, pressing the
> `TAB'-key produces file names and not labels.
> What I did in the past was looking at /dev/disk/by-... for the label/id to
> recognize my stick, but this procedure is lengthy and not recommended by you
> on the man-page.
> I simply don't have a nice answer to this problem.

OK, I've updated the man page. The command "lsblk --fs" should be goot
enough to provide overview about available filesytems and its
LABEL/UUIDS.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
