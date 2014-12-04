Return-Path: util-linux-owner@vger.kernel.org
Received: from mail2.vodafone.ie ([213.233.128.44]:49495 "EHLO
	mail2.vodafone.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420AbaLDLvf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 4 Dec 2014 06:51:35 -0500
Message-ID: <54804AC4.3000009@draigBrady.com>
Date: Thu, 04 Dec 2014 11:51:32 +0000
From: =?windows-1252?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
Subject: Re: [PATCH 01/10] lib/mbalign: fix unsigned integer overflow [AddressSanitizer]
References: <1417355862-16935-1-git-send-email-kerolasa@iki.fi> <1417355862-16935-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1417355862-16935-2-git-send-email-kerolasa@iki.fi>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 30/11/14 13:57, Sami Kerola wrote:
> This error was reported 155 times.
> 
> lib/mbsalign.c:322:18: runtime error: unsigned integer overflow: 0 - 1
> cannot be represented in type 'size_t' (aka 'unsigned long')
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  lib/mbsalign.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/mbsalign.c b/lib/mbsalign.c
> index b307d19..052fec6 100644
> --- a/lib/mbsalign.c
> +++ b/lib/mbsalign.c
> @@ -319,7 +319,7 @@ mbs_align_pad (char *dest, const char* dest_end, size_t n_spaces)
>  {
>    /* FIXME: Should we pad with "figure space" (\u2007)
>       if non ascii data present?  */
> -  while (n_spaces-- && (dest < dest_end))
> +  for (/* nothing */; n_spaces && (dest < dest_end); n_spaces--)
>      *dest++ = ' ';
>    *dest = '\0';
>    return dest;

What compiler and version are you using for this?
I don't get the error with gcc 4.9.2 with -fsanitize=undefined
Note the error is incorrect I think as the variable is not read
after the overflow.

thanks,
Pádraig.
