Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f181.google.com ([209.85.212.181]:52634 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbbBVOmW (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:42:22 -0500
Received: by mail-wi0-f181.google.com with SMTP id r20so11669818wiv.2
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:42:21 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 00/13] pull: rtcwake changes
Date: Sun, 22 Feb 2015 14:42:06 +0000
Message-Id: <1424616139-638-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

The following changes are clean ups and improvements to rtcwake command.
These changes are also available from my github remote repository.

 git://github.com/kerolasa/lelux-utiliteetit.git rtcwake

Sami Kerola (13):
  rtcwake: add rtcwake_control and remove global variables
  rtcwake: enumerate constant mode strings
  rtcwake: replace long if else statement with switch case
  rtcwake: remove RTC_ALM_READ and RTC_ALM_SET compatibility
  rtcwake: improve read_clock_mode()
  rtcwake: add human readable --date timestamp format
  rtcwake: fix preprocessor redefinition
  rtcwake: clean up struct tm initializations
  rtcwake: do not overwrite device name
  bash-completion: add freeze mode to rtcwake
  rtcwake: improve coding style
  rtcwake: make some command line options mutually exclusive
  rtcwake: read accepted mode strings from /sys/power/state

 bash-completion/rtcwake |   9 +-
 sys-utils/rtcwake.8.in  |  19 +-
 sys-utils/rtcwake.c     | 579 ++++++++++++++++++++++--------------------------
 3 files changed, 290 insertions(+), 317 deletions(-)

-- 
2.3.0

