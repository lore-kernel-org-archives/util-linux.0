Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38823 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbaIFLY6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 6 Sep 2014 07:24:58 -0400
Received: by mail-wi0-f180.google.com with SMTP id ex7so559955wid.1
        for <util-linux@vger.kernel.org>; Sat, 06 Sep 2014 04:24:56 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 0/6] pull: renice changes
Date: Sat,  6 Sep 2014 12:24:47 +0100
Message-Id: <1410002693-16540-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

The renice(1) code looked a bit dated, so I decided to change it a bit
which resulted few more changes than I thought.  The --priority <arg>
change makes the command line interface a bit less awkward, and the
numeric uid argument parsing is a bug fix.  Rest of the changes are clean
ups.


The following changes since commit 3c2e64b0ca73b90b80365842e95abb2858217e60:

  lsblk: add notes about udev to the man page (2014-09-05 10:02:45 +0200)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git renice

for you to fetch changes up to 13f618783fb0b8e19d2edef31074454fc4ad5a68:

  rename: add getpriority() message lookup table (2014-09-06 12:07:10 +0100)

----------------------------------------------------------------

Sami Kerola (6):
  renice: reorder functions to avoid need of function prototype
  rename: use usage and version print out macros
  renice: disallow --priority <arg> without pid argument
  renice: avoid having same lines of code twice
  renice: fix numeric uid argument parsing
  rename: add getpriority() message lookup table

 sys-utils/renice.c | 107 +++++++++++++++++++++++++++--------------------------
 1 file changed, 54 insertions(+), 53 deletions(-)

-- 
2.1.0

