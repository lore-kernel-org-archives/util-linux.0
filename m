Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:52588 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1426388AbcBRNMx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 18 Feb 2016 08:12:53 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx001)
 with ESMTPSA (Nemesis) id 0M3iU5-1Zf76w3tnV-00rILy for
 <util-linux@vger.kernel.org>; Thu, 18 Feb 2016 14:12:52 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 06/15] lib: rename strmode() and setmode()
Date: Thu, 18 Feb 2016 14:12:46 +0100
Message-Id: <1455801169-10470-7-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1455801169-10470-1-git-send-email-sweet_f_a@gmx.de>
References: <1455801169-10470-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

On BSD they are part of the standard C library.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 include/strutils.h          |  2 +-
 lib/strutils.c              |  2 +-
 libsmartcols/samples/tree.c |  2 +-
 misc-utils/lsblk.c          |  2 +-
 misc-utils/namei.c          |  2 +-
 sys-utils/lsipc.c           |  6 +++---
 text-utils/ul.c             | 10 +++++-----
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/strutils.h b/include/strutils.h
index ec2a8ac..4bb3b2d 100644
--- a/include/strutils.h
+++ b/include/strutils.h
@@ -78,7 +78,7 @@ static inline char *strdup_to_offset(void *stru, size_t offset, const char *str)
 #define strdup_to_struct_member(_s, _m, _str) \
 		strdup_to_offset((void *) _s, offsetof(__typeof__(*(_s)), _m), _str)
 
-extern void strmode(mode_t mode, char *str);
+extern void xstrmode(mode_t mode, char *str);
 
 /* Options for size_to_human_string() */
 enum
diff --git a/lib/strutils.c b/lib/strutils.c
index ac59de8..ef81ebd 100644
--- a/lib/strutils.c
+++ b/lib/strutils.c
@@ -425,7 +425,7 @@ void strtotimeval_or_err(const char *str, struct timeval *tv, const char *errmes
  * Converts stat->st_mode to ls(1)-like mode string. The size of "str" must
  * be 11 bytes.
  */
-void strmode(mode_t mode, char *str)
+void xstrmode(mode_t mode, char *str)
 {
 	unsigned short i = 0;
 
diff --git a/libsmartcols/samples/tree.c b/libsmartcols/samples/tree.c
index 7f41f9e..52be7fb 100644
--- a/libsmartcols/samples/tree.c
+++ b/libsmartcols/samples/tree.c
@@ -59,7 +59,7 @@ static int add_line_from_stat(struct libscols_table *tb,
 		err(EXIT_FAILURE, "failed to create output line");
 
 	/* MODE; local buffer, use scols_line_set_data() that calls strdup() */
-	strmode(mode, modbuf);
+	xstrmode(mode, modbuf);
 	if (scols_line_set_data(ln, COL_MODE, modbuf))
 		goto fail;
 
diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 1162d07..5c065a9 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -911,7 +911,7 @@ static void set_scols_data(struct blkdev_cxt *cxt, int col, int id, struct libsc
 		char md[11];
 
 		if (!st_rc) {
-			strmode(cxt->st.st_mode, md);
+			xstrmode(cxt->st.st_mode, md);
 			str = xstrdup(md);
 		}
 		break;
diff --git a/misc-utils/namei.c b/misc-utils/namei.c
index 41557ca..576e3ef 100644
--- a/misc-utils/namei.c
+++ b/misc-utils/namei.c
@@ -288,7 +288,7 @@ print_namei(struct namei *nm, char *path)
 			return -1;
 		}
 
-		strmode(nm->st.st_mode, md);
+		xstrmode(nm->st.st_mode, md);
 
 		if (nm->mountpoint)
 			md[0] = 'D';
diff --git a/sys-utils/lsipc.c b/sys-utils/lsipc.c
index 523859c..9e34e6b 100644
--- a/sys-utils/lsipc.c
+++ b/sys-utils/lsipc.c
@@ -579,7 +579,7 @@ static void do_sem(int id, struct lsipc_control *ctl, struct libscols_table *tb)
 					xasprintf(&arg, "%#o", semdsp->sem_perm.mode & 0777);
 				else {
 					arg = xmalloc(11);
-					strmode(semdsp->sem_perm.mode & 0777, arg);
+					xstrmode(semdsp->sem_perm.mode & 0777, arg);
 				}
 				rc = scols_line_refer_data(ln, n, arg);
 				break;
@@ -776,7 +776,7 @@ static void do_msg(int id, struct lsipc_control *ctl, struct libscols_table *tb)
 					xasprintf(&arg, "%#o", msgdsp->msg_perm.mode & 0777);
 				else {
 					arg = xmalloc(11);
-					strmode(msgdsp->msg_perm.mode & 0777, arg);
+					xstrmode(msgdsp->msg_perm.mode & 0777, arg);
 					rc = scols_line_refer_data(ln, n, arg);
 				}
 				break;
@@ -928,7 +928,7 @@ static void do_shm(int id, struct lsipc_control *ctl, struct libscols_table *tb)
 					xasprintf(&arg, "%#o", shmdsp->shm_perm.mode & 0777);
 				else {
 					arg = xmalloc(11);
-					strmode(shmdsp->shm_perm.mode & 0777, arg);
+					xstrmode(shmdsp->shm_perm.mode & 0777, arg);
 				}
 				rc = scols_line_refer_data(ln, n, arg);
 				break;
diff --git a/text-utils/ul.c b/text-utils/ul.c
index 7765b57..115b882 100644
--- a/text-utils/ul.c
+++ b/text-utils/ul.c
@@ -81,7 +81,7 @@ static void fwd(void);
 static void reverse(void);
 static void initinfo(void);
 static void outc(wint_t c, int width);
-static void setmode(int newmode);
+static void xsetmode(int newmode);
 static void setcol(int newcol);
 static void needcol(int col);
 static void sig_handler(int signo);
@@ -368,7 +368,7 @@ static void flushln(void)
 	for (i = 0; i < maxcol; i++) {
 		if (obuf[i].c_mode != lastmode) {
 			hadmodes++;
-			setmode(obuf[i].c_mode);
+			xsetmode(obuf[i].c_mode);
 			lastmode = obuf[i].c_mode;
 		}
 		if (obuf[i].c_char == '\0') {
@@ -382,7 +382,7 @@ static void flushln(void)
 			i += obuf[i].c_width - 1;
 	}
 	if (lastmode != NORMAL) {
-		setmode(0);
+		xsetmode(0);
 	}
 	if (must_overstrike && hadmodes)
 		overstrike();
@@ -560,11 +560,11 @@ static void outc(wint_t c, int width) {
 	}
 }
 
-static void setmode(int newmode)
+static void xsetmode(int newmode)
 {
 	if (!iflag) {
 		if (curmode != NORMAL && newmode != NORMAL)
-			setmode(NORMAL);
+			xsetmode(NORMAL);
 		switch (newmode) {
 		case NORMAL:
 			switch (curmode) {
-- 
1.8.4.5

