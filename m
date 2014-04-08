Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:15129 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756350AbaDHHtB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 8 Apr 2014 03:49:01 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s387n1as008388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 8 Apr 2014 03:49:01 -0400
Received: from redhat.brq.redhat.com (unused-4-202.brq.redhat.com [10.34.4.202])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s387moTs004800
	for <util-linux@vger.kernel.org>; Tue, 8 Apr 2014 03:49:00 -0400
From: Ondrej Oprala <ooprala@redhat.com>
To: util-linux@vger.kernel.org
Subject: [PATCH 10/10] delpart: minor man page improvements
Date: Tue,  8 Apr 2014 09:48:49 +0200
Message-Id: <1396943329-22347-11-git-send-email-ooprala@redhat.com>
In-Reply-To: <1396943329-22347-1-git-send-email-ooprala@redhat.com>
References: <1396943329-22347-1-git-send-email-ooprala@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Ondrej Oprala <ooprala@redhat.com>
---
 disk-utils/delpart.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disk-utils/delpart.8 b/disk-utils/delpart.8
index 433582f..5f90ec1 100644
--- a/disk-utils/delpart.8
+++ b/disk-utils/delpart.8
@@ -13,7 +13,7 @@ simple wrapper around the "del partition" ioctl
 .B delpart
 is a program that asks the Linux kernel to remove a partition.
 
-This command doesn't manipulate partitions on hard drive.
+This command doesn't manipulate partitions on a hard drive.
 
 .SH OPTIONS
 .TP
-- 
1.8.5.1

