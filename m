Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ww0-f44.google.com ([74.125.82.44]:65194 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928Ab1KNNsC (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 14 Nov 2011 08:48:02 -0500
Received: by wwe5 with SMTP id 5so4396244wwe.1
        for <util-linux@vger.kernel.org>; Mon, 14 Nov 2011 05:48:01 -0800 (PST)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH 1/3] fdisk: use ngettext() in str_units() for plural forms
Date: Mon, 14 Nov 2011 14:47:17 +0100
Message-Id: <1321278439-9392-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 fdisk/fdisk.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index d517d4b..5b8e24a 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -1542,11 +1542,11 @@ get_nonexisting_partition(int warn, int max) {
 }
 
 const char *
-str_units(int n) {	/* n==1: use singular */
-	if (n == 1)
-		return display_in_cyl_units ? _("cylinder") : _("sector");
-	else
-		return display_in_cyl_units ? _("cylinders") : _("sectors");
+str_units(int n)
+{
+	if (display_in_cyl_units)
+		return P_("cylinder", "cylinders", n);
+	return P_("sector", "sectors", n);
 }
 
 void change_units(void)
-- 
1.7.3.4

