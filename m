Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54935 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754497AbaHNItD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Aug 2014 04:49:03 -0400
Date: Thu, 14 Aug 2014 10:48:58 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: util-linux and distro bootstrap, dependencies and build cycles
Message-ID: <20140814084858.GA9297@x2.net.home>
References: <1407768431.5984.23.camel@oct.suse.cz>
 <20140812093955.GL17719@x2.net.home>
 <1407874536.5984.80.camel@oct.suse.cz>
 <20140813101736.GO17719@x2.net.home>
 <1407941620.5984.134.camel@oct.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407941620.5984.134.camel@oct.suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 13, 2014 at 04:53:40PM +0200, Stanislav Brabec wrote:
> > What is wrong with in-tree libs? After "make install" all the binaries 
> > is possible to use against out-of-tree libs. Problem solved.
> 
> There is nothing wrong with them. It is just a second build of the same
> code, and not building them would save only few seconds of build. I

 Hmm.. premature optimization? :-)

> consider it a bit cleaner: always link against library instances that
> will actually appear in the installed system.
> 
> However linking against an identical library with a different time stamp
> than the installed one makes no problems in Linux, and no other
> platforms are supported.
> 
> > (Well, we can improve "make install" to not install .so libs when 
> >  only python binding is wanted.)
> 
> What about adding just --use-installed-libxxx? It would fit multi-stage

 Now, when I think about it.. it seem the extra option is unnecessary

   --disable-libmount --enable-pylibmount

 provides all necessary information. If the Py binding is explicitly
 required, but the library is disabled then it's obvious that
 out-of-tree libs are necessary. Now we use

   UL_REQUIRES_BUILD([pylibmount], [libmount])

 to define dependence between in-tree builds, maybe it would be
 possible to add a new macro:

   UL_REQUIRES_BUILD_OR_LIB([pylibmount], [libmount], [MOUNT])
  
 where 'MOUNT' will be used for

   PKG_CHECK_MODULES([MOUNT])
 
 if $build_libmount=no, see m4/ul.m4 for more details.


 But again, it will increase configure complexity, IMHO it would be 
 enough to improve "make install" to install only the Py binding and
 always build against in-tree libs. If your distro build system
 triggers so many rebuilds then save few seconds is a real detail :-)

> SUSE does not rebuild all from scratch for standard packages.
> 
> openSUSE Build Service is a multi-repository system. Any change in low
> level package will trigger all higher level packages in connected
> repositories to rebuild, so the Build Service guarantees, that all high
> level packages are build against the correct version of the low level
> package.

 You will see more and more problems with this concept. The border
 between high-level and low-level is fragile and difficult to define.
 The typical problem are interpreted languages or systemd.

> util-linux is a part of the base build image, so its change (correctly)
> triggers all packages to rebuild.

 but why all packages? Why not packages which depend on util-linux libs
 only?

> If python-libmount is part of the util-linux package, any change in
> python package or its dependencies would trigger util-linux to rebuild,
> and the change in the binary image of python binding would trigger whole
> distro to rebuild.

 OK, this makes sense.

> Only base system changes (gcc, binutils, bash, util-linux,...) trigger
> whole distro to rebuild. Updates of high level packages triggers only
> dependent package.

 hmm.. we (fedora/rhel) also do mass rebuilds, but it's always
 triggered manually and usually for some obvious issue which affect
 all packages (gcc/libc bugs etc.).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
