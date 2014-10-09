Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vc0-f181.google.com ([209.85.220.181]:57901 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbaJIIvc convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 9 Oct 2014 04:51:32 -0400
Received: by mail-vc0-f181.google.com with SMTP id le20so582167vcb.40
        for <util-linux@vger.kernel.org>; Thu, 09 Oct 2014 01:51:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <54340BDD.7080405@gmx.com>
References: <1412673336-13299-1-git-send-email-nrubinstein@aldebaran.com>
 <5433CE48.7060507@gmx.com> <CAOJKDvKapctTsiybo6aVKv9w-VUppXnNfqcQ=Cr03S3uX4-c9Q@mail.gmail.com>
 <5433D8DD.3090505@gmx.com> <CAOJKDvLgeipyRqK8Kwf8=fuz3QQYuzJV_kCEvgA-BJD7p5m_fg@mail.gmail.com>
 <54340BDD.7080405@gmx.com>
From: =?UTF-8?Q?No=C3=A9_RUBINSTEIN?= <nrubinstein@aldebaran.com>
Date: Thu, 9 Oct 2014 10:51:01 +0200
Message-ID: <CAOJKDv+97LPMBJARpUSJ0en9NNDDuymSBWi_mJ+302AOSCdWaQ@mail.gmail.com>
Subject: Re: [RFC PATCH] hwclock: --offset: Use offset instead of writing clock
To: JWP <elseifthen@gmx.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi J,

I tried appplying your patches and got into some problems:
> Applying: hwclock: hctosys drift compensation II
> error: patch failed: sys-utils/hwclock.c:807
> error: sys-utils/hwclock.c: patch does not apply

I tried that both upon origin/master and upon fb2ba06, which you seem
to have based your first patch on.

Here's the list of patches I was trying to apply:
> [PATCH 1/2] hwclock: hctosys drift compensation
> [PATCH 2/2] hwclock: hctosys drift compensation man page
> [PATCH 1/7] hwclock: hctosys drift compensation II
> [PATCH 2/7] hwclock: hctosys drift compensation II COMMENTS
> [PATCH 3/7] hwclock: hctosys drift compensation II MAN
> [PATCH 4/7] hwclock: persistent_clock_is_local
> [PATCH 5/7] hwclock: persistent_clock_is_local MAN
> [PATCH 6/7] hwclock: Add --update option
> [PATCH 7/7] hwclock: Add --update option MAN

Did I overlook a patch somewhere?


2014-10-07 17:50 GMT+02:00 JWP <elseifthen@gmx.com>:
>
> On 10/07/2014 08:48 AM, Noé RUBINSTEIN wrote:
>>> Sure, hwclock already has the ability to track the offset between the
>>> Hardware Clock and the System Clock(which presumably is the 'correct' time).
>> ...but this information is recorded only when setting the hardware
>> clock, which is impossible on some (arguably buggy) targets.
>
> Are you sure that drift factor (re)calculation does not happen if
> writing the Hardware Clock fails? I just had a quick look at the
> code and it seem that we do not test to see if write fails. So
> (re)calculation might work as is?
