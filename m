Return-Path: heiko.carstens@de.ibm.com
Date: Tue, 21 Jun 2011 13:24:33 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: [PATCH] lscpu: fix bogomips detection for s390
Message-ID: <20110621112433.GA4198@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <util-linux.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

s390 has a "bogomips per cpu" string instead of a "bogomips" string in
/proc/sysinfo. So add a second bogomips lookup which detects the s390
variant.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/lscpu.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 027a298..1481fef 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -369,6 +369,8 @@ read_basicinfo(struct lscpu_desc *desc)
 		else if (lookup(buf, "cpu MHz", &desc->mhz)) ;
 		else if (lookup(buf, "flags", &desc->flags)) ;
 		else if (lookup(buf, "bogomips", &desc->bogomips)) ;
+		/* S390 */
+		else if (lookup(buf, "bogomips per cpu", &desc->bogomips)) ;
 		else
 			continue;
 	}
