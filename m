Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33541 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932840AbcBBRto (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 2 Feb 2016 12:49:44 -0500
Received: by mail-wm0-f67.google.com with SMTP id r129so3500805wmr.0
        for <util-linux@vger.kernel.org>; Tue, 02 Feb 2016 09:49:44 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 0/3] pull: colcrt test and regression
Date: Tue,  2 Feb 2016 17:49:37 +0000
Message-Id: <1454435380-1354-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

These changes has been in my outgoing submission list for quite a while
because I'm not 100% happy with the result.  The trouble is that earlier
changes, ee24ab6f1..70e3fcf29, fix crashing issue but broke output format
and now when I made the colcrt(1) robust with how it deals inputs & legit
outputs the changes broke binary inputs.  Then again the colcrt is not
supposed to be used for non-printable inputs so perhaps this regression is
better than breaking the ascii output.  Let me demonstrate.


~ cat dog 
Diogenes_the_dog
~ colcrt < dog 
Diogenes the dog
       -   -

Let's try with patched version.

~ colcrt < dog
Diogenes the dog
        -   -

So as you can see, assuming fixed width font with email client, the updated
version realigns former underscores to be hyphens at spaces of words.  In my
understanding that is primary functionality of the colcrt(1), and hence it
should work.  But as you can clearly see the patch 0003 breaks binary
imputs.  I'm tempted to say such is life.


---------------------------------------------------------------
The following changes since commit c809b20aa404a79b1482f0fc850c2a61d09253f5:
  sfdisk: make --quiet really quiet (2016-02-01 14:30:31 +0100)
are available in the git repository at:
  git://github.com/kerolasa/lelux-utiliteetit.git colcrt
for you to fetch changes up to c1ca4fc10867e792fd431d06ccbd282b7353992e:
  tests: update colcrt test expectations (2016-02-02 17:27:28 +0000)
---------------------------------------------------------------


Sami Kerola (3):
  tests: add colcrt functional tests
  colcrt: reimplementation
  tests: update colcrt test expectations

 tests/expected/colcrt/functional                |   0
 tests/expected/colcrt/functional-half-lines     |  89 +++++
 tests/expected/colcrt/functional-no-options     |  74 +++++
 tests/expected/colcrt/functional-no-underlining |  44 +++
 tests/expected/colcrt/functional-short-options  |  89 +++++
 tests/expected/colcrt/regressions               |   0
 tests/expected/colcrt/regressions-crash1        |   1 +
 tests/expected/colcrt/regressions-crash2        | 392 +---------------------
 tests/ts/colcrt/functional                      |  50 +++
 tests/ts/colcrt/nasty-input                     | Bin 0 -> 545 bytes
 tests/ts/colcrt/underlines                      |  23 ++
 text-utils/colcrt.c                             | 419 ++++++++++--------------
 12 files changed, 554 insertions(+), 627 deletions(-)
 create mode 100644 tests/expected/colcrt/functional
 create mode 100644 tests/expected/colcrt/functional-half-lines
 create mode 100644 tests/expected/colcrt/functional-no-options
 create mode 100644 tests/expected/colcrt/functional-no-underlining
 create mode 100644 tests/expected/colcrt/functional-short-options
 create mode 100644 tests/expected/colcrt/regressions
 create mode 100755 tests/ts/colcrt/functional
 create mode 100644 tests/ts/colcrt/nasty-input
 create mode 100644 tests/ts/colcrt/underlines

-- 
2.7.0

