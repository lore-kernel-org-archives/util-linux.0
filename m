Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f175.google.com ([74.125.82.175]:63483 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600AbaBPXyz (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Feb 2014 18:54:55 -0500
Received: by mail-we0-f175.google.com with SMTP id q59so9954448wes.6
        for <util-linux@vger.kernel.org>; Sun, 16 Feb 2014 15:54:54 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 9/9] isosize: make --divisor to require argument
Date: Sun, 16 Feb 2014 23:54:22 +0000
Message-Id: <1392594862-15807-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1392594862-15807-1-git-send-email-kerolasa@iki.fi>
References: <1392594862-15807-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Silly bug, only the short option -d allowed divisor argument.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/isosize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disk-utils/isosize.c b/disk-utils/isosize.c
index f90029e..5030a50 100644
--- a/disk-utils/isosize.c
+++ b/disk-utils/isosize.c
@@ -186,7 +186,7 @@ int main(int argc, char **argv)
 	long divisor = 0;
 
 	static const struct option longopts[] = {
-		{"divisor", no_argument, 0, 'd'},
+		{"divisor", required_argument, 0, 'd'},
 		{"sectors", no_argument, 0, 'x'},
 		{"version", no_argument, 0, 'V'},
 		{"help", no_argument, 0, 'h'},
-- 
1.9.0

