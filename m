Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3208BC433F5
	for <util-linux@archiver.kernel.org>; Wed, 24 Nov 2021 18:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238072AbhKXS3o (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 24 Nov 2021 13:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236712AbhKXS3o (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 24 Nov 2021 13:29:44 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55B3C061574
        for <util-linux@vger.kernel.org>; Wed, 24 Nov 2021 10:26:33 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id z9so3588826qtj.9
        for <util-linux@vger.kernel.org>; Wed, 24 Nov 2021 10:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wv0fPrRee2/gpP24JaMbzZDO6hCQ6qUuqvymZQhAXIg=;
        b=PU4cvkc2f+7radlOYU1Yp1BWpSsJeOoRv6Ti0b8jRVsv+cbIs6SHv50HFawDXQWksO
         c/+57AS7jV6ohmtG1O+K3GDfvkZAl0SteXpZU6D7T/ZidKt71GQ8Oj9YVRZsEHJOUu8b
         meWg9xpWR1Mp0yrUHX4H3UwRBI/3M0Fs4sj3srKsdlx8+c1ZYj83DcuDpv+NIAN+fCZL
         BsY3nXC5hvtMljYHKR4nQTjPVYGkA6KJNi5RQ+UJlyGsB0Ii9h1txQ8+q6yGc0PXxrHJ
         dGblK/I/p+XESJ/QE7omIWuQFvFT8vqsM3KZywQIar42VE6vL7YbA+L+2FNlA/olf+sW
         jIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wv0fPrRee2/gpP24JaMbzZDO6hCQ6qUuqvymZQhAXIg=;
        b=buWEDqi7ApK7Zu6K75o0n/ooYwCAbVkm1APLrG5TUShSCYkDkWr3ZyPpDcBZGdyWez
         wlNGnX5kwgxrfEEIJGvPnb/oUICtc/i2k7mjcEAAGRzECSOcI7d9dM8rmMkUZu4Ieuhc
         7vdD/c7F/Suz2PEuqVzYzYOv4eHepAUjKmCtgiwJvFGBhZKYTOeUMigZFLjlQc3A4SQX
         Eu0GorCWEZqPE4cwQ6Zo3YRALxp4Znq+2vWsd5IOwEhS5ju8mWr9iJBoYPF4T05DgTEH
         AdP1SrRYx4cSSuR3et+5bS3zZLglXNWNffYhK0y+RSAIlsQfU9VkxB++2WRhY5zlEWGt
         qd3w==
X-Gm-Message-State: AOAM533nmERmL0+UypRH0uW2YSLA/NgKbB9OhPdJH/JLCGxRSMiWfB/D
        vMSAnM9Sbm0qlcRBQe/LAUaGacsej3k=
X-Google-Smtp-Source: ABdhPJyT68xi/eD0AldohV2efR2u7Cns290pBjk6nUsEX1/FCPfQPopqycbrjygcJsl4C8Ei/fGQDg==
X-Received: by 2002:ac8:7d07:: with SMTP id g7mr9578928qtb.364.1637778392903;
        Wed, 24 Nov 2021 10:26:32 -0800 (PST)
Received: from godwin.fios-router.home (pool-108-18-207-184.washdc.fios.verizon.net. [108.18.207.184])
        by smtp.gmail.com with ESMTPSA id h19sm274936qth.63.2021.11.24.10.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 10:26:32 -0800 (PST)
From:   Sean Anderson <seanga2@gmail.com>
To:     util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Cc:     Mikhail Gusarov <dottedmag@dottedmag.net>,
        Matthew Harm Bekkema <id@mbekkema.name>,
        James Peach <jpeach@apache.org>,
        Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 3/6] unshare: Add some helpers for forking and synchronizing
Date:   Wed, 24 Nov 2021 13:26:15 -0500
Message-Id: <20211124182618.1801447-4-seanga2@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211124182618.1801447-1-seanga2@gmail.com>
References: <20211124182618.1801447-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

There is (or rather, will be) a common pattern in unshare like

	/* parent */	/* child */
	fork()
	do_some_work()
	sync()		wait();
			do_more_work();
	wait()		exit();

where the parent has to do some tasks (unshare(), fork() again, etc)
before the child can do its work. At the moment this is implemented
explicitly with a pipe().

Add some helper functions to abstract this process away. In addition,
switch to eventfd() instead of pipe(). As the man page for eventfd(2)
notes,

> Applications can use an eventfd file descriptor instead of a pipe (see
> pipe(2)) in all cases where a pipe is used simply to signal events. The
> kernel overhead of an eventfd file descriptor is much lower than that of
> a pipe, and only one file descriptor is required (versus the two required
> for a pipe).

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

Changes in v2:
- New

 sys-utils/unshare.c | 109 +++++++++++++++++++++++++++-----------------
 1 file changed, 68 insertions(+), 41 deletions(-)

diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 62fa66067..f8229dfad 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -250,39 +250,74 @@ static void waitchild(int pid)
 	} while (rc < 0);
 }
 
-static void bind_ns_files_from_child(pid_t *child, int fds[2])
+/**
+ * sync_with_child() - Tell our child we're ready and wait for it to exit
+ * @pid: The pid of our child
+ * @fd: A file descriptor created with eventfd()
+ *
+ * This tells a child created with fork_and_wait() that we are ready for it to
+ * continue. Once we have done that, wait for our child to exit.
+ */
+static void sync_with_child(pid_t pid, int fd)
 {
-	char ch;
-	pid_t ppid = getpid();
-	ino_t ino = get_mnt_ino(ppid);
+	uint64_t ch = PIPE_SYNC_BYTE;
 
-	if (pipe(fds) < 0)
-		err(EXIT_FAILURE, _("pipe failed"));
+	write_all(fd, &ch, sizeof(ch));
+	close(fd);
 
-	*child = fork();
+	waitchild(pid);
+}
 
-	switch (*child) {
-	case -1:
+/**
+ * fork_and_wait() - Fork and wait to be sync'd with
+ * @fd - A file descriptor created with eventfd() which should be passed to
+ *       sync_with_child()
+ *
+ * This creates an eventfd and forks. The parent process returns immediately,
+ * but the child waits for a %PIPE_SYNC_BYTE on the eventfd before returning.
+ * This allows the parent to perform some tasks before the child starts its
+ * work. The parent should call sync_with_child() once it is ready for the
+ * child to continue.
+ *
+ * Return: The pid from fork()
+ */
+static pid_t fork_and_wait(int *fd)
+{
+	pid_t pid;
+	uint64_t ch;
+
+	*fd = eventfd(0, 0);
+	if (*fd < 0)
+		err(EXIT_FAILURE, _("eventfd failed"));
+
+	pid = fork();
+	if (pid < 0)
 		err(EXIT_FAILURE, _("fork failed"));
 
-	case 0:	/* child */
-		close(fds[1]);
-		fds[1] = -1;
-
-		/* wait for parent */
-		if (read_all(fds[0], &ch, 1) != 1 && ch != PIPE_SYNC_BYTE)
-			err(EXIT_FAILURE, _("failed to read pipe"));
-		if (get_mnt_ino(ppid) == ino)
-			exit(EXIT_FAILURE);
-		bind_ns_files(ppid);
-		exit(EXIT_SUCCESS);
-		break;
-
-	default: /* parent */
-		close(fds[0]);
-		fds[0] = -1;
-		break;
+	if (!pid) {
+		/* wait for the our parent to tell us to continue */
+		if (read_all(*fd, (char *)&ch, sizeof(ch)) != sizeof(ch) ||
+		    ch != PIPE_SYNC_BYTE)
+			err(EXIT_FAILURE, _("failed to read eventfd"));
+		close(*fd);
 	}
+
+	return pid;
+}
+
+static pid_t bind_ns_files_from_child(int *fd)
+{
+	pid_t child, ppid = getpid();
+	ino_t ino = get_mnt_ino(ppid);
+
+	child = fork_and_wait(fd);
+	if (child)
+		return child;
+
+	if (get_mnt_ino(ppid) == ino)
+		exit(EXIT_FAILURE);
+	bind_ns_files(ppid);
+	exit(EXIT_SUCCESS);
 }
 
 static uid_t get_user(const char *s, const char *err)
@@ -426,7 +461,7 @@ int main(int argc, char *argv[])
 	const char *newdir = NULL;
 	pid_t pid_bind = 0;
 	pid_t pid = 0;
-	int fds[2];
+	int fd_bind = -1;
 	int status;
 	unsigned long propagation = UNSHARE_PROPAGATION_DEFAULT;
 	int force_uid = 0, force_gid = 0;
@@ -570,7 +605,7 @@ int main(int argc, char *argv[])
 	signal(SIGCHLD, SIG_DFL);
 
 	if (npersists && (unshare_flags & CLONE_NEWNS))
-		bind_ns_files_from_child(&pid_bind, fds);
+		pid_bind = bind_ns_files_from_child(&fd_bind);
 
 	if (-1 == unshare(unshare_flags))
 		err(EXIT_FAILURE, _("unshare failed"));
@@ -593,8 +628,8 @@ int main(int argc, char *argv[])
 		case -1:
 			err(EXIT_FAILURE, _("fork failed"));
 		case 0:	/* child */
-			if (pid_bind && (unshare_flags & CLONE_NEWNS))
-				close(fds[1]);
+			if (npersists && (unshare_flags & CLONE_NEWNS))
+				close(fd_bind);
 			break;
 		default: /* parent */
 			break;
@@ -603,17 +638,9 @@ int main(int argc, char *argv[])
 
 	if (npersists && (pid || !forkit)) {
 		/* run in parent */
-		if (pid_bind && (unshare_flags & CLONE_NEWNS)) {
-			char ch = PIPE_SYNC_BYTE;
-
-			/* signal child we are ready */
-			write_all(fds[1], &ch, 1);
-			close(fds[1]);
-			fds[1] = -1;
-
-			/* wait for bind_ns_files_from_child() */
-			waitchild(pid_bind);
-		} else
+		if (pid_bind && (unshare_flags & CLONE_NEWNS))
+			sync_with_child(pid_bind, fd_bind);
+		else
 			/* simple way, just bind */
 			bind_ns_files(getpid());
 	}
-- 
2.33.0

