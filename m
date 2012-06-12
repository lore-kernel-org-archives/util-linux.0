Return-Path: util-linux-owner@vger.kernel.org
Received: from damascus.uab.es ([158.109.168.135]:37425 "EHLO damascus.uab.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753215Ab2FLM51 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 12 Jun 2012 08:57:27 -0400
Received: from damascus.uab.es ([127.0.0.1])
 by damascus.uab.es (Sun Java System Messaging Server 6.1 HotFix 0.10 (built
 Jan  6 2005)) with ESMTP id <0M5I00IKR9BPCS80@damascus.uab.es> for
 util-linux@vger.kernel.org; Tue, 12 Jun 2012 14:57:27 +0200 (CEST)
Received: from aomail.uab.es ([158.109.65.1])
 by damascus.uab.es (Sun Java	System Messaging Server 6.1 HotFix 0.10 (builtJan
 6 2005)) with ESMTP id	<0M5I0025N9BP3030@damascus.uab.es>
 forutil-linux@vger.kernel.org; Tue, 12 Jun 2012 14:57:25 +0200 (CEST)
Date: Tue, 12 Jun 2012 14:57:16 +0200
From: Davidlohr Bueso <dave@gnu.org>
Subject: Re: non-recursive build system
In-reply-to: <20120612100340.GB23991@x2.net.home>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Message-id: <1339505836.17574.6.camel@offworld>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
References: <20120612100340.GB23991@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, 2012-06-12 at 12:03 +0200, Karel Zak wrote:
> 
>  The original version was implemented by Diego Elio 'Flameeyes' Pettenò
>  two years ago:
>      http://thread.gmane.org/gmane.linux.utilities.util-linux-ng/3297
> 
>  See also:
>      http://www.flameeyes.eu/autotools-mythbuster/automake/nonrecursive.html
> 
>  My current version is available at github, 'non-recursive' branch:
>      https://github.com/karelzak/util-linux/commits/non-recursive
> 
> 
>  Notes:
> 
>  * generate one Makefile for whole package
> 
>  * make(1) has all information to run tasks in parallel 
> 
>  * numbers (make -j)
> 
>              recursive | non-recursive
>              ----------+--------------
>     2 cores: 14.5 sec  | 13.2 sec
>    16 cores:  9.5 sec  |  4.3 sec
> 
>    (... more CPU cores means more fun;-)

Nice, are these real cores or HT?

> 
>  * automake variables and rules are defined in subdir/Makemodule.am files
>    (create one huge Makefile.am is too crazy idea)
> 
>  * top-level Makefile.am includes all Makemodule.am files
> 
>  * $(top_srcdir) prefix for lib/ and include/ is unnecessary, just use
>    lib/bar.c and include/bar.h in makefiles
> 
>  * lib/ has been converted to libcommon.la, it means that
>        foo_LDADD = libcommon.la
>    is enough to use arbitrary stuff from lib/.
> 
>  * all rules are interpreted from top-level directory, it means that
>        cd subdir; make
>    or
>        make -C subdir
>    does not work.
> 
>  * binaries are stored in top-level (build) directory, you don't
>    have to care about directories, just type:
> 
> 	$ make mount
> 	$ ./mount --help
> 
>  * all build targets (including test binaries) are visible for bash completion
>    scripts (e.g. /etc/bash_completion.d/make), so <tab> is your good friend
> 
> 
>  * disadvantages:
> 
>     - full paths in makefiles (e.g. foo_SOURCE = subdir/foo.c)
> 
>     - we can't use the same name for subdir/ and for a final binary
>       Necessary changes:
>        - remove partx/ directory, move partx.c to disk-utils/
>        - remove getopt/ directory, move getopt.c to misc-utils/
>        - remove hwclock/ directory, move hwclock.c to sys-utils/
>        - rename fdisk/ to fdisks/

fdisk-utils?

>        - rename mount/ to mount-deprecated/ (we use new sys-utils/mount.c)
> 
>       Note that consolidate the code and remove some subdirs (e.g. getopt/) is
>       probably a good idea independently on the build-system changes.
> 

Thanks,
Davidlohr

