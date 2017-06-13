Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:59141 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753430AbdFMPdC (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 13 Jun 2017 11:33:02 -0400
Received: from adsiz.fritz.box ([146.52.24.88]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MeMOx-1dBorr3rVX-00QDuL for
 <util-linux@vger.kernel.org>; Tue, 13 Jun 2017 17:32:37 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/5] wall: fix OSX getgrouplist, gid_t* vs int*
Date: Tue, 13 Jun 2017 17:32:34 +0200
Message-Id: <20170613153235.11164-5-sweet_f_a@gmx.de>
In-Reply-To: <20170613153235.11164-1-sweet_f_a@gmx.de>
References: <20170613153235.11164-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This was the compiler warning:

term-utils/wall.c:156:39: warning: passing 'gid_t *const' (aka 'unsigned int *const') to
parameter of type 'int *' converts between pointers to integer types with different sign
[-Wpointer-sign]
        rc = getgrouplist(login, pw->pw_gid, buf->groups, &ngroups);
                                             ^~~~~~~~~~~
/usr/include/unistd.h:653:43: note: passing argument to parameter here
int      getgrouplist(const char *, int, int *, int *);
                                              ^

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 term-utils/wall.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/term-utils/wall.c b/term-utils/wall.c
index fa2ec2143..56d0873e4 100644
--- a/term-utils/wall.c
+++ b/term-utils/wall.c
@@ -99,10 +99,17 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
+/* getgrouplist() on OSX takes int* not gid_t* */
+#ifdef __APPLE__
+# define GID_T int
+#else
+# define GID_T gid_t
+#endif
+
 struct group_workspace {
 	gid_t	requested_group;
 	int	ngroups;
-	gid_t	*groups;
+	GID_T	*groups;
 };
 
 static gid_t get_group_gid(const char *optarg)
@@ -126,7 +133,7 @@ static struct group_workspace *init_group_workspace(const char *optarg)
 
 	buf->requested_group = get_group_gid(optarg);
 	buf->ngroups = sysconf(_SC_NGROUPS_MAX) + 1;  /* room for the primary gid */
-	buf->groups = xcalloc(sizeof(gid_t), buf->ngroups);
+	buf->groups = xcalloc(sizeof(buf->groups), buf->ngroups);
 
 	return buf;
 }
@@ -162,7 +169,7 @@ static int is_gr_member(const char *login, const struct group_workspace *buf)
 	}
 
 	for (; ngroups >= 0; --ngroups) {
-		if (buf->requested_group == buf->groups[ngroups])
+		if ((GID_T)buf->requested_group == buf->groups[ngroups])
 			return 1;
 	}
 
-- 
2.12.3

