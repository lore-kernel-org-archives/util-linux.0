Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:20331 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753016Ab1JJNDw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 10 Oct 2011 09:03:52 -0400
Date: Mon, 10 Oct 2011 15:03:49 +0200
From: Karel Zak <kzak@redhat.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/6] lscpu: change column names back to mixed case
Message-ID: <20111010130348.GD17242@nb.net.home>
References: <1318237184-6616-1-git-send-email-heiko.carstens@de.ibm.com> <1318237184-6616-4-git-send-email-heiko.carstens@de.ibm.com> <20111010105945.GA17242@nb.net.home> <20111010111321.GA6695@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111010111321.GA6695@osiris.boeblingen.de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 10, 2011 at 01:13:21PM +0200, Heiko Carstens wrote:
> On Mon, Oct 10, 2011 at 12:59:45PM +0200, Karel Zak wrote:
> > On Mon, Oct 10, 2011 at 10:59:41AM +0200, Heiko Carstens wrote:
> > > Commit b9d18bc3 "lscpu: add column names to --help" changed all column names
> > > to upper case only and printed the column names for the parsable output in
> > > lower case.
> > 
> > This is bug. Sorry.
> > 
> > > However current behaviour was that for the parsable output the column names
> > > were printed in mixed case. The change might break existing other tools and
> > > breaks also the util-linux internal lscpu tests.
> > > So revert part of the above commit and restore the old behaviour.
> > 
> > It would be better to fix the code (upper case for the first letter)
> > than revert the patch.
> 
> I wanted to... but there is the special case "CPU" which was all upper case
> already before :/
> And adding special case handling in code sucks a bit, no?

 Oh, good point :-)

> > I think that we want to use the same concept for column names in all
> > utils (findmnt, lsblk, ...) where we use upper case in help, man pages
> > and all outputs. 
> > 
> > The old parsable output is exception, the new -e output should be
> > compatible with the rest of util-linux.
> > 
> > I will fix it. Thanks.
> 
> Ok, will you update the (new) lscpu man page needs to be changed as well then.
> I can send an update if you want.

 I'll update the man page.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
