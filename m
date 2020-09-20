Return-Path: <SRS0=QC14=C5=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B91C43465
	for <util-linux@archiver.kernel.org>; Sun, 20 Sep 2020 13:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFE0720796
	for <util-linux@archiver.kernel.org>; Sun, 20 Sep 2020 13:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="bgGrznnR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgITNV2 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 20 Sep 2020 09:21:28 -0400
Received: from mout.web.de ([212.227.17.12]:55763 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726306AbgITNV2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 20 Sep 2020 09:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1600608087;
        bh=Em6y7dB7PTS89H4CyGkXYUCmk2fsNdxvh5QMyt/JfYg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=bgGrznnRlL8Zjkz4nDt5cBeoixFfiGIlt+Vtk3yz0SYNVQ1F46SEBKY6fiFShJY8l
         IIjsgY6kzuudP1F/2ztgEawO7aL9rpiZt5nhhSFEVbV58hCXJdreRAabccyWg4GnoC
         85xuEMTI671NwBQJ+c+YdMxYmS7R1B72PE0iY3w8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from archbook.fritz.box ([92.252.29.128]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LrK0u-1kTzVy0GJI-0132Tp; Sun, 20
 Sep 2020 15:08:54 +0200
From:   Lennard Hofmann <lennard.hofmann@web.de>
To:     util-linux@vger.kernel.org
Cc:     Lennard Hofmann <lennard.hofmann@web.de>
Subject: [PATCH 2/4] column: Call mbs_to_wcs("") only once
Date:   Sun, 20 Sep 2020 15:08:16 +0200
Message-Id: <20200920130818.29756-1-lennard.hofmann@web.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:83bVot9JGThsBRp5cYyxfeA59+5vpA7mrBrb2ouEF8VRIwFYmcn
 syCrLzeIHaNvdPNTJzpEycPl4eunVoYK31XzzuP7TwJl0vMV0ERSluxux+Ozb5d38l5nut1
 pwaLf53FlprSeLk1HDpqHwfaxvomSsYtrckVUzVhiv0+3pAZixYiMJCgnrTVcmmHBM6uCjt
 Qwew7ZQuMdyziKHD4EgIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dxQgnFKjCXM=:i8YhNKYbp4n+o5OKETY6Gg
 EAt9K65wqGJ5ybhPqYo9/4rc9PPK8p2WOTh+KBQnTs7HLN56WXcVAj0HdEMSCjSDgYnXjStbs
 Ddiuw0pGyPCy+mhGoW9W9yH+PIf6/1nQIG3B6gKmFwBwR9luy0iyIa1j7DJRffFJtvg76PMRB
 obBt4F1jcQLPeBJLipXSeBxtJ+QPlpE2yG0RMeR7LDG6sE1aVbW0XY8TfKGzQAKBpIcdGu2ff
 P5wAWLZaELGDZtlvRzBcuZpM2q2lMcRsxmyJFktDYKZe3pzeH/bpoCkh47z4Io3Wc0pf1NfBR
 43HP+WNY+WCSf89i+/YTdORgtTdUqkJNCSkhFt7UsF3qPDNF1sN3Ch0giYqftxpvQR0YWgoxo
 aOOUxinfEFoAkJtra6NV7VxbOD6hIN3ovbUnd1Rp8ceEG2bivXEjRykHtczG3lQxQ3BIa/lmd
 HvHx+iXx9ma7/8sKGNdYHfAtPoXHd1vxAoKpfNyWxqGqMyvX4a/0yrxZ72js+XUwdtGqwESZ4
 Lqsjnx7SjONgnZADCkZasdAR7lG0Ho7ZM1+FrP8bMwYjAo8GvOn38qJzEuG8fmP3+v/8pf9Lk
 hIxMKCPepK0ECDP+5dWpTUcPRbnaIbnUNfG/TfEzZCOh4G5/aquF473Wo/KzaZPxkRJKxrE9V
 Ftb5JvO4xB0Mj6yD9c1F9NruRMD86241EYGqb8xWV2BqcnhGc2IvlonrAaQ9IfQwVb2Bx0dot
 I1OE4CEJ5SBGrar7q+TjYThsPV/w9oi8Qbix3tQ/MhQ1FqcOxTPC9qABZtOyqVoS/un9jMokv
 FXNIggNvHQh6HkSAQkwVZq1111coawS+ouakLhzY2CBA1FZgTeVR5syJz4rdtUftxP6i0VbP0
 OnIL8doBbz/2enDYe7IF3NWn/31TwP9ks4tm3GjtoF/OhPs6xCk7UZq9HmWyOamfBAVuIQeBc
 OhOfpxRJgwNonggnUvLWset+bLStlZ87k/u8etSTGy8SwdtFwqLo6kbXUuTwCcX3GSnQV/WPy
 ro1fRgApKy65aOHiG24te2Gj8siela8uvIFCcS6Sm0Zi/hlfTlcNhWrQThNZ1AF/8Fn47qUrH
 yeIeXfg/IWsDZ+PIF4OQw2VpMB11KtIO9JVpEBgLKrZG7kEr3uaJKPdwyb04nVFdbtEowGCDP
 9R1RXWdqrTXgyTYj9JV6C2pvSEQNViQMl2JsNna8mpHnu526Ynxd7ceGIaRfArUS340FKo4Wb
 Hsi0MRFGkbrb6XruSa9d4EJIykWE/c/RfBHzpHw==
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Signed-off-by: Lennard Hofmann <lennard.hofmann@web.de>
=2D--
This is an optional patch to improve performance slightly while only
adding three lines of code.
 text-utils/column.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/text-utils/column.c b/text-utils/column.c
index bc7851472..d83d8d6d7 100644
=2D-- a/text-utils/column.c
+++ b/text-utils/column.c
@@ -496,14 +496,18 @@ static void add_entry(struct column_control *ctl, si=
ze_t *maxents, wchar_t *wcs)
 	ctl->ents[ctl->nents] =3D wcs;
 }

-static void add_empty_entry(struct column_control *ctl, size_t *maxents)
+static void add_empty_entry(struct column_control *ctl, size_t *maxents,
+                            wchar_t *empty)
 {
-	add_entry(ctl, maxents, mbs_to_wcs(""));
+	if (empty =3D=3D NULL)
+		empty =3D mbs_to_wcs("");
+	add_entry(ctl, maxents, empty);
 	ctl->nents++;
 }

 static int read_input(struct column_control *ctl, FILE *fp)
 {
+	wchar_t *empty =3D NULL;
 	char *buf =3D NULL;
 	size_t bufsz =3D 0;
 	size_t maxents =3D 0;
@@ -531,7 +535,7 @@ static int read_input(struct column_control *ctl, FILE=
 *fp)
 				if (ctl->mode =3D=3D COLUMN_MODE_TABLE)
 					add_emptyline_to_table(ctl);
 				else
-					add_empty_entry(ctl, &maxents);
+					add_empty_entry(ctl, &maxents, empty);
 			}
 			continue;
 		}
=2D-
2.28.0

