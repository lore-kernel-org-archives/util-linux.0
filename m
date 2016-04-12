Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:48705 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933065AbcDLSWi (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 12 Apr 2016 14:22:38 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 39DB6AC13
	for <util-linux@vger.kernel.org>; Tue, 12 Apr 2016 18:22:36 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 1/3] libmount: Re-organize is_mounted_same_loopfile()
Message-ID: <570D3CEC.4030606@suse.cz>
Date: Tue, 12 Apr 2016 20:22:36 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

First parse options, then initialize context.
No change in function.
The change is needed for loop device reuse.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 libmount/src/context_loopdev.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/libmount/src/context_loopdev.c b/libmount/src/context_loopdev.c
index a1ff971..47d6294 100644
--- a/libmount/src/context_loopdev.c
+++ b/libmount/src/context_loopdev.c
@@ -137,7 +137,7 @@ is_mounted_same_loopfile(struct libmnt_context *cxt,
 int mnt_context_setup_loopdev(struct libmnt_context *cxt)
 {
 	const char *backing_file, *optstr, *loopdev = NULL;
-	char *val = NULL;
+	char *val = NULL, *loopval = NULL;
 	size_t len;
 	struct loopdev_cxt lc;
 	int rc = 0, lo_flags = 0;
@@ -158,10 +158,6 @@ int mnt_context_setup_loopdev(struct libmnt_context *cxt)
 		lo_flags |= LO_FLAGS_READ_ONLY;
 	}
 
-	rc = loopcxt_init(&lc, 0);
-	if (rc)
-		return rc;
-
 	optstr = mnt_fs_get_user_options(cxt->fs);
 
 	/*
@@ -169,13 +165,8 @@ int mnt_context_setup_loopdev(struct libmnt_context *cxt)
 	 */
 	if (rc == 0 && (cxt->user_mountflags & MNT_MS_LOOP) &&
 	    mnt_optstr_get_option(optstr, "loop", &val, &len) == 0 && val) {
-
-		val = strndup(val, len);
-		rc = val ? loopcxt_set_device(&lc, val) : -ENOMEM;
-		free(val);
-
-		if (rc == 0)
-			loopdev = loopcxt_get_device(&lc);
+		loopval = strndup(val, len);
+		rc = loopval ? 0 : -ENOMEM;
 	}
 
 	/*
@@ -217,6 +208,15 @@ int mnt_context_setup_loopdev(struct libmnt_context *cxt)
 		rc = -EBUSY;
 
 	if (rc)
+		goto done_no_deinit;
+
+	rc = loopcxt_init(&lc, 0);
+	if (rc == 0 && loopval) {
+		rc = loopcxt_set_device(&lc, loopval);
+		if (rc == 0)
+			loopdev = loopcxt_get_device(&lc);
+	}
+	if (rc)
 		goto done;
 
 	/* since 2.6.37 we don't have to store backing filename to mtab
@@ -301,6 +301,8 @@ int mnt_context_setup_loopdev(struct libmnt_context *cxt)
 	}
 done:
 	loopcxt_deinit(&lc);
+done_no_deinit:
+	free(loopval);
 	return rc;
 }
 
-- 
2.8.1

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
