Return-Path: <SRS0=5SnE=Z2=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BTC_ID,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799C0C43603
	for <util-linux@archiver.kernel.org>; Wed,  4 Dec 2019 14:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BBE3207DD
	for <util-linux@archiver.kernel.org>; Wed,  4 Dec 2019 14:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfLDOqf (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 4 Dec 2019 09:46:35 -0500
Received: from smtp2.cict.fr ([195.220.59.17]:43284 "EHLO smtp2.cict.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727850AbfLDOqf (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 4 Dec 2019 09:46:35 -0500
X-Greylist: delayed 567 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Dec 2019 09:46:34 EST
Received: from smtp2.cict.fr (localhost.localdomain [127.0.0.1])
        by smtp2.cict.fr (8.14.5/8.14.4) with ESMTP id xB4Eb60L026589
        for <util-linux@vger.kernel.org>; Wed, 4 Dec 2019 15:37:06 +0100
Received: from irsamc.ups-tlse.fr (irsamc.ups-tlse.fr [130.120.228.23])
        by smtp2.cict.fr (8.14.5/8.14.5) with ESMTP id xB4Eb6gJ026586
        for <util-linux@vger.kernel.org>; Wed, 4 Dec 2019 15:37:06 +0100
Received: from webmail.irsamc.ups-tlse.fr (irssv1.ups-tlse.fr [130.120.228.21])
        by irsamc.ups-tlse.fr (Postfix) with ESMTPSA id A22CF361EDF
        for <util-linux@vger.kernel.org>; Wed,  4 Dec 2019 15:37:06 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 04 Dec 2019 15:37:06 +0100
From:   pierre@irsamc.ups-tlse.fr
To:     util-linux@vger.kernel.org
Subject: Subject: [PATCH] Fix adjtime documentation
User-Agent: Roundcube Webmail/1.4.0
Message-ID: <8c9af50033cf8d287a8df373d4cade93@irsamc.ups-tlse.fr>
X-Sender: pierre@irsamc.ups-tlse.fr
X-Virus-Scanned: clamav-milter 0.97.3 at smtp2.cict.fr
X-Virus-Status: Clean
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The first line of the adjtime file is made of three numbers (see 
hwclock.c)
- a drift factor as a decimal float
- the time of last adjust as a decimal integer
- a zero (for compatibility) as a decimal float.
but both man pages (hwclock.8 and adj_time.5) tell that the third number
is a decimal integer.
Of course this is harmless if somebody edits the adjtime file with "0" 
as
the third number: it will be correctly read by hwclock anyway.
But if for some reason, a program reads the adjtime file and expects an
integer, it will fail, because hwclock writes O.OOOO0O as the third 
number.

Signed-off-by: Pierre Labastie <pierre.labastie@neuf.fr>
---
  sys-utils/adjtime_config.5 | 2 +-
  sys-utils/hwclock.8.in     | 2 +-
  2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/adjtime_config.5 b/sys-utils/adjtime_config.5
index 049d4c585..fcdc7bf6c 100644
--- a/sys-utils/adjtime_config.5
+++ b/sys-utils/adjtime_config.5
@@ -36,7 +36,7 @@ the systematic drift rate in seconds per day (floating 
point d
ecimal)
  the resulting number of seconds since  1969  UTC  of  most recent 
adjustment or calibration (decimal integer)
  .TP
  .B "adjustment status"
-zero (for compatibility with clock(8)) as a decimal integer.
+zero (for compatibility with clock(8)) as a floating point decimal.

  .SS Second line
  .TP
diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index 6c3a2e6ac..e62b4ad09 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -652,7 +652,7 @@ in seconds per day, floating point decimal; 2) the 
resulting number of
  seconds since 1969 UTC of most recent adjustment or calibration,
  decimal integer; 3) zero (for compatibility with
  .BR \%clock (8))
-as a decimal integer.
+as a floating point decimal.
  .PP
  Line 2: One number: the resulting number of seconds since 1969 UTC of 
most
  recent calibration.  Zero if there has been no calibration yet or it
-- 
2.24.0
