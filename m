Return-Path: dave@gnu.org
Subject: [PATCH] [LIB] sysfs: free used resources
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 24 Jul 2011 18:50:38 -0400
Message-ID: <1311547838.3367.2.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>
Date: Sun, 24 Jul 2011 11:22:52 -0400

In the sysfs lib example, we should be using sysfs_deinit() to free used resources and for correct usage.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 lib/sysfs.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/lib/sysfs.c b/lib/sysfs.c
index b9ddc67..7bcdaba 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -488,6 +488,7 @@ int main(int argc, char *argv[])
 
 	printf("DEVNAME: %s\n", sysfs_get_devname(&cxt, path, sizeof(path)));
 
+	sysfs_deinit(&cxt);
 	return EXIT_SUCCESS;
 }
 #endif
-- 
1.7.4.1
