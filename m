Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:50616 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759115Ab2C2Qpo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 29 Mar 2012 12:45:44 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 18CCD90B1D
	for <util-linux@vger.kernel.org>; Thu, 29 Mar 2012 18:45:44 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Subject: [PATCH 12/20] uuidd: --socket-activation implies --keep-privs
Date: Thu, 29 Mar 2012 18:45:20 +0200
Message-Id: <1333039528-24784-13-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
References: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 misc-utils/uuidd.8 |    6 +++---
 misc-utils/uuidd.c |    1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/misc-utils/uuidd.8 b/misc-utils/uuidd.8
index 892f236..8bf5da8 100644
--- a/misc-utils/uuidd.8
+++ b/misc-utils/uuidd.8
@@ -44,9 +44,9 @@ Do not daemonize using double-fork.
 .TP
 .BR \-S , " \-\-socket-activation "
 Do not create the socket and instead expect it to be provided by the calling
-process.  Implies --no-fork and --no-pid.  As of this writing, this option is
-supposed to be used only with systemd. It needs to enabled with configure
-option --enable--uuid-socket-activation.
+process.  Implies --no-fork, --no-pid and --keep-privs.  As of this writing,
+this option is supposed to be used only with systemd. It needs to enabled with
+configure option --enable--uuid-socket-activation.
 .TP
 .BR \-K , " \-\-keep-privs "
 If uuidd is installed set-uid and executed by root, it by default drops its
diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index 54978aa..795129f 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -590,6 +590,7 @@ int main(int argc, char **argv)
 			no_sock = 1;
 			no_fork = 1;
 			no_pid = 1;
+			drop_privs = 0;
 #else
 			fprintf(stderr,
 				_("uuidd has been built without support for socket activation.\n"
-- 
1.7.7

