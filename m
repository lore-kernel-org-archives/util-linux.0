Return-Path: util-linux-owner@vger.kernel.org
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:50925 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932928Ab3DGIML (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Apr 2013 04:12:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtteri2.pp.htv.fi (Postfix) with ESMTP id 53B9A19BDCB
	for <util-linux@vger.kernel.org>; Sun,  7 Apr 2013 11:12:09 +0300 (EEST)
Received: from smtp4.welho.com ([213.243.153.38])
	by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
	with ESMTP id L7akW7DEPH7G for <util-linux@vger.kernel.org>;
	Sun,  7 Apr 2013 11:12:09 +0300 (EEST)
Received: from viper.bobcat.mine.nu.bobcat.mine.nu (cs78200229.pp.htv.fi [62.78.200.229])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp4.welho.com (Postfix) with ESMTPS id EC1775BC016
	for <util-linux@vger.kernel.org>; Sun,  7 Apr 2013 11:12:08 +0300 (EEST)
From: =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/5] uuidd.8: Document --debug and --quiet long options.
Date: Sun,  7 Apr 2013 11:12:06 +0300
Message-Id: <1365322328-1607-3-git-send-email-ville.skytta@iki.fi>
In-Reply-To: <1365322328-1607-1-git-send-email-ville.skytta@iki.fi>
References: <1365322328-1607-1-git-send-email-ville.skytta@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Ville Skyttä <ville.skytta@iki.fi>
---
 misc-utils/uuidd.8.in | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/misc-utils/uuidd.8.in b/misc-utils/uuidd.8.in
index f35a41e..c38d715 100644
--- a/misc-utils/uuidd.8.in
+++ b/misc-utils/uuidd.8.in
@@ -17,7 +17,7 @@ in a secure and guaranteed-unique fashion, even in the face of large
 numbers of threads running on different CPUs trying to grab UUIDs.
 .SH OPTIONS
 .TP
-.B \-d
+.BR \-d , " \-\-debug "
 Run uuidd in debugging mode.  This prevents uuidd from running as a daemon.
 .TP
 .BR \-h , " \-\-help "
@@ -48,7 +48,7 @@ process.  Implies --no-fork and --no-pid.  As of this writing, this option is
 supposed to be used only with systemd.  This option must be enabled with a configure
 option.
 .TP
-.B \-q
+.BR \-q , " \-\-quiet "
 Suppress some failure messages.
 .TP
 .BR \-r , " \-\-random "
-- 
1.7.11.7

