Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A13C00140
	for <util-linux@archiver.kernel.org>; Fri,  5 Aug 2022 15:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbiHEP5j (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 5 Aug 2022 11:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241614AbiHEPz6 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 5 Aug 2022 11:55:58 -0400
Received: from toro.web-alm.net (toro.web-alm.net [62.245.132.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94067268
        for <util-linux@vger.kernel.org>; Fri,  5 Aug 2022 08:55:57 -0700 (PDT)
Received: from toro.web-alm.net (localhost.localdomain [127.0.0.1])
        by toro.web-alm.net (8.12.11.20060308/8.12.11/Web-Alm-2003112001) with ESMTP id 275Fo8Pe018449;
        Fri, 5 Aug 2022 17:50:08 +0200
Received: from rack3slot8.osadl.org (uucp@localhost)
        by toro.web-alm.net (8.12.11.20060308/8.12.10/Submit/Web-Alm-2003112001) with bsmtp id 275Fo8pb018447;
        Fri, 5 Aug 2022 17:50:08 +0200
Received: from rack0slot7.osadl.org (rack3slot8.osadl.org [127.0.0.1])
        by rack3slot8.osadl.org (8.13.8/8.13.8/CE-2010120801) with ESMTP id 275Fn00x023860;
        Fri, 5 Aug 2022 17:49:00 +0200
Received: (from root@localhost)
        by rack0slot7.osadl.org (8.17.1/8.17.1/Submit) id 275Fn0aJ2272748;
        Fri, 5 Aug 2022 17:49:00 +0200
Message-ID: <20220805154900.261920576@osadl.org>
User-Agent: quilt/0.66
Date:   Fri, 05 Aug 2022 17:48:21 +0200
From:   Carsten Emde <C.Emde@osadl.org>
To:     util-linux@vger.kernel.org
Cc:     Carsten Emde <C.Emde@osadl.org>
Subject: [PATCH 1/1] Taskset: check first whether affinity is settable
References: <20220805154820.407972387@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Virus-Scanned: ClamAV version 0.94.2, clamav-milter version 0.94.2 on rack3slot8.osadl.org
X-Virus-Status: Clean
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

If the PF_NO_SETAFFINITY process flag is set, the user may not
know why the affinity is not settable. Write a respective message
and do not attempt to set the affinity of this process.

Signed-off-by: Carsten Emde <C.Emde@osadl.org>

---
 schedutils/taskset.c |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

Index: util-linux/schedutils/taskset.c
===================================================================
--- util-linux.orig/schedutils/taskset.c
+++ util-linux/schedutils/taskset.c
@@ -35,6 +35,11 @@
 #include "c.h"
 #include "closestream.h"
 
+#ifndef PF_NO_SETAFFINITY
+#define PF_NO_SETAFFINITY 0x04000000
+#endif
+#define PF_NO_SETAFFINITY_FLAG 9
+
 struct taskset {
 	pid_t		pid;		/* task PID */
 	cpu_set_t	*set;		/* task CPU mask */
@@ -114,6 +119,8 @@ static void __attribute__((__noreturn__)
 
 static void do_taskset(struct taskset *ts, size_t setsize, cpu_set_t *set)
 {
+	char statfilename[32];
+
 	/* read the current mask */
 	if (ts->pid) {
 		if (sched_getaffinity(ts->pid, ts->setsize, ts->set) < 0)
@@ -124,6 +131,33 @@ static void do_taskset(struct taskset *t
 	if (ts->get_only)
 		return;
 
+	/* check whether settable */
+	if (snprintf(statfilename, sizeof(statfilename), "/proc/%d/stat", ts->pid) > 0) {
+		int statfd;
+
+		if ((statfd = open(statfilename, S_IREAD)) > 0) {
+			char stat[1024];
+
+			if (read(statfd, stat, sizeof(stat)) > 0) {
+				char *endptr, *token = strtok(stat, " ");
+				int flags, flagno = PF_NO_SETAFFINITY_FLAG;
+
+				while (token && --flagno > 0)
+					token = strtok(NULL, " ");
+				if (flagno == 0 && *token != '\0') {
+					flags = strtol(token, &endptr, 10);
+					if (endptr == token + strlen(token)) {
+						if (flags & PF_NO_SETAFFINITY) {
+							fputs("warning: affinity cannot be set due to PF_NO_SETAFFINITY flag set\n", stderr);
+							errno = EINVAL;
+							err_affinity(ts->pid, 1);
+						}
+					}
+				}
+			}
+		}
+	}
+
 	/* set new mask */
 	if (sched_setaffinity(ts->pid, setsize, set) < 0)
 		err_affinity(ts->pid, 1);

