Return-Path: <SRS0=9jDI=4H=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D225C34047
	for <util-linux@archiver.kernel.org>; Wed, 19 Feb 2020 15:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA4324654
	for <util-linux@archiver.kernel.org>; Wed, 19 Feb 2020 15:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QlgvdT7j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgBSPac (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 19 Feb 2020 10:30:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44783 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726569AbgBSPac (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 19 Feb 2020 10:30:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582126230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=/rJE9Us631gyjFF3f8TvUH+e/l295katmbqpM9SVifI=;
        b=QlgvdT7j2Xq2ULxTnyxa8JFJRhRFM6btbTu8iu7CXqLB28OFbfbQU5q+l7bOda2Eyyo/1w
        4l7KbDSpbGISEgBjjwoMpl01Ily59yDUS/dZhAeSziuhnjufOK80b7niKPoVvZrSQMS5ML
        KQ/Q7ne0dVPB5/hHW8KBBScyz6rKLyU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-hqRanSXLOMC8p6ioEG3JNQ-1; Wed, 19 Feb 2020 10:30:25 -0500
X-MC-Unique: hqRanSXLOMC8p6ioEG3JNQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CEE21108C31E;
        Wed, 19 Feb 2020 15:30:24 +0000 (UTC)
Received: from ws.net.home (ovpn-204-202.brq.redhat.com [10.40.204.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 047BD60C05;
        Wed, 19 Feb 2020 15:30:23 +0000 (UTC)
Date:   Wed, 19 Feb 2020 16:30:21 +0100
From:   Karel Zak <kzak@redhat.com>
To:     J William Piggott <elseifthen@gmx.com>
Cc:     util-linux@vger.kernel.org
Subject: review - hwclock: fix for glibc 2.31 settimeofday()
Message-ID: <20200219153021.47tbre7bloztmfdk@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


 Hi William,

please, please, review the patch below.

Let's make the review more user-friendly, all the logic is:

	if (!ctl->testing) {
		const struct timezone tz_utc = { 0 };
		const struct timezone tz = { minuteswest };

		/* warp-clock */
		if (ctl->universal)
			rc = settimeofday(NULL, &tz_utc); /* lock to UTC */
		else
			rc = settimeofday(NULL, &tz);     /* set PCIL and TZ */

		/* set timezone */
		if (!rc && ctl->universal && minuteswest)
			rc = settimeofday(NULL, &tz);

		/* set time */
		if (!rc && ctl->hctosys)
			rc = settimeofday(&newtime, NULL);

		if (rc) {
			warn(_("settimeofday() failed"));
			return  EXIT_FAILURE;
		}
	}

it means the patch splits all into three steps:
   1/ warp-clock
   2/ TZ setting (if not set in 1/)
   3/ set time

Maybe we should also ignore rc and errno==ENOSYS for
settimeofday(NULL, tz) as TZ offset modification is not supported on
some archs, but we still need to set time in this case. Not sure.

The next thing we need is to use clock_settime(CLOCK_REALTIME) to set
time and to avoid settimeofday() if possible, but it's not so
important for now.

It's like to have this glibc API change fixed in maintenance release
v2.35.2 because now hwclock -s ends with "hwclock: settimeofday()
failed: Invalid argument" after glibc update...

Thanks,
  Karel

From c5d472cfb8b9102e4a76995228513ed6a70608e7 Mon Sep 17 00:00:00 2001
From: Karel Zak <kzak@redhat.com>
Date: Wed, 19 Feb 2020 15:50:47 +0100
Subject: [PATCH] hwclock: fix for glibc 2.31 settimeofday()

glibc announce:
  ... settimeofday can no longer be used to set the time and the offset
  simultaneously. If both of its two arguments are non-null, the call
  will fail (setting errno to EINVAL).

It means we need to call settimeofday(NULL, tz) and settimeofday(tv, NULL).

Unfortunately, settimeofday(NULL, tz) has very special warp-clock
semantic if used as the very first settimeofday() call. It means we
have to be sure that we do not touch warp-clock if we need only need
to modify system TZ. So, let's always call settimeofday(NULL, 0)
before settimeofday(NULL, tz) for UTC rtc mode when modify system TZ.

CC: J William Piggott <elseifthen@gmx.com>
Signed-off-by: Karel Zak <kzak@redhat.com>
---
 sys-utils/hwclock.c | 49 ++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index e736da717..16576bc18 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -658,6 +658,9 @@ display_time(struct timeval hwctime)
  * PCIL: persistent_clock_is_local, sets the "11 minute mode" timescale.
  * firsttime: locks the warp_clock function (initialized to 1 at boot).
  *
+ * Note that very first settimeofday(NULL, tz) modifies warp-clock as well as
+ * system TZ.
+ *
  * +---------------------------------------------------------------------------+
  * |  op     | RTC scale | settimeofday calls                                  |
  * |---------|-----------|-----------------------------------------------------|
@@ -675,41 +678,45 @@ set_system_clock(const struct hwclock_control *ctl,
 	struct tm broken;
 	int minuteswest;
 	int rc = 0;
-	const struct timezone tz_utc = { 0 };
 
 	localtime_r(&newtime.tv_sec, &broken);
 	minuteswest = -get_gmtoff(&broken) / 60;
 
 	if (ctl->verbose) {
-		if (ctl->hctosys && !ctl->universal)
-			printf(_("Calling settimeofday(NULL, %d) to set "
-				 "persistent_clock_is_local.\n"), minuteswest);
-		if (ctl->systz && ctl->universal)
+		if (ctl->universal)
 			puts(_("Calling settimeofday(NULL, 0) "
-				"to lock the warp function."));
+			       "to lock the warp function."));
+		else
+			printf(_("Calling settimeofday(NULL, %d) to set "
+				 "persistent_clock_is_local and "
+				 "the kernel timezone.\n"), minuteswest);
+
+		if (ctl->universal && minuteswest)
+			printf(_("Calling settimeofday(NULL, %d) to set "
+				 "the kernel timezone.\n"), minuteswest);
+
 		if (ctl->hctosys)
-			printf(_("Calling settimeofday(%ld.%06ld, %d)\n"),
-			       newtime.tv_sec, newtime.tv_usec, minuteswest);
-		else {
-			printf(_("Calling settimeofday(NULL, %d) "), minuteswest);
-			if (ctl->universal)
-				 puts(_("to set the kernel timezone."));
-			else
-				 puts(_("to warp System time."));
-		}
+			printf(_("Calling settimeofday(%ld.%06ld, 0) to set "
+			         "the kernel time.\n"), newtime.tv_sec, newtime.tv_usec);
 	}
 
 	if (!ctl->testing) {
+		const struct timezone tz_utc = { 0 };
 		const struct timezone tz = { minuteswest };
 
-		if (ctl->hctosys && !ctl->universal)	/* set PCIL */
+		/* warp-clock */
+		if (ctl->universal)
+			rc = settimeofday(NULL, &tz_utc); /* lock to UTC */
+		else
+			rc = settimeofday(NULL, &tz);     /* set PCIL and TZ */
+
+		/* set timezone */
+		if (!rc && ctl->universal && minuteswest)
 			rc = settimeofday(NULL, &tz);
-		if (ctl->systz && ctl->universal)	/* lock warp_clock */
-			rc = settimeofday(NULL, &tz_utc);
+
+		/* set time */
 		if (!rc && ctl->hctosys)
-			rc = settimeofday(&newtime, &tz);
-		else if (!rc)
-			rc = settimeofday(NULL, &tz);
+			rc = settimeofday(&newtime, NULL);
 
 		if (rc) {
 			warn(_("settimeofday() failed"));
-- 
2.24.1

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

