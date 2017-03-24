Return-Path: elseifthen@gmx.com
Subject: [PATCH] hwclock: remove 1994 Award BIOS workaround
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <305b9d73-7210-b8f2-cd8b-d221d612dc8d@gmx.com>
Date: Fri, 24 Mar 2017 11:03:16 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Remove the 1994 Award BIOS bug workaround as
previously discussed more than two years ago:
http://marc.info/?l=util-linux-ng&m=141682406902804&w=2

* sys-utils/hwclock.c: remove badyear option
* sys-utils/hwclock.h: same
* sys-utils/hwclock.8.in: same

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
The following changes since commit 8ea213781d7ad589c211501bac9aa67b8cb57875:

  tests: remove status=none dd(1) from fincore (2017-03-24 13:13:28 +0100)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git hwclock-date7-2

for you to fetch changes up to 5531140bd6b634c63f1f7c2017f93fb194826d00:

  hwclock: remove 1994 Award BIOS workaround (2017-03-24 10:25:35 -0400)

----------------------------------------------------------------
J William Piggott (1):
      hwclock: remove 1994 Award BIOS workaround

 sys-utils/hwclock.8.in | 38 +------------------------------
 sys-utils/hwclock.c    | 62 --------------------------------------------------
 sys-utils/hwclock.h    |  1 -
 3 files changed, 1 insertion(+), 100 deletions(-)

diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index 45ff73f..d1e8027 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -245,42 +245,6 @@ Display help text and exit.
 .RI "Override the default " @ADJTIME_PATH@ " file path."
 .
 .TP
-.B \-\-badyear
-Indicate that the Hardware Clock is incapable of storing years outside
-the range 1994-1999.  There is a problem in some BIOSes (almost all
-Award BIOSes made between 4/26/94 and 5/31/95) wherein they are unable
-to deal with years after 1999.  If one attempts to set the year-of-century
-value to something less than 94 (or 95 in some cases), the value that
-actually gets set is 94 (or 95).  Thus, if you have one of these machines,
-.B \%hwclock
-cannot set the year after 1999 and cannot use the value of the clock as
-the true time in the normal way.
-.sp
-To compensate for this (without your getting a BIOS update, which would
-definitely be preferable), always use
-.B \%\-\-badyear
-if you have one of these machines.  When
-.B \%hwclock
-knows it's working with a brain-damaged clock, it ignores the year part of
-the Hardware Clock value and instead tries to guess the year based on the
-last calibrated date in the adjtime file, by assuming that date is
-within the past year.  For this to work, you had better do a
-.B \%hwclock\ \-\-set
-or
-.B \%hwclock\ \-\-systohc
-at least once a year!
-.sp
-Though
-.B \%hwclock
-ignores the year value when it reads the Hardware Clock, it sets the
-year value when it sets the clock.  It sets it to 1995, 1996, 1997, or
-1998, whichever one has the same position in the leap year cycle as
-the true year.  That way, the Hardware Clock inserts leap days where
-they belong.  Again, if you let the Hardware Clock run for more than a
-year without setting it, this scheme could be defeated and you could
-end up losing a day.
-.
-.TP
 .BI \%\-\-date= date_string
 This option must be used with the
 .B \-\-set
@@ -294,7 +258,7 @@ functions, otherwise it is ignored.
 .B "hwclock\ \-\-predict\ \-\-date='2525-08-14\ 07:11:05'"
 .PP
 The argument must be in local time, even if you keep your Hardware Clock in
-UTC. See the
+UTC.  See the
 .B \%\-\-localtime
 option.  Therefore, the argument should not include any timezone information.
 It also should not be a relative time like "+5 minutes", because
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 21559cf..bd2a057 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -126,48 +126,6 @@ struct adjtime {
 };
 
 /*
- * Almost all Award BIOS's made between 04/26/94 and 05/31/95 have a nasty
- * bug limiting the RTC year byte to the range 94-99. Any year between 2000
- * and 2093 gets changed to 2094, every time you start the system.
- *
- * With the --badyear option, we write the date to file and hope that the
- * file is updated at least once a year. I recommend putting this command
- * "hwclock --badyear" in the monthly crontab, just to be safe.
- *
- * -- Dave Coffin 11/12/98
- */
-static void write_date_to_file(struct tm *tm)
-{
-	FILE *fp;
-
-	if ((fp = fopen(_PATH_LASTDATE, "w"))) {
-		fprintf(fp, "%02d.%02d.%04d\n", tm->tm_mday, tm->tm_mon + 1,
-			tm->tm_year + 1900);
-		if (close_stream(fp) != 0)
-			warn(_("cannot write %s"), _PATH_LASTDATE);
-	} else
-		warn(_("cannot write %s"), _PATH_LASTDATE);
-}
-
-static void read_date_from_file(struct tm *tm)
-{
-	int last_mday, last_mon, last_year;
-	FILE *fp;
-
-	if ((fp = fopen(_PATH_LASTDATE, "r"))) {
-		if (fscanf(fp, "%d.%d.%d\n", &last_mday, &last_mon, &last_year)
-		    == 3) {
-			tm->tm_year = last_year - 1900;
-			if ((tm->tm_mon << 5) + tm->tm_mday <
-			    ((last_mon - 1) << 5) + last_mday)
-				tm->tm_year++;
-		}
-		fclose(fp);
-	}
-	write_date_to_file(tm);
-}
-
-/*
  * time_t to timeval conversion.
  */
 static struct timeval t2tv(time_t timet)
@@ -398,9 +356,6 @@ read_hardware_clock(const struct hwclock_control *ctl,
 	if (err)
 		return err;
 
-	if (ctl->badyear)
-		read_date_from_file(&tm);
-
 	if (ctl->debug)
 		printf(_
 		       ("Time read from Hardware Clock: %4d/%.2d/%.2d %02d:%02d:%02d\n"),
@@ -438,17 +393,6 @@ set_hardware_clock(const struct hwclock_control *ctl, const time_t newtime)
 	if (ctl->testing)
 		printf(_("Clock not changed - testing only.\n"));
 	else {
-		if (ctl->badyear) {
-			/*
-			 * Write the real year to a file, then write a fake
-			 * year between 1995 and 1998 to the RTC. This way,
-			 * Award BIOS boots on 29 Feb 2000 thinking that
-			 * it's 29 Feb 1996.
-			 */
-			write_date_to_file(&new_broken_time);
-			new_broken_time.tm_year =
-			    95 + ((new_broken_time.tm_year + 1) & 3);
-		}
 		ur->set_hardware_clock(ctl, &new_broken_time);
 	}
 }
@@ -1323,7 +1267,6 @@ static void usage(const struct hwclock_control *ctl, const char *fmt, ...)
 #endif
 	fprintf(usageto, _(
 		"     --directisa      access the ISA bus directly instead of %s\n"
-		"     --badyear        ignore RTC's year because the BIOS is broken\n"
 		"     --date <time>    specifies the time to which to set the hardware clock\n"
 		"     --epoch <year>   specifies the year which is the beginning of the\n"
 		"                        hardware clock's epoch value\n"), _PATH_RTC_DEV);
@@ -1377,7 +1320,6 @@ int main(int argc, char **argv)
 	/* Long only options. */
 	enum {
 		OPT_ADJFILE = CHAR_MAX + 1,
-		OPT_BADYEAR,
 		OPT_DATE,
 		OPT_DIRECTISA,
 		OPT_EPOCH,
@@ -1418,7 +1360,6 @@ int main(int argc, char **argv)
 #endif
 		{ "noadjfile",    no_argument,       NULL, OPT_NOADJFILE  },
 		{ "localtime",    no_argument,       NULL, OPT_LOCALTIME  },
-		{ "badyear",      no_argument,       NULL, OPT_BADYEAR    },
 		{ "directisa",    no_argument,       NULL, OPT_DIRECTISA  },
 		{ "test",         no_argument,       NULL, OPT_TEST       },
 		{ "date",         required_argument, NULL, OPT_DATE       },
@@ -1528,9 +1469,6 @@ int main(int argc, char **argv)
 		case OPT_LOCALTIME:
 			ctl.local_opt = 1;	/* --localtime */
 			break;
-		case OPT_BADYEAR:
-			ctl.badyear = 1;
-			break;
 		case OPT_DIRECTISA:
 			ctl.directisa = 1;
 			break;
diff --git a/sys-utils/hwclock.h b/sys-utils/hwclock.h
index b08bd2d..383b970 100644
--- a/sys-utils/hwclock.h
+++ b/sys-utils/hwclock.h
@@ -44,7 +44,6 @@ struct hwclock_control {
 #endif
 		noadjfile:1,
 		local_opt:1,
-		badyear:1,
 		directisa:1,
 		testing:1,
 		systz:1,
