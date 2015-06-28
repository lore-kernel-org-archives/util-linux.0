Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34838 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416AbbF1Tn3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Jun 2015 15:43:29 -0400
Received: by wiga1 with SMTP id a1so54692761wig.0
        for <util-linux@vger.kernel.org>; Sun, 28 Jun 2015 12:43:28 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 0/7] pull: various small changes
Date: Sun, 28 Jun 2015 20:43:18 +0100
Message-Id: <1435520605-4296-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

Almost all in this change set is trivial stuff, apart from deprecation
proposals.  I think scrubbing some junk makes sense when ever possible.
But deprecations can be tricky, so it would be great to hear if I
assumptions about reset(1) and the last-deprecated are right or wrong.

People who prefer fetching from remote git here's what you need: 

----------------------------------------------------------------
The following changes since commit 13c551f259423d97e6edf1380d5d9e93d77ebc89:
  cfdisk: fix condition logic [cppcheck] (2015-06-25 12:08:53 +0200)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git misc
for you to fetch changes up to 28165575552a4cb8fe919eca367ab070070d371a:
  reset: deprecate the script, and remove reset.033c (2015-06-28 19:27:36 +0100)
----------------------------------------------------------------

Sami Kerola (7):
  last-deprecated: remove from source tree
  zramctl: add link to kernel documentation
  cal: fix memory leaks [valgrind]
  docs: unify mkswap(8) with swapon(8) about holes warning
  build-sys: add minimal whitespace build directory support
  getopt: use $(...) command substitution in example script [shellcheck]
  reset: deprecate the script, and remove reset.033c

 Documentation/deprecated.txt  |   6 +-
 autogen.sh                    |   7 +-
 configure.ac                  |  15 +-
 disk-utils/mkswap.8           |  14 +-
 login-utils/Makemodule.am     |   7 -
 login-utils/last-deprecated.1 |  62 ------
 login-utils/last-deprecated.c | 483 ------------------------------------------
 misc-utils/cal.c              |   3 +
 misc-utils/getopt-parse.bash  |   4 +-
 sys-utils/zramctl.8           |   4 +
 term-utils/Makemodule.am      |   1 -
 term-utils/reset              |   6 +
 term-utils/reset.033c         |  11 -
 13 files changed, 41 insertions(+), 582 deletions(-)
 delete mode 100644 login-utils/last-deprecated.1
 delete mode 100644 login-utils/last-deprecated.c
 delete mode 100755 term-utils/reset.033c

-- 
2.4.4

