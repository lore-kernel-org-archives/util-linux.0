Return-Path: <SRS0=LDMA=4K=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB29C35641
	for <util-linux@archiver.kernel.org>; Sat, 22 Feb 2020 01:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0BE206EF
	for <util-linux@archiver.kernel.org>; Sat, 22 Feb 2020 01:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ktp5sB21"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgBVBEj (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 21 Feb 2020 20:04:39 -0500
Received: from mout.gmx.net ([212.227.17.21]:59023 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbgBVBEi (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 21 Feb 2020 20:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582333473;
        bh=4rkoHoUgn7OYpFZiaRvIijUlYh4mKbdJKVvZs1rAYfw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ktp5sB213yN42VclODBmm4u62PCe55f/UcDgWQNf87w5eAwDIkUEr8/wSfng0flFR
         QNv5w42QbnpXXdjeA2hbU6ZyIQc2PTqtszA6VWQ4Qszw0Z2SEFVKw+wzwRzTuQiFlL
         ZcmqZ+UQIBMnIy5BCsuCkfHaPgCqM60P9vRAh0yc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost ([68.56.186.98]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZCfJ-1isGXY0RfN-00V8Bs; Sat, 22
 Feb 2020 02:04:33 +0100
From:   J William Piggott <elseifthen@gmx.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [v2 PATCH] hwclock: make glibc 2.31 compatible
Date:   Fri, 21 Feb 2020 20:03:47 -0500
Message-Id: <20200222010347.2743-1-elseifthen@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1dGOs3zDP8emAGWelNLKRaXNL5LcEuPEfUX2nWC9mFdHQdUASLG
 hEpeAEt63C9OWdjR++PJZ9FDXW+NTvrR1ImXyuu+eXQZUrZ17skbVy92p9uoSXW4qK1meH5
 pUURIko7JLPZ7gr8lHr1+c/5fz5KhFfJgUZDa3wIJmf/hzL080ga9en22AP0Ka62YNUEFcz
 acpv37758f3cl8RjHxS8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y8p7PFN+ZOY=:TsVAr0vFB2jV/SATwCf+Fb
 6mcxXgSW+v/umk/qkfAbGh1eVDM60+8S6hzkj2LGEeLfOFf9JBwn11PglgDAqOGgZbjYbMe5X
 dmfnFO6FsTmXTwpUGHe+SzJKzoy/L4A2Wk6pg9x/y69pWztR1bmnqlx7C5PencAbqW+l1tn9g
 SL9Gqub2/EE2tQHPz92ljcGoUr4/owQEZJaTC2s1FXJmERPsofnz5zSSdZXOZY4c3+nxLHZcF
 IV9P3+9TC9HEGuehHXtPK+jeCDG9/DNHC5ZBM4wO5iRGkCmMj7wPuLpqb4ILq6NwfN2FD4hl3
 O7XTdmbUuT/W53SGV5bvisU96gM9SkFNY3wOWXV/hLQCE0rWIOJVbKgWwih66ZPlatr4wSKRG
 qlvWZQL/EGnbzpF9yEPY7SK04Gz9N/+YB+qIpINrLahNaqFBlkofgCsfIknhCtZWTSrXanZVO
 gmrcSreZohWJJVfhFlhrtifMdgjcdEImaA+Hh+CRR1EerBtiovqiWus8sHxaVKNANoJfdaVvs
 3XbgrWsuFmGXhczuRa34J0Lr/HII5ZJ1YS5tJHbf8mnczr6wDk00VM/aOfou6gRoiaswSb6RB
 XLKNlQelvSQLJk4kFOhMwp5lUvIV89gu+YSR7uzXnGRC38g/jbvqvheVxgJ7P09YiH+VBYIDr
 mbeguJIRrB8E3HHVBT6nNT8j1+a/qJM4iXXMxJusuXw8EHO7gNlX4brQhzl1yeD5+WraHJuP5
 RnoaTDDf/To7yUcoKOAFmX0NCLUvqYKztlN4jM2BSJFbO7bvf4q0XS7WgWx+q7oEBanYODcNV
 Vm/IsQWWCKht5x7T+9Rk57lbpNXod1vZJvvsuJ1UqCyzthu/2Rn9wq+fzvIOVgbmpYV1d2v8b
 I0OzdRYW6zTBaeJp7FCufkWYtw0kyiUBkO930u5avjIM1ev3NN/9kL8F/m+4y5057nYaEcpam
 I0+VRyAVdGTDyjYOeU4YbdWDQ9wWRQ4OYju91aZEqjKts3VAK9VlxJVsd1s+KHOyjtv54Kxdc
 r6wJjkLHuMTe3hrnnGvYJ83HvKB085WBxBGUTjN7UUJV0j7tOJ/KV+8t981+ZwJw9M5Q76SQA
 YQbIgbKSaGscXAx6NVZwC3IpsAGnPNBR1R50aQGPQJLiHiDtv4J73xBBcNgjPR8QIWcrXpcwf
 0KzZE5leRFWqCk6zNAYUhJC+NxD+aQyibmwg/ZrcE1Va4Ikn2jhxw9SaBG8c5xaEaku9+sER7
 jkMuSEylPYTx2C+TY
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

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

Changes from v1:
 Only make one settimeofday(2) call when: rtc_is_utc and tz_is_utc

Karel, your patch implemented the the above mentioned v1 change, so
I put that back. With the glibc change there is no way to avoid a double
call when: rtc_is_utc and tz_is_!zero. See the two tables below. These
compare just the time zone and warp_clock calls, not the clock setting.


Comparison of calls for [v1 PATCH]:
_____________________________________________________
 Number of settimeofday(2) calls to set timezone/warp

           RTC      RTC
Sys TZ  |  UTC  | Localtime |
=2D--------------------------------------------
UTC0    |   1   |    2
=2D-------|-------|------- Karel's   More code  7 calls
EST5    |   2   |    2
=2D-------|-------|----------------------------
UTC0    |   2   |    1     v1
=2D-------|-------|------- Willie's  Less code  6 calls
EST5    |   2   |    1
=2D--------------------------------------------


Comparison of calls for [v2 PATCH]:
_____________________________________________________

 Number of settimeofday(2) calls to set timezone/warp

           RTC      RTC
Sys TZ  |  UTC  | Localtime |
=2D--------------------------------------------
UTC0    |   1   |    2
=2D-------|-------|------- Karel's   More code  7 calls
EST5    |   2   |    2
=2D-------|-------|----------------------------
UTC0    |   1   |    1     v2
=2D-------|-------|------- Willie's  Less code  5 calls
EST5    |   2   |    1
=2D--------------------------------------------

Status: builds, but mostly untested.

 sys-utils/hwclock.c | 71 +++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 34 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index e736da717..1191a8571 100644
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
@@ -675,42 +675,45 @@ set_system_clock(const struct hwclock_control *ctl,
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
+			if (!( ctl->universal && !minuteswest ))
+				printf(_("Calling settimeofday(NULL, %d) "
+					 "to set the kernel timezone.\n"),
+				       minuteswest);
+		} else
+			printf(_("Calling settimeofday(NULL, %d) to warp "
+				 "System time, set PCIL and the kernel tz.\n"),
+			       minuteswest);
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
+			printf(_("Calling settimeofday(%ld.%06ld, NULL) "
+				 "to set the System time.\n"),
+			       newtime.tv_sec, newtime.tv_usec);
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
+		if (!rc && !( ctl->universal && !minuteswest ))
 			rc =3D settimeofday(NULL, &tz);

+		/* Set the System Clock */
+		if ((!rc || errno =3D=3D ENOSYS) && ctl->hctosys)
+			rc =3D settimeofday(&newtime, NULL);
+
 		if (rc) {
 			warn(_("settimeofday() failed"));
 			return  EXIT_FAILURE;
