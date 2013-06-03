Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:4225 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753913Ab3FCI4h (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 3 Jun 2013 04:56:37 -0400
Date: Mon, 3 Jun 2013 10:56:06 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 17/19] dmesg: make usage() a little bit shorter
Message-ID: <20130603085606.GJ30341@x2.net.home>
References: <1370195485-27907-1-git-send-email-kerolasa@iki.fi>
 <1370195485-27907-18-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1370195485-27907-18-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jun 02, 2013 at 06:51:23PM +0100, Sami Kerola wrote:
> The dmesg has rather long usage, so drop the timestamp format options
> which are aliases of the more generic options.  Old options will remain
> working as earlier.
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  sys-utils/dmesg.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
> index adfd6a5..d80b3e9 100644
> --- a/sys-utils/dmesg.c
> +++ b/sys-utils/dmesg.c
> @@ -234,8 +234,6 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
>  	fputs(_(" -C, --clear                 clear the kernel ring buffer\n"), out);
>  	fputs(_(" -c, --read-clear            read and clear all messages\n"), out);
>  	fputs(_(" -D, --console-off           disable printing messages to console\n"), out);
> -	fputs(_(" -d, --show-delta            show time delta between printed messages\n"), out);
> -	fputs(_(" -e, --reltime               show local time and time delta in readable format\n"), out);

 I'd like to keep the aliases in the usage() output. IMHO it's fine to use

    fputs(_(" -e, --reltime               alias to --time-format reltime");

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
