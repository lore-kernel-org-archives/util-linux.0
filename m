Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34219 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911Ab1GEVu5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 5 Jul 2011 17:50:57 -0400
Received: by ywe9 with SMTP id 9so2445436ywe.19
        for <util-linux@vger.kernel.org>; Tue, 05 Jul 2011 14:50:57 -0700 (PDT)
MIME-Version: 1.0
From: Kirill Elagin <kirelagin@gmail.com>
Date: Wed, 6 Jul 2011 01:50:37 +0400
Message-ID: <CABVT_gfBiyqfbmDNB9aPiMAWsFLFwn64WhuJi=EA0-oy3cnsTQ@mail.gmail.com>
Subject: [PATCH] Fix double free in mount.c with SELinux enabled
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

append_context reallocates memory, invalidating extra_opts1. As a
result my_free(extra_opts1) crashes.

Signed-off-by: Kirill Elagin <kirelagin@gmail.com>
Signed-off-by: Nikita Ofitserov <himikof@gmail.com>
---
 mount/mount.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/mount/mount.c b/mount/mount.c
index 00637f5..90d7518 100644
--- a/mount/mount.c
+++ b/mount/mount.c
@@ -1535,7 +1535,7 @@ try_mount_one (const char *spec0, const char
*node0, const char *types0,
   struct stat statbuf;

   /* copies for freeing on exit */
-  const char *opts1, *spec1, *node1, *types1, *extra_opts1;
+  const char *opts1, *spec1, *node1, *types1;

   if (verbose > 2) {
      printf("mount: spec:  \"%s\"\n", spec0);
@@ -1550,8 +1550,7 @@ try_mount_one (const char *spec0, const char
*node0, const char *types0,
   opts = opts1 = xstrdup(opts0);

   parse_opts (opts, &flags, &extra_opts);
-  extra_opts1 = extra_opts;
-  mount_opts = extra_opts;
+  mount_opts = xstrdup(extra_opts);

   /* quietly succeed for fstab entries that don't get mounted automatically */
   if (mount_all && (flags & MS_NOAUTO))
@@ -1592,8 +1591,11 @@ try_mount_one (const char *spec0, const char
*node0, const char *types0,
       /*
        * Linux kernel does not accept any selinux context option on remount
        */
-      if (mount_opts)
+      if (mount_opts) {
+          char *tmp = mount_opts;
           mount_opts = remove_context_options(mount_opts);
+          my_free(tmp);
+      }

   } else if (types && strcmp(types, "tmpfs") == 0 &&
is_selinux_enabled() > 0 &&
       !has_context_option(mount_opts)) {
@@ -1922,9 +1924,8 @@ try_mount_one (const char *spec0, const char
*node0, const char *types0,
   }
 #endif

-  if (extra_opts1 != mount_opts)
-     my_free(mount_opts);
-  my_free(extra_opts1);
+  my_free(mount_opts);
+  my_free(extra_opts);
   my_free(spec1);
   my_free(node1);
   my_free(opts1);
--
1.7.3.4
