Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Subject: Re: sfdisk, latest fixes break ppc64
Date: Wed, 22 Apr 2015 18:02:04 +0200
References: <201504211234.27649.sweet_f_a@gmx.de> <201504221620.01771.sweet_f_a@gmx.de> <5537B53F.2070805@bernhard-voelker.de>
In-Reply-To: <5537B53F.2070805@bernhard-voelker.de>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Message-Id: <201504221802.05316.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Wednesday 22 April 2015, Bernhard Voelker wrote:
> On 04/22/2015 04:20 PM, Ruediger Meier wrote:
> > On Wednesday 22 April 2015, Karel Zak wrote:
> >>   I hope so:-) Next time it would be nice to detect and fix such
> >> bugs in major release or in .1  ... we need a way how to motivate
> >> users to use -rc releases (t-shits, beers? ;-)
> >
> > Hehe, maybe the only way is like we have it right now. 2.xx and
> > 2.xx.1 are the real rc1 and rc2. The distributors have to learn to
> > use 2.xx.2 only ;)
>
> Isn't there a cross-platform CI system somewhere?
> ... okay, http://build.opensuse.org/ is one, but it usually
> doesn't track upstream changes.

I would push it from git daily when the build and test runs always 
stable. My major problem on OBS is that we don't always have the right 
kernel modules installed.

> There's also things like 
> Hydra (http://hydra.nixos.org/) ... but this only seems to
> cover i686 and x86_64.

Our drone.io and travis-ci.org setup for x86_64 is already not bad
but a bit poor ... old ubuntu, no loop devices, no systemd. If hydra has 
more features then we could also try this.

Another thing would be gcc build farm. I have ssh login there and there 
are some interesting archs. We could set up some build cronjobs. But we 
can't be root there.
https://gcc.gnu.org/wiki/CompileFarm

BTW I've heard that Debian has also some exotic developer machines where 
one could ask for login.

cu,
Rudi
