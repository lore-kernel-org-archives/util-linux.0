Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:52876 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750911AbaHSJSj (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 19 Aug 2014 05:18:39 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: kerolasa@gmail.com
Subject: Re: Regression test failure - tests/ts/ipcs/limits2
Date: Tue, 19 Aug 2014 11:18:36 +0200
Cc: Bruce Dubbs <bruce.dubbs@gmail.com>,
        "util-linux" <util-linux@vger.kernel.org>
References: <53F27C05.3090902@gmail.com> <CAG27Bk2fCSz9dt-N3F1yDQJt2JY1sSV4DTNuvpfVN5U=_5s3AQ@mail.gmail.com>
In-Reply-To: <CAG27Bk2fCSz9dt-N3F1yDQJt2JY1sSV4DTNuvpfVN5U=_5s3AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201408191118.36928.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 19 August 2014, Sami Kerola wrote:
> On 18 August 2014 23:19, Bruce Dubbs <bruce.dubbs@gmail.com> wrote:
> > When testing util-linux-2.25, I was suprised to get a test failure.
> > Running it down, I found tests/ts/ipcs/limits2 is doing:
> >
> > if [ $(</proc/sys/kernel/shmall) -ge $(bc <<<"2^64 / $PAGE_SIZE")
> > ];
> >
> > The problem is that starting with the 3.16 kernel the shmall value
> > is 18446744073692774399 which is the max value of an unsigned long
> > on a 64-bit system (UINT64_MAX).  Bash doesn't like this value and
> > says:
> >
> > "18446744073692774399: integer expression expected"
> >
> > I can work around this by setting shmall before running the test,
> > but there is a problem with either the test or in the kernel.
> >
> > I note that the kernel's shmmax value is also set to UINT64_MAX.
> >
> > What's the best way to approach this?
>
> Hi Bruce,
>
> I found the same.  The best way is to pull the most recent code from
> upstream git, and test it is no longer affected.
>
> https://github.com/karelzak/util-linux/commit/3a9ec12d6664527fad9c563
>47c88f3447d6c0856

BTW, woud be nice to fix that TODO finally. Since "ipcs -m" internally 
converts all these sizes to bytes we have to use large integer 
arithmetics somehow to have correct output at all.

cu,
Rudi
