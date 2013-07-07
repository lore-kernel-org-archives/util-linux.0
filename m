Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f46.google.com ([74.125.83.46]:33347 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab3GGTz0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Jul 2013 15:55:26 -0400
Received: by mail-ee0-f46.google.com with SMTP id d41so2385079eek.33
        for <util-linux@vger.kernel.org>; Sun, 07 Jul 2013 12:55:25 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 10/34] dmesg: inform user --show-delta and iso8601 time format does not mix
Date: Sun,  7 Jul 2013 20:54:25 +0100
Message-Id: <1373226889-3451-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

References: http://marc.info/?l=util-linux-ng&m=137267606929951&w=2
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/dmesg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index 881e3ac..64b1c09 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -1370,6 +1370,9 @@ int main(int argc, char *argv[])
 		case DMESG_TIMEFTM_TIME:
 			ctl.time_fmt = DMESG_TIMEFTM_TIME_DELTA;
 			break;
+		case DMESG_TIMEFTM_ISO8601:
+			warnx(_("--show-delta is ignored when used together with iso8601 time format"));
+			break;
 		default:
 			ctl.time_fmt = DMESG_TIMEFTM_DELTA;
 		}
-- 
1.8.3.2

