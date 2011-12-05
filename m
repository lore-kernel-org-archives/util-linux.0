Return-Path: util-linux-owner@vger.kernel.org
Received: from rrcs-67-78-168-186.se.biz.rr.com ([67.78.168.186]:59372 "EHLO
	iriserv.iradimed.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756295Ab1LEUMq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 Dec 2011 15:12:46 -0500
From: Phillip Susi <psusi@cfl.rr.com>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/4] partx: don't print error when partition already doesn't exist
Date: Mon,  5 Dec 2011 15:02:51 -0500
Message-Id: <1323115372-3983-3-git-send-email-psusi@cfl.rr.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

If you run partx -d to delete partitions, and there are gaps
in the sequence ( partition 2 exists, but 1 doesn't ), then it
would complain that it had errors trying to remove the partitions
that already don't exist. Changed to ignore the error when
errno == ENXIO.

Signed-off-by: Phillip Susi <psusi@cfl.rr.com>
---
 partx/partx.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/partx/partx.c b/partx/partx.c
index 2510ffb..50b0c20 100644
--- a/partx/partx.c
+++ b/partx/partx.c
@@ -303,10 +303,15 @@ static int del_parts(int fd, const char *device, dev_t devno,
 	}
 
 	for (i = lower; i <= upper; i++) {
-		if (partx_del_partition(fd, i) == 0) {
+		rc = partx_del_partition(fd, i);
+		if (rc == 0) {
 			if (verbose)
 				printf(_("%s: partition #%d removed\n"), device, i);
 			continue;
+		} else if (errno == ENXIO) {
+			if (verbose)
+				printf(_("%s: partition #%d already doesn't exist\n"), device, i);
+			continue;
 		}
 		rc = -1;
 		if (verbose)
-- 
1.7.5.4

