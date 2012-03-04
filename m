Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:42169 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754236Ab2CDNfG convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 4 Mar 2012 08:35:06 -0500
Received: by obbuo6 with SMTP id uo6so3193616obb.19
        for <util-linux@vger.kernel.org>; Sun, 04 Mar 2012 05:35:05 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Date: Sun, 4 Mar 2012 14:35:05 +0100
Message-ID: <CAG27Bk1Lm57u2wX0LQFWhvo8kanpOF6YSt_UgsSuuOcfB1LxPg@mail.gmail.com>
Subject: [pull] fixes to todo items etc
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

This pull request is mostly uninteresting. There are perhaps two
changes which are worthwhile to announce. User database editing will
use libc function go acquire exclusive lock at the time of edits. This
should protect util-linux software clashing, which other projects
which are editing same files. The second more notable change is
chkdupexe regression fix.


The following changes since commit 6699e742f238d4bc15ac396dd56f0df1480bd36c:

  libmount: add mnt_fs_streq_target() and export all mnt_fs_streq_*
(2012-03-02 15:53:55 +0100)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git 2012wk9

for you to fetch changes up to 72544ad04922fad6c164b51262cad56986c12ebd:

  build-sys: fix chkdupexe regression (2012-03-04 14:31:39 +0100)

----------------------------------------------------------------
Sami Kerola (17):
      docs: add deprecation comments
      docs: TODO removal, login-utils error printing
      sfdisk: use rpmatch to yes/no question
      mesg: use rpmatch to yes/no question
      vipw: use rpmatch to yes/no question
      docs: TODO removal, rpmatch task is done
      chfn: use pathnames.h for paths
      chsh: use pathnames.h for paths
      lib: add fileutils function collection
      wall: use xmkstemp for temporary file
      setpwnam: use xmkstemp() and lckpwdf()
      vipw: use xmkstemp() and lckpwdf()
      pathnames: clean up various user database tmp paths
      docs: TODO removal, ldattach usage is done
      include: add asprintf wrapper
      xalloc: use xasprintf in all files
      build-sys: fix chkdupexe regression

 Documentation/TODO             |   11 -----
 configure.ac                   |    3 ++
 disk-utils/elvtune.c           |    9 ++++
 disk-utils/fsck.cramfs.c       |    2 +-
 fdisk/sfdisk.c                 |   19 ++++----
 include/Makefile.am            |    5 +-
 include/fileutils.h            |    6 +++
 include/pathnames.h            |   12 +----
 include/xalloc.h               |   11 +++++
 lib/Makefile.am                |    2 +
 lib/fileutils.c                |   56 ++++++++++++++++++++++
 login-utils/Makefile.am        |    6 ++-
 login-utils/chfn.c             |    4 +-
 login-utils/chsh.c             |   22 ++++-----
 login-utils/last.c             |    9 ++++
 login-utils/newgrp.c           |    9 ++++
 login-utils/setpwnam.c         |   51 +++++++-------------
 login-utils/setpwnam.h         |   39 ++++-----------
 login-utils/vipw.8             |    1 +
 login-utils/vipw.c             |  103 +++++++++++++++++-----------------------
 misc-utils/findmnt.c           |    7 +--
 misc-utils/lsblk.c             |    2 +-
 misc-utils/namei.c             |    2 +-
 partx/partx.c                  |   14 +++---
 sys-utils/arch.c               |    9 ++++
 sys-utils/lscpu.c              |    2 +-
 sys-utils/mount.c              |    2 +-
 sys-utils/prlimit.c            |   12 ++---
 term-utils/Makefile.am         |    2 +-
 term-utils/mesg.c              |   14 ++++--
 term-utils/wall.c              |   19 ++------
 tests/expected/paths/built-in  |    8 ----
 tests/helpers/test_pathnames.c |    8 ----
 text-utils/line.c              |    9 ++++
 34 files changed, 261 insertions(+), 229 deletions(-)
 create mode 100644 include/fileutils.h
 create mode 100644 lib/fileutils.c

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
