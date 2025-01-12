Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C131BC9E2
	for <util-linux@vger.kernel.org>; Sun, 12 Jan 2025 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736696392; cv=none; b=UFxUl/5zlwfctdmec1lggyBjY4YRzARTzr2pjtKIA035PPXcG3IvH5uti0ZKuM57WIWluw5MWGkhZ30Tf8oRIWZBVceP36BzyKOno5VkEDx+jJa1lgstZRENdr/y9V91xCbDJ1UuDDhOHiZ7J8hhpvBp2BjgOiqQ7wDQS+GERvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736696392; c=relaxed/simple;
	bh=FLinifE0bvNHo5hjNGRUf+SS3i3lveXaZaL2hDcIf2Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BzDGQcWRg30xGcUefyRDjBH4Tm5zw0p9rZ2Hgc6QrqZiyzHwJQRfNrkbp71cx9LpJL6gE6LI7H5B5hdwOCZzwVQ5XCx34ZipWr6oMaoEAXbgzIBIvUi83cetkeuHtTgL0xAXyKypvHnYy8grioc2xHI/vgwjTGaqQK19m7frPLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=PW3iWtLd; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="PW3iWtLd"
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <samuel.thibault@gnu.org>)
	id 1tX044-00049C-VX
	for util-linux@vger.kernel.org; Sun, 12 Jan 2025 10:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Subject:To:From:Date:in-reply-to:
	references; bh=KWxRMFhqQ+DPXejCzRcDuFXduf/aDZy0P7BehEVcXAM=; b=PW3iWtLdnhTXMa
	1pE9d06l8WDhnuweFcSmu46m+piLD7ssOTmfd8Cs4F4laCMi0d4dVpk2yBTyRYnzAmjemfTs8IhUT
	F81o3WxkDUmpQPjP0QlnnWrZ2LzpQCc7BLdAyQUOsyvkkbaqbCgZerK5SPt6Rf5HiFA5P6KR9aZdC
	rtDt3pe3dMuv1yTRipAYzFo+wQwXPTFTAvVb6o7sh39LfFVX8senTb3FmsrRjre20++pyrBqKTeHr
	Lcur1SoG9FsSeUzP+ClewRcsvUTqswZqJ2FTjHbRBkfCBw5sLYTw8+1T3cOGvVMEx8S0Vb+lj3Ah0
	bs3UMWUHIkrLaCrCW5AQ==;
Date: Sun, 12 Jan 2025 16:39:44 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] Fix non-Linux build
Message-ID: <Z4PiQCAhViwlpqnG@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@gnu.org>,
	util-linux@vger.kernel.org
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: I am not organized

This fixes non-Linux builds, by:

- making sfdisk discard option conditioned by availability of BLKDISCARD
- defining and using blkid_probe_get_buffer only if O_DIRECT is
  available
- always building src/fs_statmount.c and src/tab_listmount.c, they
  already contain proper conditions to make them void if support is not
  available.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index 5e7c1d926..d8261c442 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -1370,6 +1370,7 @@ static int command_partattrs(struct sfdisk *sf, int argc, char **argv)
 	return write_changes(sf);
 }
 
+#ifdef BLKDISCARD
 /*
  * sfdisk --discard-free <device>
  */
@@ -1432,6 +1433,12 @@ done:
 	fdisk_unref_table(tb);
 	return rc;
 }
+#else /* BLKDISCARD */
+static int command_discard_free(struct sfdisk *sf, int argc, char **argv)
+{
+	fdisk_warnx(sf->cxt, _("Discard unsupported on your system."));
+}
+#endif /* BLKDISCARD */
 
 /*
  * sfdisk --disk-id <device> [<str>]
diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
index 5a156251c..61b93021c 100644
--- a/libblkid/src/probe.c
+++ b/libblkid/src/probe.c
@@ -791,6 +791,7 @@ const unsigned char *blkid_probe_get_buffer(blkid_probe pr, uint64_t off, uint64
 	return real_off ? bf->data + (real_off - bf->off + bias) : bf->data + bias;
 }
 
+#ifdef O_DIRECT
 /*
  * This is blkid_probe_get_buffer with the read done as an O_DIRECT operation.
  * Note that @off is offset within probing area, the probing area is defined by
@@ -817,6 +818,7 @@ const unsigned char *blkid_probe_get_buffer_direct(blkid_probe pr, uint64_t off,
 	}
 	return ret;
 }
+#endif
 
 /**
  * blkid_probe_reset_buffers:
diff --git a/libblkid/src/superblocks/ext.c b/libblkid/src/superblocks/ext.c
index 7a9f8c9b9..c0779c233 100644
--- a/libblkid/src/superblocks/ext.c
+++ b/libblkid/src/superblocks/ext.c
@@ -164,6 +164,7 @@ static struct ext2_super_block *ext_get_super(
 		 * then declare a checksum mismatch.
 		 */
 		if (!blkid_probe_verify_csum(pr, csum, le32_to_cpu(es->s_checksum))) {
+#ifdef O_DIRECT
 			if (blkid_probe_reset_buffers(pr))
 				return NULL;
 
@@ -175,6 +176,9 @@ static struct ext2_super_block *ext_get_super(
 			csum = crc32c(~0, es, offsetof(struct ext2_super_block, s_checksum));
 			if (!blkid_probe_verify_csum(pr, csum, le32_to_cpu(es->s_checksum)))
 				return NULL;
+#else
+			return NULL;
+#endif
 		}
 	}
 	if (fc)
diff --git a/libmount/meson.build b/libmount/meson.build
index 05b31d4d4..29a43be02 100644
--- a/libmount/meson.build
+++ b/libmount/meson.build
@@ -24,6 +24,7 @@ lib_mount_sources = '''
   src/mountP.h
   src/cache.c
   src/fs.c
+  src/fs_statmount.c
   src/init.c
   src/iter.c
   src/lock.c
@@ -31,6 +32,7 @@ lib_mount_sources = '''
   src/optstr.c
   src/tab.c
   src/tab_diff.c
+  src/tab_listmount.c
   src/tab_parse.c
   src/tab_update.c
   src/test.c
@@ -43,8 +45,6 @@ lib_mount_sources = '''
 
 if LINUX
   lib_mount_sources += '''
-    src/fs_statmount.c
-    src/tab_listmount.c
     src/hooks.c
     src/monitor.c
     src/optlist.c
diff --git a/libmount/src/Makemodule.am b/libmount/src/Makemodule.am
index 49f6d6f03..5a5c787a4 100644
--- a/libmount/src/Makemodule.am
+++ b/libmount/src/Makemodule.am
@@ -11,6 +11,7 @@ libmount_la_SOURCES = \
 	libmount/src/mountP.h \
 	libmount/src/cache.c \
 	libmount/src/fs.c \
+	libmount/src/fs_statmount.c \
 	libmount/src/init.c \
 	libmount/src/iter.c \
 	libmount/src/lock.c \
@@ -19,6 +20,7 @@ libmount_la_SOURCES = \
 	libmount/src/optstr.c \
 	libmount/src/tab.c \
 	libmount/src/tab_diff.c \
+	libmount/src/tab_listmount.c \
 	libmount/src/tab_parse.c \
 	libmount/src/tab_update.c \
 	libmount/src/test.c \
@@ -30,8 +32,6 @@ libmount_la_SOURCES += \
 	libmount/src/context.c \
 	libmount/src/context_mount.c \
 	libmount/src/context_umount.c \
-	libmount/src/fs_statmount.c \
-	libmount/src/tab_listmount.c \
 	libmount/src/hooks.c \
 	libmount/src/hook_mount.c \
 	libmount/src/hook_mount_legacy.c \
