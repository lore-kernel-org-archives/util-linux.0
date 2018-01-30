Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751219AbeA3Kuv (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 30 Jan 2018 05:50:51 -0500
Date: Tue, 30 Jan 2018 11:50:48 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/7] fixes for fsck.cramfs and other things
Message-ID: <20180130105048.pbqfqpu5zvjwe5q4@ws.net.home>
References: <20180123155928.7629-1-sweet_f_a@gmx.de>
 <20180124121655.v5pr5wetsezlsa77@ws.net.home>
 <201801241547.57246.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201801241547.57246.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 24, 2018 at 03:47:57PM +0100, Ruediger Meier wrote:
> On Wednesday 24 January 2018, Karel Zak wrote:
> > On Tue, Jan 23, 2018 at 04:59:21PM +0100, Ruediger Meier wrote:
> > > From: Ruediger Meier <ruediger.meier@ga-group.nl>
> > >
> > > Ruediger Meier (6):
> > >   Revert "fsck.cramfs: Fix bus error on broken file system."
> > >   fsck.cramfs: fix crash when superblock size is too small
> > >   tests: rewrite fsck-bad-header
> >
> > Nice.
> >
> > >   fsck.cramfs: fix error message
> 
> BTW while we are at this. I wonder why we have 3 different ways 
> (fallbacks) in fsck.cramfs.c test_crc() how to read the image.
> 
> 1. mmap
> 2. read into anonymous mmap
> 3. read blockwise
> 
> Does anybody knows why is this and whether we still need all these 
> fallbacks?

The question is why we need mmap at all here;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
