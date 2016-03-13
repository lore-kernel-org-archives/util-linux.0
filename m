Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36444 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191AbcCMKby (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Mar 2016 06:31:54 -0400
Received: by mail-wm0-f67.google.com with SMTP id l68so9996115wml.3
        for <util-linux@vger.kernel.org>; Sun, 13 Mar 2016 03:31:53 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 00/10] pull: release v2.28 prep work
Date: Sun, 13 Mar 2016 10:31:39 +0000
Message-Id: <1457865109-2881-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

Changes in this pull request are mostly resubmissions with fixes (bash
completion stuff).  There are also some ASAN & valgrind fixes to correct
issues found running test-suite.


----------------------------------------------------------------
The following changes since commit 8c97556ecfc0af358d35dc7a842aaadde5eeafd3:
  build-sys: release++ (v2.28-rc1) (2016-03-11 11:41:05 +0100)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git v2.28-prep
for you to fetch changes up to 3f2c19ff39a616c192b3a0dfb8a985a0f156e588:
  docs: update AUTHORS file (2016-03-13 10:23:00 +0000)
----------------------------------------------------------------

Sami Kerola (10):
  logger: fix memory leak [ASAN and valgrind]
  getopt: fix memory leaks and integer overflows [ASAN & valgrind]
  lsipc, lslogins, rtcwake: replace asctime() with strftime()
  isosize: stop unmeaningful printing errno message
  setsid: fix argument count bug
  bash-completion: fsck.cramfs, isosize: find files an argument
  bash-completion: ipcmk: add missing completion file
  bash-completion: lslogins: add missing completion file
  bash-completion: lsns: add missing completion file
  docs: update AUTHORS file

 AUTHORS                       |  2 +-
 bash-completion/Makemodule.am |  9 +++++
 bash-completion/fsck.cramfs   | 11 +++++--
 bash-completion/ipcmk         | 27 +++++++++++++++
 bash-completion/isosize       | 11 +++++--
 bash-completion/lslogins      | 76 +++++++++++++++++++++++++++++++++++++++++++
 bash-completion/lsns          | 56 +++++++++++++++++++++++++++++++
 disk-utils/isosize.c          |  2 +-
 include/timeutils.h           |  3 ++
 login-utils/lslogins.c        |  5 ++-
 misc-utils/getopt.c           | 36 +++++++++++++++-----
 misc-utils/logger.c           |  4 ++-
 sys-utils/lsipc.c             |  6 ++--
 sys-utils/rtcwake.c           | 15 +++++----
 sys-utils/setsid.c            |  2 +-
 15 files changed, 236 insertions(+), 29 deletions(-)
 create mode 100644 bash-completion/ipcmk
 create mode 100755 bash-completion/lslogins
 create mode 100644 bash-completion/lsns

-- 
2.7.2

