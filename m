Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:63185 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761846AbdAFMW2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 6 Jan 2017 07:22:28 -0500
From: =?windows-1252?q?R=FCdiger_Meier?= <sweet_f_a@gmx.de>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Subject: Re: [PATCH] newgrp: use libc explicit_bzero() when it is available
Date: Fri, 6 Jan 2017 13:15:05 +0100
Cc: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
References: <20170105223340.2721-1-kerolasa@iki.fi> <4462d609-2049-7484-d6a8-53daf9b4534f@bernhard-voelker.de>
In-Reply-To: <4462d609-2049-7484-d6a8-53daf9b4534f@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Message-Id: <201701061315.05420.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On Friday 06 January 2017 12:09:09 Bernhard Voelker wrote:
> On 01/05/2017 11:33 PM, Sami Kerola wrote:
> > +#ifdef HAVE_EXPLICIT_BZERO
> > +		explicit_bzero(xpwd, strlen(xpwd));
> > +#else
> >  		xmemset_s(xpwd, strlen(xpwd), 0);
> > +#endif
> >  		free(xpwd);
>
> Do you think it's worth making things even more complicated
> for overwriting a simple string?  I mean, a simple
>
>   for (char *c = xpwd; c; c++)
>     c = '\0';
>
> would do, wouldn't it?

I'm not an expert about this but explicit_bzero() seems to do some tricks to 
avoid any compiler optimizations. Maybe the compiler would just not execute 
the complete for loop if we never access bytes after the (first) NULL byte 
later!? If this issue would be trivial then they probably wouldn't have added 
the explicit_bzero() function at all.

see BSD's bzero man page:

     The explicit_bzero() variant behaves the same, but will not be removed by
     a compiler's dead store optimization pass, making it useful for clearing
     sensitive memory such as a password.

and source code:

http://www.leidinger.net/FreeBSD/dox/libkern/html/d5/da7/explicit__bzero_8c_source.html


cu,
Rudi
