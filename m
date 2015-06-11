Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews08.kpnxchange.com ([213.75.39.13]:58977 "EHLO
	cpsmtpb-ews08.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751232AbbFKJRR (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 11 Jun 2015 05:17:17 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/2] chrt: make the usage synopsis clearer
Date: Thu, 11 Jun 2015 11:04:01 +0200
Message-Id: <1434013442-2674-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 schedutils/chrt.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index 9b451ff..b6923b2 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -60,7 +60,8 @@ static void __attribute__((__noreturn__)) show_usage(int rc)
 	fputs(_("Show or change the real-time scheduling attributes of a process.\n"), out);
 	fprintf(out, _(
 	"\nSet policy:\n"
-	"  chrt [options] [-p] [<policy>] <priority> [<pid> | <command> [<arg>...]]\n"
+	"  chrt [options] <priority> <command> [<arg>...]\n"
+	"  chrt [options] -p <priority> <pid>\n"
 	"\nGet policy:\n"
 	"  chrt [options] -p <pid>\n"));
 
-- 
1.7.0.4

