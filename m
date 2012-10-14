Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:39673 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753548Ab2JNUVP (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Oct 2012 16:21:15 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so2680278wey.19
        for <util-linux@vger.kernel.org>; Sun, 14 Oct 2012 13:21:14 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 00/19] compliancy fixes
Date: Sun, 14 Oct 2012 21:20:51 +0100
Message-Id: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel and others.

Here comes few patches.  This week I have done a little bit tidying up
from standards compliancy point of view.

The MAXHOSTNAMELEN are retiring static definition, and takes
sysconf(_SC_HOST_NAME_MAX) in use.  This make sense because sysconf() and
gethostname() are a pair, the later promises not to exceed what sysconf()
tells maximum to be.  Also if the allocated hostname string has space for
maximum + 1 char the gethostname() will null-terminate the string without
exceptions.

Manual fix is trivial, as well as sd-daemon fix.

The usleep(), index(), rindex(), gethostbyname() and utime() are all
found with cppcheck to be obsolete.  Here are Open Group notes.

http://pubs.opengroup.org/onlinepubs/9699919799/xrat/V4_xsh_chap01.html#tag_22_01_01_04

Couple of these compliancy fixes are making code, and programs, a little
better.  For example I think after patch 0008 libmount is more readable,
and patch 0016 makes logger to allow IPv6 communications plus user to
define port by using /etc/service name.  That said some other patches in
this lot, such as 0019, does not add any other value than compliancy.


The following changes since commit dc3ea1335696434863c9ef4376858dcd4df6ec1b:

  libmount: fix umount file.img (2012-10-05 20:38:49 +0200)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git 2012wk41

for you to fetch changes up to 1081291888c800572615b7d4fc27ad65af05ad1d:

  fsck.cramfs: replace utime() with utimensat() (2012-10-13 15:50:22 +0100)

----------------------------------------------------------------
Sami Kerola (19):
     1  last: stop using MAXHOSTNAMELEN
     2  login: stop using MAXHOSTNAMELEN
     3  write: stop using MAXHOSTNAMELEN
     4  agetty: stop using MAXHOSTNAMELEN
     5  c.h: remove unnecessary MAXHOSTNAMELEN fallback definition
     6  docs: add line breaks to whereis.1
     7  sd-daemon: fix cppcheck warnings
     8  libmount: replace usleep with nanosleep
     9  include/all-io: replace usleep with nanosleep
    10  hwclock: replace usleep with nanosleep
    11  rtcwake: replace usleep with nanosleep
    12  agetty: replace usleep with nanosleep
    13  tailf: replace usleep with nanosleep
    14  include/usleep: remove remaining references to usleep
    15  libmount, eject: replace index() and rindex() with strrch() or strrchr()
    16  logger: replace gethostbyname() with getaddrinfo()
    17  agetty: replace gethostbyname() with getaddrinfo()
    18  build-sys: remove gethostbyname() check
    19  fsck.cramfs: replace utime() with utimensat()

 configure.ac             |  5 -----
 disk-utils/fsck.cramfs.c |  7 +++---
 include/Makemodule.am    |  1 -
 include/all-io.h         | 17 ++++++++++----
 include/c.h              | 11 ---------
 include/usleep.h         | 18 ---------------
 libmount/src/lock.c      | 16 ++++++++-----
 libmount/src/tab_parse.c |  4 ++--
 login-utils/last.c       | 19 +++++++---------
 login-utils/login.c      |  8 +++----
 misc-utils/logger.c      | 34 ++++++++++++++--------------
 misc-utils/sd-daemon.c   |  8 +++----
 misc-utils/whereis.1     |  4 ++--
 mount-deprecated/fstab.c |  1 -
 sys-utils/eject.c        |  2 +-
 sys-utils/hwclock-kd.c   |  6 +++--
 sys-utils/rtcwake.c      |  6 +++--
 term-utils/agetty.8      |  2 +-
 term-utils/agetty.c      | 58 +++++++++++++++++++++++++++++++++++-------------
 term-utils/write.c       |  7 ++++--
 text-utils/tailf.c       |  7 ++++--
 21 files changed, 126 insertions(+), 115 deletions(-)
 delete mode 100644 include/usleep.h


