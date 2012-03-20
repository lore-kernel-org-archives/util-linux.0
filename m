Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lb0-f174.google.com ([209.85.217.174]:58140 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756192Ab2CTT1D convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 20 Mar 2012 15:27:03 -0400
Received: by lbbgm6 with SMTP id gm6so334570lbb.19
        for <util-linux@vger.kernel.org>; Tue, 20 Mar 2012 12:27:02 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Date: Tue, 20 Mar 2012 20:27:01 +0100
Message-ID: <CAG27Bk3Jrh_22adczBYq77u4p7GqmtUw2ELbABU77j3_4SySvA@mail.gmail.com>
Subject: [pull] chkdupexe, a bug, version numbers and bashisms
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

This pull has couple patches which are worth while to mention.

The first patch reimplements chkdupexe in C.  Whole point of doing
that is to get rid of dependency to perl, as there where nothing else
that needed it.  It is questionable if this version is good enough.
If not perhaps others can chip in get the command better or more
useful.

The setterm patch fixes a bug, which is almost year old
faa0548de47df5691cf56dd49daaba8dbc89d34a and part of couple release.
Sorry.

First of the pg patches changes version number from old cvs(?) line
to config.h version.  I wonder if the G.  Ritter's copyright year
mark up be updated as well?

Finally I started to check shell scripts with checkbashisms.  IMHO
making POSIX bourne shell compliant makes sense, as one cannot know
if /bin/sh is dash (Debian Almquist shell) on some systems.  In best
case the /bin/sh really is dash, and these patches make scripts run
slightly quicker.


The following changes since commit 9895daca9cb9611b6565434d29619f0d28ea9e81:

  fsck: tiny coding style fix (2012-03-20 11:22:09 +0100)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git 2012wk11

for you to fetch changes up to 34337b125ddfa961ccc001dd51c5fb076ff7202a:

  tools: ko-release: make scripts bourne sh compliant [checkbashisms]
(2012-03-20 20:24:42 +0100)

----------------------------------------------------------------
Sami Kerola (31):
      chkdupexe: reimplement command in C
      mountpoint: add --version & align with howto-usage-function.txt
      findmnt: add --version & align with howto-usage-function.txt
      findfs: add --version & align with howto-usage-function.txt
      setterm: correct manual page reference
      partx: add --version option
      addpart: align with util-linux coding standards
      delpart: align with util-linux coding standards
      raw: align with howto-usage-function.txt
      raw: add long options and version printing
      raw: use symbolic exit numbers
      raw: use libc error printing facilities
      raw: use pathnames.h for file locations
      raw: check numeric user inputs
      raw: clean up coding style
      pg: correct version printing in help screen
      pg: align with howto-usage-function.txt
      fsck.cramfs: add long options
      fsck.minix: use symbolic exit codes
      fsck.minix: use rpmatch() for yes/no question
      fsck.minix: align with howto-usage-function.txt
      fsck.minix: clean up coding style
      fsck.minix: fix printf format warning
      swaplabel: add --version and align with howto-usage-function.txt
      fallocate: add --version and align with howto-usage-function.txt
      findmnt: remove dublicate usage() line
      fstrim: add --version and align with howto-usage-function.txt
      reset: make scripts bourne sh compliant [checkbashisms]
      tools: checkconfig.sh: make scripts bourne sh compliant [checkbashisms]
      tools: config-gen: make scripts bourne sh compliant [checkbashisms]
      tools: ko-release: make scripts bourne sh compliant [checkbashisms]

 configure.ac                  |    4 -
 disk-utils/fsck.cramfs.c      |   32 +-
 disk-utils/fsck.minix.c       |  781 ++++++++++++++++++++---------------------
 disk-utils/raw.c              |  266 +++++++-------
 disk-utils/swaplabel.c        |   26 +-
 include/pathnames.h           |    9 +
 misc-utils/Makefile.am        |    6 +-
 misc-utils/chkdupexe.1        |   43 ++-
 misc-utils/chkdupexe.c        |  307 ++++++++++++++++
 misc-utils/chkdupexe.pl       |  120 -------
 misc-utils/findfs.c           |   23 +-
 misc-utils/findmnt.c          |   17 +-
 partx/Makefile.am             |    2 +
 partx/addpart.c               |   78 ++--
 partx/delpart.c               |   73 ++--
 partx/partx.c                 |    6 +-
 sys-utils/fallocate.c         |   21 +-
 sys-utils/fstrim.c            |   21 +-
 sys-utils/mountpoint.c        |   19 +-
 term-utils/reset              |    6 +-
 term-utils/reset.033c         |    2 +-
 term-utils/setterm.c          |    2 +-
 text-utils/pg.c               |   45 ++-
 tools/checkconfig.sh          |    6 +-
 tools/config-gen              |    5 +-
 tools/config-gen-functions.sh |    2 +-
 tools/ko-release-gen          |    8 +-
 tools/ko-release-push         |    2 +-
 28 files changed, 1143 insertions(+), 789 deletions(-)
 create mode 100644 misc-utils/chkdupexe.c
 delete mode 100755 misc-utils/chkdupexe.pl
 mode change 100644 => 100755 term-utils/reset

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
