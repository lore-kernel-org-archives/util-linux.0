Return-Path: elseifthen@gmx.com
Subject: [PATCH 2/4] cal: remove year top header
To: Karel Zak <kzak@redhat.com>
References: <7bdff2d4-ad0d-699e-d451-be087f637074@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <425f0c7b-5f76-675a-95b4-f4aeee1b25a9@gmx.com>
Date: Wed, 24 Jan 2018 19:53:11 -0500
MIME-Version: 1.0
In-Reply-To: <7bdff2d4-ad0d-699e-d451-be087f637074@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Year is now always displayed in the month header.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 misc-utils/cal.c | 32 +++-----------------------------
 1 file changed, 3 insertions(+), 29 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 8dea2c459..d59afc03d 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -225,7 +225,6 @@ struct cal_control {
 	int gutter_width;		/* spaces in between horizontal month outputs */
 	struct cal_request req;		/* the times user is interested */
 	unsigned int	julian:1,	/* julian output */
-			header_year:1,	/* print year number */
 			header_hint:1;	/* does month name + year need two lines to fit */
 };
 
@@ -244,8 +243,7 @@ static void headers_init(struct cal_control *ctl);
 static void cal_fill_month(struct cal_month *month, const struct cal_control *ctl);
 static void cal_output_header(struct cal_month *month, const struct cal_control *ctl);
 static void cal_output_months(struct cal_month *month, const struct cal_control *ctl);
-static void monthly(const struct cal_control *ctl);
-static void yearly(const struct cal_control *ctl);
+static void months(const struct cal_control *ctl);
 static int day_in_year(const struct cal_control *ctl, int day,
 		       int month, int32_t year);
 static int day_in_week(const struct cal_control *ctl, int day,
@@ -538,7 +536,6 @@ int main(int argc, char **argv)
 			ctl.num_months = MONTHS_IN_YEAR;
 		if (yflag) {
 			ctl.req.start_month = 1;	/* start from Jan */
-			ctl.header_year = 1;		/* print year number */
 		}
 	}
 
@@ -551,10 +548,7 @@ int main(int argc, char **argv)
 	if (!ctl.num_months)
 		ctl.num_months = 1;		/* display at least one month */
 
-	if (yflag || Yflag)
-		yearly(&ctl);
-	else
-		monthly(&ctl);
+	months(&ctl);
 
 	return EXIT_SUCCESS;
 }
@@ -805,7 +799,7 @@ static void cal_output_months(struct cal_month *month, const struct cal_control
 	}
 }
 
-static void monthly(const struct cal_control *ctl)
+static void months(const struct cal_control *ctl)
 {
 	struct cal_month m1,m2,m3, *m;
 	int i, rows, new_month, month = ctl->req.start_month ? ctl->req.start_month : ctl->req.month;
@@ -852,26 +846,6 @@ static void monthly(const struct cal_control *ctl)
 	}
 }
 
-static void yearly(const struct cal_control *ctl)
-{
-	char out[FMT_ST_CHARS];
-	int year_width = 0;
-
-	year_width += (ctl->week_width + 1) * (ctl->julian ? 2 : 3);
-	if (ctl->julian)
-		year_width--;
-
-	if (ctl->header_year) {
-		sprintf(out, "%04d", ctl->req.year);
-		center(out, year_width, 0);
-		my_putstring("\n\n");
-	}
-	monthly(ctl);
-
-	/* Is empty line at the end year output really needed? */
-	my_putstring("\n");
-}
-
 /*
  * day_in_year --
  *	return the 1 based day number within the year
