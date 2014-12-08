Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38739 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751969AbaLHLmr (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 8 Dec 2014 06:42:47 -0500
Date: Mon, 8 Dec 2014 12:42:31 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 03/10] more: fix unsigned integer overflow
 [AddressSanitizer]
Message-ID: <20141208114231.GE19904@x2.net.home>
References: <1417355862-16935-1-git-send-email-kerolasa@iki.fi>
 <1417355862-16935-4-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1417355862-16935-4-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Nov 30, 2014 at 01:57:35PM +0000, Sami Kerola wrote:
> text-utils/more.c:1137:20: runtime error: unsigned integer overflow: 0 -
> 1 cannot be represented in type 'size_t' (aka 'unsigned long')
> text-utils/more.c:1139:7: runtime error: unsigned integer overflow: 2 +
> 18446744073709551615 cannot be represented in type 'unsigned long'
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  text-utils/more.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/text-utils/more.c b/text-utils/more.c
> index a489953..4b03e0d 100644
> --- a/text-utils/more.c
> +++ b/text-utils/more.c
> @@ -1125,14 +1125,14 @@ void prbuf(register char *s, register int n)
>  #ifdef HAVE_WIDECHAR
>  			{
>  				wchar_t wc;
> -				size_t mblength;
> +				ssize_t mblength;
>  				mbstate_t mbstate;
>  				memset(&mbstate, '\0', sizeof(mbstate_t));
>  				s--;
>  				n++;
>  				mblength = mbrtowc(&wc, s, n, &mbstate);
> -				if (mblength == (size_t)-2
> -				    || mblength == (size_t)-1)
> +				if (mblength == -2
> +				    || mblength == -1)

Really? (size_t) -1 and (size_t) -2 are by libc API defined return
codes. It would be better to keep it in code.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
