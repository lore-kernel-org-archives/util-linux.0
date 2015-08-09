Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:33121 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933120AbbHISTJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 9 Aug 2015 14:19:09 -0400
Received: by wijp15 with SMTP id p15so111085340wij.0
        for <util-linux@vger.kernel.org>; Sun, 09 Aug 2015 11:19:08 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 0/3] pull: colcrt crash fixes
Date: Sun,  9 Aug 2015 19:19:03 +0100
Message-Id: <1439144346-5647-1-git-send-email-kerolasa@iki.fi>
In-Reply-To: <CAFG+y4GYgtnKwHW5wQfWiHVym8NXv-SzzBSmDGuPQLvdPG_OCA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Alaa,

Thank you for bug report.  The gdb output was pretty useful but
unfortunately without knowing what you used as input I had to resort to
American Fuzzy Lop to reproduce the issue, which is not necessarily a bad
thing.  AFL found another issue in same go.  It would be nice to get
confirmation if the change 0002 corrects the problem for you.

That said after the util-linux is released the next version, that is
2.29, will deserve completely rewrote colcrt(1) command.  Current version
with it's global variables and array arithmetics does not feel right.

Three patches to colcrt, and couple other changes I send earlier the
weekend, can also be found from my remote git repository.

----------------------------------------------------------------
The following changes since commit 41e554e303e63c7051fda5783af2462066c43e4d:
  libmount: fix typo in mnt_optstr_prepend_option() (2015-08-05 13:39:06 +0200)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git colcrt
for you to fetch changes up to f137f3e2fca7f7d367114dcd39eca2953a5081f5:
  colcrt: allocate enough space for data moves [afl & asan] (2015-08-09 19:02:59 +0100)
----------------------------------------------------------------

Sami Kerola (3):
  colcrt: use #define in place of magic constants
  colcrt: avoid writing beyond array bound [afl & asan]
  colcrt: allocate enough space for data moves [afl & asan]

 text-utils/colcrt.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

-- 
2.5.0

