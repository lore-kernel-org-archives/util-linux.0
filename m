Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f169.google.com ([209.85.212.169]:33707 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbbJCSbL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 3 Oct 2015 14:31:11 -0400
Received: by wiclk2 with SMTP id lk2so71338552wic.0
        for <util-linux@vger.kernel.org>; Sat, 03 Oct 2015 11:31:09 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 0/4] [pull] mostly uuidd changes
Date: Sat,  3 Oct 2015 19:31:03 +0100
Message-Id: <1443897067-6005-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

The changes in this pull are pretty simple apart from one, that replaces use
of old libc interfaces with newer.  That change is a little bit more hairy
than the other, but should work just fine.

FYI if you pull the changes from my repository you will see they are signed
using my gpg key FDE9B739.  See with git log --show-signature.

----------------------------------------------------------------
The following changes since commit fa8945db4aa0526655655526c3ace8fafaf32f8e:
  uuidd: improve socket activation error messaging (2015-10-02 12:38:30 +0200)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git uuidd
for you to fetch changes up to 35d009dafa4cfa5ef67996e35c6a38525a91f354:
  uuidd: fix shadow declaration (2015-10-03 19:22:58 +0100)
----------------------------------------------------------------

Sami Kerola (4):
  uuidd: slice up the usage text and normalize its layout
  blkid, uuidd, uuidgen: assume getopt.h and getopt.h are available
  uuidd: use signalfd() and setup_timer()
  uuidd: fix shadow declaration

 misc-utils/Makemodule.am |   4 +-
 misc-utils/blkid.c       |   6 --
 misc-utils/uuidd.c       | 189 +++++++++++++++++++++++++++++------------------
 misc-utils/uuidgen.c     |   8 --
 4 files changed, 120 insertions(+), 87 deletions(-)

-- 
2.6.0

