Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:51095 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752038AbaFDJdV (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 4 Jun 2014 05:33:21 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: build-sys: minor issues
Date: Wed, 4 Jun 2014 11:33:14 +0200
Cc: util-linux@vger.kernel.org
References: <201406020056.17074.sweet_f_a@gmx.de> <201406020233.39094.sweet_f_a@gmx.de> <20140603104249.GQ9000@x2.net.home>
In-Reply-To: <20140603104249.GQ9000@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201406041133.15174.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 03 June 2014, Karel Zak wrote:
> On Mon, Jun 02, 2014 at 02:33:38AM +0200, Ruediger Meier wrote:
> >
> > Another issue:
> >
> > 3. --enable-gtk-doc does not work in out-of-tree build:
> > [...]

>
>  Fixed.

Thanks, it works.

For testing I've run it several times on travis farm from within 
distcheck. Unfortunately docs still fail randomly in 1 of 10 runs.

$ make distcheck
[...]
make[1]: Entering directory 
`/home/travis/build/rudimeier/util-linux/libblkid/docs'
make[1]: Circular scan-build.stamp <- libblkid-sections.txt dependency 
dropped.
  GEN    scan-build.stamp
[...]
Making all in libblkid/docs
make[3]: Entering directory 
`/home/travis/build/rudimeier/util-linux/util-linux-2.24.913-183e/_build/libblkid/docs'
gtk-doc: Preparing build
cp: cannot create regular file `./libblkid-sections.txt': Permission 
denied
make[3]: *** [scan-build.stamp] Error 1

Note that this "Permission denied" also happens in successful runs.

Here full logs of good and bad run:
https://s3.amazonaws.com/archive.travis-ci.org/jobs/26722236/log.txt
https://s3.amazonaws.com/archive.travis-ci.org/jobs/26722239/log.txt


Don't know whether this happens only out-of-tree or because of parallel 
build. "Permission denied" in distcheck always smells like writing to 
srcdir. Maybe you have already an idea what it could be or I would just 
add debug messages and watch it.

cu,
Rudi
