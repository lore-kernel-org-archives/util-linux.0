Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.17.13]:49576 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbaD0Up1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 27 Apr 2014 16:45:27 -0400
Message-ID: <535D6C65.50006@bernhard-voelker.de>
Date: Sun, 27 Apr 2014 22:45:25 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
Subject: Re: [PATCH 01/12] include/xalloc: ensure arithmetics overflow cannot
 happen
References: <1398629138-31718-1-git-send-email-kerolasa@iki.fi> <1398629138-31718-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1398629138-31718-2-git-send-email-kerolasa@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 04/27/2014 10:05 PM, Sami Kerola wrote:
> The xrealloc() changes has the greatest change.  It splits the size and
> multiplier arguments so that arithmetics overflow can be detected.  This
> change is propagated to use of the function in other files.
> 
> Additionally this change checks that size inputs for allocations are
> never zero.  It is uncertain if in these cases abort() should be called
> to get a core.

I'd favor to see the behavior of the allocation functions to be harmonized
with gnulib: quite a couple of us guys may work in projects using it, thus
being familiar with its details and corner cases.
WDYT?

> The xstrdup() is made to use memcpy(), which is exactly what the library
> call does so one layer of absraction is saved here.
...
>  static inline char __attribute__((warn_unused_result)) *xstrdup(const char *str)
>  {
> -        char *ret;
> -
> -        if (!str)
> -                return NULL;
> -
> -        ret = strdup(str);
> +	size_t len;
> +	char *ret;
>  
> -        if (!ret)
> -                err(XALLOC_EXIT_CODE, "cannot duplicate string");
> -        return ret;
> +	if (!str)
> +		return NULL;
> +	len = strlen(str) + 1;
> +	ret = xmalloc(len);
> +	memcpy(ret, str, len);
> +	return ret;
>  }

Hmm, while memcpy() alone is faster than strcpy(), replacing the
latter by strlen() + memcpy() certainly is not.  The compilers and
libc are optimized enough, e.g. by using had-crafted assembler code,
that I think you don't have a chance to be faster by trying to be
smarter than them.

Have a nice day,
Berny
