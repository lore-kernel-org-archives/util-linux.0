Return-Path: util-linux-owner@vger.kernel.org
Received: from h2.hallyn.com ([78.46.35.8]:36316 "EHLO h2.hallyn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753607AbcD2PxF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 29 Apr 2016 11:53:05 -0400
Date: Fri, 29 Apr 2016 10:53:03 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: "W. Trevor King" <wking@tremily.us>,
        Linux Containers <containers@lists.linux-foundation.org>,
        systemd-devel@lists.freedesktop.org, util-linux@vger.kernel.org
Subject: Re: Unprivileged containers and co-ordinating user namespaces
Message-ID: <20160429155303.GA8900@mail.hallyn.com>
References: <1461880928.2307.48.camel@HansenPartnership.com>
 <20160428230045.GS22888@odin.tremily.us>
 <1461944328.2311.10.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1461944328.2311.10.camel@HansenPartnership.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Quoting James Bottomley (James.Bottomley@HansenPartnership.com):
> On Thu, 2016-04-28 at 16:00 -0700, W. Trevor King wrote:
> > On Thu, Apr 28, 2016 at 03:02:08PM -0700, James Bottomley wrote:
> > > /etc/usernamespaces
> > > 
> > > and the format be :::
> > > 
> > > …
> > > 
> > > If this sounds OK to people, I can code up a utility that does this,
> > > which should probably belong in util-linux.
> > 
> > This sounds a lot like shadow's newuidmap and newgidmap [1,2,3].
> > 
> > Cheers,
> > Trevor
> > 
> > [1]: https://github.com/shadow-maint/shadow/commit/673c2a6f9aa6c69588f4c1be08589b8d3475a520
> > [2]: http://man7.org/linux/man-pages/man1/newuidmap.1.html
> > [3]: http://man7.org/linux/man-pages/man5/subuid.5.html
> 
> I think that mostly works.  No-one's packaging it yet, which is why I

https://packages.debian.org/jessie/uidmap
https://launchpad.net/ubuntu/yakkety/+package/uidmap
http://rpm.pbone.net/index.php3/stat/45/idpl/28763248/numer/1/nazwa/newuidmap

> didn't notice.  It also looks like the build dependencies have vastly
> expanded, so I can't get it to build in the build service yet.
> 
> It looks like the only addition it needs is the setgroups flag for
> newgidmap, which the security people will need, so I can patch that. 
>  Plus it's trying to install newgidmap/newuidmap as setuid root rather
> than cap_setuid/cap_setgid, but that's fixable in the spec file.

That would prevent it being installed inside user namespaces, until
the user namespaced file capabilities (see separate thread :) hit.

-serge
