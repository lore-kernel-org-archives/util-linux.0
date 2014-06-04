Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: build-sys: minor issues
Date: Wed, 4 Jun 2014 11:48:03 +0200
Cc: util-linux@vger.kernel.org
References: <201406020056.17074.sweet_f_a@gmx.de> <201406031509.24914.sweet_f_a@gmx.de> <20140604092600.GT9000@x2.net.home>
In-Reply-To: <20140604092600.GT9000@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201406041148.03629.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Wednesday 04 June 2014, Karel Zak wrote:
> On Tue, Jun 03, 2014 at 03:09:24PM +0200, Ruediger Meier wrote:
> > On Monday 02 June 2014, Ruediger Meier wrote:
> > > I have two minor issues with our build-sys:
> >
> > Another issue:
> >
> > 4. --disable-all-programs disables pylibmount forever
> >
> > --with-python   does not turn it on again
> > --enable-pylibmount  does not exist
>
>  OK, I have added --enable-pylibmount, so you have to use:
>
>  ./configure --disable-all-programs \
>              --enable-pylibmount \
>              --enable-libmount \
>              --enable-libblkid
>
>  to compile the binding.

Thanks!

> > or do I miss something?
>
> note that we don't have --enable-* for all utils. It's probably
> overkill for small utils or utils expected everywhere.

Ah, I thought you've had added --enable-* more generically for 
everything lately.

But no problem in doubt there is still
$ ./configure --enable-all-programs
$ make xyz

cu,
Rudi
