Return-Path: <SRS0=z6SK=XQ=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750F5C49ED7
	for <util-linux@archiver.kernel.org>; Sat, 21 Sep 2019 18:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430252184C
	for <util-linux@archiver.kernel.org>; Sat, 21 Sep 2019 18:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fifth.space header.i=@fifth.space header.b="Qgxluo14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfIUS5G (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 21 Sep 2019 14:57:06 -0400
Received: from fifth.space ([45.32.148.28]:47532 "EHLO fifth.space"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727926AbfIUS5G (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 21 Sep 2019 14:57:06 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sat, 21 Sep 2019 14:57:04 EDT
Received: from fifth.space (localhost [127.0.0.1])
        by fifth.space (OpenSMTPD) with ESMTP id 2b0b7b02
        for <util-linux@vger.kernel.org>;
        Sat, 21 Sep 2019 20:50:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=fifth.space; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=dkim; bh=Gl3Kio8YgN9w8jmuFItDqjASz
        i0=; b=Qgxluo14wMHqtQPdFDo/0tSYslO/wayfu6kgR5juISRR84M5R85kI/0Rz
        aNOIDAj/nHSzMpsD1PAXBNKM+vSAgazJdV/PcFzuofPV8n25R73vVS7qU7SxGJNw
        edEQsOhjwPyij0DSk4G+dluCOiKNOUs7b/Kfbkz7W0E4mKuIvQMl75eLSVCFJMg2
        XkG2eyP8PpF0mgBq1R9lCcwbe2r6TqcxUwbqwaJkqZH9cw9/LVV7EFdmYuMgd/EJ
        bE7nIHBZkUdDP4tInaLnet3S4NftDcrsMYiYzqNt+KNx2faiAr0gBBUFlPA6g+QG
        8JSYJmFwdVlbgoc0WOtwz096EPEkg==
DomainKey-Signature: a=rsa-sha1; c=nofws; d=fifth.space; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=dkim; b=GH1jeZnoa9AhBKQ1Wua
        IhJXK0YsjJ8PYtiWAK5EWhc2ChyCH8HpWSJd3kdcbPuMiOzrjKVoi1vKsP2jVWWK
        aWMb/riTLtbAuGRzAy6UToiYsmysKpjufHMn0Hr4hNQeysLpdUsLQ8mhDiAfSkMJ
        a4E1zqxbXOlXbwg53ZukLbdKSmQxjouLS0VZND0nE23oAul3nloyaMglOEapPiV0
        IOyVcZgLj4sM5dB19t7xmnAsuJaiSPqodugGD0p4E9RJ9W89ibzv3UvZgy2mwfh+
        uybwaNAvJIdSgMpK8eDEjUBdxjY2hbjM/1s/nB7DzJq3+BqbBLZ9sU0jiGyjRdjC
        1Qg==
Received: from localhost (fifth.space [local])
        by fifth.space (OpenSMTPD) with ESMTPA id 959ad8a2;
        Sat, 21 Sep 2019 20:50:23 +0200 (CEST)
From:   Quentin Rameau <quinq@fifth.space>
To:     util-linux@vger.kernel.org
Cc:     Quentin Rameau <quinq@fifth.space>
Subject: [PATCH 2/2] chsh: replace getpw unsafe functions with xgetpw
Date:   Sat, 21 Sep 2019 20:50:21 +0200
Message-Id: <20190921185021.10568-3-quinq@fifth.space>
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
 login-utils/chsh.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/login-utils/chsh.c b/login-utils/chsh.c
index 9b2761157..a9ebec86f 100644
--- a/login-utils/chsh.c
+++ b/login-utils/chsh.c
@@ -38,6 +38,7 @@
 #include "islocal.h"
 #include "nls.h"
 #include "pathnames.h"
+#include "pwdutils.h"
 #include "setpwnam.h"
 #include "strutils.h"
 #include "xalloc.h"
@@ -253,7 +254,7 @@ static void check_shell(const char *shell)
 
 int main(int argc, char **argv)
 {
-	char *oldshell;
+	char *oldshell, *pwbuf;
 	int nullshell = 0;
 	const uid_t uid = getuid();
 	struct sinfo info = { NULL };
@@ -267,12 +268,12 @@ int main(int argc, char **argv)
 
 	parse_argv(argc, argv, &info);
 	if (!info.username) {
-		pw = getpwuid(uid);
+		pw = xgetpwuid(uid, &pwbuf);
 		if (!pw)
 			errx(EXIT_FAILURE, _("you (user %d) don't exist."),
 			     uid);
 	} else {
-		pw = getpwnam(info.username);
+		pw = xgetpwnam(info.username, &pwbuf);
 		if (!pw)
 			errx(EXIT_FAILURE, _("user \"%s\" does not exist."),
 			     info.username);
-- 
2.21.0

