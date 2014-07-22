Return-Path: davidlohr@hp.com
From: Davidlohr Bueso <davidlohr@hp.com>
To: kzak@redhat.com
Cc: davidlohr@hp.com, aswin@hp.com, util-linux@vger.kernel.org
Subject: [PATCH 13/13] sfdisk: activate_usage() can use noreturn attribute Signed-off-by: Davidlohr Bueso <davidlohr@hp.com>
Date: Tue, 22 Jul 2014 16:44:57 -0700
Message-Id: <1406072697-20912-14-git-send-email-davidlohr@hp.com>
In-Reply-To: <1406072697-20912-1-git-send-email-davidlohr@hp.com>
References: <1406072697-20912-1-git-send-email-davidlohr@hp.com>
List-ID: <util-linux.vger.kernel.org>

---
 disk-utils/sfdisk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index f730504..6fbbb73 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -2539,7 +2539,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-static void activate_usage(void)
+static void __attribute__ ((__noreturn__)) activate_usage(void)
 {
 	char *p;
 
-- 
1.8.1.4
