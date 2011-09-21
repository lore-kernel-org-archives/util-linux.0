Return-Path: util-linux-owner@vger.kernel.org
Received: from e9.ny.us.ibm.com ([32.97.182.139]:38474 "EHLO e9.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751931Ab1IUWcr (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 21 Sep 2011 18:32:47 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p8LLvbUE022427
	for <util-linux@vger.kernel.org>; Wed, 21 Sep 2011 17:57:37 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p8LMWkEL210908
	for <util-linux@vger.kernel.org>; Wed, 21 Sep 2011 18:32:46 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p8LMWjB4005979
	for <util-linux@vger.kernel.org>; Wed, 21 Sep 2011 18:32:46 -0400
Date: Wed, 21 Sep 2011 15:32:42 -0700
From: Tim Pepper <lnxninja@linux.vnet.ibm.com>
To: "Ted Ts'o" <tytso@mit.edu>
Cc: Tim Pepper <tpepper@gmail.com>, util-linux@vger.kernel.org
Subject: Re: libuuid clock.txt fd leaks
Message-ID: <20110921223242.GE28823@tpepper-t61p.dolavim.us>
References: <CAHuv5K=UXH=vMZoCgYYvucACru5D8dLa91ufVeY2GJFFSv1ckw@mail.gmail.com>
 <20110921202620.GD4056@thunk.org>
 <CAHuv5Kn4eOjsm9JORpjWJjD15vUEmrOx5K_xzU+wie8f4Cx8AA@mail.gmail.com>
 <20110921222412.GA6654@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110921222412.GA6654@thunk.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed 21 Sep at 18:24:12 -0400 tytso@mit.edu said:
> 
> There are programs out there that generate literally tens of thousands
> of UUID's per second.

That's what I worried.  I figured you wouldn't have done this if that
weren't the case.  One can hope though right?  Perhaps for the use case
I'm looking at they don't need performance as much as they need the fd
not to leak.  We'll see...

-- 
Tim Pepper  <lnxninja@linux.vnet.ibm.com>
IBM Linux Technology Center
