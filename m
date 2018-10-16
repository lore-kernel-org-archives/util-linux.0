Return-Path: <SRS0=SH8e=M4=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEA1C04EBD
	for <util-linux@archiver.kernel.org>; Tue, 16 Oct 2018 07:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE3720866
	for <util-linux@archiver.kernel.org>; Tue, 16 Oct 2018 07:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE3720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbeJPPaE (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 16 Oct 2018 11:30:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39182 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbeJPPaE (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 16 Oct 2018 11:30:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A8BC43084259;
        Tue, 16 Oct 2018 07:40:56 +0000 (UTC)
Received: from ws.net.home (ovpn-116-198.ams2.redhat.com [10.36.116.198])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A91405D9CA;
        Tue, 16 Oct 2018 07:40:55 +0000 (UTC)
Date:   Tue, 16 Oct 2018 09:40:53 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     util-linux@vger.kernel.org, Stanislav Brabec <sbrabec@suse.cz>
Subject: Re: [PATCH v2] agetty: don't put the VC into canonical mode
Message-ID: <20181016074053.dea6ydle26y37uva@ws.net.home>
References: <20181016064149.2698-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016064149.2698-1-lkundrak@v3.sk>
User-Agent: NeoMutt/20180716-423-e60b71
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 16 Oct 2018 07:40:56 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Oct 16, 2018 at 08:41:49AM +0200, Lubomir Rintel wrote:
> The wait_for_term_input()'s select() needs to be tripped when the user
> starts typing. Otherwise the reloads can abort an already in-progress login.
> 
> Coupled with \4 and \6 expansions that happen to be there on Fedora Server,
> this means reload on every netlink event. With a couple of IPv6 routers
> announcing their networks and temporary addresses in use can make it
> sometimes virtually impossible to log in.

It's too late for v2.33. It also seems we need to wait for Stanislav's
work on this issue -- his idea is to complete disable the reload
notification when user start typing, and it also requires to switch
to non-canonical mode.

This is definitely something we need to fix in v2.34 and v2.33.1.

> Seems like zero lflags do the job just fine on a Linux VT. Reset it to
> canonical mode before running login.

What about Del/Backspace keys when user is typing login name? :-)

    Karel

> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> ---
> Changes since v1:
> - Unreversed the logic in termio_final()/reset_vc() conditional
> 
> Tested on a vc and serial console on a stock Fedora installation:
> 
>   /sbin/agetty -o -p -- \u --noclear tty1 linux
>   /sbin/agetty -o -p -- \u --keep-baud 115200,38400,9600 ttyS2 vt220
> 
>  term-utils/agetty.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/term-utils/agetty.c b/term-utils/agetty.c
> index 3c87ec64e..3834813f1 100644
> --- a/term-utils/agetty.c
> +++ b/term-utils/agetty.c
> @@ -303,7 +303,7 @@ static void parse_speeds(struct options *op, char *arg);
>  static void update_utmp(struct options *op);
>  static void open_tty(char *tty, struct termios *tp, struct options *op);
>  static void termio_init(struct options *op, struct termios *tp);
> -static void reset_vc (const struct options *op, struct termios *tp);
> +static void reset_vc(const struct options *op, struct termios *tp, int canon);
>  static void auto_baud(struct termios *tp);
>  static void list_speeds(void);
>  static void output_special_char (unsigned char c, struct options *op,
> @@ -485,13 +485,14 @@ int main(int argc, char **argv)
>  	if (options.timeout)
>  		alarm(0);
>  
> -	if ((options.flags & F_VCONSOLE) == 0) {
> -		/* Finalize the termios settings. */
> +	/* Finalize the termios settings. */
> +	if ((options.flags & F_VCONSOLE) == 0)
>  		termio_final(&options, &termios, &chardata);
> +	else
> +		reset_vc(&options, &termios, 1);
>  
> -		/* Now the newline character should be properly written. */
> -		write_all(STDOUT_FILENO, "\r\n", 2);
> -	}
> +	/* Now the newline character should be properly written. */
> +	write_all(STDOUT_FILENO, "\r\n", 2);
>  
>  	sigaction(SIGQUIT, &sa_quit, NULL);
>  	sigaction(SIGINT, &sa_int, NULL);
> @@ -1234,7 +1235,7 @@ static void termio_init(struct options *op, struct termios *tp)
>  		setlocale(LC_CTYPE, "POSIX");
>  		op->flags &= ~F_UTF8;
>  #endif
> -		reset_vc(op, tp);
> +		reset_vc(op, tp, 0);
>  
>  		if ((tp->c_cflag & (CS8|PARODD|PARENB)) == CS8)
>  			op->flags |= F_EIGHTBITS;
> @@ -1344,7 +1345,7 @@ static void termio_init(struct options *op, struct termios *tp)
>  }
>  
>  /* Reset virtual console on stdin to its defaults */
> -static void reset_vc(const struct options *op, struct termios *tp)
> +static void reset_vc(const struct options *op, struct termios *tp, int canon)
>  {
>  	int fl = 0;
>  
> @@ -1353,6 +1354,15 @@ static void reset_vc(const struct options *op, struct termios *tp)
>  
>  	reset_virtual_console(tp, fl);
>  
> +#ifdef AGETTY_RELOAD
> +	/*
> +	 * Discard all the flags that makes the line go canonical with echoing.
> +	 * We need to know when the user starts typing.
> +	 */
> +	if (canon == 0)
> +		tp->c_lflag = 0;
> +#endif
> +
>  	if (tcsetattr(STDIN_FILENO, TCSADRAIN, tp))
>  		log_warn(_("setting terminal attributes failed: %m"));
>  
> -- 
> 2.19.1
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
