Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33052 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932968AbcHCW7M (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 3 Aug 2016 18:59:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id o80so38493121wme.0
        for <util-linux@vger.kernel.org>; Wed, 03 Aug 2016 15:58:09 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/2] uuidd: require use of --socket-activation when run as systemd service
Date: Wed,  3 Aug 2016 23:41:57 +0100
Message-Id: <20160803224158.23657-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/uuidd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index a3fe830..77c967d 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -651,6 +651,13 @@ int main(int argc, char **argv)
 	else if (pidfile_path_param)
 		pidfile_path = pidfile_path_param;
 
+#ifdef HAVE_LIBSYSTEMD
+	if (getppid() == 1 && 0 < sd_booted() &&
+	    (!uuidd_cxt.no_sock || !uuidd_cxt.no_fork || !no_pid))
+		errx(EXIT_FAILURE,  _("cannot run as systemd service "
+				      "without --socket-activation"));
+#endif
+
 	/* custom socket path and socket-activation make no sense */
 	if (s_flag && uuidd_cxt.no_sock && !uuidd_cxt.quiet)
 		warnx(_("Both --socket-activation and --socket specified. "
-- 
2.9.2

