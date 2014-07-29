Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:30252 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223AbaG2G1Z (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 29 Jul 2014 02:27:25 -0400
Date: Tue, 29 Jul 2014 08:27:18 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: kerolasa@gmail.com, Util-Linux <util-linux@vger.kernel.org>
Subject: Re: hwclock --compare segfaults when run as normal user
Message-ID: <20140729062718.GN8533@x2.net.home>
References: <1406378420.29449.145898149.3B1EDA38@webmail.messagingengine.com>
 <CAG27Bk2SkstBkDGR9EiP0UENK1qag0VZ31tLZsjvgCxRss2bpw@mail.gmail.com>
 <1406390709.8686.145937949.0F0BF57C@webmail.messagingengine.com>
 <20140728111214.GI8533@x2.net.home>
 <1406573448.201539.146573889.3D4D553B@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406573448.201539.146573889.3D4D553B@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 28, 2014 at 08:50:48PM +0200, Benno Schulenberg wrote:
> 
> On Mon, Jul 28, 2014, at 13:12, Karel Zak wrote:
> >  I have no way how to to test it, but can you try the patch below?
> > [...]
> >  
> > +	if (ur->get_permissions())
> > +		return EX_NOPERM;
> > +
> 
> Yes, looks better now:
> 
> $ ./hwclock --compare
> hwclock: unable to get I/O port access:  the iopl(3) call failed.: Operation not permitted
> hwclock: Probably you need root privileges.

 Applied, thanks.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
