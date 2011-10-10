Return-Path: util-linux-owner@vger.kernel.org
Received: from mtagate2.uk.ibm.com ([194.196.100.162]:37255 "EHLO
	mtagate2.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752991Ab1JJJAc (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 10 Oct 2011 05:00:32 -0400
Received: from d06nrmr1307.portsmouth.uk.ibm.com (d06nrmr1307.portsmouth.uk.ibm.com [9.149.38.129])
	by mtagate2.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p9A90VIm030078
	for <util-linux@vger.kernel.org>; Mon, 10 Oct 2011 09:00:31 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com [9.149.37.228])
	by d06nrmr1307.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p9A90UM72351296
	for <util-linux@vger.kernel.org>; Mon, 10 Oct 2011 10:00:30 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p9A90Qrv004850
	for <util-linux@vger.kernel.org>; Mon, 10 Oct 2011 03:00:26 -0600
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 1/6] lscpu: switch Yes/No output to lower case
Date: Mon, 10 Oct 2011 10:59:39 +0200
Message-Id: <1318237184-6616-2-git-send-email-heiko.carstens@de.ibm.com>
In-Reply-To: <1318237184-6616-1-git-send-email-heiko.carstens@de.ibm.com>
References: <1318237184-6616-1-git-send-email-heiko.carstens@de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Some people complained about the first letter of Yes/No as seen in the
online and configured column in the human readabe output being a capital
letter instead of the expected lower case letter.
So let's try to make everbody happy and convert them to lower case.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/lscpu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 8637ef1..66fa971 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -850,7 +850,7 @@ get_cell_data(struct lscpu_desc *desc, int cpu, int col,
 				 desc->configured[cpu] ? _("Y") : _("N"));
 		else
 			snprintf(buf, bufsz,
-				 desc->configured[cpu] ? _("Yes") : _("No"));
+				 desc->configured[cpu] ? _("yes") : _("no"));
 		break;
 	case COL_ONLINE:
 		if (!desc->online)
@@ -860,7 +860,7 @@ get_cell_data(struct lscpu_desc *desc, int cpu, int col,
 				 is_cpu_online(desc, cpu) ? _("Y") : _("N"));
 		else
 			snprintf(buf, bufsz,
-				 is_cpu_online(desc, cpu) ? _("Yes") : _("No"));
+				 is_cpu_online(desc, cpu) ? _("yes") : _("no"));
 		break;
 	}
 	return buf;
-- 
1.7.6.3

