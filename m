Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:63687 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753677AbcLAIwQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 1 Dec 2016 03:52:16 -0500
Received: from tenfore.ga-group.nl ([217.186.11.144]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0Lp8h6-1cfwcL03Ea-00epqu for <util-linux@vger.kernel.org>; Thu, 01 Dec 2016
 09:52:13 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 00/11] switch to utmpx.h
Date: Thu,  1 Dec 2016 09:52:03 +0100
Message-Id: <1480582332-17407-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

We want to use utmpx instead of utmp becuase it's POSIX.

The first commits of this patch-set are mostly simple cleanup. Then the
final switch to utmpx.h is just renaming work.

Ruediger Meier (11):
  last: include libgen.h for basename(3p)
  login-utils: remove _HAVE_UT_TV fallback
  lslogins: remove useless strlen()
  utmpdump: code formatting for readability
  login-utils: avoid using the defined utmp sizes.
  login: re-add lastlog.h header
  agetty: remove obsolete HAVE_UPDWTMP fallback
  login-utils: switch to utmpx.h
  build-sys: check for POSIX utmpx usage
  travis: let OSX auto-skip utmpx tools
  agetty: re-add utmp.h for Debian GNU/kFreeBSD

 .travis-functions.sh           |  8 -----
 configure.ac                   | 33 +++++++++++------
 include/pathnames.h            |  2 --
 login-utils/last.c             | 81 +++++++++++++++++++++---------------------
 login-utils/login.c            | 52 ++++++++++-----------------
 login-utils/lslogins.c         | 34 ++++++++----------
 login-utils/su-common.c        | 14 ++------
 login-utils/utmpdump.c         | 26 +++++++-------
 term-utils/agetty.c            | 57 +++++++++++------------------
 term-utils/wall.c              |  8 ++---
 term-utils/write.c             | 24 ++++++-------
 tests/expected/paths/built-in  |  1 -
 tests/helpers/test_pathnames.c |  1 -
 13 files changed, 147 insertions(+), 194 deletions(-)

-- 
1.8.5.6

