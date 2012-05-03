Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39575 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752970Ab2ECGjX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 3 May 2012 02:39:23 -0400
Date: Thu, 3 May 2012 08:39:19 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] wdctl: align with other util-linux commands
Message-ID: <20120503063919.GC16016@x2.net.home>
References: <1334862654-32253-1-git-send-email-kerolasa@iki.fi>
 <CAG27Bk3B3J456tO8s+vk0mGvAVns_nVkHVH8KdAeb7nvkkc7ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAG27Bk3B3J456tO8s+vk0mGvAVns_nVkHVH8KdAeb7nvkkc7ng@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, May 02, 2012 at 07:37:55PM +0200, Sami Kerola wrote:
> On Thu, Apr 19, 2012 at 9:10 PM, Sami Kerola <kerolasa@iki.fi> wrote:
> > * Add watchdog device path to pathnames.h
> > * Check output stream status at exit.
> > * Adjust usage() notation to follow howto file.
> > * Retire numeric return value.
> >
> >  include/pathnames.h |    2 ++
> >  sys-utils/wdctl.c   |   10 +++++++---
> >  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> Hi Karel,
> 
> It's been while since I sent this to review. Perhaps it is soon time
> to accept or reject the patch.

 Good timing, I'm just working on the code ;-)

 Sorry for the delay, your changes seems correct, but I'd like to a
 little rewrite the original Lennart's code to to make it more
 compatible with our new utils (like lsblk, lslocks, ...).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
