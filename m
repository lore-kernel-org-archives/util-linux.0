Return-Path: util-linux-owner@vger.kernel.org
Received: from mozilla-myt-1.haze.yandex.net ([77.88.23.115]:53444 "EHLO
        mail.unsafe.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752743AbdEDOBL (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 4 May 2017 10:01:11 -0400
Received: from comp-core-i7-2640m-0182e6 (nat-pool-brq-t.redhat.com [213.175.37.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.unsafe.ru (Postfix) with ESMTPSA id 3F7A8D40FD1
        for <util-linux@vger.kernel.org>; Thu,  4 May 2017 13:52:55 +0000 (UTC)
Date: Thu, 4 May 2017 15:53:13 +0200
From: Alexey Gladkov <gladkov.alexey@gmail.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] Fix blkid return code when display the version
Message-ID: <20170504135313.GJ24836@comp-core-i7-2640m-0182e6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 misc-utils/blkid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index a472d06..ec385b7 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -762,6 +762,7 @@ int main(int argc, char **argv)
 		case 'V':
 		case 'v':
 			print_version(stdout);
+			err = 0;
 			goto exit;
 		case 'w':
 			/* ignore - backward compatibility */
-- 
2.10.2

