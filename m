Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752725AbeA3PkD (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 30 Jan 2018 10:40:03 -0500
Date: Tue, 30 Jan 2018 16:39:54 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org, J William Piggott <elseifthen@gmx.com>,
        Ruediger Meier <sweet_f_a@gmx.de>
Subject: cal(1) summary
Message-ID: <20180130153954.yi3p2muaw5k6t5rt@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Maybe we need to summarize all ongoing issues, regressions, and
features etc. I'm a little bit losing in all the changes ;-)

I have also fixed some things and updated regression tests.

* -y header
    - not sure if we need a change here to use "Month Year" in all
      cases (???)
* -1
    - has to behave like cal with no option (FIXED)

* -3 and -y width issue
    - number of months in row by terminal width on terminal (FIXED)
    - for non-terminal don't care (FIXED)

* -3|-1|-n<N> <year>   default month issue
    - let's use the current month if year specified (seems FIXED)
    - follow requested number of months (FIXED)

* add --calendar-system-header on|off (default *OFF*)

* support another (non-UK) --reforms <name>
    - let's postpone this until next release

* remove tailing extra blank like (reported by Mike year ago;-)
    - FIXED

* extra blank space after last month column
    - FIXED 
    - for old versions see (cal -y  | sed 's/ /*/g')

* update regression tests
    - FIXED
    - (!) Please, next time I'll ignore patches (sets) where is no
          update for our tests.
* ???

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
