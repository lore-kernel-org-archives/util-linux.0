Return-Path: <SRS0=Xb09=QY=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8735FC43381
	for <util-linux@archiver.kernel.org>; Sun, 17 Feb 2019 21:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD3C2146E
	for <util-linux@archiver.kernel.org>; Sun, 17 Feb 2019 21:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfBQVzl (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 17 Feb 2019 16:55:41 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:46289 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfBQVzl (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 17 Feb 2019 16:55:41 -0500
Received: from pepper.home.stoeckmann.org ([217.87.204.172]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MQMmF-1ghvjR0LWz-00MILH for <util-linux@vger.kernel.org>; Sun, 17 Feb
 2019 22:55:40 +0100
Received: from localhost (192.168.2.125 [192.168.2.125])
        by pepper.home.stoeckmann.org (OpenSMTPD) with ESMTPSA id 0095316f (TLSv1.2:ECDHE-RSA-CHACHA20-POLY1305:256:NO)
        for <util-linux@vger.kernel.org>;
        Sun, 17 Feb 2019 22:55:39 +0100 (CET)
Date:   Sun, 17 Feb 2019 22:55:29 +0100
From:   Tobias Stoeckmann <tobias@stoeckmann.org>
To:     util-linux@vger.kernel.org
Subject: [PATCH 1/1] sfdisk: Avoid out of boundary read with readline
Message-ID: <20190217215529.zh3rn57hqu7rruze@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:O9tI2oh5KbalFpgT6fbyTSOLDWzseQmkYKn6vu5+d4mAgJ+SUtI
 NodCE30ZCYs4AhQA7MH+BgdE/eQcZOkljHTQgxbYIv6lnNQidps4RH7gr+zpCWv49IQTZKX
 BA4lhjT+AwH+kJxqEarTeMIUf3zGqh4juVmwkiAKsEAEMsKS5iDJv44vHcO2foSxLpe7AjK
 y2J7YjNJkRtU3E9B7Y+GQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rJVbRlhYzZc=:QDz0Dvb+H7cb8zKyXXRslv
 I59Fip1jpe8q19Yh6VBD79XfTviIS7B9dJiRYsR+OQN+ulDOVUZuNx+Qes0rUu/ZXh5OjYfmZ
 qHDlxxzWqV0XXltR6S0nKBuTOEqyVc8K08qCqm7qyyhHkX2nAqukO8W3oOnSYTCODvyQrOcIw
 8jjMOgZHWIA23YWkmuFZ9ITqQ19mjQcSyiVHkkPFq5lFLbQbqv7hINH0I82XHcAajGch0Q6/6
 YrHgXTr2uPcvx/AGxvLRKqok+2DnzPpFx/ANMpVoVGhlnmvVy4Kf0+96/PBfr/FPQs2bMyf0D
 s9w0m2wElcnOIP3aQTU0M5UkDfTTumVnO/Mbj+GWbIl51s+OjPp03mTKhFhKEFCKPmaKmWpv5
 /wP9K3qYL1z2f10Aourzz1WFlGW95TGUhbOyWJiaF66ZauQVQ6ZGGz7FWDXARWKvsqgIVbePd
 bCeTM75ah87GQKtlYfZpioeXj6buE/94B/pXV1FYHANUljkMCZM7spMYcvAnXfBGBuira4uBq
 8dMzVjmOYAr6PprMz5fSmibFB1HZ7D3tnRGGwpNIAIPk8QdoxYua39k4eQJGKuSFjB7O5O8gS
 9/LQ53r9MOcepehVcFqrZa9vIePCV74oYzT3aBITGa6mbkWajbB2wrE9gonjtJEkQ5foslphz
 xV3nK3qOyy4shm64v+chBcsApyejOBhn8DdoaE1SshngKml/1VxCPsCAT6tGhDdrFb2Guy/K2
 VrzBEsyTWdVjsJ3nBLDksDuXLbkogMwsZpPw9g==
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

It is not guaranteed that the returned string of readline() actually
contains as many bytes as buf can contain.

If bufsz is larger than the allocated memory by readline, an out of
boundary read occurs and leads to undefined behaviour. Most likely
that will be a crash.

This can be reproduced when readline-support is compiled in and when
you directly enter "quit" and "n" (to not write changes back to disk)
when sfdisk was called with any given device.

Signed-off-by: Tobias Stoeckmann <tobias@stoeckmann.org>
---
 disk-utils/sfdisk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index 3911dda85..52ccc5251 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -133,7 +133,9 @@ static int get_user_reply(const char *prompt, char *buf, size_t bufsz)
 		p = readline(prompt);
 		if (!p)
 			return 1;
-		memcpy(buf, p, bufsz);
+		strncpy(buf, p, bufsz);
+		if (bufsz != 0)
+			buf[bufsz - 1] = '\0';
 		free(p);
 	} else
 #endif
-- 
2.20.1

