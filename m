Return-Path: util-linux-owner@vger.kernel.org
Received: from imap.thunk.org ([74.207.234.97]:39739 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751341AbbLDWRZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 4 Dec 2015 17:17:25 -0500
Date: Fri, 4 Dec 2015 17:17:20 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "U.Mutlu" <for-gmane@mutluit.com>
Cc: util-linux@vger.kernel.org
Subject: Re: fsck memory leak
Message-ID: <20151204221720.GD18359@thunk.org>
References: <n3rei3$8l3$1@ger.gmane.org>
 <20151204151927.GA3548@thunk.org>
 <n3sjvh$ib8$1@ger.gmane.org>
 <20151204195848.GA18359@thunk.org>
 <n3st78$77b$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <n3st78$77b$1@ger.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Dec 04, 2015 at 09:31:36PM +0100, U.Mutlu wrote:
> 
> I think it's a double-edged sword: if user has less memory then
> the integrated caching will IMO degrade the performance.

You're wrong.

> Btw, why does my "free" command not have the "available" column?
> Or did you use a different tool for the above outputs?

Probably because you're using an older version of procps.  The
difference is between 2:3.3.9-9 and 2:3.3.10-2 (which recently entered
Debian testing).

The older version of free has a "-/+ buffers/cache" line, and the Free
entry in the "-/+ buffer/cache" line is equivalent to the available
line.  So you're version of free looks like this:

             total       used       free     shared    buffers     cached
Mem:           15G       7.1G       8.2G       421M       303M       1.6G
-/+ buffers/cache:       5.2G   ===> 10G <===
Swap:           0B         0B         0B

							- Ted
















;



> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
