Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:31256 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752651AbaELMQ0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 12 May 2014 08:16:26 -0400
Date: Mon, 12 May 2014 14:10:11 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 12/12] setterm: convert remaining magic values to
 symbolic references
Message-ID: <20140512121011.GH8951@x2.net.home>
References: <1399836409-7769-1-git-send-email-kerolasa@iki.fi>
 <1399836409-7769-12-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1399836409-7769-12-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, May 11, 2014 at 08:26:49PM +0100, Sami Kerola wrote:
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  term-utils/setterm.c | 65 ++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 45 insertions(+), 20 deletions(-)
> 
> diff --git a/term-utils/setterm.c b/term-utils/setterm.c
> index 2de555e..5950d2a 100644
> --- a/term-utils/setterm.c
> +++ b/term-utils/setterm.c
> @@ -171,6 +171,31 @@ enum {
>  };
>  #endif
>  
> +/* Powersave modes */
> +enum {
> +	VESA_BLANK_MODE_OFF = 0,
> +	VESA_BLANK_MODE_SUSPENDV,
> +	VESA_BLANK_MODE_SUSPENDH,
> +	VESA_BLANK_MODE_POWERDOWN
> +};
> +
> +/* klogctl() actions */
> +enum {
> +	SYSLOG_ACTION_CONSOLE_OFF	= 6,
> +	SYSLOG_ACTION_CONSOLE_ON	= 7,
> +	SYSLOG_ACTION_CONSOLE_LEVEL	= 8
> +};

 OK.

> +/* Various numbers  */
> +enum {
> +	CONSOLE_LEVEL_MIN = 1,
> +	CONSOLE_LEVEL_MAX = 8,
> +	DEFAULT_TAB_LEN = 8,
> +	BLANK_MAX = 60,
> +	TABS_MAX = 160,
> +	BLENGTH_MAX = 2000,
> +};

 Please, use enum {} to group together things which have any relation,
 otherwise use #define.

 Fixed and merged.

 Applied all patches in the patchset, thanks.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
