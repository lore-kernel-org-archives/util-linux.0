Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:50733 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751064AbaJILPo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 9 Oct 2014 07:15:44 -0400
Message-ID: <54366E5B.7010302@gmx.com>
Date: Thu, 09 Oct 2014 07:15:39 -0400
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?No=E9_RUBINSTEIN?= <nrubinstein@aldebaran.com>
CC: util-linux <util-linux@vger.kernel.org>
Subject: Re: [RFC PATCH] hwclock: --offset: Use offset instead of writing
 clock
References: <1412673336-13299-1-git-send-email-nrubinstein@aldebaran.com> <5433CE48.7060507@gmx.com> <CAOJKDvKapctTsiybo6aVKv9w-VUppXnNfqcQ=Cr03S3uX4-c9Q@mail.gmail.com> <5433D8DD.3090505@gmx.com> <CAOJKDvLgeipyRqK8Kwf8=fuz3QQYuzJV_kCEvgA-BJD7p5m_fg@mail.gmail.com> <54340BDD.7080405@gmx.com> <CAOJKDv+97LPMBJARpUSJ0en9NNDDuymSBWi_mJ+302AOSCdWaQ@mail.gmail.com>
In-Reply-To: <CAOJKDv+97LPMBJARpUSJ0en9NNDDuymSBWi_mJ+302AOSCdWaQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello Noé,

I recalled the first set of patches from 14/09/14 titled
'[PATCH 1/2] hwclock: hctosys drift compensation' and 
'[PATCH 2/2] hwclock: hctosys drift compensation man page'
Do not use those. 

Use only the 1/7 ~ 7/7 patch set as it supersedes the first.

Sorry for the confusion.

On 10/09/2014 04:51 AM, Noé RUBINSTEIN wrote:
> Hi J,
> 
> I tried appplying your patches and got into some problems:
>> Applying: hwclock: hctosys drift compensation II
>> error: patch failed: sys-utils/hwclock.c:807
>> error: sys-utils/hwclock.c: patch does not apply
> 
> I tried that both upon origin/master and upon fb2ba06, which you seem
> to have based your first patch on.
> 
> Here's the list of patches I was trying to apply:
>> [PATCH 1/2] hwclock: hctosys drift compensation
>> [PATCH 2/2] hwclock: hctosys drift compensation man page
>> [PATCH 1/7] hwclock: hctosys drift compensation II
>> [PATCH 2/7] hwclock: hctosys drift compensation II COMMENTS
>> [PATCH 3/7] hwclock: hctosys drift compensation II MAN
>> [PATCH 4/7] hwclock: persistent_clock_is_local
>> [PATCH 5/7] hwclock: persistent_clock_is_local MAN
>> [PATCH 6/7] hwclock: Add --update option
>> [PATCH 7/7] hwclock: Add --update option MAN
> 
> Did I overlook a patch somewhere?
> 
> 
> 2014-10-07 17:50 GMT+02:00 JWP <elseifthen@gmx.com>:
>>
>> On 10/07/2014 08:48 AM, NoÃ© RUBINSTEIN wrote:
>>>> Sure, hwclock already has the ability to track the offset between the
>>>> Hardware Clock and the System Clock(which presumably is the 'correct' time).
>>> ...but this information is recorded only when setting the hardware
>>> clock, which is impossible on some (arguably buggy) targets.
>>
>> Are you sure that drift factor (re)calculation does not happen if
>> writing the Hardware Clock fails? I just had a quick look at the
>> code and it seem that we do not test to see if write fails. So
>> (re)calculation might work as is?
> 
