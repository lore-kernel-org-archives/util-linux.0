Return-Path: <SRS0=1kTP=O2=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCD6C43387
	for <util-linux@archiver.kernel.org>; Mon, 17 Dec 2018 08:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021DB2086C
	for <util-linux@archiver.kernel.org>; Mon, 17 Dec 2018 08:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731817AbeLQIbF (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 17 Dec 2018 03:31:05 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:39823 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731770AbeLQIbF (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 17 Dec 2018 03:31:05 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBH8Q6UG002491
        for <util-linux@vger.kernel.org>; Mon, 17 Dec 2018 09:31:04 +0100
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx07-00178001.pphosted.com with ESMTP id 2pcr8xgu3s-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <util-linux@vger.kernel.org>; Mon, 17 Dec 2018 09:31:04 +0100
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8FA6A22
        for <util-linux@vger.kernel.org>; Mon, 17 Dec 2018 08:31:01 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1674345D
        for <util-linux@vger.kernel.org>; Mon, 17 Dec 2018 08:31:00 +0000 (GMT)
Received: from localhost (10.75.127.49) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 17 Dec 2018 09:30:58
 +0100
From:   Jean-Philippe ROMAIN <jean-philippe.romain@st.com>
To:     <util-linux@vger.kernel.org>
CC:     Jean-Philippe Romain <jean-philippe.romain@st.com>
Subject: [PATCH] dmesg: correct "-n, --console-level level" example in manual page
Date:   Mon, 17 Dec 2018 09:30:54 +0100
Message-ID: <1545035454-30986-1-git-send-email-jean-philippe.romain@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-17_02:,,
 signatures=0
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

When providing an abbreviation of the level name with the option "-n, --console-level level",
it corresponds to the level (included) up to which messages are displayed on the console.
If a level number is given, this level is excluded.

So in the given example, "-n 1" is equivalent to "-n emerg".

Signed-off-by: Jean-Philippe Romain <jean-philippe.romain@st.com>

diff --git a/sys-utils/dmesg.1 b/sys-utils/dmesg.1
index adf5214..a93821a 100644
--- a/sys-utils/dmesg.1
+++ b/sys-utils/dmesg.1
@@ -100,7 +100,7 @@ output.
 For example,
 .B \-n 1
 or
-.B \-n alert
+.B \-n emerg
 prevents all messages, except emergency (panic) messages, from appearing on
 the console.  All levels of messages are still written to
 .IR /proc/kmsg ,
-- 
2.7.4

