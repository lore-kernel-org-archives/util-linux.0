Return-Path: <SRS0=rKDH=AV=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C347DC433DF
	for <util-linux@archiver.kernel.org>; Fri, 10 Jul 2020 00:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A711F2065F
	for <util-linux@archiver.kernel.org>; Fri, 10 Jul 2020 00:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgGJAMq (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 9 Jul 2020 20:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgGJAMq (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 9 Jul 2020 20:12:46 -0400
Received: from inpost.hi.is (inpost.hi.is [IPv6:2a00:c88:4000:1650::165:62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEDBC08C5CE
        for <util-linux@vger.kernel.org>; Thu,  9 Jul 2020 17:12:45 -0700 (PDT)
Received: from hekla.rhi.hi.is (hekla.rhi.hi.is [IPv6:2a00:c88:4000:1650::165:2])
        by inpost.hi.is (8.14.7/8.14.7) with ESMTP id 06A0Cik7031079
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <util-linux@vger.kernel.org>; Fri, 10 Jul 2020 00:12:44 GMT
DKIM-Filter: OpenDKIM Filter v2.11.0 inpost.hi.is 06A0Cik7031079
Received: from hekla.rhi.hi.is (localhost [127.0.0.1])
        by hekla.rhi.hi.is (8.14.4/8.14.4) with ESMTP id 06A0Ci6J030865
        for <util-linux@vger.kernel.org>; Fri, 10 Jul 2020 00:12:44 GMT
Received: (from bjarniig@localhost)
        by hekla.rhi.hi.is (8.14.4/8.14.4/Submit) id 06A0Ci74030864
        for util-linux@vger.kernel.org; Fri, 10 Jul 2020 00:12:44 GMT
Date:   Fri, 10 Jul 2020 00:12:44 +0000
From:   Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To:     util-linux@vger.kernel.org
Subject: [PATCH] Subject: docs: remove unnecessary paragraph macros
Message-ID: <20200710001243.GA30809@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

  Remove a second paragraph macro (.TP, .PP) as it does not change the
output (.SS/.PP) or it adds an extra empty line (.TP/.TP)

  Warning from "mandoc -Tlint":

mandoc: ./sys-utils/hwclock.8.in:299:2: WARNING: line scope broken: TP breaks TP
mandoc: ./sys-utils/hwclock.8.in:459:2: WARNING: skipping paragraph macro: PP after SS
mandoc: ./sys-utils/hwclock.8.in:543:2: WARNING: skipping paragraph macro: PP after SS
mandoc: ./sys-utils/hwclock.8.in:574:2: WARNING: skipping paragraph macro: PP after SS
mandoc: ./sys-utils/hwclock.8.in:673:2: WARNING: skipping paragraph macro: PP after SS
mandoc: ./sys-utils/hwclock.8.in:721:2: WARNING: skipping paragraph macro: PP after SS

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 sys-utils/hwclock.8.in | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index e62b4ad09..84fe4d84f 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -297,7 +297,6 @@ another delay is required.
 .RE
 .
 .TP
-.TP
 .BR \-D ", " \-\-debug
 .RB Use\  \-\-verbose .
 .RB The\  \%\-\-debug\  option
@@ -456,7 +455,6 @@ is doing internally.
 .SH NOTES
 .
 .SS Clocks in a Linux System
-.PP
 There are two types of date-time clocks:
 .PP
 .B The Hardware Clock:
@@ -540,7 +538,6 @@ See also
 .BR \%settimeofday (2).
 .
 .SS Hardware Clock Access Methods
-.PP
 .B \%hwclock
 uses many different ways to get and set Hardware Clock values.  The most
 normal way is to do I/O to the rtc device special file, which is
@@ -571,7 +568,6 @@ provides it for testing, troubleshooting, and  because it may be the
 only method available on ISA systems which do not have a working rtc
 device driver.
 .SS The Adjust Function
-.PP
 The Hardware Clock is usually not very accurate.  However, much of its
 inaccuracy is completely predictable - it gains or loses the same amount
 of time every day.  This is called systematic drift.
@@ -670,7 +666,6 @@ You can use an adjtime file that was previously used with the
 .BR \%clock "(8) program with " \%hwclock .
 .
 .SS Automatic Hardware Clock Synchronization by the Kernel
-.PP
 You should be aware of another way that the Hardware Clock is kept
 synchronized in some systems.  The Linux kernel has a mode wherein it
 copies the System Time to the Hardware Clock every 11 minutes. This mode
@@ -718,7 +713,6 @@ notify the kernel.
 should not be used with NTP \%'11\ minute\ mode'.
 .
 .SS ISA Hardware Clock Century value
-.PP
 There is some sort of standard that defines CMOS memory Byte 50 on an ISA
 machine as an indicator of what century it is.
 .B \%hwclock
-- 
2.27.0
