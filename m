Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:1202 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751047AbaAOJzd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 15 Jan 2014 04:55:33 -0500
Date: Wed, 15 Jan 2014 10:55:28 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: Scott Moser <smoser@ubuntu.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] fix partx --update ranges and out of order tables
Message-ID: <20140115095528.GJ12700@x2.net.home>
References: <alpine.DEB.2.02.1401131526340.5329@brickies>
 <20140114085439.GF12700@x2.net.home>
 <52D54D09.10506@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52D54D09.10506@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jan 14, 2014 at 09:43:21AM -0500, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> > +blkid_partition get_partition_by_partno(blkid_partlist ls, int n)
> 
> I was wondering why libblkid didn't already have a function like this,
> should this be moved there instead of just being in partx.c?

 Yes, good point.
 
 I have moved the function to libblkid in the master branch (in the
 stable/v2.24 is the original Scott's version -- I don't want to
 change the API in x.y.1 releases). Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
