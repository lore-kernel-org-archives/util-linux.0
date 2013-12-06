Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:15885 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752511Ab3LFVH5 (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Fri, 6 Dec 2013 16:07:57 -0500
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id rB6L7uam024158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux-ng@vger.kernel.org>; Fri, 6 Dec 2013 16:07:56 -0500
Date: Fri, 6 Dec 2013 16:07:54 -0500
From: Rik van Riel <riel@redhat.com>
To: util-linux-ng@vger.kernel.org
Cc: kzak@redhat.com, jmario@redhat.com
Subject: [PATCH] fix PERMISSIONS section of taskset man page
Message-ID: <20131206160754.1b162955@annuminas.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

A user is always allowed to change the CPU affinity of his or her
own processes. CAP_SYS_NICE is only required to change the affinity
of another user's process.

Signed-off-by: Rik van Riel <riel@redhat.com>
Reported-by: Joe Mario <jmario@redhat.com>
---
 schedutils/taskset.1 | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/schedutils/taskset.1 b/schedutils/taskset.1
index ade202b..916bce7 100644
--- a/schedutils/taskset.1
+++ b/schedutils/taskset.1
@@ -102,10 +102,11 @@ Display version information and exit.
 .B taskset \-p
 .I mask pid
 .SH PERMISSIONS
+A user can change the CPU affinity of a process belonging to the same user.
 A user must possess
 .B CAP_SYS_NICE
-to change the CPU affinity of a process.  Any user can retrieve the affinity
-mask.
+to change the CPU affinity of a process belonging to another user. 
+A user can retrieve the affinity mask of any process.
 .SH AUTHOR
 Written by Robert M. Love.
 .SH COPYRIGHT
