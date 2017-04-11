Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:49774 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752693AbdDKOMy (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 11 Apr 2017 10:12:54 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2CE2EAAB2
        for <util-linux@vger.kernel.org>; Tue, 11 Apr 2017 14:12:53 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] libmount: Ensure utab.lock mode 644
Message-ID: <e837973e-9f84-827f-ba86-1799d291bf8b@suse.cz>
Date: Tue, 11 Apr 2017 16:12:52 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

If utab.lock is created by a process with a restricted umask, utab.lock is
created with restricted permissions. It breaks userspace monitor.

Ensure that the mode is always 644.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 libmount/src/lock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/libmount/src/lock.c b/libmount/src/lock.c
index 06eff1344..f9d0253fb 100644
--- a/libmount/src/lock.c
+++ b/libmount/src/lock.c
@@ -220,6 +220,11 @@ static int lock_simplelock(struct libmnt_lock *ml)
 		rc = -errno;
 		goto err;
 	}
+	rc = fchmod(ml->lockfile_fd, S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH);
+	if (rc < 0) {
+		rc = -errno;
+		goto err;
+	}
 
 	while (flock(ml->lockfile_fd, LOCK_EX) < 0) {
 		int errsv;
-- 
2.12.2

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Køi¾íkova 148/34 (Corso IIa)                  tel: +49 911 7405384547
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
