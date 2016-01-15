Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:50263 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752872AbcAOVkG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 15 Jan 2016 16:40:06 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1aKC6F-0005Gz-Vg
	for util-linux@vger.kernel.org; Fri, 15 Jan 2016 22:40:04 +0100
Received: from 95.131.151.139 ([95.131.151.139])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Fri, 15 Jan 2016 22:40:03 +0100
Received: from yumkam by 95.131.151.139 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Fri, 15 Jan 2016 22:40:03 +0100
To: util-linux@vger.kernel.org
From: yumkam@gmail.com (Yuriy M. Kaminskiy)
Subject: [PATCH] fix lsns failure after zombie process
Date: Sat, 16 Jan 2016 00:38:00 +0300
Message-ID: <m3r3hih6br.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

(At least on kernel 3.16), stat("/proc/${pid_of_zombie}/ns/mnt") returns
-ENOENT, as a result lsns stops scanning processes prematurely.

--- util-linux.orig/sys-utils/lsns.c
+++ util-linux/sys-utils/lsns.c
@@ -308,7 +308,7 @@ static int read_processes(struct lsns *l
 
 	while (proc_next_pid(proc, &pid) == 0) {
 		rc = read_process(ls, pid);
-		if (rc && rc != -EACCES)
+		if (rc && rc != -EACCES && rc != -ENOENT)
 			break;
 		rc = 0;
 	}

