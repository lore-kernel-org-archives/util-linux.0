Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f174.google.com ([209.85.212.174]:63827 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbbBVOlz (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:41:55 -0500
Received: by mail-wi0-f174.google.com with SMTP id em10so11834580wid.1
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:41:54 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 00/16] pull: changes to various utils
Date: Sun, 22 Feb 2015 14:41:30 +0000
Message-Id: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

Here is collection of patches that hit various utilities all around
source tree, and do not have any particular theme.  These changes are
also available from my github remote repository.

 git://github.com/kerolasa/lelux-utiliteetit.git various

Sami Kerola (16):
  whereis: tell when mandatory option is missing
  flock: add --verbose option
  flock: improve timeout handling
  prlimit: tell in --verbose output which pid got the new limit
  tunelp: remove get_val() in favour of strtol_or_err()
  tunelp: remove unnecessary preprocessor directives
  lib/strutils: move parse_switch() from setterm(1) to library
  tunelp: use parse_switch()
  eject: use parse_switch()
  rpmatch: use symbolic value when evaluation return codes
  tailf: check printing criteria more carefully
  tailf: count last lines correctly at initial print out
  tailf: do not allow minus signed last lines argument
  tailf: ensure file argument really is a file
  logger: move /dev/log to pathnames.h
  logger: fix -i argument parsing regression

 disk-utils/fdisk.c      |   2 +-
 disk-utils/fsck.minix.c |   6 +--
 disk-utils/sfdisk.c     |   2 +-
 include/Makemodule.am   |   1 -
 include/pathnames.h     |   3 ++
 include/rpmatch.h       |   4 ++
 include/strutils.h      |   2 +
 include/timer.h         |  31 -----------
 lib/strutils.c          |   8 +++
 login-utils/vipw.c      |   2 +-
 misc-utils/logger.1     |   5 +-
 misc-utils/logger.c     |  16 ++++--
 misc-utils/whereis.c    |   8 ++-
 sys-utils/Makemodule.am |   5 +-
 sys-utils/eject.c       |  14 +----
 sys-utils/flock.1       |   4 ++
 sys-utils/flock.c       |  82 +++++++++++++++++++++++++----
 sys-utils/prlimit.c     |   3 +-
 sys-utils/tunelp.c      |  51 +++++-------------
 term-utils/mesg.c       |   6 +--
 term-utils/setterm.c    |  14 -----
 text-utils/tailf.c      | 135 ++++++++++++++++++++++++++++--------------------
 22 files changed, 224 insertions(+), 180 deletions(-)
 delete mode 100644 include/timer.h

-- 
2.3.0

