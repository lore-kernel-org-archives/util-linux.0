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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDEAC43466
	for <util-linux@archiver.kernel.org>; Mon, 21 Sep 2020 16:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 937B82388B
	for <util-linux@archiver.kernel.org>; Mon, 21 Sep 2020 16:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="g3Y7g7/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgIUQ0Q (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 21 Sep 2020 12:26:16 -0400
Received: from mout.web.de ([212.227.15.14]:34243 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbgIUQ0N (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 21 Sep 2020 12:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1600705571;
        bh=aVTpfxexnLME7WIfO3qutbEAPy3whZbdQRoB5ogSjl0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=g3Y7g7/vHdFeK8AeNMGD8feVhrFJh3Xl61RLFgPkHVinkELbfi1amPkuHQba7ujCV
         a1NUeMp7FTdRIU1RTLnNij4DWUMwypOa0ktFmPDNleCJwbJ8Qz8BTsZ/9yv7NG9Jpp
         Jx5HrmQLGmkUN1kkoxyjSVRQmgml/h0pvO64Ges4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from archbook.fritz.box ([92.252.88.59]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LgYi5-1kqRja0r3d-00nvkG; Mon, 21
 Sep 2020 18:26:11 +0200
From:   Lennard Hofmann <lennard.hofmann@web.de>
To:     util-linux@vger.kernel.org
Cc:     Lennard Hofmann <lennard.hofmann@web.de>
Subject: [PATCH v2 2/2] column: Deprecate --table-empty-lines in favor of --keep-empty-lines
Date:   Mon, 21 Sep 2020 18:26:00 +0200
Message-Id: <20200921162600.19984-1-lennard.hofmann@web.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921161621.19562-1-lennard.hofmann@web.de>
References: <20200921161621.19562-1-lennard.hofmann@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1XSsaciAQEjGu9+uJDzft12vj8ul+Hkf8er8dEGnwbQZk4ZYKqa
 OrcP4KjhHO+XfQtsvJCpk3vSyfYQzHoEKVOX5QVhMqpTVwDsZMZ4+oK1fABOku047nF/9WR
 nC2LcIKKFa/+AVz8Smsyai8bZth7JGlKSg3as6HbIaFEPzanbFoe9aZ6KnuyPN+1O3nX+ja
 6Jr+M56WruzvGj8pG/axw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ErPfvL7mxqo=:ZwblmhmJzjOgEo7LtUaQ/Q
 BwhCh608eQyLnhHaVsaw7l6hQpwrxgIK6Wmb/KKYhzj1NtpBQ34dNyNnUEkdEAz0WadBfsY+c
 gKxUuP8Cm6ri9F3L/u7sw8x3Lqpr0WQ3I8wNDSVzp6WkRCz+xRlzhuq62Tn9Azu5+29Gwvi0O
 JQvy8hiWxaSuJp0DLOCwxpLT7JIWJiEjiTomRdpLtRmlLMEJwW2NML+vn+zFI4i+ZtGeq5rp8
 gOuU7+AbmrwChQ6SW1pr7WCkjoxn/pPF/83FFcGRFrY7AErtp2AmBLZNe1Mbvo0Z+xfPX0T4C
 H1WE4Go+FoHLBiTy5ENAOS3S+hWt3tN+wiQ0iAONxm45V5/LlVx664qLv/e/9mE//egmnlBiS
 uUiU5WN5YXaXDqyIZi8kAc8/6mNixG/ZVHbEgpFgiM4456P+aUUbj3L+fSnsqDyUINhv96+KB
 pT4x/bZ72sPtgoOpmuUPJ+g5cZ4sbxipkF07OIEP6lzTDH8j714B/FShsCc4wvOX6qug2odH/
 +bU0x/RgPQ+blOEm+OeeAqVsgoHD1+xtGXUS3n1p48rT5I7W8BgnPMiz404d2OaNGx3KzC5v9
 s3wTvy5ywgOnoCyYVv16z3HFJOURrkG8m1HeGZRBiR2dPzETa28dyuhzsTO1QmCmm/PdAy2by
 wuR+8C4ysC9AO4+Riq1q/YHvmjU6OwqIap/Y0G8591Nd7hiwPu6zXMks3ej0cB9xc0RD3IUOl
 OtwH6qsoySumfGM5nJcAgwhF2AqwKLQXXOkUqJsW0wEsl8w2RVOkTCumaxLwT3IwjIwcohjaj
 q3x10gPgOjcMkRcIr4/GL2ZlTI2yJwl+/ig+5VK42K0iQ7YWvI6HCVrguJ9EQNpxiJvr1eUFX
 MIK6HR9ftskFmb1DXDrWtw4299/Tx58H1gDat/Nwshk28+Z+XDxPAfCg1tN5rL+FikvJWztU3
 jpctqE3cs+3oi2k1BM9PTY/qGyt5SUChVbxCvDe8U03luePG5LqDCiR3f4bE/PUB9rtmm5gYa
 D/FuzfxvtHtCYHHxoHasCq0Tm9sQ7NnqC/xm/UxDwGDEa6KL2lMBvKqE6woPeqH1KGTrdeaDp
 MXq7z4yMfzjiy4boo4R/3QQcJtvXyNyR1nIE65TBqJvCQbW3+PMfQE97W4qQnKK77paeB3h6E
 DeDtp2tTcvVhzYbT8+29asasJo0AsHf/lSYjgMMd7ea+hx1D0qSfajU1M1n1JmB1PV9FBpoD/
 BIighqn74p8rQnjRQvsMS3hhsYNWXQewYcgJPuQ==
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

`--table-empty-lines` gives the false impression that the option
only applies to table mode.

Signed-off-by: Lennard Hofmann <lennard.hofmann@web.de>
=2D--
In comparison to the last patch, I also edited deprecated.txt and the
bash-completion. The PO files need to be updated, too, but I do not
know how.

 Documentation/deprecated.txt |  7 +++++++
 bash-completion/column       |  2 +-
 text-utils/column.1          |  8 +++++---
 text-utils/column.c          | 11 ++++++-----
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/Documentation/deprecated.txt b/Documentation/deprecated.txt
index 08ba8b974..4d4b309d6 100644
=2D-- a/Documentation/deprecated.txt
+++ b/Documentation/deprecated.txt
@@ -2,6 +2,13 @@ The following is a list of commands or features that are =
deprecated.  All
 deprecated utils are in maintenance mode and we keep them in source tree =
for
 backward compatibility only.

+
+what:  column --table-empty-lines
+why:   renamed to --keep-empty-lines
+since: v2.37
+
+--------------------------
+
 what:  hwclock --debug
 why:   renamed to --verbose, and may be repurposed later.
 since: v2.32
diff --git a/bash-completion/column b/bash-completion/column
index 1f47aecc8..5ce56e76f 100644
=2D-- a/bash-completion/column
+++ b/bash-completion/column
@@ -40,7 +40,7 @@ _column_module()
 				--table-right
 				--table-truncate
 				--table-wrap
-				--table-empty-lines
+				--keep-empty-lines
 				--json
 				--tree
 				--tree-id
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
index f01499dca..d251a710e 100644
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

@@ -523,7 +523,7 @@ static int read_input(struct column_control *ctl, FILE=
 *fp)
 				*p =3D '\0';
 		}
 		if (!str || !*str) {
-			if (ctl->tab_empty_lines) {
+			if (ctl->keep_empty_lines) {
 				if (ctl->mode =3D=3D COLUMN_MODE_TABLE) {
 					add_emptyline_to_table(ctl);
 				} else {
@@ -664,7 +664,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -R, --table-right <columns>      right align text in these col=
umns\n"), out);
 	fputs(_(" -T, --table-truncate <columns>   truncate text in the columns =
when necessary\n"), out);
 	fputs(_(" -W, --table-wrap <columns>       wrap text in the columns when=
 necessary\n"), out);
-	fputs(_(" -L, --table-empty-lines          don't ignore empty lines\n"),=
 out);
+	fputs(_(" -L, --keep-empty-lines           don't ignore empty lines\n"),=
 out);
 	fputs(_(" -J, --json                       use JSON output format for ta=
ble\n"), out);

 	fputs(USAGE_SEPARATOR, out);
@@ -703,6 +703,7 @@ int main(int argc, char **argv)
 		{ "fillrows",            no_argument,       NULL, 'x' },
 		{ "help",                no_argument,       NULL, 'h' },
 		{ "json",                no_argument,       NULL, 'J' },
+		{ "keep-empty-lines",    no_argument,       NULL, 'L' },
 		{ "output-separator",    required_argument, NULL, 'o' },
 		{ "output-width",        required_argument, NULL, 'c' },
 		{ "separator",           required_argument, NULL, 's' },
@@ -717,7 +718,7 @@ int main(int argc, char **argv)
 		{ "table-right",         required_argument, NULL, 'R' },
 		{ "table-truncate",      required_argument, NULL, 'T' },
 		{ "table-wrap",          required_argument, NULL, 'W' },
-		{ "table-empty-lines",   no_argument,       NULL, 'L' },
+		{ "table-empty-lines",   no_argument,       NULL, 'L' }, /* deprecated =
*/
 		{ "table-header-repeat", no_argument,       NULL, 'e' },
 		{ "tree",                required_argument, NULL, 'r' },
 		{ "tree-id",             required_argument, NULL, 'i' },
@@ -768,7 +769,7 @@ int main(int argc, char **argv)
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

