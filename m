Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f174.google.com ([209.85.212.174]:61880 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614Ab2LPKoa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Dec 2012 05:44:30 -0500
Received: by mail-wi0-f174.google.com with SMTP id hm9so1394205wib.1
        for <util-linux@vger.kernel.org>; Sun, 16 Dec 2012 02:44:29 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 09/14] minix: change types in header file
Date: Sun, 16 Dec 2012 10:43:57 +0000
Message-Id: <1355654642-22106-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1355654642-22106-1-git-send-email-kerolasa@iki.fi>
References: <1355654642-22106-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/minix_programs.h | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/disk-utils/minix_programs.h b/disk-utils/minix_programs.h
index 4af1a34..7ad308d 100644
--- a/disk-utils/minix_programs.h
+++ b/disk-utils/minix_programs.h
@@ -28,7 +28,7 @@ static inline unsigned long get_ninodes(void)
 	case 3:
 		return Super3.s_ninodes;
 	default:
-		return (unsigned long)Super.s_ninodes;
+		return Super.s_ninodes;
 	}
 }
 
@@ -36,11 +36,11 @@ static inline unsigned long get_nzones(void)
 {
 	switch (fs_version) {
 	case 3:
-		return (unsigned long)Super3.s_zones;
+		return Super3.s_zones;
 	case 2:
-		return (unsigned long)Super.s_zones;
+		return Super.s_zones;
 	default:
-		return (unsigned long)Super.s_nzones;
+		return Super.s_nzones;
 	}
 }
 
@@ -48,9 +48,9 @@ static inline unsigned long get_nimaps(void)
 {
 	switch (fs_version) {
 	case 3:
-		return (unsigned long)Super3.s_imap_blocks;
+		return Super3.s_imap_blocks;
 	default:
-		return (unsigned long)Super.s_imap_blocks;
+		return Super.s_imap_blocks;
 	}
 }
 
@@ -58,43 +58,43 @@ static inline unsigned long get_nzmaps(void)
 {
 	switch (fs_version) {
 	case 3:
-		return (unsigned long)Super3.s_zmap_blocks;
+		return Super3.s_zmap_blocks;
 	default:
-		return (unsigned long)Super.s_zmap_blocks;
+		return Super.s_zmap_blocks;
 	}
 }
 
-static inline unsigned long get_first_zone(void)
+static inline off_t get_first_zone(void)
 {
 	switch (fs_version) {
 	case 3:
-		return (unsigned long)Super3.s_firstdatazone;
+		return Super3.s_firstdatazone;
 	default:
-		return (unsigned long)Super.s_firstdatazone;
+		return Super.s_firstdatazone;
 	}
 }
 
-static inline unsigned long get_zone_size(void)
+static inline size_t get_zone_size(void)
 {
 	switch (fs_version) {
 	case 3:
-		return (unsigned long)Super3.s_log_zone_size;
+		return Super3.s_log_zone_size;
 	default:
-		return (unsigned long)Super.s_log_zone_size;
+		return Super.s_log_zone_size;
 	}
 }
 
-static inline unsigned long get_max_size(void)
+static inline size_t get_max_size(void)
 {
 	switch (fs_version) {
 	case 3:
-		return (unsigned long)Super3.s_max_size;
+		return Super3.s_max_size;
 	default:
-		return (unsigned long)Super.s_max_size;
+		return Super.s_max_size;
 	}
 }
 
-static unsigned long inode_blocks(void)
+static inline unsigned long inode_blocks(void)
 {
 	switch (fs_version) {
 	case 3:
@@ -105,12 +105,12 @@ static unsigned long inode_blocks(void)
 	}
 }
 
-static inline unsigned long first_zone_data(void)
+static inline off_t first_zone_data(void)
 {
 	return 2 + get_nimaps() + get_nzmaps() + inode_blocks();
 }
 
-static inline unsigned long get_inode_buffer_size(void)
+static inline size_t get_inode_buffer_size(void)
 {
 	return inode_blocks() * MINIX_BLOCK_SIZE;
 }
-- 
1.8.0.2

