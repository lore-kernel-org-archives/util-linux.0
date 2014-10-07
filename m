Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:53632 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754230AbaJGPu7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 7 Oct 2014 11:50:59 -0400
Message-ID: <54340BDD.7080405@gmx.com>
Date: Tue, 07 Oct 2014 11:50:53 -0400
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

Are you sure that drift factor (re)calculation does not happen if
writing the Hardware Clock fails? I just had a quick look at the
code and it seem that we do not test to see if write fails. So
(re)calculation might work as is?
