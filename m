Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05281C49EA6
	for <util-linux@archiver.kernel.org>; Thu, 24 Jun 2021 21:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4B77613BD
	for <util-linux@archiver.kernel.org>; Thu, 24 Jun 2021 21:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbhFXV24 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 24 Jun 2021 17:28:56 -0400
Received: from server.contractcoder.biz ([67.209.116.215]:55712 "EHLO
        server.contractcoder.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbhFXV2z (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 24 Jun 2021 17:28:55 -0400
Received: by server.contractcoder.biz (Postfix, from userid 109)
        id 4452D2500944; Thu, 24 Jun 2021 22:26:35 +0100 (BST)
Received: from contractcoder.biz (cpc137950-brom13-2-0-cust104.16-1.cable.virginm.net [82.46.16.105])
        by server.contractcoder.biz (Postfix) with ESMTPSA id 25B4B2500941
        for <util-linux@vger.kernel.org>; Thu, 24 Jun 2021 22:26:33 +0100 (BST)
Date:   Thu, 24 Jun 2021 22:26:32 +0100
From:   Ian Jones <ian@contractcoder.biz>
To:     util-linux@vger.kernel.org
Subject: Additions to earlier more POSIX compliance patch.
Message-ID: <20210624212632.GC2541@contractcoder.biz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Apologies, I forgot to update the manpage. I have also modified the
prompt to display '(END)' at EOF.

I hope you find these patches acceptable.

Best regards,

Ian

--jho1yZJdad60DJr+
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0003-Addition-of-e-flag-to-for-POSIX-compliance.patch"

From fc87c44a7bce26fdf4e5048f37d37fc3e059c29b Mon Sep 17 00:00:00 2001
From: Ian Jones <ian@contractcoder.biz>
Date: Thu, 24 Jun 2021 14:14:21 +0100
Subject: [PATCH 3/6] Addition of -e flag to for POSIX compliance.

---
 text-utils/more.1.adoc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/text-utils/more.1.adoc b/text-utils/more.1.adoc
index 43124cac1..9cb463453 100644
--- a/text-utils/more.1.adoc
+++ b/text-utils/more.1.adoc
@@ -65,6 +65,9 @@ Prompt with "[Press space to continue, 'q' to quit.]", and display "[Press 'h' f
 *-l*, *--logical*::
 Do not pause after any line containing a *^L* (form feed).
 
+*-e*, *--exit-on-eof*::
+Exit on EOF.
+
 *-f*, *--no-pause*::
 Count logical lines, rather than screen lines (i.e., long lines are not folded).
 
-- 
2.20.1


--jho1yZJdad60DJr+
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0006-Display-END-at-EOF.patch"

From 2d9001cc3f4eac9f74599b687ca6ea552332ddfc Mon Sep 17 00:00:00 2001
From: Ian Jones <ian@contractcoder.biz>
Date: Thu, 24 Jun 2021 22:02:23 +0100
Subject: [PATCH 6/6] Display '(END)' at EOF.

---
 text-utils/more.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index f4da7724e..d1fab940c 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -732,9 +732,13 @@ static void output_prompt(struct more_control *ctl, char *filename)
 		if (filename != NULL) {
 			ctl->prompt_len += printf(_("(Next file: %s)"), filename);
 		} else if (!ctl->no_tty_in && 0 < ctl->file_size) {
-			ctl->prompt_len +=
-			    printf("(%d%%)",
-				   (int)((ctl->file_position * 100) / ctl->file_size));
+            int position = ((ctl->file_position * 100) / ctl->file_size);
+            if (position == 100) {
+		        erase_to_col(ctl, 0);
+                ctl->prompt_len += printf(_("(END)"));
+            } else {
+			    ctl->prompt_len += printf("(%d%%)", position);
+            }
 		}
 		if (ctl->suppress_bell) {
 			ctl->prompt_len +=
-- 
2.20.1


--jho1yZJdad60DJr+--
