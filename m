Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vc0-f170.google.com ([209.85.220.170]:55211 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbaJGMs4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 7 Oct 2014 08:48:56 -0400
Received: by mail-vc0-f170.google.com with SMTP id hy10so4696768vcb.15
        for <util-linux@vger.kernel.org>; Tue, 07 Oct 2014 05:48:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5433D8DD.3090505@gmx.com>
References: <1412673336-13299-1-git-send-email-nrubinstein@aldebaran.com>
 <5433CE48.7060507@gmx.com> <CAOJKDvKapctTsiybo6aVKv9w-VUppXnNfqcQ=Cr03S3uX4-c9Q@mail.gmail.com>
 <5433D8DD.3090505@gmx.com>
From: =?UTF-8?Q?No=C3=A9_RUBINSTEIN?= <nrubinstein@aldebaran.com>
Date: Tue, 7 Oct 2014 14:48:26 +0200
Message-ID: <CAOJKDvLgeipyRqK8Kwf8=fuz3QQYuzJV_kCEvgA-BJD7p5m_fg@mail.gmail.com>
Subject: Re: [RFC PATCH] hwclock: --offset: Use offset instead of writing clock
To: JWP <elseifthen@gmx.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> Sure, hwclock already has the ability to track the offset between the
> Hardware Clock and the System Clock(which presumably is the 'correct' time).
...but this information is recorded only when setting the hardware
clock, which is impossible on some (arguably buggy) targets.

> With my patch, hctosys will include the offset when setting the System
> Clock. Which is the functionality you want, right?
Nearly.

I guess in order for the use-case I want to be possible we would need
an option for --systohc/--set to modify the adjtime file, but not to
touch the hardware clock.
