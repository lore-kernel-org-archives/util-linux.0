Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43374 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752641AbbFYKKg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 25 Jun 2015 06:10:36 -0400
Date: Thu, 25 Jun 2015 12:10:34 +0200
From: Karel Zak <kzak@redhat.com>
To: Boris Egorov <egorov@linux.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/3] cppcheck warnings fixes
Message-ID: <20150625101034.GR1992@ws.net.home>
References: <1434742861-11704-1-git-send-email-egorov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1434742861-11704-1-git-send-email-egorov@linux.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jun 20, 2015 at 01:40:58AM +0600, Boris Egorov wrote:
>  disk-utils/cfdisk.c      |  2 +-
>  disk-utils/fsck.cramfs.c |  6 +++---
>  disk-utils/mkfs.bfs.c    |  6 +++---
>  lib/cpuset.c             |  6 +++---
>  libblkid/src/tag.c       |  2 +-
>  misc-utils/whereis.c     |  2 +-
>  sys-utils/chcpu.c        | 38 +++++++++++++++++++-------------------
>  sys-utils/hwclock-rtc.c  |  2 +-
>  sys-utils/ipcs.c         |  4 ++--
>  sys-utils/readprofile.c  | 12 ++++++------
>  10 files changed, 40 insertions(+), 40 deletions(-)

Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
