Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37986 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751825AbbHCJVS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 3 Aug 2015 05:21:18 -0400
Date: Mon, 3 Aug 2015 11:21:16 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/7] textual: adjust grammar and punctuation of some
 messages
Message-ID: <20150803092116.GE2619@ws.net.home>
References: <1438417391-2269-1-git-send-email-bensberg@justemail.net>
 <1438417659.181169.344954537.5780777A@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438417659.181169.344954537.5780777A@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Aug 01, 2015 at 10:27:39AM +0200, Benno Schulenberg wrote:
> 
> On Sat, Aug 1, 2015, at 10:23, Benno Schulenberg wrote:
> >  disk-utils/cfdisk.c     |    2 +-
> >  disk-utils/fdisk-menu.c |    2 +-
> >  disk-utils/fdisk.c      |    2 +-
> >  disk-utils/fsck.c       |    6 +++---
> >  disk-utils/sfdisk.c     |   28 ++++++++++++++--------------
> >  include/colors.h        |    6 +++---
> >  sys-utils/flock.c       |    2 +-
> >  sys-utils/lsipc.c       |   10 +++++-----
> >  8 files changed, 29 insertions(+), 29 deletions(-)
> 
> I can split this one up, if you wish.

That's fine.

> Patch 3 and 4 I've dropped; they should have been submitted
> for 2.26.

OK. Applied all 5 patches, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
