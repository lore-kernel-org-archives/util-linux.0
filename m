Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.nue.novell.com ([195.135.221.5]:58834 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933195AbcCHQxd (ORCPT
	<rfc822;groupwise-util-linux@vger.kernel.org:0:0>);
	Tue, 8 Mar 2016 11:53:33 -0500
From: Matthias Brugger <mbrugger@suse.com>
To: util-linux@vger.kernel.org
Cc: ruediger.meier@ga-group.nl, Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH] Revert "Revert "tests: start script/race test only when --force specified""
Date: Tue,  8 Mar 2016 17:52:58 +0100
Message-Id: <1457455978-8530-1-git-send-email-mbrugger@suse.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This reverts commit bd84241de3f20afef5446ab3f3bbb0245a520faa.

Addresses: https://github.com/karelzak/util-linux/issues/296
Cc: Ruediger Meier <ruediger.meier@ga-group.nl>
Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---

The problem also occurs on v2.27-rc2, so it should probably be backported.

 tests/ts/script/race | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/ts/script/race b/tests/ts/script/race
index 4bdbe95..65d48e2 100755
--- a/tests/ts/script/race
+++ b/tests/ts/script/race
@@ -19,6 +19,9 @@
 TS_TOPDIR="${0%/*}/../.."
 TS_DESC="race conditions"
 
+# Don't execute this test by default, --force required
+TS_OPTIONAL="yes"
+
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
-- 
2.6.2

