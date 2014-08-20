Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-la0-f53.google.com ([209.85.215.53]:43516 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618AbaHTTHD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 20 Aug 2014 15:07:03 -0400
Received: by mail-la0-f53.google.com with SMTP id gl10so7766502lab.12
        for <util-linux@vger.kernel.org>; Wed, 20 Aug 2014 12:07:01 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] tests: apply travis clang PATH workaround
Date: Wed, 20 Aug 2014 22:06:58 +0300
Message-Id: <1408561618-11277-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

As seen in Travis build log the clang is not found, causing one of the
tests to fail.  This change adds a workaround from Travis issue 2607 to
util-linux.

Reference: https://travis-ci.org/karelzak/util-linux/jobs/33056101#L3630
Reference: https://github.com/travis-ci/travis-ci/issues/2607
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 .travis.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index a1a15e4..bc2b8b9 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -33,3 +33,9 @@ script:
 
 after_script:
   - travis_after_script
+
+before_install:
+  - $CC --version
+  - which $CC
+  # workaround clang not system wide, fail on sudo make install
+  - export CC=`which $CC`
-- 
2.1.0

