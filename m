Return-Path: util-linux-owner@vger.kernel.org
Received: from li9-11.members.linode.com ([67.18.176.11]:56274 "EHLO
	test.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750964Ab1IUWYO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 21 Sep 2011 18:24:14 -0400
Date: Wed, 21 Sep 2011 18:24:12 -0400
From: "Ted Ts'o" <tytso@mit.edu>
To: Tim Pepper <tpepper@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: libuuid clock.txt fd leaks
Message-ID: <20110921222412.GA6654@thunk.org>
References: <CAHuv5K=UXH=vMZoCgYYvucACru5D8dLa91ufVeY2GJFFSv1ckw@mail.gmail.com>
 <20110921202620.GD4056@thunk.org>
 <CAHuv5Kn4eOjsm9JORpjWJjD15vUEmrOx5K_xzU+wie8f4Cx8AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHuv5Kn4eOjsm9JORpjWJjD15vUEmrOx5K_xzU+wie8f4Cx8AA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Sep 21, 2011 at 03:02:48PM -0700, Tim Pepper wrote:
> Is the original optimization really needed?  If not you avoid the whole
> problem...no static, no TLS, no fd left open.

> I wonder who would whinge on performance if the open/close simply
> happened everytime?  Ie: remove initial state_fd=-2 and its associated
> special casing.

There are programs out there that generate literally tens of thousands
of UUID's per second.  One example of such a program filed high
priority bugs with both RHEL and SLES because it wasn't fast enough
and the uuid library was slowing down the setup time of an
commercially important Enterprise Resource Planning product by hours.

The reason why I implemented uuidd was specifically to help out this
product and this company.  Partially because it was economically
important to Red Hat, SLES, and IBM (who was my employer at the time),
and partially because I had a soft spot for this company, to which I had
helped add Kerberos authentication and was very supportive of Linux in
the mid 1990's, before Linux had been discovered by big business.

But yeah, there are people and companies who really care about
libuuid's performance.

    	  	    	       	      	   - Ted
