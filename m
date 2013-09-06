Return-Path: g2p.code@gmail.com
From: Gabriel de Perthuis <g2p.code@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: Rolf Fokkens <rolf@rolffokkens.nl>, util-linux@vger.kernel.org,
        Gabriel de Perthuis <g2p.code@gmail.com>
Subject: [PATCH 2/2] wipefs: Also wipe superblocks with bad checksums
Date: Fri,  6 Sep 2013 20:11:29 +0200
Message-Id: <1378491089-1135-3-git-send-email-g2p.code@gmail.com>
In-Reply-To: <1378491089-1135-1-git-send-email-g2p.code@gmail.com>
References: <1378491089-1135-1-git-send-email-g2p.code@gmail.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Gabriel de Perthuis <g2p.code@gmail.com>
---
 libblkid/src/blkid.h.in                | 1 +
 libblkid/src/superblocks/superblocks.c | 3 ++-
 misc-utils/wipefs.c                    | 3 ++-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/libblkid/src/blkid.h.in b/libblkid/src/blkid.h.in
index 2a7d6b4..c140fc6 100644
--- a/libblkid/src/blkid.h.in
+++ b/libblkid/src/blkid.h.in
@@ -258,10 +258,11 @@ extern int blkid_probe_enable_superblocks(blkid_probe pr, int enable);
 #define BLKID_SUBLKS_TYPE	(1 << 5) /* define TYPE result value */
 #define BLKID_SUBLKS_SECTYPE	(1 << 6) /* define compatible fs type (second type) */
 #define BLKID_SUBLKS_USAGE	(1 << 7) /* define USAGE result value */
 #define BLKID_SUBLKS_VERSION	(1 << 8) /* read FS type from superblock */
 #define BLKID_SUBLKS_MAGIC	(1 << 9) /* define SBMAGIC and SBMAGIC_OFFSET */
+#define BLKID_SUBLKS_BADCSUM	(1 << 10) /* allow a bad checksum */
 
 #define BLKID_SUBLKS_DEFAULT	(BLKID_SUBLKS_LABEL | BLKID_SUBLKS_UUID | \
 				 BLKID_SUBLKS_TYPE | BLKID_SUBLKS_SECTYPE)
 
 extern int blkid_probe_set_superblocks_flags(blkid_probe pr, int flags);
diff --git a/libblkid/src/superblocks/superblocks.c b/libblkid/src/superblocks/superblocks.c
index 2a023f8..29e9f40 100644
--- a/libblkid/src/superblocks/superblocks.c
+++ b/libblkid/src/superblocks/superblocks.c
@@ -390,11 +390,12 @@ static int superblocks_probe(blkid_probe pr, struct blkid_chain *chn)
 		if (pr->csum != pr->csum_expected) {
 			DBG(LOWPROBE, blkid_debug(
 					"incorrect checksum for type %s,"
 					" got %jX, expected %jX",
 					id->name, pr->csum, pr->csum_expected));
-			goto nothing;
+			if (! (chn->flags & BLKID_SUBLKS_BADCSUM))
+				goto nothing;
 		}
 
 		/* all cheks passed */
 		if (chn->flags & BLKID_SUBLKS_TYPE)
 			rc = blkid_probe_set_value(pr, "TYPE",
diff --git a/misc-utils/wipefs.c b/misc-utils/wipefs.c
index 2cfad7c..ff2f62f 100644
--- a/misc-utils/wipefs.c
+++ b/misc-utils/wipefs.c
@@ -246,11 +246,12 @@ new_probe(const char *devname, int mode)
 		goto error;
 
 	blkid_probe_enable_superblocks(pr, 1);
 	blkid_probe_set_superblocks_flags(pr, BLKID_SUBLKS_MAGIC |
 			BLKID_SUBLKS_TYPE | BLKID_SUBLKS_USAGE |
-			BLKID_SUBLKS_LABEL | BLKID_SUBLKS_UUID);
+			BLKID_SUBLKS_LABEL | BLKID_SUBLKS_UUID |
+			BLKID_SUBLKS_BADCSUM);
 
 	blkid_probe_enable_partitions(pr, 1);
 	blkid_probe_set_partitions_flags(pr, BLKID_PARTS_MAGIC);
 
 	return pr;
-- 
1.8.4.25.g05e4ae6
