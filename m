Return-Path: dave@gnu.org
Subject: [PATCH] strutils: return success on test program
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 05 Apr 2012 22:35:19 +0200
Message-ID: <1333658119.2696.0.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 lib/strutils.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/strutils.c b/lib/strutils.c
index db15110..4774614 100644
--- a/lib/strutils.c
+++ b/lib/strutils.c
@@ -568,6 +568,6 @@ int main(int argc, char *argv[])
 	free(hum);
 	free(hum2);
 
-	return EXIT_FAILURE;
+	return EXIT_SUCCESS;
 }
 #endif /* TEST_PROGRAM */
-- 
1.7.4.1
