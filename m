Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:54620 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754398AbaJGPTa (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 7 Oct 2014 11:19:30 -0400
Message-ID: <5434047C.9090807@gmx.com>
Date: Tue, 07 Oct 2014 11:19:24 -0400
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?No=E9_RUBINSTEIN?= <nrubinstein@aldebaran.com>
CC: util-linux <util-linux@vger.kernel.org>
Subject: Re: [RFC PATCH] hwclock: --offset: Use offset instead of writing
 clock
References: <1412673336-13299-1-git-send-email-nrubinstein@aldebaran.com> <5433CE48.7060507@gmx.com> <CAOJKDvKapctTsiybo6aVKv9w-VUppXnNfqcQ=Cr03S3uX4-c9Q@mail.gmail.com> <5433D8DD.3090505@gmx.com> <CAOJKDvLgeipyRqK8Kwf8=fuz3QQYuzJV_kCEvgA-BJD7p5m_fg@mail.gmail.com>
In-Reply-To: <CAOJKDvLgeipyRqK8Kwf8=fuz3QQYuzJV_kCEvgA-BJD7p5m_fg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 10/07/2014 08:48 AM, Noé RUBINSTEIN wrote:
>> Sure, hwclock already has the ability to track the offset between the
>> Hardware Clock and the System Clock(which presumably is the 'correct' time).
> ...but this information is recorded only when setting the hardware
> clock, which is impossible on some (arguably buggy) targets.

I would think we should fix that. What hardware is it that hwclock cannot
set the Hardware Clock?

> 
>> With my patch, hctosys will include the offset when setting the System
>> Clock. Which is the functionality you want, right?
> Nearly.
> 
> I guess in order for the use-case I want to be possible we would need
> an option for --systohc/--set to modify the adjtime file, but not to
> touch the hardware clock.

Well, we could (re)calculate the drift factor even if setting the Hardware
Clock fails, or have an option to (re)calculate without setting the HW Clock.
I am willing to write such a patch if Mr. Zak approves.


> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
