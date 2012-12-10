Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:50166 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752539Ab2LJMem (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 10 Dec 2012 07:34:42 -0500
Date: Mon, 10 Dec 2012 13:34:39 +0100
From: "Dr. Werner Fink" <werner@suse.de>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] agetty: map NL to CR-NL on output in initial
 termiossettings
Message-ID: <20121210123439.GA20802@boole.suse.de>
References: <1321437290.29540.75.camel@djensen-laptop>
 <20111123110851.GA516@nb.net.home>
 <1322157357.6169.541.camel@djensen-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1322157357.6169.541.camel@djensen-laptop>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Nov 24, 2011 at 06:55:57PM +0100, Dennis Jensen wrote:
> On Wed, 2011-11-23 at 12:08 +0100, Karel Zak wrote:
> > [CC: to Werner Fink]
> > 
> > On Wed, Nov 16, 2011 at 10:54:50AM +0100, Dennis Jensen wrote:
> > > This fixes situations where messages "scroll horizontally", making
> > 
> > Do you mean /etc/issue and prompt strings? The terminal end-of-line
> > should be detected in get_logname() and then the proper flags should
> > be set in termio_final().
> 
> I mean something like this, after enabling DEBUG: 
> 
> -wL8ttyS019200linuxaterm_io 2
>                              before autobaud
>                                             waiting for cr-lf

[...]

> 
> diff --git a/term-utils/agetty.c b/term-utils/agetty.c
> index 041e1f7..079a737 100644
> --- a/term-utils/agetty.c
> +++ b/term-utils/agetty.c
> @@ -1091,7 +1091,8 @@ static void termio_init(struct options *op, struct termios *tp)
>  #else
>  	tp->c_iflag = 0;
>  #endif
> -	tp->c_lflag = tp->c_oflag = 0;
> +	tp->c_lflag = 0;
> +	tp->c_oflag &= OPOST | ONLCR;
>  
>  	if ((op->flags & F_KEEPCFLAGS) == 0)
>  		tp->c_cflag = CS8 | HUPCL | CREAD | (tp->c_cflag & CLOCAL);


Indeed this should work even on some strange serial consoles.
Maybe this is also required for my patch set for sulogin as
with this set sulogin supports not only virtual consoles but
also serial consoles as well.


     Werner

-- 
  "Having a smoking section in a restaurant is like having
          a peeing section in a swimming pool." -- Edward Burr
