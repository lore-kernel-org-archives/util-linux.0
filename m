Return-Path: elseifthen@gmx.com
Subject: [v5 PATCH 3/3] cal: update man page
To: Karel Zak <kzak@redhat.com>
References: <4833b897-2192-86dc-f81b-e977d98b07b1@gmx.com>
 <20180108102159.dyelg7kqp5tx3c3i@ws.net.home>
 <6635776f-9787-f05c-704f-e326808daa1d@gmx.com>
 <20180111090120.k6h5q2juw6gqemlc@ws.net.home>
 <95eb163b-218b-42ab-1b4b-4018cedd040e@gmx.com>
 <20180112105706.plx4c5puj6uxdofw@ws.net.home>
 <6ad5a25b-6095-38f7-65b3-bd2711a05ba3@gmx.com>
 <20180115133622.v4wbionunsjj7bmy@ws.net.home>
 <a638c05f-19dc-513f-51b0-f37937193196@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <8caf31ac-de41-6c9b-da09-1f35b8def50a@gmx.com>
Date: Tue, 16 Jan 2018 16:42:15 -0500
MIME-Version: 1.0
In-Reply-To: <a638c05f-19dc-513f-51b0-f37937193196@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Update cal.1 with the new options --reform and --iso.

Also add information about the calendar systems used and
the difference between the --julian option and the Julian
calendar system.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 misc-utils/cal.1 | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 74 insertions(+), 9 deletions(-)

diff --git a/misc-utils/cal.1 b/misc-utils/cal.1
index f1084edba..f99c6b495 100644
--- a/misc-utils/cal.1
+++ b/misc-utils/cal.1
@@ -34,7 +34,7 @@
 .\"
 .\"     @(#)cal.1	8.1 (Berkeley) 6/6/93
 .\"
-.TH CAL 1 "June 2015" "util-linux" "User Commands"
+.TH CAL 1 "January 2018" "util-linux" "User Commands"
 .SH NAME
 cal \- display a calendar
 .SH SYNOPSIS
@@ -52,6 +52,22 @@ month is displayed.
 .sp
 The \fImonth\fR may be specified as a number (1-12), as a month name or as an
 abbreviated month name according to the current locales.
+.sp
+Two different calendar systems are used, Gregorian and Julian.  These are
+nearly identical systems with Gregorian making a small adjustment to the
+frequency of leap years; this facilitates improved synchronization with solar
+events like the equinoxes.  The Gregorian calendar reform was introduced in
+1582, but its adoption continued up to 1923.  By default
+.B cal
+uses the adoption date of 3 Sept 1752.  From that date forward the Gregorian
+calendar is displayed; previous dates use the Julian calendar system.  11 days
+were removed at the time of adoption to bring the calendar in sync with solar
+events.  So Sept 1752 has a mix of Julian and Gregorian dates by which the 2nd
+is followed by the 14th (the 3rd through the 13th are absent).
+.sp
+Optionally, either the proleptic Gregorian calendar or the Julian calendar may
+be used exclusively.
+.RB See\  \-\-reform\  below.
 .SH OPTIONS
 .TP
 \fB\-1\fR, \fB\-\-one\fR
@@ -73,8 +89,60 @@ Display Sunday as the first day of the week.
 \fB\-m\fR, \fB\-\-monday\fR
 Display Monday as the first day of the week.
 .TP
+.B \-\-iso
+Display the proleptic Gregorian calendar exclusively.
+.RB See\  \-\-reform\  below.
+.TP
 \fB\-j\fR, \fB\-\-julian\fR
-Display Julian dates (days one-based, numbered from January 1).
+Use day-of-year numbering for all calendars.  These are also called ordinal
+days.  Ordinal days range from 1 to 366.  This option does not switch from the
+Gregorian to the Julian calendar system, that is controlled by the
+.BR \-\-reform\  option.
+.sp
+Sometimes Gregorian calendars using ordinal dates are referred to as Julian
+calendars.  This can be confusing due to the many date related conventions that
+use Julian in their name: (ordinal) julian date, julian (calendar) date,
+(astronomical) julian date, (modified) julian date, and more.  This option is
+named julian, because ordinal days are identified as julian by the POSIX
+standard.  However, be aware that
+.B cal
+also uses the Julian calendar system.
+.RB See\  DESCRIPTION\  above.
+.TP
+.BI \-\-reform\  val
+This option sets the adoption date of the Gregorian calendar reform.  Calendar
+dates previous to reform use the Julian calendar system.  Calendar dates
+after reform use the Gregorian calendar system.  The argument
+.I val
+can be:
+.RS
+.IP \(bu 2
+.I 1752
+- sets 3 September 1752 as the reform date (default).
+This is when the Gregorian calendar reform was adopted by the British Empire.
+.IP \(bu 2
+.I gregorian
+- display Gregorian calendars exclusively.  This special placeholder sets the
+reform date below the smallest year that
+.B cal
+can use; meaning all calendar output uses the Gregorian calendar system.  This
+is called the proleptic Gregorian calendar, because dates prior to the calendar
+system's creation use extrapolated values.
+.IP \(bu 2
+.I iso
+- alias of
+.IR gregorian .
+The ISO 8601 standard for the representation of dates and times in information
+interchange requires using the proleptic Gregorian calendar.
+.IP \(bu 2
+.I julian
+- display Julian calendars exclusively.  This special placeholder sets the reform date above the largest year that
+.B cal
+can use; meaning all
+calendar output uses the Julian calendar system.
+.PP
+.RB See\  \%DESCRIPTION\  above.
+.RE
 .TP
 \fB\-y\fR, \fB\-\-year\fR
 Display a calendar for the whole year.
@@ -148,14 +216,11 @@ See
 for more details about colorization configuration.
 .SH BUGS
 .PP
-The
+The default
 .B cal
-program uses the 3rd of September 1752 as the date of the Gregorian calendar
-reformation -- that is when it happened in Great Britain and its colonies
-(including what is now the USA).  Starting at that date, eleven days were eliminated
-by this reformation, so the calendar for that month is rather unusual.
-The actual historical dates at which the calendar reform happened in all the
-different countries (locales) are ignored.
+output uses 3 September 1752 as the Gregorian calendar reform date.  The
+historical reform  dates for the other locales, including its introduction in
+October 1582, are not implemented.
 .PP
 Alternative calendars, such as the Umm al-Qura, the Solar Hijri, the Ge'ez,
 or the lunisolar Hindu, are not supported.
