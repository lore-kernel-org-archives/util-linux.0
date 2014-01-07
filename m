Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:25534 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750849AbaAGJyV (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 7 Jan 2014 04:54:21 -0500
Date: Tue, 7 Jan 2014 10:54:08 +0100
From: Karel Zak <kzak@redhat.com>
To: Thomas =?iso-8859-1?Q?B=E4chler?= <thomas@archlinux.org>
Cc: util-linux@vger.kernel.org, Sami Kerola <kerolasa@iki.fi>
Subject: Re: [PATCH] uuidd: use pkg-config to find systemd-deamon support
Message-ID: <20140107095408.GL31045@x2.net.home>
References: <1389051548-1268-1-git-send-email-kerolasa@iki.fi>
 <20140107085831.GK31045@x2.net.home>
 <52CBCB08.1000702@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <52CBCB08.1000702@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jan 07, 2014 at 10:38:16AM +0100, Thomas Bächler wrote:
> Am 07.01.2014 09:58, schrieb Karel Zak:
> > On Mon, Jan 06, 2014 at 11:39:08PM +0000, Sami Kerola wrote:
> >>  configure.ac             |   3 +
> >>  misc-utils/Makemodule.am |   3 +-
> >>  misc-utils/sd-daemon.c   | 520 -----------------------------------------------
> >>  misc-utils/sd-daemon.h   | 282 -------------------------
> >>  misc-utils/uuidd.c       |   2 +-
> > 
> >  Seems like a good idea, unfortunately I'm not sure about it. 
> >  
> >  The systemd (udevd) depends on libblkid+libuuid, it would be 
> >  probably better to keep util-linux without dependencies on systemd
> >  libs otherwise we will introduce a cyclic dependence -- it could be
> >  too tricky for some build systems and users :-) I'll think about it...
> > 
> >     Karel
> 
> We already have such a cyclic dependency, since udevd depends on
> libblkid+libuuid, and findmnt (from util-linux) depends on libudev.

 .. and nobody complains, good point :-) Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
