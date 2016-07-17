Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33668 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743AbcGQNAl (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 17 Jul 2016 09:00:41 -0400
Received: by mail-wm0-f66.google.com with SMTP id o80so8770691wme.0
        for <util-linux@vger.kernel.org>; Sun, 17 Jul 2016 06:00:40 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 10/13] misc: fix declarations shadowing variables in the global scope [oclint]
Date: Sun, 17 Jul 2016 14:00:12 +0100
Message-Id: <20160717130015.31760-11-kerolasa@iki.fi>
In-Reply-To: <20160717130015.31760-1-kerolasa@iki.fi>
References: <20160717130015.31760-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Fixes multiple occurences of 'optarg' overwrites.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/last.c     |  6 +++---
 login-utils/lslogins.c |  6 +++---
 misc-utils/logger.c    | 14 +++++++-------
 sys-utils/dmesg.c      | 14 +++++++-------
 sys-utils/ipcrm.c      |  8 ++++----
 sys-utils/lsipc.c      |  6 +++---
 sys-utils/rtcwake.c    |  6 +++---
 7 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index 0c234f5..6d0e892 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -163,15 +163,15 @@ static time_t lastdate;		/* Last date we've seen */
 static time_t currentdate;	/* date when we started processing the file */
 
 /* --time-format=option parser */
-static int which_time_format(const char *optarg)
+static int which_time_format(const char *s)
 {
 	size_t i;
 
 	for (i = 0; i < ARRAY_SIZE(timefmts); i++) {
-		if (strcmp(timefmts[i].name, optarg) == 0)
+		if (strcmp(timefmts[i].name, s) == 0)
 			return i;
 	}
-	errx(EXIT_FAILURE, _("unknown time format: %s"), optarg);
+	errx(EXIT_FAILURE, _("unknown time format: %s"), s);
 }
 
 /*
diff --git a/login-utils/lslogins.c b/login-utils/lslogins.c
index 60a1b50..76ada7f 100644
--- a/login-utils/lslogins.c
+++ b/login-utils/lslogins.c
@@ -1200,7 +1200,7 @@ static void free_user(void *f)
 	free(u);
 }
 
-static int parse_time_mode(const char *optarg)
+static int parse_time_mode(const char *s)
 {
 	struct lslogins_timefmt {
 		const char *name;
@@ -1214,10 +1214,10 @@ static int parse_time_mode(const char *optarg)
 	size_t i;
 
 	for (i = 0; i < ARRAY_SIZE(timefmts); i++) {
-		if (strcmp(timefmts[i].name, optarg) == 0)
+		if (strcmp(timefmts[i].name, s) == 0)
 			return timefmts[i].val;
 	}
-	errx(EXIT_FAILURE, _("unknown time format: %s"), optarg);
+	errx(EXIT_FAILURE, _("unknown time format: %s"), s);
 }
 
 static void __attribute__((__noreturn__)) usage(FILE *out)
diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index 8a1f7d6..5b43566 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -807,11 +807,11 @@ static void syslog_rfc5424_header(struct logger_ctl *const ctl)
 	free(structured);
 }
 
-static void parse_rfc5424_flags(struct logger_ctl *ctl, char *optarg)
+static void parse_rfc5424_flags(struct logger_ctl *ctl, char *s)
 {
 	char *in, *tok;
 
-	in = optarg;
+	in = s;
 	while ((tok = strtok(in, ","))) {
 		in = NULL;
 		if (!strcmp(tok, "notime")) {
@@ -826,15 +826,15 @@ static void parse_rfc5424_flags(struct logger_ctl *ctl, char *optarg)
 	}
 }
 
-static int parse_unix_socket_errors_flags(char *optarg)
+static int parse_unix_socket_errors_flags(char *s)
 {
-	if (!strcmp(optarg, "off"))
+	if (!strcmp(s, "off"))
 		return AF_UNIX_ERRORS_OFF;
-	if (!strcmp(optarg, "on"))
+	if (!strcmp(s, "on"))
 		return AF_UNIX_ERRORS_ON;
-	if (!strcmp(optarg, "auto"))
+	if (!strcmp(s, "auto"))
 		return AF_UNIX_ERRORS_AUTO;
-	warnx(_("invalid argument: %s: using automatic errors"), optarg);
+	warnx(_("invalid argument: %s: using automatic errors"), s);
 	return AF_UNIX_ERRORS_AUTO;
 }
 
diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index 92de6e2..a2ab3a2 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -1178,19 +1178,19 @@ static int read_kmsg(struct dmesg_control *ctl)
 	return 0;
 }
 
-static int which_time_format(const char *optarg)
+static int which_time_format(const char *s)
 {
-	if (!strcmp(optarg, "notime"))
+	if (!strcmp(s, "notime"))
 		return DMESG_TIMEFTM_NONE;
-	if (!strcmp(optarg, "ctime"))
+	if (!strcmp(s, "ctime"))
 		return DMESG_TIMEFTM_CTIME;
-	if (!strcmp(optarg, "delta"))
+	if (!strcmp(s, "delta"))
 		return DMESG_TIMEFTM_DELTA;
-	if (!strcmp(optarg, "reltime"))
+	if (!strcmp(s, "reltime"))
 		return DMESG_TIMEFTM_RELTIME;
-	if (!strcmp(optarg, "iso"))
+	if (!strcmp(s, "iso"))
 		return DMESG_TIMEFTM_ISO8601;
-	errx(EXIT_FAILURE, _("unknown time format: %s"), optarg);
+	errx(EXIT_FAILURE, _("unknown time format: %s"), s);
 }
 
 #ifdef TEST_DMESG
diff --git a/sys-utils/ipcrm.c b/sys-utils/ipcrm.c
index 7912fee..06bbd44 100644
--- a/sys-utils/ipcrm.c
+++ b/sys-utils/ipcrm.c
@@ -191,13 +191,13 @@ static unsigned long strtokey(const char *str, const char *errmesg)
 	return 0;
 }
 
-static int key_to_id(type_id type, char *optarg)
+static int key_to_id(type_id type, char *s)
 {
 	int id;
 	/* keys are in hex or decimal */
-	key_t key = strtokey(optarg, "failed to parse argument");
+	key_t key = strtokey(s, "failed to parse argument");
 	if (key == IPC_PRIVATE) {
-		warnx(_("illegal key (%s)"), optarg);
+		warnx(_("illegal key (%s)"), s);
 		return -1;
 	}
 	switch (type) {
@@ -230,7 +230,7 @@ static int key_to_id(type_id type, char *optarg)
 		default:
 			err(EXIT_FAILURE, _("key failed"));
 		}
-		warnx("%s (%s)", errmsg, optarg);
+		warnx("%s (%s)", errmsg, s);
 	}
 	return id;
 }
diff --git a/sys-utils/lsipc.c b/sys-utils/lsipc.c
index 9041dc1..d4e5037 100644
--- a/sys-utils/lsipc.c
+++ b/sys-utils/lsipc.c
@@ -249,7 +249,7 @@ static char *get_groupname(struct group **gr, gid_t id)
 	return *gr ? xstrdup((*gr)->gr_name) : NULL;
 }
 
-static int parse_time_mode(const char *optarg)
+static int parse_time_mode(const char *s)
 {
 	struct lsipc_timefmt {
 		const char *name;
@@ -263,10 +263,10 @@ static int parse_time_mode(const char *optarg)
 	size_t i;
 
 	for (i = 0; i < ARRAY_SIZE(timefmts); i++) {
-		if (strcmp(timefmts[i].name, optarg) == 0)
+		if (strcmp(timefmts[i].name, s) == 0)
 			return timefmts[i].val;
 	}
-	errx(EXIT_FAILURE, _("unknown time format: %s"), optarg);
+	errx(EXIT_FAILURE, _("unknown time format: %s"), s);
 }
 
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
diff --git a/sys-utils/rtcwake.c b/sys-utils/rtcwake.c
index 053baf5..536c5bf 100644
--- a/sys-utils/rtcwake.c
+++ b/sys-utils/rtcwake.c
@@ -344,18 +344,18 @@ static int print_alarm(struct rtcwake_control *ctl, int fd)
 	return 0;
 }
 
-static int get_rtc_mode(struct rtcwake_control *ctl, const char *optarg)
+static int get_rtc_mode(struct rtcwake_control *ctl, const char *s)
 {
 	size_t i;
 	char **modes = get_sys_power_states(ctl), **m;
 
 	STRV_FOREACH(m, modes) {
-		if (strcmp(optarg, *m) == 0)
+		if (strcmp(s, *m) == 0)
 			return SYSFS_MODE;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(rtcwake_mode_string); i++)
-		if (!strcmp(optarg, rtcwake_mode_string[i]))
+		if (!strcmp(s, rtcwake_mode_string[i]))
 			return i;
 
 	return -EINVAL;
-- 
2.9.0

