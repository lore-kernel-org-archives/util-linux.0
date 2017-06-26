Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:54729 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751308AbdFZSaL (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 26 Jun 2017 14:30:11 -0400
Received: from adsiz.fritz.box ([146.52.24.88]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MB1C4-1dZUv8324y-009v2g for
 <util-linux@vger.kernel.org>; Mon, 26 Jun 2017 20:29:54 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 5/6] login: add --help text
Date: Mon, 26 Jun 2017 20:29:51 +0200
Message-Id: <20170626182952.15988-6-sweet_f_a@gmx.de>
In-Reply-To: <20170626182952.15988-1-sweet_f_a@gmx.de>
References: <20170626182952.15988-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 login-utils/login.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/login-utils/login.c b/login-utils/login.c
index ee06d03e8..08b2d3564 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -1101,6 +1101,14 @@ static void __attribute__((__noreturn__)) usage(void)
 	printf(_(" %s [-p] [-h <host>] [-H] [[-f] <username>]\n"), program_invocation_short_name);
 	fputs(USAGE_SEPARATOR, stdout);
 	fputs(_("Begin a session on the system.\n"), stdout);
+
+	fputs(USAGE_OPTIONS, stdout);
+	puts(_(" -p             do not destroy the environment"));
+	puts(_(" -f             skip a second login authentication"));
+	puts(_(" -h <host>      hostname to be used for utmp logging"));
+	puts(_(" -H             suppress hostname in the login prompt"));
+	printf("     --help     %s\n", USAGE_HELP_TXT);
+	printf(" -V, --version  %s\n", USAGE_VERSION_TXT);
 	printf(USAGE_MAN_TAIL("login(1)"));
 	exit(EXIT_SUCCESS);
 }
-- 
2.12.3

