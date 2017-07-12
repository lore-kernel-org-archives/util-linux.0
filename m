Return-Path: util-linux-owner@vger.kernel.org
Received: from hotei.ga-group.nl ([138.201.147.219]:36954 "EHLO
        hotei.ga-group.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752450AbdGLTPF (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 12 Jul 2017 15:15:05 -0400
From: Ruediger Meier <ruediger.meier@ga-group.nl>
To: util-linux@vger.kernel.org
Subject: uuidparse: test fails on 32bit machines
Date: Wed, 12 Jul 2017 21:15:01 +0200
Cc: Sami Kerola <kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201707122115.01476.ruediger.meier@ga-group.nl>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

below you see the test diff when running on i586 or other
32bit archs. Could be that the program is fine and we could
simply fix the test by not using such large timestamps, but
maybe it's worth to review strtimeval_iso() and also
libuuid/src/uuid_time.c for overflow handling.


--- /home/rudi/devel/util-linux/tests/expected/uuid/uuidparse   2017-06-29 20:41:46.847789376 +0000
+++ /home/rudi/devel/util-linux/build-32/tests/output/uuid/uuidparse    2017-07-12 18:48:04.874392934 +0000
@@ -7,7 +7,7 @@
 00000000-0000-5000-0000-000000000000  NCS       sha1-based
 00000000-0000-6000-0000-000000000000  NCS       unknown
 00000000-0000-0000-8000-000000000000  DCE       nil
-00000000-0000-1000-8000-000000000000  DCE       time-based 60038-03-11 05:36:10,955161+0000
+00000000-0000-1000-8000-000000000000  DCE       time-based 1922-08-07 02:26:18,955161+0000
 00000000-0000-2000-8000-000000000000  DCE       DCE
 00000000-0000-3000-8000-000000000000  DCE       name-based
 00000000-0000-4000-8000-000000000000  DCE       random
@@ -28,6 +28,6 @@
 00000000-0000-5000-f000-000000000000  other     sha1-based
 00000000-0000-6000-f000-000000000000  other     unknown
 9b274c46-544a-11e7-a972-00037f500001  DCE       time-based 2017-06-18 17:21:46,544647+0000
-ffffffff-ffff-1fff-8fff-ffffffffffff  DCE       time-based 5236-03-31 21:21:00,684697+0000
+ffffffff-ffff-1fff-8fff-ffffffffffff  DCE       time-based 1969-10-19 10:02:36,684697+0000
 invalid-input                         invalid   invalid    invalid
 return value: 0

cu,
Rudi
