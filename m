Return-Path: <SRS0=rKDH=AV=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A924EC433E8
	for <util-linux@archiver.kernel.org>; Fri, 10 Jul 2020 12:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87D0320720
	for <util-linux@archiver.kernel.org>; Fri, 10 Jul 2020 12:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MChGhT6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgGJMP3 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 10 Jul 2020 08:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgGJMP2 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 10 Jul 2020 08:15:28 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A83C08C5CE
        for <util-linux@vger.kernel.org>; Fri, 10 Jul 2020 05:15:28 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id g139so3063059lfd.10
        for <util-linux@vger.kernel.org>; Fri, 10 Jul 2020 05:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=fg9gtudSwmdYzAnZovNppI2fgUbWQC/CkaXpb/WGNYM=;
        b=MChGhT6I2NMczHp9SriQY0pW5mDA8BJ/HjTfYdBjXijSJF72t57y4FWm/JhQUzxSeB
         chtDTpLVgzIWNxYEIphCvPKkKbeL9VnM4bEprLLjnu4/tjWpfPMqO2h0lR8IScPl3B1g
         fFse6L9y9zv8rvGe8+Gm3a+hWasb+LunyNjFPHhR9hQF8aNBsIvlHJIkYSwct9/bz5TE
         Qeno2tMLOehomv8ZF8fBMlgvZgTdk57sV5kiI0sQAAyE02EXmZUtzpKuYSjZeOGWUHAC
         /09FpixbPZM5wzCGZfX9FFvzzqicoHfc3hVoQhCfG+SznjPtG6QC1Qo8QJKdgRhdtKht
         t7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=fg9gtudSwmdYzAnZovNppI2fgUbWQC/CkaXpb/WGNYM=;
        b=tZH60ipooT2LG8cZNvuyplhPbnn43HTBI2aVGpvVqpG6R1nW37TBjs4EDiTcSixLiE
         hOYXKPeS54/H+Dt9znC8r38XlCUNrnUQt/31QaTfLS9fSEUGrxMTbImQ3N2d38n4F14W
         kfLxfNhKKeQwN88f+dHF1uLPcNT0vRlCz9WjchC6RIQL8LvrHQ1y0I0HxAIinoatoUpK
         lrNoeEX1CwqNhfey+1toXe6aJMc4NEpOAfOaZINot9/MDn84wVMt/JO60pDo064n9NQS
         iqjkrx3kZ4ax3wnwbN7OYadaNnD3Qg7itneb8hJnZgpyK7MNJidUy/ktxc47gyLifuQd
         6gMQ==
X-Gm-Message-State: AOAM531GqWSidP1Qgt8hkoKrx4smmb35KqwcgpVajIBnlel5rriwM2lg
        Tj9EEXiOt9DyuKBpw8TDBZskNRFy0/Y4+yEUyZUOHnO2
X-Google-Smtp-Source: ABdhPJwBRmnAO/ssC8TOdhCqowAOhptJZQGb9oHoajJUqHMcYaq9vAoC7cIwQJN1q8OSvu+jU/QWoOq1PXcy4NVE1L4=
X-Received: by 2002:a19:ca48:: with SMTP id h8mr43255393lfj.161.1594383326629;
 Fri, 10 Jul 2020 05:15:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:7c04:0:0:0:0:0 with HTTP; Fri, 10 Jul 2020 05:15:25
 -0700 (PDT)
From:   Soumendra Ganguly <soumendraganguly@gmail.com>
Date:   Fri, 10 Jul 2020 07:15:25 -0500
Message-ID: <CAOW54GXn9KWBEquqCyuBOnADk-MLXA0LpBqUj=kp138Z2KFLEA@mail.gmail.com>
Subject: [PATCH] term-utils: Make scriptreplay set terminal to raw mode
To:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

scriptreplay produces garbled output while replaying certain curses
sessions. script(1) from util-linux is able to record the sessions
correctly.

The following programs can be used to demonstrate this.

1. A curses-based game called "greed"; a Debian 10 package named
"greed" is available.

2. A Python implementation of Conway's game of life by GitHub user
iiSeymour. The repository is named game-of-life.

Expected output is obtained by making scriptreplay call cfmakeraw.

Signed-off-by: Soumendra Ganguly <soumendraganguly@gmail.com>
---
 term-utils/scriptreplay.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/term-utils/scriptreplay.c b/term-utils/scriptreplay.c
index bca1d21b4..19a7d568b 100644
--- a/term-utils/scriptreplay.c
+++ b/term-utils/scriptreplay.c
@@ -28,6 +28,7 @@
 #include <unistd.h>
 #include <getopt.h>
 #include <sys/time.h>
+#include <termios.h>

 #include "c.h"
 #include "xalloc.h"
@@ -120,12 +121,30 @@ static void appendchr(char *buf, size_t bufsz, int c)
 		buf[sz] = c;
 }

+static int termraw(struct termios *backup)
+{
+	struct termios tattr;
+
+	if (tcgetattr(STDOUT_FILENO, backup) != 0)
+		return -1;
+
+	tattr = *backup;
+	cfmakeraw(&tattr);
+	if (tcsetattr(STDOUT_FILENO, TCSANOW, &tattr) != 0)
+		return -1;
+
+	return 0;
+}
+
 int
 main(int argc, char *argv[])
 {
 	static const struct timeval mindelay = { .tv_sec = 0, .tv_usec = 100 };
 	struct timeval maxdelay;

+	char isterm;
+	struct termios saved;
+
 	struct replay_setup *setup = NULL;
 	struct replay_step *step = NULL;
 	char streams[6] = {0};		/* IOSI - in, out, signal,info */
@@ -286,6 +305,10 @@ main(int argc, char *argv[])
 		replay_set_delay_max(setup, &maxdelay);
 	replay_set_delay_min(setup, &mindelay);

+	isterm = isatty(STDOUT_FILENO);
+	if (isterm && termraw(&saved) != 0)
+		err(EXIT_FAILURE, _("failed to set terminal to raw mode"));
+
 	do {
 		rc = replay_get_next_step(setup, streams, &step);
 		if (rc)
@@ -300,6 +323,9 @@ main(int argc, char *argv[])
 		rc = replay_emit_step_data(setup, step, STDOUT_FILENO);
 	} while (rc == 0);

+	if (isterm)
+		tcsetattr(STDOUT_FILENO, TCSADRAIN, &saved);
+
 	if (step && rc < 0)
 		err(EXIT_FAILURE, _("%s: log file error"), replay_step_get_filename(step));
 	else if (rc < 0)
-- 
2.20.1
