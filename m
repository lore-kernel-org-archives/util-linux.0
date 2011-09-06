Return-Path: heiko.carstens@de.ibm.com
Message-Id: <20110906010157.024880300@de.ibm.com>
Date: Tue, 06 Sep 2011 02:52:54 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 03/11] [PATCH] lscpu: simplify cache column output function
References: <20110906005251.497675140@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

Simplify the logic to "always print a ',' for each cache except if
it is the last one.
This is also a preparation patch for printing the cache column for
offline CPUs where it would print one colon too much because of the
current logic.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/lscpu.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 45b644b..49b6f2b 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -915,13 +915,11 @@ print_parsable_cell(struct lscpu_desc *desc, int i, int col, int compatible)
 
 			for (x = 0; x < ca->nsharedmaps; x++) {
 				if (CPU_ISSET_S(i, setsize, ca->sharedmaps[x])) {
-					if (j != desc->ncaches - 1)
-						putchar(compatible ? ',' : ':');
 					printf("%d", x);
 					break;
 				}
 			}
-			if (x == ca->nsharedmaps)
+			if (j != 0)
 				putchar(compatible ? ',' : ':');
 		}
 		break;
-- 
1.7.5.4
