Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:50244 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887AbbDBXLG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 2 Apr 2015 19:11:06 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: question about logger tests
Date: Fri, 3 Apr 2015 00:10:57 +0100
Cc: util-linux@vger.kernel.org
References: <201503261450.33545.sweet_f_a@gmx.de> <20150327141458.GN1749@ws.net.home>
In-Reply-To: <20150327141458.GN1749@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201504030110.58092.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Friday 27 March 2015, Karel Zak wrote:
> On Thu, Mar 26, 2015 at 02:50:33PM +0100, Ruediger Meier wrote:
> > Our logger tests fail if it can't connect to /dev/log. I'd like to
> > fix that case for the test-suite but have some questions:
> >
> > 1. It was confusing for me to figure out the actual
> >    problem. Maybe --no-act and/or --stderr should imply
> >    that --socket-errors=auto turns error printing on?
>
> Hmm.. probably good idea.

I'll send a patch.

> > 2. Alternatively we could use --socket-errors=on for all tests.
> >
> > 3. Couldn't we fix --no-act to not need an open /dev/log at all?
>
> But then it will introduce another fragility, complexity and
> difference between test (--no-act) and non-test mode. I see for
> example "if(ctl->fd < 0)" in code. Now it really skips write() only.

You are right. If there would be a real-life use case for --no-act then 
not connecting /dev/log could be an optimization but I guess there is 
no such use case except our tests.

So how could we skip logger tests safely if /dev/log does not work?

cu,
Rudi


