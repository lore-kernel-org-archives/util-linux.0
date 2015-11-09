Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42424 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752272AbbKIJBU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 9 Nov 2015 04:01:20 -0500
Date: Mon, 9 Nov 2015 10:01:18 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 04/12] agetty: fix chown(3), chmod(3) and open(3) race
Message-ID: <20151109090118.GS19508@ws.net.home>
References: <1446319284-24778-1-git-send-email-kerolasa@iki.fi>
 <1446319284-24778-5-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1446319284-24778-5-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Oct 31, 2015 at 07:21:16PM +0000, Sami Kerola wrote:
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  term-utils/agetty.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/term-utils/agetty.c b/term-utils/agetty.c
> index 0237b79..a9c8785 100644
> --- a/term-utils/agetty.c
> +++ b/term-utils/agetty.c
> @@ -1004,23 +1004,23 @@ static void open_tty(char *tty, struct termios *tp, struct options *op)
>  		     (int)sizeof(buf)) || (len < 0))
>  			log_err(_("/dev/%s: cannot open as standard input: %m"), tty);
>  
> +		/* Open the tty as standard input. */
> +		if ((fd = open(buf, O_RDWR|O_NOCTTY|O_NONBLOCK, 0)) < 0)
> +			log_err(_("/dev/%s: cannot open as standard input: %m"), tty);
> +
>  		/*
>  		 * There is always a race between this reset and the call to
>  		 * vhangup() that s.o. can use to get access to your tty.
>  		 * Linux login(1) will change tty permissions. Use root owner and group
>  		 * with permission -rw------- for the period between getty and login.
>  		 */
> -		if (chown(buf, 0, gid) || chmod(buf, (gid ? 0620 : 0600))) {
> +		if (fchown(fd, 0, gid) || fchmod(fd, (gid ? 0620 : 0600))) {

Note that this is only a cosmetic change, because we re-open() the tty
later (and it's not dangerous due to vhangup & friends in login(1)).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
