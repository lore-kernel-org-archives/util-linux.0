Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:50587 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758958Ab2C2Qp2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 29 Mar 2012 12:45:28 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 7C7CF8FB75
	for <util-linux@vger.kernel.org>; Thu, 29 Mar 2012 18:45:27 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Subject: [PATCH 00/20] *** uuidd: refactoring & systemd support + build-sys fixes ***
Date: Thu, 29 Mar 2012 18:45:08 +0200
Message-Id: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi all.

The primary goal of the patch series below was to implement systemd support in
for uuidd as it was one of the items on Karel's wish list for util-linux-2.22 [1].

First two patches are just minor cleanups I came across while working on the code.

Then I added --no-pid, --no-fork, --socket-activation and --keep-privs options
to make uuidd play nicely with systemd (or any compatible init system should
there be any).  Note that --socket-activation automatically implies all other
mentioned options. With the socket activation mode [2], uuidd is started on
demand when the first request comes to its request socket and quits after 60
seconds of inactivity (can be overridden in the provided unit files).

To make socket-activation work, the uuidd has to be compiled with the
sd-daemon.c files.  This is controlled via the --enable-uuidd-socket-activation
configure option. The second alternative would be to link with libsystemd
shared library, but after discussion with Karel I decided not to do it to avoid
some build dependency cycles between systemd and util-linux (to make life
easier for distributions).

I tried not to break or change the behavior of any existing uuidd options.

Next, there is new configure option for libuuid, the
--disable-libuuid-exec-uuidd, which prevents uuidd daemon to be executed
from the libuuid library, as it does not make sense with socket-activated
uuidd. I did not change the former libuuid behavior (exec the daemon), but when
building for systemd-based systems, it should be configured with 
--disable-libuuid-exec-uuidd.

Lastly, in order to make 'make distcheck' work (and verify the changes I did), I
fixed some minor issues in the build system.

I'd very much welcome any feedback/comments.

Thanks,

	Petr

[1] http://www.spinics.net/lists/util-linux-ng/msg05793.html
[2] http://0pointer.de/blog/projects/socket-activation.html



Petr Uzel (20):
  uuidd: use UUIDD_OP_GETPID instead of magic number
  uuidd: remove useless initialization of cleanup_socket
  uuidd: factor out pidfile creation into separate function
  uuidd: implement --no-pid option
  uuidd: implement --no-fork option
  uuidd: factor out socket creation into separate function
  uuidd: implement --socket-activation option
  uuidd: print all debugging information to stderr
  uuidd: factor out dropping of privileges into separate function
  uuidd: make drop_privs true by default in main()
  uuidd: introduce --keep-privs option
  uuidd: --socket-activation implies --keep-privs
  uuidd: add systemd unit files
  libuuid: use EXIT_FAILURE
  libuuid: implement --disable-libuuid-exec-uuidd configure option
  libuuid: fix typo in uuid_compare manpage
  build-sys: run distcheck with verbose make rules
  build-sys: add ttyutils.h to dist
  build-sys: add fsprobe.h to dist
  build-sys: fix installation of uuidd units with make distcheck

 Makefile.am                 |    4 +-
 configure.ac                |   35 +++
 include/Makefile.am         |    1 +
 libuuid/man/uuid_compare.3  |    2 +-
 libuuid/src/gen_uuid.c      |   11 +-
 misc-utils/.gitignore       |    2 +-
 misc-utils/Makefile.am      |   17 ++-
 misc-utils/sd-daemon.c      |  530 +++++++++++++++++++++++++++++++++++++++++++
 misc-utils/sd-daemon.h      |  282 +++++++++++++++++++++++
 misc-utils/uuidd.8          |   17 ++
 misc-utils/uuidd.c          |  295 +++++++++++++++++-------
 misc-utils/uuidd.service.in |    9 +
 misc-utils/uuidd.socket     |    8 +
 mount/Makefile.am           |    2 +-
 14 files changed, 1121 insertions(+), 94 deletions(-)
 create mode 100644 misc-utils/sd-daemon.c
 create mode 100644 misc-utils/sd-daemon.h
 create mode 100644 misc-utils/uuidd.service.in
 create mode 100644 misc-utils/uuidd.socket

-- 
1.7.7

