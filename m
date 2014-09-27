Return-Path: elseifthen@gmx.com
Message-ID: <5426D4C2.4060403@gmx.com>
Date: Sat, 27 Sep 2014 11:16:18 -0400
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: [PATCH 0/7] hwclock patch cover letter.
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

This hwclock patch set includes three topics, one
is needed functionality, the other two are bug
fixes.

The first also fixes three bugs as a side effect
(See 'Part II' in its commit message).

The second fixes a complaint we receive regularly
from users that keep their Hardware Clock set to
the local timescale while running NTP.

Note: to test this fix you will need a kernel >= 3.13,
as 11 minute mode was broken from 3.0 ~ 3.13-rc1.

The third involves the use of --systohc at
shutdown. We need this with 11 minute mode to
refresh the adjtime file's timestamps, but doing
so clobbers the drift factor to near zero.  When
not running NTP it causes drift factor creep by
assuming that the System Clock is keeping perfect
time. Of course, it is not.

J William Piggott (7):
  hwclock: hctosys drift compensation II
  hwclock: hctosys drift compensation II COMMENTS
  hwclock: hctosys drift compensation II MAN
  hwclock: persistent_clock_is_local
  hwclock: persistent_clock_is_local MAN
  hwclock: Add --update option
  hwclock: Add --update option MAN


 sys-utils/hwclock.8.in | 145 +++++++++++++++------
 sys-utils/hwclock.c    | 337 ++++++++++++++++++++++++++-----------------------
 2 files changed, 281 insertions(+), 201 deletions(-)
