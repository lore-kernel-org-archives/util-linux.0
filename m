Return-Path: util-linux-owner@vger.kernel.org
Received: from out01.mta.xmission.com ([166.70.13.231]:49675 "EHLO
	out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbaLQXI1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 17 Dec 2014 18:08:27 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: <util-linux@vger.kernel.org>
Cc: Karel Zak <kzak@redhat.com>, Lubomir Rintel <lkundrak@v3.sk>
Date: Wed, 17 Dec 2014 17:06:03 -0600
Message-ID: <87zjalkhb8.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [RFC][PATCH] unshare: Fix --map-root-user to work on new kernels
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


I have just merged a security fix into the linux kernel that corrects an
oversight in the permission checks of /proc/self/gid_map.

The root of the issue is that unix allows anyone to specify permissions
such like: --rwx---rwx on a file, and setgroups call at login time
allows seting groups that even setgid exectuables don't drop.  Which
results in the ability to assign a process fewer privileges just because
it is in a specified group, and this makes dropping groups an unsafe
operation.

Therefore unprivileged writing of /proc/self/gid_map has been disabled
unless /proc/self/setgroups is written first to permanently disable the
ability to call setgroups in that user namespace.

In part this design was chosen so that applications that are affected
will break early instead of late, and in part to make it clear to
everyone what is going on.

I think for the experimental tool that is unshare --make-root-user we
just want to flip the bit and be done with it (patch below).

However we may want to require an additional option to clear setgroups,
if there loging type applications running that call setgroups and having
explicit breakage up front instead of more silent stealthy breakage
when the application runs is desired.

If we don't want any extra options working tested code is below.

Eric

From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Thu, 11 Dec 2014 20:05:25 -0600
Subject: [PATCH] unshare: Fix --map-root-user to work on new kernels

In rare cases droping groups with setgroups(0, NULL) is an operation
that can grant a user additional privileges.  User namespaces were
allwoing that operation to unprivileged users and that had to be
fixed.

Update unshare --map-root-user to disable the setgroups operation
before setting the gid_map.

This is needed as after the security fix gid_map is restricted to
privileged users unless setgroups has been disabled.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/pathnames.h |  1 +
 sys-utils/unshare.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/pathnames.h b/include/pathnames.h
index 1cc4e15e6e4f..1c53e4554268 100644
--- a/include/pathnames.h
+++ b/include/pathnames.h
@@ -92,6 +92,7 @@
 
 #define _PATH_PROC_UIDMAP	"/proc/self/uid_map"
 #define _PATH_PROC_GIDMAP	"/proc/self/gid_map"
+#define _PATH_PROC_SETGROUPS	"/proc/self/setgroups"
 
 #define _PATH_PROC_ATTR_CURRENT	"/proc/self/attr/current"
 #define _PATH_PROC_ATTR_EXEC	"/proc/self/attr/exec"
diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 95e4afbd055e..d409a7c936b6 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -39,6 +39,24 @@
 #include "pathnames.h"
 #include "all-io.h"
 
+static void disable_setgroups(void)
+{
+	const char *file = _PATH_PROC_SETGROUPS;
+	const char *deny = "deny";
+	int fd;
+
+	fd = open(file, O_WRONLY);
+	if (fd < 0) {
+		if (errno == ENOENT)
+			return;
+		 err(EXIT_FAILURE, _("cannot open %s"), file);
+	}
+
+	if (write_all(fd, deny, strlen(deny)))
+		err(EXIT_FAILURE, _("write failed %s"), file);
+	close(fd);
+}
+
 static void map_id(const char *file, uint32_t from, uint32_t to)
 {
 	char *buf;
@@ -178,6 +196,7 @@ int main(int argc, char *argv[])
 	}
 
 	if (maproot) {
+		disable_setgroups();
 		map_id(_PATH_PROC_UIDMAP, 0, real_euid);
 		map_id(_PATH_PROC_GIDMAP, 0, real_egid);
 	}
-- 
2.1.3

