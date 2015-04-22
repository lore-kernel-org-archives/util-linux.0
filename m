Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59061 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965525AbbDVPq7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 22 Apr 2015 11:46:59 -0400
Date: Wed, 22 Apr 2015 17:46:56 +0200
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org
Subject: Re: sfdisk, latest fixes break ppc64
Message-ID: <20150422154656.GG27969@ws.net.home>
References: <201504211234.27649.sweet_f_a@gmx.de>
 <201504221242.18521.sweet_f_a@gmx.de>
 <20150422132827.GF27969@ws.net.home>
 <201504221620.01771.sweet_f_a@gmx.de>
 <5537B53F.2070805@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5537B53F.2070805@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 22, 2015 at 04:50:39PM +0200, Bernhard Voelker wrote:
> On 04/22/2015 04:20 PM, Ruediger Meier wrote:
> >On Wednesday 22 April 2015, Karel Zak wrote:
> >>  I hope so:-) Next time it would be nice to detect and fix such bugs
> >>  in major release or in .1  ... we need a way how to motivate users
> >>to use -rc releases (t-shits, beers? ;-)
> >
> >Hehe, maybe the only way is like we have it right now. 2.xx and 2.xx.1
> >are the real rc1 and rc2. The distributors have to learn to use 2.xx.2
> >only ;)
> 
> Isn't there a cross-platform CI system somewhere?
> ... okay, http://build.opensuse.org/ is one, but it usually
> doesn't track upstream changes.  There's also things like
> Hydra (http://hydra.nixos.org/) ... but this only seems to
> cover i686 and x86_64.

We already use 

    https://drone.io/github.com/karelzak/util-linux

and

    https://travis-ci.org/karelzak/util-linux

both connected to github, but for ppc64 and s390 I use machines in Red
Hat labs and during -rc1 I usually use Coverity analyzer.

It's also possible to use Fedora/Suse build farms, but we don't
execute all the tests (especially tests where is necessary root perms)
by default. 

Anyway, this is no problem, the problem is real life testing.
Fortunately, I can push unstable stuff to Fedora Rawhide :)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
