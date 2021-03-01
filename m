Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB02C4332B
	for <util-linux@archiver.kernel.org>; Mon,  1 Mar 2021 18:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19AAA6146D
	for <util-linux@archiver.kernel.org>; Mon,  1 Mar 2021 18:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239657AbhCASWL (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 1 Mar 2021 13:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239128AbhCASUH (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 1 Mar 2021 13:20:07 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A426FC061788
        for <util-linux@vger.kernel.org>; Mon,  1 Mar 2021 10:19:23 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id gi9so8572671qvb.10
        for <util-linux@vger.kernel.org>; Mon, 01 Mar 2021 10:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=pFmrCPQvIi44VDMEthwCxsE58nRPjCx+qvUzSEbltFY=;
        b=krD0XWuD9LlePce+TnzNSlhH899dyCYb8yZVzZDwVbVFkMRUJPG91MyEKAUQ7YTozJ
         yWX78W9MX3C0dj8ExPw/DxIMESQ5krCVfVgZuxrJFUsg9q2YU6PwXZO33rsanl+4rc4x
         x2FZobOG+SbFp50f922vD+OI2I6VJjxJxDox7hULTE0ajmIELUSaOjysQJihxrGjp1Sf
         USJRX+1pUYTv8yNFQmvPUQuRN2JG1H6XhM1v6QbdCbraU0WKRA5vJ5rqhBlGM5UQnIBr
         BPn8ClZIwqMXsXMlxLF9TwxGmsRnU+oS3VVTB7TrIVvlNZIpDSMyrA1z7SA0/KS3fEcx
         p5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=pFmrCPQvIi44VDMEthwCxsE58nRPjCx+qvUzSEbltFY=;
        b=jkNUfWN4fn6hiNCorTS5wf8wNB6YQDpNIEXBKltDricqX08NiR+a9j304+uaTh0ges
         T/vaam41WmzWc6izD/uj5WX5+67akFfWR9uevQW2XCpQin3kirW4z8RJMt3S/axjPADB
         ohgVbAQ8cdpyt7BcfqIBWDztAWUXUTs1XNnYnKRP2KvlwYJwp4P7iaqTgrUtLvFri7HD
         uqFs6ZYcGEbJ3rEsRS6EiOZuy2afTbG+WZvu12FfPe3x64NUIgdbHR0JT/vm64Ag3D4a
         fkBU9aqsAK5YHcgupoWC87SQONXcfxNjwYWcf2Duo6CRXlwyBtZJh1d8ubIheBcczP62
         Wnmw==
X-Gm-Message-State: AOAM53074rWMIQ0iHckzdyAB0WQ7/gTPpB1yhSR+NlU3smbc0khsFbbK
        5Wj/w2UwSXJqRXTKgoCvS5MWm2qhl3mx4g==
X-Google-Smtp-Source: ABdhPJzRgkRFss1GVH/BsRW8gxiUo8eMeaS3XVqGNZU0sNBBiO5N0qKWf9PZxLr2E0/e3SM4Xc9U8A==
X-Received: by 2002:ad4:5bea:: with SMTP id k10mr15355288qvc.2.1614622762511;
        Mon, 01 Mar 2021 10:19:22 -0800 (PST)
Received: from [192.168.0.104] (c-73-87-224-7.hsd1.md.comcast.net. [73.87.224.7])
        by smtp.gmail.com with ESMTPSA id x7sm13161908qkf.111.2021.03.01.10.19.21
        for <util-linux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Mar 2021 10:19:21 -0800 (PST)
From:   Andrew Shapiro <anshapiro@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: [PATCH] utmpdup: Ensure flushing when using follow flag
Message-Id: <593E7F58-59CA-4310-8420-D400CBF8ADE7@gmail.com>
Date:   Mon, 1 Mar 2021 13:18:27 -0500
To:     util-linux@vger.kernel.org
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The following usages of utmpdump result in no output being flushed to =
the specified file because the default output buffering is fully =
buffered:

$ utmpdump --follow --output myOutputFile /var/log/utmp
$ utmpdump --follow /var/log/utmp > myOutputFile

This change configures line buffering for these scenarios so that output =
will be flushed after each log event.

Signed-off-by: Andrew Shapiro <anshapiro@gmail.com>
---
 login-utils/utmpdump.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/login-utils/utmpdump.c b/login-utils/utmpdump.c
index 5ccae8655..b9a92b5f6 100644
--- a/login-utils/utmpdump.c
+++ b/login-utils/utmpdump.c
@@ -367,6 +367,10 @@ int main(int argc, char **argv)
 	if (!out)
 		out =3D stdout;

+	if (follow && (out !=3D stdout || !isatty(STDOUT_FILENO))) {
+		setvbuf(out, NULL, _IOLBF, 0);
+	}
+
 	if (optind < argc) {
 		filename =3D argv[optind];
 		in =3D fopen(filename, "r");
--
2.24.3 (Apple Git-128)

