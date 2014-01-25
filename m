Return-Path: util-linux-owner@vger.kernel.org
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:58313 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbaAYMX5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 25 Jan 2014 07:23:57 -0500
Received: from localhost (localhost [127.0.0.1])
	by filtteri5.pp.htv.fi (Postfix) with ESMTP id 1EBF95A71CE
	for <util-linux@vger.kernel.org>; Sat, 25 Jan 2014 14:23:54 +0200 (EET)
Received: from smtp4.welho.com ([213.243.153.38])
	by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
	with ESMTP id ylcoYI9wg-eY for <util-linux@vger.kernel.org>;
	Sat, 25 Jan 2014 14:23:49 +0200 (EET)
Received: from viper.local.bobcat.mine.nu (cs78200229.pp.htv.fi [62.78.200.229])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp4.welho.com (Postfix) with ESMTPS id 151885BC010
	for <util-linux@vger.kernel.org>; Sat, 25 Jan 2014 14:23:50 +0200 (EET)
From: =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
To: util-linux@vger.kernel.org
Subject: [PATCH] getopt.1: The usual doc dir is /usr/share/doc, not .../docs
Date: Sat, 25 Jan 2014 14:23:49 +0200
Message-Id: <1390652629-6851-1-git-send-email-ville.skytta@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Ville Skyttä <ville.skytta@iki.fi>
---
 misc-utils/getopt.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/getopt.1 b/misc-utils/getopt.1
index 04fd34a..7fd8720 100644
--- a/misc-utils/getopt.1
+++ b/misc-utils/getopt.1
@@ -418,7 +418,7 @@ Example scripts for (ba)sh and (t)csh are provided with the
 distribution, and are optionally installed in
 .BR /usr/share/getopt/
 or
-.BR /usr/share/docs/
+.BR /usr/share/doc/
 in the util-linux subdirectory.
 .SH ENVIRONMENT
 .IP POSIXLY_CORRECT
-- 
1.8.3.1

