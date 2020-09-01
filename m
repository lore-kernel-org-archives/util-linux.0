Return-Path: <SRS0=RAhs=CK=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1419C433E6
	for <util-linux@archiver.kernel.org>; Tue,  1 Sep 2020 19:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA66B2071B
	for <util-linux@archiver.kernel.org>; Tue,  1 Sep 2020 19:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGWdSmuC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgIATBi (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 1 Sep 2020 15:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgIATBh (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 1 Sep 2020 15:01:37 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EC9C061244
        for <util-linux@vger.kernel.org>; Tue,  1 Sep 2020 12:01:35 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c18so2694477wrm.9
        for <util-linux@vger.kernel.org>; Tue, 01 Sep 2020 12:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version:organization
         :content-transfer-encoding;
        bh=u3OTs0bhA4N62onQ45fKGYA4svariCpDMK8EsK0GBQ4=;
        b=NGWdSmuCMvJMoqSDOiAFsOgiZO8J0X7jiLyubiy3ABPG3uhILQtTw3As91Luw/Vdl4
         vNBWq+VS+J11SByWNFsE+4Qq+6UpseR81o5mzsghEu265AhZ7DINjyxKGNiFB/QwdhK3
         ZVe1nZd8t2lOJI3lDxlu9kfF70+lDllvs4NR4/OhPJ5IQ1qeHR6VG+yAVYQvKSHMg/ji
         z5Z17apZKA4Bi8g64wCJiAM2uimBBeUg2xJCW1AsVeZDkLMwmtCRdfhNArpjwTLM1NN0
         FVKuF/+Qobd5kcXtLbhlK6Z6Xjpp1YmO5HECiuDmdCtWz+eMSrGopNaThMX96cAZ0fsM
         Hk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:organization:content-transfer-encoding;
        bh=u3OTs0bhA4N62onQ45fKGYA4svariCpDMK8EsK0GBQ4=;
        b=ACWJMWQ6AwFAfBWWcLArHuDRum8W1lLUYmXts7Z7uXua0iyQ5FY8Efn0r0AT52YkDz
         7piW3gist811jheIfuJAf871zfsPH1pQ6P3wf3EZwzIpKt2q9WnUZ9CIBuUuE8cXRaPU
         v45CcXd+p/TJWccRBrbZ+LHdkfeUxiAzbX6gzpIC7v8L92mmJ3+uMQVrwWT8uwMmACBn
         vm/WNcJgWZBKAzg53h2GEheIfA91ww1lspwuxgJXUsmpupEbs+U1L/eAY2u4ivJU71M8
         XCmbS/r63U9L4Qo6Xiq6Ku8YBllUDwh9UCd+2F1OIHFUQwaE60bKAeON0tOn4RlFIa2w
         ySqg==
X-Gm-Message-State: AOAM532rQwa+Yr26buKDbjmtf9kyeY3wkKGjwKxizsLxq44OD9Wu+ym6
        z11CJGVcrIYcAFfNshe3YmbCDT17u6M=
X-Google-Smtp-Source: ABdhPJyW2u5HhyQ4hmWxjO0J/CebHSODnjM1v46xnxPvkGZG8LwLQeXK9HD7bhEpIVokt6T/XAy6PA==
X-Received: by 2002:a5d:6646:: with SMTP id f6mr3344899wrw.155.1598986894013;
        Tue, 01 Sep 2020 12:01:34 -0700 (PDT)
Received: from localhost ([2a02:8010:659f:0:a8d8:38f:5807:ac47])
        by smtp.gmail.com with ESMTPSA id q6sm2832856wmq.19.2020.09.01.12.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 12:01:33 -0700 (PDT)
From:   Sami Kerola <kerolasa@iki.fi>
To:     util-linux@vger.kernel.org
Cc:     Sami Kerola <kerolasa@iki.fi>,
        Sami Kerola <kerolasa@cloudflare.com>
Subject: [PATCH] nologin: use sendfile() to submit message to user
Date:   Tue,  1 Sep 2020 20:01:31 +0100
Message-Id: <20200901190131.4153-1-kerolasa@iki.fi>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Organization: Cloudflare
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

A read() write() pair can be replaced with sendfile(), and it should be more
efficient than suffling bytes back and forth user and kernel space.

Signed-off-by: Sami Kerola <kerolasa@cloudflare.com>
---
 login-utils/nologin.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/login-utils/nologin.c b/login-utils/nologin.c
index f38a3aab0..ca4ca4e84 100644
--- a/login-utils/nologin.c
+++ b/login-utils/nologin.c
@@ -3,6 +3,7 @@
  */
 
 #include <stdio.h>
+#include <sys/sendfile.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <fcntl.h>
@@ -97,12 +98,12 @@ int main(int argc, char *argv[])
 	if (c < 0 || !S_ISREG(st.st_mode))
 		goto dflt;
 	else {
-		char buf[BUFSIZ];
-		ssize_t rd;
-
-		while ((rd = read(fd, buf, sizeof(buf))) > 0)
-			ignore_result( write(STDOUT_FILENO, buf, rd) );
+		int stdout_fd;
 
+		stdout_fd = fileno(stdout);
+		if (stdout_fd < 0)
+			goto dflt;
+		ignore_result( sendfile(stdout_fd, fd, NULL, st.st_size) );
 		close(fd);
 		return EXIT_FAILURE;
 	}
-- 
2.28.0

