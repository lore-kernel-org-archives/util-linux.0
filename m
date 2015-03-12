Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:63603 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750726AbbCLJKx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 12 Mar 2015 05:10:53 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx001)
 with ESMTPSA (Nemesis) id 0MN1j6-1YcYi23eZM-006jIF for
 <util-linux@vger.kernel.org>; Thu, 12 Mar 2015 10:10:50 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: Re: prevent cal segfault
Date: Thu, 12 Mar 2015 10:10:49 +0100
References: <20150312084639.GC9756@laura.suse.cz>
In-Reply-To: <20150312084639.GC9756@laura.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201503121010.49968.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 12 March 2015, Petr Gajdos wrote:
> Hello,
>
> cal utility segfaults in putp() when setupterm() fails as cal
> insufficiently checks for setupterm() failure.
>
> $ TERM= cal
> Segmentation fault

Regarding TERM there is another issue with "more".

$ TERM= make check TS_OPTS="--parallel=1 more" 
  more: regexp                   ... FAILED (more/regexp)
  more: squeeze                  ... OK


Without TERM it prints a '\r' because of text-utils/more.c:1083:
void kill_line(void)
{
        erasep(0);
        if (!eraseln || dumb)
                putchar('\r');
}


cu,
Rudi
