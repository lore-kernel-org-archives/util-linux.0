Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f171.google.com ([209.85.212.171]:37231 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbbH0NVe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 27 Aug 2015 09:21:34 -0400
Received: by widdq5 with SMTP id dq5so45034960wid.0
        for <util-linux@vger.kernel.org>; Thu, 27 Aug 2015 06:21:32 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 0/4] pull: cal: --sunday --week numbering correction
Date: Thu, 27 Aug 2015 14:21:25 +0100
Message-Id: <1440681689-2708-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

The first change in this pull request attempts to fix US week numbering
issue reported in

https://bugzilla.redhat.com/show_bug.cgi?id=1249486

The fix will make Jan 1st to be on week 1, and last week of the year may
have less than seven days.  According to wikipedia this is one of the
possible US week numbering systems.

https://en.wikipedia.org/wiki/ISO_week_date#Other_week_numbering_systems

I do not think cal(1) should implement all of the possible week numbering
alternatives.

----------------------------------------------------------------
The following changes since commit 1198e390514e6c0ce34411982228bb773e45ae5a:
  libblkid: (drbdmanage) add magic strings array terminator (2015-08-27 11:07:39 +0200)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git bz1249486
for you to fetch changes up to e82a312d69f2a610f84bc9ea19324c449758ed69:
  cal: check biggest week number correctly when highlighting (2015-08-27 14:01:18 +0100)
----------------------------------------------------------------

Sami Kerola (4):
  cal: correct gregorian week numbering
  tests: cal: update Gregorian week numbers
  cal: replace magic constants with symbolical values
  cal: check biggest week number correctly when highlighting

 misc-utils/cal.c            | 102 +++---
 tests/expected/cal/bigyearw | 156 ++++-----
 tests/expected/cal/colorw   |  48 +--
 tests/expected/cal/jan1753  |  12 +-
 tests/expected/cal/sep1752w | 148 ++++----
 tests/expected/cal/weekarg  |  60 ++--
 tests/expected/cal/weeknum  | 816 ++++++++++++++++++++++----------------------
 tests/ts/cal/weekarg        |  26 ++
 8 files changed, 710 insertions(+), 658 deletions(-)

-- 
2.5.0

