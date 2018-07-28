Return-Path: glaubitz@physik.fu-berlin.de
To: Sami Kerola <kerolasa@iki.fi>
Cc: Bernhard Voelker <mail@bernhard-voelker.de>, Karel Zak <kzak@redhat.com>,
 util-linux@vger.kernel.org, Michael Cree <mcree@orcon.net.nz>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Debian has not dropped alpha - was: Re: [PATCH] hwclock: stop
 supporting alpha cpu architecture
Message-ID: <7ad8126b-cc76-c341-d1c5-d9461f9c1f5f@physik.fu-berlin.de>
Date: Sat, 28 Jul 2018 13:01:45 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <util-linux.vger.kernel.org>

Hello!

I was just pointed towards this mail and wanted to give a quick
heads up! The original claim in the first mail is not accurate.

While Debian has stopped supporting alpha **officially**, we are
still supporting alpha in Debian Ports. In fact, Debian has more
stable and working ports than Gentoo with many of them team-maintained
by the Debian Ports team.

For an overview of the currently supported targets, see:

> https://buildd.debian.org/status/package.php?p=base-files&suite=sid

All architectures build the vast majority of packages without problems
and alpha is actually one of the healhiest ports with over 90% of
all packages being built:

> https://buildd.debian.org/stats/graph-ports-big.png

Please do not drop support for alpha in util-linux.

To get in touch with us, we're hanging around in #debian-ports on OFTC.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
