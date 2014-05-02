Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f47.google.com ([209.85.220.47]:40545 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbaEBI0D (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 2 May 2014 04:26:03 -0400
Received: by mail-pa0-f47.google.com with SMTP id fa1so5000258pad.6
        for <util-linux@vger.kernel.org>; Fri, 02 May 2014 01:26:02 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <CALkMTNnLBf3q4PBVUCOdgzJiK6G4h4-+28hSPzSGyvx+3xLnGQ@mail.gmail.com>
References: <CALkMTNnMEujZy7H2tv+iUApHK+10b3Q3aNu4E+cxy=U-uE37ew@mail.gmail.com>
	<CALkMTNnLBf3q4PBVUCOdgzJiK6G4h4-+28hSPzSGyvx+3xLnGQ@mail.gmail.com>
Date: Fri, 2 May 2014 09:26:02 +0100
Message-ID: <CAG27Bk2mYN7BoMcMfJEm=1KLat1zERNnvd2zV01deik-PBk_Hw@mail.gmail.com>
Subject: Re: Problem with gettimeofday
From: Sami Kerola <kerolasa@iki.fi>
To: Alexander Samilovskih <alexsamilovskih@gmail.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 2 May 2014 03:52, Alexander Samilovskih <alexsamilovskih@gmail.com> wrote:
> There are several places where gettimeofday should be replaced by
> clock_gettime(CLOCK_MONOTONIC_RAW). According to manual pages
> gettimeofday affected by discontinues jumps made by system
> administrator, can be slewed by ntpd or kinda stuff. So when we
> subtract two different timestamps from gettimeofday we can get
> confusing results
>
> sys-utils/eject.c
> libmount/lock.c
> maybe some other places...

Hi Alexander,

The diff you sent does not seem to work.

fatal: corrupt patch at line 123

The format you get from

$ git format-patch HEAD~1

would be appreciated.

> diff --git a/include/timeutils.h b/include/timeutils.h
> index bcae613..7cf972d 100644
> --- a/include/timeutils.h
> +++ b/include/timeutils.h
> @@ -51,5 +51,6 @@ typedef uint64_t nsec_t;
>  #define FORMAT_TIMESPAN_MAX 64
>
>  int parse_timestamp(const char *t, usec_t *usec);
> +int gettime_monotonic(struct timeval *tv);
>
>  #endif /* UTIL_LINUX_TIME_UTIL_H */
> diff --git a/lib/timeutils.c b/lib/timeutils.c
> index 7fe6218..06ae597 100644
> --- a/lib/timeutils.c
> +++ b/lib/timeutils.c
> @@ -336,3 +336,24 @@ int parse_timestamp(const char *t, usec_t *usec)
>
>   return 0;
>  }
> +
> +int gettime_monotonic(struct timeval *tv)
> +{
> +#ifdef CLOCK_MONOTONIC
> + //Can slew only by ntp and adjtime

Could you use /* comment */ style rather than // from C++ world.

> + int ret;
> + struct timespec ts;
> +#ifdef CLOCK_MONOTONIC_RAW
> + //Linux specific, cant slew
> + if (!(ret = clock_gettime(CLOCK_MONOTONIC_RAW, &ts))) {
> +#else
> + if (!(ret = clock_gettime(CLOCK_MONOTONIC, &ts))) {
> +#endif
> + tv->tv_sec = ts.tv_sec;
> + tv->tv_usec = ts.tv_nsec / 1000;
> + }
> + return ret;
> +#else

A comment could ease understanding what is going on, such as

#else   /* CLOCK_MONOTONIC is not available */

> + return gettimeofday(tv, NULL);
> +#endif
> +}

Th rest looks pretty ok.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
