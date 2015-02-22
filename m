Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f175.google.com ([74.125.82.175]:34099 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbbBVOm5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:42:57 -0500
Received: by wesq59 with SMTP id q59so13672221wes.1
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:42:56 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 00/12] pull: script(1) changes
Date: Sun, 22 Feb 2015 14:42:37 +0000
Message-Id: <1424616169-693-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

The following changes are clean ups and improvements to script(1)
command.  These changes are also available from my github remote
repository.

 git://github.com/kerolasa/lelux-utiliteetit.git script

Sami Kerola (12):
  script: remove function prototypes
  script: add struct script_control and remove global variables
  script: use signalfd() to catch signals
  script: use poll() rather than select()
  script: merge doinput() and output() functions to do_io()
  script: remove io vs signal race
  script: add 'Script started' line always to capture file
  script: move do_io() content to small functions
  script: replace strftime() workaround with CFLAGS = -Wno-format-y2k
  script: use correct input type, move comment, and so on
  script: use gettime_monotonic() to get timing file timestamps
  script: add noreturn function attributes

 term-utils/Makemodule.am |   5 +-
 term-utils/script.c      | 872 ++++++++++++++++++++---------------------------
 tests/ts/script/race     |   4 -
 3 files changed, 380 insertions(+), 501 deletions(-)

-- 
2.3.0

