Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:5798 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751472AbaHLJkA (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 12 Aug 2014 05:40:00 -0400
Date: Tue, 12 Aug 2014 11:39:55 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: util-linux and distro bootstrap, dependencies and build cycles
Message-ID: <20140812093955.GL17719@x2.net.home>
References: <1407768431.5984.23.camel@oct.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407768431.5984.23.camel@oct.suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 11, 2014 at 04:47:11PM +0200, Stanislav Brabec wrote:
> The build cycle util-linux <-> python is far the largest build cycle. In
> case of forthcoming SLES12 it triggers rebuild of 2921 packages!

well, util-linux is source tarball, all depends what do you want to
build from the tarball. You can rebuild and use only the binding and
ignore everything else.

  ./configure --disable-all-programs --enable-libblkid --enable-libuuid
              --enable-libmount --enable-pylibmount


I currently see only one disadvantage, we don't have "install-pylibmount" 
Makefile target now, you can use

  make install-pylibmountexecPYTHON install-pylibmountexecLTLIBRARIES

but it sucks..


Anyway, I don't understand why do you want to rebuild all recursively
(so result is rebuild of 2921 packages).

> I was asked to solve this problem, and I created a solution that makes
> possible to build:
> util-linux stage 1: Everything except stuff that supports systemd and
>   python-libmount
> util-linux stage 2: Stuff that supports systemd (lslogins, logger, uuidd
>   and fstrim service files) using installed low level stage 1 stuff.
> python-libmount: Python bindings only using installed stage 1 stuff.
> 
> This is now implemented by a set of sed scripts on top of .am and .ac
> sources. But I would like to create more generic solution.

Hmm.. modify build system is bad idea.

> What do you think about one of the following solutions?:
> 
> Solution 1:
> 
> Modify make system by adding:
> --enable-build-stage-1: Distro bootstrap stage 1: Build only code
>     without systemd and python dependencies.

 --without-systemd --without-python

> --enable-build-stage-2: Distro bootstrap stage 2: Build code with
>     systemd dependencies (even if they are optional). Use installed
>     instances of libmount, libblkid, libsmartcols and libuuidd, do not
>     build them in-tree.

 Why do you do not want to use in-tree code? The libraries interfaces 
 are versioned, it's safe to build against in-tree code and the
 install..

 We can add --with-outtree-libs or so, but it will require check for
 many things and it will increase complexity etc. IMHO it's really bad
 idea.

> --enable-build-stage-3: Distro bootstrap stage 3: Build python-libmount
>     only. Use installed instance of libmount, do not build them in-tree.

> Solution 2:
> 
> --enable-build-stage-1 and --enable-build-stage-2 exactly as above.
> 
> Split python-libmount into a separate project.


 Solution 3:

 Fix your build system to use complete build roots.
 
 You can use old version of your distro to build new complete
 util-linux (and another packages), then create new build root from
 the new set of the packages and rebuild again.


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
