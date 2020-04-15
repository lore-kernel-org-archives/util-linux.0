Return-Path: <SRS0=c7ae=57=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4352C2BA19
	for <util-linux@archiver.kernel.org>; Wed, 15 Apr 2020 21:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BB4D20732
	for <util-linux@archiver.kernel.org>; Wed, 15 Apr 2020 21:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fami-braun.de header.i=@fami-braun.de header.b="m/s9cFOP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438889AbgDOVUI (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 15 Apr 2020 17:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438818AbgDOVUF (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 15 Apr 2020 17:20:05 -0400
X-Greylist: delayed 184 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Apr 2020 14:20:04 PDT
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de [IPv6:2a01:238:20a:202:5300::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0ACC061A0C
        for <util-linux@vger.kernel.org>; Wed, 15 Apr 2020 14:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1586985603;
        s=strato-dkim-0002; d=fami-braun.de;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=kEPbLDkumZhcdnYd8qL6fJ0ivFzWhslZIIk8uGl8WlE=;
        b=m/s9cFOPOI3c6JChQT+/u6bWsVrJHCjuz11o1Lh3DjkhLd2w9HLxkjkexocH6jwiKi
        Q9c3zIAayrS/mYVgKeq7cYNtkH+ET5AVd4Pzk2tRcSzkWW002TcquFvX3A7HhLcyMXAQ
        6HBUTO8FkcXpwtQx6908wPEf+527ynXZbJccsjVQaBFnmvzLXvrgaS0U2rdpT9BAlVEY
        deHOoX7rOtXn1doXLrC5q8dDxk5Gm/HMsLaHulABfbglr2xWjZSCIqfiHUAsS8mTqN4e
        u3zKxgOMz+tboLSZBSO6tkRygXYEr0Snda2oCeCTpIW0eYcs+K8ZI2n0NwVH8E0gr9eo
        Lqlg==
X-RZG-AUTH: ":P20JeEWkefDI1ODZs1HHtgV3eF0OpFsRaGIBEm4ljegySSvO7VhbcRIBGrxpew95lCZXlpLYMugbKw=="
X-RZG-CLASS-ID: mo00
Received: from dynamic.fami-braun.de
        by smtp.strato.de (RZmta 46.4.0 DYNA|AUTH)
        with ESMTPSA id m09e07w3FLGw3V2
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate)
        for <util-linux@vger.kernel.org>;
        Wed, 15 Apr 2020 23:16:58 +0200 (CEST)
Received: from dynamic.fami-braun.de (localhost [127.0.0.1])
        by dynamic.fami-braun.de (fami-braun.de) with ESMTP id E32FB15418F
        for <util-linux@vger.kernel.org>; Wed, 15 Apr 2020 23:16:57 +0200 (CEST)
Received: from charlie.fritz.box (p5B352FA9.dip0.t-ipconnect.de [91.53.47.169])
        by dynamic.fami-braun.de (fami-braun.de) with ESMTPSA id BC9A4158330;
        Wed, 15 Apr 2020 23:16:54 +0200 (CEST)
From:   michael-dev@fami-braun.de
To:     util-linux@vger.kernel.org
Cc:     michael-dev@fami-braun.de
Subject: [PATCH] Fix PID namespace persistence
Date:   Wed, 15 Apr 2020 23:16:53 +0200
Message-Id: <20200415211653.5455-1-michael-dev@fami-braun.de>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: clamav-milter 0.102.2 at gate
X-Virus-Status: Clean
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: michael-dev <michael-dev@fami-braun.de>

After unshare(...) is called, /proc/self/ns/pid does not change.
Instead, only /proc/self/ns/pid_for_children is affected. So bind-mounting /proc/self/ns/pid results in the original namespace getting bind-mounted.

Fix this by instead bind-mounting ns/pid_for_children.

Signed-off-by: Michael Braun <michael-dev@fami-braun.de>
---
 sys-utils/unshare.c | 66 ++++++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 28 deletions(-)

diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 8652ebdaf..c3ba18e32 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -63,7 +63,7 @@ static struct namespace_file {
 	{ .type = CLONE_NEWIPC,   .name = "ns/ipc"  },
 	{ .type = CLONE_NEWUTS,   .name = "ns/uts"  },
 	{ .type = CLONE_NEWNET,   .name = "ns/net"  },
-	{ .type = CLONE_NEWPID,   .name = "ns/pid"  },
+	{ .type = CLONE_NEWPID,   .name = "ns/pid_for_children"  },
 	{ .type = CLONE_NEWNS,    .name = "ns/mnt"  },
 	{ .type = CLONE_NEWTIME,  .name = "ns/time"  },
 	{ .name = NULL }
@@ -361,6 +361,7 @@ int main(int argc, char *argv[])
 	const char *procmnt = NULL;
 	const char *newroot = NULL;
 	const char *newdir = NULL;
+	pid_t pid_bind = 0;
 	pid_t pid = 0;
 	int fds[2];
 	int status;
@@ -501,13 +502,37 @@ int main(int argc, char *argv[])
 			"unsharing of a time namespace (-t)"));
 
 	if (npersists && (unshare_flags & CLONE_NEWNS))
-		bind_ns_files_from_child(&pid, fds);
+		bind_ns_files_from_child(&pid_bind, fds);
 
 	if (-1 == unshare(unshare_flags))
 		err(EXIT_FAILURE, _("unshare failed"));
 
-	if (npersists) {
-		if (pid && (unshare_flags & CLONE_NEWNS)) {
+	if (force_boottime)
+		settime(boottime, CLOCK_BOOTTIME);
+
+	if (force_monotonic)
+		settime(monotonic, CLOCK_MONOTONIC);
+
+	if (forkit) {
+		// force child forking before mountspace binding
+		// so pid_for_children is populated
+		pid = fork();
+
+		switch(pid) {
+		case -1:
+			err(EXIT_FAILURE, _("fork failed"));
+		case 0:	/* child */
+			if (pid_bind && (unshare_flags & CLONE_NEWNS))
+				close(fds[1]);
+			break;
+		default: /* parent */
+      break;
+		}
+	}
+
+	if (npersists && (pid || !forkit)) {
+		// run in parent
+		if (pid_bind && (unshare_flags & CLONE_NEWNS)) {
 			int rc;
 			char ch = PIPE_SYNC_BYTE;
 
@@ -518,7 +543,7 @@ int main(int argc, char *argv[])
 
 			/* wait for bind_ns_files_from_child() */
 			do {
-				rc = waitpid(pid, &status, 0);
+				rc = waitpid(pid_bind, &status, 0);
 				if (rc < 0) {
 					if (errno == EINTR)
 						continue;
@@ -533,29 +558,14 @@ int main(int argc, char *argv[])
 			bind_ns_files(getpid());
 	}
 
-	if (force_boottime)
-		settime(boottime, CLOCK_BOOTTIME);
-
-	if (force_monotonic)
-		settime(monotonic, CLOCK_MONOTONIC);
-
-	if (forkit) {
-		pid = fork();
-
-		switch(pid) {
-		case -1:
-			err(EXIT_FAILURE, _("fork failed"));
-		case 0:	/* child */
-			break;
-		default: /* parent */
-			if (waitpid(pid, &status, 0) == -1)
-				err(EXIT_FAILURE, _("waitpid failed"));
-			if (WIFEXITED(status))
-				return WEXITSTATUS(status);
-			else if (WIFSIGNALED(status))
-				kill(getpid(), WTERMSIG(status));
-			err(EXIT_FAILURE, _("child exit failed"));
-		}
+	if (pid) {
+		if (waitpid(pid, &status, 0) == -1)
+			err(EXIT_FAILURE, _("waitpid failed"));
+		if (WIFEXITED(status))
+			return WEXITSTATUS(status);
+		else if (WIFSIGNALED(status))
+			kill(getpid(), WTERMSIG(status));
+		err(EXIT_FAILURE, _("child exit failed"));
 	}
 
 	if (kill_child_signo != 0 && prctl(PR_SET_PDEATHSIG, kill_child_signo) < 0)
-- 
2.17.1

