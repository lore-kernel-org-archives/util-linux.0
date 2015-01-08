Return-Path: elseifthen@gmx.com
Message-ID: <54AE046B.7090706@gmx.com>
Date: Wed, 07 Jan 2015 23:15:39 -0500
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: [PATCH 2/4] hwclock: Incorrect UTC defaults
References: <54AE031C.30907@gmx.com>
In-Reply-To: <54AE031C.30907@gmx.com>
Content-Type: text/plain; charset=utf-8
List-ID: <util-linux.vger.kernel.org>

Hwclock's default timescale was changed to UTC in:

commit 7894bf0f08740f75610990a2ba76af7a7cbce61e
Date:   Mon Feb 21 13:27:07 2011 +0000

This change was incomplete.

With no /etc/adjtime file the current behavior is:
hwclock --utc --adjust        #Creates a UTC file.
hwclock --localtime --adjust  #File is not created.

That is the opposite of what UTC default should do.

With this patch the behavior is:
hwclock --utc --adjust        #File is not created.
hwclock --localtime --adjust  #Creates a LOCAL file.

'Creates a xxxx file' means: An /etc/adjtime file
is created with zero for all parameters except the
Hardware Clock's timescale field, which is set to
the value indicated by xxxx.

The second item missed in the patch was a test in
the save_adjtime() function that defaults to LOCAL.

Theoretically we cannot get to the save function
without having a value set for adjtime.local_utc,
but the test is there so it needs be correct.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 008b20a..4d40dc5 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -272,7 +272,7 @@ static int read_adjtime(struct adjtime *adjtime_p)
 		adjtime_p->last_adj_time = 0;
 		adjtime_p->not_adjusted = 0;
 		adjtime_p->last_calib_time = 0;
-		adjtime_p->local_utc = UNKNOWN;
+		adjtime_p->local_utc = UTC;
 		adjtime_p->dirty = FALSE;	/* don't create a zero adjfile */
 
 		return 0;
@@ -1135,7 +1135,7 @@ static void save_adjtime(const struct adjtime adjtime, const bool testing)
 			(long)adjtime.last_adj_time,
 			adjtime.not_adjusted,
 			(long)adjtime.last_calib_time,
-			(adjtime.local_utc == UTC) ? "UTC" : "LOCAL");
+			(adjtime.local_utc == LOCAL) ? "LOCAL" : "UTC");
 
 		if (testing) {
 			printf(_
