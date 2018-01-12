Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35050 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933149AbeALMr1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 12 Jan 2018 07:47:27 -0500
Date: Fri, 12 Jan 2018 13:47:23 +0100
From: Karel Zak <kzak@redhat.com>
To: Peter Cordes <peter@cordes.ca>
Cc: halfdog <me@halfdog.net>, util-linux@vger.kernel.org
Subject: Re: util-linux mount/unmount ASLR bypass via environment variable
Message-ID: <20180112124723.mduisaaklkxcmddu@ws.net.home>
References: <820-1515696719.436169@jYEA.ctRK.4WZD>
 <20180112101559.rm2k4qbhi7kyufma@ws.net.home>
 <20180112115000.GF29852@cordes.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180112115000.GF29852@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jan 12, 2018 at 07:50:00AM -0400, Peter Cordes wrote:
> On Fri, Jan 12, 2018 at 11:15:59AM +0100, Karel Zak wrote:
> > Good point. Fixed, now for SUIDs it's without the addresses:
> >
> > $ LIBMOUNT_DEBUG=all mount
> > 18622: libmount:      CXT: ----> allocate [RESTRICTED]
> > 18622: libmount:      TAB: alloc
> > ...
> 
> Would it be useful to warn that addresses are being hidden?  People
> might not realize they're missing out on that when debugging.

OK.

# LIBMOUNT_DEBUG=all ./mount.static
14676: libmount: don't print memory addresses (SUID executable).
14676: libmount:     INIT: library debug mask: 0x100ffff
14676: libmount:     INIT: library version: 2.31.188
14676: libmount:     INIT:     feature: btrfs
14676: libmount:     INIT:     feature: assert



    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
