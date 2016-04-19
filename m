Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33421 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430AbcDSUft (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 19 Apr 2016 16:35:49 -0400
Received: by mail-wm0-f67.google.com with SMTP id y144so8321188wmd.0
        for <util-linux@vger.kernel.org>; Tue, 19 Apr 2016 13:35:48 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 0/5] pull: couple clang scan-build fixes
Date: Tue, 19 Apr 2016 21:35:40 +0100
Message-Id: <1461098145-2988-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

Here are some minor updates to make static analyzers less noisy.  Whether
these make any difference in real life is questionable.  Well at least there
will be fewer false positive when running scan-build, asan, or such.


----------------------------------------------------------------
The following changes since commit 1bd62f72d8281cdd089fbef43652656dd3c60642:
  libblkid: fix mistake in debug message (2016-04-19 12:45:00 +0200)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git scan-build
for you to fetch changes up to 55cf10134a5dd3622361090ea90e7fd501b4b655:
  getopt: fix memory leaks and integer overflows [ASAN & valgrind] (2016-04-19 21:27:54 +0100)
----------------------------------------------------------------

Sami Kerola (5):
  build-sys: test functions does not return void
  libmount: fix memory leak
  setpwnam: fix memory leak
  lib: avoid double free in loopdev.c
  getopt: fix memory leaks and integer overflows [ASAN & valgrind]

 configure.ac           |  2 +-
 lib/loopdev.c          |  1 +
 libmount/src/utils.c   |  4 ++--
 login-utils/setpwnam.c |  1 +
 misc-utils/getopt.c    | 25 ++++++++++++++++++-------
 5 files changed, 23 insertions(+), 10 deletions(-)

-- 
2.8.0

