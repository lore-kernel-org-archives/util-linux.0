Return-Path: <SRS0=QCn3=6Z=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7269C47255
	for <util-linux@archiver.kernel.org>; Mon, 11 May 2020 12:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE0E8207FF
	for <util-linux@archiver.kernel.org>; Mon, 11 May 2020 12:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJua4/68"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgEKMUE (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 11 May 2020 08:20:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44425 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725913AbgEKMUD (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 11 May 2020 08:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589199601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=1Vfe56YDToK/lT/8w6/KKc6r3uvD8Ffb68LAyy31Dew=;
        b=EJua4/68MGn5yT6e87rEDdeys313PzJJnexWbKeH34aTgV2j2R9/t6GcQ+M8XH0uFpaoY9
        u3ifMqZ4okymrBsx5JU14NzurkXeDIuwRp7tX9JhYbXTi7yA6/I4UhJxQ+aTbqC9xZew1w
        eLSmpKi6Wq++TLTMUdswmQbkv0pD4e0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-5bCU3HHQOEaB0KmzPGOkEw-1; Mon, 11 May 2020 08:19:59 -0400
X-MC-Unique: 5bCU3HHQOEaB0KmzPGOkEw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6515C107ACF9;
        Mon, 11 May 2020 12:19:58 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 95ED06299C;
        Mon, 11 May 2020 12:19:57 +0000 (UTC)
Date:   Mon, 11 May 2020 14:19:54 +0200
From:   Karel Zak <kzak@redhat.com>
To:     J William Piggott <elseifthen@gmx.com>, util-linux@vger.kernel.org
Subject: settimeofday() portability in hwclock 
Message-ID: <20200511121954.pi5wpbwxqtli7gha@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


 Hi William,

 please, review this patch. It seems we need to somehow hide libc
 maintainers' creativity as settimeofday() have different behavior on
 different libcs ;-) For example musl-C completely ignores TZ.

 I'd like to keep the current structure of our code (IMHO it's pretty
 readable now), so I have  introduced  __set_time() and __set_timezone()
 to hide the portability issues.

    Karel

From 8a1e6fe5c37e2122264c501d5452a5b55ae33b66 Mon Sep 17 00:00:00 2001
From: Karel Zak <kzak@redhat.com>
Date: Mon, 11 May 2020 13:35:21 +0200
Subject: [PATCH] hwclock: improve use of settimeofday() portability

The different libc implements TZ deprecation in settimeofday() library
function in the different way. Let's hide these portability issues and
use directly Linux syscall to set timezone.

Addresses: https://github.com/karelzak/util-linux/issues/995
Signed-off-by: Karel Zak <kzak@redhat.com>
---
 sys-utils/hwclock.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 37abab42d..ac4f9c753 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -71,6 +71,7 @@
 #include <string.h>
 #include <sys/stat.h>
 #include <sys/time.h>
+#include <sys/syscall.h>
 #include <time.h>
 #include <unistd.h>
 
@@ -655,7 +656,6 @@ display_time(struct timeval hwctime)
  * ptr2utc: tz.tz_minuteswest is zero (UTC).
  * PCIL: persistent_clock_is_local, sets the "11 minute mode" timescale.
  * firsttime: locks the warp_clock function (initialized to 1 at boot).
- * Since glibc v2.31 settimeofday() will fail if both args are non NULL
  *
  * +---------------------------------------------------------------------------+
  * |  op     | RTC scale | settimeofday calls                                  |
@@ -666,7 +666,25 @@ display_time(struct timeval hwctime)
  * | hctosys |   UTC     | 1st) locks warp* 2nd) sets tz 3rd) sets system time |
  * +---------------------------------------------------------------------------+
  *                         * only on first call after boot
+ *
+ * POSIX 2008 marked TZ in settimeofday() as deprecated. Unfortunately,
+ * different C libraries react to this deprecation in a different way. Since
+ * glibc v2.31 settimeofday() will fail if both args are not NULL, Musl-C
+ * ignores TZ at all, etc. We use __set_time() and __set_timezone() to hide
+ * these portability issues and to keep code readable.
  */
+#define __set_time(_tv)		settimeofday(_tv, NULL)
+
+static inline int __set_timezone(const struct timezone *tz)
+{
+#ifdef SYS_settimeofday
+	errno = 0;
+	return syscall(SYS_settimeofday, NULL, tz);
+#else
+	return settimeofday(NULL, tz);
+#endif
+}
+
 static int
 set_system_clock(const struct hwclock_control *ctl,
 		 const struct timeval newtime)
@@ -703,15 +721,15 @@ set_system_clock(const struct hwclock_control *ctl,
 
 		/* If UTC RTC: lock warp_clock and PCIL */
 		if (ctl->universal)
-			rc = settimeofday(NULL, &tz_utc);
+			rc = __set_timezone(&tz_utc);
 
 		/* Set kernel tz; if localtime RTC: warp_clock and set PCIL */
 		if (!rc && !( ctl->universal && !minuteswest ))
-			rc = settimeofday(NULL, &tz);
+			rc = __set_timezone(&tz);
 
 		/* Set the System Clock */
 		if ((!rc || errno == ENOSYS) && ctl->hctosys)
-			rc = settimeofday(&newtime, NULL);
+			rc = __set_time(&newtime);
 
 		if (rc) {
 			warn(_("settimeofday() failed"));
-- 
2.25.4

