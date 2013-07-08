Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:5466 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751464Ab3GHIX4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 8 Jul 2013 04:23:56 -0400
Date: Mon, 8 Jul 2013 10:23:46 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 21/34] mesg: assigned value is never read [clang-analyzer]
Message-ID: <20130708082346.GB11126@x2.net.home>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
 <1373226889-3451-22-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1373226889-3451-22-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jul 07, 2013 at 08:54:36PM +0100, Sami Kerola wrote:
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  term-utils/mesg.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/term-utils/mesg.c b/term-utils/mesg.c
> index 430236f..638a8c7 100644
> --- a/term-utils/mesg.c
> +++ b/term-utils/mesg.c
> @@ -115,7 +115,6 @@ int main(int argc, char *argv[])
>  			usage(stderr);
>  		}
>  
> -	argc -= optind;
>  	argv += optind;

 This is technically correct change, but I don't think it makes code
 more robust. The argv[] and argc are twins and it's bad coding style
 manner to divide the relation.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
