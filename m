Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:49397 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758453AbaHZPJ7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 26 Aug 2014 11:09:59 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: kerolasa@gmail.com
Subject: Re: Regression test failure - tests/ts/ipcs/limits2
Date: Tue, 26 Aug 2014 17:09:49 +0200
Cc: "util-linux" <util-linux@vger.kernel.org>, Karel Zak <kzak@redhat.com>
References: <53F27C05.3090902@gmail.com> <201408191118.36928.sweet_f_a@gmx.de> <CAG27Bk1JU6u7QHzg7HWsqqrQ5a=SDp7PdymYX-F3D1PvCSWftQ@mail.gmail.com>
In-Reply-To: <CAG27Bk1JU6u7QHzg7HWsqqrQ5a=SDp7PdymYX-F3D1PvCSWftQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201408261709.49994.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wednesday 20 August 2014, Sami Kerola wrote:
> On 19 August 2014 12:18, Ruediger Meier <sweet_f_a@gmx.de> wrote:
> > BTW, woud be nice to fix that TODO finally. Since "ipcs -m"
> > internally converts all these sizes to bytes we have to use large
> > integer arithmetics somehow to have correct output at all.
>
> Hi Rudi and others,
>
> I agree, it would be nice to be precise about sizes.  But should
> util-linux have a lib/bigint.c or something similar to avoid
> dependency to external infinite precision implementation[1]?
>
> By glance there are some examples how to write bigint from scratch. 
> And the examples are more or less directly advising against
> re-inventing the wheel.  My feeling is that use of existing bigint
> implementation would be good decision, but one has to be able to
> disable the dependency when needed.  I am guessing distributors who
> bootstrap systems would prefer that sort of setup.
>
> Comments, opinions?

@Karel
Maybe you could re-open the issue on github to not forget about it.
https://github.com/karelzak/util-linux/issues/51

cu,
Rudi
