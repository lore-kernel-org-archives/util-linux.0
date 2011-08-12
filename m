Return-Path: dave@gnu.org
Subject: [PATCH] partx: do not print null
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 12 Aug 2011 15:38:31 -0400
Message-ID: <1313177911.3305.10.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>
Date: Fri, 12 Aug 2011 15:36:50 -0400

Replace the annoying null output when displaying no partitions in verbose mode.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 partx/partx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/partx/partx.c b/partx/partx.c
index b2a72ed..0b35f9f 100644
--- a/partx/partx.c
+++ b/partx/partx.c
@@ -795,7 +795,7 @@ int main(int argc, char **argv)
 
 	if (verbose)
 		printf(_("partition: %s, disk: %s, lower: %d, upper: %d\n"),
-				device, wholedisk, lower, upper);
+		       device ? device : "none", wholedisk, lower, upper);
 
 	if (what == ACT_ADD || what == ACT_DELETE) {
 		struct stat x;
-- 
1.7.4.1
