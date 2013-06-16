Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f179.google.com ([209.85.212.179]:37677 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755408Ab3FPSyf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Jun 2013 14:54:35 -0400
Received: by mail-wi0-f179.google.com with SMTP id hj3so1579008wib.0
        for <util-linux@vger.kernel.org>; Sun, 16 Jun 2013 11:54:33 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 09/15] dmesg: add --time-format option
Date: Sun, 16 Jun 2013 19:53:50 +0100
Message-Id: <1371408836-16663-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
References: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/dmesg.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index 5677836..2199e7f 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -257,6 +257,8 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" -u, --userspace             display userspace messages\n"), out);
 	fputs(_(" -w, --follow                wait for new messages\n"), out);
 	fputs(_(" -x, --decode                decode facility and level to readable string\n"), out);
+	fputs(_("     --time-format <format>  show time stamp using format:\n"
+		"                               [delta|reltime|ctime|notime]\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
@@ -1119,6 +1121,19 @@ static int read_kmsg(struct dmesg_control *ctl)
 	return 0;
 }
 
+static int which_time_format(const char *optarg)
+{
+	if (!strcmp(optarg, "notime"))
+		return DMESG_TIMEFTM_NONE;
+	if (!strcmp(optarg, "ctime"))
+		return DMESG_TIMEFTM_CTIME;
+	if (!strcmp(optarg, "delta"))
+		return DMESG_TIMEFTM_DELTA;
+	if (!strcmp(optarg, "reltime"))
+		return DMESG_TIMEFTM_RELTIME;
+	errx(EXIT_FAILURE, _("unknown time format: %s"), optarg);
+}
+
 #undef is_timefmt
 #define is_timefmt(c, f) (c.time_fmt == (DMESG_TIMEFTM_ ##f))
 int main(int argc, char *argv[])
@@ -1137,6 +1152,9 @@ int main(int argc, char *argv[])
 		.time_fmt = DMESG_TIMEFTM_TIME,
 	};
 	int colormode = UL_COLORMODE_NEVER;
+	enum {
+		OPT_TIME_FORMAT = CHAR_MAX + 1,
+	};
 
 	static const struct option longopts[] = {
 		{ "buffer-size",   required_argument, NULL, 's' },
@@ -1163,6 +1181,7 @@ int main(int argc, char *argv[])
 		{ "nopager",       no_argument,       NULL, 'P' },
 		{ "userspace",     no_argument,       NULL, 'u' },
 		{ "version",       no_argument,	      NULL, 'V' },
+		{ "time-format",   required_argument, NULL, OPT_TIME_FORMAT },
 		{ NULL,	           0, NULL, 0 }
 	};
 
@@ -1281,6 +1300,9 @@ int main(int argc, char *argv[])
 		case 'x':
 			ctl.decode = 1;
 			break;
+		case OPT_TIME_FORMAT:
+			ctl.time_fmt = which_time_format(optarg);
+			break;
 		case '?':
 		default:
 			usage(stderr);
-- 
1.8.3.1

