Return-Path: sbrabec@suse.cz
Message-ID: <1408032144.5984.179.camel@oct.suse.cz>
Subject: Re: util-linux and distro bootstrap, dependencies and build cycles
From: Stanislav Brabec <sbrabec@suse.cz>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Date: Thu, 14 Aug 2014 18:02:24 +0200
In-Reply-To: <20140814084858.GA9297@x2.net.home>
References: <1407768431.5984.23.camel@oct.suse.cz>
	 <20140812093955.GL17719@x2.net.home> <1407874536.5984.80.camel@oct.suse.cz>
	 <20140813101736.GO17719@x2.net.home>
	 <1407941620.5984.134.camel@oct.suse.cz> <20140814084858.GA9297@x2.net.home>
Content-Type: text/plain; charset="ISO-8859-2"
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Wed, Aug 13, 2014 at 04:53:40PM +0200, Stanislav Brabec wrote:
>
>  Now, when I think about it.. it seem the extra option is unnecessary
> 
>    --disable-libmount --enable-pylibmount
> 
>  provides all necessary information. If the Py binding is explicitly
>  required, but the library is disabled then it's obvious that
>  out-of-tree libs are necessary. Now we use
> 
>    UL_REQUIRES_BUILD([pylibmount], [libmount])
> 
>  to define dependence between in-tree builds, maybe it would be
>  possible to add a new macro:
> 
>    UL_REQUIRES_BUILD_OR_LIB([pylibmount], [libmount], [MOUNT])
>   
>  where 'MOUNT' will be used for
> 
>    PKG_CHECK_MODULES([MOUNT])

Yes, it could work. I'll try to create a patch.

libmount is not wanted + pylibmount is wanted
  => check for external libmount

> > util-linux is a part of the base build image, so its change (correctly)
> > triggers all packages to rebuild.
> 
>  but why all packages? Why not packages which depend on util-linux libs
>  only?

util-linux is part of the base build image together with gcc binutils,
glibc, sed and few other packages.
=> Any package can be affected by util-linux change

> > Only base system changes (gcc, binutils, bash, util-linux,...) trigger
> > whole distro to rebuild. Updates of high level packages triggers only
> > dependent package.
> 
>  hmm.. we (fedora/rhel) also do mass rebuilds, but it's always
>  triggered manually and usually for some obvious issue which affect
>  all packages (gcc/libc bugs etc.).

I know. It may easily cause overseeing of newly introduced fulfilling:
PKG_CHECK_MODULES([foo >= version])

SUSE does no manual rebuilds. It depends on automatic rebuild triggers.
Mass rebuilds happen automatically if somebody submits a package in the
core build image. In all other cases, only part of the tree is
triggered.

There are several ways, how to automatically trigger rebuilds:
- Trigger by any change in lower level packages.
- Trigger by change in provided symbols (file list, version, SONAME,
  library symbols).
- Trigger by change apparently that apparently caused breakage (SONAME
  change).

openSUSE Build Service uses first two triggers. For example, Gentoo uses
the third way.

The first two triggers have to solve dependency loops. They introduce
multiple triggering of rebuilds of the same package:
new util-linux => rebuild python (it can change)
new python => rebuild util-linux (as python-libmount will change)
util-linux changed (exactly python-libmount changed) => rebuild python

In most cases, package contents settles after two build cycles (If the
resulting package is bit-equal to the previous one, rebuild trigger is
not activated.)

Large dependency loops are not wanted, as they affect distro build time.

Note: Far the worst dependency cycle happens between maven (Java build
system) and about 500 Java package that require maven to build, but they
are required by maven to build maven. In this case, our package
maintainer broken the dependency loop by using of binary images of
dependent packages.

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
