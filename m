Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33225 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbcBBNkV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 2 Feb 2016 08:40:21 -0500
Received: by mail-wm0-f65.google.com with SMTP id r129so2485755wmr.0
        for <util-linux@vger.kernel.org>; Tue, 02 Feb 2016 05:40:20 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 3/3] swapon: do not run execvp() calls when swapon is setuid binary
Date: Tue,  2 Feb 2016 13:40:10 +0000
Message-Id: <1454420410-654-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1454420410-654-1-git-send-email-kerolasa@iki.fi>
References: <1454420410-654-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

swapon(8) is not expected to be setuid binary, but if it is try to avoid
obvious security vulnerability of executing user preferred mkswap file as
someone else, such as root.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/swapon.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
index 5ad5cd1..be8f771 100644
--- a/sys-utils/swapon.c
+++ b/sys-utils/swapon.c
@@ -297,6 +297,10 @@ static int swap_reinitialize(struct swapon_ctl *ctl)
 	char const *cmd[7];
 	int idx=0;
 
+	if (geteuid() != getuid()) {
+		warnx(_("will not execute mkswap when swapon is setuid binary"));
+		return -1;
+	}
 	warnx(_("%s: reinitializing the swap."), ctl->device);
 
 	switch((pid=fork())) {
-- 
2.7.0

