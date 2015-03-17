Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews07.kpnxchange.com ([213.75.39.10]:61312 "EHLO
	cpsmtpb-ews07.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753211AbbCQUfC (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 17 Mar 2015 16:35:02 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/3] hwclock: remove an untrue phrase from the man page
Date: Tue, 17 Mar 2015 21:34:51 +0100
Message-Id: <1426624493-2464-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/hwclock.8.in |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index 96c57d4..9682244 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -298,11 +298,6 @@ the true year.  That way, the Hardware Clock inserts leap days where
 they belong.  Again, if you let the Hardware Clock run for more than a
 year without setting it, this scheme could be defeated and you could
 end up losing a day.
-.sp
-.B \%hwclock
-warns you that you probably need
-.B \%\-\-badyear
-whenever it finds your Hardware Clock set to 1994 or 1995.
 .
 .TP
 .BI \%\-\-date= date_string
-- 
1.7.0.4

