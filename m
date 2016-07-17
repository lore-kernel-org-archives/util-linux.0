Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35599 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbcGQNAW (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 17 Jul 2016 09:00:22 -0400
Received: by mail-wm0-f68.google.com with SMTP id i5so8763232wmg.2
        for <util-linux@vger.kernel.org>; Sun, 17 Jul 2016 06:00:21 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 00/13] pull: OCLint static code analysis changes
Date: Sun, 17 Jul 2016 14:00:02 +0100
Message-Id: <20160717130015.31760-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

Just while back I heard first time a tool called OCLint[1] and I decided to
give it a try.  The OCLint seems to print a lot of warnings that do not
appear to that important to address.  It seems the tools is in it best to
find where code is unnecessarily complicated - and the changes are mostly
about improving such segments.  IMHO only the shadowing and libblkid
debugging fixes in this pull request are a little bit more important.

[1] http://oclint.org/

----------------------------------------------------------------
The following changes since commit b8fd5c055889edcefdd97afa2abb35b71e6fa369:
  tests: fix ttyutils test (2016-07-15 10:11:35 +0200)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git oclint
for you to fetch changes up to 5c5e25f2a96c458cd641fbf119c81813d27f1da3:
  libblkid: fix debugging macro [oclint] (2016-07-17 13:49:51 +0100)
----------------------------------------------------------------

Sami Kerola (13):
  misc: simplify if clauses [oclint]
  switch_root: simplify code and reduce indentation [oclint]
  libfdisk: collapse indentation [oclint]
  lslogins: simplify if clause and move definition and comments [oclint]
  libblkid: simplify if clause [oclint]
  logger: simplify if clause [oclint]
  syspriv: flip inverted logic [oclint]
  libmount, look: remove dead code [oclint]
  dmesg: drop core at impossible case in read_buffer() [oclint]
  misc: fix declarations shadowing variables in the global scope [oclint]
  setterm: fix declarations shadowing variables in the global scope [oclint]
  agetty: move unreachable code to pre-processor #else segment [oclint]
  libblkid: fix debugging macro [oclint]

 disk-utils/fsck.c              | 31 +++++++--------
 disk-utils/fsck.cramfs.c       | 11 ++----
 disk-utils/fsck.minix.c        |  7 ++--
 disk-utils/mkfs.cramfs.c       | 15 +++----
 disk-utils/mkfs.minix.c        |  8 +---
 lib/sysfs.c                    |  6 +--
 lib/timeutils.c                |  6 +--
 libblkid/src/probe.c           | 10 ++---
 libblkid/src/superblocks/zfs.c | 32 +++++++--------
 libfdisk/src/dos.c             | 26 ++++++-------
 libfdisk/src/sgi.c             |  5 +--
 libfdisk/src/sun.c             | 48 +++++++++++------------
 libmount/src/context_mount.c   |  1 -
 libmount/src/context_umount.c  |  1 -
 libmount/src/fs.c              |  9 ++---
 libmount/src/utils.c           |  6 +--
 login-utils/last.c             |  6 +--
 login-utils/lslogins.c         | 26 ++++++-------
 login-utils/sulogin.c          |  6 +--
 login-utils/utmpdump.c         |  5 +--
 login-utils/vipw.c             |  7 ++--
 misc-utils/cal.c               |  6 +--
 misc-utils/logger.c            | 62 ++++++++++++++---------------
 misc-utils/look.c              |  2 -
 misc-utils/mcookie.c           |  6 +--
 misc-utils/uuidd.c             |  5 +--
 sys-utils/dmesg.c              | 29 +++++++-------
 sys-utils/ipcrm.c              | 13 +++----
 sys-utils/lsipc.c              |  6 +--
 sys-utils/rtcwake.c            | 15 +++----
 sys-utils/setpriv.c            | 22 +++++------
 sys-utils/setsid.c             |  6 +--
 sys-utils/switch_root.c        | 29 +++++++-------
 term-utils/agetty.c            | 30 +++++++-------
 term-utils/setterm.c           | 88 +++++++++++++++++++++---------------------
 text-utils/hexdump-parse.c     | 15 +++----
 text-utils/tailf.c             |  8 ++--
 37 files changed, 274 insertions(+), 340 deletions(-)

-- 
2.9.0

