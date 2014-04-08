Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33496 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756272AbaDHHs7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 8 Apr 2014 03:48:59 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s387mxQ6008383
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 8 Apr 2014 03:48:59 -0400
Received: from redhat.brq.redhat.com (unused-4-202.brq.redhat.com [10.34.4.202])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s387moTq004800
	for <util-linux@vger.kernel.org>; Tue, 8 Apr 2014 03:48:58 -0400
From: Ondrej Oprala <ooprala@redhat.com>
To: util-linux@vger.kernel.org
Subject: [PATCH 08/10] addpart: minor man page improvements
Date: Tue,  8 Apr 2014 09:48:47 +0200
Message-Id: <1396943329-22347-9-git-send-email-ooprala@redhat.com>
In-Reply-To: <1396943329-22347-1-git-send-email-ooprala@redhat.com>
References: <1396943329-22347-1-git-send-email-ooprala@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Ondrej Oprala <ooprala@redhat.com>
---
 disk-utils/addpart.8 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/disk-utils/addpart.8 b/disk-utils/addpart.8
index 9dcd0a3..875ca9e 100644
--- a/disk-utils/addpart.8
+++ b/disk-utils/addpart.8
@@ -5,15 +5,15 @@
 .TH ADDPART 8 "January 2007" "util-linux" "System Administration"
 .SH NAME
 addpart \-
-simple wrapper around the "add partition" ioctl
+a simple wrapper around the "add partition" ioctl
 .SH SYNOPSIS
 .B addpart
 .I device partition start length
 .SH DESCRIPTION
 .B addpart
-is a program that informs the Linux kernel of new partition.
+is a program that informs the Linux kernel of a new partition.
 
-This command doesn't manipulate partitions on hard drive.
+This command doesn't manipulate partitions on the hard drive.
 
 .SH PARAMETERS
 .TP
@@ -24,7 +24,7 @@ Specify the disk device.
 Specify the partition number.
 .TP
 .I start
-Specify the begin of the partition (in 512-byte sectors).
+Specify the beginning of the partition (in 512-byte sectors).
 .TP
 .I length
 Specify the length of the partition (in 512-byte sectors).
-- 
1.8.5.1

