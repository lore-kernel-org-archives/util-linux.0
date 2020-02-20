Return-Path: <SRS0=NKAx=4I=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6D4C11D0C
	for <util-linux@archiver.kernel.org>; Thu, 20 Feb 2020 19:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98184206F4
	for <util-linux@archiver.kernel.org>; Thu, 20 Feb 2020 19:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="DzDnid7q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgBTTso (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 20 Feb 2020 14:48:44 -0500
Received: from mout.gmx.net ([212.227.17.22]:47143 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728448AbgBTTso (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 20 Feb 2020 14:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582228119;
        bh=6J214Dflz5PScQkmvErl425xAINLRsdstE3EYQ4awns=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=DzDnid7qvBmkAVMr0pb3y90ojBKqNdVMbNDMjCG5BKl4fDqdAXzM8sUfcuASX/QVq
         G5ygJTRYYGE/Tu3XBEv9Hle7Umhau5f9JCPKN89SyPGIfUA3n86UzRfKQ8zLC7naWp
         4eujRiiDnfFokMBunOeSaTAp72iRfLFilSR0E2Pk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost ([68.56.186.98]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MtfNf-1jIhEe1T9r-00v4JI; Thu, 20
 Feb 2020 20:48:39 +0100
From:   J William Piggott <elseifthen@gmx.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH] hwclock: make glibc 2.31 compatible
Date:   Thu, 20 Feb 2020 14:47:54 -0500
Message-Id: <20200220194754.16849-1-elseifthen@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dzUsL1NlMqg/CR5CrREryG/N4Gy+iC6gWr9aQ2SLAzqNlnLqhI9
 sw58qyAYpFRXUNuFOn71n75u4tmW+KmjXf/LkTAeL5mLBslDWPhCETiIxQpWvHWJkPa1P1h
 1jOiSswTgZCFLPFivJ7famqKSvgmQdqTFC2JDVvpwx1vaSVJS/qqYKzHgX0mFPKqIuML0Mx
 jQ1tHSZewnxzC3c8YA3+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HNYtI4cWsDI=:1v0w1QmXgaB5nZwDXZINyS
 +5DJsRN1hVrAmVFgLZl0el06lvEb1/GgpFTAJe2rOjFCSlYWLmztZ6eL6Sec0UUQvZHxQTaRf
 4NSfXkC1/4KSzq3t4SRzUpXljqa3tiP4UguC1ROWIR1Ryswpky/KYCnLTR1vw/bZ59M4vtDy2
 M0Vfg6Gcs2mhd2ehloj//YDbgMmGkQe993EVFvDFJ1WeOkM302BxuqvGL0y0EyyniefnwXKKl
 w7+0hEF6vcYZ7jAAm1hAXC1Q83AS8yVrMMfEAuFlyXemh90pwAe1SCaO8F0dtCX2eUTtiEQ9r
 7E01NEQCUah9Oq8lwqor9jWFuZS0NzAAL3k297IpvgfOL4/KEZcecHkZxfxRb0aN5TO35UpVZ
 ar+hfyXnfr9rLWEw4czn3Sf1EaZd8BOd0ked3OiOKfMKXvfVB5Nuy7TgjywdGfMsmHE6G7B6D
 TnOqlMH5hw/+71+oBfSEWkZUl8ex6BYTx0zXekWP3g6ATUwtornfk+pfFOPkiEwuE0Ip4Bydu
 AHhMjBr2amSyoJ0pS3cq1bDLvB7iax5gVrkmUdtaxoPKJy5Z0BJKYJulPT3cOjAJONofGM235
 xJilO58wWXTslnLEU3rnkkPDnZjUKdfSroiGuRYPEKTtwmVyVgQPh1KZ7gBN/qI8eHer5ns+Q
 9VcvG/ik5LGM4L7z4yaMXIylDObkfrUmQexJ2gcqUpVNyQKLEr9Mvlt0HYSHOj04s8+38GFwW
 oGEgZxxp7rW7KzjNprh9OWI3n9UqE4w+gAfZ5x/nEUKfj4VKHvJcEIdd5xhT0OWs/Cbs9vj5P
 /0g9tiKIWPAdQ85HsMDnHXux08zz8WqFRRfMsu6zOJBChW+/K9KgdmE/Ntj19Rv+6p3jP/Vbx
 RyFlUUs/P9UGKxWkPecxMgjHmWZtVNBqfs349h0O9KWQUPMlcoEr7IWj4Xx4QTAUbOU/QjIEq
 JhlkzhCBQCiheOMX32bEvh50gzuHWlk9CuZhoH8qY1Mttsy+ndZoeBU/lhcNedDWypP1meckh
 Yzeuve2UOc/oG3J/iuUJ8wnhDCxndPUDUJH5+NEpV7f0Gz6Xn/hfvBWP6dlp7Jty73/mRdCOg
 ByYj520MN+O41CX+XjjWSSINdU1EdabbaF6c3MQK1bovbyBoCusQ1pDagrTbcXo6uTPAaF1EU
 1+nhIbaDcLx6omFuIesRsJ88Gu42v3r6R3tkS11qbk99Fz/9TD/BzpgCEADsOYAdwjwQKmIsy
 XpDaWKHBiYbeqncES
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, 19 Feb 2020 at 15:50, Karel Zak <kzak@redhat.com> wrote:
> Hi William,
>
>please, please, review the patch below.
>
>Let's make the review more user-friendly, all the logic is:
>
>	if (!ctl->testing) {
>		const struct timezone tz_utc =3D { 0 };
>		const struct timezone tz =3D { minuteswest };
>
>		/* warp-clock */
>		if (ctl->universal)
>			rc =3D settimeofday(NULL, &tz_utc); /* lock to UTC */
>		else
>			rc =3D settimeofday(NULL, &tz);     /* set PCIL and TZ */
>
>		/* set timezone */
>		if (!rc && ctl->universal && minuteswest)
>			rc =3D settimeofday(NULL, &tz);

The same call is made with universal and !universal; it cannot be tested
for minuteswest as it will fail, for example with:

cp/usr/share/zoneinfo/Atlantic/Reykjavik /etc/localtime
hwclock --localtime systohc

That means: !universal && minuteswest =3D=3D 0

So, drop the 'else' branch and call it unconditionally.

Nice job of simplifying the logic, by the way!

 8< ---

>
>Maybe we should also ignore rc and errno=3D=3DENOSYS for

ENOSYS yes, rc no, I think.

I'm also including ideas for comment and message changes.

So, for the amount of changes I'm suggesting I think it will be easier
for everyone if I just submit a new patch to you.

Status: builds; mostly untested.

The patch below applies on top of:

commit aa506f7cc51f9025e62ab2a58f8d5c101e56a062 (upstream/master, master)

    Merge branch 'master' of https://github.com/pali/util-linux




>From 17838aa96b3568e7295e62e717e5cba0672c1386 Mon Sep 17 00:00:00 2001
From: J William Piggott <elseifthen@gmx.com>
Date: Thu, 20 Feb 2020 14:00:19 -0500
Subject: [PATCH] hwclock: make glibc 2.31 compatible
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org

______________________________________________________
GNU C Library NEWS -- history of user-visible changes.
Version 2.31
Deprecated and removed features, and other changes affecting compatibility=
:

* The settimeofday function can still be used to set a system-wide time
  zone when the operating system supports it.  This is because the Linux
  kernel reused the API, on some architectures, to describe a system-wide
  time-zone-like offset between the software clock maintained by the kerne=
l,
  and the "RTC" clock that keeps time when the system is shut down.

  However, to reduce the odds of this offset being set by accident,
  settimeofday can no longer be used to set the time and the offset
  simultaneously.  If both of its two arguments are non-null, the call
  will fail (setting errno to EINVAL).

  Callers attempting to set this offset should also be prepared for the ca=
ll
  to fail and set errno to ENOSYS; this already happens on the Hurd and on
  some Linux architectures.  The Linux kernel maintainers are discussing a
  more principled replacement for the reused API.  After a replacement
  becomes available, we will change settimeofday to fail with ENOSYS on al=
l
  platforms when its 'tzp' argument is not a null pointer.

  settimeofday itself is obsolescent according to POSIX.  Programs that se=
t
  the system time should use clock_settime and/or the adjtime family of
  functions instead.  We may cease to make settimeofday available to newly
  linked binaries after there is a replacement for Linux's time-zone-like
  offset API.
______________________________________________________

hwclock(8) had one settimeofday(2) call where both args were set for
=2D-hctosys when the RTC was ticking UTC. This allowed setting the system
time, timezone, and locking the warp_clock function with a single call.
That operation now takes 3 calls of settimeofday(2).

Although this common operation now takes three calls, the overall logic
for the set_system_clock() function was simplified.

Co-authored-by: Karel Zak <kzak@redhat.com>
Signed-off-by: J William Piggott <elseifthen@gmx.com>
=2D--
 sys-utils/hwclock.c | 67 ++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index e736da717..8edb0b01e 100644
=2D-- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -643,28 +643,28 @@ display_time(struct timeval hwctime)
  * tz.tz_minuteswest argument and sets PCIL (see below). At boot settimeo=
fday(2)
  * has one-shot access to this function as shown in the table below.
  *
- * +-------------------------------------------------------------------+
- * |                       settimeofday(tv, tz)                        |
- * |-------------------------------------------------------------------|
- * |     Arguments     |  System Time  | PCIL |           | warp_clock |
- * |   tv    |   tz    | set  | warped | set  | firsttime |   locked   |
- * |---------|---------|---------------|------|-----------|------------|
- * | pointer | NULL    |  yes |   no   |  no  |     1     |    no      |
- * | pointer | pointer |  yes |   no   |  no  |     0     |    yes     |
- * | NULL    | ptr2utc |  no  |   no   |  no  |     0     |    yes     |
- * | NULL    | pointer |  no  |   yes  |  yes |     0     |    yes     |
- * +-------------------------------------------------------------------+
+ * +---------------------------------------------------------------------=
----+
+ * |                           settimeofday(tv, tz)                      =
    |
+ * |---------------------------------------------------------------------=
----|
+ * |     Arguments     |  System Time  | TZ  | PCIL |           | warp_cl=
ock |
+ * |   tv    |   tz    | set  | warped | set | set  | firsttime |   locke=
d   |
+ * |---------|---------|---------------|-----|------|-----------|--------=
----|
+ * | pointer | NULL    |  yes |   no   | no  |  no  |     1     |    no  =
    |
+ * | NULL    | ptr2utc |  no  |   no   | yes |  no  |     0     |    yes =
    |
+ * | NULL    | pointer |  no  |   yes  | yes |  yes |     0     |    yes =
    |
+ * +---------------------------------------------------------------------=
----+
  * ptr2utc: tz.tz_minuteswest is zero (UTC).
  * PCIL: persistent_clock_is_local, sets the "11 minute mode" timescale.
  * firsttime: locks the warp_clock function (initialized to 1 at boot).
+ * Since glibc v2.31 settimeofday() will fail if both args are non NULL
  *
  * +---------------------------------------------------------------------=
------+
  * |  op     | RTC scale | settimeofday calls                            =
      |
  * |---------|-----------|-----------------------------------------------=
------|
  * | systz   |   Local   | 1) warps system time*, sets PCIL* and kernel t=
z     |
  * | systz   |   UTC     | 1st) locks warp_clock* 2nd) sets kernel tz    =
      |
- * | hctosys |   Local   | 1st) sets PCIL* 2nd) sets system time and kern=
el tz |
- * | hctosys |   UTC     | 1) sets system time and kernel tz             =
      |
+ * | hctosys |   Local   | 1st) sets PCIL* & kernel tz   2nd) sets system=
 time |
+ * | hctosys |   UTC     | 1st) locks warp* 2nd) sets tz 3rd) sets system=
 time |
  * +---------------------------------------------------------------------=
------+
  *                         * only on first call after boot
  */
@@ -675,42 +675,41 @@ set_system_clock(const struct hwclock_control *ctl,
 	struct tm broken;
 	int minuteswest;
 	int rc =3D 0;
-	const struct timezone tz_utc =3D { 0 };

 	localtime_r(&newtime.tv_sec, &broken);
 	minuteswest =3D -get_gmtoff(&broken) / 60;

 	if (ctl->verbose) {
-		if (ctl->hctosys && !ctl->universal)
-			printf(_("Calling settimeofday(NULL, %d) to set "
-				 "persistent_clock_is_local.\n"), minuteswest);
-		if (ctl->systz && ctl->universal)
+		if (ctl->universal) {
 			puts(_("Calling settimeofday(NULL, 0) "
-				"to lock the warp function."));
+			       "to lock the warp_clock function."));
+			printf(_("Calling settimeofday(NULL, %d) to set "
+				 "the kernel timezone.\n"), minuteswest);
+		} else
+			printf(_("Calling settimeofday(NULL, %d) to warp_clock, "
+				 "set PCIL and the kernel tz.\n"), minuteswest);
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
+				 "the kernel time.\n"), newtime.tv_sec, newtime.tv_usec);
 	}

 	if (!ctl->testing) {
+		const struct timezone tz_utc =3D { 0 };
 		const struct timezone tz =3D { minuteswest };

-		if (ctl->hctosys && !ctl->universal)	/* set PCIL */
-			rc =3D settimeofday(NULL, &tz);
-		if (ctl->systz && ctl->universal)	/* lock warp_clock */
+		/* If UTC RTC: lock warp_clock and PCIL */
+		if (ctl->universal)
 			rc =3D settimeofday(NULL, &tz_utc);
-		if (!rc && ctl->hctosys)
-			rc =3D settimeofday(&newtime, &tz);
-		else if (!rc)
+
+		/* Set kernel tz; if localtime RTC: warp_clock and set PCIL */
+		if (!rc)
 			rc =3D settimeofday(NULL, &tz);

+		/* Set the System Clock */
+		if ((!rc || errno =3D=3D ENOSYS) && ctl->hctosys)
+			rc =3D settimeofday(&newtime, NULL);
+
 		if (rc) {
 			warn(_("settimeofday() failed"));
 			return  EXIT_FAILURE;
