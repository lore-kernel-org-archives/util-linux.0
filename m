Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:61677 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935494AbcCQKf1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 17 Mar 2016 06:35:27 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Benno Schulenberg <bensberg@justemail.net>
Subject: Re: cancelling the tests says that they all passed
Date: Thu, 17 Mar 2016 11:35:19 +0100
Cc: "Util-Linux" <util-linux@vger.kernel.org>
References: <1458207847.751745.551787010.6EE6554F@webmail.messagingengine.com>
In-Reply-To: <1458207847.751745.551787010.6EE6554F@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201603171135.19679.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 17 March 2016, Benno Schulenberg wrote:
> When one hits ^C when the compilation phase of 'make check'
> finishes and the first tests start executing, the script prints

I don't manage to reproduce that. How do you run make exactly (-j)?
If I hit ctrl-C during compilation then the test script does not start 
at all. Maybe there is a dependency problem and your tests start before 
compilation is finished?

>   All 177 tests PASSED

This is because the test script actually means this

  "None of 177 available tests failed"

It does not count the executed tests but failures only.

> before aborting.  That... doesn't seem quite right.

I've had already planned to improve/refactor the failure/success 
counting and also the handling of broken/aborted scripts. Probably this 
would also improve such cosmetical issues.

But this is something for the next release. Would be too risky to change 
something just a few days before releasing 2.28.


> When I leave the tests to run to completion, it says:
>
>   4 tests of 177 FAILED
>
> The failed ones are these:
>
>          ipcs: mk-rm-shm                                     ...
> FAILED (ipcs/mk-rm-shm) misc: fallocate                              
>       ... FAILED (misc/fallocate) misc: swaplabel                    
>                 ... FAILED (misc/swaplabel) misc: ul                 
>                           ... FAILED (misc/ul)
>



Could you show us the test diffs?
$ find tests/diff/ -type f | xargs -r cat

Maybe also warnings durning the test run (if any).

cu,
Rudi
