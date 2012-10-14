Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:56691 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754394Ab2JNUW3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Oct 2012 16:22:29 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so3908587wgb.1
        for <util-linux@vger.kernel.org>; Sun, 14 Oct 2012 13:22:28 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 00/13] make ipcs to use proc
Date: Sun, 14 Oct 2012 21:22:12 +0100
Message-Id: <1350246145-10600-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel and others.

Couple weeks ago I decided to do the ipcs todo item, and today patches
got to be ready enough so that I could make final polishing and send them
for review.

The ipcs is still pretty messy.  Partly the mess arises from my decision
to keep various ipc info mechanisms as fallback when /proc or /sys is
missing.  And then again there are couple values which the ipc does not
seem to expose without calling good ol' multiplexer.

As the change is quite large I assume there has to be few bugs.  None of
the where intentional, so having multiple people testing is preferable. 


The following changes since commit 71b161ea37c57dc6a8341aeec6c0c2ae7cd4cfe3:

  build-sys: clean update-potfiles script (2012-10-10 14:10:30 +0200)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git ipcs

for you to fetch changes up to b6700fc1b733ebe44612d52e4bd649dc8dfd85be:

  docs: update TODO (2012-10-14 20:56:10 +0100)

----------------------------------------------------------------
Sami Kerola (13):
      ipcs: add data structures to read state from /proc & /sys
      ipcs: add /proc and /sys path definitions
      ipcs: determine ipc limits from /proc
      ipcs: add new permissions printing function
      ipcs: read shared memory values from /proc
      ipcs: read message queue values from /proc
      ipsc: read semaphore values from /proc
      ipcs: clean up permissions printing
      ipcs: make individual shared memory id printing to use /proc
      ipcs: make individual message queue id printing to use /proc
      ipcs: make individual semaphore id printing to use /proc
      ipcs: validate numeric user input
      docs: update TODO

 Documentation/TODO      |   4 -
 include/pathnames.h     |  11 +
 sys-utils/Makemodule.am |   2 +-
 sys-utils/ipcs.c        | 913 ++++++++++++++++++++++++++++++++++++------------
 4 files changed, 711 insertions(+), 219 deletions(-)

