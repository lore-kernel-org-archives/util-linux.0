Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcaib.dreamhost.com ([208.97.132.81]:49590 "EHLO
	homiemail-a38.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751515Ab1LTONm (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 20 Dec 2011 09:13:42 -0500
Subject: Re: [PATCH 1/3] column: use xalloc libs
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Dave Reisner <d@falconindy.com>
Cc: util-linux@vger.kernel.org, Dave Reisner <dreisner@archlinux.org>
In-Reply-To: <1324388164-2112-1-git-send-email-dreisner@archlinux.org>
References: <1324388164-2112-1-git-send-email-dreisner@archlinux.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 20 Dec 2011 15:13:36 +0100
Message-ID: <1324390416.3316.13.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, 2011-12-20 at 08:36 -0500, Dave Reisner wrote:
> Signed-off-by: Dave Reisner <dreisner@archlinux.org>
> ---
>  text-utils/column.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/text-utils/column.c b/text-utils/column.c
> index 79d2842..c642680 100644
> --- a/text-utils/column.c
> +++ b/text-utils/column.c
> @@ -395,7 +395,7 @@ static wchar_t *mbs_to_wcs(const char *s)
>  	n = mbstowcs((wchar_t *)0, s, 0);
>  	if (n < 0)
>  		return NULL;
> -	wcs = malloc((n + 1) * sizeof(wchar_t));
> +	wcs = xmalloc((n + 1) * sizeof(wchar_t));
>  	if (!wcs)
>  		return NULL;

Hmm this isn't that straight forward, if the memory allocation fails
here we don't necessarily abort the program.

>  	n = mbstowcs(wcs, s, n + 1);


