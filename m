Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vc0-f171.google.com ([209.85.220.171]:59817 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755901AbaJIPGP (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 9 Oct 2014 11:06:15 -0400
Received: by mail-vc0-f171.google.com with SMTP id hy10so1139917vcb.2
        for <util-linux@vger.kernel.org>; Thu, 09 Oct 2014 08:06:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <54366E5B.7010302@gmx.com>
References: <1412673336-13299-1-git-send-email-nrubinstein@aldebaran.com>
 <5433CE48.7060507@gmx.com> <CAOJKDvKapctTsiybo6aVKv9w-VUppXnNfqcQ=Cr03S3uX4-c9Q@mail.gmail.com>
 <5433D8DD.3090505@gmx.com> <CAOJKDvLgeipyRqK8Kwf8=fuz3QQYuzJV_kCEvgA-BJD7p5m_fg@mail.gmail.com>
 <54340BDD.7080405@gmx.com> <CAOJKDv+97LPMBJARpUSJ0en9NNDDuymSBWi_mJ+302AOSCdWaQ@mail.gmail.com>
 <54366E5B.7010302@gmx.com>
From: =?UTF-8?Q?No=C3=A9_RUBINSTEIN?= <nrubinstein@aldebaran.com>
Date: Thu, 9 Oct 2014 17:05:44 +0200
Message-ID: <CAOJKDv+905g8wqoqLKBrv=SL6FzOnPEs_ZR2xDTGCPAa_Mt--g@mail.gmail.com>
Subject: Re: [RFC PATCH] hwclock: --offset: Use offset instead of writing clock
To: JWP <elseifthen@gmx.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> Are you sure that drift factor (re)calculation does not happen if
> writing the Hardware Clock fails? I just had a quick look at the
> code and it seem that we do not test to see if write fails. So
> (re)calculation might work as is?

It does not seem to work the obvious way:

> [root@localhost ~]# date
> Thu Oct  9 14:56:30 UTC 2014
> [root@localhost ~]# hwclock --systohc --update
> hwclock: ioctl(RTC_SET_TIME) to /dev/rtc to set the time failed.: Invalid argument
> [root@localhost ~]# hwclock --get
> Thu Jan  8 05:12:51 1970  .543449 seconds

I will try to look into it.
