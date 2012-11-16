Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54276 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751480Ab2KPJgT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 16 Nov 2012 04:36:19 -0500
Date: Fri, 16 Nov 2012 10:36:15 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
Subject: Re: new mount regression
Message-ID: <20121116093615.GA20338@x2.net.home>
References: <50A3F95E.6030407@gmail.com>
 <20121114231031.GB20303@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121114231031.GB20303@altlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Nov 15, 2012 at 03:10:31AM +0400, Dmitry V. Levin wrote:
> > Also new mount understands fstype list in options:
> > 
> > $ mount -t vfat,hfsplus,ext4,ext3,ext2 /dev/loop0 /media
> 
> Already reported with a patch in
> http://marc.info/?l=util-linux-ng&m=134876452206541
> The patch was labelled a hack and rejected in
> http://marc.info/?l=util-linux-ng&m=134910609108013
> but no better alternative is available so far.

 I have applied the Gleb's patch as I did not found a better
 (less invasive) solution.

 Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
