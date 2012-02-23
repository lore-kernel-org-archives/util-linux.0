Return-Path: heiko.carstens@de.ibm.com
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Chandan B Rajenda <chandan@linux.vnet.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH] lib/strutils.c: Move array bounds check in string_to_idarray() to appropriate place.
Date: Thu, 23 Feb 2012 10:17:28 +0100
Message-Id: <1329988648-21830-1-git-send-email-heiko.carstens@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

From: Chandan B Rajenda <chandan@linux.vnet.ibm.com>

string_to_idarray() will incorrectly exit with an error when the last element
of the passed in array gets filled.
However it should only exit with an error if there is more input. To fix this
move the array bounds check.

Signed-off-by: Chandan B Rajenda <chandan@linux.vnet.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 lib/strutils.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/strutils.c b/lib/strutils.c
index 7586160..c40daf2 100644
--- a/lib/strutils.c
+++ b/lib/strutils.c
@@ -393,6 +393,8 @@ int string_to_idarray(const char *list, int ary[], size_t arysz,
 		const char *end = NULL;
 		int id;
 
+		if (n >= arysz)
+			return -2;
 		if (!begin)
 			begin = p;		/* begin of the column name */
 		if (*p == ',')
@@ -408,8 +410,6 @@ int string_to_idarray(const char *list, int ary[], size_t arysz,
 		if (id == -1)
 			return -1;
 		ary[ n++ ] = id;
-		if (n >= arysz)
-			return -2;
 		begin = NULL;
 		if (end && !*end)
 			break;
-- 
1.7.9
