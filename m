Return-Path: <SRS0=kmrn=26=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC1CC282DD
	for <util-linux@archiver.kernel.org>; Thu,  9 Jan 2020 23:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D8220656
	for <util-linux@archiver.kernel.org>; Thu,  9 Jan 2020 23:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="nxsj5bhP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgAIXws (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 9 Jan 2020 18:52:48 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:39718 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729201AbgAIXws (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 9 Jan 2020 18:52:48 -0500
Received: by mail-io1-f68.google.com with SMTP id c16so79969ioh.6
        for <util-linux@vger.kernel.org>; Thu, 09 Jan 2020 15:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7tzo8AsFSbwAy6evH5W3HWw7LXJOsvnf1e9CdRxBSjg=;
        b=nxsj5bhPNgwjt/bB+dPqY5w4r96C27n41JMbXzwtZOeK6IqywySTYdP1cPPNpkrxfs
         xlg1lvQR2PVaAr7v6WquOMG+nYu4gYM7DbEX+43DtlYhxtdOa8jFYq6mcVon6FkWmeT+
         cm1F1J4dbZ1RYg1k3A16o7LD7tmYeDBudc4kUU5BDbAH7ialRGVBX8hypTk6C8laO2ng
         rV7Ya4Q5KsuUq39nMGME+wSlCGJ9Diof0da7HbV6xk4mwMvulEyKNlTBe1VWmQ4irqRF
         8sRIDNhHyC02ybrYkfM09AwYkrXXDEh1UQxnNCKnMdoLrQ9TeH47z9M53a+Qdneth8u0
         rAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7tzo8AsFSbwAy6evH5W3HWw7LXJOsvnf1e9CdRxBSjg=;
        b=C2NhJWiYl2i06b2moOFSd+OAoUr/Ar2YxJMUj9SQ5xFgAK9bd1FCAO0WlneNkwaHtm
         KVWuAy4laPTJwWYk+dKdsuGWT+5UjYT7grZra8zBdtOSW5QCPulY92CajtyTMZzQ3xso
         SDD9e6LKZAK/wlbnplGPpiTxxnN3wcB0lp9v2Ifk6kswu2ucr9vZ/RC9AUqZBN0pdziq
         o3KY2ugpuAkLgY+GTatH3bdZfPss65z6gwH4sqquakZx2+G8nLRtJeaLC+jIzXLn7ARt
         lTkxXVpO5LO5h4DWKc1WQIO6rfveb+mh+gchF+tWGusDo2JluHNaoIehT/+0kUFGLsct
         8OXA==
X-Gm-Message-State: APjAAAXBUHpCdovGrxmimCZURUBWX5eYr68BFvb/1XDlhyMc42Z3QnwT
        sfY/nF71zvUeOkSzZI8uW17NNbDlDBY=
X-Google-Smtp-Source: APXvYqyf8k5G6LQh4GW5MJ/7MNFTiHNZoJ7pxM0XYWtDlxIzIel7ofT0JS6ql6KoDQi0TV+6VIV3pA==
X-Received: by 2002:a5d:9e4a:: with SMTP id i10mr67573ioi.177.1578613965885;
        Thu, 09 Jan 2020 15:52:45 -0800 (PST)
Received: from cisco.hsd1.co.comcast.net ([2601:282:902:b340:8cce:f495:841a:bcdb])
        by smtp.gmail.com with ESMTPSA id a82sm123705ill.38.2020.01.09.15.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 15:52:45 -0800 (PST)
From:   Tycho Andersen <tycho@tycho.ws>
To:     util-linux@vger.kernel.org
Cc:     Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH] libmount: do not unnecessarily chmod utab.lock
Date:   Thu,  9 Jan 2020 16:52:41 -0700
Message-Id: <20200109235241.31865-1-tycho@tycho.ws>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Before ecfeae90a294 ("libmount: Ensure utab.lock mode 644"), you could do
something like:

irc:/tmp umount --version
umount from util-linux 2.27.1 (libmount 2.27.0: selinux, assert, debug)
irc:/tmp mkdir foo bar
irc:/tmp unshare -Urm
irc:/tmp mount --bind foo bar
irc:/tmp umount bar
irc:/tmp echo $?
0

However, afterwards, you get:

/tmp unshare -Urm
/tmp mount --bind foo bar
/tmp umount bar
umount: /tmp/bar: filesystem was unmounted, but failed to update userspace mount table.

Because of the chmod failing:

fchmod(3, 0644)                         = -1 EPERM (Operation not permitted)

Let's figure out whether the chmod is necessary before doing it, and only
do it if it is necessary. This won't fix cases where the system is already
broken, but at least on healthy systems umount will behave as before.

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
---
 libmount/src/lock.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/libmount/src/lock.c b/libmount/src/lock.c
index e6eefa13a..74b272f9d 100644
--- a/libmount/src/lock.c
+++ b/libmount/src/lock.c
@@ -204,6 +204,8 @@ static int lock_simplelock(struct libmnt_lock *ml)
 {
 	const char *lfile;
 	int rc;
+	struct stat sb;
+	const mode_t lock_mask = S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH;
 
 	assert(ml);
 	assert(ml->simplelock);
@@ -225,12 +227,21 @@ static int lock_simplelock(struct libmnt_lock *ml)
 		rc = -errno;
 		goto err;
 	}
-	rc = fchmod(ml->lockfile_fd, S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH);
+
+	rc = fstat(ml->lockfile_fd, &sb);
 	if (rc < 0) {
 		rc = -errno;
 		goto err;
 	}
 
+	if ((sb.st_mode & lock_mask) != lock_mask) {
+		rc = fchmod(ml->lockfile_fd, lock_mask);
+		if (rc < 0) {
+			rc = -errno;
+			goto err;
+		}
+	}
+
 	while (flock(ml->lockfile_fd, LOCK_EX) < 0) {
 		int errsv;
 		if ((errno == EAGAIN) || (errno == EINTR))
-- 
2.20.1

