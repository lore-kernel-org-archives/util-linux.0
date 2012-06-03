Return-Path: dave@gnu.org
Subject: [PATCH 4/5] fdisk: use EXIT_SUCCESS for -l option
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 03 Jun 2012 20:15:30 +0200
Message-ID: <1338747330.2864.13.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index d8ef14f..baa5bad 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -2122,7 +2122,7 @@ int main(int argc, char **argv)
 				print_partition_table_from_option(argv[k], sector_size);
 		} else
 			print_all_partition_table_from_option(sector_size);
-		exit(0);
+		exit(EXIT_SUCCESS);
 	}
 
 	if (opts) {
-- 
1.7.4.1
