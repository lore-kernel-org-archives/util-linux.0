Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f171.google.com ([209.85.192.171]:40581 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327AbaHTLkx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 20 Aug 2014 07:40:53 -0400
Received: by mail-pd0-f171.google.com with SMTP id z10so11716591pdj.2
        for <util-linux@vger.kernel.org>; Wed, 20 Aug 2014 04:40:49 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <201408191118.36928.sweet_f_a@gmx.de>
References: <53F27C05.3090902@gmail.com>
	<CAG27Bk2fCSz9dt-N3F1yDQJt2JY1sSV4DTNuvpfVN5U=_5s3AQ@mail.gmail.com>
	<201408191118.36928.sweet_f_a@gmx.de>
Date: Wed, 20 Aug 2014 14:40:49 +0300
Message-ID: <CAG27Bk1JU6u7QHzg7HWsqqrQ5a=SDp7PdymYX-F3D1PvCSWftQ@mail.gmail.com>
Subject: Re: Regression test failure - tests/ts/ipcs/limits2
From: Sami Kerola <kerolasa@iki.fi>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Bruce Dubbs <bruce.dubbs@gmail.com>,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 19 August 2014 12:18, Ruediger Meier <sweet_f_a@gmx.de> wrote:
> BTW, woud be nice to fix that TODO finally. Since "ipcs -m" internally
> converts all these sizes to bytes we have to use large integer
> arithmetics somehow to have correct output at all.

Hi Rudi and others,

I agree, it would be nice to be precise about sizes.  But should
util-linux have a lib/bigint.c or something similar to avoid dependency
to external infinite precision implementation[1]?

By glance there are some examples how to write bigint from scratch.  And
the examples are more or less directly advising against re-inventing the
wheel.  My feeling is that use of existing bigint implementation would be
good decision, but one has to be able to disable the dependency when
needed.  I am guessing distributors who bootstrap systems would prefer
that sort of setup.

Comments, opinions?

[1] https://gmplib.org/

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
