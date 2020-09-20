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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4920AC43463
	for <util-linux@archiver.kernel.org>; Sun, 20 Sep 2020 13:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E45BE20EDD
	for <util-linux@archiver.kernel.org>; Sun, 20 Sep 2020 13:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="m4JVYrsi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgITNHY (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 20 Sep 2020 09:07:24 -0400
Received: from mout.web.de ([212.227.15.14]:48117 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbgITNHY (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 20 Sep 2020 09:07:24 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Sep 2020 09:07:23 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1600607243;
        bh=6DAgvS0F85AZf62nN2xF5vmT9gIAPt0XggNLJgX1B2M=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=m4JVYrsi2BMhmDreKdWS15brKi8HZl75RMr46T2OIwNUT2EY8argEuRZkJtP8T0Hb
         I/raQox3qGPJHm4IazFrYRg/ds768GrLdUeWthxq6omTmxj21CN9tH+OOgDryt1SIi
         wcRbWgNcOaReTxDY1Erj7pasolRy88mEAKfB0VVk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from archbook.fritz.box ([92.252.29.128]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MHGJ1-1kEm3b2A0R-00E7bU; Sun, 20
 Sep 2020 15:02:20 +0200
From:   Lennard Hofmann <lennard.hofmann@web.de>
To:     util-linux@vger.kernel.org
Cc:     Lennard Hofmann <lennard.hofmann@web.de>
Subject: [PATCH 1/4] column: Optionally keep empty lines in cols/rows mode
Date:   Sun, 20 Sep 2020 14:55:18 +0200
Message-Id: <20200920125520.28204-1-lennard.hofmann@web.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xQ7d7YRKkbYFFnqd1G9/jbPboWAFvASaT3MtkgE768L2KUDdcOZ
 s+umAvMaVqbuWeGRfQydnt2AYX6xjFEZ0RsUV5w4x0Kcj1SdOA6VNq5Otc/jhCF3aFERvLM
 QV1PEvY846U7/4QhY9UJo2Yp/EBqCZJFr61hA8cz/m1/rbyUzr0Vgp+As88vMhxitBsIK5r
 g7YfRLfLEud0fNrAUs/eQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IwIQmG2tYJ4=:Yzz9Vtv3GVHcm+ohyeD63l
 iQOCXwzUnt5vj0lhiKEETk5joLiRWqHMopCIp7EIkAzNReGKdxcP5plY02jXGuH3QCFHBxNTt
 LFSwO64WRNXcOdINnp27f89YkR1decxQx2eb+V4PVhEyxoO1n9jYxBUqRq/AugQc0RuBupGTV
 bAxikeXDi7TEFqEzKMydeV8cOz31YYnKV8mhmGyiUfNWBxqQjFBxp3ufMss0mT7elogelZIV7
 6nkRv0XvFrm67q/QeKXFOwbRY85rIbNVxQ20cYlzoPZGMNCYvC35BWbKlV+BqiwsvOswjHb/+
 gsH3bkE5GHhr80kIu1p3bWHUpjvtcZkoXBxs5z2j6YWWMSe6GfmIw63bFW3GPyJNfmJgu6S/P
 BwkA9JjW8j1WWkYFP9dCQYEhSLImqr/HlRZttdGrlFxX+ogdPIFz+TMfHslBTsvfba7ZzXAMY
 f1X63EW8gYF56Pp2om15IsWr1VM23VQloAWexn99u/amFKtfNdkX/iA/fIF33PSRyHgVm1VvA
 N2KpUXzP1VcZBzgLvmgNmwq1Fc2qEwR9Cn7umAifFspPv84CP5lxLpIVPIxGKs79IS28kEVr3
 nR1GusPu3l7l25ao0SF1SZhlZfscEMFmI9ZZzjGQKX40hOSV8emnyshK2x7TxknOPre3CVIPi
 /LWo0QosjAgQ8AipDy5gIyCmGPP+M0qwY6uVzpWgjsdSAIt2/8BtvjSdB8BhzDTw+guL7EQCN
 tV+8DwOm7POp9yRxKuBn4ax4PYcqHNHlFZjHuddggqeSmou7IrOcikcjkZ9hxIo7rv3G6OPP0
 eGJ6GF0CtpqKbhcPdMldKyLxSLPKG7uLq6uwGpMe8T2RB98XXh1U6y2SFhNaC+QWua8hDhuxu
 mW23LpTKk0DNBK3ahbx2AhwaP45Z9166IgM1NA9qtg2SPeghQ4KnP+v9XLPNyezopAU+fi5r6
 uxe5LU2wYJP5ixJHhFp1LDxi5JzSRdc5ztFwU5k5Zkk3BDZERwN6Hh3HDdHZsgzle5E1ibLBY
 aQv6Gu2RJ4KalSMrbL0ywdZpB/4GVSniR5rTOH7WIAoT+yHhWkHbY89KQSspKV7xVLwyktOJK
 G6Sc9BKDs4z7HhfgOcXCdxLkI2vtfDam3ps3MbsbRlXTzM4Inpax1myizHtdz4v5Bkd5wHJeP
 bPOKGKlPDcSdRX5vxmy2y6FcFef9n7UISCrdU5fk1oeb9rYJTkpEWOhP68unBFGBlIvZija9o
 t479Lxwo8LXBp5RIrtmydf16oHnswiXYGdwpRxg==
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Signed-off-by: Lennard Hofmann <lennard.hofmann@web.de>
=2D--
It surprised me that the -L option only works in table mode because I like
column(1) for columnating long terminal output on wide screens. I am not a=
ware
of a simple way to achieve this using other Unix utilities: pr(1) truncate=
s
columns and requires you to calculate the number of columns and the output
width manually.

The following patches remove the unnecessary restriction of the -L option.=
 The
patch below simply moves the existing logic to a new function `add_entry()=
` that
gets called with an empty wcs if the -L option is present.

I am very new to C and mailing lists so I appreciate any feedback.

text-utils/column.c
| 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/text-utils/column.c b/text-utils/column.c
index 238dbab41..bc7851472 100644
=2D-- a/text-utils/column.c
+++ b/text-utils/column.c
@@ -487,6 +487,21 @@ static int add_emptyline_to_table(struct column_contr=
ol *ctl)
 	return 0;
 }

+static void add_entry(struct column_control *ctl, size_t *maxents, wchar_=
t *wcs)
+{
+	if (ctl->nents <=3D *maxents) {
+		*maxents +=3D 1000;
+		ctl->ents =3D xrealloc(ctl->ents, *maxents * sizeof(wchar_t *));
+	}
+	ctl->ents[ctl->nents] =3D wcs;
+}
+
+static void add_empty_entry(struct column_control *ctl, size_t *maxents)
+{
+	add_entry(ctl, maxents, mbs_to_wcs(""));
+	ctl->nents++;
+}
+
 static int read_input(struct column_control *ctl, FILE *fp)
 {
 	char *buf =3D NULL;
@@ -512,8 +527,12 @@ static int read_input(struct column_control *ctl, FIL=
E *fp)
 				*p =3D '\0';
 		}
 		if (!str || !*str) {
-			if (ctl->mode =3D=3D COLUMN_MODE_TABLE && ctl->tab_empty_lines)
-				add_emptyline_to_table(ctl);
+			if (ctl->tab_empty_lines) {
+				if (ctl->mode =3D=3D COLUMN_MODE_TABLE)
+					add_emptyline_to_table(ctl);
+				else
+					add_empty_entry(ctl, &maxents);
+			}
 			continue;
 		}

@@ -539,12 +558,7 @@ static int read_input(struct column_control *ctl, FIL=
E *fp)

 		case COLUMN_MODE_FILLCOLS:
 		case COLUMN_MODE_FILLROWS:
-			if (ctl->nents <=3D maxents) {
-				maxents +=3D 1000;
-				ctl->ents =3D xrealloc(ctl->ents,
-						maxents * sizeof(wchar_t *));
-			}
-			ctl->ents[ctl->nents] =3D wcs;
+			add_entry(ctl, &maxents, wcs);
 			len =3D width(ctl->ents[ctl->nents]);
 			if (ctl->maxlength < len)
 				ctl->maxlength =3D len;
=2D-
2.28.0

