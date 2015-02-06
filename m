Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57327 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757134AbbBFOzY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 6 Feb 2015 09:55:24 -0500
Message-ID: <1423234521.24479.9.camel@redhat.com>
Subject: libmount: MNT_OMODE_FORCE usage
From: Fridolin Pokorny <fpokorny@redhat.com>
To: util-linux@vger.kernel.org
Date: Fri, 06 Feb 2015 15:55:21 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

I have found out that libmount does not respect MNT_OMODE_FORCE mode.
I don't see any usage in sources and libmount does not respect this mode
when calling library functions. I'm proposing a patch to fix this.

Have a nice day!
Fridolin Pokorny


diff --git a/libmount/src/context.c b/libmount/src/context.c
index c902f39..1c288e5 100644
--- a/libmount/src/context.c
+++ b/libmount/src/context.c
@@ -2077,6 +2077,7 @@ int mnt_context_apply_fstab(struct libmnt_context *cxt)
 	}
 
 	if (!src && tgt
+	    && !(cxt->optsmode & MNT_OMODE_FORCE)
 	    && !(cxt->optsmode & MNT_OMODE_FSTAB)
 	    && !(cxt->optsmode & MNT_OMODE_MTAB)) {
 		DBG(CXT, ul_debugobj(cxt, "only target; fstab/mtab not required "
@@ -2088,7 +2089,7 @@ int mnt_context_apply_fstab(struct libmnt_context *cxt)
 	ignore_result( mnt_context_get_fs(cxt) );
 
 	/* try fstab */
-	if (cxt->optsmode & MNT_OMODE_FSTAB) {
+	if (cxt->optsmode & (MNT_OMODE_FSTAB | MNT_OMODE_FORCE)) {
 		DBG(CXT, ul_debugobj(cxt, "trying to apply fstab (src=%s, target=%s)", src, tgt));
 		rc = mnt_context_get_fstab(cxt, &tab);
 		if (!rc)
@@ -2096,7 +2097,7 @@ int mnt_context_apply_fstab(struct libmnt_context *cxt)
 	}
 
 	/* try mtab */
-	if (rc < 0 && (cxt->optsmode & MNT_OMODE_MTAB)) {
+	if (rc < 0 && (cxt->optsmode & (MNT_OMODE_MTAB | MNT_OMODE_FORCE))) {
 		DBG(CXT, ul_debugobj(cxt, "trying to apply mtab (src=%s, target=%s)", src, tgt));
 		if (tgt)
 			rc = mnt_context_get_mtab_for_target(cxt, &tab, tgt);


