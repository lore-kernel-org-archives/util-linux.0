Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f53.google.com ([74.125.82.53]:44338 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551AbaL0RRj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 27 Dec 2014 12:17:39 -0500
Received: by mail-wg0-f53.google.com with SMTP id l18so15902166wgh.26
        for <util-linux@vger.kernel.org>; Sat, 27 Dec 2014 09:17:38 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 00/22] pull: follow-up to chsh, newgrp, and script changes
Date: Sat, 27 Dec 2014 17:17:27 +0000
Message-Id: <1419700655-19107-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

As I mentioned in

http://comments.gmane.org/gmane.linux.utilities.util-linux-ng/10390

the previous patch set was not complete.  The script(1) had signals and
io-streams race that is now fixed with changes 0015 to 0018.

The patches below can be also found from my github repository branch
'script'.

https://github.com/kerolasa/lelux-utiliteetit/tree/script


Sami Kerola (22):
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
=== end of earlier submission ===
  script: use signalfd() to catch signals
  script: use poll() rather than select()
  script: merge doinput() and output() functions to do_io()
  script: remove io vs signal race
  script: add 'Script started' line always to capture file
  script: move do_io() content to small functions
  script: replace strftime() workaround with CFLAGS = -Wno-format-y2k
  script: use correct input type, move comment, and so on

 login-utils/Makemodule.am |   4 +-
 login-utils/ch-common.c   |  34 ++
 login-utils/ch-common.h   |   6 +
 login-utils/chfn.c        |  16 +-
 login-utils/chsh.c        | 365 +++++++++----------
 login-utils/newgrp.c      |  25 +-
 term-utils/Makemodule.am  |   1 +
 term-utils/script.c       | 866 ++++++++++++++++++++--------------------------
 tests/ts/script/race      |   4 -
 9 files changed, 594 insertions(+), 727 deletions(-)
 create mode 100644 login-utils/ch-common.c
 create mode 100644 login-utils/ch-common.h

-- 
2.2.1

