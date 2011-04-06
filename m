Return-Path: util-linux-owner@vger.kernel.org
Received: from hapkido.dreamhost.com ([66.33.216.122]:49974 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755986Ab1DFOXf (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Wed, 6 Apr 2011 10:23:35 -0400
Received: from homiemail-a37.g.dreamhost.com (mailbigip.dreamhost.com [208.97.132.5])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 611A417A3E4
	for <util-linux-ng@vger.kernel.org>; Wed,  6 Apr 2011 07:23:35 -0700 (PDT)
Subject: Re: [PATCH 3/3] mkfs.minix: add support for minix3 fs
From: Davidlohr Bueso <dave@gnu.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux-ng <util-linux-ng@vger.kernel.org>
In-Reply-To: <20110406083627.GA6491@nb.net.home>
References: <1301583579.2159.17.camel@offworld>
	 <20110406083627.GA6491@nb.net.home>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 06 Apr 2011 11:22:40 -0300
Message-ID: <1302099760.2142.3.camel@offworld>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, 2011-04-06 at 10:36 +0200, Karel Zak wrote:
> On Thu, Mar 31, 2011 at 11:59:38AM -0300, Davidlohr Bueso wrote:
> >  #define INODE_SIZE (sizeof(struct minix_inode))
...
> 
>  Oh.. Davidlohr, you forgot regression test ;-) What about to add
>     
>         mkfs.minix -{1,2,3}
> 
>  to tests/ts/minix/mkfs{1,2,3} ?
> 
>  It would be also nice to add MINIX3_SUPER_MAGIC to fsck.minix and
>  print a warning that v3 is unsupported (yet?).

I had a feeling you would dislike the sloppy code (which was already a
part of mkfs.minix), so heck, let's invade it massively, like partx.
Like you mention, we need to go through several patches, which I will be
sending you over the next few days, this way it might be a bit easier to
merge.

Thanks,
Davidlohr

