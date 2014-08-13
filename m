Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:35753 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750757AbaHMOxn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 13 Aug 2014 10:53:43 -0400
Message-ID: <1407941620.5984.134.camel@oct.suse.cz>
Subject: Re: util-linux and distro bootstrap, dependencies and build cycles
From: Stanislav Brabec <sbrabec@suse.cz>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Date: Wed, 13 Aug 2014 16:53:40 +0200
In-Reply-To: <20140813101736.GO17719@x2.net.home>
References: <1407768431.5984.23.camel@oct.suse.cz>
	 <20140812093955.GL17719@x2.net.home> <1407874536.5984.80.camel@oct.suse.cz>
	 <20140813101736.GO17719@x2.net.home>
Content-Type: text/plain; charset="ISO-8859-2"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
>Sorry, but I don't plan to support and maintain any stages options,
>all we need is to have --disable-<utilname> and then you can define
>the stages in *your* build scripts (spec files).

> Sure, nobody wants to support build against random out-of-tree libs
> when we develop all together to make things consistent.

They are not random libraries. They are util-linux libraries built from
the same source code, just in time between there was python and systemd
rebuilt.

> What is wrong with in-tree libs? After "make install" all the binaries 
> is possible to use against out-of-tree libs. Problem solved.

There is nothing wrong with them. It is just a second build of the same
code, and not building them would save only few seconds of build. I
consider it a bit cleaner: always link against library instances that
will actually appear in the installed system.

However linking against an identical library with a different time stamp
than the installed one makes no problems in Linux, and no other
platforms are supported.

> (Well, we can improve "make install" to not install .so libs when 
>  only python binding is wanted.)

What about adding just --use-installed-libxxx? It would fit multi-stage
build needs as well and it would be cleaner to implement. I think that
not-installing built shared libraries is not supported by autotools
(IMHO noinst switches to static linking).

To be sure about installed version, it's easy to add pkg-config version
check.
PKG_CHECK_MODULES([LIBMOUNT], [mount = $PACKAGE_VERSION],...)

If you would accept such change, I will send a patch.

> You have to also guarantee that in-tree version is exactly the same
> as -lmount version...

It is guaranteed by the build system.

> > > Anyway, I don't understand why do you want to rebuild all recursively
> > > (so result is rebuild of 2921 packages).
> > 
> > Imagine that util-linux is updated and automatic system evaluates
> > dependencies in a safe way
> 
> This is not answer to the question. I don't understand why Suse does
> not use regular build roots for updates. For example for Fedora we
> don't rebuild all from scratch -- just use the current system packages
> to build new version (and then update the build machines). It's about
> minutes to rebuild the package.

SUSE does not rebuild all from scratch for standard packages.

openSUSE Build Service is a multi-repository system. Any change in low
level package will trigger all higher level packages in connected
repositories to rebuild, so the Build Service guarantees, that all high
level packages are build against the correct version of the low level
package.

If the package rebuild triggers change, the rebuild trigger is activated
as well.

util-linux is a part of the base build image, so its change (correctly)
triggers all packages to rebuild.

If python-libmount is part of the util-linux package, any change in
python package or its dependencies would trigger util-linux to rebuild,
and the change in the binary image of python binding would trigger whole
distro to rebuild.

> 
> Yes, I can imagine self-hosting distro, but it's IMHO very special
> situation... (new CentOS from SRPMs, Linux from scratch, etc.), but
> for standard updates?

Only base system changes (gcc, binutils, bash, util-linux,...) trigger
whole distro to rebuild. Updates of high level packages triggers only
dependent package.

This prevents any binary incompatibility when releasing rolling update
with a new library.

This also makes possible to create experimental repositories with single
library updated. The build system automatically identifies and rebuilds
its dependencies.

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

