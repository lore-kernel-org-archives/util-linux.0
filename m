Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD5FC4332F
	for <util-linux@archiver.kernel.org>; Mon, 17 Jan 2022 11:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239238AbiAQLuw (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 17 Jan 2022 06:50:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51620 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239261AbiAQLul (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 17 Jan 2022 06:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642420240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0LrltGYx9rvAWuTg32nffJZ13xp0MLABe0GJ5c9l4rM=;
        b=Dv5BXaEZNsdW6orKWYrIIiMZV8Q9yTReEPDpQoADnJPIohOHmttDishSBDVe7w78Q8XJ+I
        EmjIikGeWR2pUcjlZeQOPQlIVhaMBw5gJX9GgW3cFnHesS2KlkSIsxUC8B5MPpnVbHi1H/
        SZXwRO1gBMGAT6p1EYL3ZogE3Tt2MxU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-530-B5EoBtC8MO2X75UTC0fFYw-1; Mon, 17 Jan 2022 06:50:36 -0500
X-MC-Unique: B5EoBtC8MO2X75UTC0fFYw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E2D4108E941;
        Mon, 17 Jan 2022 11:50:35 +0000 (UTC)
Received: from ws.net.home (ovpn-112-8.ams2.redhat.com [10.36.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 47FBC752DC;
        Mon, 17 Jan 2022 11:50:32 +0000 (UTC)
Date:   Mon, 17 Jan 2022 12:50:30 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc:     util-linux@vger.kernel.org, jkosina@suse.cz, kurt@garloff.de,
        den@openvz.org, msuchanek@suse.de, efremov@linux.com
Subject: Re: [PATCH 2/2] libblkid: reopen floppy without O_NONBLOCK
Message-ID: <20220117115030.ci5z5jtgyl2clvud@ws.net.home>
References: <20211209141233.3774937-1-vsementsov@virtuozzo.com>
 <20211209141233.3774937-3-vsementsov@virtuozzo.com>
 <20211214120349.kntr7gza5flma5tc@ws.net.home>
 <a378a167-fd41-f74d-1b0d-b997b82df05c@virtuozzo.com>
 <20211215125605.4tg7ugdnlbb3i3v7@ws.net.home>
 <9dc07586-5471-ee5e-fae4-e177ceb114f4@virtuozzo.com>
 <23719c29-9668-1edc-e60c-a30bd821c7fa@virtuozzo.com>
 <20220103084311.beuxa6fcjtzn74a3@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220103084311.beuxa6fcjtzn74a3@ws.net.home>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Jan 03, 2022 at 09:43:11AM +0100, Karel Zak wrote:
> > Hi! Are you working on this? If not I can try to make a v2.
> 
> I had a vacation in the last 14 days; nothing is done. Go ahead if you   
> have time for this task. I'm going to work on something else this
> week.

It seems you're busy with something else ;-), so I have implemented it,
but it's not tested yet.

Please, please, can you review and test it with your environment?

Thanks!

See the patch bellow or topic/blkid-floppy branch on github.

 Karel


From 49be1b256ad351cde2e0cf5000c7046e7010cc02 Mon Sep 17 00:00:00 2001
From: Karel Zak <kzak@redhat.com>
Date: Mon, 17 Jan 2022 12:37:13 +0100
Subject: [PATCH] libblkid: reopen floppy without O_NONBLOCK

Vladimir Sementsov-Ogievskiy wrote:
> The commit "floppy: reintroduce O_NDELAY fix" was removed from kernel,
> so we faced the bug described and discussed here:
> https://bugzilla.suse.com/show_bug.cgi?id=3D1181018
>
> Discussion in kernel list on reverting the commit:
> https://www.spinics.net/lists/stable/msg493061.html
>
> In short, I can quote Jiri Kosina's comment:
>
>   opening floppy device node with O_NONBLOCK is asking for all kinds
>   of trouble
>
> So opening floppy with O_NONBLOCK in blkid leads to failure of blkid,
> probable failure of mount and unpleasant error messages in dmesg (see
> also patch 02 for details).

Based on patch from Vladimir.

CC: Jiri Kosina <jkosina@suse.cz>
Reported-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Karel Zak <kzak@redhat.com>
---
 include/fileutils.h  |  3 +++
 lib/fileutils.c      | 17 +++++++++++++++++
 libblkid/src/probe.c | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/include/fileutils.h b/include/fileutils.h
index c36ce6353..8722ed59b 100644
--- a/include/fileutils.h
+++ b/include/fileutils.h
@@ -97,4 +97,7 @@ extern void ul_close_all_fds(unsigned int first, unsigned int last);
 #define UL_COPY_WRITE_ERROR (-2)
 int ul_copy_file(int from, int to);
 
+
+extern int ul_reopen(int fd, int flags);
+
 #endif /* UTIL_LINUX_FILEUTILS */
diff --git a/lib/fileutils.c b/lib/fileutils.c
index 7a8fce26f..5b15d4916 100644
--- a/lib/fileutils.c
+++ b/lib/fileutils.c
@@ -288,3 +288,20 @@ int ul_copy_file(int from, int to)
 	return copy_file_simple(from, to);
 #endif
 }
+
+int ul_reopen(int fd, int flags)
+{
+	ssize_t ssz;
+	char buf[PATH_MAX];
+	char fdpath[ sizeof(_PATH_PROC_FDDIR) +  sizeof(stringify_value(INT_MAX)) ];
+
+	snprintf(fdpath, sizeof(fdpath), _PATH_PROC_FDDIR "/%d", fd);
+
+	ssz = readlink(fdpath, buf, sizeof(buf) - 1);
+	if (ssz <= 0)
+		return -EINVAL;
+
+	buf[ssz] = '\0';
+
+	return open(buf, flags);
+}
diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
index 6168370e2..d69ff530f 100644
--- a/libblkid/src/probe.c
+++ b/libblkid/src/probe.c
@@ -103,6 +103,9 @@
 #ifdef HAVE_ERRNO_H
 #include <errno.h>
 #endif
+#ifdef HAVE_LINUX_FD_H
+#include <linux/fd.h>
+#endif
 #include <inttypes.h>
 #include <stdint.h>
 #include <stdarg.h>
@@ -113,6 +116,7 @@
 #include "sysfs.h"
 #include "strutils.h"
 #include "list.h"
+#include "fileutils.h"
 
 /*
  * All supported chains
@@ -907,6 +911,35 @@ int blkid_probe_set_device(blkid_probe pr, int fd,
 	if (fd < 0)
 		return 1;
 
+#ifdef FDGETFDCSTAT
+	{
+		/*
+		 * Re-open without O_NONBLOCK for floppy device.
+		 *
+		 * Since kernel commit c7e9d0020361f4308a70cdfd6d5335e273eb8717
+		 * floppy drive works bad when opened with O_NONBLOCK.
+		 */
+		struct floppy_fdc_state  flst;
+
+		if (ioctl(fd, FDGETFDCSTAT, &flst) >= 0) {
+			int flags = fcntl(fd, F_GETFL, 0);
+
+			if (flags < 0)
+				goto err;
+			if (flags & O_NONBLOCK) {
+				flags &= ~O_NONBLOCK;
+
+				fd = ul_reopen(fd, flags | O_CLOEXEC);
+				if (fd < 0)
+					goto err;
+
+				pr->flags |= BLKID_FL_PRIVATE_FD;
+				pr->fd = fd;
+			}
+		}
+	}
+#endif
+
 #if defined(POSIX_FADV_RANDOM) && defined(HAVE_POSIX_FADVISE)
 	/* Disable read-ahead */
 	posix_fadvise(fd, 0, 0, POSIX_FADV_RANDOM);
-- 
2.31.1

