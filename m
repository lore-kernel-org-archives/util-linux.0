Return-Path: elseifthen@gmx.com
Subject: [PATCH 12/12] hwclock: remove unused stdarg.h
To: Karel Zak <kzak@redhat.com>
References: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <21f01805-814b-efe8-a0c1-33001fa5a271@gmx.com>
Date: Sun, 18 Jun 2017 20:51:02 -0400
MIME-Version: 1.0
In-Reply-To: <011634ef-e5e7-354e-6064-3191450b4fc8@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 636d36a..e05ee96 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -61,7 +61,6 @@
 #include <getopt.h>
 #include <limits.h>
 #include <math.h>
-#include <stdarg.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
