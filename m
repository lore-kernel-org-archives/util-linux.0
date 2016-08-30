Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:32826 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753327AbcH3KYH (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 30 Aug 2016 06:24:07 -0400
Date: Tue, 30 Aug 2016 12:24:05 +0200
From: Karel Zak <kzak@redhat.com>
To: Xen <list@xenhideout.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: PV on disk without partitions not recognised as LVM2_member
Message-ID: <20160830102405.kdjfewm4dik3msgf@ws.net.home>
References: <c3d87222fe4f87eed72f61b6bc501344@dds.nl>
 <20160819111429.4rsuedff24inn4gu@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160819111429.4rsuedff24inn4gu@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Aug 19, 2016 at 01:14:29PM +0200, Karel Zak wrote:
> On Thu, Aug 18, 2016 at 10:39:30PM +0200, Xen wrote:
> > Would someone be will to fix the issue that a Physical Volume from LVM2 (PV)
> > when placed directly on disk (no partitions or partition tables) will not be
> 
> This is very unusual setup, but according to feedback from LVM guys
> it's supported, so I will improve blkid to support it too.

Fixed in the git tree (for the next v2.29). Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
