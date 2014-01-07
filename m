Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46888 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750938AbaAGKTs (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 7 Jan 2014 05:19:48 -0500
Date: Tue, 7 Jan 2014 11:19:35 +0100
From: Karel Zak <kzak@redhat.com>
To: Thomas =?iso-8859-1?Q?B=E4chler?= <thomas@archlinux.org>
Cc: util-linux@vger.kernel.org, Sami Kerola <kerolasa@iki.fi>
Subject: Re: [PATCH] uuidd: use pkg-config to find systemd-deamon support
Message-ID: <20140107101935.GA2658@x2.net.home>
References: <1389051548-1268-1-git-send-email-kerolasa@iki.fi>
 <20140107085831.GK31045@x2.net.home>
 <52CBCB08.1000702@archlinux.org>
 <20140107095408.GL31045@x2.net.home>
 <52CBCF17.50706@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <52CBCF17.50706@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jan 07, 2014 at 10:55:35AM +0100, Thomas Bächler wrote:
> >> We already have such a cyclic dependency, since udevd depends on
> >> libblkid+libuuid, and findmnt (from util-linux) depends on libudev.
> > 
> >  .. and nobody complains, good point :-) Thanks!
> > 
> >     Karel
> 
> Actually, now that I know you care about these things, I am complaining.

 :-)))

> It has caused me (minor) trouble once already.

 It's possible (first time) to compile util-linux without libudev,
 compile systemd/udevd and then again recompile util-linux with
 libudev.

 IMHO libudev is very useful for findmnt and lsblk to get info about
 devices.

 Note that uuidd is absolutely unnecessary if you don't have huge SAP
 installation (-- it means unnecessary for 99% of the all Linux users).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
