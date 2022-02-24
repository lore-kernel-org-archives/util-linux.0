Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF1BC433F5
	for <util-linux@archiver.kernel.org>; Thu, 24 Feb 2022 10:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbiBXKra (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 24 Feb 2022 05:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbiBXKra (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 24 Feb 2022 05:47:30 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68DCBD890
        for <util-linux@vger.kernel.org>; Thu, 24 Feb 2022 02:46:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tqi/RZ4QJXxfx+VLYWeIU7kqvFpAzO+oQC9qmRwE2UrnzF/Jas9VW77iP46bYyQ293Qt7OmwGJVBN4sCKAfkNIU874gggFkNHbQBZ4PWa4+SoDoav09fUu2A6Z4+Duh/Dyvo3sY92cfx3N9J1B/f/bqmwI+Rl/yUIldQokXT9GQxwcRZUX3GoMESnv4i53Zgwj9WKQGXlB7VO1iy+0+pKNs7KsSecbX1wgE7FwwGuRnrCRFPjL/9Gx8/LNHeVTuq1owLmpHGpr/tEwAYamwGC47M6rOZCN7HzhEvTfntwpQtszZo/WwMMn93ni6ks9fBUu0pkayYaXFlCRRibQVdLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ap/XfvHljCo2THqhg/hHP8gZkGBKjd6DVnaAVYphQtE=;
 b=hUl+4C0Hs7mZEHMBJn+akH2uDbpy1+drTV8glDRTNkYyeuS/DyGKVkfy8OnlgIuxDhnKI7K1vxNU1DNAU2HdbiErRkoLevc6s5APde/cTnGdor5SwXmcFtQnpQI2innfxaDMSR9s9vrmM+uRwLiSWUCAQ8Wn3SZg1k/GG4oeFjToxk8T3KLwLdDdaV5W+u3LbJMUm0YRfz8BqhlJiIoGgXz8ZvJifBDy9e9RR3MYHV4VjWxLGBrXJ0trCTJZGBZ/HuLefQ5RXgLK+JbVpa6KZLBgmGBh2whlv0H9so8HGXo0woupmshhNbet1feDHik28lvxmcozdikTw0qowM/Khg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 155.56.66.103) smtp.rcpttodomain=redhat.com smtp.mailfrom=sap.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=sap.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ap/XfvHljCo2THqhg/hHP8gZkGBKjd6DVnaAVYphQtE=;
 b=CTEph1fizeJM0/gn+mM9PvxPKqDeJ/FwuyWsnTklZqvhz3vgyLYWhIv4V9vwRBIEgd/LEckzWg3DanLqY/WFIXrNJ4+sIpjV14dnkwuyMU28D93ycZDp2uV7/z+SPAPkctmEF5jx2xzhs98MZ2sMapr/9kxNCNdJtkEG2fe25U0xh1tCp72YRL/vHGU+y82Ea1muqXZ59E2ylbC7aEGShLF80SQ+H49r1DI/fWrZvFH68U7zFFuhncIF+3IiETOLYhXiys+V3A6ooEXh/6NTAbWt8rPsb5hqsAwXxxm4RP70tKufkNBNBMI3Q3+qBQ1nvGiMn24/PxQ9ZEzuIXmugA==
Received: from AS9PR06CA0227.eurprd06.prod.outlook.com (2603:10a6:20b:45e::16)
 by DB9PR02MB7997.eurprd02.prod.outlook.com (2603:10a6:10:373::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 24 Feb
 2022 10:46:56 +0000
Received: from VE1EUR03FT004.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:45e:cafe::7e) by AS9PR06CA0227.outlook.office365.com
 (2603:10a6:20b:45e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Thu, 24 Feb 2022 10:46:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 155.56.66.103)
 smtp.mailfrom=sap.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sap.com;
Received-SPF: Pass (protection.outlook.com: domain of sap.com designates
 155.56.66.103 as permitted sender) receiver=protection.outlook.com;
 client-ip=155.56.66.103; helo=mail.net.sap;
Received: from mail.net.sap (155.56.66.103) by
 VE1EUR03FT004.mail.protection.outlook.com (10.152.18.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 10:46:56 +0000
X-purgate-ID: 152705::1645699613-00000270-403FAEC5/0/0
X-purgate-size: 1699
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate-type: clean
X-SAP-SPAM-Status: clean
From:   Michael Trapp <michael.trapp@sap.com>
To:     <util-linux@vger.kernel.org>
CC:     <kzak@redhat.com>
Subject: [PATCH] libuuid, extend cache in uuid_generate_time_generic()
Date:   Thu, 24 Feb 2022 11:46:51 +0100
Message-ID: <20220224104651.74944-1-michael.trapp@sap.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cff9d4aa-9680-4d1f-9fb6-08d9f782fa34
X-MS-TrafficTypeDiagnostic: DB9PR02MB7997:EE_
X-Microsoft-Antispam-PRVS: <DB9PR02MB799721D1EB2A48E469D4C50BF93D9@DB9PR02MB7997.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4+dni62ehUzFypTsW84z6fWc1tMcvSJ/69LuIftUV113wAEhlAdtscSWQKmZxV8SEj1a0oCoideJ1fJFvmioovvYEjdsURx6vFPbLFLJh1K4VOOAN6k05hUJU0wDwCOTRW9c80c9bULDrZBGYwVyoCv5GZNPjiZJq7ci0AV+kpQwlUQ8nxcO4JPAt2O+Ltk+IjVKoiqsY7Um1xa+CIjyBCITRX/qN7NtjhiVXGW0rVxPblvmHik2cKbkIHQ6xNg3bPXLJK+MXLGt59kvgXzIyq3Pg/NyToOUHuMvOdbnOCjX2XE+hfxg82Oq95C2IM0UivvL6DGhKdJU2mpcPwabkCQAQYbZziIppmtoyrut1c/CS8EZQisgShIO50L6nv3ATsM5BRcrDJRLDoTSMxBPjANuFKXUpYEPQ/AfqpnxQGploh+Gg8v6+jx3ThG1QgTcnZzZWpDcI/TPvyJq2wBEKu2GLaeeGAcKUWulx0pJI5m+0tmdhNfn0mb9dOlmOw3VHqlJpjVgpLas5XAZLiCkdtkkN2AVXLy0cIlmnd5puO/t/04U7CfoXegL6DPW51BaiSMAw0zLpSocLXqayXzne2yJSmeJDqTlkUdOec3UqdVTjpdnN2L/Zey/uXG1cTLYVkavM9E0wFtPqcP8UOWA8MZFUZvfUQKrtlusYozE6ylYrETW3DBwZ+jR6Cxiaedn3B42Fc8vwmRbEGbETEjEJQ==
X-Forefront-Antispam-Report: CIP:155.56.66.103;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.net.sap;PTR:smtpgw06.mail.net.sap;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(8936002)(82310400004)(47076005)(6506007)(1076003)(26005)(508600001)(4326008)(8676002)(316002)(336012)(36860700001)(2906002)(86362001)(356005)(6486002)(6916009)(44832011)(5660300002)(70206006)(6666004)(70586007)(82960400001)(186003)(40460700003)(956004)(36736006)(36756003)(6512007)(2616005)(83380400001)(41533002);DIR:OUT;SFP:1101;
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 10:46:56.4289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cff9d4aa-9680-4d1f-9fb6-08d9f782fa34
X-MS-Exchange-CrossTenant-Id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=42f7676c-f455-423c-82f6-dc2d99791af7;Ip=[155.56.66.103];Helo=[mail.net.sap]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT004.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7997
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Improve throughput and reduce clock sequence increments
for high load situation with time based version 1 uuids.
---
In a high load scenario, where an application continiously reads time
based version 1 uuids from uuidd, we have noticed the following
behaviour.

The application reads more uuids as there are available in the
corresponding timeframe and each bulk request results in an increment of
the clock sequence because of the 'step back' in time. Due to the
14bit size of the clock sequence this also results in overflows of
the clock sequence.

As uuidd calls
    uuid_generate_time_safe()
       uuid_generate_time_generic()
the default value for the bulk request in the '#ifdef HAVE_TLS' section
of uuid_generate_time_generic() is set to 1000.

Extending the 'cache' of uuid_generate_time_generic() by increasing
the default of num to 1000000 doesn't solve the issue, but reduces
the clock sequence increments by factor 1000 and it also improves
the uuid throughput in our setup by factor 3-4.

It might be possible to implement a cache for
  UUIDD_OP_BULK_TIME_UUID
  UUIDD_OP_TIME_UUID
in the uuidd request handling, but it would not be as simple as this fix
in uuid_generate_time_generic().

 src/gen_uuid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/gen_uuid.c b/src/gen_uuid.c
index f2b30e1..12c2f09 100644
--- a/src/gen_uuid.c
+++ b/src/gen_uuid.c
@@ -475,7 +475,7 @@ static int uuid_generate_time_generic(uuid_t out) {
 			num = 0;
 	}
 	if (num <= 0) {
-		num = 1000;
+		num = 1000000;
 		if (get_uuid_via_daemon(UUIDD_OP_BULK_TIME_UUID,
 					out, &num) == 0) {
 			last_time = time(NULL);
-- 
2.28.0

