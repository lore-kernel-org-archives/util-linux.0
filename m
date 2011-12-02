Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:1063 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757086Ab1LBR31 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 2 Dec 2011 12:29:27 -0500
Date: Fri, 2 Dec 2011 18:29:17 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] build-sys: check HAVE_ definitions with #ifdef
	[smatch scan]
Message-ID: <20111202172917.GB28962@nb.net.home>
References: <1322777421-11541-1-git-send-email-kerolasa@iki.fi> <1322777421-11541-2-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1322777421-11541-2-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Dec 01, 2011 at 11:10:21PM +0100, Sami Kerola wrote:
>  include/blkdev.h       |    2 +-
>  include/md5.h          |    2 +-
>  lib/env.c              |    2 +-
>  lib/ismounted.c        |    2 +-
>  libblkid/src/cache.c   |    2 +-
>  libblkid/src/devname.c |    8 ++++----
>  libblkid/src/devno.c   |   10 +++++-----
>  libblkid/src/llseek.c  |    6 +++---
>  libblkid/src/read.c    |    4 ++--
>  libblkid/src/resolve.c |    2 +-
>  libblkid/src/version.c |    2 +-
>  misc-utils/cal.c       |    2 +-
>  term-utils/script.c    |   10 +++++++---
>  13 files changed, 29 insertions(+), 25 deletions(-)

 Applied, thanks.

>> -#if HAVE_LIBUTIL && HAVE_PTY_H
> +#ifdef HAVE_LIBUTIL
> +# ifdef HAVE_PTY_H

here we can use:

    #if defined(HAVE_LIBUTIL) && defined(HAVE_PTY_H)


 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
