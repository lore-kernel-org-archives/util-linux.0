Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37562 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762Ab3KJSXv (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 10 Nov 2013 13:23:51 -0500
Received: by mail-wi0-f177.google.com with SMTP id hq4so903549wib.16
        for <util-linux@vger.kernel.org>; Sun, 10 Nov 2013 10:23:50 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 00/13] pull: cal: code revisit part I try II
Date: Sun, 10 Nov 2013 18:23:27 +0000
Message-Id: <1384107820-498-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel and others,

You might remember attempt to refactor cal(1) from couple weeks.

http://www.spinics.net/lists/util-linux-ng/index.html#08443

This patch set / pull request is fairly similar to previous.  Difference
are with variable and function naming, and output generator and printout
routines.  Essentially the changes proposed by Karel should at least
partly done, and I am happy that the code quality clearly increased in
between tries.

Notice that this is 'revist part I'.  These changes will allow new
features, such as variable number horizontal calendar outputs, and
printout of user defined calendar months that cross year boundaries.  I
do not think I will have time to work with these feature before end of
the month.  I am perfectly ok if if someone does the next stuff, but if
not I'll have a look of that about in December.


The following changes since commit 5dc242cc97b2323c2540a7f13be72c678f0b6b58:

  tests: update blkid swap tests (2013-11-08 14:22:35 +0100)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git cal-ng

for you to fetch changes up to 543a04eb8db8ddf74da1c5ec044d5df83f1f2f17:

  cal: use month contents structure for --year printing (2013-11-10 18:20:27 +0000)

----------------------------------------------------------------
Sami Kerola (13):
      cal: use control structure for run time configuration
      cal: rename ascii_wnum() to ascii_weeknum()
      cal: add input variable names to function prototypes
      cal: make day_in_week() use same variable names as other functions
      cal: simplify ascii_weeknum() function
      cal: determine output width at beginning of run and reuse result
      tests: cal: take account week numbers when determing month lenght
      cal: make user request to be part of read-only control struct
      tests: cal: do not let --week=<num> to adjust requested month
      cal: determine how many header lines are needed at initialization
      cal: add month contents structure
      cal: use month contents structure for --three printing
      cal: use month contents structure for --year printing

 misc-utils/cal.c            | 781 ++++++++++++++++++++------------------------
 tests/expected/cal/bigyearw |  12 +-
 tests/expected/cal/weekarg  |  84 ++---
 3 files changed, 405 insertions(+), 472 deletions(-)

