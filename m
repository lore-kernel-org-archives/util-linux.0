Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:53076 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754456Ab2ECTCE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 3 May 2012 15:02:04 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id AE69E9664A
	for <util-linux@vger.kernel.org>; Thu,  3 May 2012 21:02:02 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 00/15] uuidd: refactoring & systemd support (take 2)
Date: Thu,  3 May 2012 21:01:46 +0200
Message-Id: <1336071721-32492-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi all.

This is the second version of uuidd refactoring and systemd support. First
version was posted at [1]

The primary goal of the patch series below was to implement systemd support in
for uuidd as it was one of the items on Karel's wish list for util-linux-2.22 [2].

First two patches are just minor cleanups I came across while working on the code.

Then I added --no-pid, --no-fork and --socket-activation options
to make uuidd play nicely with systemd (or any compatible init system should
there be any).  Note that --socket-activation automatically implies all other
mentioned options. With the socket activation mode [3], uuidd is started on
demand when the first request comes to its request socket and quits after 60
seconds of inactivity (can be overridden in the provided unit files).

To make socket-activation work, the uuidd has to be compiled with the
sd-daemon.c files.  This is controlled via the --enable-socket-activation
configure option. The second alternative would be to link with libsystemd
shared library, but after discussion with Karel I decided not to do it to avoid
some build dependency cycles between systemd and util-linux (to make life
easier for distributions).

This series also removes the ability of libuuid to execute uuidd daemon
on-demand if it is not running as we believe that it is not an elegant solution
and it should be rather required that the daemon is started by an initscript or
activated via the socket.

Regarding the last patch in the series, it addresses issue described in
http://marc.info/?l=util-linux-ng&m=133405763330121&w=2 in the way recomended
by Karel. However, after implementing it, I'm wondering: wouldn't it be cleaner
to just test if /dev/u?random exists and is readable in uuid_generate() instead
of calling random_get_fd() and passing the fd down the stack?


For reference, these are the important changes since first version of the series:

- do not implement --keep-privs and instead remove the privilege-dropping
  functionality completely
- removed ability to execute uuidd from libuuid
- server_loop() has been refactored not to use confusing goto statement
- long list of arguments of server_loop() has been avoided by
  encapsulating them in uuidd_ctx structure
- s/--enable-uuidd-socket-activation/--enable-socket-activation
- s/UUIDD_SOCKET_ACTIVATION/USE_SOCKET_ACTIVATION
- no longer mention configure option names in the uuidd manpage
- this series no longer include build-sys fixes (posted as separate series)


Thank you in advance for any feedback and comments.

Thanks,

	Petr

[1] http://marc.info/?l=util-linux-ng&m=133303960414089&w=2
[2] http://www.spinics.net/lists/util-linux-ng/msg05793.html
[3] http://0pointer.de/blog/projects/socket-activation.html



Petr Uzel (15):
  uuidd: use UUIDD_OP_GETPID instead of magic number
  uuidd: remove useless initialization of cleanup_socket
  uuidd: factor out pidfile creation into separate function
  uuidd: implement --no-pid option
  uuidd: use ignore_result helper
  uuidd: implement --no-fork option
  uuidd: factor out socket creation into separate function
  uuidd: implement --socket-activation option
  uuidd: print all debugging information to stderr
  uuidd: do not drop privileges
  libuuid: use EXIT_FAILURE
  uuidd: add systemd unit files
  libuuid: don't exec uuidd
  uuidd: introduce uuidd_cxt to pass arguments to server loop
  libuuid: avoid double open and leaking descriptor

 Makefile.am                 |    3 +-
 configure.ac                |   23 ++
 fdisk/fdiskdoslabel.c       |    2 +-
 include/randutils.h         |    2 +-
 lib/randutils.c             |    8 +-
 libuuid/src/Makefile.am     |    1 -
 libuuid/src/gen_uuid.c      |   65 +-----
 libuuid/src/uuidd.h         |    2 +-
 misc-utils/.gitignore       |    1 +
 misc-utils/Makefile.am      |   17 ++-
 misc-utils/sd-daemon.c      |  530 +++++++++++++++++++++++++++++++++++++++++++
 misc-utils/sd-daemon.h      |  282 +++++++++++++++++++++++
 misc-utils/uuidd.8          |   12 +
 misc-utils/uuidd.c          |  313 +++++++++++++++++---------
 misc-utils/uuidd.service.in |    9 +
 misc-utils/uuidd.socket     |    8 +
 16 files changed, 1109 insertions(+), 169 deletions(-)
 create mode 100644 misc-utils/sd-daemon.c
 create mode 100644 misc-utils/sd-daemon.h
 create mode 100644 misc-utils/uuidd.service.in
 create mode 100644 misc-utils/uuidd.socket

-- 
1.7.7

