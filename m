Return-Path: elseifthen@gmx.com
Message-ID: <5508562A.4030108@gmx.com>
Date: Tue, 17 Mar 2015 12:28:26 -0400
From: J William Piggott <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: [PATCH 2/2] hwclock: non-root access in test mode
References: <55085554.5040409@gmx.com>
In-Reply-To: <55085554.5040409@gmx.com>
Content-Type: text/plain; charset=utf-8
List-ID: <util-linux.vger.kernel.org>

Allow a non-root user to call all hwclock
functions when the --test option is used.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index e8732b8..e1e5816 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1914,15 +1914,15 @@ int main(int argc, char **argv)
 		permitted = TRUE;
 	else {
 		/* program is designed to run setuid (in some situations) */
-		if (set || systohc || adjust) {
+		if ((set || systohc || adjust) && !testing) {
 			warnx(_("Sorry, only the superuser can change "
 				"the Hardware Clock."));
 			permitted = FALSE;
-		} else if (systz || hctosys) {
+		} else if ((systz || hctosys) && !testing) {
 			warnx(_("Sorry, only the superuser can change "
 				"the System Clock."));
 			permitted = FALSE;
-		} else if (setepoch) {
+		} else if (setepoch && !testing) {
 			warnx(_("Sorry, only the superuser can change the "
 				"Hardware Clock epoch in the kernel."));
 			permitted = FALSE;
