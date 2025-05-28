Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA2520E011
	for <util-linux@vger.kernel.org>; Wed, 28 May 2025 09:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748425046; cv=none; b=RuRU/rY93QnNPKxgCwmsQhmI9e5gUFdc54LPucJhGR10VKHVTO9eP5CBasD3JY3HnWXJxzHzNJIgDAicas8EBlj3qn7ikk98VwXNDX46UbRkZ4VU/Hp14fSuns7MGpxeNVepIf4GbOqGVidigCklDp+uK2ukrzk4uRLU5/IuIEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748425046; c=relaxed/simple;
	bh=XK3KO3H0cst09rcFINB3xCJD5U1J65LukRCDi5LmmtM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jpcd9qcCfgEFlKO5qhgqvUlbr+Kv8vILpg89SZS8bm+4eVNqaIxFItO2evgx1GMwHUZxOzy1WJn4Z2fDl2Z8D+JJNnr3WmkvRcYlx1qEiXv+uWaWCMuyqwJ5EoE3HdgjzksWy90kYqVi8E8Hoa/7AokihECjVJJ139v/3pvsRMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=tCz4qf97; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="tCz4qf97"
X-KPN-MessageId: 7514dfeb-3ba7-11f0-86ce-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 7514dfeb-3ba7-11f0-86ce-005056aba152;
	Wed, 28 May 2025 11:38:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=cF50Fw2rV81BXhp79DHH/grTDImaSGqo5LW9AywvHv0=;
	b=tCz4qf97ZqqAOG/JsgpjO45SgDEitnRgXhGLcDrYk2bF2X7eCTh1mO7BGB/EzGKsIkuc2lcooq8BB
	 WwxEDWg/EqAVpvvU2v19FenLUb52xPrUUmx/YY0FGiZqbdvrTyICc86Ko6yj2oACFBp7KSMREGFXl2
	 MczrjxoXE6pvjRlw=
X-KPN-MID: 33|IGAR8iqlr9b0Mz1LcjujVj9ci8Y2hXvGKOddL84VB7ZG4QBlwR3LzhRFE5+qpyx
 d3KOE2tg2kEhm0LXLcBqGLK4M9M/17l4geXKw3Lu/TLY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|GhdyE8P1tIVgYufLkU3+sNCv/XOPsXmlwTK+LtiwD1Mj/1ROCNOYPU8GPQtE9Ki
 Uy3sF+fabdVroaiMSh0xbsg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 54949a60-3ba7-11f0-9bdc-005056ab1411;
	Wed, 28 May 2025 11:37:11 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/4] lib/colors: call gettext() only when the argument of --color is invalid
Date: Wed, 28 May 2025 11:37:01 +0200
Message-ID: <20250528093704.8896-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of calling gettext() before starting to interpret the argument
of option -L/--color, call it only when it's needed: when the argument
is not recognized.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 disk-utils/cfdisk.c  | 3 +--
 disk-utils/fdisk.c   | 3 +--
 disk-utils/sfdisk.c  | 3 +--
 include/colors.h     | 2 +-
 lib/colors.c         | 7 ++++---
 misc-utils/cal.c     | 3 +--
 sys-utils/dmesg.c    | 3 +--
 text-utils/hexdump.c | 3 +--
 8 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
index fdd74fbf9..e4e16001e 100644
--- a/disk-utils/cfdisk.c
+++ b/disk-utils/cfdisk.c
@@ -2781,8 +2781,7 @@ int main(int argc, char *argv[])
 		case 'L':
 			colormode = UL_COLORMODE_AUTO;
 			if (optarg)
-				colormode = colormode_or_err(optarg,
-						_("unsupported color mode"));
+				colormode = colormode_or_err(optarg);
 			break;
                 case 'r':
                         read_only = 1;
diff --git a/disk-utils/fdisk.c b/disk-utils/fdisk.c
index 6493e2767..727178da4 100644
--- a/disk-utils/fdisk.c
+++ b/disk-utils/fdisk.c
@@ -1239,8 +1239,7 @@ int main(int argc, char **argv)
 		case 'L':
 			colormode = UL_COLORMODE_AUTO;
 			if (optarg)
-				colormode = colormode_or_err(optarg,
-						_("unsupported color mode"));
+				colormode = colormode_or_err(optarg);
 			break;
 		case 'n':
 			noauto_pt = 1;
diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index 41b5558ea..7f2f3deea 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -2437,8 +2437,7 @@ int main(int argc, char *argv[])
 		case OPT_COLOR:
 			colormode = UL_COLORMODE_AUTO;
 			if (optarg)
-				colormode = colormode_or_err(optarg,
-						_("unsupported color mode"));
+				colormode = colormode_or_err(optarg);
 			break;
 		case OPT_MOVEDATA:
 			sf->movedata = 1;
diff --git a/include/colors.h b/include/colors.h
index 770161ae0..c02f61a57 100644
--- a/include/colors.h
+++ b/include/colors.h
@@ -33,7 +33,7 @@ enum colortmode {
 #endif
 
 extern int colormode_from_string(const char *str);
-extern int colormode_or_err(const char *str, const char *errmsg);
+extern int colormode_or_err(const char *str);
 
 /* Initialize the global variable UL_COLOR_TERM_OK */
 extern int colors_init(int mode, const char *util_name);
diff --git a/lib/colors.c b/lib/colors.c
index 4852a87cc..47d69cabc 100644
--- a/lib/colors.c
+++ b/lib/colors.c
@@ -34,6 +34,7 @@
 #include "c.h"
 #include "cctype.h"
 #include "colors.h"
+#include "nls.h"
 #include "pathnames.h"
 #include "strutils.h"
 
@@ -755,14 +756,14 @@ int colormode_from_string(const char *str)
 /*
  * Parses @str and exit(EXIT_FAILURE) on error
  */
-int colormode_or_err(const char *str, const char *errmsg)
+int colormode_or_err(const char *str)
 {
 	const char *p = str && *str == '=' ? str + 1 : str;
 	int colormode;
 
 	colormode = colormode_from_string(p);
 	if (colormode < 0)
-		errx(EXIT_FAILURE, "%s: '%s'", errmsg, p);
+		errx(EXIT_FAILURE, _("unsupported color mode: %s"), p);
 
 	return colormode;
 }
@@ -791,7 +792,7 @@ int main(int argc, char *argv[])
 			color_scheme = optarg;
 			break;
 		case 'm':
-			mode = colormode_or_err(optarg, "unsupported color mode");
+			mode = colormode_or_err(optarg);
 			break;
 		case 'n':
 			name = optarg;
diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 8c0eb3638..09622165a 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -421,8 +421,7 @@ int main(int argc, char **argv)
 		case OPT_COLOR:
 			ctl.colormode = UL_COLORMODE_AUTO;
 			if (optarg)
-				ctl.colormode = colormode_or_err(optarg,
-						_("unsupported color mode"));
+				ctl.colormode = colormode_or_err(optarg);
 			break;
 		case OPT_REFORM:
 			ctl.reform_year = parse_reform_year(optarg);
diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index 8dcf67c94..6584613c7 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -1756,8 +1756,7 @@ int main(int argc, char *argv[])
 		case 'L':
 			colormode = UL_COLORMODE_AUTO;
 			if (optarg)
-				colormode = colormode_or_err(optarg,
-						_("unsupported color mode"));
+				colormode = colormode_or_err(optarg);
 			break;
 		case 'l':
 			ctl.fltr_lev= 1;
diff --git a/text-utils/hexdump.c b/text-utils/hexdump.c
index 36744554e..60bf6f94b 100644
--- a/text-utils/hexdump.c
+++ b/text-utils/hexdump.c
@@ -115,8 +115,7 @@ parse_args(int argc, char **argv, struct hexdump *hex)
 		case 'L':
 			colormode = UL_COLORMODE_AUTO;
 			if (optarg)
-				colormode = colormode_or_err(optarg,
-						_("unsupported color mode"));
+				colormode = colormode_or_err(optarg);
                         break;
 		case 'n':
 			hex->length = strtosize_or_err(optarg, _("failed to parse length"));
-- 
2.48.1

