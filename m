Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43098 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756686AbeEJKZu (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 10 May 2018 06:25:50 -0400
Date: Thu, 10 May 2018 12:25:46 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: Dan Mick <dmick@redhat.com>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: lsblk '--allcols'
Message-ID: <20180510102546.lub3dz6r77hyhk75@ws.net.home>
References: <cf949a43-9027-de52-87e2-33c95605d58b@redhat.com>
 <CAG27Bk3m7PYCMtMMV0pVAZpmMJGsGWUk0KFfpT=KD80U4QQ5ug@mail.gmail.com>
 <20180423094628.4x3qhf7ah5gazz7z@ws.net.home>
 <alpine.LNX.2.20.1804242230510.12936@imuri>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.20.1804242230510.12936@imuri>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 24, 2018 at 10:38:02PM +0100, Sami Kerola wrote:
> On Mon, 23 Apr 2018, Karel Zak wrote:
> > On Sat, Apr 21, 2018 at 09:14:03AM +0100, Sami Kerola wrote:
> > > If I see right the --output-all could be added to these utilities: fdisk,
> > > fincore, findmnt, losetup, lscpu, lsipc, lslocks, lslogins, lsmem, lsns,
> > > partx, prlimit, rfkill, sfdisk, swapon, uuidparse, wdctl, wipefs, and
> > > zramctl.
> > 
> > Good idea. (Your) patches are welcomed :-)
> 
> Here's some.  I skipped couple commands, they either already listing all 
> columns or are unlikely to be used for info listing (fdisk, wipefs, ...)
> 
> Due the tiring repetativeness in these changes I won't send send these to 
> maillist. Please fetch from my remote to review & merge.

Merged, maybe next time you can use "pull request" git hub feature ;-)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
