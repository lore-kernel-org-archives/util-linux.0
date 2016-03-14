Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:51805 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932557AbcCNX1b (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Mar 2016 19:27:31 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Stanislav Brabec <sbrabec@suse.cz>
Subject: Re: [PATCH] tests: add btrfs mount tests
Date: Tue, 15 Mar 2016 00:27:24 +0100
Cc: util-linux@vger.kernel.org
References: <56B0EEB2.1060707@suse.cz> <201603140220.47345.sweet_f_a@gmx.de> <56E6C863.2070909@suse.cz>
In-Reply-To: <56E6C863.2070909@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <201603150027.24650.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Monday 14 March 2016, Stanislav Brabec wrote:
> On Mar 14, 2016 at 02:20 Ruediger Meier wrote:
> > On Tuesday 02 February 2016, Stanislav Brabec wrote:
> > IMO this test needs some more error handling, see below.
> >
> >> +btrfs subvol create s2 >/dev/null
> >
> > For example if you comment out above line (or if it would fail)
> > then all subtests below still succeed. This can't be right.
>
> Well, it is a test suite for mount, not btrfs. I did not add any
> error checks in the code that creates the testing image.

> Grepping through the whole test suite, I see that more than a half of
> all tests do not check for mkfs failure. Here we just have a
> multi-line mkfs.
>
> It is possible to add a check for every command there, and fail the
> test if the command fails or returns something unexpected.

You are right. I've added already some lines to skip outdated 
btrfs-tools. Nethertheless both subtests succeed even when they operate 
on an empty device without any filesystem or subvolume.

Ideally a test should be skipped if the system is broken. But if we 
don't have "skip rules" implemented yet then it should better fail than 
succeed. 

I know that we have a lot of such issues in our test suite. Just 
commented this one because it was recently added and I've noticed  it 
on existing systems.

> >> +NON_DEFAULT_SUBVOLID=$(btrfs subvol list "$TS_MOUNTPOINT-create"
> >> |
>
> NON_DEFAULT_SUBVOLID will be empty.
>
> >> "subvolid=$NON_DEFAULT_SUBVOLID" +
>
> I am not sure how kernel will interpret subvolid=.

Maybe just log the btrfs return codes to TS_OUTPUT. If we see failure in 
real life then we know that something has to be fixed, either the skip 
rules or the code to create subvols.

cu,
Rudi
