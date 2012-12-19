Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:60135 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753379Ab2LSN3U (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 19 Dec 2012 08:29:20 -0500
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 85F97A5200
	for <util-linux@vger.kernel.org>; Wed, 19 Dec 2012 14:29:19 +0100 (CET)
Date: Wed, 19 Dec 2012 14:29:17 +0100
From: "Dr. Werner Fink" <werner@suse.de>
To: util-linux@vger.kernel.org
Subject: Re: [util-linux] [PATCH] agetty: map NL to CR-NL on output in
 initial termiossettings
Message-ID: <20121219132917.GA26228@boole.suse.de>
References: <1321437290.29540.75.camel@djensen-laptop>
 <20111123110851.GA516@nb.net.home>
 <1322157357.6169.541.camel@djensen-laptop>
 <20121210123439.GA20802@boole.suse.de>
 <20121219093346.GA17959@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20121219093346.GA17959@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Dec 19, 2012 at 10:33:46AM +0100, Karel Zak wrote:
> On Mon, Dec 10, 2012 at 01:34:39PM +0100, Dr. Werner Fink wrote:
> > > --- a/term-utils/agetty.c
> > > +++ b/term-utils/agetty.c
> > > @@ -1091,7 +1091,8 @@ static void termio_init(struct options *op, struct termios *tp)
> > >  #else
> > >  	tp->c_iflag = 0;
> > >  #endif
> > > -	tp->c_lflag = tp->c_oflag = 0;
> > > +	tp->c_lflag = 0;
> > > +	tp->c_oflag &= OPOST | ONLCR;
> > >  
> > >  	if ((op->flags & F_KEEPCFLAGS) == 0)
> > >  		tp->c_cflag = CS8 | HUPCL | CREAD | (tp->c_cflag & CLOCAL);
> > 
> > 
> > Indeed this should work even on some strange serial consoles.
> > Maybe this is also required for my patch set for sulogin as
> 
>  OK, applied to sulogin too.
> 
> > with this set sulogin supports not only virtual consoles but
> > also serial consoles as well.
> 
>  It seems that we duplicate some code in sulogin and agetty. 
> 
>  See: 
>     term-utils/agetty.c: termio_final()
>     login-utils/sulogin.c: tcfinal()
> 
>     (and maybe also tcinit() in sulogin.c)
> 
>  would be possible to merge this code and move it to include/ttyutils.h 
>  (or lib/ttyutils.c). I see small differences in the code, but not sure 
>  which version is better (I guess agetty as this code is tested on more
>  places).
> 
>  It would be nice to cleanup this before the next release to have only
>  one place (code) where we initialize terminal attributes.

This may require to move `struct chardata' from term-utils/agetty.c and
also from include/consoles.h as well as init_chardata from term-utils/agetty.c to
a new include/ttyutils.h ...  then the function caps_lock() from term-utils/agetty.c
could be moved to lib/ttyutils.c ... after this termio_final() could become
the core of tcfinal() after the two boolean.  Similar holds true for tcinit()
and termio_init().


     Werner

-- 
  "Having a smoking section in a restaurant is like having
          a peeing section in a swimming pool." -- Edward Burr
