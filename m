Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f174.google.com ([209.85.212.174]:45842 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755771Ab3ASAKE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 18 Jan 2013 19:10:04 -0500
Received: by mail-wi0-f174.google.com with SMTP id hq4so5649795wib.13
        for <util-linux@vger.kernel.org>; Fri, 18 Jan 2013 16:10:03 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 20/22] dmesg: parse level when --color is used
Date: Sat, 19 Jan 2013 00:09:09 +0000
Message-Id: <1358554151-25985-21-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
References: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

When user runs with --color it should not need to be combined with
filtering per level or facility, or decoding.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/dmesg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index ddab9b4..080fe7d 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -658,7 +658,7 @@ static int get_next_syslog_record(struct dmesg_control *ctl,
 			continue;	/* error or empty line? */
 
 		if (*begin == '<') {
-			if (ctl->fltr_lev || ctl->fltr_fac || ctl->decode)
+			if (ctl->fltr_lev || ctl->fltr_fac || ctl->decode || ctl->color)
 				begin = parse_faclev(begin + 1, &rec->facility,
 						     &rec->level);
 			else
-- 
1.8.1.1

