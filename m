Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57272 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751092Ab2FLKDn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 12 Jun 2012 06:03:43 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q5CA3hhh003554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 12 Jun 2012 06:03:43 -0400
Received: from x2 (ovpn-116-57.ams2.redhat.com [10.36.116.57])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q5CA3f7o000908
	for <util-linux@vger.kernel.org>; Tue, 12 Jun 2012 06:03:42 -0400
Date: Tue, 12 Jun 2012 12:03:40 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux <util-linux@vger.kernel.org>
Subject: non-recursive build system
Message-ID: <20120612100340.GB23991@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



 The original version was implemented by Diego Elio 'Flameeyes' Pettenò
 two years ago:
     http://thread.gmane.org/gmane.linux.utilities.util-linux-ng/3297

 See also:
     http://www.flameeyes.eu/autotools-mythbuster/automake/nonrecursive.html

 My current version is available at github, 'non-recursive' branch:
     https://github.com/karelzak/util-linux/commits/non-recursive


 Notes:

 * generate one Makefile for whole package

 * make(1) has all information to run tasks in parallel 

 * numbers (make -j)

             recursive | non-recursive
             ----------+--------------
    2 cores: 14.5 sec  | 13.2 sec
   16 cores:  9.5 sec  |  4.3 sec

   (... more CPU cores means more fun;-)

 * automake variables and rules are defined in subdir/Makemodule.am files
   (create one huge Makefile.am is too crazy idea)

 * top-level Makefile.am includes all Makemodule.am files

 * $(top_srcdir) prefix for lib/ and include/ is unnecessary, just use
   lib/bar.c and include/bar.h in makefiles

 * lib/ has been converted to libcommon.la, it means that
       foo_LDADD = libcommon.la
   is enough to use arbitrary stuff from lib/.

 * all rules are interpreted from top-level directory, it means that
       cd subdir; make
   or
       make -C subdir
   does not work.

 * binaries are stored in top-level (build) directory, you don't
   have to care about directories, just type:

	$ make mount
	$ ./mount --help

 * all build targets (including test binaries) are visible for bash completion
   scripts (e.g. /etc/bash_completion.d/make), so <tab> is your good friend


 * disadvantages:

    - full paths in makefiles (e.g. foo_SOURCE = subdir/foo.c)

    - we can't use the same name for subdir/ and for a final binary
      Necessary changes:

       - remove partx/ directory, move partx.c to disk-utils/
       - remove getopt/ directory, move getopt.c to misc-utils/
       - remove hwclock/ directory, move hwclock.c to sys-utils/
       - rename fdisk/ to fdisks/
       - rename mount/ to mount-deprecated/ (we use new sys-utils/mount.c)

      Note that consolidate the code and remove some subdirs (e.g. getopt/) is
      probably a good idea independently on the build-system changes.


 Comments & objections?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
