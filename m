Return-Path: elseifthen@gmx.com
Message-ID: <54AE031C.30907@gmx.com>
Date: Wed, 07 Jan 2015 23:10:04 -0500
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: [PATCH 0/4] hwclock: x86_64 -- UTC Defaults -- v2.26 man updates
Content-Type: text/plain; charset=utf-8
List-ID: <util-linux.vger.kernel.org>

I think I heard Mr. Zak say RC1 is coming, so I
wanted to add some more documentation details for
the hwclock v2.26 changes.

While testing to make sure what I wrote was
correct, I found 2 new minor bugs.  I want to slip
the patches in for them this release so the manual
will make sense.

Then I decided to do some man page errata and drop
some outdated language... and then I authored a
new configuration section... well it ended up
being a more sizable patch then I intended. I 
apologize for that, but it's not code so I hope it
will be okay. A rewrite of the man page is on my 
todo list after hwclock refactoring is finished; 
this patch puts a good scratch in some of what I 
intended todo.

If the POSIX vs 'RIGHT' section sounds vaguely
familiar, you're probably recalling this commit:
d53f8ecfbf036eddb2aef737dc0973a613d80ced
Which should never have been accepted.

>From his email, Mr. Parmelee appears to be seriously confused.
http://marc.info/?l=util-linux-ng&m=136543342327830&w=2

But I'll bring this discussion up in a hwclock
refactoring RFC later on.

I made the final man page patch separate so it can
be rejected easily. We've already visited that
subject a few times now and perhaps Karel doesn't
want to mess with it anymore.

I wish everyone here a Happy New Year!

J William Piggott (4):
  hwclock: enable --directisa for x86_64
  hwclock: Incorrect UTC defaults
  hwclock: update man page for v2.26 rc
  hwclock: man page 'Since v2.26' notes

 sys-utils/hwclock-cmos.c |    9 +-
 sys-utils/hwclock.8.in   | 1148 ++++++++++++++++++++++++++++++----------------
 sys-utils/hwclock.c      |    4 +-
 3 files changed, 759 insertions(+), 402 deletions(-)
