Return-Path: heiko.carstens@de.ibm.com
Message-Id: <20110906010156.418074369@de.ibm.com>
Date: Tue, 06 Sep 2011 02:52:53 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 02/11] [PATCH] lscpu: fix cache output for extended parsable output
References: <20110906005251.497675140@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

The extended parsable output prints a colon instead of comma between each
item. The case where a CPU doesn't belong to any cache was not converted.
Just fix this.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/lscpu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 3733cab..45b644b 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -922,7 +922,7 @@ print_parsable_cell(struct lscpu_desc *desc, int i, int col, int compatible)
 				}
 			}
 			if (x == ca->nsharedmaps)
-				putchar(',');
+				putchar(compatible ? ',' : ':');
 		}
 		break;
 	case COL_POLARIZATION:
-- 
1.7.5.4
