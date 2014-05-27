Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:53722 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751658AbaE0JqH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 27 May 2014 05:46:07 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: BUG: cal prints bad month headers
Date: Tue, 27 May 2014 11:45:56 +0200
Cc: Sami Kerola <kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201405271145.56596.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

I have a system where "cal -ym" diff looks like this: 
------------
 Gregorian - Monday-based week
-                               2006
+                               2006                                      January               February                 March               April                   
May                   June                July                  August                September            October               November               December
+

-       January               February                 March
 Mo Tu We Th Fr Sa Su   Mo Tu We Th Fr Sa Su   Mo Tu We Th Fr Sa Su
                    1          1  2  3  4  5          1  2  3  4  5
  2  3  4  5  6  7  8    6  7  8  9 10 11 12    6  7  8  9 10 11 12
@@ -10,7 +10,7 @@
 16 17 18 19 20 21 22   20 21 22 23 24 25 26   20 21 22 23 24 25 26
 23 24 25 26 27 28 29   27 28                  27 28 29 30 31
 30 31
-        April                   May                   June
+
 Mo Tu We Th Fr Sa Su   Mo Tu We Th Fr Sa Su   Mo Tu We Th Fr Sa Su
                 1  2    1  2  3  4  5  6  7             1  2  3  4
  3  4  5  6  7  8  9    8  9 10 11 12 13 14    5  6  7  8  9 10 11
@@ -18,7 +18,7 @@
 17 18 19 20 21 22 23   22 23 24 25 26 27 28   19 20 21 22 23 24 25
 24 25 26 27 28 29 30   29 30 31               26 27 28 29 30

-        July                  August                September
+
 Mo Tu We Th Fr Sa Su   Mo Tu We Th Fr Sa Su   Mo Tu We Th Fr Sa Su
                 1  2       1  2  3  4  5  6                1  2  3
  3  4  5  6  7  8  9    7  8  9 10 11 12 13    4  5  6  7  8  9 10
@@ -26,7 +26,7 @@
 17 18 19 20 21 22 23   21 22 23 24 25 26 27   18 19 20 21 22 23 24
 24 25 26 27 28 29 30   28 29 30 31            25 26 27 28 29 30
 31
-       October               November               December
+
 Mo Tu We Th Fr Sa Su   Mo Tu We Th Fr Sa Su   Mo Tu We Th Fr Sa Su
                    1          1  2  3  4  5                1  2  3
  2  3  4  5  6  7  8    6  7  8  9 10 11 12    4  5  6  7  8  9 10
--------------------

This happens only if output is redirected into a file
$ ./cal -ym > bla ;cat bla
It looks good in terminal.  

Reverting 95f4adde (plus 0c6dc4b9 and 4a7424a5) fixes the problem.

The system is a Fedora 18, ppc64. I can't reproduce it on any other
ppc64 system. Unfortunately I don't have any other Fedora 18 for
testing.

cu,
Rudi
