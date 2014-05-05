Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:48096 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799AbaEEStD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 5 May 2014 14:49:03 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 0BA89AAF1
	for <util-linux@vger.kernel.org>; Mon,  5 May 2014 18:49:02 +0000 (UTC)
Message-ID: <1399315741.11780.36.camel@oct.suse.cz>
Subject: [PATCH 0/2] hwclock: Fix excessive adjustment
From: Stanislav Brabec <sbrabec@suse.cz>
To: util-linux@vger.kernel.org
Date: Mon, 05 May 2014 20:49:01 +0200
Content-Type: text/plain; charset="ISO-8859-2"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Algorithm of calculation of hwclock adjustment is vulnerable to
miscalculations. These miscalculations may lead to clock drifting by
many years even after fixing CMOS hwclock failure.

Following two patches are attempts to solve the most visible parts of
the problem:
- Calculation of excessive drift values in /etc/adjtime
- Applying of excessive drift that causes many years clock failure.
- It also prevents hangs before 4a44a54b.

There are further poor places in the code that are above the scope of
this patch set:
- Algorithm for detecting of invalid hwclock is very poor (valid_p fails
  only if hwclock output fails to pass mktime()).
- There is no or failing discrimination between fine time adjustment and
  clock set.
- In particular, proposed patch does not cover miscalculation while
  changing clock due to DST change, and more than 2 days passed since
  last adjustment. This could be covered by lowering of MAX_DRIFT, but
  heuristics for discrimination between adjustment and clock setting
  would be much better.
- Most of failures fixed by these patches were hidden by a poor
  calculation of time passed since last adjustment:
  if ((hclocktime - adjtime_p->last_calib_time) < 23 * 60 * 60)
  (As there is no abs(), all times in past were considered as "less than
  one day ago".)

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76

