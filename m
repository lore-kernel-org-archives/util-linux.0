Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:38296 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936221AbdAJMyU (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 10 Jan 2017 07:54:20 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F0688AC97
        for <util-linux@vger.kernel.org>; Tue, 10 Jan 2017 12:54:18 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] If mtab support is disabled, disable ro/rw mtab checks
Message-ID: <4d702326-5d60-8430-73a9-2e25dac6e49e@suse.cz>
Date: Tue, 10 Jan 2017 13:54:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Commit f9906424 introduced a check that should prevent different information in
mtab and /proc/mounts. The check can require significant amount of time, and for
systems without mtab support it has no sense.

Execute this code only on systems with mtab.

When a systems with large number of nodes (thousands) mount the filesystems
simultaneously, the time required for serialization causes the utimensat() to
take a large amount of time (tens of minutes) when a large number of nodes are
simultaneously updating the timestamp.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 libmount/src/context_mount.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libmount/src/context_mount.c b/libmount/src/context_mount.c
index a7ea83250..23f0e303a 100644
--- a/libmount/src/context_mount.c
+++ b/libmount/src/context_mount.c
@@ -987,6 +987,7 @@ int mnt_context_do_mount(struct libmnt_context *cxt)
 	} else
 		res = do_mount_by_pattern(cxt, cxt->fstype_pattern);
 
+#if USE_LIBMOUNT_SUPPORT_MTAB
 	if (mnt_context_get_status(cxt)
 	    && !mnt_context_is_fake(cxt)
 	    && !cxt->helper) {
@@ -1016,6 +1017,7 @@ int mnt_context_do_mount(struct libmnt_context *cxt)
 			mnt_context_set_mflags(cxt,
 					cxt->mountflags | MS_RDONLY);
 	}
+#endif
 
 	return res;
 }
-- 
2.11.0

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Køi¾íkova 148/34 (Corso IIa)                  tel: +49 911 7405384547
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
