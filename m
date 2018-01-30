Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49350 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751408AbeA3KfR (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 30 Jan 2018 05:35:17 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4B9E45414C
        for <util-linux@vger.kernel.org>; Tue, 30 Jan 2018 10:35:17 +0000 (UTC)
Received: from ws.net.home (ovpn-117-78.ams2.redhat.com [10.36.117.78])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B060470902
        for <util-linux@vger.kernel.org>; Tue, 30 Jan 2018 10:35:16 +0000 (UTC)
Date: Tue, 30 Jan 2018 11:35:14 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH] mount(8): drop redundant filesystem-specific sections
Message-ID: <20180130103514.ldln4nauocjs3n23@ws.net.home>
References: <20180119184520.13067-1-vapier@gentoo.org>
 <20180122090923.io62zeuwnv25iw7p@ws.net.home>
 <20180125042426.GE1718@vapier>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180125042426.GE1718@vapier>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 24, 2018 at 11:24:26PM -0500, Mike Frysinger wrote:
> On 22 Jan 2018 10:09, Karel Zak wrote:
> > On Fri, Jan 19, 2018 at 01:45:20PM -0500, Mike Frysinger wrote:
> > > Add a new section to the top of the filesystem-specific chapter to point
> > > people generally to the filesystem-specific man pages.  This way we can
> > > delete all the redundant subsections that say the same thing.
> > 
> > Well, the subsections also provides the name of the package where is FS
> > specific man page :-)
> > 
> > > -.SS "Mount options for xfs"
> > > -See the options section of the
> > > -.BR xfs (5)
> > > -man page (the xfsprogs package must be installed).
> > 
> > It's probably not so important (and I have no strong opinion about
> > it), but I can imagine that for end-users it's useful. Maybe we can
> > add to the man page a small table with FS name, man page and package
> > name:
> > 
> >       xfs   xfs(5)          xfsprogs
> >       ext4  ext4(5)         e2fsprogs
> >       cifs  mount.cifs(8)   cifs-utils
> >       ...
> > 
> > or is it overkill?
> 
> the only reason i hesitated to try and do that was due to cross-distro
> package naming idiosyncrasies.  but i guess if we refer to the upstream

Good point.

> project using the name they choose, the rest can be an exercise for the
> user ?

Let's ignore this for now. I think the description at the begin of the
section is good enough for now. We'll see :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
