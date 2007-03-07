Return-Path: <util-linux-ng-owner@vger.kernel.org>
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:41661 "HELO
	smtp107.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1422817AbXCGRtc (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Wed, 7 Mar 2007 12:49:32 -0500
From: David Brownell <david-b@pacbell.net>
To: Karel Zak <kzak@redhat.com>
Subject: Re: what happend with hwclock patches?
Date: Wed, 7 Mar 2007 09:42:49 -0800
Cc: List util-linux-ng <util-linux-ng@vger.kernel.org>
References: <200703062006.27793.david-b@pacbell.net> <20070307104257.GC25806@petra.dvoda.cz>
In-Reply-To: <20070307104257.GC25806@petra.dvoda.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703070942.49785.david-b@pacbell.net>
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wednesday 07 March 2007 2:42 am, Karel Zak wrote:
>  Thanks for this link. The patch is not applied yet. Maybe I should
>  release a snapshot (at least) with urgent things like hwclock or some
>  mount patches.

Something like that would probably be a good thing.   The visibility that
patches are finally getting released will help restart machinery that's had
sand in its gears for way too long.


>  But I think you should ask downstream (your distribution) maitainer
>  to apply these kind of patches. They have pretty stable util-linux
>  packages now. I'll need few weeks to prepare useful util-linux-ng release.
>
> (I'm going to add the patch to Fedora tree.)

Thing is, distros are more likely to notice an updated util-linux package
than Yet Another Patch That Should Have Come From Upstream ... and the issue
is not _my_ distro (heck, I patched my systems directly) but every distro
that could potentially run a 2.6.21 kernel.  I am *NOT* in touch with many
such maintainers.  


> On Tue, Mar 06, 2007 at 08:06:27PM -0800, David Brownell wrote:
> 
> > I see there's a GIT archive but you don't seem to have merged the patch I sent
> > you back in November ... and the GIT tree doesn't show any active development,
> > no commits except syncing to old releases.
> 
>  Please, don't use broken gitweb at kernel.org or use it very carefully.
> 
>  There is active development, see "log" in the devel branch:
> 
>    http://git.kernel.org/?p=utils/util-linux-ng/util-linux-ng.git;a=log;h=devel

Well, by active development I included "merging patches submitted" e.g. hwclock,
but it's also rather conventional to have patches show up on mainline instead of
only on branches.  See for example the kernel tree, or essentially any other tree...

It stiil doesn't *show* that development in the usual way.  Attributing the issue
to gitweb isn't relevant; lots of people don't know more than "git pull", and if
that doesn't give them updates, they effectively didn't happen.


>  The good news is that I have more time and I work on that full time
>  now.

That's good to know.  As you're well aware, the fact that this package
is an orphan has made trouble.  No real release since 2005, etc ...

- Dave

