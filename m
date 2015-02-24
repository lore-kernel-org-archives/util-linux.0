Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39030 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751613AbbBXNBr (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Feb 2015 08:01:47 -0500
Date: Tue, 24 Feb 2015 14:01:37 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 10/13] bash-completion: add freeze mode to rtcwake
Message-ID: <20150224130137.GS19430@ws.net.home>
References: <1424616139-638-1-git-send-email-kerolasa@iki.fi>
 <1424616139-638-11-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424616139-638-11-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 22, 2015 at 02:42:16PM +0000, Sami Kerola wrote:
> Missed when commit ece44f19f423408f576f348fed2845c876d72c6e added support
> to freeze.
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  bash-completion/rtcwake | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/bash-completion/rtcwake b/bash-completion/rtcwake
> index 51566a2..70ae743 100644
> --- a/bash-completion/rtcwake
> +++ b/bash-completion/rtcwake
> @@ -12,7 +12,7 @@ _rtcwake_module()
>  			return 0
>  			;;
>  		'-m'|'--mode')
> -			COMPREPLY=( $(compgen -W "standby mem disk off no on disable show" -- $cur) )
> +			COMPREPLY=( $(compgen -W "standby freeze mem disk off no on disable show" -- $cur) )

 would be possible to ask rtcwake(8) for all supported modes rather
 than hard code it to the bash-completion script?

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
