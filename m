Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:58775 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734AbaE0Kuo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 27 May 2014 06:50:44 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: Re: BUG: cal prints bad month headers
Date: Tue, 27 May 2014 12:50:41 +0200
Cc: Sami Kerola <kerolasa@iki.fi>
References: <201405271145.56596.sweet_f_a@gmx.de>
In-Reply-To: <201405271145.56596.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201405271250.41256.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 27 May 2014, Ruediger Meier wrote:
> This happens only if output is redirected into a file
> $ ./cal -ym > bla ;cat bla
> It looks good in terminal.
>
> Reverting 95f4adde (plus 0c6dc4b9 and 4a7424a5) fixes the problem.

Just another hint. Adding a fflush() like you see below also "fixes" the 
problem. Maybe we are mixing several output methods (printf, puts, 
my_putstring, etc.) like we shouldn't.

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 81375fe..2b61a30 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -760,6 +760,7 @@ static void yearly(const struct cal_control *ctl)
                set_consecutive_months(&m1, month, ctl->req.year);
                for (i = &m1; i; i = i->next)
                        cal_fill_month(i, ctl);
+               fflush(NULL);
                cal_output_header(&m1, ctl);
                cal_output_months(&m1, ctl);
        }
