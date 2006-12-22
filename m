Return-Path: <util-linux-ng-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:58719 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423179AbWLVGM4 (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Fri, 22 Dec 2006 01:12:56 -0500
Received: by nf-out-0910.google.com with SMTP id o25so3319962nfa
        for <util-linux-ng@vger.kernel.org>; Thu, 21 Dec 2006 22:12:55 -0800 (PST)
Message-ID: <787b0d920612212212s1ca3179jf037fc71f3f28498@mail.gmail.com>
Date: Fri, 22 Dec 2006 01:12:54 -0500
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Karel Zak" <kzak@redhat.com>
Subject: Re: splitting util-linux (was: kill)
Cc: "Bryan Henderson" <bryanh@giraffe-data.com>, ethanol@armory.com,
        ams@gnu.org, P@draigbrady.com, util-linux-ng@vger.kernel.org
In-Reply-To: <20061221215312.GP5971@petra.dvoda.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <787b0d920612192242x3788f4bfh3be846d4188e3767@mail.gmail.com>
	 <20061220085706.GH5971@petra.dvoda.cz>
	 <45890A78.1030105@draigBrady.com>
	 <20061220104547.GJ5971@petra.dvoda.cz>
	 <20061220214503.0BB4744007@Psilocybe.Update.UU.SE>
	 <20061220235519.GN5971@petra.dvoda.cz>
	 <20061221041033.GB13134@armory.com> <80765.bryanh@giraffe-data.com>
	 <20061221215312.GP5971@petra.dvoda.cz>
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 12/21/06, Karel Zak <kzak@redhat.com> wrote:

> > problem, since there are people who are willing to maintain some
> > pieces, but less energetic about maintaining the entire package or
> > working through a central bureaucracy.
>
>  I don't see any problem collaborate with more people.

Power sharing is difficult.
See also: OpenBSD, DragonflyBSD, XEmacs

>  Maybe I'm blind, but why do you think that the code in look, cal, ...
>  will be better if you split util-linux into more small packages?

As far as I can see, "look" is basically a lame grep.
Is this something we really need?

(meanwhile the "primes" program needed for making some types
of hash function gets lumped in with a bunch of obsolete games!)

I see rdev. If I remember right, that's used for the pre-2.6 kernels
when you use "dd" to put a raw kernel image on a floppy.
Older kernels had a built-in boot loader that needed parameters.
Uh... NOT useful.

Lots of computers don't even have floppy drives anymore.

Aw, let's just go down the list. Going by what Debian ships:

arch -- OK, though people use uname
chkdupexe -- OK, though obscure
ddate -- pure junk
getopt -- needed for bloated shell scripts AFAIK
line -- people use read
mcookie -- buggy, and belongs in X.org
more -- still better-known than "less", sadly
namei -- OK, though obscure and probably broken
pg -- old-timers from SysV are probably addicted
readprofile -- critical dev tool, though obscure
rev -- possibly useful, though obscure
setterm -- useful
whereis -- might make sense on Gentoo or BSD
blockdev -- for disk benchmarks maybe
cfdisk -- important and dangerous to fool with
clock -- perhaps called from boot scripts or GUI tools
cytune -- very obsolete hardware?
dmesg -- critical
elvtune -- useful
fdformat -- for nostalgia?
fdisk -- important and dangerous to fool with
fsck.minix -- for the retro-computing crowd
getty -- might get used on servers for serial consoles (*)
hwclock -- perhaps called from boot scripts or GUI tools
ipcrm -- critical, sadly
ipcs -- critical, sadly
isosize -- belongs with mkisofs, not in util-linux
mkfs -- important and dangerous to fool with
mkfs.minix -- for the retro-computing crowd
mkswap -- needed
pivot_root -- probably belongs here
ramsize -- ?
raw -- obsolete
rdev -- very obsolete
rootflags -- very obsolete
setsid -- eh, bash or xterm does this for you...?
sfdisk -- important and dangerous to fool with
tunelp -- obsolete (new PCs even lack the ports)
vidmode -- very obsolete

*  getty note: yeah I know you need a getty, but everybody
   and their dog wrote at least one getty program, minimum.

>  No, the motivation for new util-linux upstream is that there is more
>  than 100 util-linux patches in Suse, Red Hat or Debian. We're
>  interested in whole package and we want to merge changes from
>  distribution to this upstream and sync code in util-linux with
>  kernel. This is necessary step.

Something like that is what destabilized the other branch of
procps development. Resist the urge to be a patchbot. You
need to fully understand the patches AND SIDE EFFECTS.
If you apply those patches without a test suite, you are doomed.
