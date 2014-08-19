Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f171.google.com ([209.85.192.171]:39134 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589AbaHSGJ4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 19 Aug 2014 02:09:56 -0400
Received: by mail-pd0-f171.google.com with SMTP id z10so9036400pdj.16
        for <util-linux@vger.kernel.org>; Mon, 18 Aug 2014 23:09:56 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <53F27C05.3090902@gmail.com>
References: <53F27C05.3090902@gmail.com>
Date: Tue, 19 Aug 2014 07:09:54 +0100
Message-ID: <CAG27Bk2fCSz9dt-N3F1yDQJt2JY1sSV4DTNuvpfVN5U=_5s3AQ@mail.gmail.com>
Subject: Re: Regression test failure - tests/ts/ipcs/limits2
From: Sami Kerola <kerolasa@iki.fi>
To: Bruce Dubbs <bruce.dubbs@gmail.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 18 August 2014 23:19, Bruce Dubbs <bruce.dubbs@gmail.com> wrote:
> When testing util-linux-2.25, I was suprised to get a test failure. Running
> it down, I found tests/ts/ipcs/limits2 is doing:
>
> if [ $(</proc/sys/kernel/shmall) -ge $(bc <<<"2^64 / $PAGE_SIZE") ];
>
> The problem is that starting with the 3.16 kernel the shmall value is
> 18446744073692774399 which is the max value of an unsigned long on a 64-bit
> system (UINT64_MAX).  Bash doesn't like this value and says:
>
> "18446744073692774399: integer expression expected"
>
> I can work around this by setting shmall before running the test, but there
> is a problem with either the test or in the kernel.
>
> I note that the kernel's shmmax value is also set to UINT64_MAX.
>
> What's the best way to approach this?

Hi Bruce,

I found the same.  The best way is to pull the most recent code from
upstream git, and test it is no longer affected.

https://github.com/karelzak/util-linux/commit/3a9ec12d6664527fad9c56347c88f3447d6c0856

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
