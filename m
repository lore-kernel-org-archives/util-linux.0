Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46496 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753803AbcJZKrQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 26 Oct 2016 06:47:16 -0400
Date: Wed, 26 Oct 2016 12:47:13 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: libfdisk show stopper on i586?
Message-ID: <20161026104713.chfwao7rbnxbxkdv@ws.net.home>
References: <201610260000.12844.sweet_f_a@gmx.de>
 <201610261153.51698.sweet_f_a@gmx.de>
 <20161026101916.4f3d2u3xwmekfpjs@ws.net.home>
 <201610261227.55777.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201610261227.55777.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Oct 26, 2016 at 12:27:55PM +0200, Ruediger Meier wrote:
> On Wednesday 26 October 2016, Karel Zak wrote:
> > On Wed, Oct 26, 2016 at 11:53:51AM +0200, Ruediger Meier wrote:
> > > commit 8430b9b88426eb3c273b02a2d9505d839913317c
> > > Author: Karel Zak <kzak@redhat.com>
> > > Date:   Tue Oct 25 13:41:10 2016 +0200
> > >
> > >     libfdisk: make script token parser more robust
> >
> > Strange, don't see relation between the script parser and fdisk -l.
> > Do you have LIBFDISK_DEBUG output?
> >
> >     Karel
> 
> 
> [   65s] +14318: libfdisk:     INIT: library debug mask: 0xffff
> [   65s] +Available "LIBFDISK_DEBUG=<name>[,...]|<mask>" debug masks:

Can you send me the disk image? dd(1) + gzip, it's full of zeros, so
it should be relatively small.

Do you see something strange when you use parted for the disk?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
