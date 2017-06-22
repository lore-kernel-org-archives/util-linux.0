Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:61046 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751866AbdFVCht (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 21 Jun 2017 22:37:49 -0400
Received: from tenfore.ga-group.nl ([92.195.15.151]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MaV3V-1d3r4k0lVB-00KCyD for
 <util-linux@vger.kernel.org>; Thu, 22 Jun 2017 04:37:47 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 02/13] misc: remove superfluous null pointer checks for optarg
Date: Thu, 22 Jun 2017 04:37:35 +0200
Message-Id: <1498099066-24235-3-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1498099066-24235-1-git-send-email-sweet_f_a@gmx.de>
References: <1498099066-24235-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This is only needed for optional arguments.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 login-utils/chsh.c     |  2 --
 login-utils/lslogins.c | 15 ++++++---------
 text-utils/hexdump.c   |  2 +-
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/login-utils/chsh.c b/login-utils/chsh.c
index 3bea971..10b0bdc 100644
--- a/login-utils/chsh.c
+++ b/login-utils/chsh.c
@@ -235,8 +235,6 @@ static void parse_argv(int argc, char **argv, struct sinfo *pinfo)
 			print_shells();
 			exit(EXIT_SUCCESS);
 		case 's':
-			if (!optarg)
-				usage(stderr);
 			pinfo->shell = optarg;
 			break;
 		default:
diff --git a/login-utils/lslogins.c b/login-utils/lslogins.c
index ab04c10..1e89d27 100644
--- a/login-utils/lslogins.c
+++ b/login-utils/lslogins.c
@@ -1381,15 +1381,12 @@ int main(int argc, char *argv[])
 			outmode = OUT_NEWLINE;
 			break;
 		case 'o':
-			if (optarg) {
-				if (*optarg == '=')
-					optarg++;
-				ncolumns = string_to_idarray(optarg,
-						columns, ARRAY_SIZE(columns),
-						column_name_to_id);
-				if (ncolumns < 0)
-					return EXIT_FAILURE;
-			}
+			if (*optarg == '=')
+				optarg++;
+			ncolumns = string_to_idarray(optarg, columns,
+					ARRAY_SIZE(columns), column_name_to_id);
+			if (ncolumns < 0)
+				return EXIT_FAILURE;
 			opt_o = 1;
 			break;
 		case 'r':
diff --git a/text-utils/hexdump.c b/text-utils/hexdump.c
index 125734d..bf06316 100644
--- a/text-utils/hexdump.c
+++ b/text-utils/hexdump.c
@@ -107,7 +107,7 @@ parse_args(int argc, char **argv, struct hexdump *hex)
 		case 'f':
 			addfile(optarg, hex);
 			break;
-                case 'L':
+		case 'L':
 			colormode = UL_COLORMODE_AUTO;
 			if (optarg)
 				colormode = colormode_or_err(optarg,
-- 
1.8.5.6

