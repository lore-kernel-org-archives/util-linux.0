Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B6726ACD
	for <util-linux@vger.kernel.org>; Fri,  2 May 2025 12:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188588; cv=none; b=b+BEIP6JNNXAwvU2V4x6A2OegeR8ePV3TN4/Yhpp+WOHemVTgatvXuZGBD0SxVZdTTfU2pzbgjDlO5TMySABoz+MQ7DDechZn23Fu9pQshUqWGtTrjCcrNCyLrn3airDw5R86D4mVj15GotOXpdq0eSdfyiqL3nga1RSeM/8aAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188588; c=relaxed/simple;
	bh=Hc4EktD6EWXTnRt7gpeLXcBuxd25Qrh4cKxyNBi62QY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSwWDmD2RqEzeVyMApQfvo2bMHd3Vpvq4R8IydELatduBZO07oYcPXj62CzMu8kxofrqRMxtuuh/vCjw3f6UTnKi29uiK5kmiD7xjv+tE9tz+DL1863AN2E4Qly2aQszDxzDRoNWvSVN+frAmxpE2kRmotT1rP0KmL65KNMTZLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=YhJyYcc6; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="YhJyYcc6"
X-KPN-MessageId: 4b6c6ece-2750-11f0-bc2b-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 4b6c6ece-2750-11f0-bc2b-005056ab378f;
	Fri, 02 May 2025 14:23:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=sofqGTMcaDcQmfVlTkwqnp89O/eoso6J0HjkNj7Yr+U=;
	b=YhJyYcc6omk4E92owF+rARmU3xlKAXK0ffJwnK94vtjhe4VjTi9NZO6FuP/vn9b2D+3ceZmEHPKEa
	 UmWzJv+lLa+tKsAIIcqFAFwv042qYqUYVprSD11sBiODXOG9QxrIX+VSrRs6EyKfY84j/edu1KTQ1i
	 z4gCl+OnYWJHrMHg=
X-KPN-MID: 33|ifeSy5UAeryJjxN/Z22bpXcaLEO5Kpz0Kr+Car7khb9ECXJCT3vlFzPNFH4kHid
 2MqR/Cr5pUN0vVFN/H1T05jX1C25Pi4KVb1NBpqJO0+0=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|y6uo4/p/J3IAAARBvn3D1fmNVKSOctekx8qKEI0JazCfbdvmG63jzssOkm752Dq
 zqPeOvfv9GkE/UH76I5X2tw==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 2df16e40-2750-11f0-9b9b-005056ab1411;
	Fri, 02 May 2025 14:22:57 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/2] strutils: move an error message to where it is used, and improve it
Date: Fri,  2 May 2025 14:22:42 +0200
Message-ID: <20250502122242.72961-2-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250502122242.72961-1-bensberg@telfort.nl>
References: <20250502122242.72961-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling gettext() is somewhat costly: it has to find the given message
among the more than five thousand messages in util-linux's repertoire.
So, call gettext() only when the message actually gets printed.

Besides, allowing to customize the error message for parse_switch() was
a nice gesture, but it's unneeded: a fixed error message is good enough.

Also, "argument error" was rather vague, as it doesn't say _what_ the
error is.  Better say "unsupported argument".

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 include/strutils.h   |  2 +-
 lib/strutils.c       |  8 ++++----
 sys-utils/eject.c    |  6 ++----
 sys-utils/irqtop.c   |  3 +--
 sys-utils/losetup.c  |  2 +-
 sys-utils/tunelp.c   |  8 ++++----
 term-utils/setterm.c | 36 ++++++++++++------------------------
 7 files changed, 25 insertions(+), 40 deletions(-)

diff --git a/include/strutils.h b/include/strutils.h
index 63cd1c1c6..f8eb5f7c4 100644
--- a/include/strutils.h
+++ b/include/strutils.h
@@ -68,7 +68,7 @@ extern int isxdigit_strend(const char *str, const char **end);
 #define isxdigit_string(_s)	isxdigit_strend(_s, NULL)
 
 
-extern int parse_switch(const char *arg, const char *errmesg, ...);
+extern int parse_switch(const char *arg, ...);
 
 #ifndef HAVE_MEMPCPY
 extern void *mempcpy(void *restrict dest, const void *restrict src, size_t n);
diff --git a/lib/strutils.c b/lib/strutils.c
index 0cf0da96b..00934d511 100644
--- a/lib/strutils.c
+++ b/lib/strutils.c
@@ -247,14 +247,14 @@ int isxdigit_strend(const char *str, const char **end)
 }
 
 /*
- *  parse_switch(argv[i], "on", "off",  "yes", "no",  NULL);
+ *  For example: parse_switch(argv[i], "on", "off",  "yes", "no",  NULL);
  */
-int parse_switch(const char *arg, const char *errmesg, ...)
+int parse_switch(const char *arg, ...)
 {
 	const char *a, *b;
 	va_list ap;
 
-	va_start(ap, errmesg);
+	va_start(ap, *arg);
 	do {
 		a = va_arg(ap, char *);
 		if (!a)
@@ -275,7 +275,7 @@ int parse_switch(const char *arg, const char *errmesg, ...)
 	} while (1);
 	va_end(ap);
 
-	errx(STRTOXX_EXIT_CODE, "%s: '%s'", errmesg, arg);
+	errx(STRTOXX_EXIT_CODE, _("unsupported argument: %s"), arg);
 }
 
 #ifndef HAVE_MEMPCPY
diff --git a/sys-utils/eject.c b/sys-utils/eject.c
index 310d6c3df..d01cde719 100644
--- a/sys-utils/eject.c
+++ b/sys-utils/eject.c
@@ -207,8 +207,7 @@ static void parse_args(struct eject_control *ctl, int argc, char **argv)
 		switch (c) {
 		case 'a':
 			ctl->a_option = 1;
-			ctl->a_arg = parse_switch(optarg, _("argument error"),
-						"on", "off",  "1", "0",  NULL);
+			ctl->a_arg = parse_switch(optarg, "on", "off",  "1", "0",  NULL);
 			break;
 		case 'c':
 			ctl->c_option = 1;
@@ -229,8 +228,7 @@ static void parse_args(struct eject_control *ctl, int argc, char **argv)
 			break;
 		case 'i':
 			ctl->i_option = 1;
-			ctl->i_arg = parse_switch(optarg, _("argument error"),
-						"on", "off",  "1", "0",  NULL);
+			ctl->i_arg = parse_switch(optarg, "on", "off",  "1", "0",  NULL);
 			break;
 		case 'm':
 			ctl->m_option = 1;
diff --git a/sys-utils/irqtop.c b/sys-utils/irqtop.c
index 51e04ee85..7275d0510 100644
--- a/sys-utils/irqtop.c
+++ b/sys-utils/irqtop.c
@@ -366,9 +366,8 @@ static void parse_args(	struct irqtop_ctl *ctl,
 				ctl->cpustat_mode = IRQTOP_CPUSTAT_AUTO;
 			else
 				ctl->cpustat_mode = IRQTOP_CPUSTAT_DISABLE - parse_switch(optarg,
-							_("unsupported argument"), "yes", "no",
 							"always", "never", "enable", "disable",
-							"on", "off", "1", "0", NULL);
+							"on", "off", "yes", "no", "1", "0", NULL);
 			break;
 		case 'C':
 			{
diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
index eafab72f3..2840586a8 100644
--- a/sys-utils/losetup.c
+++ b/sys-utils/losetup.c
@@ -818,7 +818,7 @@ int main(int argc, char **argv)
 		case OPT_DIO:
 			use_dio = set_dio = 1;
 			if (optarg)
-				use_dio = parse_switch(optarg, _("argument error"), "on", "off", NULL);
+				use_dio = parse_switch(optarg, "on", "off", NULL);
 			if (use_dio)
 				lo_flags |= LO_FLAGS_DIRECT_IO;
 			break;
diff --git a/sys-utils/tunelp.c b/sys-utils/tunelp.c
index 95a21b39e..51442d595 100644
--- a/sys-utils/tunelp.c
+++ b/sys-utils/tunelp.c
@@ -189,24 +189,24 @@ int main(int argc, char **argv)
 			break;
 		case 'a':
 			cmds->op = LPABORT;
-			cmds->val = parse_switch(optarg, _("argument error"), "on", "off", NULL);
+			cmds->val = parse_switch(optarg, "on", "off", NULL);
 			cmds->next = xmalloc(sizeof(struct command));
 			cmds = cmds->next;
 			cmds->next = NULL;
 			break;
 		case 'q':
-			show_irq = parse_switch(optarg, _("argument error"), "on", "off", NULL);
+			show_irq = parse_switch(optarg, "on", "off", NULL);
 			break;
 		case 'o':
 			cmds->op = LPABORTOPEN;
-			cmds->val = parse_switch(optarg, _("argument error"), "on", "off", NULL);
+			cmds->val = parse_switch(optarg, "on", "off", NULL);
 			cmds->next = xmalloc(sizeof(struct command));
 			cmds = cmds->next;
 			cmds->next = NULL;
 			break;
 		case 'C':
 			cmds->op = LPCAREFUL;
-			cmds->val = parse_switch(optarg, _("argument error"), "on", "off", NULL);
+			cmds->val = parse_switch(optarg, "on", "off", NULL);
 			cmds->next = xmalloc(sizeof(struct command));
 			cmds = cmds->next;
 			cmds->next = NULL;
diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index 801095c87..886ff78fc 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -559,23 +559,19 @@ static void parse_option(struct setterm_control *ctl, int ac, char **av)
 			break;
 		case OPT_CURSOR:
 			ctl->opt_cursor = set_opt_flag(ctl->opt_cursor);
-			ctl->opt_cu_on = parse_switch(optarg, _("argument error"),
-						"on", "off", NULL);
+			ctl->opt_cu_on = parse_switch(optarg,"on", "off", NULL);
 			break;
 		case OPT_REPEAT:
 			ctl->opt_repeat = set_opt_flag(ctl->opt_repeat);
-			ctl->opt_rep_on = parse_switch(optarg, _("argument error"),
-						"on", "off", NULL);
+			ctl->opt_rep_on = parse_switch(optarg, "on", "off", NULL);
 			break;
 		case OPT_APPCURSORKEYS:
 			ctl->opt_appcursorkeys = set_opt_flag(ctl->opt_appcursorkeys);
-			ctl->opt_appck_on = parse_switch(optarg, _("argument error"),
-						"on", "off", NULL);
+			ctl->opt_appck_on = parse_switch(optarg, "on", "off", NULL);
 			break;
 		case OPT_LINEWRAP:
 			ctl->opt_linewrap = set_opt_flag(ctl->opt_linewrap);
-			ctl->opt_li_on = parse_switch(optarg, _("argument error"),
-						"on", "off", NULL);
+			ctl->opt_li_on = parse_switch(optarg, "on", "off", NULL);
 			break;
 		case OPT_DEFAULT:
 			ctl->opt_default = set_opt_flag(ctl->opt_default);
@@ -598,33 +594,27 @@ static void parse_option(struct setterm_control *ctl, int ac, char **av)
 			break;
 		case OPT_INVERSESCREEN:
 			ctl->opt_inversescreen = set_opt_flag(ctl->opt_inversescreen);
-			ctl->opt_invsc_on = parse_switch(optarg, _("argument error"),
-						"on", "off", NULL);
+			ctl->opt_invsc_on = parse_switch(optarg, "on", "off", NULL);
 			break;
 		case OPT_BOLD:
 			ctl->opt_bold = set_opt_flag(ctl->opt_bold);
-			ctl->opt_bo_on = parse_switch(optarg, _("argument error"),
-						"on", "off", NULL);
+			ctl->opt_bo_on = parse_switch(optarg, "on", "off", NULL);
 			break;
 		case OPT_HALF_BRIGHT:
 			ctl->opt_halfbright = set_opt_flag(ctl->opt_halfbright);
-			ctl->opt_hb_on = parse_switch(optarg, _("argument error"),
-						"on", "off", NULL);
+			ctl->opt_hb_on = parse_switch(optarg, "on", "off", NULL);
 			break;
 		case OPT_BLINK:
 			ctl->opt_blink = set_opt_flag(ctl->opt_blink);
-			ctl->opt_bl_on = parse_switch(optarg, _("argument error"),
-						"on", "off", NULL);
+			ctl->opt_bl_on = parse_switch(optarg, "on", "off", NULL);
 			break;
 		case OPT_REVERSE:
 			ctl->opt_reverse = set_opt_flag(ctl->opt_reverse);
-			ctl->opt_re_on = parse_switch(optarg, _("argument error"),
-						"on", "off", NULL);
+			ctl->opt_re_on = parse_switch(optarg, "on", "off", NULL);
 			break;
 		case OPT_UNDERLINE:
 			ctl->opt_underline = set_opt_flag(ctl->opt_underline);
-			ctl->opt_un_on = parse_switch(optarg, _("argument error"),
-						"on", "off", NULL);
+			ctl->opt_un_on = parse_switch(optarg, "on", "off", NULL);
 			break;
 		case OPT_STORE:
 			ctl->opt_store = set_opt_flag(ctl->opt_store);
@@ -632,8 +622,7 @@ static void parse_option(struct setterm_control *ctl, int ac, char **av)
 		case OPT_CLEAR:
 			ctl->opt_clear = set_opt_flag(ctl->opt_clear);
 			if (optarg)
-				ctl->opt_cl_all = parse_switch(optarg, _("argument error"),
-						"all", "rest", NULL);
+				ctl->opt_cl_all = parse_switch(optarg, "all", "rest", NULL);
 			else
 				ctl->opt_cl_all = 1;
 			break;
@@ -667,8 +656,7 @@ static void parse_option(struct setterm_control *ctl, int ac, char **av)
 			break;
 		case OPT_MSG:
 			ctl->opt_msg = set_opt_flag(ctl->opt_msg);
-			ctl->opt_msg_on = parse_switch(optarg, _("argument error"),
-						"on", "off", NULL);
+			ctl->opt_msg_on = parse_switch(optarg, "on", "off", NULL);
 			break;
 		case OPT_MSGLEVEL:
 			ctl->opt_msglevel = set_opt_flag(ctl->opt_msglevel);
-- 
2.48.1

