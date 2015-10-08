Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42239 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735AbbJHEAr (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 8 Oct 2015 00:00:47 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 27D30550D5
	for <util-linux@vger.kernel.org>; Thu,  8 Oct 2015 04:00:47 +0000 (UTC)
Received: from [10.3.113.58] (ovpn-113-58.phx2.redhat.com [10.3.113.58])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t9840jJf000352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <util-linux@vger.kernel.org>; Thu, 8 Oct 2015 00:00:46 -0400
To: util-linux@vger.kernel.org
Subject: [PATCH] libfdisk: Detect out-of-space when adding new primary
 partition
From: Ian Wienand <iwienand@redhat.com>
Message-ID: <5615EA6C.8000801@redhat.com>
Date: Thu, 8 Oct 2015 15:00:44 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I got a bit confused with the interaction below:

  Command (m for help): p
  Disk /dev/sda: 41 GiB, 43965677568 bytes, 85870464 sectors
    ...
  Device     Boot   Start      End  Sectors  Size Id Type
  /dev/sda1  *       2048  1026047  1024000  500M 83 Linux
  /dev/sda2       1026048 85868543 84842496 40.5G 8e Linux LVM

  Command (m for help): n
  To create more partitions, first replace a primary with an extended partition.

I knew I should have had two primary partitions available, but I did
not notice that the disk was seen as full (I was trying to grow it)

This change detects available primary partitions, and if so indicates
we are out of space, rather than out of partitions.

Signed-off-by: Ian Wienand <iwienand@redhat.com>
---
 libfdisk/src/dos.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/libfdisk/src/dos.c b/libfdisk/src/dos.c
index b337c0b..c04ee71 100644
--- a/libfdisk/src/dos.c
+++ b/libfdisk/src/dos.c
@@ -1598,8 +1598,11 @@ static int dos_add_partition(struct fdisk_context *cxt,
 			}
 			rc = add_logical(cxt, pa, &res);
 		} else {
+			if (free_primary)
+				fdisk_info(cxt, _("All space for primary partitions is in use."));
+			else
 			/* TRANSLATORS: Try to keep this within 80 characters. */
-			fdisk_info(cxt, _("To create more partitions, first replace "
+				fdisk_info(cxt, _("To create more partitions, first replace "
 					  "a primary with an extended partition."));
 			return -EINVAL;
 		}
-- 
2.4.3

