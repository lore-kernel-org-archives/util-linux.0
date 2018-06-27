Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-it0-f68.google.com ([209.85.214.68]:40451 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965912AbeF0VYt (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 27 Jun 2018 17:24:49 -0400
Received: by mail-it0-f68.google.com with SMTP id 188-v6so9479146ita.5
        for <util-linux@vger.kernel.org>; Wed, 27 Jun 2018 14:24:48 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <09cf76ad-032f-2e6c-0d67-e4c8ff5bb3f2@bernhard-voelker.de>
References: <20180626211343.4675-1-kerolasa@iki.fi> <09cf76ad-032f-2e6c-0d67-e4c8ff5bb3f2@bernhard-voelker.de>
From: Sami Kerola <kerolasa@iki.fi>
Date: Wed, 27 Jun 2018 22:24:47 +0100
Message-ID: <CAG27Bk3Z7zCQpZv_0Ubd+pfo3f1G6NnKyxr4mRJYT-kyK9+p=A@mail.gmail.com>
Subject: Re: [PATCH] hwclock: stop supporting alpha cpu architecture
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 27 June 2018 at 06:58, Bernhard Voelker <mail@bernhard-voelker.de> wrote:
> On 06/26/2018 11:13 PM, Sami Kerola wrote:
>> @@ -255,16 +249,7 @@ static int synchronize_to_clock_tick_rtc(const struct hwclock_control *ctl)
>>       } else {
>>               int rc;         /* Return code from ioctl */
>>               /* Turn on update interrupts (one per second) */
>> -#if defined(__alpha__) || defined(__sparc__)
>> -             /*
>> -              * Not all alpha kernels reject RTC_UIE_ON, but probably
>> -              * they should.
>> -              */
>> -             rc = -1;
>> -             errno = EINVAL;
>> -#else
>>               rc = ioctl(rtc_fd, RTC_UIE_ON, 0);
>> -#endif
>
> Are you sure you want to change the code path for SPARC?

Hi Berny,

After reading linux kernel code, and trying to find references where sparc
condition might be originating I could not find good reason why sparc should
hard code RTC_UIE_ON not to be supported.  There is message from 2005 about
chrony having issue with sparc RTC_UIE_ON, but later in that thread Dave
Miller tells there is no problem with rtc and sparc.  I am fairly confident
ioctl(rtc_fd, RTC_UIE_ON, 0) will either do the right thing or return -1.

Reference: https://lists.debian.org/debian-sparc/2005/04/msg00115.html

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
