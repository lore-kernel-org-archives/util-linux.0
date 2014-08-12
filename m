Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:46275 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754399AbaHLUPi (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 12 Aug 2014 16:15:38 -0400
Message-ID: <1407874536.5984.80.camel@oct.suse.cz>
Subject: Re: util-linux and distro bootstrap, dependencies and build cycles
From: Stanislav Brabec <sbrabec@suse.cz>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Date: Tue, 12 Aug 2014 22:15:36 +0200
In-Reply-To: <20140812093955.GL17719@x2.net.home>
References: <1407768431.5984.23.camel@oct.suse.cz>
	 <20140812093955.GL17719@x2.net.home>
Content-Type: text/plain; charset="ISO-8859-2"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Mon, Aug 11, 2014 at 04:47:11PM +0200, Stanislav Brabec wrote:
> > The build cycle util-linux <-> python is far the largest build cycle. In
> > case of forthcoming SLES12 it triggers rebuild of 2921 packages!
> 
> well, util-linux is source tarball, all depends what do you want to
> build from the tarball. You can rebuild and use only the binding and
> ignore everything else.
> 
>   ./configure --disable-all-programs --enable-libblkid --enable-libuuid
>               --enable-libmount --enable-pylibmount
> 

This does not do what I need: It builds python bindings plus it builds
and installs libblkid, libmount and libuuid (for the second time, as we
already built and install them in the stage 1).

I need to build util-linux with defined configure options, but do it in
three stages with defined dependencies.

There is currently no way how to build python-libmount against
system-installed instance of libmount and not the in-tree one. (It means
that python-libmount forces to build libmount in-tree.)

> I currently see only one disadvantage, we don't have "install-pylibmount" 
> Makefile target now, you can use
> 
>   make install-pylibmountexecPYTHON install-pylibmountexecLTLIBRARIES
> but it sucks..

My proposal is different: Use special configuration options, that will
configure only part of util-linux to be built. Then use standard "make
install". It can be done by setting BUILD_* properly and using variable
instead of libxxx.la.

I think about using $(LIBMOUNT_LIBS) instead of libmount.la (and the
same for other in-tree libraries). LIBMOUNT_LIBS will be libmount.la
(use in-tree libmount) during normal build, and e. g. -lmount (use
installed libmount) during multi-stage build.

This will allow to build and install util-linux per-partes. All other
configure options could be kept intact.

> Anyway, I don't understand why do you want to rebuild all recursively
> (so result is rebuild of 2921 packages).

Imagine that util-linux is updated and automatic system evaluates
dependencies in a safe way:

1) util-linux update is built

2) all high level packages are triggered to rebuild by util-linux
   changes
   systemd and python are two of triggered packages

3) 2920 packages are rebuilt => all dependencies of systemd and python
   are ready => python is rebuilt, systemd was rebuild as well

4) python (and/or systemd) changes trigger util-linux to rebuild

5) all high level packages are triggered to rebuild by util-linux
   changes, including 2921 packages already rebuilt in 3)


How it looks with multi stage util-linux build:

1) util-linux stage 1 update is built

2) all high level packages are triggered to rebuild by util-linux
   changes
   systemd and python are two of triggered packages

3) all dependencies of systemd are ready => systemd is rebuilt => 
   util-linux-systemd (= util-linux stage 2) update is built

4) 2920 packages are rebuilt => python is rebuilt =>
   python-libmount (= util-linux stage 3) update is built

In case of openSUSE Build Service, multi-stage build saves one day of
machine time of our build cluster.

> > I was asked to solve this problem, and I created a solution that makes
> > possible to build:
> > util-linux stage 1: Everything except stuff that supports systemd and
> >   python-libmount
> > util-linux stage 2: Stuff that supports systemd (lslogins, logger, uuidd
> >   and fstrim service files) using installed low level stage 1 stuff.
> > python-libmount: Python bindings only using installed stage 1 stuff.
> > 
> > This is now implemented by a set of sed scripts on top of .am and .ac
> > sources. But I would like to create more generic solution.
> 
> Hmm.. modify build system is bad idea.

That is why I want to implement configure options and do it in a safe
and upstream-acceptable way.

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76

