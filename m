Return-Path: <SRS0=jsub=P6=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8C5C282C3
	for <util-linux@archiver.kernel.org>; Tue, 22 Jan 2019 18:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF3C20870
	for <util-linux@archiver.kernel.org>; Tue, 22 Jan 2019 18:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=shadowice.org header.i=@shadowice.org header.b="Ind/kkt3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbfAVSYk (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:24:40 -0500
Received: from shadowice.org ([95.216.8.22]:40583 "EHLO shadowice.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbfAVSYk (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 22 Jan 2019 13:24:40 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Jan 2019 13:24:39 EST
Received: from shadowice (localhost [127.0.0.1])
        by shadowice.org (OpenSMTPD) with ESMTP id c678ffb4
        for <util-linux@vger.kernel.org>;
        Tue, 22 Jan 2019 19:17:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=shadowice.org; h=from:to
        :cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=default; bh=UjpeTiSTncXzCpGIIoQaK1
        62pYQ=; b=Ind/kkt32XPFoxuTXWlDtZ+Z1VlIr/CDhTGq8BUWqB/KV76bWUUUy/
        CmbbKe0vME6RThHPar421rfqkORkLTHSNKSQzwVAnfIXFyldN9gX7UkWTDEquvyF
        W01NEmnYJPsN8Kmz4HHGHgB18k5RuU4kvX5GWFt4t3f49qA5ofElg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=shadowice.org; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         q=dns; s=default; b=a1rAzOHvkpWkOMQ3+P/IGeHFfem10/5BtZxSu0zI/Vv
        AB1nlwKqUEikNWkLcJgqo0rZyNLVZtxny1DdxnTGm9q730VPfnMFbr62PRseHHAR
        NHUdBhRdb5FEWKMZHxBTFV2SZ9rC0+0GlMSu5ZjM+Tj2l5Cot0IFXLXw3yHoEonY
        =
Received: from localhost (2001:16b8:49c2:6600:e6b3:18ff:fe0e:8df [IPv6:2001:16b8:49c2:6600:e6b3:18ff:fe0e:8df])
        by shadowice.org (OpenSMTPD) with ESMTPSA id 0facc73d (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Tue, 22 Jan 2019 19:17:58 +0100 (CET)
From:   Johannes Nixdorf <mixi@shadowice.org>
To:     util-linux@vger.kernel.org
Cc:     Johannes Nixdorf <mixi@shadowice.org>
Subject: [PATCH] build-sys: fix crypt() detection without -lcrypt
Date:   Tue, 22 Jan 2019 19:17:55 +0100
Message-Id: <20190122181755.2234-1-mixi@shadowice.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The check tested whether code using crypt() links without -lcrypt, but
didn't set have_crypt to yes if it succeeded.

This fixes the check erroneously failing when compiling against musl
libc.

Signed-off-by: Johannes Nixdorf <mixi@shadowice.org>
---
 configure.ac | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 4c8de521f..0bf422cda 100644
--- a/configure.ac
+++ b/configure.ac
@@ -798,7 +798,10 @@ AC_LINK_IFELSE([AC_LANG_PROGRAM([[
 #endif
 ]], [[
 char *c = crypt("abc","pw");
-]])],[],[
+]])],[
+  have_libcrypt=no
+  have_crypt=yes
+],[
   LIBS="$LIBS -lcrypt"
   AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
   #ifdef HAVE_CRYPT_H
-- 
2.20.1

