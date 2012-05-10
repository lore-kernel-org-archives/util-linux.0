Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:10919 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758344Ab2EJJzD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 10 May 2012 05:55:03 -0400
Date: Thu, 10 May 2012 11:54:38 +0200
From: Karel Zak <kzak@redhat.com>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] libuuid: avoid double open and leaking fd (reworked)
Message-ID: <20120510095438.GD30118@x2.net.home>
References: <1336334153-32532-1-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336334153-32532-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, May 06, 2012 at 09:55:53PM +0200, Petr Uzel wrote:
> This is better than calling random_get_fd() twice, passing the file
> descriptor down the stack and reusing it in next call to
> random_get_fd().

 Yep, nice :-)

>  fdisk/fdiskdoslabel.c  |    2 +-
>  include/randutils.h    |    2 +-
>  lib/randutils.c        |    8 +++-----
>  libuuid/src/gen_uuid.c |   28 ++++++++++++++++++----------
>  libuuid/src/uuidd.h    |    2 +-
>  misc-utils/uuidd.c     |    4 ++--
>  6 files changed, 26 insertions(+), 20 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
