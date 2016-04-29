Return-Path: util-linux-owner@vger.kernel.org
Received: from h2.hallyn.com ([78.46.35.8]:47184 "EHLO h2.hallyn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752475AbcD2VuD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 29 Apr 2016 17:50:03 -0400
Date: Fri, 29 Apr 2016 16:50:01 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: "W. Trevor King" <wking@tremily.us>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        systemd-devel@lists.freedesktop.org, util-linux@vger.kernel.org
Subject: Re: Unprivileged containers and co-ordinating user namespaces
Message-ID: <20160429215001.GB13615@mail.hallyn.com>
References: <1461880928.2307.48.camel@HansenPartnership.com>
 <20160428230045.GS22888@odin.tremily.us>
 <1461944328.2311.10.camel@HansenPartnership.com>
 <20160429155303.GA8900@mail.hallyn.com>
 <20160429183404.GE22888@odin.tremily.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160429183404.GE22888@odin.tremily.us>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Quoting W. Trevor King (wking@tremily.us):
> On Fri, Apr 29, 2016 at 10:53:03AM -0500, Serge E. Hallyn wrote:
> > Quoting James Bottomley:
> > > I think that mostly works.  No-one's packaging it yet, which is why I
> > 
> > https://packages.debian.org/jessie/uidmap
> > https://launchpad.net/ubuntu/yakkety/+package/uidmap
> > http://rpm.pbone.net/index.php3/stat/45/idpl/28763248/numer/1/nazwa/newuidmap
> 
> On the other hand, Gentoo is waiting on a clean release tarball [1].
> It looks like 4.3-1 was missing a clean autoreconf [2]?  Has anything
> been pushed since?

Nope, I've not had time to push it and noone has offered a patch.

Maybe I'll find time next week.

> Cheers,
> Trevor
> 
> [1]: https://bugs.gentoo.org/show_bug.cgi?id=580432#c3
> [2]: https://lists.alioth.debian.org/pipermail/pkg-shadow-devel/2016-March/010924.html
>      Subject: [Pkg-shadow-devel] new shadow release candidate
>      Date: Tue Mar 22 18:58:55 UTC 2016
> 
> -- 
> This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
> For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy


