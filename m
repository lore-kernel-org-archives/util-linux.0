Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:58223 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751089AbaLNTpm (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 14 Dec 2014 14:45:42 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/8] docs: fix the grammar of the recent comment about comments
Date: Sun, 14 Dec 2014 20:45:26 +0100
Message-Id: <1418586333-5342-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 lib/terminal-colors.d.5 |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/terminal-colors.d.5 b/lib/terminal-colors.d.5
index 1bd98a1..66ecf2c 100644
--- a/lib/terminal-colors.d.5
+++ b/lib/terminal-colors.d.5
@@ -163,8 +163,9 @@ use:
 .RE
 
 .SS Comments
-All lines where the first non-blank character is # (hash) are ignored. The
-another usage of the hash character is not interpreted as comment.
+Lines where the first non-blank character is a # (hash) are ignored.
+Any other use of the hash character is not interpreted as introducing
+a comment.
 
 .SH FILES
 .B $XDG_CONFIG_HOME/terminal-colors.d
-- 
1.7.0.4

