Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDEDC64EC7
	for <util-linux@archiver.kernel.org>; Wed, 22 Feb 2023 15:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjBVPdH (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 22 Feb 2023 10:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbjBVPdG (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 22 Feb 2023 10:33:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644763866C
        for <util-linux@vger.kernel.org>; Wed, 22 Feb 2023 07:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677079934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2tpfHdqjqa3luq0t8otUOCW+1btWIa8+B+BzE8Ubnd4=;
        b=Yw0XxlAxxq12tjn0cqYx3HW1hSm9iX8zWo1xVuNMBbe6/X1nQ25yOX000mumeFq8YwMlok
        Y74ttPeA0bFZiBlCO3RS9FU7vA6g1ngSjFYyLTI5Y+YAcpypwwYzEdzvluENuMQ5elA8Q1
        40iHj3oZFe5zEokyyeZfIQkjRL1aJBs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-j3RGVOC8O2e_BW3IxKwmQg-1; Wed, 22 Feb 2023 10:32:11 -0500
X-MC-Unique: j3RGVOC8O2e_BW3IxKwmQg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7BC392805582
        for <util-linux@vger.kernel.org>; Wed, 22 Feb 2023 15:32:07 +0000 (UTC)
Received: from localhost.localdomain (ovpn-192-10.brq.redhat.com [10.40.192.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E68024024CA1;
        Wed, 22 Feb 2023 15:32:06 +0000 (UTC)
From:   Thomas Haller <thaller@redhat.com>
To:     util-linux@vger.kernel.org
Cc:     Thomas Haller <thaller@redhat.com>
Subject: [PATCH 1/1] lib/randutils: drop unnecessary fcntl() in random_get_fd()
Date:   Wed, 22 Feb 2023 16:32:03 +0100
Message-Id: <20230222153203.1506570-1-thaller@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

We already pass O_CLOEXEC flag to open(), no need to modify
the file descriptor with FD_CLOEXEC afterwards.

This was a left over from commit b1fa3e2234fa ('lib: use O_CLOEXEC in
libcommon').

Signed-off-by: Thomas Haller <thaller@redhat.com>
---
 lib/randutils.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/lib/randutils.c b/lib/randutils.c
index 2ffe9b4f069e..15c2f7834969 100644
--- a/lib/randutils.c
+++ b/lib/randutils.c
@@ -80,16 +80,11 @@ static void crank_random(void)
 
 int random_get_fd(void)
 {
-	int i, fd;
+	int fd;
 
 	fd = open("/dev/urandom", O_RDONLY | O_CLOEXEC);
 	if (fd == -1)
 		fd = open("/dev/random", O_RDONLY | O_NONBLOCK | O_CLOEXEC);
-	if (fd >= 0) {
-		i = fcntl(fd, F_GETFD);
-		if (i >= 0)
-			fcntl(fd, F_SETFD, i | FD_CLOEXEC);
-	}
 	crank_random();
 	return fd;
 }
-- 
2.39.2

