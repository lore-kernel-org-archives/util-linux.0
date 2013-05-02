Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f176.google.com ([74.125.82.176]:59139 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760354Ab3EBSvr (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 2 May 2013 14:51:47 -0400
Received: by mail-we0-f176.google.com with SMTP id r6so721043wey.7
        for <util-linux@vger.kernel.org>; Thu, 02 May 2013 11:51:46 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 00/16]: [pull] cal: second review round
Date: Thu,  2 May 2013 19:51:25 +0100
Message-Id: <1367520701-14962-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello all,

Here comes cal(1) patch series II.  There is a lot of similarities, and
some changes since last submission.  The previous patch series is still
available in my git (branch 2013wk16), which should make comparing every
single small detail quite trivial.  IMHO the most significant changes in
between the two submissions are:

o Copy argmatch.h and argmatch.c from gnulib to util-linux.
o Add --highlight={never,auto,always} option.
o Add new option to usage(), and clean it up.
o Remove trailing space trimming.

All the changes are based on feedback from Pádraig, Thomas, Dave, and
Karel.  Thank you for pointing me to correct direction, and please have
look if I'm still a bit lost.


The following changes since commit a48c321dd175d043fb4572bab625631b2055075e:

  textual: fixing typos in a warning and an error message (2013-04-26 13:55:29 +0200)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git cal-new

for you to fetch changes up to 2b491019173dc2eda3a0d014e9adb3dec54e41bc:

  cal: simplify day_in_week() (2013-05-02 19:30:16 +0100)

----------------------------------------------------------------
Sami Kerola (16):
      cal: fix preprocessor directive indendation
      cal: convert function like definitions to functions
      cal: clean up use of constants
      tests: add calendar reformation check
      cal: simplify calendar reformat calculations
      cal: remove unnecessary initializations
      cal: de-duplicate julian specific functions
      lib: copy argmatch from gnulib
      cal: add --highligth option which uses argmatch
      cal: add --highlight to usage()
      docs: cal: add --highlight option description
      tests: add cal day highlight corner cases
      cal: stop trimming whitespaces
      cal: move global variables to local scope
      cal: mark all functions static
      cal: simplify day_in_week()

 include/Makemodule.am        |   1 +
 include/argmatch.h           | 100 ++++++++
 lib/Makemodule.am            |   1 +
 lib/argmatch.c               | 272 ++++++++++++++++++++
 misc-utils/Makemodule.am     |   2 +-
 misc-utils/cal.1             |  13 +
 misc-utils/cal.c             | 597 ++++++++++++++++++++++---------------------
 tests/expected/cal/1m        |  48 ++--
 tests/expected/cal/3m        |  48 ++--
 tests/expected/cal/highlight |  55 ++++
 tests/expected/cal/sep1752   | 198 ++++++++++++++
 tests/expected/cal/year      | 240 ++++++++---------
 tests/ts/cal/highlight       |  70 +++++
 tests/ts/cal/sep1752         |  95 +++++++
 14 files changed, 1274 insertions(+), 466 deletions(-)
 create mode 100644 include/argmatch.h
 create mode 100644 lib/argmatch.c
 create mode 100644 tests/expected/cal/highlight
 create mode 100644 tests/expected/cal/sep1752
 create mode 100755 tests/ts/cal/highlight
 create mode 100755 tests/ts/cal/sep1752


