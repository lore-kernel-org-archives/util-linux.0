Return-Path: <SRS0=z6SK=XQ=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FC4C4740C
	for <util-linux@archiver.kernel.org>; Sat, 21 Sep 2019 18:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8EE921882
	for <util-linux@archiver.kernel.org>; Sat, 21 Sep 2019 18:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fifth.space header.i=@fifth.space header.b="dLpYHN5k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfIUS5G (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 21 Sep 2019 14:57:06 -0400
Received: from fifth.space ([45.32.148.28]:47532 "EHLO fifth.space"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfIUS5F (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 21 Sep 2019 14:57:05 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sat, 21 Sep 2019 14:57:04 EDT
Received: from fifth.space (localhost [127.0.0.1])
        by fifth.space (OpenSMTPD) with ESMTP id 34849153
        for <util-linux@vger.kernel.org>;
        Sat, 21 Sep 2019 20:50:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=fifth.space; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=dkim; bh=IcL1DinkLukBm5ab7HYDsQOko
        IM=; b=dLpYHN5k3v731q6mxjToveE0xF2+XBZ8KbXD5zmD+f9GczUB0Z2cYXEJP
        Kh6AVFLYJ800BmlCujIhLmfEMK6/y0CVwNg6zmawNctj8K371eeMt51ymarrfzal
        3J/x+N065ug+85ApayEexVtx3QOoWwfc9wQBw5EWPhvuSS9ZLY6gxxo45BTYbTBh
        a0Oyf3mFP6wMO1bc9LnLXa9632JI7B0KhJM9hECD67HBz04jusYgaTIsrOOLtmTK
        0cdGhqh91ZWlytcP613aCDCQ+USZw31avTws2bOpdWLQR3KlHH4k8k1jBaGN2svu
        R/Hg7hdqwuttuFHx8rQx4xqXHBTHQ==
DomainKey-Signature: a=rsa-sha1; c=nofws; d=fifth.space; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=dkim; b=OsX30nY6i/9Jkcv+PSj
        SUMCD2Pe7zyJjoELC5e1uUqusaXetSrP9sTbg1noxl1lOZLO+hDCeYwj+Paa7/PS
        IORLGIv1oyoau/mLrGeRBwDQSZcyJXskXkLA5IH00YwT4bh5JdFNn14RCWTW+JFY
        7EYd6gCvbn40NTooOrwf57Iou5O7zQjW3oHyJWrVsEu86LOoBG2Xq6fBRNz+euoT
        by8TfRDlaNrFUYu3145GBwWlxjoBRyFIMqdL2FiIXiPusUu0Ql5kCe1aWuX1VHd+
        KNdpyqvW0Go7g1JRMXNrN9wk64wZlPdtay0c2VhWSwaaNIHZCqCdkroxw43cM7uG
        QwA==
Received: from localhost (fifth.space [local])
        by fifth.space (OpenSMTPD) with ESMTPA id 8cf92071;
        Sat, 21 Sep 2019 20:50:23 +0200 (CEST)
From:   Quentin Rameau <quinq@fifth.space>
To:     util-linux@vger.kernel.org
Cc:     Quentin Rameau <quinq@fifth.space>
Subject: [PATCH 1/2] lib/pwdutils: add xgetpwuid
Date:   Sat, 21 Sep 2019 20:50:20 +0200
Message-Id: <20190921185021.10568-2-quinq@fifth.space>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190921185021.10568-1-quinq@fifth.space>
References: <20190921185021.10568-1-quinq@fifth.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

---
 include/pwdutils.h |  1 +
 lib/pwdutils.c     | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/pwdutils.h b/include/pwdutils.h
index a69dd6b45..bea46e57e 100644
--- a/include/pwdutils.h
+++ b/include/pwdutils.h
@@ -5,6 +5,7 @@
 #include <pwd.h>
 
 extern struct passwd *xgetpwnam(const char *username, char **pwdbuf);
+extern struct passwd *xgetpwuid(uid_t uid, char **pwdbuf);
 extern char *xgetlogin(void);
 
 #endif /* UTIL_LINUX_PWDUTILS_H */
diff --git a/lib/pwdutils.c b/lib/pwdutils.c
index 25b4daed0..d54458d65 100644
--- a/lib/pwdutils.c
+++ b/lib/pwdutils.c
@@ -36,6 +36,34 @@ failed:
 	return NULL;
 }
 
+struct passwd *xgetpwuid(uid_t uid, char **pwdbuf)
+{
+	struct passwd *pwd = NULL, *res = NULL;
+	int rc;
+
+	if (!pwdbuf)
+		return NULL;
+
+	*pwdbuf = xmalloc(UL_GETPW_BUFSIZ);
+	pwd = xcalloc(1, sizeof(struct passwd));
+
+	errno = 0;
+	rc = getpwuid_r(uid, pwd, *pwdbuf, UL_GETPW_BUFSIZ, &res);
+	if (rc != 0) {
+		errno = rc;
+		goto failed;
+	}
+	if (!res) {
+		errno = EINVAL;
+		goto failed;
+	}
+	return pwd;
+failed:
+	free(pwd);
+	free(*pwdbuf);
+	return NULL;
+}
+
 char *xgetlogin(void)
 {
 	struct passwd *pw = NULL;
-- 
2.21.0

