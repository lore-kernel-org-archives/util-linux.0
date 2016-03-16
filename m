Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews07.kpnxchange.com ([213.75.39.10]:51786 "EHLO
	cpsmtpb-ews07.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965788AbcCPI5Q (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Mar 2016 04:57:16 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 7/8] uuidd: correct the wording of an error message
Date: Wed, 16 Mar 2016 09:55:54 +0100
Message-Id: <1458118555-4691-7-git-send-email-bensberg@justemail.net>
In-Reply-To: <1458118555-4691-1-git-send-email-bensberg@justemail.net>
References: <1458118555-4691-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 misc-utils/uuidd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index 208c361..feb0a0a 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -342,7 +342,7 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 		memset(&timeout, 0, sizeof timeout);
 		timeout.it_value.tv_sec = 30;
 		if (setup_timer(&t_id, &timeout, &timeout_handler))
-			err(EXIT_FAILURE, _("cannot not setup timer"));
+			err(EXIT_FAILURE, _("cannot set up timer"));
 		if (pidfile_path)
 			fd_pidfile = create_pidfile(uuidd_cxt, pidfile_path);
 		ret = call_daemon(socket_path, UUIDD_OP_GETPID, reply_buf,
-- 
1.7.0.4

