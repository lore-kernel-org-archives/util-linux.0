Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45332 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751725AbdF2K5F (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 29 Jun 2017 06:57:05 -0400
Date: Thu, 29 Jun 2017 12:57:01 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/3] officially drop Linux < 2.6
Message-ID: <20170629105701.uup4s4rev6qciimk@ws.net.home>
References: <1498702148-11755-1-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1498702148-11755-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 29, 2017 at 04:09:05AM +0200, Ruediger Meier wrote:
>  Documentation/deprecated.txt |  2 +-
>  disk-utils/mkfs.cramfs.8     |  2 +-
>  disk-utils/mkfs.cramfs.c     |  5 +--
>  include/pt-mbr-partnames.h   |  2 +-
>  include/pt-mbr.h             |  2 +-
>  lib/blkdev.c                 | 13 +------
>  sys-utils/eject.1            |  6 +--
>  sys-utils/mount.8            | 88 ++++++++------------------------------------
>  sys-utils/readprofile.8      |  6 +--
>  sys-utils/swapon.8           |  2 +-
>  sys-utils/umount.8           |  5 +--
>  11 files changed, 33 insertions(+), 100 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
