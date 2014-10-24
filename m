Return-Path: elseifthen@gmx.com
Message-ID: <5449BF98.5020103@gmx.com>
Date: Thu, 23 Oct 2014 22:55:20 -0400
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: [PATCH 5/5] hwclock: version prints out of order
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>


The version string was printing after other
messages, it should be the first thing to print.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 6d05d46..5ff5c70 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1879,6 +1879,9 @@ int main(int argc, char **argv)
 		}
 	}
 #endif
+	if (debug)
+		out_version();
+
 	if (argc > 0) {
 		usage(_("%s takes no non-option arguments\n"
 			"You supplied %d\n"), program_invocation_short_name,
@@ -1941,9 +1944,6 @@ int main(int argc, char **argv)
 	}
 #endif

-	if (debug)
-		out_version();
-
 	if (!systz && !predict) {
 		determine_clock_access_method(directisa);
 		if (!ur) {
