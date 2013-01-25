Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:6209 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756222Ab3AYRgZ (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Fri, 25 Jan 2013 12:36:25 -0500
Date: Fri, 25 Jan 2013 18:36:23 +0100
From: Karel Zak <kzak@redhat.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux-ng@vger.kernel.org
Subject: Re: fsck files w/relative paths
Message-ID: <20130125173623.GD1954@x2.net.home>
References: <201301201827.23141.vapier@gentoo.org>
 <20130125151736.GP27413@x2.net.home>
 <201301251202.02511.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201301251202.02511.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jan 25, 2013 at 12:02:01PM -0500, Mike Frysinger wrote:
> On Friday 25 January 2013 10:17:36 Karel Zak wrote:
> > On Sun, Jan 20, 2013 at 06:27:22PM -0500, Mike Frysinger wrote:
> > > we could tweak parse_argv() so that it checks for argv[0] == '.' in
> > > addition to argv[0] == '/'.  but that wouldn't fix other relative paths
> > > like: $ fsck images/foo
> > > $ fsck foo
> > 
> > Hmm... maybe add a hint to the fsck man page is the best solution :-)
> > 
> > > should we treat all non-options as devices ?  would that break anything ?
> > 
> > I don't think it's a good idea.
> > 
> > All unknown stuff is by default interpreted as filesystem specific options
> > (options for fsck.<type>) and it's pretty common that people don't use
> > "--" separator between fsck and fsck.<type> options.
> 
> well, i didn't mean non-fsck options, but non-options.  i.e. things that don't 

I understand..

> start with dashes.  are there fscks which use non-options as something other 
> than "file/device to check" ?

 fsck.ext4 -L bad_block_file  /dev/sda1

or whatever... and note that we have no clue about all possible fsck
implementations (not all is public and open source..)

> really, the fsck checking here is simply to determine whether it has to 
> automatically look up the root device and append that to the command line.  if 
> the user specified a file/device, then that shouldn't happen.  we could even 
> resort to doing a stat() on the non-options to see if it exists.

.. so because we have no clue about -L we will call stat() for
bad_block_file.

IMHO require absolute paths seems like a better solution :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
