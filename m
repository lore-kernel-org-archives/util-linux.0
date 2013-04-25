Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60284 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754872Ab3DYHro (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 25 Apr 2013 03:47:44 -0400
Date: Thu, 25 Apr 2013 09:47:29 +0200
From: Karel Zak <kzak@redhat.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, util-linux@vger.kernel.org
Subject: Re: [PATCH] fix non-linux build (was: [ANNOUNCE] util-linux
 v2.23-rc2)
Message-ID: <20130425074729.GA2244@x2.net.home>
References: <20130410222248.GF26442@x2.net.home>
 <20130410224327.GK17173@type.leflore.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130410224327.GK17173@type.leflore.lan>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Apr 11, 2013 at 12:43:27AM +0200, Samuel Thibault wrote:
> diff --git a/configure.ac b/configure.ac
> index dd5d3e1..d9d6cb8 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -968,7 +968,7 @@ AM_CONDITIONAL(BUILD_BFS, test "x$build_bfs" = xyes)
>  
>  AC_ARG_ENABLE([fdformat],
>    AS_HELP_STRING([--disable-fdformat], [do not build fdformat]),
> -  [], enable_fdformat=yes
> +  [], enable_fdformat=check
>  )
>  UL_BUILD_INIT([fdformat])
>  UL_REQUIRES_LINUX([fdformat])

 Applied, thanks.


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
