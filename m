Return-Path: dave@gnu.org
Subject: [PATCH] mkfs.minix: check for misalignment
From: Davidlohr Bueso <dave@gnu.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 20 Jun 2011 23:11:46 -0400
Message-ID: <1308625906.3690.2.camel@offworld>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>
Date: Mon, 20 Jun 2011 23:10:13 -0400

Produce a warning if the device is misaligned.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 disk-utils/mkfs.minix.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index 405e241..bc7d941 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -653,6 +653,11 @@ int main(int argc, char ** argv) {
 		DEV = open(device_name,O_RDWR | O_EXCL);
 	else
 		DEV = open(device_name,O_RDWR);
+
+	if (blkdev_is_misaligned(DEV))
+		warnx(_("warning: %s is misaligned"), device_name);
+
+
 	if (DEV<0)
 		err(MKFS_ERROR, _("%s: open failed"), device_name);
 	if (S_ISBLK(statbuf.st_mode)) {
-- 
1.7.5.4
