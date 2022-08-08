Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4B9C00140
	for <util-linux@archiver.kernel.org>; Mon,  8 Aug 2022 13:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242685AbiHHNff (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 8 Aug 2022 09:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237695AbiHHNfe (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 8 Aug 2022 09:35:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2FADBC1E
        for <util-linux@vger.kernel.org>; Mon,  8 Aug 2022 06:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659965731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sKVSv7UqkX3J45wHFZXZWjUuW/iPee6DGQ+Z+kZRH9k=;
        b=SyKMcpZb1wjznZMIKimpaf0DSnlluwQbQK14aTUy73l42jkFY2FgyOHkKOkqIA9kxW9a5q
        zzK3dN58pq8ZiZmcheMQqmAWZBxiPrzNj7bdt1bWv+kYDrmXykqIF8+7+3MkLetmNbYe3/
        xar252XfyefWvrziaUI/dYPRILLyrSA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-466-eH7DvrzXMKmjp9B_YKfq2w-1; Mon, 08 Aug 2022 09:35:30 -0400
X-MC-Unique: eH7DvrzXMKmjp9B_YKfq2w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC6C385A58E;
        Mon,  8 Aug 2022 13:35:29 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 72F199457F;
        Mon,  8 Aug 2022 13:35:29 +0000 (UTC)
Date:   Mon, 8 Aug 2022 15:35:26 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Carsten Emde <C.Emde@osadl.org>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Taskset: check first whether affinity is settable
Message-ID: <20220808133526.k4i5elxhqe66sghm@ws.net.home>
References: <20220806224915.326517265@osadl.org>
 <20220806225421.221956570@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220806225421.221956570@osadl.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sun, Aug 07, 2022 at 12:49:16AM +0200, Carsten Emde wrote:
> If the PF_NO_SETAFFINITY process flag is set, the user may not
> know why the affinity is not settable. Write a respective message
> and do not attempt to set the affinity of this process.

I'm unsure if constantly checking for the flag rather than calling
sched_setaffinity() is the right way. It seems pretty expensive.

I don't like when userspace tries to predict any kernel policy or
behavior. It seems better to call the syscall and, if necessary,
compose a better (detailed) error message. 

What about the patch below? (I have moved /proc/#/stat parsing to
lib/procfs.c to keep tastset.c more readable.)

    Karel


diff --git a/include/procfs.h b/include/procfs.h
index 5a730c94c..825689bc2 100644
--- a/include/procfs.h
+++ b/include/procfs.h
@@ -30,6 +30,7 @@ extern ssize_t procfs_process_get_cmdline(struct path_cxt *pc, char *buf, size_t
 extern ssize_t procfs_process_get_cmdname(struct path_cxt *pc, char *buf, size_t bufsz);
 extern ssize_t procfs_process_get_stat(struct path_cxt *pc, char *buf, size_t bufsz);
 
+extern int procfs_process_get_stat_nth(struct path_cxt *pc, int n, uintmax_t *re);
 
 static inline ssize_t procfs_process_get_exe(struct path_cxt *pc, char *buf, size_t bufsz)
 {
diff --git a/lib/procfs.c b/lib/procfs.c
index 0d58857c8..1072a9a2c 100644
--- a/lib/procfs.c
+++ b/lib/procfs.c
@@ -169,6 +169,35 @@ ssize_t procfs_process_get_stat(struct path_cxt *pc, char *buf, size_t bufsz)
 	return procfs_process_get_line_for(pc, buf, bufsz, "stat");
 }
 
+int procfs_process_get_stat_nth(struct path_cxt *pc, int n, uintmax_t *re)
+{
+	ssize_t rc;
+	char *key = NULL, *tok, *p;
+	char buf[BUFSIZ];
+	int i;
+
+	if (n == 2 || n == 3)		/* process name and status (strings) */
+		return -EINVAL;
+
+	rc = procfs_process_get_line_for(pc, buf, sizeof(buf), "stat");
+	if (rc < 0)
+		return rc;
+
+	for (i = 0, tok = strtok_r(buf, " ", &key); tok;
+	     tok = strtok_r(NULL, " ", &key)) {
+
+		i++;
+		if (i == n)
+			return ul_strtou64(tok, re, 10);
+
+		/* skip rest of the process name */
+		if (i == 2 && (p = strchr(key, ')')))
+			key = p + 2;
+	}
+
+	return -EINVAL;
+}
+
 int procfs_process_get_uid(struct path_cxt *pc, uid_t *uid)
 {
 	struct stat sb;
@@ -547,6 +576,30 @@ static int test_isprocfs(int argc, char *argv[])
 	return is ? EXIT_SUCCESS : EXIT_FAILURE;
 }
 
+static int test_process_stat_nth(int argc, char *argv[])
+{
+	pid_t pid;
+	struct path_cxt *pc;
+	uintmax_t num = 0;
+	int n;
+
+	if (argc != 3)
+		return EXIT_FAILURE;
+	pid = strtol(argv[1], (char **) NULL, 10);
+	n = strtol(argv[2], (char **) NULL, 10);
+
+	pc = ul_new_procfs_path(pid, NULL);
+	if (!pc)
+		err(EXIT_FAILURE, "cannot alloc procfs handler");
+
+	if (procfs_process_get_stat_nth(pc, n, &num) != 0)
+		err(EXIT_FAILURE, "read %dth number failed", n);
+
+	printf("%d: %dth %ju\n", (int) pid, n, num);
+	ul_unref_path(pc);
+	return EXIT_SUCCESS;
+}
+
 int main(int argc, char *argv[])
 {
 	if (argc < 2) {
@@ -554,7 +607,8 @@ int main(int argc, char *argv[])
 				"       %1$s --fds <pid>\n"
 				"       %1$s --is-procfs [<dir>]\n"
 				"       %1$s --processes [---name <name>] [--uid <uid>]\n"
-				"       %1$s --one <pid>\n",
+				"       %1$s --one <pid>\n"
+				"       %1$s --stat-nth <pid> <n>\n",
 				program_invocation_short_name);
 		return EXIT_FAILURE;
 	}
@@ -569,6 +623,8 @@ int main(int argc, char *argv[])
 		return test_isprocfs(argc - 1, argv + 1);
 	if (strcmp(argv[1], "--one") == 0)
 		return test_one_process(argc - 1, argv + 1);
+	if (strcmp(argv[1], "--stat-nth") == 0)
+		return test_process_stat_nth(argc - 1, argv + 1);
 
 	return EXIT_FAILURE;
 }
diff --git a/schedutils/taskset.c b/schedutils/taskset.c
index 0ab7d12e2..d2d1a869e 100644
--- a/schedutils/taskset.c
+++ b/schedutils/taskset.c
@@ -112,6 +112,8 @@ static void __attribute__((__noreturn__)) err_affinity(pid_t pid, int set)
 	err(EXIT_FAILURE, msg, pid ? pid : getpid());
 }
 
+#define PF_NO_SETAFFINITY 0x04000000
+
 static void do_taskset(struct taskset *ts, size_t setsize, cpu_set_t *set)
 {
 	/* read the current mask */
@@ -125,8 +127,22 @@ static void do_taskset(struct taskset *ts, size_t setsize, cpu_set_t *set)
 		return;
 
 	/* set new mask */
-	if (sched_setaffinity(ts->pid, setsize, set) < 0)
+	if (sched_setaffinity(ts->pid, setsize, set) < 0) {
+		uintmax_t flags = 0;
+		struct path_cxt *pc;
+		int errsv = errno;
+
+		if (errno != EPERM
+		    && (pc = ul_new_procfs_path(ts->pid, NULL))
+		    && procfs_process_get_stat_nth(pc, 9, &flags) == 0
+		    && (flags & PF_NO_SETAFFINITY)) {
+			warnx(_("affinity cannot be set due to PF_NO_SETAFFINITY flag set"));
+			errno = EINVAL;
+		} else
+			errno = errsv;
+
 		err_affinity(ts->pid, 1);
+	}
 
 	/* re-read the current mask */
 	if (ts->pid) {

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

