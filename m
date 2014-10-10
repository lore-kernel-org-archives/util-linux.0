Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:50957 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751030AbaJJALH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 9 Oct 2014 20:11:07 -0400
Message-ID: <54372416.4050405@gmx.com>
Date: Thu, 09 Oct 2014 20:11:02 -0400
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?No=E9_RUBINSTEIN?= <nrubinstein@aldebaran.com>
CC: util-linux <util-linux@vger.kernel.org>
Subject: Re: [RFC PATCH] hwclock: --offset: Use offset instead of writing
 clock
References: <1412673336-13299-1-git-send-email-nrubinstein@aldebaran.com> <5433CE48.7060507@gmx.com> <CAOJKDvKapctTsiybo6aVKv9w-VUppXnNfqcQ=Cr03S3uX4-c9Q@mail.gmail.com> <5433D8DD.3090505@gmx.com> <CAOJKDvLgeipyRqK8Kwf8=fuz3QQYuzJV_kCEvgA-BJD7p5m_fg@mail.gmail.com> <54340BDD.7080405@gmx.com> <CAOJKDv+97LPMBJARpUSJ0en9NNDDuymSBWi_mJ+302AOSCdWaQ@mail.gmail.com> <54366E5B.7010302@gmx.com> <CAOJKDv+905g8wqoqLKBrv=SL6FzOnPEs_ZR2xDTGCPAa_Mt--g@mail.gmail.com>
In-Reply-To: <CAOJKDv+905g8wqoqLKBrv=SL6FzOnPEs_ZR2xDTGCPAa_Mt--g@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 10/09/2014 11:05 AM, Noé RUBINSTEIN wrote:
>> Are you sure that drift factor (re)calculation does not happen if
>> writing the Hardware Clock fails? I just had a quick look at the
>> code and it seem that we do not test to see if write fails. So
>> (re)calculation might work as is?
> 
> It does not seem to work the obvious way:
> 
> [root@localhost ~]# date
> Thu Oct  9 14:56:30 UTC 2014
> [root@localhost ~]# hwclock --systohc --update
> hwclock: ioctl(RTC_SET_TIME) to /dev/rtc to set the time failed.: Invalid argument
> [root@localhost ~]# hwclock --get
> Thu Jan  8 05:12:51 1970  .543449 seconds

You cannot initialize the Hardware Clock at all? Not even through
the BIOS?  If the Hardware Clock cannot be set at all, then my
patch will not help you.  Sorry if I misunderstood.

What machine are you using?



