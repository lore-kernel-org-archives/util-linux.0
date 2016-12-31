Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wj0-f194.google.com ([209.85.210.194]:36043 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754776AbcLaVlN (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 31 Dec 2016 16:41:13 -0500
Received: by mail-wj0-f194.google.com with SMTP id j10so64697311wjb.3
        for <util-linux@vger.kernel.org>; Sat, 31 Dec 2016 13:41:12 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: pull: hwclock 27 changes
Date: Sat, 31 Dec 2016 21:41:07 +0000
Message-Id: <20161231214107.8658-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Good New Year,

Most of the changes in this pull request has been lying in my git repo for
few months, and now when 2016 is coming to an end I had a look what
unsubmitted work there is.  After reviewing my changes, and improving some
of them modestly, these are now ready for review.

----------------------------------------------------------------

The following changes since commit 963f7dfb82d44661d76c6fb61fda309b846726ce:

  Merge branch 'getrandom' of git://github.com/kerolasa/lelux-utiliteetit (2016-12-22 15:27:25 +0100)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git hwclock

for you to fetch changes up to c7a8f56920c738a90038cd6baaaec676c642b926:

  hwclock: remove trailing dot from messages that include system error message (2016-12-31 21:29:27 +0000)

----------------------------------------------------------------
Sami Kerola (27):
      hwclock: remove UTC-0 localization hack
      lib: add timegm() portability function to lib/timeutils.c
      hwclock: remove FLOOR macro
      hwclock: remove hwclock_exit() indirection
      hwclock: do not hardcode date command magic string twice
      hwclock: remove unnecessary type casts
      hwclock: move command-line options to control structure
      hwclock: clarify set_cmos_epoch() code
      hwclock: move error messages to determine_clock_access_method()
      docs: add instructions how to avoid alpha epoc Y2020 bug
      hwclock: remove dead code and other minor fixes
      hwclock: simplify save_adjtime() execution flow
      hwclock: alloate date_resp parsing buffer in interpret_date_string()
      hwclock: initialize struct adjtime members
      hwclock: use symbolic magic values passed in between functions
      hwclock: remove magic constants from interpret_date_string()
      hwclock: add debugging to open_rtc()
      hwclock: remove division by zero [asan]
      hwclock: use integer arithmetics in compare_clock()
      docs: deprecate hwclock --compare option
      hwclock: improve coding style
      hwclock: stream line synchronize_to_clock_tick_rtc()
      hwclock: try RTCGET and RTCSET only when normal rtc fails
      hwclock: clarify cmos inb and outb preprocessor directives
      hwclock: fix rtc atexit registration
      hwclock: make --date=argument less prone to injection
      hwclock: remove trailing dot from messages that include system error message

 configure.ac             |   1 +
 include/pathnames.h      |   4 +
 include/timeutils.h      |   4 +
 lib/timeutils.c          |  19 ++
 login-utils/utmpdump.c   |   1 +
 sys-utils/hwclock-cmos.c | 228 +++++++------
 sys-utils/hwclock-rtc.c  | 221 ++++++------
 sys-utils/hwclock.8.in   |  11 +
 sys-utils/hwclock.c      | 874 +++++++++++++++++++++--------------------------
 sys-utils/hwclock.h      |  71 +++-
 10 files changed, 702 insertions(+), 732 deletions(-)
