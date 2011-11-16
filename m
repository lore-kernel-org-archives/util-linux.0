Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57819 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753154Ab1KPWyE (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Wed, 16 Nov 2011 17:54:04 -0500
Date: Wed, 16 Nov 2011 23:54:00 +0100
From: Karel Zak <kzak@redhat.com>
To: Jim Meyering <jim@meyering.net>
Cc: List util-linux-ng <util-linux-ng@vger.kernel.org>
Subject: Re: [PATCH] column: avoid memory overrun and/or use of
	uninitialized buffer
Message-ID: <20111116225400.GP7916@nb.net.home>
References: <87fwhn6fyo.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87fwhn6fyo.fsf@rho.meyering.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 16, 2011 at 08:10:39PM +0100, Jim Meyering wrote:
>  text-utils/column.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/text-utils/column.c b/text-utils/column.c
> index f8fd350..79d2842 100644
> --- a/text-utils/column.c
> +++ b/text-utils/column.c
> @@ -305,8 +305,8 @@ static void maketbl(wchar_t **list, int entries, wchar_t *separator)
>  				cols = xrealloc(cols, maxcols * sizeof(wchar_t *));
>  				lens = xrealloc(lens, maxcols * sizeof(ssize_t));
>  				/* zero fill only new memory */
> -				memset(lens + ((maxcols - DEFCOLS) * sizeof(ssize_t)), 0,
> -				       DEFCOLS * sizeof(int));
> +				memset(lens + (maxcols - DEFCOLS), 0,
> +				       DEFCOLS * sizeof(*lens));

 Ah, this is my bug... (in the original code was cast to char *).

 Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
