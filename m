Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:37797 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673Ab2KYMC0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 25 Nov 2012 07:02:26 -0500
Received: by mail-we0-f174.google.com with SMTP id d7so3015084wer.19
        for <util-linux@vger.kernel.org>; Sun, 25 Nov 2012 04:02:25 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 4/4] docs: ddate removal
Date: Sun, 25 Nov 2012 12:01:11 +0000
Message-Id: <1353844871-6047-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1353844871-6047-1-git-send-email-kerolasa@iki.fi>
References: <1353844871-6047-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Missed in commit 4cf02b65109029a38f708148dea8d2bdf2fa19de

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 Documentation/ddate.txt | 73 -------------------------------------------------
 1 file changed, 73 deletions(-)
 delete mode 100644 Documentation/ddate.txt

diff --git a/Documentation/ddate.txt b/Documentation/ddate.txt
deleted file mode 100644
index 87d0fb8..0000000
--- a/Documentation/ddate.txt
+++ /dev/null
@@ -1,73 +0,0 @@
-
-PERPETUAL DATE CONVERTER FROM GREGORIAN TO POEE CALENDAR
-
-SEASONS
-    1.  Chaos -- Patron Apostle Hung Mung
-    2.  Discord -- Patron Apostle Dr. Van Van Mojo
-    3.  Confusion -- Patron Apostle Sri Syadasti
-    4.  Bureaucracy -- Patron Apostle Zarathud
-    5.  The Aftermath -- Patron Apostle the Elder Malaclypse
-
-DAYS OF THE WEEK*
-    1.  Sweetmorn                       *The DAYS OF THE WEEK
-    2.  Boomtime                        are named from the five
-    3.  Pungenday                       basic elements:  SWEET,
-    4.  Prickle-Prickle                 BOOM, PUNGENT, PRICKLE,
-    5.  Setting Orange                  and ORANGE.
-
-HOLYDAYS                                
-A.  Apostle Holydays                    B.  Seasons Holydays
-    1.  Mungday                             1.  Chaoflux
-    2.  Mojoday                             2.  Discoflux
-    3.  Syaday                              3.  Confuflux
-    4.  Zaraday                             4.  Bureflux
-    5.  Maladay                             5.  Afflux
-Each occurs on the 5th                  Each occurs on the 50th
-day of the Season                       day of the Season
-
-C.  Saint Tib's Day -- occurs once every four years (1 + 4 = 5) and is
-    inserted between the 59th and 60th days of the Season of Chaos
-
-                    ST BT PD PP SO                          SM BT PD PP SO
-Jan  1  2  3  4  5   1  2  3  4  5 Chs  Jul  5  6  7  8  9  40 41 42 43 44 Cfn
-     6  7  8  9 10   6  7  8  9 10          10 11 12 13 14  45 46 47 48 49
-    11 12 13 14 15  11 12 13 14 15          15 16 17 18 19  50 51 52 53 54
-    16 17 18 19 20  16 17 18 19 20          20 21 22 23 24  55 56 57 58 59
-    21 22 23 24 25  21 22 23 24 25          25 26 27 28 29  60 61 62 63 64
-    26 27 28 29 30  26 27 28 29 30          30 31  1  2  3  65 66 67 68 69
-    31  1  2  3  4  31 32 33 34 35      Aug  4  5  6  7  8  70 71 72 73  1 Bcy
-Feb  5  6  7  8  9  36 37 38 39 40           9 10 11 12 13   2  3  4  5  6
-    10 11 12 13 14  41 42 43 44 45          14 15 16 17 18   7  8  9 10 11
-    15 16 17 18 19  46 47 48 49 50          19 20 21 22 23  12 13 14 15 16
-    20 21 22 23 24  51 52 53 54 55          24 25 26 27 28  17 18 19 20 21
-    25 26 27 28* 1  56 57 58 59 60          29 30 31  1  2  22 23 24 25 26
-Mar  2  3  4  5  6  61 62 63 64 65      Sep  3  4  5  6  7  27 28 29 30 31
-     7  8  9 10 11  66 67 68 69 70           8  9 10 11 12  32 33 34 35 36
-    12 13 14 15 16  71 72 73  1  2 Dsc      13 14 15 16 17  37 38 39 40 41
-    17 18 19 20 21   3  4  5  6  7          18 19 20 21 22  42 43 44 45 46
-    22 23 24 25 26   8  9 10 11 12          23 24 25 26 27  47 48 49 50 51
-    27 28 29 30 31  13 14 15 16 17          28 29 30  1  2  52 53 54 55 56
-Apr  1  2  3  4  5  18 19 20 21 22      Oct  3  4  5  6  7  57 58 59 60 61
-     6  7  8  9 10  23 24 25 26 27           8  9 10 11 12  62 63 64 65 66
-    11 12 13 14 15  28 29 30 31 32          13 14 15 16 17  67 68 69 70 71
-    16 17 18 19 20  33 34 35 36 37          18 19 20 21 22  72 73  1  2  3 Afm
-    21 22 23 24 25  38 39 40 41 42          23 24 25 26 27   4  5  6  7  8
-    26 27 28 29 30  43 44 45 46 47          28 29 30 31  1   9 10 11 12 13
-May  1  2  3  4  5  48 49 50 51 52      Nov  2  3  4  5  6  14 15 16 17 18
-     6  7  8  9 10  53 54 55 56 57           7  8  9 10 11  19 20 21 22 23
-    11 12 13 14 15  58 59 60 61 62          12 13 14 15 16  24 25 26 27 28
-    16 17 18 19 20  63 64 65 66 67          17 18 19 20 21  29 30 31 32 33
-    21 22 23 24 25  68 69 70 71 72          22 23 24 25 26  34 35 36 37 38
-    26 27 28 29 30  73  1  2  3  4 Cfn      27 28 29 30  1  39 40 41 42 43
-    31  1  2  3  4   5  6  7  8  9      Dec  2  3  4  5  6  44 45 46 47 48
-Jun  5  6  7  8  9  10 11 12 13 14           7  8  9 10 11  49 50 51 52 53
-    10 11 12 13 14  15 16 17 18 19          12 13 14 15 16  54 55 56 57 58
-    15 16 17 18 19  20 21 22 23 24          17 18 19 20 21  59 60 61 62 63
-    20 21 22 23 24  25 26 27 28 29          22 23 24 25 26  64 65 66 67 68
-    25 26 27 28 29  30 31 32 33 34          27 28 29 30 31  69 70 71 72 73
-    30  1  2  3  4  35 36 37 38 39 [1970 = 3136] [Next St. Tib's Day in 3138]
-
-                SACRED DOCUMENT OF THE FROGS (old Erisian poem):
-                73 Days hath
-                Chaos, Discord, Confusion, Bureaucracy, and Aftermath
-
-- 
1.8.0

