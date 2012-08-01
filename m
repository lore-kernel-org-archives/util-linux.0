Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:65434 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752171Ab2HAJOD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 1 Aug 2012 05:14:03 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q719E30O020355
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Wed, 1 Aug 2012 05:14:03 -0400
From: Niels de Vos <ndevos@redhat.com>
To: util-linux@vger.kernel.org
Cc: Niels de Vos <ndevos@redhat.com>
Subject: [RFC] mount: overwrite options from /etc/fstab when given on the commandline
Date: Wed,  1 Aug 2012 11:11:41 +0200
Message-Id: <1343812301-24896-1-git-send-email-ndevos@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi all,

it seems that some of the options given in /etc/fstab are not overloaded by
options given on the mount-commandline. Some options are not allowed to be
passed multiple times (like the SElinux context options) and mounting will fail
if options are present in both /etc/fstab and on the commandline.

Is there a reason for not overloading the options from /etc/fstab by the
options given on the commandline?

The patch below changes the behaviour of mount so that options on the
commandline replace options given in /etc/fstab. This example is based on the
now deprecated code of mount in util-linux-2.17.2. I'd like to receive some
responses if this change would be acceptible, or if this was done by design.

If this can be accepted, I'll happily look into the libmount code and provide
a patch for the current util-linux version.

Many thanks,
Niels

---
 mount/mount.c |   44 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 43 insertions(+), 1 deletions(-)

diff --git a/mount/mount.c b/mount/mount.c
index 45f9699..e594f5e 100644
--- a/mount/mount.c
+++ b/mount/mount.c
@@ -294,6 +294,48 @@ print_all (char *types) {
      exit (0);
 }
 
+/* reallocates its first arg
+ * opt is the single option, val is the opt=val pair */
+static char *
+merge_one_opt(char *s, const char *opt, const char *val)
+{
+	char *old_opt, *next_opt;
+
+	if (!opt)
+		return s;
+	if (!s)
+		return xstrdup(val);		/* opt & opt=val */
+	if (!val)
+		return s;				/* s,opt */
+
+	old_opt = strstr(s, opt);
+	if (old_opt) {
+		next_opt = strchr(old_opt, ',');
+		if (!next_opt)
+			memset(old_opt, '\0', 1);
+		else
+			memmove(old_opt, next_opt + 1, strlen(next_opt) + 1);
+	}
+	return xstrconcat3(s, ",", val);		/* s,opt=val */
+}
+
+/* reallocates its first arg */
+static char *
+merge_opts(char *s, const char *extra_opts)
+{
+	char *new_opts = xstrdup(extra_opts);
+	char *opt, *opt_pos, *o;
+
+	opt = strtok_r(new_opts, ",", &opt_pos);
+	while (opt != NULL) {
+		o = xstrndup(opt, strchrnul(opt, '=') - opt);
+		s = merge_one_opt(s, o, opt);
+		opt = strtok_r(NULL, ",", &opt_pos);
+	}
+
+	return s;
+}
+
 /* reallocates its first arg */
 static char *
 append_opt(char *s, const char *opt, const char *val)
@@ -1701,7 +1743,7 @@ mount_one (const char *spec, const char *node, const char *types,
 	opts = usersubst(fstabopts);
 
 	/* Merge the fstab and command line options.  */
-	opts = append_opt(opts, cmdlineopts, NULL);
+	opts = merge_opts(opts, cmdlineopts);
 
 	if (types == NULL && !mounttype && !is_existing_file(spec)) {
 		if (strchr (spec, ':') != NULL) {
-- 
1.7.7.6

