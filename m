Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f181.google.com ([209.85.212.181]:42474 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755013Ab3FBRwW (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 2 Jun 2013 13:52:22 -0400
Received: by mail-wi0-f181.google.com with SMTP id hi5so2010814wib.14
        for <util-linux@vger.kernel.org>; Sun, 02 Jun 2013 10:52:21 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 14/19] dmesg: add --time-format option
Date: Sun,  2 Jun 2013 18:51:20 +0100
Message-Id: <1370195485-27907-15-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1370195485-27907-1-git-send-email-kerolasa@iki.fi>
References: <1370195485-27907-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/dmesg.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index b882120..6a8c64a 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -253,6 +253,8 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" -u, --userspace             display userspace messages\n"), out);
 	fputs(_(" -w, --follow                wait for new messages\n"), out);
 	fputs(_(" -x, --decode                decode facility and level to readable string\n"), out);
+	fputs(_("     --time-format <format>  show time stamp using format:\n"
+		"                               [notime|ctime|delta|reltime]\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
@@ -1142,6 +1144,19 @@ static int read_kmsg(struct dmesg_control *ctl)
 	return 0;
 }
 
+static int which_time_format(const char *optarg)
+{
+	if (!strcmp(optarg, "notime"))
+		return TIMEFTM_NONE;
+	if (!strcmp(optarg, "ctime"))
+		return TIMEFTM_CTIME;
+	if (!strcmp(optarg, "delta"))
+		return TIMEFTM_DELTA;
+	if (!strcmp(optarg, "reltime"))
+		return TIMEFTM_RELTIME;
+	errx(EXIT_FAILURE, _("unknown time format: %s"), optarg);
+}
+
 int main(int argc, char *argv[])
 {
 	char *buf = NULL;
@@ -1157,6 +1172,9 @@ int main(int argc, char *argv[])
 		.time_fmt = 0,
 	};
 	int colormode = UL_COLORMODE_NEVER;
+	enum {
+		OPT_TIME_FORMAT = CHAR_MAX + 1,
+	};
 
 	static const struct option longopts[] = {
 		{ "buffer-size",   required_argument, NULL, 's' },
@@ -1183,6 +1201,7 @@ int main(int argc, char *argv[])
 		{ "nopager",       no_argument,       NULL, 'P' },
 		{ "userspace",     no_argument,       NULL, 'u' },
 		{ "version",       no_argument,	      NULL, 'V' },
+		{ "time-format",   required_argument, NULL, OPT_TIME_FORMAT },
 		{ NULL,	           0, NULL, 0 }
 	};
 
@@ -1278,9 +1297,7 @@ int main(int argc, char *argv[])
 				ctl.bufsize = 4096;
 			break;
 		case 'T':
-			ctl.boot_time = get_boot_time();
-			if (ctl.boot_time)
-				ctl.time_fmt |= TIMEFTM_CTIME;
+			ctl.time_fmt |= TIMEFTM_CTIME;
 			break;
 		case 't':
 			ctl.time_fmt |= TIMEFTM_NONE;
@@ -1300,6 +1317,9 @@ int main(int argc, char *argv[])
 		case 'x':
 			ctl.decode = 1;
 			break;
+		case OPT_TIME_FORMAT:
+			ctl.time_fmt |= which_time_format(optarg);
+			break;
 		case '?':
 		default:
 			usage(stderr);
@@ -1321,10 +1341,10 @@ int main(int argc, char *argv[])
 	if ((ctl.time_fmt & TIMEFTM_RELTIME) && (ctl.time_fmt & TIMEFTM_CTIME))
 		errx(EXIT_FAILURE, _("--reltime can't be used together with --ctime "));
 
-	if (ctl.time_fmt & TIMEFTM_RELTIME) {
+	if (ctl.time_fmt & (TIMEFTM_RELTIME | TIMEFTM_CTIME)) {
 		ctl.boot_time = get_boot_time();
 		if (!ctl.boot_time)
-			ctl.time_fmt &= TIMEFTM_RELTIME;
+			ctl.time_fmt &= TIMEFTM_RELTIME | TIMEFTM_CTIME;
 	}
 
 	ctl.color = colors_init(colormode) ? 1 : 0;
-- 
1.8.3

