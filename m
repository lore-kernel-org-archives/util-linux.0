Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:43931 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbaLNRoi (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Dec 2014 12:44:38 -0500
Received: by mail-wi0-f178.google.com with SMTP id em10so6866090wid.17
        for <util-linux@vger.kernel.org>; Sun, 14 Dec 2014 09:44:37 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 00/16] pull: updates to lslogins and chfn
Date: Sun, 14 Dec 2014 17:43:56 +0000
Message-Id: <1418579052-29386-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

While using lslogins earlier the week I noticed --time-format not being
honored in all instances.  There is also another fix to option handling,
that is relatively important for anyone who cares user interface.

The chfn changes are my attempt to make the code a little bit easier to
read, and modify.  That said I came a cross with login.defs CHFN_RESTRICT
so I decided to make it work.  The login.defs(5) is also talking about
CHFN_AUTH, but I don't think it combines well with libuser so I did not
bother trying to spend time with it.

Now when the chfn is bit more OK, see the chsh could be better.  I'll try
to send patches about chsh sometime before holidays.


The following changes since commit 0d75c73d4fc9f638b9fbcab142002acadca9e603:
  lslogins: fix -l -g logic (2014-12-12 15:17:19 +0100)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git 2014wk49
for you to fetch changes up to 7de7c6819d44c9052e3bee50990f37b6d75f3bcb:
  chfn: make command to obey login.defs CHFN_RESTRICT instructions (2014-12-14 17:27:08 +0000)

Sami Kerola (16):
  lslogins: allow changing password changed and expiration time formats
  lslogins: make journald last logs time stamps to honor --time-format
  lslogins: tell why command failed
  lslogins: fix short options
  lslogins: reject unknown time format arguments
  lslogins: add space to systemd journal header and message
  lslogins: use hardcoded paths from pathnames.h
  chfn: remove function prototypes
  chfn: rewrite prompt() to use strutils
  chfn: use xasprintf() rather than bunch of strlen() and malloc() calls
  chfn: fix usage() regression
  chfn: simplify parse_passwd() by using strsep()
  chfn: add minimalistic struct chfn_control
  chfn: clean up parse_argv()
  chfn: move new and old finger structs to chfn control struct
  chfn: make command to obey login.defs CHFN_RESTRICT instructions

 include/pathnames.h       |   1 +
 login-utils/Makemodule.am |   6 +-
 login-utils/chfn.c        | 548 +++++++++++++++++++++++-----------------------
 login-utils/lslogins.c    |  65 +++---
 4 files changed, 312 insertions(+), 308 deletions(-)

-- 
2.1.3

