Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39432EB64DA
	for <util-linux@archiver.kernel.org>; Tue,  4 Jul 2023 09:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjGDJXM (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 4 Jul 2023 05:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjGDJWb (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 4 Jul 2023 05:22:31 -0400
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35701A4
        for <util-linux@vger.kernel.org>; Tue,  4 Jul 2023 02:22:25 -0700 (PDT)
From:   Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1688462072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZVjYruNRPeslzPVJ3d81pTnznipS2okvS/UF3uFGvfM=;
        b=HOfoICFf0DV/0agy5pXEhzznx4/L7ZOTaawbCtXdEvbsnG0izeZEqgw+XvSwa0i4FfzLTj
        TjVvcPRg/A+680MF7CrPC8pUFj71kje3RWLPvc4DPqXwRmZYcMFrIwEeVERAHpH+yjZVaI
        PUx1JhxCE71V7LZcy+bcNPBmR0OGaoJqeYvAexAtn07uQoMtsBdZ7YFV5J7Gb/ThuiiXf1
        pHdLAucUdLDzthlBmI1pMnb4fo2o9VtwxCqtNdc1IDVNjxFk+ncsiq5NVJo20nccciJOaL
        zT115DVsYwSjF2I4iq6d5KeaR/qmE07AVCWggWsseUs5RCExNZK6Hflw3YwiFQ==
To:     util-linux@vger.kernel.org
Subject: [PATCH 1/3] lib/pager: Allow PAGER commands with options
Date:   Tue,  4 Jul 2023 11:14:28 +0200
Message-Id: <20230704091430.3555428-1-dsimic@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

It's quite common to have options in the commands specified in the
PAGER environment variable, to customize the behavior of the configured
output filter.  For example, someone might want to include the "-X"
option when less(1) is configured as the output filter, or might want
to specifically not include it, depending on the personal preferences.

For example, man(1), git(1) and bat(1) already allow and properly handle
the presence of any options in the configured output filter commands,
which assures that it's fine to do the same in util-linux.

Here's also a quotation from the description of the man(1) utility that
describes the PAGER environment variable, as found in The Single UNIX
Specification, version 4:

  PAGER
       Determine an output filtering command for writing the output
       to a terminal. Any string acceptable as a command_string operand
       to the sh -c command shall be valid. When standard output is
       a terminal device, the reference page output shall be piped
       through the command. If the PAGER variable is null or not set,
       the command shall be either more or another paginator utility
       documented in the system documentation.

This quotation just confirms, rather formally, that allowing options
in the output filter commands is a perfectly valid thing to do.

While there, perform a couple of minor cleanups as well, to make the
formatting of the code a tiny bit more consistent, and to slightly
improve one of the logged debug messages.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 lib/pager.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/lib/pager.c b/lib/pager.c
index 9429032b3..db7a989df 100644
--- a/lib/pager.c
+++ b/lib/pager.c
@@ -178,35 +178,45 @@ static void wait_for_pager_signal(int signo)
 static int has_command(const char *cmd)
 {
 	const char *path;
-	char *p, *s;
+	char *b, *c, *p, *s;
 	int rc = 0;
 
 	if (!cmd)
 		goto done;
-	if (*cmd == '/') {
-		rc = access(cmd, X_OK) == 0;
+
+	c = xstrdup(cmd);
+	if (!c)
 		goto done;
+	b = strtok(c, " ");	/* cmd may contain options */
+	if (!b)
+		goto cleanup;
+
+	if (*b == '/') {
+		rc = access(b, X_OK) == 0;
+		goto cleanup;
 	}
 
 	path = getenv("PATH");
 	if (!path)
-		goto done;
+		goto cleanup;
 	p = xstrdup(path);
 	if (!p)
-		goto done;
+		goto cleanup;
 
-	for(s = strtok(p, ":"); s; s = strtok(NULL, ":")) {
+	for (s = strtok(p, ":"); s; s = strtok(NULL, ":")) {
 		int fd = open(s, O_RDONLY|O_CLOEXEC);
 		if (fd < 0)
 			continue;
-		rc = faccessat(fd, cmd, X_OK, 0) == 0;
+		rc = faccessat(fd, b, X_OK, 0) == 0;
 		close(fd);
 		if (rc)
 			break;
 	}
 	free(p);
+cleanup:
+	free(c);
 done:
-	/*fprintf(stderr, "has PAGER %s rc=%d\n", cmd, rc);*/
+	/*fprintf(stderr, "has PAGER '%s': rc=%d\n", cmd, rc);*/
 	return rc;
 }
 
-- 
2.33.1

