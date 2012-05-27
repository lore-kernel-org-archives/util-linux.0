Return-Path: dave@gnu.org
Subject: [PATCH 7/7] fdisk: sun: use sector_t
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 27 May 2012 21:44:24 +0200
Message-ID: <1338147864.22474.6.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisksunlabel.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fdisk/fdisksunlabel.c b/fdisk/fdisksunlabel.c
index e94b652..9d5b3e8 100644
--- a/fdisk/fdisksunlabel.c
+++ b/fdisk/fdisksunlabel.c
@@ -152,7 +152,7 @@ int check_sun_label(void)
 void create_sunlabel(struct fdisk_context *cxt)
 {
 	struct hd_geometry geometry;
-	unsigned long long llsectors, llcyls;
+	sector_t llsectors, llcyls;
 	unsigned int ndiv, sec_fac;
 	int res;
 
-- 
1.7.4.1
