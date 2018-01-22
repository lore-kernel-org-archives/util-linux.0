Return-Path: elseifthen@gmx.com
Subject: [PATCH 2/2] cal: do not set months_in_row with -3 option
To: Karel Zak <kzak@redhat.com>
References: <85ea05cd-c4d0-f7d6-14f4-7deb065089d1@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <009ab747-9e36-1283-f20d-0c3fea21045d@gmx.com>
Date: Mon, 22 Jan 2018 15:07:15 -0500
MIME-Version: 1.0
In-Reply-To: <85ea05cd-c4d0-f7d6-14f4-7deb065089d1@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Having the -3 option set months_in_row causes ordinal days
to wrap; it overrides the automatic handling of months_in_row
that falls back to 2 month columns for ordinal days.

Before:
cal -3j 2020
                           2020

            July                         August                      September
Sun Mon Tue Wed Thu Fri Sat   Sun Mon Tue Wed Thu Fri Sat   Sun Mon Tue Wed Thu Fri Sat
    182 183 184 185 186 187                   213 214 215   244 245 246 247 248 249 250
188 189 190 191 192 193 194   216 217 218 219 220 221 222   251 252 253 254 255 256 257
195 196 197 198 199 200 201   223 224 225 226 227 228 229   258 259 260 261 262 263 264
202 203 204 205 206 207 208   230 231 232 233 234 235 236   265 266 267 268 269 270 271
209 210 211 212               237 238 239 240 241 242 243   272 273

Patched:
cal -3j 2020
                           2020

          December                      January
Sun Mon Tue Wed Thu Fri Sat   Sun Mon Tue Wed Thu Fri Sat
335 336 337 338 339 340 341                 1   2   3   4
342 343 344 345 346 347 348     5   6   7   8   9  10  11
349 350 351 352 353 354 355    12  13  14  15  16  17  18
356 357 358 359 360 361 362    19  20  21  22  23  24  25
363 364 365                    26  27  28  29  30  31

          February
Sun Mon Tue Wed Thu Fri Sat
                         32
 33  34  35  36  37  38  39
 40  41  42  43  44  45  46
 47  48  49  50  51  52  53
 54  55  56  57  58  59  60

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 misc-utils/cal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 8a715d94c..a38ca3024 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -367,7 +367,6 @@ int main(int argc, char **argv)
 		case '3':
 			ctl.num_months = 3;
 			ctl.span_months = 1;
-			ctl.months_in_row = 3;
 			break;
 		case 's':
 			ctl.weekstart = SUNDAY;		/* default */
