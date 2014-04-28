Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:2378 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752466AbaD1Gwz (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 28 Apr 2014 02:52:55 -0400
Date: Mon, 28 Apr 2014 08:52:43 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 01/12] include/xalloc: ensure arithmetics overflow cannot
 happen
Message-ID: <20140428065243.GJ2405@x2.net.home>
References: <1398629138-31718-1-git-send-email-kerolasa@iki.fi>
 <1398629138-31718-2-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1398629138-31718-2-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Apr 27, 2014 at 09:05:27PM +0100, Sami Kerola wrote:
> The xrealloc() changes has the greatest change.  It splits the size and
> multiplier arguments so that arithmetics overflow can be detected.  This
> change is propagated to use of the function in other files.

 I don't like it at all. The function realloc() has well know semantic
 and arguments. We don't want to create parallel universe...
 
 If you want something else "nmemb, size"  then introduce xrecalloc()
 or so.. but don't use "realloc" name at all.

> Additionally this change checks that size inputs for allocations are
> never zero.  It is uncertain if in these cases abort() should be called
> to get a core.

 I don't think we need a different semantic than C standards.

>  void *xmalloc(const size_t size)
>  {
> -        void *ret = malloc(size);
> +	void *ret;
>  
> -        if (!ret && size)
> -                err(XALLOC_EXIT_CODE, "cannot allocate %zu bytes", size);
> -        return ret;
> +	if (size == 0)
> +		err(XALLOC_EXIT_CODE, "xmalloc: zero size");

 man malloc, zero size is just correct

> +	ret = malloc(size);
> +	if (!ret)
> +		err(XALLOC_EXIT_CODE, "xmalloc: cannot allocate %zu bytes", size);
> +	return ret;
>  }

 I don't think we need "xmalloc:" prefix to the error message.

>  static inline __ul_alloc_size(2)
> -void *xrealloc(void *ptr, const size_t size)
> +void *xrealloc(void *ptr, const size_t nmemb, const size_t size)
>  {
> -        void *ret = realloc(ptr, size);
> -
> -        if (!ret && size)
> -                err(XALLOC_EXIT_CODE, "cannot allocate %zu bytes", size);
> -        return ret;
> +	void *ret;
> +	size_t new_size = nmemb * size;
> +
> +	if (new_size == 0)
> +		err(XALLOC_EXIT_CODE, "xrealloc: zero size");

 man realloc, zero size is correct

> +	if (SIZE_MAX / nmemb < size)
> +		err(XALLOC_EXIT_CODE, "xrealloc: nmemb * size > SIZE_MAX");
> +	if (ptr == NULL)
> +		ret = malloc(new_size);
> +	else
> +		ret = realloc(ptr, new_size);
> +	if (!ret)
> +		err(XALLOC_EXIT_CODE, "xrealloc: cannot allocate %zu bytes", size);
> +	return ret;
>  }
>  
>  static inline __ul_calloc_size(1, 2)
>  void *xcalloc(const size_t nelems, const size_t size)
>  {
> -        void *ret = calloc(nelems, size);
> -
> -        if (!ret && size && nelems)
> -                err(XALLOC_EXIT_CODE, "cannot allocate %zu bytes", size);
> -        return ret;
> +	void *ret;
> +
> +	if (nelems == 0 || size == 0)
> +		err(XALLOC_EXIT_CODE, "xcalloc: zero size");

 zero size is correct

> +	if (SIZE_MAX / nelems < size)
> +		err(XALLOC_EXIT_CODE, "xcalloc: nmemb * size > SIZE_MAX");
> +	ret = calloc(nelems, size);
> +	if (!ret)
> +		err(XALLOC_EXIT_CODE, "xcalloc: cannot allocate %zu bytes", nelems * size);
> +	return ret;
>  }
>  
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

 Seem like premature optimization, it would be better to use libc
 rather than maintain private implementation.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
