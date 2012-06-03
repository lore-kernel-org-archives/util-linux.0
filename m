Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:57268 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753731Ab2FCVJr convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Sun, 3 Jun 2012 17:09:47 -0400
Received: by wibhj8 with SMTP id hj8so2248623wib.1
        for <util-linux-ng@vger.kernel.org>; Sun, 03 Jun 2012 14:09:46 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 3 Jun 2012 23:09:46 +0200
Message-ID: <CAG27Bk3Cb0hTp=6J8p8wX-=eNKuXa-rEHQwowTD4QZR8PNm2SA@mail.gmail.com>
Subject: [pull] login utils and manual fixes
From: Sami Kerola <kerolasa@gmail.com>
To: util-linux-ng@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

The pull is mostly about manuals, but there are couple bug fixes as well.

At weekend Dave found issue with xmkstemp, which caused vipw and few
other utilities which change contents of /etc/passwd file to fail if
/tmp was not on same device. The easiest solution we could thing to
fix the issue was to change interface, and allow move to happen within
/etc/ directory.

The other bug is that logindefs got confused when dealing group names
that begin by number. The other logindefs change will disallow users
to specify negative number when they do not make sense.


The following changes since commit 71681ee5ecd24ac19747dc692f2350a212e448e9:

  build-sys: move configure login options to one place (2012-05-29
15:24:04 +0200)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git 2012wk22

for you to fetch changes up to 00388ebc7b8cbe4187ddcf1506679f47a5ac173a:

  docs: clean up getopt.1 manual (2012-06-02 22:39:40 +0200)

----------------------------------------------------------------
Dave Reisner (1):
      fileutils: xmkstemp() interface change

Sami Kerola (10):
      logindefs: change getlogindefs_num() to return unsigned long
      build-sys: add su executable to .gitignore
      login: allow TTYGROUP name begin by number
      docs: clean up login.1 manual
      docs: clean up wdctl.8 manual
      tools: add checkmans.sh
      docs: fix all man page groff warnings
      docs: clean up chcpu.8 manual
      docs: clean up dmesg.1 manual
      docs: clean up getopt.1 manual

 Makefile.am               |    3 +
 disk-utils/fsck.8         |    4 +-
 getopt/getopt.1           |  472 ++++++++++++++++++++++-----------------------
 include/fileutils.h       |    6 +-
 lib/fileutils.c           |   12 +-
 login-utils/.gitignore    |    1 +
 login-utils/login.1       |  276 ++++++++++++++++----------
 login-utils/login.c       |   28 ++-
 login-utils/logindefs.c   |    6 +-
 login-utils/logindefs.h   |    2 +-
 login-utils/setpwnam.c    |    3 +-
 login-utils/su.c          |    2 +-
 login-utils/vipw.c        |    3 +-
 mount/mount.8             |    2 +-
 sys-utils/chcpu.8         |   95 +++++----
 sys-utils/dmesg.1         |  154 ++++++++-------
 sys-utils/ipcmk.1         |    4 +-
 sys-utils/mount.8         |    2 +-
 sys-utils/setarch.8       |    8 +-
 sys-utils/wdctl.8         |   67 ++++---
 term-utils/mesg.1         |    2 +-
 term-utils/scriptreplay.1 |   12 +-
 term-utils/wall.c         |    2 +-
 tools/checkmans.sh        |   75 +++++++
 24 files changed, 705 insertions(+), 536 deletions(-)
 create mode 100755 tools/checkmans.sh

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
