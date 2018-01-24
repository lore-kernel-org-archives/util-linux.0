Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46108 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933590AbeAXNZP (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 24 Jan 2018 08:25:15 -0500
Date: Wed, 24 Jan 2018 14:25:11 +0100
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] cal: do not set months_in_row with -3 option
Message-ID: <20180124132511.rhvvlvzblygpt242@ws.net.home>
References: <85ea05cd-c4d0-f7d6-14f4-7deb065089d1@gmx.com>
 <009ab747-9e36-1283-f20d-0c3fea21045d@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <009ab747-9e36-1283-f20d-0c3fea21045d@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jan 22, 2018 at 03:07:15PM -0500, J William Piggott wrote:
> 
> Having the -3 option set months_in_row causes ordinal days
> to wrap; it overrides the automatic handling of months_in_row
> that falls back to 2 month columns for ordinal days.
> 
> Before:
> cal -3j 2020
>                            2020
> 
>             July                         August                      September
> Sun Mon Tue Wed Thu Fri Sat   Sun Mon Tue Wed Thu Fri Sat   Sun Mon Tue Wed Thu Fri Sat
>     182 183 184 185 186 187                   213 214 215   244 245 246 247 248 249 250
> 188 189 190 191 192 193 194   216 217 218 219 220 221 222   251 252 253 254 255 256 257
> 195 196 197 198 199 200 201   223 224 225 226 227 228 229   258 259 260 261 262 263 264
> 202 203 204 205 206 207 208   230 231 232 233 234 235 236   265 266 267 268 269 270 271
> 209 210 211 212               237 238 239 240 241 242 243   272 273
> 
> Patched:
> cal -3j 2020
>                            2020
> 
>           December                      January
> Sun Mon Tue Wed Thu Fri Sat   Sun Mon Tue Wed Thu Fri Sat
> 335 336 337 338 339 340 341                 1   2   3   4
> 342 343 344 345 346 347 348     5   6   7   8   9  10  11
> 349 350 351 352 353 354 355    12  13  14  15  16  17  18
> 356 357 358 359 360 361 362    19  20  21  22  23  24  25
> 363 364 365                    26  27  28  29  30  31
> 
>           February
> Sun Mon Tue Wed Thu Fri Sat
>                          32
>  33  34  35  36  37  38  39
>  40  41  42  43  44  45  46
>  47  48  49  50  51  52  53
>  54  55  56  57  58  59  60

Merged, but the patch breaks regression tests. It would be nice to fix
it ASAP.

It would be nice to be smart and use include/ttyutils.h:get_terminal_width()
if stdout is terminal. For non-terminal output we can use always 3 columns.

See patch below. It's not perfect, because we have extra blank space
behind last column, but good enough to show the idea. For really small
terms it uses one month, etc.

    Karel


diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 562ae2afb..688377189 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -75,6 +75,7 @@
 #include "strutils.h"
 #include "optutils.h"
 #include "timeutils.h"
+#include "ttyutils.h"
 
 static int has_term = 0;
 static const char *Senter = "", *Sexit = "";	/* enter and exit standout mode */
@@ -542,10 +543,19 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (ctl.num_months > 1 && ctl.months_in_row == 0)
-		ctl.months_in_row = ctl.julian ? MONTHS_IN_YEAR_ROW - 1 :
-						 MONTHS_IN_YEAR_ROW;
-	else if (!ctl.months_in_row)
+#define DOY_MONTH_WIDTH	28	/* -j */
+#define DOM_MONTH_WIDTH 23
+
+	if (ctl.num_months > 1 && ctl.months_in_row == 0) {
+		if (isatty(STDOUT_FILENO)) {
+			int w = get_terminal_width(STDOUT_FILENO);
+			int mw = ctl.julian ? DOY_MONTH_WIDTH : DOM_MONTH_WIDTH;
+
+			ctl.months_in_row = w  / mw;
+		} else
+			ctl.months_in_row = MONTHS_IN_YEAR_ROW;
+
+	} else if (!ctl.months_in_row)
 		ctl.months_in_row = 1;
 
 	if (!ctl.num_months)
