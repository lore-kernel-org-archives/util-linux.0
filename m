Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47265 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114Ab2KHJoq (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 8 Nov 2012 04:44:46 -0500
Date: Thu, 8 Nov 2012 10:44:42 +0100
From: Karel Zak <kzak@redhat.com>
To: Venkatraman S <venkat@linaro.org>
Cc: util-linux@vger.kernel.org, arnd.bergmann@linaro.org
Subject: Re: [RFC PATCH 0/4] Adding useful information into swap partition
 header
Message-ID: <20121108094442.GA2327@x2.net.home>
References: <1350925048-31084-1-git-send-email-venkat@linaro.org>
 <20121023121610.GI21724@x2.net.home>
 <CAFSEfh0A6JoKdhDyawc1=imRDZT7YFTUyDrVPaK-02CW1pGcRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFSEfh0A6JoKdhDyawc1=imRDZT7YFTUyDrVPaK-02CW1pGcRA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Oct 23, 2012 at 07:07:42PM +0530, Venkatraman S wrote:
> On 23 October 2012 17:46, Karel Zak <kzak@redhat.com> wrote:
> > On Mon, Oct 22, 2012 at 10:27:23PM +0530, Venkatraman S wrote:
> >> Venkatraman S (4):
> >>   libblkid/topology: add preferred_erase_size to topology probe
> >>   mkswap: refactor header preparation
> >>   mkswap: Add additional fields in swapheader
> >>   mkswap: Probe and embed useful block device info into swapheader
> >
> >  I don't see a problem to support additional information in the swap
> >  header, but our rule is pretty simple: first in Linus' tree, after
> >  that in userspace.
> >
> 
> Thanks Karl - that's understood. I posted the patches to better explain the
> issue I faced - this new parameter I introduced in topology.c is accessible
> only when I pass the root disk dev node to mkswap (as /dev/mmcblkX)
> and not when invoked with /dev/mmcblkXpY) (i.e a partition with the device).

 Well, the problem is that sysfs_{open,stat}() functions in
 lib/sysfs.c reads attributes from parent only for "queue/" directory
 attributes. It's trivial to fix this problem.

> So how should the topology probe be invoked in this case ?

 The question is if we really need to extend libblkid if the attribute
 is necessary only for mkswap.

 I think it would be better to read the sysfs attribute directly in
 mkswap (by lib/sysfs.c functions). The result will be one small patch
 for mkswap.

 Anyway, all this is trivial and maybe implemented very quickly --
 what we need is to have support in kernel.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
