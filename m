Return-Path: heiko.carstens@de.ibm.com
Message-Id: <20110810083822.717667600@de.ibm.com>
Date: Wed, 10 Aug 2011 10:36:46 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [patch 1/8] [PATCH] lscpu: fix s390 bogomips detection coding style
References: <20110810083645.135814950@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Just make the s390 bogomips detection line look like all others.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/lscpu.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -434,8 +434,7 @@ read_basicinfo(struct lscpu_desc *desc)
 		else if (lookup(buf, "features", &desc->flags)) ;	/* s390 */
 		else if (lookup(buf, "type", &desc->flags)) ;		/* sparc64 */
 		else if (lookup(buf, "bogomips", &desc->bogomips)) ;
-		/* S390 */
-		else if (lookup(buf, "bogomips per cpu", &desc->bogomips)) ;
+		else if (lookup(buf, "bogomips per cpu", &desc->bogomips)) ; /* s390 */
 		else
 			continue;
 	}
