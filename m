Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59748 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754757Ab3ENN4R (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 14 May 2013 09:56:17 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4EDuGaO013489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 14 May 2013 09:56:17 -0400
Date: Tue, 14 May 2013 15:56:15 +0200
From: Karel Zak <kzak@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: ReFS
Message-ID: <20130514135615.GA13909@x2.net.home>
References: <20130514110316.GA17246@redhat.com>
 <20130514132707.GC17246@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130514132707.GC17246@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 14, 2013 at 02:27:07PM +0100, Richard W.M. Jones wrote:
> On Tue, May 14, 2013 at 12:03:16PM +0100, Richard W.M. Jones wrote:
> > ReFS is Microsoft's new filesystem used in Windows 2012 Server and
> > above.  There's no support for this in Linux (although I'm hoping to
> > change that) but it'd be nice if blkid could at least recognize it.
> > 
> > So I thought you might be interested in the filesystem signature for
> > ReFS, which appears to be in the first 8 bytes:
> > 
> > 00000000  00 00 00 52 65 46 53 00  00 00 00 00 00 00 00 00  |...ReFS.........|

 I have added this magic string to libblkid.

> After further research, I found some preliminary analysis:
> 
> http://libfslibs.googlecode.com/files/Resilient%20File%20System%20(ReFS).pdf

 Thanks.

> which is the best we have to go on so far.  There is no superblock as
> such, but there is a level 0 metadata block.  In any case that

 Yes, expected, I guess all is stored in some key-value DB (b-trees or
 so).

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
