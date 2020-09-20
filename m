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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0263CC43463
	for <util-linux@archiver.kernel.org>; Sun, 20 Sep 2020 13:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89A7821789
	for <util-linux@archiver.kernel.org>; Sun, 20 Sep 2020 13:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="DyI+hJay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgITNPV (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 20 Sep 2020 09:15:21 -0400
Received: from mout.web.de ([212.227.17.12]:53697 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbgITNPU (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 20 Sep 2020 09:15:20 -0400
X-Greylist: delayed 385 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Sep 2020 09:15:20 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1600607719;
        bh=CEjOTPm+ry4w+B30GSNqWT1qjrVeJQlTTWp1vHfbix8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=DyI+hJayeZZgiFjLaR4YH3Yfhl840rHQIQeO+Bi1hwNGbO/UKT7ckUhB6Z0nFuxau
         lGVmVqhbCig6KJplOoiPhX+W8bVxdgkX1I3uZaG87zOWD38TqzduycnRe8SSvRifNk
         3K9IZ12eYgvw8IKfWIEnfajtvfJ0cZP4oO/zfG30=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from archbook.fritz.box ([92.252.29.128]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lp760-1kwb6r1xJM-00eyAb; Sun, 20
 Sep 2020 15:10:17 +0200
From:   Lennard Hofmann <lennard.hofmann@web.de>
To:     util-linux@vger.kernel.org
Cc:     Lennard Hofmann <lennard.hofmann@web.de>
Subject: [PATCH 3/4] column: Deprecate --table-empty-lines in favor of --keep-empty-lines
Date:   Sun, 20 Sep 2020 15:08:18 +0200
Message-Id: <20200920130818.29756-2-lennard.hofmann@web.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200920130818.29756-1-lennard.hofmann@web.de>
References: <20200920130818.29756-1-lennard.hofmann@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BabPIBECU4nkjSAkUJhP0wS7XMpfRP5N/W3+NzUbEil1yuTKGIl
 wVt1NwQqws62iG/EiiQ2IV3aj/rapnOX41XoNGpku7a5w6e+NsEmf5kD1sxelLE8M7wt/r9
 FSF36PDUz8igRopU4dCs8pG1T/VjMUYZhPeWaAyL2V8iJxVNnOJSBP/eTUTQLd3XPF6KXQq
 B0ALHI4MHeIW0vWbNt/oQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e0wWP/UT0ro=:vuf1aociKO1scK5lXbYm/w
 hrXDEjveio50kH37WSV5JylJtwrt3SpCfheONXZD2wwzf++5lWHJ2Cm0lTsb8Y+Y9wK8rnlZ/
 R2UVYBRRWP5C8a1LypaOa5YZhWjQOWGBDlQWIOFVLgEXcomr+7uXuusgG96gugySQh/hl0RRF
 EQatx0Zo8qzfbPWbBfuuPwTMwqWtjtqYX7Eb7KqOv8LRiEZSdNMTmBzHOvWVYJLtrqspSLUBb
 TWCaUG+sFn3RZGRnZCy1v+cAjRqdxLgSLQGlAW/TdbaJ2CH/3vWyAJIoYF2Y50Zpn/efNaVR5
 9OnJj5H664snLnP6fV18ASHp/LeD00cHLeIga325JjcGBi9GdFbliyQOx/1sCkHDlK/9BmhGp
 u1wJLuIqAnl1/piUkaN391CCBqeiWD8uI1IyF7QskQKlbioR1xtCQsV5B3/mMMOPSYP0bZPq4
 bFLXC6mw5kx59kzmaqsE0uBRGWpYGq3Cdc0qokujiTP20VX3XDBoVaV2sYR99t+Qbiw1sPYNQ
 4+92JI3919m6u2X8OUI2gjBAOv5hunp+LEzrA80QIxvYc/o1kVXjeYyUkWiE92xyqcEytcegE
 vvnKCKBYRZpBu8IPb5U4693Re436rFJCWD4wnTkzNqhnekB13CDhN8mOrzm7LD/tcvDDWEoij
 S4nwYOTNVREu9dkBo14Qnpn57Eqyu2IqQonzKUWkKYioT0ApNzgTRtJh1nUYITbRxb+dQV1a6
 bei3V7cYyIeID1L1TDDuMIFuYo/S3eFtqF3Xb3tT+xKdqDrQE7CyL8KlStmyLRiZUPxIK56NQ
 OQsuZzR1o3/XURjLfX4vi4yYWWYOVHDs4EdkNZmM/Oy+PnnIUoHTVMbK6Oux4F8s8Fooc3EUq
 hXs+1BIvZP3QNePnCutAYoeHvz18a+a2NgeoEcKQQBiPIoKUg7M62+K0HNjiOgX8EUwQiQYCa
 kTLkp65DcEOe4hXE7qkcoV3RfZiwGwmCtbZhyMZbMeCebmcBUVhw/V9j1IeEvEdDoMgydnWLC
 rwpExIrWdIWuX2fgE9MbiOnbuYjQnKPnsJJQ7OVOXmqHv7zJidShx8m0GFZ+6UKdjh8yIL/ah
 CDZwVck8HgrDwvyGTVEFV/uPU+l/U57lNlrB+PeNdmokdGQAXVpNSxLxfhOsJGwUjrG6gv9Oa
 z8KyRSIhU0ls3tQlwqJ4DPZLXXEfIWREmszgyA0leixZHOfIzmmaq90Qplde4NDn8gL8/4Mrp
 3Fqiyh169TTtSnNcLCiaBpSRXfLUDodXDSavpsw==
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

`--table-empty-lines` gives the false impression that the option
only applies to table mode.

Signed-off-by: Lennard Hofmann <lennard.hofmann@web.de>
=2D--
 text-utils/column.1 | 8 +++++---
 text-utils/column.c | 9 +++++----
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/text-utils/column.1 b/text-utils/column.1
index 86886f3bf..d10fc7efb 100644
=2D-- a/text-utils/column.1
+++ b/text-utils/column.1
@@ -110,9 +110,11 @@ hide all unnamed columns (see \-\-table-columns).
 Specify columns order on output.
 .IP "\fB\-n, \-\-table-name\fP \fIname\fP"
 Specify the table name used for JSON output. The default is "table".
-.IP "\fB\-L, \-\-table\-empty\-lines\fP"
-Insert empty line to the table for each empty line on input. The default
-is ignore empty lines at all.
+.IP "\fB\-L, \-\-keep\-empty\-lines\fP"
+Preserve whitespace-only lines in the input. The default is ignore empty =
lines
+at all. This option=E2=80=99s original name was \-\-table-empty-lines but=
 is now
+deprecated because it gives the false impression that the option only app=
lies
+to table mode.
 .IP "\fB\-r, \-\-tree\fP \fIcolumn\fP"
 Specify column to use tree-like output. Note that the circular dependenci=
es and
 other anomalies in child and parent relation are silently ignored.
diff --git a/text-utils/column.c b/text-utils/column.c
index d83d8d6d7..bc0c1fd11 100644
=2D-- a/text-utils/column.c
+++ b/text-utils/column.c
@@ -96,7 +96,7 @@ struct column_control {
 	unsigned int greedy :1,
 		     json :1,
 		     header_repeat :1,
-		     tab_empty_lines :1,	/* --table-empty-lines */
+		     keep_empty_lines :1,	/* --keep-empty-lines */
 		     tab_noheadings :1;
 };

@@ -531,7 +531,7 @@ static int read_input(struct column_control *ctl, FILE=
 *fp)
 				*p =3D '\0';
 		}
 		if (!str || !*str) {
-			if (ctl->tab_empty_lines) {
+			if (ctl->keep_empty_lines) {
 				if (ctl->mode =3D=3D COLUMN_MODE_TABLE)
 					add_emptyline_to_table(ctl);
 				else
@@ -709,6 +709,7 @@ int main(int argc, char **argv)
 		{ "fillrows",            no_argument,       NULL, 'x' },
 		{ "help",                no_argument,       NULL, 'h' },
 		{ "json",                no_argument,       NULL, 'J' },
+		{ "keep-empty-lines",    no_argument,       NULL, 'L' },
 		{ "output-separator",    required_argument, NULL, 'o' },
 		{ "output-width",        required_argument, NULL, 'c' },
 		{ "separator",           required_argument, NULL, 's' },
@@ -723,7 +724,7 @@ int main(int argc, char **argv)
 		{ "table-right",         required_argument, NULL, 'R' },
 		{ "table-truncate",      required_argument, NULL, 'T' },
 		{ "table-wrap",          required_argument, NULL, 'W' },
-		{ "table-empty-lines",   no_argument,       NULL, 'L' },
+		{ "table-empty-lines",   no_argument,       NULL, 'L' }, /* deprecated =
*/
 		{ "table-header-repeat", no_argument,       NULL, 'e' },
 		{ "tree",                required_argument, NULL, 'r' },
 		{ "tree-id",             required_argument, NULL, 'i' },
@@ -774,7 +775,7 @@ int main(int argc, char **argv)
 			ctl.mode =3D COLUMN_MODE_TABLE;
 			break;
 		case 'L':
-			ctl.tab_empty_lines =3D 1;
+			ctl.keep_empty_lines =3D 1;
 			break;
 		case 'l':
 			ctl.maxncols =3D strtou32_or_err(optarg, _("invalid columns limit argu=
ment"));
=2D-
2.28.0

