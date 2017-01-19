Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49448 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752171AbdASMq6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 19 Jan 2017 07:46:58 -0500
Date: Thu, 19 Jan 2017 13:46:53 +0100
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux@vger.kernel.org
Subject: Re: stable/v2.29.1
Message-ID: <20170119124653.2tbsa7pmkpgv3bfl@ws.net.home>
References: <20170118131217.3kv7samrkbnxmqqr@ws.net.home>
 <e3ebe087-45ee-0afd-7e85-7a243be3c379@bernhard-voelker.de>
 <20170119113502.ykteazztzpd7eocs@ws.net.home>
 <f323282a-63cf-2b37-6241-5d29908c0bce@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f323282a-63cf-2b37-6241-5d29908c0bce@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jan 19, 2017 at 01:15:56PM +0100, Bernhard Voelker wrote:
> On 01/19/2017 12:35 PM, Karel Zak wrote:
> > On Thu, Jan 19, 2017 at 11:32:20AM +0100, Bernhard Voelker wrote:
> >> On 01/18/2017 02:12 PM, Karel Zak wrote:
> >>> The branch stable/v2.29 contains what I want to release as v2.29.1.
> >>
> >> General question:
> >> Is it worth dealing with maintenance branches in the upstream repo?
> >> I mean, downstream projects can cherry-pick fixes and improvements
> >> to their own needs anyway.  So I think having one upstream mainline
> >> would be sufficient.  WDYT?
> > 
> >  I use the branches to create maintenance releases (tarballs), e.g.
> >  v2.29.1.
> >  
> >  The goal is to minimize number of patches in downstream packages. So I
> >  guess downstream are happy to have .1 and .2 releases.
> 
> I see: as you're also downstream Redhat/Fedora maintainer, you're
> effectively doing the downstream work in the upstream repository and
> thus share this to other projects.  That's nice. ;-)

 another downstreams also collaborate on maintenance releases. For
 example right now we want to release 2.29.1 before Debian freeze :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
