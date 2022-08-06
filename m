Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4959C25B0C
	for <util-linux@archiver.kernel.org>; Sat,  6 Aug 2022 23:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiHFXDN (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 6 Aug 2022 19:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiHFXDN (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 6 Aug 2022 19:03:13 -0400
Received: from toro.web-alm.net (toro.web-alm.net [62.245.132.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADC65101E7
        for <util-linux@vger.kernel.org>; Sat,  6 Aug 2022 16:03:11 -0700 (PDT)
Received: from toro.web-alm.net (localhost.localdomain [127.0.0.1])
        by toro.web-alm.net (8.12.11.20060308/8.12.11/Web-Alm-2003112001) with ESMTP id 276N385d023130;
        Sun, 7 Aug 2022 01:03:08 +0200
Received: from rack3slot8.osadl.org (uucp@localhost)
        by toro.web-alm.net (8.12.11.20060308/8.12.10/Submit/Web-Alm-2003112001) with bsmtp id 276N380F023128;
        Sun, 7 Aug 2022 01:03:08 +0200
Received: from rack0slot7.osadl.org (rack3slot8.osadl.org [127.0.0.1])
        by rack3slot8.osadl.org (8.13.8/8.13.8/CE-2010120801) with ESMTP id 276MsLge014583;
        Sun, 7 Aug 2022 00:54:21 +0200
Received: (from root@localhost)
        by rack0slot7.osadl.org (8.17.1/8.17.1/Submit) id 276MsLjD3526821;
        Sun, 7 Aug 2022 00:54:21 +0200
Message-ID: <20220806225421.221956570@osadl.org>
User-Agent: quilt/0.66
Date:   Sun, 07 Aug 2022 00:49:16 +0200
From:   Carsten Emde <C.Emde@osadl.org>
To:     util-linux@vger.kernel.org
Cc:     Carsten Emde <C.Emde@osadl.org>
Subject: [PATCH v2 1/1] Taskset: check first whether affinity is settable
References: <20220806224915.326517265@osadl.org>
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
 schedutils/taskset.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

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
+#define PF_NO_SETAFFINITY_ITEM 9
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
@@ -124,6 +131,52 @@ static void do_taskset(struct taskset *t
 	if (ts->get_only)
 		return;
 
+	/* check whether settable */
+	if (snprintf(statfilename, sizeof(statfilename), "/proc/%d/stat", ts->pid) > 0) {
+		int statfd;
+		char *nosetwarning =
+		    "warning: affinity cannot be set due to PF_NO_SETAFFINITY flag set\n";
+
+		if ((statfd = open(statfilename, O_RDONLY)) > 0) {
+			char stat[1024];
+			int got;
+
+			if ((got = read(statfd, stat, sizeof(stat))) > 0) {
+				char *endptr, *token = stat;
+				int flags, item = PF_NO_SETAFFINITY_ITEM-1;
+
+				token[got] = '\0';
+				while (token != NULL && --item > 0) {
+					token = strchr(token, ' ');
+					if (token != NULL)
+						token++;
+					if (*token != '\0' && *token == '(') {
+						token = strchr(token, ')');
+						if (token != NULL && *token != '\0')
+							token++;
+						if (*token != '\0')
+							token++;
+					}
+				}
+				if (item == 0 && token != NULL && *token != '\0') {
+					char *nextspace = strchr(token, ' ');
+
+					if (nextspace != NULL)
+						*nextspace = '\0';
+					flags = strtol(token, &endptr, 10);
+					if (endptr == token + strlen(token)) {
+						if (flags & PF_NO_SETAFFINITY) {
+							fputs(nosetwarning, stderr);
+							errno = EINVAL;
+							err_affinity(ts->pid, 1);
+						}
+					}
+				}
+			}
+			close(statfd);
+		}
+	}
+
 	/* set new mask */
 	if (sched_setaffinity(ts->pid, setsize, set) < 0)
 		err_affinity(ts->pid, 1);

