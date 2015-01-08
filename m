Return-Path: elseifthen@gmx.com
Message-ID: <54AE05E9.8010305@gmx.com>
Date: Wed, 07 Jan 2015 23:22:01 -0500
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: [PATCH 4/4] hwclock: man page 'Since v2.26' notes
References: <54AE031C.30907@gmx.com>
In-Reply-To: <54AE031C.30907@gmx.com>
Content-Type: text/plain; charset=utf-8
List-ID: <util-linux.vger.kernel.org>

Clean up the 'Since v2.26' man page notes.
They were redundant of information already
in the manual, and became too verbose.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.8.in | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index 505ff65..20a8dd0 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -36,25 +36,11 @@ Clock timescale; set the kernel's timezone, NTP timescale, and epoch
 (Alpha only); compare the System and Hardware Clocks; and predict future
 Hardware Clock values based on its drift rate.
 .PP
-Since v2.26
-.B hwclock
-does not update the Hardware Clock's drift factor in @ADJTIME_PATH@ by default.
-It is necessary to use \fB\-\-update-drift\fR, with \fB\-\-set\fR or
-\fB\-\-systohc\fR, to force drift factor updates.
-See the \fB\-\-update\-drift\fR option below for details.
-.PP
-Since v2.26
-.B hwclock \-\-hctosys
-does a better job at setting the System Clock: it no longer simply copies
-the time from the Hardware Clock to the System Clock, but sets the System
-Clock to a drift-compensated time.  (That is: it reads the Hardware Clock,
-applies a compensation for the systematic drift to this read time, and
-then sets the System Clock to the resulting value.)
-Therefore it is no longer necessary to run \fBhwclock --adjust\fR before
-doing \fBhwclock --hctosys\fR, and thus \fBhwclock\fR can be used very
-early on in the boot process when the root filesystem is still read-only.
-See the \fB\-\-hctosys\fR function below for information on inhibiting
-this new behavior.
+Since v2.26 important changes were made to the
+.B \-\-hctosys
+function, and the new option
+.B \-\-update\-drift
+was added. See their respective sections below.
 .
 .SH FUNCTIONS
 The following functions are mutually exclusive, only one can be given at
