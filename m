Return-Path: elseifthen@gmx.com
Subject: [PATCH 4/8] hwclock: fix RTC read logic
To: Karel Zak <kzak@redhat.com>
References: <e1d514d0-132d-d142-41fb-cf179de5606a@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <5714882c-8ed5-c703-410e-c0dd191051f6@gmx.com>
Date: Tue, 1 Aug 2017 09:17:08 -0400
MIME-Version: 1.0
In-Reply-To: <e1d514d0-132d-d142-41fb-cf179de5606a@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Over the past decade a few commits for a corner case problem
have left the RTC read branch in a bad place.

The problem was: when a corrupted RTC could not be read, then
it also could not be reset, because hwclock would error out
due to the RTC read failure.

2.15-rc1 commit 3b96a7a Aug  9 2008
2.19-rc1 commit 5606df5 Dec 29 2010
2.23-rc1 commit ab8f402 Mar 21 2013

The first fix was to ignore a synchronization timeout only for
the busywait branch.

Two and a half years later a commit describing the same problem
took a little more heavy-handed approach by ignoring all
synchronization failures and the RTC read after it, for both of
the RTC set functions.

Because the previous fix also ignored the select() branch timeout
it caused a bogus warning. The chosen workaround for that was to
only print the select() timeout message in debug mode (this is
reverted by another patch).

The problem with these fixes is that we cannot just ignore the
synchronization timeout like that, because then the drift
correction operations will be invalid. The original logic was
correct; we must exit when synchronization fails.

Another problem is that now there are statements between the
timing-critical synchronize-read-timestamp trio (which were
also in the wrong order, but that part of the problem goes
back further in history).

The solution is to skip the RTC read block completely for the
RTC set functions when not also using the --update-drift
option. If we are updating the drift correction factor during
a set function then we must synchronize and read the RTC.
Otherwise reading the RTC is not needed. Anyone trying to set
a corrupt RTC should not be using --update-drift, because the
resulting drift correction factor would be invalid.

Using this approach has the added benefit of significantly
reducing system shutdown time when not using --update-drift:

time ./hwclock --test --systohc; time ./hwclock-master --test --systohc
Test mode: clock was not changed

real    0m0.072s
user    0m0.066s
sys     0m0.003s
Test mode: clock was not changed

real    0m1.000s
user    0m0.169s
sys     0m0.005s

I've see differences as high as 1.518 seconds.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 1550dfe..e172fb1 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1034,8 +1034,6 @@ manipulate_clock(const struct hwclock_control *ctl, const time_t set_time,
 	struct timeval hclocktime = { 0, 0 };
 	/* Total Hardware Clock drift correction needed. */
 	struct timeval tdrift;
-	/* local return code */
-	int rc = 0;
 
 	if ((ctl->set || ctl->systohc || ctl->adjust) &&
 	    (adjtime->local_utc == UTC) != ctl->universal) {
@@ -1068,32 +1066,26 @@ manipulate_clock(const struct hwclock_control *ctl, const time_t set_time,
 	if (ur->get_permissions())
 		return EX_NOPERM;
 
-	if (ctl->show || ctl->get || ctl->adjust || ctl->hctosys
-	    || !ctl->noadjfile) {
-		/* data from HW-clock are required */
-		rc = synchronize_to_clock_tick(ctl);
-
+	/*
+	 * Read and drift correct RTC time; except for RTC set functions
+	 * without the --update-drift option because: 1) it's not needed;
+	 * 2) it enables setting a corrupted RTC without reading it first;
+	 * 3) it significantly reduces system shutdown time.
+	 */
+	if ( ! ((ctl->set || ctl->systohc) && !ctl->update)) {
 		/*
-		 * We don't error out if the user is attempting to set the
-		 * RTC and synchronization timeout happens - the RTC could
-		 * be functioning but contain invalid time data so we still
-		 * want to allow a user to set the RTC time.
+		 * Timing critical - do not change the order of, or put
+		 * anything between the follow three statements.
+		 * Synchronization failure MUST exit, because all drift
+		 * operations are invalid without it.
 		 */
-		if (rc == RTC_BUSYWAIT_FAILED && !ctl->set && !ctl->systohc)
+		if (synchronize_to_clock_tick(ctl))
 			return EX_IOERR;
+		read_hardware_clock(ctl, &hclock_valid, &hclocktime.tv_sec);
 		gettimeofday(&read_time, NULL);
 
-		/*
-		 * If we can't synchronize to a clock tick,
-		 * we likely can't read from the RTC so
-		 * don't bother reading it again.
-		 */
-		if (!rc) {
-			rc = read_hardware_clock(ctl, &hclock_valid,
-						 &hclocktime.tv_sec);
-			if (rc && !ctl->set && !ctl->systohc)
-				return EX_IOERR;
-		}
+		if (!hclock_valid)
+			return EX_IOERR;
 		/*
 		 * Calculate and apply drift correction to the Hardware Clock
 		 * time for everything except --show
