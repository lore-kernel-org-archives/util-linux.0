Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:52247 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751390AbcCHNhk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 8 Mar 2016 08:37:40 -0500
Received: from assos.lan ([84.185.129.97]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MIQlv-1aZiWR3MBb-0047ld for
 <util-linux@vger.kernel.org>; Tue, 08 Mar 2016 14:37:33 +0100
From: =?iso-8859-1?q?R=FCdiger_Meier?= <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: cal: bug on FreeBSD
Date: Tue, 8 Mar 2016 14:37:31 +0100
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201603081437.31966.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

cal skips the first day of the week if it has 2 digits.

# diff ./cal
 Mo Tu We Th Fr Sa Su
              1  2  3
  4  5  6  7  8  9 10
-11 12 13 14 15 16 17
-18 19 20 21 22 23 24
-25 26 27 28 29 30
+ 12 13 14 15 16 17
+ 19 20 21 22 23 24
+ 26 27 28 29 30

The bug was introduced by my own commit
07ac4aa9  cal: all output must use my_putstring

This is the related code in cal_output_months()

for (d = DAYS_IN_WEEK * week_line;
     d < DAYS_IN_WEEK * week_line + DAYS_IN_WEEK; d++) {
	if (0 < i->days[d]) {
		if (reqday == i->days[d])
			sprintf(out, "%*s%s%*d%s", skip - (ctl->julian ? 3 : 2),
			       "", Senter, (ctl->julian ? 3 : 2),
			       i->days[d], Sexit);
		else
			sprintf(out, "%*d", skip, i->days[d]);
/*                             ^^^^^
 *         if we print this with fputs instead of my_putstring/putp
 *         below than it looks good */
	} else
		sprintf(out, "%*s", skip, "");
	my_putstring(out);
	if (skip < (int)ctl->day_width)
		skip++;
}


Is putp() broken on that machine or could we fix it?

cu,
Rudi
