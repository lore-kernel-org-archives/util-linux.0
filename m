Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35615 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751015Ab2IKItM (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 11 Sep 2012 04:49:12 -0400
Date: Tue, 11 Sep 2012 10:49:08 +0200
From: Karel Zak <kzak@redhat.com>
To: Ludwig Nussel <ludwig.nussel@suse.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] remove obsolete encryption support from losetup
Message-ID: <20120911084908.GA30228@x2.net.home>
References: <1339747456-30761-1-git-send-email-ludwig.nussel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1339747456-30761-1-git-send-email-ludwig.nussel@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jun 15, 2012 at 10:04:16AM +0200, Ludwig Nussel wrote:
>  include/loopdev.h              |    3 --
>  lib/loopdev.c                  |   56 ----------------------------------------
>  libmount/src/context_loopdev.c |   22 +++-------------
>  mount/mount.8                  |    9 +-----
>  mount/mount.c                  |   26 +++---------------
>  sys-utils/losetup.8            |   29 +-------------------
>  sys-utils/losetup.c            |   37 ++++++--------------------
>  sys-utils/mount.c              |   42 +----------------------------
>  8 files changed, 23 insertions(+), 201 deletions(-)

 Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
