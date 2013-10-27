Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f47.google.com ([74.125.82.47]:38825 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753963Ab3J0Umm (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 27 Oct 2013 16:42:42 -0400
Received: by mail-wg0-f47.google.com with SMTP id c11so5842867wgh.14
        for <util-linux@vger.kernel.org>; Sun, 27 Oct 2013 13:42:40 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [0000/0010] cal: code revisit part I
Date: Sun, 27 Oct 2013 20:42:26 +0000
Message-Id: <1382906556-16442-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel, and others,

I promised earlier to put some effort in making the cal(1) a little bit
less messy.  The patch set begins by adding a structure that contains
what user wants.  Last two changes are hopefully most interesting.  They
add run time configuration that is filled, and used later.

I got the --one and --three outputs working, but I am not completely
happy about the --three.  Quite frankly better function would take input
how many horizontal calendar outputs are needed, and would do exactly
that.  Such function would be more reusable when considering yearly
output, and the fact it has two column output when in julian mode.

Karel, it is be best not to merge the last patch.  It is more of
work-in-progress, comments would be great.


The following changes since commit 433d05ff9afeb4a374943cb35d1b8b19613c8039:

  libfdisk: (gpt) allow to work with hybrid GPT (2013-10-23 16:59:45 +0200)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git cal-ng

for you to fetch changes up to 69e4ed597fb54710cdc3337e3af14aedbc2f481c:

  cal: make cal --three to use content structures (2013-10-27 20:27:49 +0000)

----------------------------------------------------------------
Sami Kerola (10):
      cal: use control structure for run time configuration
      cal: add input variable names to function prototypes
      cal: make day_in_week() use same variable names as other functions
      cal: simplify ascii_wnum() function
      cal: determine output width at beginning of run and reuse result
      tests: cal: take account week numbers when determing month lenght
      cal: make user request to be part of read-only control struct
      cal: determine how many header lines are needed at initialization
      cal: add month contents structure
      cal: make cal --three to use content structures

 misc-utils/cal.c            | 637 +++++++++++++++++++++++++++-----------------
 tests/expected/cal/bigyearw |  12 +-
 2 files changed, 391 insertions(+), 258 deletions(-)


