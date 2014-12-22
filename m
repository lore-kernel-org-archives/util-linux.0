Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f43.google.com ([74.125.82.43]:56008 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140AbaLVLrV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 22 Dec 2014 06:47:21 -0500
Received: by mail-wg0-f43.google.com with SMTP id l18so6438526wgh.30
        for <util-linux@vger.kernel.org>; Mon, 22 Dec 2014 03:47:20 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 00/14] pull: chsh, newgrp, and script changes
Date: Mon, 22 Dec 2014 11:47:03 +0000
Message-Id: <1419248837-4619-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel,

Here are the last change I want to sent before holiday break.

This patch set is primarily about chsh(1).  Changes to newgrp(1) are
modest, and the changes to script(1) are incomplete.  Consider the
script(1) changes as preparation to fixes ahead.  I ACK future
exepectations for script are described in the test file.

$ grep -A1 TODO tests/ts/script/race 
# TODO see comments about script design
# https://github.com/karelzak/util-linux/pull/62

In between eating too much, queen's speech, pulling some crackers, and
other festive activities I might have time to further improve script(1).

Finally, here is an alternative for people who prefer using changes from
remote repository rather then merging from mails.

----------------------------------------------------------------
The following changes since commit bf6c15ed4a3e00ae1f9c18c6d9bbf8589e09a2da:
  chfn: fix compilation without libuser (2014-12-19 15:05:04 +0100)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git script
for you to fetch changes up to 0b3b58ae5ff95fd9cdea3e2fa45ef02639e8521d:
  script: add struct script_control and remove global variables (2014-12-20 16:03:29 +0000)
----------------------------------------------------------------

Sami Kerola (14):
  chsh: remove function prototypes
  chfn, chsh: share illegal_passwd_chars() function
  chsh: use getline() to support arbitrarily long lines
  chsh: set few variables read-only and rename one of them
  chsh: allow user to set shell to /bin/sh if none is set
  chsh: clean up parse_argv()
  chsh: rewrite function interacting with user to get path to new shell
  chsh: simplify check_shell()
  chsh: fail get_shell_list() check when /etc/shells cannot be opened
  newgrp: simplify if else clauses
  newgrp: move shell determination closer where it is used
  newgrp: set function arguments read-only when possible
  script: remove function prototypes
  script: add struct script_control and remove global variables

 login-utils/Makemodule.am |   4 +-
 login-utils/ch-common.c   |  34 ++
 login-utils/ch-common.h   |   6 +
 login-utils/chfn.c        |  16 +-
 login-utils/chsh.c        | 365 ++++++++++-----------
 login-utils/newgrp.c      |  25 +-
 term-utils/script.c       | 788 +++++++++++++++++++++++-----------------------
 7 files changed, 609 insertions(+), 629 deletions(-)
 create mode 100644 login-utils/ch-common.c
 create mode 100644 login-utils/ch-common.h

-- 
2.2.1

