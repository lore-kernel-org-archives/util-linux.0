Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59463 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524Ab1FMPNx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 13 Jun 2011 11:13:53 -0400
Received: by ewy4 with SMTP id 4so1634503ewy.19
        for <util-linux@vger.kernel.org>; Mon, 13 Jun 2011 08:13:52 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: =?UTF-8?q?Pentecost=20weekend=20pull=20request?=
Date: Mon, 13 Jun 2011 17:13:50 +0200
Message-Id: <1307978030-13006-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel et.al.

I feel a bit embarrassed to see how many patches I wrote. My
excuse is long, mostly rainy, weekend. Here comes a pull request;

[01/33] mount: take xalloc.h in use
        Basiclly code reuse.

[02/33] checktty: NGROUP -> sysconf
        This patch was sent earlier, see details bellow.

        date    Thu, Jun 9, 2011 at 21:31
        subject Re: [PATCH 3/6] checktty: Use NGROUPS_MAX instead of NGROUPS

[03/33] checktty: fix unused parameters
        Ditto.

[04/33] login-utils: include fix
        Inspired what Pádraig Brady did with coreutils I thought
        to give a shot to include-what-you-use as well.
        http://lists.gnu.org/archive/html/coreutils/2011-06/msg00004.html

        The utility clearly works. So it is a good time to think
        if checking headers in all files should be TODO item?

[05/33] namei: add --version option
[06/33] namei: use xalloc.h
[07/33] namei: fix to argument handling
        The namei patches are trivial.

[08/33] mcookie: use warnx, long options and help screen
[09/33] docs: inform about mcookie long options
[10/33] mcookie: change coding style
        The mcookie patches are trivial, with exception of docs
        change. Updating manual pages with help2man seems to be
        quite good idea. Using the output as is is pretty brain
        dead idea, but copy pasting bits of syntax etc seems to
        work great. Is this an approach you would like to see in
        future?

[11/33] whereis: maintenance fixes
[12/33] cal: maintenance fixes
[13/33] docs: inform about cal long options
        Trivial changes.

[14/33] rename: verbose option & maintenance fixes
[15/33] docs: rename.1 verbose, long options and warning
        Looking the code this utility seems to be in wrong
        package. Rewriting the command to rely heavily on gnulib
        copy.h and backupfile.h would make this to be good
        addition to coreutils, assuming they accept the command.
        Or it could time to deprecate the whole command, and
        recommend users to multimove by using scripts.

[16/33] misc-utils: remove misleading README files
[17/33] build-sys: move write to term-utils directory
        Maintainer style activities.

[18/33] write: maintenance fixes
[19/33] wipefs: add version printing & compiler warning
[20/33] uuidgen: add long options
[21/33] docs: uuidgen.1 mention long options
[22/33] uuid: define UUID_STR_LEN in uuid.h
[23/33] uuidd: maintenance fixes
[24/33] docs: mention long options in uuidd.8 manual page
[25/33] look: add long options
[26/33] docs: look.1 manual rewrote
        Trivial changes.

[27/33] getopt: use xalloc.h
        Resubmission of getopts maintenance, see 
        http://permalink.gmane.org/gmane.linux.utilities.util-linux-ng/3822

[28/33] getopt: remove unnecessary free()
        Trivial change.

[29/33] getopt: make user getopt_long parsing to use function pointer
        Without this the 33/33 would look unreadable at the point
        where the function pointer is used.

[30/33] build-sys: remove unnecessary files from getopt
[31/33] getopt: options struct, usage and version outputs
[32/33] getopt: inform where to send bug reports
        I wonder should the config.h PACKAGE_BUGREPORT be
        util-linux mail list...

[33/33] getopt: fix coding style
        Trivial change.

---

The following changes since commit 42fe2b2b2d19d09241bd7c3dd811463e0095d4aa:

  Merge branch 'master', remote-tracking branch 'upstream/master' (2011-06-11 10:10:01 +0200)

are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git wknd23

 disk-utils/mkswap.c                |    2 +-
 getopt/Makefile.am                 |    3 +-
 getopt/getopt-1.1.3.lsm            |   16 --
 getopt/getopt-test.bash            |    6 -
 getopt/getopt-test.tcsh            |    7 -
 getopt/getopt.c                    |  514 ++++++++++++++++++------------------
 include/xalloc.h                   |   23 ++
 libuuid/src/tst_uuid.c             |    2 +-
 libuuid/src/uuid.h                 |    3 +
 login-utils/checktty.c             |   32 ++-
 login-utils/islocal.c              |    2 +-
 misc-utils/.gitignore              |    1 -
 misc-utils/Makefile.am             |   21 +--
 misc-utils/README.flushb           |    5 -
 misc-utils/README.namei2           |   14 -
 misc-utils/README.reset            |   20 --
 misc-utils/cal.1                   |   94 ++++----
 misc-utils/cal.c                   |  166 +++++++-----
 misc-utils/look.1                  |  121 ++++-----
 misc-utils/look.c                  |   51 +++-
 misc-utils/mcookie.1               |   27 ++-
 misc-utils/mcookie.c               |  267 +++++++++++--------
 misc-utils/namei.1                 |    4 +
 misc-utils/namei.c                 |   47 ++--
 misc-utils/rename.1                |   36 ++-
 misc-utils/rename.c                |   93 +++++---
 misc-utils/uuidd.8                 |   88 +++----
 misc-utils/uuidd.c                 |  114 +++++---
 misc-utils/uuidgen.1               |   14 +-
 misc-utils/uuidgen.c               |   38 +++-
 misc-utils/whereis.c               |  141 +++++++----
 misc-utils/wipefs.c                |   13 +-
 mount/Makefile.am                  |    2 +-
 mount/devname.c                    |    3 +-
 mount/fstab.c                      |    4 +-
 mount/lomount.c                    |    4 +-
 mount/mount.c                      |    4 +-
 mount/mount_mntent.c               |    3 +-
 mount/sundries.c                   |   18 +--
 mount/sundries.h                   |    7 +-
 mount/umount.c                     |    3 +-
 mount/xmalloc.c                    |   48 ----
 mount/xmalloc.h                    |   14 -
 term-utils/.gitignore              |    1 +
 term-utils/Makefile.am             |   14 +-
 {misc-utils => term-utils}/write.1 |    0
 {misc-utils => term-utils}/write.c |  215 ++++++++-------
 47 files changed, 1236 insertions(+), 1089 deletions(-)
 delete mode 100644 getopt/getopt-1.1.3.lsm
 delete mode 100755 getopt/getopt-test.bash
 delete mode 100755 getopt/getopt-test.tcsh
 delete mode 100644 misc-utils/README.flushb
 delete mode 100644 misc-utils/README.namei2
 delete mode 100644 misc-utils/README.reset
 delete mode 100644 mount/xmalloc.c
 delete mode 100644 mount/xmalloc.h
 rename {misc-utils => term-utils}/write.1 (100%)
 rename {misc-utils => term-utils}/write.c (67%)

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
