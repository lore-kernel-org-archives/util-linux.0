Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.parknet.co.jp ([210.171.160.6]:47722 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbcKWFNg (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 23 Nov 2016 00:13:36 -0500
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTP id 948E7170001
        for <util-linux@vger.kernel.org>; Wed, 23 Nov 2016 14:13:35 +0900 (JST)
Received: from devron.myhome.or.jp (root@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-6) with ESMTPS id uAN5DYma002775
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <util-linux@vger.kernel.org>; Wed, 23 Nov 2016 14:13:35 +0900
Received: from devron.myhome.or.jp (hirofumi@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-6) with ESMTPS id uAN5DY15032474
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <util-linux@vger.kernel.org>; Wed, 23 Nov 2016 14:13:34 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: util-linux@vger.kernel.org
Subject: [PATCH v2] lsns: Fix parser for /proc/<pid>/stat which is including space in comm
References: <87a8cvk01b.fsf@mail.parknet.co.jp>
        <20161122204301.GB21655@vapier.lan>
Date: Wed, 23 Nov 2016 14:13:34 +0900
In-Reply-To: <20161122204301.GB21655@vapier.lan> (Mike Frysinger's message of
        "Tue, 22 Nov 2016 12:43:01 -0800")
Message-ID: <874m2yhj7l.fsf_-_@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

For example, child process of spamd has

    32031 (spamd child) S 32026 32026 32026 0 -1 4210752 338 0 0 0 ...

fscanf("%d %*s %c %d*[^\n]") in read_process() can't parse above as we
expected, because %s only skips non-whitespace. I.e. it parses like
following,

    32031 (spamd child) S 32026 32026 32026 0 -1 4210752 338 0 0 0 ...
    +---+ +----+ +
      %d    %*s  %c

and returns 2 (pid=32031, state=c).

This fixes it by skipping task->comm part manually.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 sys-utils/lsns.c |   30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff -puN sys-utils/lsns.c~a sys-utils/lsns.c
--- util-linux2/sys-utils/lsns.c~a	2016-11-23 13:54:46.030143424 +0900
+++ util-linux2-hirofumi/sys-utils/lsns.c	2016-11-23 13:54:46.032143437 +0900
@@ -217,6 +217,30 @@ static int get_ns_ino(int dir, const cha
 	return 0;
 }
 
+static int parse_proc_stat(FILE *fp, pid_t *pid, char *state, pid_t *ppid)
+{
+	char *line = NULL, *p;
+	size_t len = 0;
+	int rc;
+
+	if (getline(&line, &len, fp) < 0) {
+		rc = -errno;
+		goto error;
+	}
+
+	p = strrchr(line, ')');
+	if (p == NULL ||
+	    sscanf(line, "%d (", pid) != 1 ||
+	    sscanf(p, ") %c %d*[^\n]", state, ppid) != 2) {
+		rc = -EINVAL;
+		goto error;
+	}
+	rc = 0;
+
+error:
+	free(line);
+	return rc;
+}
 
 static int read_process(struct lsns *ls, pid_t pid)
 {
@@ -255,11 +279,9 @@ static int read_process(struct lsns *ls,
 		rc = -errno;
 		goto done;
 	}
-	rc = fscanf(f, "%d %*s %c %d*[^\n]", &p->pid, &p->state, &p->ppid);
-	if (rc != 3) {
-		rc = rc < 0 ? -errno : -EINVAL;
+	rc = parse_proc_stat(f, &p->pid, &p->state, &p->ppid);
+	if (rc < 0)
 		goto done;
-	}
 	rc = 0;
 
 	for (i = 0; i < ARRAY_SIZE(p->ns_ids); i++) {
_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
