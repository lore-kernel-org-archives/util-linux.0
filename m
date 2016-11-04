Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754700AbcKDKjd (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 4 Nov 2016 06:39:33 -0400
Date: Fri, 4 Nov 2016 11:39:31 +0100
From: Karel Zak <kzak@redhat.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: util-linux@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH 2/4] lsmem: new tool
Message-ID: <20161104103931.dvhnyuyjhb4ykyw7@ws.net.home>
References: <20161012120047.60732-1-heiko.carstens@de.ibm.com>
 <20161012120047.60732-3-heiko.carstens@de.ibm.com>
 <20161103120059.75nflzf5wvepafzu@ws.net.home>
 <20161103161948.GA12234@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161103161948.GA12234@osiris>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Nov 03, 2016 at 05:19:48PM +0100, Heiko Carstens wrote:
> On Thu, Nov 03, 2016 at 01:00:59PM +0100, Karel Zak wrote:
> > On Wed, Oct 12, 2016 at 02:00:45PM +0200, Heiko Carstens wrote:
> > > RANGE                                 SIZE STATE   REMOVABLE BLOCK
> > > 0x0000000000000000-0x000000005fffffff 1,5G online  yes       0-5
> > > 0x0000000060000000-0x000000007fffffff 512M online  no        6-7
> > > 0x0000000080000000-0x000000013fffffff   3G online  yes       8-19
> > > 0x0000000140000000-0x000000014fffffff 256M offline -         20
> > > 0x0000000150000000-0x000000017fffffff 768M online  no        21-23
> > > 
> > > Memory block size   :     256M
> > > Total online memory :     5,8G
> > > Total offline memory:     256M
> > 
> > It seems that for backward compatibility we need the summary lines at
> > the end. Maybe we can add --no-summary and --summary-only for people
> > who want to use it in the scripts.
> 
> Scripts should use the --parsable option (or one of the new options you
> mentioned below), no?

Yes, good point.

> However it's of course fine with me to make the summary lines optional.

I have added --summary[=never,always,only]

    never  - disable summary lines at all (forced for parsable  outputs)
    always - default for standard output
    only   - prints only summary, no table with blocks, default when
             --summary specified without argument

> Also fine with me :) Thank you for taking care of this!

    https://github.com/karelzak/util-linux/tree/mem-tools

This branch contains the new lsmem; the next week I'll cleanup chmem 
and merge it to the master branch (after v2.29 release, probably
Monday).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
