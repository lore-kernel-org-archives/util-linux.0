Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:59319 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751986AbaFDWc0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 4 Jun 2014 18:32:26 -0400
Received: from brln-4dbc076b.pool.mediaways.net ([77.188.7.107]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0MbrR4-1X8KPn0DbS-00JIiA
 for <util-linux@vger.kernel.org>; Thu, 05 Jun 2014 00:32:25 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: tests: hwclock questions
Date: Thu, 5 Jun 2014 00:32:24 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201406050032.24233.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

The test hwclock/systohc needs some fixes because of the following 
issues:
 - ntpdate return value checks ("$?" == "1") are wrong
 - actually ntpdate is deprecated and we should go with "ntpd -q"
 - variable OFFSET should be checked for being numeric to protect "bc"
   and to avoid follow-up errors
 - hwclock loop should break and ts_failed if any hwclock call fails
 - We need to skip case "Cannot access the Hardware Clock via any
   known method"
 - I think we have to protect the user from setting his clock to
   un-wanted time zone (local or UTC).

On travis build server this test succeds allthough neither ntpdate nor 
hwclock works :)


But before doing this I have two questions.

1. I wonder what is the original purpose of this test. Are we really 
testing hwclock or the kernel or hardware? I mean setting and reading 
cock 10 times ... could this really discover a bug in our hwclock code?

2. Why do we _set_ the time from ntp server at the beginning? Wouldnt it 
be enough to check whether the offset to ntp is the same before and 
after the test?

cu,
Rudi
