Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:8159 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752700AbbC0OPE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 27 Mar 2015 10:15:04 -0400
Date: Fri, 27 Mar 2015 15:14:58 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: question about logger tests
Message-ID: <20150327141458.GN1749@ws.net.home>
References: <201503261450.33545.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201503261450.33545.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Mar 26, 2015 at 02:50:33PM +0100, Ruediger Meier wrote:
> Our logger tests fail if it can't connect to /dev/log. I'd like to fix 
> that case for the test-suite but have some questions:
> 
> 1. It was confusing for me to figure out the actual
>    problem. Maybe --no-act and/or --stderr should imply
>    that --socket-errors=auto turns error printing on?

Hmm.. probably good idea.

> 2. Alternatively we could use --socket-errors=on for all tests.
> 
> 3. Couldn't we fix --no-act to not need an open /dev/log at all?

But then it will introduce another fragility, complexity and
difference between test (--no-act) and non-test mode. I see for
example "if(ctl->fd < 0)" in code. Now it really skips write() only.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
