Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f52.google.com ([74.125.82.52]:56447 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018Ab3HQSQf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 17 Aug 2013 14:16:35 -0400
Received: by mail-wg0-f52.google.com with SMTP id b13so2381251wgh.31
        for <util-linux@vger.kernel.org>; Sat, 17 Aug 2013 11:16:34 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 09/16] last: make switch cases complete, and inform if impossible occurs
Date: Sat, 17 Aug 2013 19:15:14 +0100
Message-Id: <1376763321-22782-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1376763321-22782-1-git-send-email-kerolasa@iki.fi>
References: <1376763321-22782-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Some of the ut_type numbers does not seem to be recognized by last(1) so
they are, at least for now, silently ignored.  See glibc documentation
for information what the ignored EMPTY, INIT_PROCESS, LOGIN_PROCESS, and
ACCOUNTING mean.

Reference: FIXME
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/last.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/login-utils/last.c b/login-utils/last.c
index f188092..276d13a 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -343,6 +343,8 @@ static int list(struct utmp *p, time_t t, int what)
 			break;
 		case R_NORMAL:
 			break;
+		default:
+			abort();
 	}
 
 	/*
@@ -808,6 +810,15 @@ int main(int argc, char **argv)
 			utmplist = p;
 			break;
 
+		case EMPTY:
+		case INIT_PROCESS:
+		case LOGIN_PROCESS:
+		case ACCOUNTING:
+			/* ignored ut_types */
+			break;
+
+		default:
+			warnx("unrecogized ut_type: %d", ut.ut_type);
 		}
 
 		/*
-- 
1.8.3.4

