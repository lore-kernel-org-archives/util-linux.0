Return-Path: heiko.carstens@de.ibm.com
Message-Id: <20110906010155.806769708@de.ibm.com>
Date: Tue, 06 Sep 2011 02:52:52 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 01/11] [PATCH] lscpu: remove comma operator
References: <20110906005251.497675140@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

Fix typo where the comma operator has been introduced.
Use a semicolon instead so we end up with simple assignment expressions.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/lscpu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index fb65d8e..3733cab 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -1218,8 +1218,8 @@ int main(int argc, char *argv[])
 			} else {
 				columns[ncolumns++] = COL_CPU;
 				columns[ncolumns++] = COL_CORE;
-				columns[ncolumns++] = COL_SOCKET,
-				columns[ncolumns++] = COL_NODE,
+				columns[ncolumns++] = COL_SOCKET;
+				columns[ncolumns++] = COL_NODE;
 				columns[ncolumns++] = COL_CACHE;
 				compatible = 1;
 			}
-- 
1.7.5.4
