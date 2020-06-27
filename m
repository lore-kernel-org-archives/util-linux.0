Return-Path: <SRS0=PdLH=AI=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2D2C433DF
	for <util-linux@archiver.kernel.org>; Sat, 27 Jun 2020 19:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25532207FC
	for <util-linux@archiver.kernel.org>; Sat, 27 Jun 2020 19:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=incenp.org header.i=@incenp.org header.b="R70x3vHz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgF0TDj (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 27 Jun 2020 15:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgF0TDj (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 27 Jun 2020 15:03:39 -0400
X-Greylist: delayed 308 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 27 Jun 2020 12:03:38 PDT
Received: from mail.incenp.org (mail.incenp.org [IPv6:2001:41d0:302:2000::43d4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14E3C061794
        for <util-linux@vger.kernel.org>; Sat, 27 Jun 2020 12:03:38 -0700 (PDT)
Received: from localhost (dgouttegattat.plus.com [81.174.245.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.incenp.org (Postfix) with ESMTPSA id 94FEB20213
        for <util-linux@vger.kernel.org>; Sat, 27 Jun 2020 20:58:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=incenp.org; s=201912;
        t=1593284308; bh=h0UOIAPVgj/4mCw5+m04RrKd15FA/DDQCwkTJPeKqtY=;
        h=From:To:Subject:Date;
        b=R70x3vHztN0KBMndI16YuWIcwVfpBC8GLYgPg212Dmfw5e3lnzkTOA8eeW56Ux3rf
         lRg2CwxkESeepE3iupSWXKyCsGall2uIrUfDQpOU2kvugvxoK1UmCnCSazAipI5s6b
         S39ou8M+cwrhJslCitf8iCBzzkfSuDEoWQjSxIPI=
From:   Damien Goutte-Gattat <dgouttegattat@incenp.org>
To:     util-linux@vger.kernel.org
Subject: [PATCH] chfn: Make readline prompt for each field on a separate line
Date:   Sat, 27 Jun 2020 19:58:13 +0100
Message-Id: <20200627185813.17837-1-dgouttegattat@incenp.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

When readline is called to get user input, it is called without
a prompt argument. As a result, if the user does not enter anything
for a given field, then the next field is displayed on the same
line, yielding the following output:

  $ chfn
  Changing finger information for user.
  Password:
  Name []: Office []: Office Phone []: Home Phone []:

instead of the expected:

  $ chfn
  Changing finger information for user.
  Password:
  Full Name []:
  Room Number []:
  Work Phone []:
  Home Phone []:

This patch restores the expected behavior by feeding readline with
a character to display as "prompt".

Signed-off-by: Damien Goutte-Gattat <dgouttegattat@incenp.org>
---
 login-utils/chfn.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/login-utils/chfn.c b/login-utils/chfn.c
index 1b203a83e..b2aadb0d9 100644
--- a/login-utils/chfn.c
+++ b/login-utils/chfn.c
@@ -235,12 +235,13 @@ static char *ask_new_field(struct chfn_control *ctl, const char *question,
 	if (!def_val)
 		def_val = "";
 	while (true) {
-		printf("%s [%s]: ", question, def_val);
+		printf("%s [%s]:", question, def_val);
 		__fpurge(stdin);
 #ifdef HAVE_LIBREADLINE
 		rl_bind_key('\t', rl_insert);
-		if ((buf = readline(NULL)) == NULL)
+		if ((buf = readline(" ")) == NULL)
 #else
+		putchar('\n');
 		if (getline(&buf, &dummy, stdin) < 0)
 #endif
 			errx(EXIT_FAILURE, _("Aborted."));
-- 
2.27.0

