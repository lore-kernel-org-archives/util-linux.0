Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35404 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932156AbcGCVYD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Jul 2016 17:24:03 -0400
Received: by mail-wm0-f52.google.com with SMTP id z126so21199008wme.0
        for <util-linux@vger.kernel.org>; Sun, 03 Jul 2016 14:24:02 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 00/15] pull: write(1) improvements
Date: Sun,  3 Jul 2016 22:23:43 +0100
Message-Id: <20160703212358.1218-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

This patch set was sent earlier, but because the changes were not merged or
rejected.  So here is a resubmission that I further worked with to improve
quality of the changes with hope this time these will get final verdict.
Old attributions are kept, and more can be added to my git assuming feedback
is given.


----------------------------------------------------------------
The following changes since commit f29bc6e1cc4ed9f76bded543c6ab393f674ec3ed:
  lslocks: add --noinaccessible (2016-07-01 14:45:04 +0200)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git write-improvements
for you to fetch changes up to 6d0f3a2c208917eff769340434a5d736d3f8e57c:
  lib: try to find tty in get_terminal_name() (2016-07-03 22:17:43 +0100)
----------------------------------------------------------------

Sami Kerola (15):
  write: remove unused variable
  write: get rid of function prototypes
  write: remove pointless fileno(3) calls
  write: set atime value in term_chk() only when needed
  write: use xstrncpy() from strutils.h
  write: run atexit() checks at the end of execution
  write: add control structure to clarify what is going on
  write: improve function and variable names
  write: remove unnecessary utmp variables
  write: make timestamp to be obviously just a clock time
  write: remove PUTC macro
  write: improve coding style
  write: tell when effective gid and tty path group mismatch
  write: stop removing and adding /dev/ in front of tty string
  lib: try to find tty in get_terminal_name()

 include/ttyutils.h       |   2 +-
 lib/ttyutils.c           |  15 +-
 login-utils/login.c      |   2 +-
 login-utils/su-common.c  |   4 +-
 term-utils/Makemodule.am |   1 +
 term-utils/write.c       | 418 +++++++++++++++++++++++------------------------
 6 files changed, 218 insertions(+), 224 deletions(-)

-- 
2.9.0

