Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967406AbdLSN3J (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 19 Dec 2017 08:29:09 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 802C87E427
        for <util-linux@vger.kernel.org>; Tue, 19 Dec 2017 13:29:09 +0000 (UTC)
Received: from ws.net.home (ovpn-117-230.ams2.redhat.com [10.36.117.230])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DFA4160C8E
        for <util-linux@vger.kernel.org>; Tue, 19 Dec 2017 13:29:08 +0000 (UTC)
Date: Tue, 19 Dec 2017 14:29:06 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: v2.32 cal(1)
Message-ID: <20171219132906.74xm7nm4r3trr4qq@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


I'd like to do some changes to the command cal(1). The current
implementation provides extra care about year 1752 -- calendar
reformation -- switch from Julian to Gregorian calendar.

The problem is that year 1752 is very specific to British Empire and
for example Catholic Europe moved to the Gregorian calendar in year
1582.

And another countries in another years... for details see
https://en.wikipedia.org/wiki/Gregorian_calendar.

cal(1) is not compatible with another tools (e.g. date(1)) for old 
dates, and it's painful to use cal(1) for old dates as you have no
control about the calculations.

My suggestion:

* keep the current default "British Empire" behavior (Gregorian since
  September 1752)

* add option --gregorian to strictly use Gregorian calendar for all
  dates with no exceptions (it means dates from year 0 to now, no
  exceptions for 1582 or 1752, or so...)

* for --gregorian also use ISO leap years calculation for all dates
  Now we use for years < 1752 simple "year/4" calculation.

* add to the man page section about Gregorian and Julian calendars and
  explain where and when Gregorian calendar went into effect, years 1582,
  1752 etc. (just to avoid discussions:-)

* add option --1752-reform to enable the current "British Empire" behavior
  (default now)

* later (after warning in release notes) we can make --gregorian as
  the default

Comments? Volunteers?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
