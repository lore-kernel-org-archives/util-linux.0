Return-Path: elseifthen@gmx.com
Message-ID: <54E0E69C.6020907@gmx.com>
Date: Sun, 15 Feb 2015 13:34:04 -0500
From: J William Piggott <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: [PATCH] hwclock: man-page errata
Content-Type: text/plain; charset=utf-8
List-ID: <util-linux.vger.kernel.org>

Professor Eggert, maintainer of the tz database, reviewed
the new POSIX vs 'RIGHT' man-page section and suggested
the following corrections.

Correct the subdirectory names and remove IANA from the
name of the Time Zone Database.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.8.in | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index 9512690..7ddd2b1 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -993,10 +993,10 @@ A discussion on date-time configuration would be incomplete without
 addressing timezones, this is mostly well covered by
 .BR tzset (3).
 One area that seems to have no documentation is the 'right'
-directory of the IANA Time Zone Database, aka tz, aka zoneinfo.
+directory of the Time Zone Database, aka tz, aka zoneinfo.
 .PP
 There are two separate databases in the zoneinfo system, posix
-and 'right'. 'Right' (now named leaps) includes leap seconds and posix
+and 'right'. 'Right' (now named zoneinfo\-leaps) includes leap seconds and posix
 does not. To use the 'right' database the System Clock must be kept in
 \%UTC\ +\ leap_seconds, i.e., \%TAI\ \-\ 10. This allows calculating the
 exact number of seconds between two dates that cross a leap second
@@ -1013,13 +1013,13 @@ Files are never used directly from the posix or 'right' subdirectories, e.g.,
 This habit was becoming so common that the upstream zoneinfo project
 restructured the system's file tree by moving the posix and 'right'
 subdirectories out of the zoneinfo directory and into sibling directories:
-.br
+.PP
 .in +2
 .I /usr/share/zoneinfo
 .br
-.I /usr/share/posix
+.I /usr/share/zoneinfo\-posix
 .br
-.I /usr/share/leaps
+.I /usr/share/zoneinfo\-leaps
 .PP
 Unfortunately, some Linux distributions are changing it back to the old
 tree structure in their packages. So the problem of system
