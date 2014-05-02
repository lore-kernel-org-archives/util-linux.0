Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ob0-f170.google.com ([209.85.214.170]:60117 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997AbaEBMMP (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 2 May 2014 08:12:15 -0400
Received: by mail-ob0-f170.google.com with SMTP id vb8so5109354obc.29
        for <util-linux@vger.kernel.org>; Fri, 02 May 2014 05:12:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAG27Bk2mYN7BoMcMfJEm=1KLat1zERNnvd2zV01deik-PBk_Hw@mail.gmail.com>
References: <CALkMTNnMEujZy7H2tv+iUApHK+10b3Q3aNu4E+cxy=U-uE37ew@mail.gmail.com>
	<CALkMTNnLBf3q4PBVUCOdgzJiK6G4h4-+28hSPzSGyvx+3xLnGQ@mail.gmail.com>
	<CAG27Bk2mYN7BoMcMfJEm=1KLat1zERNnvd2zV01deik-PBk_Hw@mail.gmail.com>
Date: Fri, 2 May 2014 12:12:14 +0000
Message-ID: <CALkMTNkNJY5mUjPh_UJRnR2kZ8+KPpXkPADEWqT4EUEBxZBQMw@mail.gmail.com>
Subject: Re: Problem with gettimeofday
From: Alexander Samilovskih <alexsamilovskih@gmail.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

2014-05-02 8:26 GMT+00:00 Sami Kerola <kerolasa@iki.fi>:
> On 2 May 2014 03:52, Alexander Samilovskih <alexsamilovskih@gmail.com> wrote:
>> There are several places where gettimeofday should be replaced by
>> clock_gettime(CLOCK_MONOTONIC_RAW). According to manual pages
>> gettimeofday affected by discontinues jumps made by system
>> administrator, can be slewed by ntpd or kinda stuff. So when we
>> subtract two different timestamps from gettimeofday we can get
>> confusing results
>>
>> sys-utils/eject.c
>> libmount/lock.c
>> maybe some other places...
>
> Hi Alexander,
>
> The diff you sent does not seem to work.
>
> fatal: corrupt patch at line 123
>
> The format you get from
>
> $ git format-patch HEAD~1
>
> would be appreciated.
>
>> diff --git a/include/timeutils.h b/include/timeutils.h
>> index bcae613..7cf972d 100644
>> --- a/include/timeutils.h
>> +++ b/include/timeutils.h
>> @@ -51,5 +51,6 @@ typedef uint64_t nsec_t;
>>  #define FORMAT_TIMESPAN_MAX 64
>>
>>  int parse_timestamp(const char *t, usec_t *usec);
>> +int gettime_monotonic(struct timeval *tv);
>>
>>  #endif /* UTIL_LINUX_TIME_UTIL_H */
>> diff --git a/lib/timeutils.c b/lib/timeutils.c
>> index 7fe6218..06ae597 100644
>> --- a/lib/timeutils.c
>> +++ b/lib/timeutils.c
>> @@ -336,3 +336,24 @@ int parse_timestamp(const char *t, usec_t *usec)
>>
>>   return 0;
>>  }
>> +
>> +int gettime_monotonic(struct timeval *tv)
>> +{
>> +#ifdef CLOCK_MONOTONIC
>> + //Can slew only by ntp and adjtime
>
> Could you use /* comment */ style rather than // from C++ world.
>
>> + int ret;
>> + struct timespec ts;
>> +#ifdef CLOCK_MONOTONIC_RAW
>> + //Linux specific, cant slew
>> + if (!(ret = clock_gettime(CLOCK_MONOTONIC_RAW, &ts))) {
>> +#else
>> + if (!(ret = clock_gettime(CLOCK_MONOTONIC, &ts))) {
>> +#endif
>> + tv->tv_sec = ts.tv_sec;
>> + tv->tv_usec = ts.tv_nsec / 1000;
>> + }
>> + return ret;
>> +#else
>
> A comment could ease understanding what is going on, such as
>
> #else   /* CLOCK_MONOTONIC is not available */
>
>> + return gettimeofday(tv, NULL);
>> +#endif
>> +}
>
> Th rest looks pretty ok.
>
> --
> Sami Kerola
> http://www.iki.fi/kerolasa/

Fixed,

git format-patch HEAD~3

>From b641e268ab0aa1597e46f79accd169c388f06c7c Mon Sep 17 00:00:00 2001
From: Alex Samilovskih <alexsamilovskih@gmail.com>
Date: Fri, 2 May 2014 18:15:12 +0000
Subject: [PATCH 1/3] Add support for monotonic clock

---
 include/timeutils.h |  1 +
 lib/timeutils.c     | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/timeutils.h b/include/timeutils.h
index bcae613..7cf972d 100644
--- a/include/timeutils.h
+++ b/include/timeutils.h
@@ -51,5 +51,6 @@ typedef uint64_t nsec_t;
 #define FORMAT_TIMESPAN_MAX 64

 int parse_timestamp(const char *t, usec_t *usec);
+int gettime_monotonic(struct timeval *tv);

 #endif /* UTIL_LINUX_TIME_UTIL_H */
diff --git a/lib/timeutils.c b/lib/timeutils.c
index 7fe6218..b3fb87b 100644
--- a/lib/timeutils.c
+++ b/lib/timeutils.c
@@ -336,3 +336,27 @@ int parse_timestamp(const char *t, usec_t *usec)

  return 0;
 }
+
+/*  Get the current time that is not a subject to resetting and drifting  */
+int gettime_monotonic(struct timeval *tv)
+{
+#ifdef CLOCK_MONOTONIC
+ int ret;
+ struct timespec ts;
+
+#ifdef CLOCK_MONOTONIC_RAW
+ if (!(ret = clock_gettime(CLOCK_MONOTONIC_RAW, &ts))) {
+#else /* CLOCK_MONOTONIC_RAW is not available */
+ if (!(ret = clock_gettime(CLOCK_MONOTONIC, &ts))) {
+#endif
+ tv->tv_sec = ts.tv_sec;
+ tv->tv_usec = ts.tv_nsec / 1000;
+ }
+
+ return ret;
+
+#else /* CLOCK_MONOTONIC is not available */
+
+ return gettimeofday(tv, NULL);
+#endif
+}
-- 
1.9.2


>From b72b47b2f8e12c4cb53e817939bad464139e9042 Mon Sep 17 00:00:00 2001
From: Alex Samilovskih <alexsamilovskih@gmail.com>
Date: Fri, 2 May 2014 18:21:20 +0000
Subject: [PATCH 2/3] Add support for monotonic clock in eject

---
 sys-utils/eject.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sys-utils/eject.c b/sys-utils/eject.c
index 03744c7..049cdb7 100644
--- a/sys-utils/eject.c
+++ b/sys-utils/eject.c
@@ -52,6 +52,7 @@
 #include "xalloc.h"
 #include "pathnames.h"
 #include "sysfs.h"
+#include "timeutils.h"

 /*
  * sg_io_hdr_t driver_status -- see kernel include/scsi/scsi.h
@@ -460,7 +461,7 @@ static void toggle_tray(int fd)
  * needed.  In my experience the function needs less than 0.05
  * seconds if the tray was already open, and at least 1.5 seconds
  * if it was closed.  */
- gettimeofday(&time_start, NULL);
+ gettime_monotonic(&time_start);

  /* Send the CDROMEJECT command to the device. */
  if (!eject_cdrom(fd))
@@ -468,7 +469,7 @@ static void toggle_tray(int fd)

  /* Get the second timestamp, to measure the time needed to open
  * the tray.  */
- gettimeofday(&time_stop, NULL);
+ gettime_monotonic(&time_stop);

  time_elapsed = (time_stop.tv_sec * 1000000 + time_stop.tv_usec) -
  (time_start.tv_sec * 1000000 + time_start.tv_usec);
-- 
1.9.2


>From b8ca74bfdb93034e9d1c52ab8702ff02dab8787c Mon Sep 17 00:00:00 2001
From: Alex Samilovskih <alexsamilovskih@gmail.com>
Date: Fri, 2 May 2014 18:28:31 +0000
Subject: [PATCH 3/3] Add support for monotonic clock in libmount

---
 libmount/src/lock.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/libmount/src/lock.c b/libmount/src/lock.c
index 8667db9..41f8ed1 100644
--- a/libmount/src/lock.c
+++ b/libmount/src/lock.c
@@ -25,6 +25,7 @@
 #include "closestream.h"
 #include "pathnames.h"
 #include "mountP.h"
+#include "timeutils.h"

 /*
  * lock handler
@@ -258,7 +259,7 @@ static int mnt_wait_mtab_lock(struct libmnt_lock
*ml, struct flock *fl, time_t m
  struct sigaction sa, osa;
  int ret = 0;

- gettimeofday(&now, NULL);
+ gettime_monotonic(&now);

  if (now.tv_sec >= maxtime)
  return 1; /* timeout */
@@ -408,7 +409,7 @@ static int lock_mtab(struct libmnt_lock *ml)
  }
  close(i);

- gettimeofday(&maxtime, NULL);
+ gettime_monotonic(&maxtime);
  maxtime.tv_sec += MOUNTLOCK_MAXTIME;

  waittime.tv_sec = 0;
@@ -434,7 +435,7 @@ static int lock_mtab(struct libmnt_lock *ml)
  if (ml->lockfile_fd < 0) {
  /* Strange... Maybe the file was just deleted? */
  int errsv = errno;
- gettimeofday(&now, NULL);
+ gettime_monotonic(&now);
  if (errsv == ENOENT && now.tv_sec < maxtime.tv_sec) {
  ml->locked = 0;
  continue;
@@ -646,7 +647,7 @@ int test_lock(struct libmnt_test *ts, int argc,
char *argv[])

  /* start the test in exactly defined time */
  if (synctime) {
- gettimeofday(&tv, NULL);
+ gettimeofday(&tv);
  if (synctime && synctime - tv.tv_sec > 1) {
  usecs = ((synctime - tv.tv_sec) * 1000000UL) -
  (1000000UL - tv.tv_usec);
-- 
1.9.2
