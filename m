Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:21343 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932443Ab1KIJHR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 9 Nov 2011 04:07:17 -0500
Date: Wed, 9 Nov 2011 10:07:14 +0100
From: Karel Zak <kzak@redhat.com>
To: Francesco Cosoleto <cosoleto@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] whereis: silence comparison between signed/unsigned
	warning
Message-ID: <20111109090714.GH16397@nb.net.home>
References: <1320790495-29290-1-git-send-email-cosoleto@gmail.com> <1320790495-29290-4-git-send-email-cosoleto@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320790495-29290-4-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 All your patches applied, except this one.

On Tue, Nov 08, 2011 at 11:14:55PM +0100, Francesco Cosoleto wrote:

> Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
> ---
>  misc-utils/whereis.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/misc-utils/whereis.c b/misc-utils/whereis.c
> index 03ea95e..d776b32 100644
> --- a/misc-utils/whereis.c
> +++ b/misc-utils/whereis.c
> @@ -241,7 +241,7 @@ findin(char *dir, char *cp)
>  
>  static int inpath(const char *str)
>  {
> -	int i;
> +	size_t i;

 It seems that your git tree is not up to date, this problem has been
 already fixed:

 $ git blame -L244,+1 misc-utils/whereis.c
 cc69f339 (Karel Zak 2011-08-31 11:58:01 +0200 244)      size_t i;

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
