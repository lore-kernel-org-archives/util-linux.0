Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34369 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757369Ab2C1JAo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 28 Mar 2012 05:00:44 -0400
Date: Wed, 28 Mar 2012 11:00:38 +0200
From: Karel Zak <kzak@redhat.com>
To: "Ted Ts'o" <tytso@mit.edu>
Cc: Michael Conrad <mconrad@intellitree.com>, util-linux@vger.kernel.org
Subject: Re: blkid -o value
Message-ID: <20120328090038.GB2045@x2.net.home>
References: <4F71F836.4000103@intellitree.com>
 <20120327173149.GC10142@thunk.org>
 <4F71FE73.9010208@intellitree.com>
 <20120327184345.GA11236@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120327184345.GA11236@thunk.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 27, 2012 at 11:43:45AM -0700, Ted Ts'o wrote:
> On Tue, Mar 27, 2012 at 01:52:51PM -0400, Michael Conrad wrote:
> > 
> > I see how that could be useful if and only if you use exactly one
> > "-s", but if you requested more than one "-s" they still come out in
> > non-stable order.  It's like running a SQL query and having all the
> > columns shifted because the first one was a NULL.  
> 
> Actually, it's more like running an SQL query without a SORTED BY and
> assuming the order of the rows was stable.
> 
> > At the very least, I would appreciate it if the man page mentioned
> > that "-o value" should only ever be used with exactly one "-s".
> 
> What I would suggest is that blkid explicitly state that the order of
> fields or file systems (if more than one file system is selected) is
> not defined, since that's something which is true in general, and not
> just for "-o value".
> 
> It might also be useful to have an EXAMPLES section which gives some
> sample ways that blkid can be used.

 Good idea. I'll update the man page.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
