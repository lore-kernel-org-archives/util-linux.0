Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:55809 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753120AbdIDBRl (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 3 Sep 2017 21:17:41 -0400
Subject: [PATCH 1/1] hwclock: update usage()
To: Karel Zak <kzak@redhat.com>
References: <e5219e08-60f7-d35d-c81c-64cb598c7e84@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <5ed40d68-f7de-58e5-8da1-24560be5d6ae@gmx.com>
Date: Sun, 3 Sep 2017 21:17:28 -0400
MIME-Version: 1.0
In-Reply-To: <e5219e08-60f7-d35d-c81c-64cb598c7e84@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Improve usage strings for debug and version.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 include/c.h         | 2 +-
 sys-utils/hwclock.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/c.h b/include/c.h
index 119a127e3..b0670dcaa 100644
--- a/include/c.h
+++ b/include/c.h
@@ -317,7 +317,7 @@ static inline int xusleep(useconds_t usec)
 #define USAGE_SEPARATOR    "\n"
 
 #define USAGE_OPTSTR_HELP     _("display this help")
-#define USAGE_OPTSTR_VERSION  _("print version")
+#define USAGE_OPTSTR_VERSION  _("display version")
 
 #define USAGE_HELP_OPTIONS(marg_dsc) \
 		"%-" #marg_dsc "s%s\n" \
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 9fb631f6f..bf5459783 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1101,7 +1101,7 @@ usage(void)
 	printf(_(
 	       "     --adjfile <file> use an alternate file to %1$s\n"), _PATH_ADJTIME);
 	puts(_("     --test           dry run; use -D to view what would have happened"));
-	puts(_(" -D, --debug          use debug mode"));
+	puts(_(" -D, --debug          display more details"));
 	fputs(USAGE_SEPARATOR, stdout);
 	printf(USAGE_HELP_OPTIONS(22));
 	printf(USAGE_MAN_TAIL("hwclock(8)"));
