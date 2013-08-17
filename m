Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f41.google.com ([74.125.82.41]:35532 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018Ab3HQSPb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 17 Aug 2013 14:15:31 -0400
Received: by mail-wg0-f41.google.com with SMTP id l18so2098618wgh.2
        for <util-linux@vger.kernel.org>; Sat, 17 Aug 2013 11:15:30 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 00/16] pull: additions recent to last(1) work, plus few small changes
Date: Sat, 17 Aug 2013 19:15:05 +0100
Message-Id: <1376763321-22782-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel and others,

This patch set is mostly about last(1), which was recently undeprecated.
Many of the following patches are direct reactions to that change, while,
especially at the end of the patch set, others are more of a enhancements
of the last(1).  With that I mean mostly about patches 0013, 0015, and
0016, which may or may not be how this command should behave.  IMHO the
--present option from 0016 is most useful of these feature like changes.

Any/everyone; comments, proposal, etc feedback is welcome, as usual.


The following changes since commit 7f1fe74248290c50f5447c2c09fcf0f0575a7666:

  build-sys: remove deprecated elvtune command (2013-08-13 15:55:52 +0200)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git 2013wk32

for you to fetch changes up to 7c3160f91491d5edc793f03077fa4ba3db5ff440:

  last: add --present option (2013-08-17 16:43:45 +0100)

----------------------------------------------------------------
Sami Kerola (16):
      build-sys: remove unnecessary environment variable
      docs: update TODO
      build-sys: complete elvtune removal
      docs: be clear which last(1) is deprecated
      docs: add long options to last.1 manual page
      include: carefulput: print determined char when unprintable char is found
      last: use carefulput() for printable character output
      last: check expected numeric user input is number
      last: make switch cases complete, and inform if impossible occurs
      last: prefer enum rather than #definition list
      last: remove broken code
      last: use as narrow variable scoping as possible
      last: use ISO 8601 time format for --fulltimes
      last: global variables are initialize automatically to zero
      last: allow --file to be defined multiple times
      last: add --present option

 .gitignore                   |   1 -
 Documentation/TODO           |   5 -
 Documentation/deprecated.txt |   7 +-
 autogen.sh                   |   1 -
 include/carefulputc.h        |   4 +-
 login-utils/Makemodule.am    |   2 +-
 login-utils/last.1           | 184 +++++++++++++----------
 login-utils/last.c           | 340 +++++++++++++++++++++++--------------------
 term-utils/wall.c            |   2 +-
 term-utils/write.c           |   2 +-
 10 files changed, 292 insertions(+), 256 deletions(-)

