Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:58319 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751842AbbDMMB5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 13 Apr 2015 08:01:57 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0MUHbK-1Ypunh1KXS-00QzE3 for
 <util-linux@vger.kernel.org>; Mon, 13 Apr 2015 14:01:55 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH v2 1/7] logger: --stderr and --no-act turn "auto-errors" on
Date: Mon, 13 Apr 2015 14:01:47 +0200
Message-Id: <1428926513-25449-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1428926513-25449-1-git-send-email-sweet_f_a@gmx.de>
References: <1428926513-25449-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 misc-utils/logger.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index 6316a76..8908dfc 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -914,10 +914,9 @@ int main(int argc, char **argv)
 		ctl.unix_socket_errors = 1;
 		break;
 	case AF_UNIX_ERRORS_AUTO:
+		ctl.unix_socket_errors = ctl.noact || ctl.stderr_printout;
 #ifdef HAVE_LIBSYSTEMD
-		ctl.unix_socket_errors = sd_booted();
-#else
-		ctl.unix_socket_errors = 0;
+		ctl.unix_socket_errors |= !!sd_booted();
 #endif
 		break;
 	default:
-- 
1.8.4.5

