Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54110 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935688AbdEZLVY (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 26 May 2017 07:21:24 -0400
Date: Fri, 26 May 2017 13:21:20 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: BUG: wipefs dry run
Message-ID: <20170526112120.kinsu7oi7fldx2o4@ws.net.home>
References: <201705101154.50099.sweet_f_a@gmx.de>
 <20170510103202.ssoqv7pzk5h2a24q@ws.net.home>
 <201705101303.10856.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201705101303.10856.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, May 10, 2017 at 01:03:10PM +0200, Ruediger Meier wrote:
> > It would be probably possible to extend libblkid to work in some
> > "ignore previous result" mode to to gather all permutation for the
> > FS/RAID/etc, but it won't be trivial task...
> 
> This would be nice.

Implemented (and it was relatively easy to implement :-)

Try "blkid-hide" branch from github, will be in v2.31.

# wipefs -a --no-act /dev/sdc
/dev/sdc: 8 bytes were erased at offset 0x00000200 (gpt): 45 46 49 20 50 41 52 54
/dev/sdc: 8 bytes were erased at offset 0x063ffe00 (gpt): 45 46 49 20 50 41 52 54
/dev/sdc: 2 bytes were erased at offset 0x000001fe (PMBR): 55 aa
/dev/sdc: calling ioctl to re-read partition table: Success

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
