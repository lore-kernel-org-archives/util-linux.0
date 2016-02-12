Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:53691 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751204AbcBLQXM (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 12 Feb 2016 11:23:12 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0MBIAz-1aKfhz0SiD-00AEIw for
 <util-linux@vger.kernel.org>; Fri, 12 Feb 2016 17:23:10 +0100
To: util-linux@vger.kernel.org
Subject: Re: [PATCH] tests: add test for loop option in fstab
From: Ruediger Meier <sweet_f_a@gmx.de>
Date: Fri, 12 Feb 2016 17:23:09 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <201602121723.09217.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Friday 12 February 2016 at 16:55, you wrote:
> Ruediger Meier wrote:
> > On Thursday 11 February 2016, Stanislav Brabec wrote:
> >> Add a new fstab tests which check loop mount of the same source
> >> multiple times in multiple steps.
> >>
> >> The test is currently failing, but it should not fail once the
> >> triggering bug will be fixed.
> >
> > Will this be fixed quickly? Otherwise we should add
> >    TS_KNOWN_FAIL="yes"
> > to the test. Then you would still see it in the build log and test
> > diff but it wouldn't bother you with build error.
>
> This statement was valid in the time of sending the patch. Karel
> promptly fixed it, so the fix appeared in the main tree even one
> commit earlier:

Ah sorry I've missed that. The test fails for me because of another 
minor problem. I'll send a patch.

cu,
Rudi
