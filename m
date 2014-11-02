Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36233 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbaKBU0m (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 2 Nov 2014 15:26:42 -0500
Received: by mail-wi0-f171.google.com with SMTP id q5so4940681wiv.16
        for <util-linux@vger.kernel.org>; Sun, 02 Nov 2014 12:26:41 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 0/8] pull: mostly mkswap and one swapoff chanage
Date: Sun,  2 Nov 2014 20:26:23 +0000
Message-Id: <1414959991-8369-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

This pull request contains corrected version of swapoff(8) change, that was
first sent at 31 October 2014 23:57 and had issues.

Rest of the changes are to mkswap, that needed a bit dusting.  Pretty old
sparc 32bit support for kernels about 15 years ago is removed.  The command
got all familiar util-linux convention like 'struct mkswap_control', that
made easier to see what exactly is the data functions are handling.  The
rest of the changes are straight forward clarifications.

----------------------------------------------------------------
The following changes since commit 54f2e4563d6c7064df9f2a201ffe928709c29333:
  swapon: remove extra word from usage (2014-10-31 10:58:27 +0100)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git 2014wk43
for you to fetch changes up to 9e55f54b2f1a740da508c5f192371f5df900680f:
  mkswap: various minor improvement (2014-11-02 19:50:00 +0000)
----------------------------------------------------------------
Sami Kerola (8):
  swapoff: make LABEL= and UUID= work when turning off swap files
  mkswap: remove system architecture specific max swap size checks
  mkswap: remove unnecessary size check
  mkswap: use err() rather than perror() && exit()
  mkswap: add struct mkswap_control to remove global variables
  mkswap: make remaining functions to take control structure as argument
  mkswap: set variable only when it's value is known
  mkswap: various minor improvement

 disk-utils/mkswap.c     | 435 ++++++++++++++++--------------------------------
 include/swapheader.h    |   2 -
 sys-utils/Makemodule.am |  13 +-
 sys-utils/swapoff.c     |  34 ++--
 4 files changed, 177 insertions(+), 307 deletions(-)

-- 
2.1.3

