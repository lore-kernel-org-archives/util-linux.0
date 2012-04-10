Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:26805 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750885Ab2DJLXn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 10 Apr 2012 07:23:43 -0400
Date: Tue, 10 Apr 2012 13:23:39 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/3] lib: random utilities
Message-ID: <20120410112339.GL19784@x2.net.home>
References: <1333662724.2696.4.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333662724.2696.4.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Apr 05, 2012 at 11:52:04PM +0200, Davidlohr Bueso wrote:
>  include/randutils.h |   19 +++++++++
>  lib/Makefile.am     |    2 +
>  lib/randutils.c     |  104 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 125 insertions(+), 0 deletions(-)
>  create mode 100644 include/randutils.h
>  create mode 100644 lib/randutils.c

 Applied with some changes, thanks.

> +++ b/include/randutils.h
> +#if defined(__linux__) && defined(__NR_gettid) && defined(HAVE_JRAND48)
> +#define DO_JRAND_MIX
> +static unsigned short jrand_seed[3];
> +#endif

 - add static buffer to header file does not make sense

 - TLS (thread local storage) is necessary there if you want to use
   the code in a shared library (libuuid).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
