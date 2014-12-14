Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f177.google.com ([209.85.212.177]:45208 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbaLNRoo (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Dec 2014 12:44:44 -0500
Received: by mail-wi0-f177.google.com with SMTP id l15so6948148wiw.4
        for <util-linux@vger.kernel.org>; Sun, 14 Dec 2014 09:44:43 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 01/16] lslogins: allow changing password changed and expiration time formats
Date: Sun, 14 Dec 2014 17:43:57 +0000
Message-Id: <1418579052-29386-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1418579052-29386-1-git-send-email-kerolasa@iki.fi>
References: <1418579052-29386-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The password change and expiry has are marked with resolution of a day,
so add a new short iso-8601 format.  With this system admins can easily
find users has not updated their password lately

$ lslogins --time-format=iso --user --output=pwd-change,user | sort -n

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/lslogins.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/login-utils/lslogins.c b/login-utils/lslogins.c
index 9929b14..f050595 100644
--- a/login-utils/lslogins.c
+++ b/login-utils/lslogins.c
@@ -143,6 +143,7 @@ enum {
 	TIME_SHORT,
 	TIME_FULL,
 	TIME_ISO,
+	TIME_ISO_SHORT,
 };
 
 /*
@@ -349,6 +350,9 @@ static char *make_time(int mode, time_t time)
 	case TIME_ISO:
 		strftime(buf, sizeof(buf), "%Y-%m-%dT%H:%M:%S%z", &tm);
 		break;
+	case TIME_ISO_SHORT:
+		strftime(buf, sizeof(buf), "%Y-%m-%d", &tm);
+		break;
 	default:
 		errx(EXIT_FAILURE, _("unsupported time type"));
 	}
@@ -693,7 +697,8 @@ static struct lslogins_user *get_user_info(struct lslogins_control *ctl, const c
 			break;
 		case COL_PWD_EXPIR:
 			if (shadow && shadow->sp_expire >= 0)
-				user->pwd_expire = make_time(TIME_SHORT,
+				user->pwd_expire = make_time(ctl->time_mode == TIME_ISO ?
+						TIME_ISO_SHORT : ctl->time_mode,
 						shadow->sp_expire * 86400);
 			break;
 		case COL_PWD_CTIME:
@@ -701,7 +706,8 @@ static struct lslogins_user *get_user_info(struct lslogins_control *ctl, const c
 			 * (especially in non-GMT timezones) would only serve
 			 * to confuse */
 			if (shadow)
-				user->pwd_ctime = make_time(TIME_SHORT,
+				user->pwd_ctime = make_time(ctl->time_mode == TIME_ISO ?
+						TIME_ISO_SHORT : ctl->time_mode,
 						shadow->sp_lstchg * 86400);
 			break;
 		case COL_PWD_CTIME_MIN:
-- 
2.1.3

