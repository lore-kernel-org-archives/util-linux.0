Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33358 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbcHCXgM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 3 Aug 2016 19:36:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id o80so38683345wme.0
        for <util-linux@vger.kernel.org>; Wed, 03 Aug 2016 16:35:48 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/2] uuidd: remove unnecessary pidpile path variable
Date: Wed,  3 Aug 2016 23:41:58 +0100
Message-Id: <20160803224158.23657-2-kerolasa@iki.fi>
In-Reply-To: <20160803224158.23657-1-kerolasa@iki.fi>
References: <20160803224158.23657-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/uuidd.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index 77c967d..dce12c0 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -543,7 +543,6 @@ int main(int argc, char **argv)
 {
 	const char	*socket_path = UUIDD_SOCKET_PATH;
 	const char	*pidfile_path = NULL;
-	const char	*pidfile_path_param = NULL;
 	const char	*err_context = NULL;
 	char		buf[1024], *cp;
 	char		str[UUID_STR_LEN];
@@ -601,7 +600,7 @@ int main(int argc, char **argv)
 						_("failed to parse --uuids"));
 			break;
 		case 'p':
-			pidfile_path_param = optarg;
+			pidfile_path = optarg;
 			break;
 		case 'P':
 			no_pid = 1;
@@ -646,10 +645,8 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (!no_pid && !pidfile_path_param)
+	if (!no_pid && !pidfile_path)
 		pidfile_path = UUIDD_PIDFILE_PATH;
-	else if (pidfile_path_param)
-		pidfile_path = pidfile_path_param;
 
 #ifdef HAVE_LIBSYSTEMD
 	if (getppid() == 1 && 0 < sd_booted() &&
-- 
2.9.2

