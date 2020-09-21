Return-Path: <SRS0=FFMN=C6=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BFCC43466
	for <util-linux@archiver.kernel.org>; Mon, 21 Sep 2020 16:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8396920708
	for <util-linux@archiver.kernel.org>; Mon, 21 Sep 2020 16:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="grQc0YzH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgIUQSI (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 21 Sep 2020 12:18:08 -0400
Received: from mout.web.de ([212.227.15.4]:57043 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgIUQSI (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 21 Sep 2020 12:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1600705087;
        bh=YDGhL48WInSpU9/cC5uIHuRN5wXIReRb+LS1EeFKCbY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=grQc0YzHhTg44yLK+dpT1K9AT2btRVUOIZytKV4oEpMxiwIZ3MeSiVUHis67XoYJg
         2X5OtmEhwP6SWNcciD12k/nlYog16U8GqjWy/gGP6WG4Jg4e7ep8UgVut6tY1jE1Wz
         TUa+LtmwgMu0PhS3E/o8UZTsYhbUHWmXKr+CYhZY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from archbook.fritz.box ([92.252.88.59]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MBjMO-1kAXfn0iQm-00CHKd; Mon, 21
 Sep 2020 18:18:07 +0200
From:   Lennard Hofmann <lennard.hofmann@web.de>
To:     util-linux@vger.kernel.org
Cc:     Lennard Hofmann <lennard.hofmann@web.de>
Subject: [PATCH v2 1/2] column: Optionally keep empty lines in cols/rows mode
Date:   Mon, 21 Sep 2020 18:16:20 +0200
Message-Id: <20200921161621.19562-1-lennard.hofmann@web.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PzxOP6WtaVoRXocG+gAji5IOsdAg9aDjXzHn+vgeJhkCe0fb9Ep
 FSwrmhC/CSmyfDBOWpC6fy1VXkf2Tlnz1z7lrRmMsM9/2KxSQUzx9Pa3S5JUTbg39bqhVrt
 CAoEZRjBy6+SHDfeejLwl1FSgooysLPzG4p8NR/NLCxxlBtwPiFiJmR5TgYKw/zHTp5gGRh
 LWd5SFvSPleyx7yviem/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:weZgKumRahU=:l9u4Ju9qzfCjVd5uynLs9q
 fPTD5XUFGMtkKUO0x/N0rthx4x8y886Auzn5totu+EhQlFipFTQgLtYNEemRhCqDY1+8anHWY
 nYIfVif4D2qLJE5g6HqyoDw7ylMWsE5mgf7iR5o9vKpgodRJwldPJubMZ957/Kr3JsHi6Hxxr
 B8Km/H6ZngMbx1PTXg3q7wJeP/WUIB6+lm8rInYSVlTOEwXnCCIoalsE/cHJS4Z4Yy7XzsH7a
 8SekGeIbHoWrzW4RA6cW2EC48O8sUfds4aQZ1NO7+XbO2xZSDI1b69h0m2zaRPwK+8d5dFkwb
 9Ik8XoBol6vEr+diCWF8sqUNkXdTS8Ne1uQoD/J9dxs5oDDb4m+8ZVEQWnBAhzH4cVXggPz4N
 0ix31I2OBnUjiFtLQ8EDgFzPV508dajo81RaAjKG9HEwkqyR7cdnyLrgqWKsHC4BmanYnRCe7
 griQRAXyOg/Exq6djQk6v2NEfn8Lrj0L8L+KhNYUmpJbq1oKqDJsmQgWv4ne5vSiGuiYQSrjJ
 qlG0qxgWpzw2kJa8sAwSrwTdA9/v5QQyVXb63FP5dGBB6P0zKm4Kzb/4xeF0axgwuqdLDvuQv
 9LlnUb6WZsGfYjOEb3jxWwqopuUcTzEcizDI5d1xZLkLjMc7GnPxi98MpeWvkadf5qCMZpeCK
 aH9oCjSk1mEi6YAhcrGk3/A0Yyy6m0mlZYXpVxFTwqUCjR/hGF4gsjpOUU8bjtVnxEh2B0fHl
 eu4ErXdr657MDN3E9xzne3VwzK5RqJUwhTS6lA5kBE7++nu+SdwZs55n7oq+8QUe6EMPWWt0V
 Cz82lS8UGR6swoec/LFu21SypQpLVR+WiZ3OLrjLXqhmhLD4jzGs4wyoDFeoflNyz8dIpxLNC
 5JAWwO5lJGnY8wlD9DW6ZVMuKOS9Gkh7cgTLYKtNNWKt6mZfu7upHerFlMX+Wk+4GfBwc/kYH
 zQxOGFqJ4EZdovyDhbVpVEEf6GuPCL5T+Heo96Mb2ZscDu1u26Jg1lRPexlMVEUHgQ+8GulHc
 wPHBLqjRaIkc6jzh1zf2pwpdadWkggOWQsHtBPPdYh6tipXK+ucX2tyaDCDflTsSyBExGm8Lg
 uXGk1ajcjwI0KbT3smuvBA+YskC/jQL9OjN2M37viSss/5b54QYeuEji5AX5spu2ZXDHEuvYO
 yMZWkwciRfZbaTuKXASSbuJl5oKnR+WfH8o3ZrsLD6+/y8J36tMpr2z1F02SIsxkEPV4sb3Ak
 PM7VOxRgk+6M7l4qPTpCGJy6SikiHXDsaup0lHg==
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Signed-off-by: Lennard Hofmann <lennard.hofmann@web.de>
=2D--
 text-utils/column.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/text-utils/column.c b/text-utils/column.c
index 238dbab41..f01499dca 100644
=2D-- a/text-utils/column.c
+++ b/text-utils/column.c
@@ -487,8 +487,19 @@ static int add_emptyline_to_table(struct column_contr=
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
+	ctl->nents++;
+}
+
 static int read_input(struct column_control *ctl, FILE *fp)
 {
+	wchar_t *empty =3D NULL;
 	char *buf =3D NULL;
 	size_t bufsz =3D 0;
 	size_t maxents =3D 0;
@@ -512,8 +523,15 @@ static int read_input(struct column_control *ctl, FIL=
E *fp)
 				*p =3D '\0';
 		}
 		if (!str || !*str) {
-			if (ctl->mode =3D=3D COLUMN_MODE_TABLE && ctl->tab_empty_lines)
-				add_emptyline_to_table(ctl);
+			if (ctl->tab_empty_lines) {
+				if (ctl->mode =3D=3D COLUMN_MODE_TABLE) {
+					add_emptyline_to_table(ctl);
+				} else {
+					if (!empty)
+						empty =3D mbs_to_wcs("");
+					add_entry(ctl, &maxents, empty);
+				}
+			}
 			continue;
 		}

@@ -539,16 +557,10 @@ static int read_input(struct column_control *ctl, FI=
LE *fp)

 		case COLUMN_MODE_FILLCOLS:
 		case COLUMN_MODE_FILLROWS:
-			if (ctl->nents <=3D maxents) {
-				maxents +=3D 1000;
-				ctl->ents =3D xrealloc(ctl->ents,
-						maxents * sizeof(wchar_t *));
-			}
-			ctl->ents[ctl->nents] =3D wcs;
-			len =3D width(ctl->ents[ctl->nents]);
+			add_entry(ctl, &maxents, wcs);
+			len =3D width(wcs);
 			if (ctl->maxlength < len)
 				ctl->maxlength =3D len;
-			ctl->nents++;
 			break;
 		default:
 			free(wcs);
=2D-
2.28.0

