Return-Path: util-linux-owner@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37824 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932858AbeFUQHl (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Thu, 21 Jun 2018 12:07:41 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5LG4YIb052823
        for <util-linux@vger.kernel.org>; Thu, 21 Jun 2018 12:07:40 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jrd2fxp3r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <util-linux@vger.kernel.org>; Thu, 21 Jun 2018 12:07:40 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <util-linux@vger.kernel.org> from <kmahlkuc@linux.vnet.ibm.com>;
        Thu, 21 Jun 2018 10:07:39 -0600
From: kmahlkuc@linux.vnet.ibm.com
To: util-linux@vger.kernel.org
Cc: KyleMahlkuch <Kyle.Mahlkuch@ibm.com>
Subject: [PATCH] libfdisk: Fix multipath partition seperators for user-friendly names
Date: Thu, 21 Jun 2018 11:07:34 -0500
Message-Id: <1529597254-1342-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: KyleMahlkuch <Kyle.Mahlkuch@ibm.com>

The current code assumes "-part" is the only partition sepereator
but this is not true for some distros.

For example in Ubuntu 18.04 fdisk does not print the correct names for
mpatha:

~# ls -l /dev/mapper/mpatha*
lrwxrwxrwx 1 root root 7 Feb  1 04:39 /dev/mapper/mpatha -> ../dm-0
lrwxrwxrwx 1 root root 7 Feb  1 04:38 /dev/mapper/mpatha1 -> ../dm-4
lrwxrwxrwx 1 root root 7 Feb  1 04:38 /dev/mapper/mpatha2 -> ../dm-5
lrwxrwxrwx 1 root root 7 Feb  1 04:38 /dev/mapper/mpatha3 -> ../dm-6

~# fdisk -l /dev/mapper/mpatha
Device                   Boot     Start        End   Sectors  Size Id Type
/dev/mapper/mpatha-part1           2048  419432447 419430400  200G 83 Linux
/dev/mapper/mpatha-part2      419432448  838862847 419430400  200G 83 Linux
/dev/mapper/mpatha-part3      838862848 1258291199 419428352  200G 83 Linux

Instead of assuming a partition seperator of "-part" this patch uses
access to check the file system for a partition seperator of "p" or
the absense of a partition seperator. If neither of these work the patch
defaults to "-part" like we had before this patch.

Signed-off-by: Kyle Mahlkuch <Kyle.Mahlkuch@ibm.com>
---
 libfdisk/src/utils.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/libfdisk/src/utils.c b/libfdisk/src/utils.c
index 5ba9e04..031c783 100644
--- a/libfdisk/src/utils.c
+++ b/libfdisk/src/utils.c
@@ -153,7 +153,18 @@ char *fdisk_partname(const char *dev, size_t partno)
 	if ((strncmp(dev, _PATH_DEV_BYID, sizeof(_PATH_DEV_BYID) - 1) == 0) ||
 	     strncmp(dev, _PATH_DEV_BYPATH, sizeof(_PATH_DEV_BYPATH) - 1) == 0 ||
 	     strncmp(dev, "/dev/mapper", sizeof("/dev/mapper") - 1) == 0) {
-	       p = "-part";
+		asprintf(&res, "%.*s%zu", w, dev, partno);
+		if (access(res, F_OK) == 0){
+			p = "";
+		} else {
+			/* check for partition seperator "p" */
+			p = "p";
+			asprintf(&res, "%.*s%s%zu", w, dev, p, partno);
+			if (access(res, F_OK) != 0){
+				/* otherwise, default to "-path" */
+				p = "-part";
+			}
+		}
 	}
 
 	if (asprintf(&res, "%.*s%s%zu", w, dev, p, partno) <= 0)
-- 
1.8.3.1

