Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35970 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751667AbcERMvC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 18 May 2016 08:51:02 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E547CC05B1E4
	for <util-linux@vger.kernel.org>; Wed, 18 May 2016 12:51:01 +0000 (UTC)
Received: from ws (ovpn-204-89.brq.redhat.com [10.40.204.89])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u4ICp0lk018692
	for <util-linux@vger.kernel.org>; Wed, 18 May 2016 08:51:01 -0400
Date: Wed, 18 May 2016 14:51:00 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: cal(1) year formatting
Message-ID: <20160518125100.gqvcbbfx23tti6re@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 See the patch below. I have no strong opinion about it, any
 objection?

    Karel


>From e671a62ef8574b16cd6acbfd04dc35c514b184e5 Mon Sep 17 00:00:00 2001
From: Karel Zak <kzak@redhat.com>
Date: Wed, 18 May 2016 14:43:20 +0200
Subject: [PATCH] cal: use %04d for year

It seems that people are crazy enough to assume that "cal 16" is the
year 2016, rather than 16 (2000 years ago).

This patch makes it more clear as the output is 0016.

Addresses: https://github.com/karelzak/util-linux/issues/320
Signed-off-by: Karel Zak <kzak@redhat.com>
---
 misc-utils/cal.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 2a53b89..3e20530 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -516,7 +516,7 @@ static void headers_init(struct cal_control *ctl)
 	char tmp[FMT_ST_CHARS];
 	int year_len;
 
-	year_len = snprintf(tmp, sizeof(tmp), "%d", ctl->req.year);
+	year_len = snprintf(tmp, sizeof(tmp), "%04d", ctl->req.year);
 
 	if (year_len < 0 || (size_t)year_len >= sizeof(tmp)) {
 		/* XXX impossible error */
@@ -612,13 +612,13 @@ static void cal_output_header(struct cal_month *month, const struct cal_control
 		if (!ctl->header_year) {
 			my_putstring("\n");
 			for (i = month; i; i = i->next) {
-				sprintf(out, _("%d"), i->year);
+				sprintf(out, _("%04d"), i->year);
 				center(out, ctl->week_width - 1, i->next == NULL ? 0 : ctl->gutter_width);
 			}
 		}
 	} else {
 		for (i = month; i; i = i->next) {
-			sprintf(out, _("%s %d"), ctl->full_month[i->month - 1], i->year);
+			sprintf(out, _("%s %04d"), ctl->full_month[i->month - 1], i->year);
 			center(out, ctl->week_width - 1, i->next == NULL ? 0 : ctl->gutter_width);
 		}
 	}
@@ -762,7 +762,7 @@ static void yearly(const struct cal_control *ctl)
 		year_width--;
 
 	if (ctl->header_year) {
-		sprintf(out, "%d", ctl->req.year);
+		sprintf(out, "%04d", ctl->req.year);
 		center(out, year_width, 0);
 		my_putstring("\n\n");
 	}
-- 
2.4.11

