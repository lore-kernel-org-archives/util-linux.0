Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46442 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750812AbbHaJdI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 31 Aug 2015 05:33:08 -0400
Date: Mon, 31 Aug 2015 11:33:06 +0200
From: Karel Zak <kzak@redhat.com>
To: Chen Qi <Qi.Chen@windriver.com>
Cc: util-linux@vger.kernel.org
Subject: Re: include errno.h instead of argp.h
Message-ID: <20150831093306.GD2726@ws.net.home>
References: <1441009426-13799-1-git-send-email-Qi.Chen@windriver.com>
 <1441009426-13799-2-git-send-email-Qi.Chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1441009426-13799-2-git-send-email-Qi.Chen@windriver.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 31, 2015 at 04:23:45PM +0800, Chen Qi wrote:
> Index: util-linux-2.22.1/configure.ac

We're just working on v2.27 :-)

> ===================================================================
> --- util-linux-2.22.1.orig/configure.ac
> +++ util-linux-2.22.1/configure.ac
> @@ -372,7 +372,7 @@ esac
>  
>  AC_MSG_CHECKING([whether program_invocation_short_name is defined])
>  AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
> -	#include <argp.h>
> +	#include <errno.h>

anyway, you're probably right.

It seems that our original AC_COMPILE_IFELSE() is copy & past from gnulib, but 
gnulib checks for errno.h and then it uses the result by #ifdefs in the private
copy of the argp.h. The original author probably miss this detail.

Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
