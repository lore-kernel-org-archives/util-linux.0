Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f181.google.com ([209.85.212.181]:60720 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192Ab3D1RLN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Apr 2013 13:11:13 -0400
Received: by mail-wi0-f181.google.com with SMTP id c10so2069569wiw.2
        for <util-linux@vger.kernel.org>; Sun, 28 Apr 2013 10:11:12 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 00/11] pull: cal(1) spring clean up
Date: Sun, 28 Apr 2013 18:10:56 +0100
Message-Id: <1367169067-23705-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi all,

Occasionally I wonder why cal(1) does not have --week option to include
week numbers to print out.  So I decided to have a closer look of the
cal, and found out that it could made a little cleaner.  These patches
are about that, and hopefully rather uninteresting.  Only patch that has
any implications to users is 0010 which removes of trailing white spaces
from three month print out.

But back to the question.  Would it make sense to try add week number
printing?  It would work much like 'gcal --with-week-number
--iso-week-number=yes', which brings me to next question.  If week
numbers are preferred should both 'standard' and 'iso' week numbers be
implemented?  Hearing that the week numbers are not really needed is also
fine.  It's not often I need such, the feature would be more like 'nice
to have'.


The following changes since commit a48c321dd175d043fb4572bab625631b2055075e:

  textual: fixing typos in a warning and an error message (2013-04-26 13:55:29 +0200)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git 2013wk16

for you to fetch changes up to 0ec2cbe22ef73a0f3b1814a08510c8a30e76ee07:

  cal: move global variables to local scope (2013-04-28 17:55:40 +0100)

----------------------------------------------------------------
Sami Kerola (11):
      cal: fix preprocessor directive indendation
      cal: convert function like definitions to functions
      cal: clean up use of constants
      tests: add calendar reformation check
      cal: simplify calendar reformat calculations
      cal: remove unnecessary initializations
      cal: de-duplicate julian specific functions
      cal: allow day highlight testing
      tests: add cal day highlight corner cases
      cal: trim three month display trailing white spaces
      cal: move global variables to local scope

 misc-utils/Makemodule.am     |   8 +
 misc-utils/cal.c             | 517 +++++++++++++++++++++----------------------
 tests/commands.sh            |   2 +-
 tests/expected/cal/1m        |   8 +-
 tests/expected/cal/3m        |  24 +-
 tests/expected/cal/highlight |  55 +++++
 tests/expected/cal/sep1752   | 198 +++++++++++++++++
 tests/expected/cal/year      |   8 +-
 tests/ts/cal/highlight       |  70 ++++++
 tests/ts/cal/sep1752         |  95 ++++++++
 10 files changed, 702 insertions(+), 283 deletions(-)
 create mode 100644 tests/expected/cal/highlight
 create mode 100644 tests/expected/cal/sep1752
 create mode 100755 tests/ts/cal/highlight
 create mode 100755 tests/ts/cal/sep1752


