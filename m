Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:28072 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751278Ab2LSJds (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 19 Dec 2012 04:33:48 -0500
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qBJ9XmYP013461
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Wed, 19 Dec 2012 04:33:48 -0500
Received: from x2 (ovpn-113-135.phx2.redhat.com [10.3.113.135])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id qBJ9Xl6e026140
	for <util-linux@vger.kernel.org>; Wed, 19 Dec 2012 04:33:48 -0500
Date: Wed, 19 Dec 2012 10:33:46 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH] agetty: map NL to CR-NL on output in initial
 termiossettings
Message-ID: <20121219093346.GA17959@x2.net.home>
References: <1321437290.29540.75.camel@djensen-laptop>
 <20111123110851.GA516@nb.net.home>
 <1322157357.6169.541.camel@djensen-laptop>
 <20121210123439.GA20802@boole.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121210123439.GA20802@boole.suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Dec 10, 2012 at 01:34:39PM +0100, Dr. Werner Fink wrote:
> > --- a/term-utils/agetty.c
> > +++ b/term-utils/agetty.c
> > @@ -1091,7 +1091,8 @@ static void termio_init(struct options *op, struct termios *tp)
> >  #else
> >  	tp->c_iflag = 0;
> >  #endif
> > -	tp->c_lflag = tp->c_oflag = 0;
> > +	tp->c_lflag = 0;
> > +	tp->c_oflag &= OPOST | ONLCR;
> >  
> >  	if ((op->flags & F_KEEPCFLAGS) == 0)
> >  		tp->c_cflag = CS8 | HUPCL | CREAD | (tp->c_cflag & CLOCAL);
> 
> 
> Indeed this should work even on some strange serial consoles.
> Maybe this is also required for my patch set for sulogin as

 OK, applied to sulogin too.

> with this set sulogin supports not only virtual consoles but
> also serial consoles as well.

 It seems that we duplicate some code in sulogin and agetty. 

 See: 
    term-utils/agetty.c: termio_final()
    login-utils/sulogin.c: tcfinal()

    (and maybe also tcinit() in sulogin.c)

 would be possible to merge this code and move it to include/ttyutils.h 
 (or lib/ttyutils.c). I see small differences in the code, but not sure 
 which version is better (I guess agetty as this code is tested on more
 places).

 It would be nice to cleanup this before the next release to have only
 one place (code) where we initialize terminal attributes.
 
    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
