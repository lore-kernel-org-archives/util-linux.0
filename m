Return-Path: util-linux-owner@vger.kernel.org
Received: from out03.mta.xmission.com ([166.70.13.233]:46411 "EHLO
	out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237AbcEDOsn (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 4 May 2016 10:48:43 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Linux Containers <containers@lists.linux-foundation.org>,
        util-linux@vger.kernel.org
References: <1462299656.16133.51.camel@HansenPartnership.com>
Date: Wed, 04 May 2016 09:38:03 -0500
In-Reply-To: <1462299656.16133.51.camel@HansenPartnership.com> (James
	Bottomley's message of "Tue, 03 May 2016 14:20:56 -0400")
Message-ID: <87oa8lc2ic.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: bind mounting namespace inodes for unprivileged users
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

James Bottomley <James.Bottomley@HansenPartnership.com> writes:

> Right at the moment, unprivileged users cannot call mount --bind to
> create a permanent copy of any of their namespaces.  This is annoying
> because it means that for entry to long running containers you have to
> spawn an undying process and use nsenter via the /proc/<pid>/ns files.
>
> The first question is:  assuming we restrict it to bind mounting only
> nsfs inodes, is there any reason an unprivileged user shouldn't be able
> to bind a namespace they've created to a file they own in the initial
> mount namespace?

Own, have read/write and unlink privileges.

My big concern would be the fact that a bind mount today makes a file
immune from unlink.  So it would mess up rm -rf.

That might not be worse than what a setuid fuse mount binary allows
today.

I wonder if there might is a way to setup a
user namespace and mount namespace combination so users could manage
mounts in their own login shells, just like is allowed in plan 9.
Long term I think that would be more satisfactory.


> So, does anyone have any strong (or even weak) opinions about this
> before I start coding patches?

The mount namespace is complex and getting it right is a pain in the
rear.  So adding yet another path and piece in to the existing
complexity makes me cringe a little.

Eric
