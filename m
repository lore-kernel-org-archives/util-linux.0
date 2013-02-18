Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42281 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751180Ab3BRLXo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 18 Feb 2013 06:23:44 -0500
Date: Mon, 18 Feb 2013 12:23:41 +0100
From: Karel Zak <kzak@redhat.com>
To: "Zeeshan Ali (Khattak)" <zeeshanak@gnome.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libblkid: Make use of isalnum()
Message-ID: <20130218112341.GD11636@x2.net.home>
References: <1361065052-18695-1-git-send-email-zeeshanak@gnome.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1361065052-18695-1-git-send-email-zeeshanak@gnome.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 17, 2013 at 03:37:32AM +0200, Zeeshan Ali (Khattak) wrote:
> From: "Zeeshan Ali (Khattak)" <zeeshanak@gnome.org>
> 
> ---
>  libblkid/src/encode.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/libblkid/src/encode.c b/libblkid/src/encode.c
> index ff57be4..e96e0e2 100644
> --- a/libblkid/src/encode.c
> +++ b/libblkid/src/encode.c
> @@ -181,9 +181,7 @@ static int replace_whitespace(const char *str, char *to, size_t len)
>  
>  static int is_whitelisted(char c, const char *white)
>  {
> -	if ((c >= '0' && c <= '9') ||
> -	    (c >= 'A' && c <= 'Z') ||
> -	    (c >= 'a' && c <= 'z') ||
> +	if (isalnum (c) ||

 It seems like locale sensitive function ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
