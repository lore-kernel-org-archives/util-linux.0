Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:61221 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbaEROFv (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 18 May 2014 10:05:51 -0400
Received: by mail-wi0-f178.google.com with SMTP id cc10so311019wib.5
        for <util-linux@vger.kernel.org>; Sun, 18 May 2014 07:05:50 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 00/17] pull: almost complete setterm refactoring
Date: Sun, 18 May 2014 15:05:24 +0100
Message-Id: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

Here is bunch of patches to setterm, with the intention to make the code
to look a little bit more fresh.  I admit the second patch being
practically impossible to review because there is so much going on in it. 
Unfortunately I could not figure out how to change how options work, and
keep the change small.

Lets hope this does not break anything, while the change should make the
command more robust in various ways.


The following changes since commit 1efded63dfe85d62bcd8f0ff29ea6b62aa5cac74:

  Merge branch 'tests-mount' of https://github.com/rudimeier/util-linux (2014-05-16 14:30:05 +0200)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git 2014wk19

for you to fetch changes up to 19d616172ad30e375056ab3ce86d0166a840773a:

  setterm: add set_blanking() action (2014-05-18 14:55:23 +0100)

Sami Kerola (17):
  setterm: clean up includes
  setterm: use getopt_long_only() for option parsing
  setterm: use string utils to numeric parsing
  setterm: move show_tabs() and screendump() functions
  setterm: remove usage comment segment
  setterm: add option control structure
  setterm: add init_terminal() to make main() shorter
  setterm: clean up screendump()
  setterm: remove devfs and /dev/vcsa0 support
  setterm: make -msglevel 0 to work as is did earlier
  setterm: correct usage() bright color argument
  setterm: improve perform_sequence() coding style
  setterm: tell user when options does not effect
  setterm: improve error messages
  setterm: various visual terminal effects are not console specific
  setterm: mark some options to be exclusive with each other
  setterm: add set_blanking() action

 bash-completion/setterm  |   19 +-
 term-utils/Makemodule.am |    2 +-
 term-utils/setterm.c     | 1621 +++++++++++++++++++++-------------------------
 3 files changed, 761 insertions(+), 881 deletions(-)

-- 
1.9.2

