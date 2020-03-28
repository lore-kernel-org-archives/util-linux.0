Return-Path: <SRS0=sRCm=5N=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57DFC43331
	for <util-linux@archiver.kernel.org>; Sat, 28 Mar 2020 22:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B233220732
	for <util-linux@archiver.kernel.org>; Sat, 28 Mar 2020 22:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgC1WkW (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 28 Mar 2020 18:40:22 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:40623 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbgC1WkW (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 28 Mar 2020 18:40:22 -0400
X-Greylist: delayed 386 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Mar 2020 18:40:21 EDT
Received: from localhost.localdomain (i19-les04-th2-31-36-16-7.sfr.lns.abo.bbox.fr [31.36.16.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 2B3A35648B4;
        Sat, 28 Mar 2020 23:33:56 +0100 (CET)
From:   Aurelien LAJOIE <orel@melix.net>
To:     util-linux@vger.kernel.org
Cc:     Aurelien LAJOIE <orel@melix.net>
Subject: [PATCH 3/3] cal: correctly set the week width
Date:   Sat, 28 Mar 2020 23:33:41 +0100
Message-Id: <20200328223341.11463-3-orel@melix.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200328223341.11463-1-orel@melix.net>
References: <20200328223341.11463-1-orel@melix.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Mar 28 23:33:57 2020 +0100 (CET))
X-Org-Mail: aurelien.lajoie.2000@polytechnique.org
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

There is seven values but only 6 spaces between them, that why the -1
The value is always used with a minus one, just set it correctly instead
of always fix when used

Signed-off-by: Aurelien LAJOIE <orel@melix.net>
---
 misc-utils/cal.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 7cd6545d1..feff1e805 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -452,6 +452,11 @@ int main(int argc, char **argv)
 		ctl.week_width = (ctl.day_width * DAYS_IN_WEEK) + WNUM_LEN;
 	} else
 		ctl.week_width = ctl.day_width * DAYS_IN_WEEK;
+	/*
+	 * The day_width includes the space between days,
+	 * as there is no leading space, remove 1
+	 * */
+	ctl.week_width -= 1;
 
 	if (argc == 1 && !isdigit_string(*argv)) {
 		usec_t x;
@@ -688,7 +693,7 @@ static void headers_init(struct cal_control *ctl)
 
 	for (i = 0; i < MONTHS_IN_YEAR; i++) {
 		/* The +1 after year_len is space in between month and year. */
-		if (ctl->week_width < strlen(ctl->full_month[i]) + year_len + 1)
+		if (ctl->week_width < strlen(ctl->full_month[i]) + year_len)
 			ctl->header_hint = 1;
 	}
 }
@@ -757,19 +762,19 @@ static void cal_output_header(struct cal_month *month, const struct cal_control
 	if (ctl->header_hint || ctl->header_year) {
 		for (i = month; i; i = i->next) {
 			snprintf(out, sizeof(out), "%s", ctl->full_month[i->month - 1]);
-			center(out, ctl->week_width - 1, i->next == NULL ? 0 : ctl->gutter_width);
+			center(out, ctl->week_width, i->next == NULL ? 0 : ctl->gutter_width);
 		}
 		if (!ctl->header_year) {
 			my_putstring("\n");
 			for (i = month; i; i = i->next) {
 				snprintf(out, sizeof(out), "%04d", i->year);
-				center(out, ctl->week_width - 1, i->next == NULL ? 0 : ctl->gutter_width);
+				center(out, ctl->week_width, i->next == NULL ? 0 : ctl->gutter_width);
 			}
 		}
 	} else {
 		for (i = month; i; i = i->next) {
 			snprintf(out, sizeof(out), "%s %04d", ctl->full_month[i->month - 1], i->year);
-			center(out, ctl->week_width - 1, i->next == NULL ? 0 : ctl->gutter_width);
+			center(out, ctl->week_width, i->next == NULL ? 0 : ctl->gutter_width);
 		}
 	}
 	my_putstring("\n");
@@ -909,7 +914,7 @@ static void yearly(const struct cal_control *ctl)
 	char out[FMT_ST_CHARS];
 	int year_width;
 
-	year_width = ctl->months_in_row * (ctl->week_width - 1) +
+	year_width = ctl->months_in_row * (ctl->week_width) +
 		(ctl->months_in_row - 1) * ctl->gutter_width;
 
 	if (ctl->header_year) {
-- 
2.20.1

