Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52886 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751719AbdFNKJF (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 14 Jun 2017 06:09:05 -0400
Date: Wed, 14 Jun 2017 12:09:00 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/4] last: fix format overflow
Message-ID: <20170614100900.nt2v47n65qfadkhl@ws.net.home>
References: <20170527182409.13985-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170527182409.13985-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, May 27, 2017 at 07:24:06PM +0100, Sami Kerola wrote:
> login-utils/last.c:624:23: warning: '%s' directive writing up to 31 bytes
> into a region of size 27 [-Wformat-overflow=]
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  login-utils/last.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/login-utils/last.c b/login-utils/last.c
> index 679ea6c12..153130ac0 100644
> --- a/login-utils/last.c
> +++ b/login-utils/last.c
> @@ -598,7 +598,7 @@ static void __attribute__((__noreturn__)) usage(const struct last_control *ctl,
>  static int is_phantom(const struct last_control *ctl, struct utmpx *ut)
>  {
>  	struct passwd *pw;
> -	char path[32];
> +	char path[sizeof("/dev/") + sizeof(ut->ut_line) + 1];

 I have applied patches from Rudi with NAME_MAX.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
