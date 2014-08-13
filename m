Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:17093 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751060AbaHMKRm (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 13 Aug 2014 06:17:42 -0400
Date: Wed, 13 Aug 2014 12:17:36 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: util-linux and distro bootstrap, dependencies and build cycles
Message-ID: <20140813101736.GO17719@x2.net.home>
References: <1407768431.5984.23.camel@oct.suse.cz>
 <20140812093955.GL17719@x2.net.home>
 <1407874536.5984.80.camel@oct.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407874536.5984.80.camel@oct.suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 12, 2014 at 10:15:36PM +0200, Stanislav Brabec wrote:
> Karel Zak wrote:
> > On Mon, Aug 11, 2014 at 04:47:11PM +0200, Stanislav Brabec wrote:
> > > The build cycle util-linux <-> python is far the largest build cycle. In
> > > case of forthcoming SLES12 it triggers rebuild of 2921 packages!
> > 
> > well, util-linux is source tarball, all depends what do you want to
> > build from the tarball. You can rebuild and use only the binding and
> > ignore everything else.
> > 
> >   ./configure --disable-all-programs --enable-libblkid --enable-libuuid
> >               --enable-libmount --enable-pylibmount
> > 
> 
> This does not do what I need: It builds python bindings plus it builds
> and installs libblkid, libmount and libuuid (for the second time, as we
> already built and install them in the stage 1).
> 
> I need to build util-linux with defined configure options, but do it in
> three stages with defined dependencies.

Sorry, but I don't plan to support and maintain any stages options,
all we need is to have --disable-<utilname> and then you can define
the stages in *your* build scripts (spec files).

> There is currently no way how to build python-libmount against
> system-installed instance of libmount and not the in-tree one. (It means
> that python-libmount forces to build libmount in-tree.)

Sure, nobody wants to support build against random out-of-tree libs
when we develop all together to make things consistent.

What is wrong with in-tree libs? After "make install" all the binaries 
is possible to use against out-of-tree libs. Problem solved.

(Well, we can improve "make install" to not install .so libs when 
 only python binding is wanted.)

> I think about using $(LIBMOUNT_LIBS) instead of libmount.la (and the
> same for other in-tree libraries). LIBMOUNT_LIBS will be libmount.la
> (use in-tree libmount) during normal build, and e. g. -lmount (use
> installed libmount) during multi-stage build.

You have to also guarantee that in-tree version is exactly the same
as -lmount version...

> > Anyway, I don't understand why do you want to rebuild all recursively
> > (so result is rebuild of 2921 packages).
> 
> Imagine that util-linux is updated and automatic system evaluates
> dependencies in a safe way

This is not answer to the question. I don't understand why Suse does
not use regular build roots for updates. For example for Fedora we
don't rebuild all from scratch -- just use the current system packages
to build new version (and then update the build machines). It's about
minutes to rebuild the package. 

Yes, I can imagine self-hosting distro, but it's IMHO very special
situation... (new CentOS from SRPMs, Linux from scratch, etc.), but
for standard updates?

> How it looks with multi stage util-linux build:
> 
> 1) util-linux stage 1 update is built
> 
> 2) all high level packages are triggered to rebuild by util-linux
>    changes
>    systemd and python are two of triggered packages
> 
> 3) all dependencies of systemd are ready => systemd is rebuilt => 
>    util-linux-systemd (= util-linux stage 2) update is built
> 
> 4) 2920 packages are rebuilt => python is rebuilt =>
>    python-libmount (= util-linux stage 3) update is built


Sure, all this is already possible (well, there is no --disable-logger, but 
we can add this option). All you need is to carefully specify --with-* and
--disable-*.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
