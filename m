Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39132 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750904Ab1C2I2t (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 29 Mar 2011 04:28:49 -0400
Date: Tue, 29 Mar 2011 10:28:50 +0200
From: Karel Zak <kzak@redhat.com>
To: Miklos Szeredi <mszeredi@suse.cz>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] umount: allow non-root umount of FUSE even if not in
	fstab
Message-ID: <20110329082850.GR21093@nb.net.home>
References: <20110328140454.GA4790@foxbat.suse.cz> <1301322200.22846.68.camel@tucsk.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1301322200.22846.68.camel@tucsk.pomaz.szeredi.hu>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 28, 2011 at 04:23:20PM +0200, Miklos Szeredi wrote:
> On Mon, 2011-03-28 at 16:04 +0200, Petr Uzel wrote:
> > Hi all,
> > 
> > I hacked the following patch with which it is possible to use 
> > "umount $dir" instead of "fusermount -u $dir", which IMHO is an
> > improvement in usability. It seems to work (at least for me), however,
> > I have to admit that I don't like it very much, because:
> > - it complicates umount
> > - duplicates code from fusermount
> 
> And this is not the only one that would have to be duplicated.  The
> mount and umount races that were fixed in fusermount in recently and not
> so recently would also have to be added to util-linux, which would
> actually be a good thing, since in theory they could affect fstab based
> user mounts as well (though that is much more unlikely than with fuse,
> where the user chooses the mountpoint).

 Maybe we need to call umount2() with UMOUNT_NOFOLLOW flag for
 non-root users in umount(8). I think it should be enough for
 umount(8) (where almost all is controlled by system admin in fstab). 
 
 See below. Comments?

    Karel


>From 5cf67485d23dc4547eb5e54cbe96cc60837e36af Mon Sep 17 00:00:00 2001
From: Karel Zak <kzak@redhat.com>
Date: Tue, 29 Mar 2011 10:19:56 +0200
Subject: [PATCH] umount: use UMOUNT_NOFOLLOW for non-root users

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 mount/umount.c |   44 ++++++++++++++++++++++++++++++++++++--------
 1 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/mount/umount.c b/mount/umount.c
index 42671f4..0660b20 100644
--- a/mount/umount.c
+++ b/mount/umount.c
@@ -45,15 +45,22 @@ umount2(const char *path, int flags) {
 }
 #endif /* __NR_umount2 */
 
-#if !defined(MNT_FORCE)
-/* dare not try to include <linux/mount.h> -- lots of errors */
-#define MNT_FORCE 1
+#ifndef MNT_FORCE
+# define MNT_FORCE        0x00000001	/* Attempt to forcibily umount */
 #endif
 
 #endif /* MNT_FORCE */
 
-#if !defined(MNT_DETACH)
-#define MNT_DETACH 2
+#ifndef MNT_DETACH
+# define MNT_DETACH       0x00000002	/* Just detach from the tree */
+#endif
+
+#ifndef UMOUNT_NOFOLLOW
+# define UMOUNT_NOFOLLOW  0x00000008	/* Don't follow symlink on umount */
+#endif
+
+#ifndef UMOUNT_UNUSED
+#define UMOUNT_UNUSED     0x80000000	/* Flag guaranteed to be unused */
 #endif
 
 
@@ -197,6 +204,21 @@ static void complain(int err, const char *dev) {
   }
 }
 
+/* Check whether the kernel supports UMOUNT_NOFOLLOW flag */
+static int umount_nofollow_support(void)
+{
+	int res = umount2("", UMOUNT_UNUSED);
+	if (res != -1 || errno != EINVAL)
+		return 0;
+
+	res = umount2("", UMOUNT_NOFOLLOW);
+	if (res != -1 || errno != ENOENT)
+		return 0;
+
+	return 1;
+}
+
+
 /* Umount a single device.  Return a status code, so don't exit
    on a non-fatal error.  We lock/unlock around each umount.  */
 static int
@@ -206,6 +228,7 @@ umount_one (const char *spec, const char *node, const char *type,
 	int isroot;
 	int res = 0;
 	int status;
+	int extra_flags = 0;
 	const char *loopdev;
 	int myloop = 0;
 
@@ -237,15 +260,18 @@ umount_one (const char *spec, const char *node, const char *type,
 	if (delloop && is_loop_device(spec))
 		myloop = 1;
 
+	if (restricted && umount_nofollow_support())
+		extra_flags |= UMOUNT_NOFOLLOW;
+
 	if (lazy) {
-		res = umount2 (node, MNT_DETACH);
+		res = umount2 (node, MNT_DETACH | extra_flags);
 		if (res < 0)
 			umnt_err = errno;
 		goto writemtab;
 	}
 
 	if (force) {		/* only supported for NFS */
-		res = umount2 (node, MNT_FORCE);
+		res = umount2 (node, MNT_FORCE | extra_flags);
 		if (res == -1) {
 			int errsv = errno;
 			perror("umount2");
@@ -256,7 +282,9 @@ umount_one (const char *spec, const char *node, const char *type,
 				res = umount (node);
 			}
 		}
-	} else
+	} else if (extra_flags)
+		res = umount2 (node, extra_flags);
+	else
 		res = umount (node);
 
 	if (res < 0)
-- 
1.7.3.4

