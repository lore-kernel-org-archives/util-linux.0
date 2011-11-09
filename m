Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:14746 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751422Ab1KIJZH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 9 Nov 2011 04:25:07 -0500
Date: Wed, 9 Nov 2011 10:24:32 +0100
From: Karel Zak <kzak@redhat.com>
To: Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] libmount: fix trivial typos in debugging output
Message-ID: <20111109092432.GJ16397@nb.net.home>
References: <1320829852-31250-1-git-send-email-petr.uzel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320829852-31250-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 09, 2011 at 10:10:52AM +0100, Petr Uzel wrote:
> Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
> ---
>  libmount/src/cache.c          |    2 +-
>  libmount/src/context.c        |    2 +-
>  libmount/src/context_mount.c  |    4 ++--
>  libmount/src/context_umount.c |    2 +-
>  libmount/src/optstr.c         |    2 +-
>  libmount/src/tab_update.c     |    2 +-
>  6 files changed, 7 insertions(+), 7 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
