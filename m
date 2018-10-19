Return-Path: <SRS0=K1B8=M7=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA26DECDE43
	for <util-linux@archiver.kernel.org>; Fri, 19 Oct 2018 06:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76AF62086E
	for <util-linux@archiver.kernel.org>; Fri, 19 Oct 2018 06:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76AF62086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbeJSOOK (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 19 Oct 2018 10:14:10 -0400
Received: from shell.v3.sk ([90.176.6.54]:37533 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbeJSOOJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 19 Oct 2018 10:14:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 8490EBDCFE;
        Fri, 19 Oct 2018 08:09:30 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id SYP245ZnSYcs; Fri, 19 Oct 2018 08:09:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id E3BA7BDD02;
        Fri, 19 Oct 2018 08:09:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lVwaagzOt0q9; Fri, 19 Oct 2018 08:09:26 +0200 (CEST)
Received: from odvarok.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 2E6F0BDCFE;
        Fri, 19 Oct 2018 08:09:26 +0200 (CEST)
Message-ID: <52ebddaca50ed8d5f498bdf56b02ae4640af369a.camel@v3.sk>
Subject: Re: [PATCH v2] agetty: don't put the VC into canonical mode
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, Stanislav Brabec <sbrabec@suse.cz>
Date:   Fri, 19 Oct 2018 08:09:24 +0200
In-Reply-To: <20181016074053.dea6ydle26y37uva@ws.net.home>
References: <20181016064149.2698-1-lkundrak@v3.sk>
         <20181016074053.dea6ydle26y37uva@ws.net.home>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 (3.30.1-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, 2018-10-16 at 09:40 +0200, Karel Zak wrote:
> On Tue, Oct 16, 2018 at 08:41:49AM +0200, Lubomir Rintel wrote:
> > The wait_for_term_input()'s select() needs to be tripped when the
> > user
> > starts typing. Otherwise the reloads can abort an already in-
> > progress login.
> > 
> > Coupled with \4 and \6 expansions that happen to be there on Fedora
> > Server,
> > this means reload on every netlink event. With a couple of IPv6
> > routers
> > announcing their networks and temporary addresses in use can make
> > it
> > sometimes virtually impossible to log in.
> 
> It's too late for v2.33. It also seems we need to wait for
> Stanislav's
> work on this issue -- his idea is to complete disable the reload
> notification when user start typing, and it also requires to switch
> to non-canonical mode.
> 
> This is definitely something we need to fix in v2.34 and v2.33.1.
> 
> > Seems like zero lflags do the job just fine on a Linux VT. Reset it
> > to
> > canonical mode before running login.
> 
> What about Del/Backspace keys when user is typing login name? :-)

They seem to work the same as they used to?

From Stanislav's message I notice that there's supposed to be some
problem with them -- I'm not seeing that. Either the patch does
something different or I'm not looking at the right thing.

(I haven't looked at Stanislav's patch -- but I surely intend to give
it a try.)

Lubo

> 
>     Karel
> 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > 
> > ---
> > Changes since v1:
> > - Unreversed the logic in termio_final()/reset_vc() conditional
> > 
> > Tested on a vc and serial console on a stock Fedora installation:
> > 
> >   /sbin/agetty -o -p -- \u --noclear tty1 linux
> >   /sbin/agetty -o -p -- \u --keep-baud 115200,38400,9600 ttyS2
> > vt220
> > 
> >  term-utils/agetty.c | 26 ++++++++++++++++++--------
> >  1 file changed, 18 insertions(+), 8 deletions(-)
> > 
> > diff --git a/term-utils/agetty.c b/term-utils/agetty.c
> > index 3c87ec64e..3834813f1 100644
> > --- a/term-utils/agetty.c
> > +++ b/term-utils/agetty.c
> > @@ -303,7 +303,7 @@ static void parse_speeds(struct options *op,
> > char *arg);
> >  static void update_utmp(struct options *op);
> >  static void open_tty(char *tty, struct termios *tp, struct options
> > *op);
> >  static void termio_init(struct options *op, struct termios *tp);
> > -static void reset_vc (const struct options *op, struct termios
> > *tp);
> > +static void reset_vc(const struct options *op, struct termios *tp,
> > int canon);
> >  static void auto_baud(struct termios *tp);
> >  static void list_speeds(void);
> >  static void output_special_char (unsigned char c, struct options
> > *op,
> > @@ -485,13 +485,14 @@ int main(int argc, char **argv)
> >  	if (options.timeout)
> >  		alarm(0);
> >  
> > -	if ((options.flags & F_VCONSOLE) == 0) {
> > -		/* Finalize the termios settings. */
> > +	/* Finalize the termios settings. */
> > +	if ((options.flags & F_VCONSOLE) == 0)
> >  		termio_final(&options, &termios, &chardata);
> > +	else
> > +		reset_vc(&options, &termios, 1);
> >  
> > -		/* Now the newline character should be properly
> > written. */
> > -		write_all(STDOUT_FILENO, "\r\n", 2);
> > -	}
> > +	/* Now the newline character should be properly written. */
> > +	write_all(STDOUT_FILENO, "\r\n", 2);
> >  
> >  	sigaction(SIGQUIT, &sa_quit, NULL);
> >  	sigaction(SIGINT, &sa_int, NULL);
> > @@ -1234,7 +1235,7 @@ static void termio_init(struct options *op,
> > struct termios *tp)
> >  		setlocale(LC_CTYPE, "POSIX");
> >  		op->flags &= ~F_UTF8;
> >  #endif
> > -		reset_vc(op, tp);
> > +		reset_vc(op, tp, 0);
> >  
> >  		if ((tp->c_cflag & (CS8|PARODD|PARENB)) == CS8)
> >  			op->flags |= F_EIGHTBITS;
> > @@ -1344,7 +1345,7 @@ static void termio_init(struct options *op,
> > struct termios *tp)
> >  }
> >  
> >  /* Reset virtual console on stdin to its defaults */
> > -static void reset_vc(const struct options *op, struct termios *tp)
> > +static void reset_vc(const struct options *op, struct termios *tp,
> > int canon)
> >  {
> >  	int fl = 0;
> >  
> > @@ -1353,6 +1354,15 @@ static void reset_vc(const struct options
> > *op, struct termios *tp)
> >  
> >  	reset_virtual_console(tp, fl);
> >  
> > +#ifdef AGETTY_RELOAD
> > +	/*
> > +	 * Discard all the flags that makes the line go canonical with
> > echoing.
> > +	 * We need to know when the user starts typing.
> > +	 */
> > +	if (canon == 0)
> > +		tp->c_lflag = 0;
> > +#endif
> > +
> >  	if (tcsetattr(STDIN_FILENO, TCSADRAIN, tp))
> >  		log_warn(_("setting terminal attributes failed: %m"));
> >  
> > -- 
> > 2.19.1
> > 

