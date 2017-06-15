Return-Path: elseifthen@gmx.com
Subject: [PATCH 10/10] parse-date: time_zone_hhmm() bug fixes
To: Karel Zak <kzak@redhat.com>
References: <1b57c4a5-9517-e005-dd05-265004d58948@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <ff691a87-60cc-c030-107e-63af7138ac36@gmx.com>
Date: Thu, 15 Jun 2017 19:49:23 -0400
MIME-Version: 1.0
In-Reply-To: <1b57c4a5-9517-e005-dd05-265004d58948@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


* fix incorrect arg type used for abs().
* prevent integer arithmetic overflow by limiting offset to 4 digits.
* don't accept malformed offset values like:
    -4:3
    +12:719
    +0000001:23
    -9:00000001
    +0000001123

Reported-by: Ruediger Meier <ruediger.meier@ga-group.nl>
Influenced-by: gnulib 30784c4 Paul Eggert <eggert@cs.ucla.edu>
Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 lib/parse-date.y | 68 +++++++++++++++++++++++++++-----------------------------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/lib/parse-date.y b/lib/parse-date.y
index c06616a..5e966f0 100644
--- a/lib/parse-date.y
+++ b/lib/parse-date.y
@@ -214,7 +214,7 @@ typedef struct {
 union YYSTYPE;
 static int yylex (union YYSTYPE *, parser_control *);
 static int yyerror (parser_control const *, char const *);
-static long int time_zone_hhmm (parser_control *, textint, intmax_t);
+static int time_zone_hhmm (parser_control *, textint, textint);
 
 /**
  * Extract into *PC any date and time info from a string of digits
@@ -307,7 +307,7 @@ set_hhmmss(parser_control *pc, intmax_t hour, intmax_t minutes,
 %token <textintval> tSNUMBER tUNUMBER
 %token <timespec> tSDECIMAL_NUMBER tUDECIMAL_NUMBER
 
-%type <intval> o_colon_minutes
+%type <textintval> o_colon_minutes
 %type <timespec> seconds signed_seconds unsigned_seconds
 
 %type <rel> relunit relunit_snumber dayshift
@@ -402,7 +402,7 @@ o_zone_offset:
 zone_offset:
 	  tSNUMBER o_colon_minutes {
 		pc->zones_seen++;
-		pc->time_zone = time_zone_hhmm (pc, $1, $2);
+		if (! time_zone_hhmm (pc, $1, $2)) YYABORT;
 	  }
 ;
 
@@ -455,7 +455,8 @@ zone:
 		apply_relative_time (pc, $2, 1);
 	  }
 	| tZONE tSNUMBER o_colon_minutes {
-		pc->time_zone = $1 + time_zone_hhmm (pc, $2, $3);
+		if (! time_zone_hhmm (pc, $2, $3)) YYABORT;
+		pc->time_zone += $1;
 	  }
 	| tDAYZONE {
 		pc->time_zone = $1 + 60;
@@ -662,9 +663,10 @@ hybrid:
 
 o_colon_minutes:
 	  /* empty */
-		{ $$ = -1; }
-	| ':' tUNUMBER
-		{ $$ = $2.value; }
+		{ $$.value = $$.digits = 0; }
+	| ':' tUNUMBER {
+		$$ = $2;
+	  }
 ;
 
 %%
@@ -855,39 +857,35 @@ static table const military_table[] = {
 };
 
 /**
- * Convert a time zone expressed as HH:MM into an integer count of
- * minutes.  If MM is negative, then S is of the form HHMM and needs
- * to be picked apart; otherwise, S is of the form HH.  As specified in
- * http://www.opengroup.org/susv3xbd/xbd_chap08.html#tag_08_03, allow
- * only valid TZ range, and consider first two digits as hours, if no
- * minutes specified.
+ * Convert a time offset expressed as HH:MM or HHMM into an integer count of
+ * minutes.  If hh is more than 2 digits then it is of the form HHMM and must be
+ * delimited; in that case 'mm' is required to be absent.  Otherwise, hh and mm
+ * are used ('mm' contains digits that were prefixed with a colon).
+ *
+ * POSIX TZ and ISO 8601 both define the maximum offset as 24:59. POSIX also
+ * allows seconds, but currently the parser rejects them. Both require minutes
+ * to be zero padded (2 digits). ISO requires hours to be zero padded, POSIX
+ * does not, either is accepted; which means an invalid ISO offset could pass.
  */
 
-static long int time_zone_hhmm(parser_control *pc, textint s, intmax_t mm)
+static int time_zone_hhmm(parser_control *pc, textint hh, textint mm)
 {
-	intmax_t n_minutes;
-
-	/**
-	 * If the length of S is 1 or 2 and no minutes are specified,
-	 * interpret it as a number of hours.
-	 */
-	if (s.digits <= 2 && mm < 0)
-		s.value *= 100;
-
-	if (mm < 0)
-		n_minutes = (s.value / 100) * 60 + s.value % 100;
-	else
-		n_minutes = s.value * 60 + (s.negative ? -mm : mm);
+	int h, m;
+
+	if (hh.digits > 2 && hh.digits < 5 && mm.digits == 0) {
+		h = hh.value / 100;
+		m = hh.value % 100;
+	} else if (hh.digits < 3 && (mm.digits == 0 || mm.digits == 2)) {
+		h = hh.value;
+		m = hh.negative ? -mm.value : mm.value;
+	} else
+		return 0;
 
-	/**
-	 * If the absolute number of minutes is larger than 24 hours,
-	 * arrange to reject it by incrementing pc->zones_seen.	Thus,
-	 * we allow only values in the range UTC-24:00 to UTC+24:00.
-	 */
-	if (24 * 60 < abs (n_minutes))
-		pc->zones_seen++;
+	if (abs(h) > 24 || abs(m) > 59)
+		return 0;
 
-	return n_minutes;
+	pc->time_zone =  h * 60 + m;
+	return 1;
 }
 
 static int to_hour(intmax_t hours, int meridian)
