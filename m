Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A49C00140
	for <util-linux@archiver.kernel.org>; Tue,  2 Aug 2022 12:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbiHBMQv (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 2 Aug 2022 08:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbiHBMQt (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 2 Aug 2022 08:16:49 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60084.outbound.protection.outlook.com [40.107.6.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB69D1BEB0
        for <util-linux@vger.kernel.org>; Tue,  2 Aug 2022 05:16:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUZl8VXkdebLP/eroLiDlybVMVlb0TNiUIcSH8tkia4GuR/iQymLl4I44/lvVSN+mUosLOkl1kUrOlkjgY3uR/yGDKEonJYWZ77a1eWLAxIcaKFH7VIjBhsx09++aCaLGgyB2Jr08UkPIQU5Jr3aowaNxQaCRNtqAwltFHrSqpwf56RICXp7LZU8oIFN1T/02nVpd/P1vVrV0tmUO+QzxR8HZ3KOSd9ht2pRuyBPSc85/eOpZvixR73MpNEuGl1SFvH+fqnrab3KxkNxi2iJXUnuYAFAyh5qtYZbv8Re7afqUexLRcthAGIEChFEYX+u1yEgsjgUZpZtak2DhVz39w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20s4LIomgeJBJ8EavJ0fItxAniKwqCp3vnkVN4jq/7E=;
 b=Gk90iC0UmAu7a0wom7ZcHjFIZ3sRmL8qouksdzIq/qxFkH8qGKp7hkdZoJP2tgpyERg83ClUqsdI4uyC9f8kEV0gvjnVFQZakWmnx3HBd5NbiKFhlyCc061aR6Xh2PpAc9naYNmkhRVhyWQj1B7nZ3EF3fzE+d2JjFIby1L+/W9BDyRtZJ+yTr1m9LlR3G7nf57xLnmWBVRhGbqSSL2WBleu+jhYpZuoAJtEuWyEt+Bomxq1ClUclXVWIjCBo2p+fqDm6pR6hxlKnyvehECKXoKZtTXatIcqI5uv2mz+gqFiG1s8YNCKk6v/t13r5a5/zQvOVbHbHLBAU6ioL/tVfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 155.56.68.170) smtp.rcpttodomain=redhat.com smtp.mailfrom=sap.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=sap.com;
 dkim=pass (signature was verified) header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20s4LIomgeJBJ8EavJ0fItxAniKwqCp3vnkVN4jq/7E=;
 b=iLuGD58A8cEd2ZXCShHmjNxEQQGFA5hE76UyeRTFEL/AMsvEI6DLaWJ5iDzI6MVH0PVA6nNJ3AIKkzo8INvHRdP4N5j+tOfEoVSb7+kTbNLNQa2pLpi953aTQcib/W3Ah3uVy4f3C9HC87iSKiDnbJZtzl4DDJelniysXtvL/vXJfIKSQQHdUe9O23H8gyK6Ix8DjEYFqu+HdLw+pRzy3P1BfN4Uu2/byJEResaQjnErxkIReJ1HK9vB0lk/g+FibiRwLJJIPNcPB+ltPOl6kO9fP9w63utqss2pEzQZk+q0+MA2oZ4e3I5+tRVMyTG74SQ5TJn9wqc3BKnN5NDYPQ==
Received: from DB6PR07CA0119.eurprd07.prod.outlook.com (2603:10a6:6:2c::33) by
 PAXPR02MB7695.eurprd02.prod.outlook.com (2603:10a6:102:21e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.16; Tue, 2 Aug 2022 12:16:45 +0000
Received: from DBAEUR03FT055.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:2c:cafe::13) by DB6PR07CA0119.outlook.office365.com
 (2603:10a6:6:2c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.6 via Frontend
 Transport; Tue, 2 Aug 2022 12:16:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 155.56.68.170)
 smtp.mailfrom=sap.com; dkim=pass (signature was verified)
 header.d=sap.com;dmarc=pass action=none header.from=sap.com;
Received-SPF: Pass (protection.outlook.com: domain of sap.com designates
 155.56.68.170 as permitted sender) receiver=protection.outlook.com;
 client-ip=155.56.68.170; helo=smtpde01.mail.net.sap; pr=C
Received: from smtpde01.mail.net.sap (155.56.68.170) by
 DBAEUR03FT055.mail.protection.outlook.com (100.127.142.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.12 via Frontend Transport; Tue, 2 Aug 2022 12:16:45 +0000
X-purgate-ID: 152705::1659442605-4A85A369-667E0C9A/0/0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com;
        s=it-20211118; t=1659442605; x=1660738605;
        bh=20s4LIomgeJBJ8EavJ0fItxAniKwqCp3vnkVN4jq/7E=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From;
        b=R5cFs8dplR350LzCCBuzBNKelRvYwPPCyRGGk4+KOUfYgPcUFZf6bM5c+GW+/uVm2
         F4aEYpIh2Qtxas+F1Vz9AdtzmPBOK0WCUqOh/zjQ/1sidY0SRCGutEov8HuiYxsA+u
         On5xKQVLPbNB/o6U3MNsQCE9fvzMMH8qIPZY79Co7TtzAZnEqMLb+F/XZJUI2DIli5
         hPBMSMA5ZEegn231fxnvbmFlTwRnju3tMmZ0hy0oIZMm5W+dK+tDYfMlUBETjHvnGC
         pywekVNti8A8MTfP41Px1wfLlswFD8kedlR3Ar7yi1DBRLgrRVtiIiFUexkKlVx6Xb
         ItLR7gCkEZEUw==
X-purgate-size: 728
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate-type: clean
X-SAP-SPAM-Status: clean
From:   Michael Trapp <michael.trapp@sap.com>
To:     util-linux@vger.kernel.org
Cc:     kzak@redhat.com
Subject: [PATCH] libuuid - check clock value from LIBUUID_CLOCK_FILE
Date:   Tue,  2 Aug 2022 14:16:43 +0200
Message-Id: <20220802121643.29565-1-michael.trapp@sap.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 30f10d61-9802-4931-8a8f-08da7480ddfb
X-MS-TrafficTypeDiagnostic: PAXPR02MB7695:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZS2B1WeSvbdrfCE9Wo8L8ejIC+pM+kvN20sXSf6K03U6mYHPsgTUZA2EpXD9kknCjS3XsoK8DCDYLT9Ds3adJvQ8fHCKJaePvhbWHEL9d1Tn1qv55OxRuA08WvMgWIq8zN104YlEXPzkVlhjnvF/4UJCMMJAaUSzh59LyRyXySB+W+EKB8FXJgAd6JYv3vLjdqfmtKaXNFE/ZFtQGbMfNRA2b6Rxv4UPxn/JizLqwvnmrA5cscnoNSpmAq+ye5nix/cuQnQ/EBfPRrPYZZS1YppmbwSoJQD52N9L8bLuhbx1FMcql/9GDbe1onXI9NzOf4t9c8oXn2Ld0bFc1r1Mf9qCVpav2MJqaVQL88++1CsLWCu2ZNVs5Z29/ZtMBGRVXFosI3FukQqIGnz9Ak5HFTCjN24apPUldn1DM0tzlo0NGGILnWlsEhu5h3X42ZtrcZPX0k/K7H13qnI1SvABVXbmIXuWIv+bivMtIFL1QFgt4D8zkIxbGkPadM50ajDDeGHVGwpu9ADDGBaXtYIedybm3eDxID/qgz4mpL0cC8MbK0BrR8Pw0uht7BhI64yV8AyJDneLE7QN/+u5v0BszRmaM89tq0xflK6W8950XDmDczxpz5B1BwoCQ1ORyHH9e1Ln+EspqasSxVpuubhDirnbBRl/ZDkU5ITi6P4HyZDgxVtKd4TCuKEmoN+8q8WujBtjL2FONkcVBh9nBLg5/7nZVpG1lP5u55pKPMsvjNdrICM5NBCD0PZrNvaP6HTn9RgfwIrmxOW3UomGvv4C/nrmkaC9TNksa6OhSQ+7XxM1iHHrck9jWYE6ZFXyAogL
X-Forefront-Antispam-Report: CIP:155.56.68.170;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpde01.mail.net.sap;PTR:smtpde01.mail.net.sap;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(376002)(346002)(396003)(36840700001)(46966006)(40470700004)(44832011)(83380400001)(4744005)(1076003)(2616005)(956004)(36860700001)(336012)(186003)(47076005)(8936002)(36756003)(2906002)(8676002)(5660300002)(4326008)(70206006)(40480700001)(36736006)(82310400005)(6916009)(478600001)(41300700001)(6506007)(9316004)(6512007)(26005)(82740400003)(316002)(40460700003)(86362001)(7596003)(6486002)(356005)(82960400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 12:16:45.4294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f10d61-9802-4931-8a8f-08da7480ddfb
X-MS-Exchange-CrossTenant-Id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=42f7676c-f455-423c-82f6-dc2d99791af7;Ip=[155.56.68.170];Helo=[smtpde01.mail.net.sap]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DBAEUR03FT055.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB7695
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The clock value from the LIBUUID_CLOCK_FILE must be checked in
case of an update of libuuid. If clock==CLOCK_SEQ_CONT it must
be set to a new value.
---
 libuuid/src/gen_uuid.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/libuuid/src/gen_uuid.c b/libuuid/src/gen_uuid.c
index 807dcd115..e1ba3c3d0 100644
--- a/libuuid/src/gen_uuid.c
+++ b/libuuid/src/gen_uuid.c
@@ -274,6 +274,11 @@ static int get_clock(uint32_t *clock_high, uint32_t *clock_low,
 			last.tv_usec = tv2;
 			adjustment = a;
 		}
+		// reset in case of reserved CLOCK_SEQ_CONT
+		if (clock_seq == CLOCK_SEQ_CONT) {
+			last.tv_sec = 0;
+			last.tv_usec = 0;
+		}
 	}
 
 	if ((last.tv_sec == 0) && (last.tv_usec == 0)) {
-- 

