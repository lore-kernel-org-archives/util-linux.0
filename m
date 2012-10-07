Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcbbj.dreamhost.com ([208.97.132.119]:35799 "EHLO
	homiemail-a38.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753129Ab2JGOeL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Oct 2012 10:34:11 -0400
Message-ID: <1349620448.2548.10.camel@offbook>
Subject: [PATCH 5/5] fdisk: gpt: use swap_efi_guid for new partitions
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Date: Sun, 07 Oct 2012 16:34:08 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisks/gpt.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/fdisks/gpt.c b/fdisks/gpt.c
index 467b944..5b792a6 100644
--- a/fdisks/gpt.c
+++ b/fdisks/gpt.c
@@ -1430,17 +1430,7 @@ static int gpt_create_new_partition(int partnum, uint64_t fsect, uint64_t lsect,
 	 * to have a unique GUID.
 	 */
 	uuid_generate_random((unsigned char *) &e->unique_partition_guid);
-
-	/*
-	 * UUID is traditionally 16 byte big-endian array, except Intel EFI
-	 * specs where the UUID is a structure of little-endian fields, convert.
-	 */
-	e->unique_partition_guid.time_low =
-		cpu_to_le32(e->unique_partition_guid.time_low);
-	e->unique_partition_guid.time_mid =
-		cpu_to_le16(e->unique_partition_guid.time_mid);
-	e->unique_partition_guid.time_hi_and_version =
-		cpu_to_le16(e->unique_partition_guid.time_hi_and_version);
+	swap_efi_guid(&e->unique_partition_guid);
 
 	memcpy(&entries[partnum] , e, sizeof(*e));
 
-- 
1.7.9.5




