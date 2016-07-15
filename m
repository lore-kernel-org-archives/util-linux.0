Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41341 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932483AbcGOLQ2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 15 Jul 2016 07:16:28 -0400
Date: Fri, 15 Jul 2016 13:16:26 +0200
From: Karel Zak <kzak@redhat.com>
To: Tobias Stoeckmann <tobias@stoeckmann.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Fix previously adjusted segfault patch
Message-ID: <20160715111626.levjhzetw7cvldri@ws.net.home>
References: <20160710141407.GA26802@localhost>
 <20160714101215.ckr3tl22fmpcumwa@ws.net.home>
 <20160714192834.GA3861@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20160714192834.GA3861@localhost>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jul 14, 2016 at 09:28:34PM +0200, Tobias Stoeckmann wrote:
> Casting the value to be checked to size_t renders the check useless.
> If st_size is SIZE_MAX+1, it will be truncated to 0 and the check
> succeeds. In fact, this check can never be false because every value
> stored in a size_t is smaller or equal to SIZE_MAX.
> 
> I think this adjustment was meant to fix a compiler warning for 64 bit

yes

> systems for which sizeof(off_t) is sizeof(size_t), but the signedness
> differs. One possibility is to do a "binary and" operation with the
> value SIZE_MAX. If the original value and the and-operated value differ,
> it means that a higher bit was set and therefore the file was too large.
> 
> Signed-off-by: Tobias Stoeckmann <tobias@stoeckmann.org>
> ---
>  text-utils/tailf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/text-utils/tailf.c b/text-utils/tailf.c
> index 6219aa2..5ddbee9 100644
> --- a/text-utils/tailf.c
> +++ b/text-utils/tailf.c
> @@ -284,7 +284,7 @@ int main(int argc, char **argv)
>  		errx(EXIT_FAILURE, _("%s: is not a file"), filename);
>  
>  	/* mmap is based on size_t */
> -	if (st.st_size && (size_t) st.st_size <= SIZE_MAX)
> +	if (st.st_size && st.st_size == (st.st_size & SIZE_MAX))

but compiler still don't like it, because "& SIZE_MAX" result is
unsigned number.

text-utils/tailf.c: In function ‘main’:
text-utils/tailf.c:287:31: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]

I guess you need to cast:

    if (st.st_size > 0 && st.st_size == (off_t) (st.st_size & SIZE_MAX))


Maybe it would be nice to have a macros for this purpose in include/c.h,
something like:

#define is_between(x, mi, ma)  (x >= mi && x == (__typeof__(x)) (x & ma))

#define is_sizet_convertible(x)     is_between(x, 0, SIZE_MAX)
#define is_uint32_convertible(x)    is_between(x, 0, UINT32_MAX)
...

    if (st.st_size && is_sizet_convertible(st.st_size))
        tailf(filename, lines, &st);


Correct? or maybe I need a coffee? ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
