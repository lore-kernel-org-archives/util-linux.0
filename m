Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: build-sys: how to install pylibmount after libmount?
Date: Wed, 4 Jun 2014 12:45:53 +0200
Cc: util-linux@vger.kernel.org
References: <201406031552.50670.sweet_f_a@gmx.de> <20140604102117.GU9000@x2.net.home>
In-Reply-To: <20140604102117.GU9000@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201406041245.54088.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Wednesday 04 June 2014, Karel Zak wrote:
> On Tue, Jun 03, 2014 at 03:52:50PM +0200, Ruediger Meier wrote:
> > Hi,
> >
> > This should be easy to reproduce if you don't have a global
> > installed libmount.
> >
> > $ sudo mkdir /usr/lib64/away
> > $ sudo mv /usr/lib64/libmount.* /usr/lib64/away
> >
> > $ ./configure --disable-use-tty-group \
> > 	--prefix=/tmp/dest \
>
>  Just note, it's usually bad idea to override the default prefix
>  (especially for package like util-linux), it's better to use
>  standard prefix and use "make install  DESTDIR=/tmp/dest".

Yes, in this case I wanted to debug and reproduce "make distcheck"
where --prefix is used.

> > Unfortunately some systems set per default
> >   link_all_deplibs=no
> > instead of "unknown" in ./libtool. Don't know whether this is a bug
> > in libtool or automake macros. But we could work around this if we
> > would make sure to install pylibmount always after libmount.
> >
> > This is how it looks in Makefile.in:
> > install-exec-am: install-binPROGRAMS
> > install-dist_usrbin_execSCRIPTS \ install-pylibmountexecLTLIBRARIES
> > \
> >         install-pylibmountexecSCRIPTS install-sbinPROGRAMS \
> >         install-usrbin_execPROGRAMS install-usrlib_execLTLIBRARIES
> > \ install-usrsbin_execPROGRAMS
> >         @$(NORMAL_INSTALL)
> >         $(MAKE) $(AM_MAKEFLAGS) install-exec-hook
> >
> > How could we force to put
> >   install-pylibmountexecLTLIBRARIES
> > after
> >   install-usrlib_execLTLIBRARIES
>
> hmm.. I don't know, I think it's libtool job to generate the right
> order.

I think too. libtool and automake can be assumed to be non-broken on 
devel machines. I thought there is still a little chance that we have 
incorrect pylibmount_la_DEPENDENCIES ot whatever. But I don't see it.

Anyway, I will just add a workaround for travis.yml until they update 
build-os:
  ./autogen.sh
  # workaround for broken pylibmount install relink
  sed -i 's/\(link_all_deplibs\)=no/\1=unknown/' ./configure

cu,
Rudi
