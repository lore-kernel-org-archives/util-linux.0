Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:50639 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964818AbbLROc3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 18 Dec 2015 09:32:29 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: sfdisk, re-eading partition table fails
Date: Fri, 18 Dec 2015 15:32:17 +0100
Cc: util-linux@vger.kernel.org
References: <201512141311.59328.sweet_f_a@gmx.de> <20151215102408.GG2353@ws.net.home> <201512151326.33633.sweet_f_a@gmx.de>
In-Reply-To: <201512151326.33633.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201512181532.18097.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 15 December 2015, Ruediger Meier wrote:
> On Tuesday 15 December 2015, Karel Zak wrote:
> > On Mon, Dec 14, 2015 at 01:11:59PM +0100, Ruediger Meier wrote:

> > > Removing the first BLKRRPART ioctl (or sleeping about 50ms after
> > > the first one) "fixes" the issue.
> >
> > The is_device_used() in the sfdisk is nothing elegant,
>
> But how else could we check whether a device is in use?
>
> > maybe
> > we can use --noreread sfdisk command line option in the tests.
>
> I have such patch already for testing.

It's now on github pull request #244 among other patches
https://github.com/karelzak/util-linux/pull/244

Would be still nice to fix the problem within sfdisk somehow.

BTW I found that is_device_used() is not called for other generic 
options like --reorder. This seems inconsistent.

cu,
Rudi
