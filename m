Return-Path: util-linux-owner@vger.kernel.org
Received: from out01.mta.xmission.com ([166.70.13.231]:42610 "EHLO
	out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754101Ab3AQAgo (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 16 Jan 2013 19:36:44 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Karel Zak <kzak@redhat.com>
Cc: Mike Frysinger <vapier@gentoo.org>, util-linux@vger.kernel.org,
        Neil Horman <nhorman@tuxdriver.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>
References: <876234812z.fsf@xmission.com> <20130111161320.GA16206@x2.net.home>
	<87fw27jq29.fsf_-_@xmission.com>
	<201301111845.16591.vapier@gentoo.org>
	<20130114082846.GA16421@x2.net.home> <87a9s8lkbq.fsf_-_@xmission.com>
Date: Wed, 16 Jan 2013 16:36:32 -0800
In-Reply-To: <87a9s8lkbq.fsf_-_@xmission.com> (Eric W. Biederman's message of
	"Wed, 16 Jan 2013 16:33:29 -0800")
Message-ID: <87hamgk5m7.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [PATCH 5/5] unshare,nsenter:  Move the old libc handling into a common header namespace.h
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Move the defitions of CLONE_NEWNS, CLONE_NEWUTS, CLONE_NEWIPC,
CLONE_NEWNET, CLONE_NEWUSER, CLONE_NEWPID into namespace.h in case
sched.h does not provide those definitions.  Are there systems
around that are old enough that still need this?

Move the definitions of unshare() and setns() into namespace.h
for supporting old versions of libc that does not provice these.
I have tested this support with setns as I still have systems
old enough that glibc does not wrap setns.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/namespace.h |   43 +++++++++++++++++++++++++++++++++++++++++++
 sys-utils/nsenter.c |   28 +---------------------------
 sys-utils/unshare.c |   29 +----------------------------
 3 files changed, 45 insertions(+), 55 deletions(-)
 create mode 100644 include/namespace.h

diff --git a/include/namespace.h b/include/namespace.h
new file mode 100644
index 0000000..8ccc3f6
--- /dev/null
+++ b/include/namespace.h
@@ -0,0 +1,43 @@
+/* Compat code so unshare and setns can be used with older libcs */
+#ifndef UTIL_LINUX_NAMESPACE_H
+#define UTIL_LINUX_NAMESPACE_H
+
+#include <sched.h>
+
+#ifndef CLONE_NEWSNS
+# define CLONE_NEWNS 0x00020000
+#endif
+#ifndef CLONE_NEWUTS
+# define CLONE_NEWUTS 0x04000000
+#endif
+#ifndef CLONE_NEWIPC
+# define CLONE_NEWIPC 0x08000000
+#endif
+#ifndef CLONE_NEWNET
+# define CLONE_NEWNET 0x40000000
+#endif
+#ifndef CLONE_NEWUSER
+# define CLONE_NEWUSER 0x10000000
+#endif
+#ifndef CLONE_NEWPID
+# define CLONE_NEWPID 0x20000000
+#endif
+
+#ifndef HAVE_UNSHARE
+# include <sys/syscall.h>
+
+static inline int unshare(int flags)
+{
+	return syscall(SYS_unshare, flags);
+}
+#endif
+
+#ifndef HAVE_SETNS
+# include <sys/syscall.h>
+static inline int setns(int fd, int nstype)
+{
+	return syscall(SYS_setns, fd, nstype);
+}
+#endif /* HAVE_SETNS */
+
+#endif /* UTIL_LINUX_NAMESPACE_H */
diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
index cc54ebe..a2d464e 100644
--- a/sys-utils/nsenter.c
+++ b/sys-utils/nsenter.c
@@ -31,33 +31,7 @@
 #include "nls.h"
 #include "c.h"
 #include "closestream.h"
-
-#ifndef CLONE_NEWSNS
-# define CLONE_NEWNS 0x00020000
-#endif
-#ifndef CLONE_NEWUTS
-# define CLONE_NEWUTS 0x04000000
-#endif
-#ifndef CLONE_NEWIPC
-# define CLONE_NEWIPC 0x08000000
-#endif
-#ifndef CLONE_NEWNET
-# define CLONE_NEWNET 0x40000000
-#endif
-#ifndef CLONE_NEWUSER
-# define CLONE_NEWUSER 0x10000000
-#endif
-#ifndef CLONE_NEWPID
-# define CLONE_NEWPID 0x20000000
-#endif
-
-#ifndef HAVE_SETNS
-# include <sys/syscall.h>
-static int setns(int fd, int nstype)
-{
-	return syscall(SYS_setns, fd, nstype);
-}
-#endif /* HAVE_SETNS */
+#include "namespace.h"
 
 static struct namespace_file{
 	int nstype;
diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 00cc2cf..9b849ee 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -28,34 +28,7 @@
 #include "nls.h"
 #include "c.h"
 #include "closestream.h"
-
-#ifndef CLONE_NEWSNS
-# define CLONE_NEWNS 0x00020000
-#endif
-#ifndef CLONE_NEWUTS
-# define CLONE_NEWUTS 0x04000000
-#endif
-#ifndef CLONE_NEWIPC
-# define CLONE_NEWIPC 0x08000000
-#endif
-#ifndef CLONE_NEWNET
-# define CLONE_NEWNET 0x40000000
-#endif
-#ifndef CLONE_NEWUSER
-# define CLONE_NEWUSER 0x10000000
-#endif
-#ifndef CLONE_NEWPID
-# define CLONE_NEWPID 0x20000000
-#endif
-
-#ifndef HAVE_UNSHARE
-# include <sys/syscall.h>
-
-static int unshare(int flags)
-{
-	return syscall(SYS_unshare, flags);
-}
-#endif
+#include "namespace.h"
 
 static void usage(int status)
 {
-- 
1.7.5.4

