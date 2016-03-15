Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33107 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751537AbcCONOl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 Mar 2016 09:14:41 -0400
Date: Tue, 15 Mar 2016 14:14:37 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] vipw: print only one new line when asking about shadow
 file
Message-ID: <20160315131437.4z4ncdtm4qvksqdu@ws.net.home>
References: <1457991510-12122-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1457991510-12122-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 14, 2016 at 09:38:30PM +0000, Sami Kerola wrote:
> diff --git a/login-utils/vipw.c b/login-utils/vipw.c
> index b8e5b47..0438656 100644
> --- a/login-utils/vipw.c
> +++ b/login-utils/vipw.c
> @@ -343,9 +343,9 @@ int main(int argc, char *argv[])
>  	if (access(orig_file, F_OK) == 0) {
>  		char response[80];
>  
> -		puts((program == VIGR)
> +		fputs((program == VIGR)


 Oops:-) Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
