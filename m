Return-Path: util-linux-owner@vger.kernel.org
Received: from out03.mta.xmission.com ([166.70.13.233]:34065 "EHLO
	out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757751Ab3AQAgF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 16 Jan 2013 19:36:05 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Karel Zak <kzak@redhat.com>
Cc: Mike Frysinger <vapier@gentoo.org>, util-linux@vger.kernel.org,
        Neil Horman <nhorman@tuxdriver.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>
References: <876234812z.fsf@xmission.com> <20130111161320.GA16206@x2.net.home>
	<87fw27jq29.fsf_-_@xmission.com>
	<201301111845.16591.vapier@gentoo.org>
	<20130114082846.GA16421@x2.net.home> <87a9s8lkbq.fsf_-_@xmission.com>
Date: Wed, 16 Jan 2013 16:35:53 -0800
In-Reply-To: <87a9s8lkbq.fsf_-_@xmission.com> (Eric W. Biederman's message of
	"Wed, 16 Jan 2013 16:33:29 -0800")
Message-ID: <87mww8k5na.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [PATCH 4/5] nsenter: Replace a bare strtoul with strtoul_or_err
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


This is shorter code and makes things a bit clearer and less
error prone if anyone happens to copy the code.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 sys-utils/nsenter.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
index 5b8d9c4..cc54ebe 100644
--- a/sys-utils/nsenter.c
+++ b/sys-utils/nsenter.c
@@ -27,6 +27,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 
+#include "strutils.h"
 #include "nls.h"
 #include "c.h"
 #include "closestream.h"
@@ -198,7 +199,6 @@ int main(int argc, char *argv[])
 
 	struct namespace_file *nsfile;
 	int do_fork = 0;
-	char *end;
 	int c;
 
 	setlocale(LC_MESSAGES, "");
@@ -214,13 +214,7 @@ int main(int argc, char *argv[])
 			printf(UTIL_LINUX_VERSION);
 			return EXIT_SUCCESS;
 		case 't':
-			errno = 0;
-			namespace_target_pid = strtoul(optarg, &end, 10);
-			if (!*optarg || (*optarg && *end) || errno != 0) {
-				err(EXIT_FAILURE,
-				    _("Pid '%s' is not a valid number"),
-				    optarg);
-			}
+			namespace_target_pid = strtoul_or_err(optarg, _("failed to parse pid"));
 			break;
 		case 'm':
 			open_namespace_fd(CLONE_NEWNS, optarg);
-- 
1.7.5.4

