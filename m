Return-Path: util-linux-owner@vger.kernel.org
Received: from li9-11.members.linode.com ([67.18.176.11]:38575 "EHLO
	test.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754880Ab2C0Snt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 27 Mar 2012 14:43:49 -0400
Date: Tue, 27 Mar 2012 11:43:45 -0700
From: "Ted Ts'o" <tytso@mit.edu>
To: Michael Conrad <mconrad@intellitree.com>
Cc: util-linux@vger.kernel.org
Subject: Re: blkid -o value
Message-ID: <20120327184345.GA11236@thunk.org>
References: <4F71F836.4000103@intellitree.com>
 <20120327173149.GC10142@thunk.org>
 <4F71FE73.9010208@intellitree.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F71FE73.9010208@intellitree.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 27, 2012 at 01:52:51PM -0400, Michael Conrad wrote:
> 
> I see how that could be useful if and only if you use exactly one
> "-s", but if you requested more than one "-s" they still come out in
> non-stable order.  It's like running a SQL query and having all the
> columns shifted because the first one was a NULL.  

Actually, it's more like running an SQL query without a SORTED BY and
assuming the order of the rows was stable.

> At the very least, I would appreciate it if the man page mentioned
> that "-o value" should only ever be used with exactly one "-s".

What I would suggest is that blkid explicitly state that the order of
fields or file systems (if more than one file system is selected) is
not defined, since that's something which is true in general, and not
just for "-o value".

It might also be useful to have an EXAMPLES section which gives some
sample ways that blkid can be used.

Regards,

						- Ted
