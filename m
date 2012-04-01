Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41214 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297Ab2DASUa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 1 Apr 2012 14:20:30 -0400
Received: by mail-ey0-f174.google.com with SMTP id q12so624535eaa.19
        for <util-linux@vger.kernel.org>; Sun, 01 Apr 2012 11:20:29 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/3] tests: hwclock: locate ntpdate by using path
Date: Sun,  1 Apr 2012 20:19:30 +0200
Message-Id: <1333304372-25944-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1333304372-25944-1-git-send-email-kerolasa@iki.fi>
References: <20120330150457.GE23437@x2.net.home>
 <1333304372-25944-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/ts/hwclock/systohc |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/ts/hwclock/systohc b/tests/ts/hwclock/systohc
index f58d07e..401ee93 100755
--- a/tests/ts/hwclock/systohc
+++ b/tests/ts/hwclock/systohc
@@ -24,7 +24,8 @@ NTP_SERVER="0.fedora.pool.ntp.org"
 ts_init "$*"
 ts_skip_nonroot
 
-[ -x "/usr/sbin/ntpdate" ] || ts_skip "cannot find ntpdate command"
+PATH='/usr/sbin:/usr/bin:/sbin:/bin'
+type ntpdate >/dev/null 2>&1 || ts_skip "cannot find ntpdate command"
 
 set -o pipefail
 
-- 
1.7.9.5

