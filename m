Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B895EC433F5
	for <util-linux@archiver.kernel.org>; Fri, 22 Apr 2022 08:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445498AbiDVIK7 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 22 Apr 2022 04:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445539AbiDVIKx (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 22 Apr 2022 04:10:53 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E574532D6
        for <util-linux@vger.kernel.org>; Fri, 22 Apr 2022 01:07:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJ+cx2CTgTHksUm9nZ5FHZRAHG71JfPbtbCuwLZPvW1W2X0el1gsrEo5M1kexR7eDFJHmyPPiVOywIDFAS5J+WiXkgYeu2gGItuPcabbNj2fgeKJfWTrg7K5+oFzOBeItZ9l4UM6jck1bnmuf8rNpS9+wSwofrcyyalyDlovMr5U1LkPlIVyBbXCb9YM0GmuQ1N25ynOLK2HkYpzfk1KVSYbcXvKA1H0UENK0DwVZh+VklH3LAbMTDkmyxXMV0H4FNZi7awIIwsRHYldy64ahpI4uD/4e22VP0JHRRD6H+uudKgGnVWH0Pn870pDCeXiAcPPVxktYF/Umc5rmx7sfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qasjyWjvz4Unj7nAva9qhvIbWTFIaRWWiURIX/yTGuo=;
 b=DQeylfzI7KX4FkXBNyNWAHRUpsEVsTHweebWU2sZxDPAo2MPXs72fLsK6hd6BQ2l13aNyhQemuNmiX3/5PyAqDIzJQtS5v4g4luVi2sMR7y0aXwOJwsSXEzLeW2fhjFtZYKvBddsbF5JGe5DvbiC1f8191ihd0W6H59UqTBnUqYUuewh/3AhZScyQk43I8PeAqHaRREFMNfRmr58EwmxMLyf3BhmevAPlqGOyelrdaPDZGNe9HUpxTKSUKmfavcj3mjmigKH2F9VzqBjioDV1rHj1naKmWj6lK8jn+LiFNPHmUGyBiAqABer41syfrrwZY5lmEnXczbLzFdS3lQOWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 155.56.66.103) smtp.rcpttodomain=redhat.com smtp.mailfrom=sap.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=sap.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qasjyWjvz4Unj7nAva9qhvIbWTFIaRWWiURIX/yTGuo=;
 b=GOamxpl+rKUtYljPhRgMJEGm4muldMDk3jllcQjy33VPK5GswP6xKlUgyssEctaUV4cN5yYBcCL7p0+uKm+k1m2cte5Z7lyocCi0GeBO4x4zpP+Px8iJE1zRxZk680r/WwiFvMACq/gmJciBKkACQTPtGQdV+mWyL+uTm1yHpIKYdJG54P+zuzRyhZdwkIGqPrxcmLNSYFjlXVwZ62mDwpEvNvG8u/wnLiXBXgkIumE76HH4CxFX23WnUvH6FT0fKD/RmWwVqsGzMNAkD4mf0MMsP/r/80iM8rFVL02L6PttJ7VLvOKbS71uBdtew7r+GI67sXmCyDAY7LAESceJ0w==
Received: from AS9PR06CA0061.eurprd06.prod.outlook.com (2603:10a6:20b:464::35)
 by DB8PR02MB5945.eurprd02.prod.outlook.com (2603:10a6:10:11f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 08:07:54 +0000
Received: from AM5EUR03FT008.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:464:cafe::26) by AS9PR06CA0061.outlook.office365.com
 (2603:10a6:20b:464::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 22 Apr 2022 08:07:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 155.56.66.103)
 smtp.mailfrom=sap.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sap.com;
Received-SPF: Pass (protection.outlook.com: domain of sap.com designates
 155.56.66.103 as permitted sender) receiver=protection.outlook.com;
 client-ip=155.56.66.103; helo=mail.net.sap;
Received: from mail.net.sap (155.56.66.103) by
 AM5EUR03FT008.mail.protection.outlook.com (10.152.16.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 08:07:53 +0000
X-purgate-ID: 152705::1650614867-000002E7-B0740F07/0/0
X-purgate-size: 1277
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate-type: clean
X-SAP-SPAM-Status: clean
From:   Michael Trapp <michael.trapp@sap.com>
To:     <util-linux@vger.kernel.org>
CC:     <kzak@redhat.com>, d032747 <michael.trapp@sap.com>
Subject: [PATCH] libuuid: improve cache handling
Date:   Fri, 22 Apr 2022 10:07:46 +0200
Message-ID: <20220422080746.29896-1-michael.trapp@sap.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c57051c-46a2-4eab-c4ad-08da243733f3
X-MS-TrafficTypeDiagnostic: DB8PR02MB5945:EE_
X-Microsoft-Antispam-PRVS: <DB8PR02MB59450F2EC8CFAF83DB587F9AF9F79@DB8PR02MB5945.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rKh2KQRRfjiIv/AF7mubUGqku99ZpQV5Z9O0fF51mE+GhpPE9I2ztLberlB/dZb7Nnr3ME9h8AEvbDkM+s+7N9lwR4emASBC389iUl7xqf/xOglM1RYIdgkWzfl+YWp678ga43H/dkJ5LKXE+2YITr6ktDavClghUiLIWDrxNRB9XyPPWnGvgJ5NBDQeKeuA7Q5PpTXtc/WkeE7RxsXBXAcj9RcjSWsIoc4lj7/0MXx1JquhZrTEjVyon60bjnt5KMZ1hOfSQIjnoCaF5jLcG9D0JoynxsVz4okjRmbT+dniRCs+hsGrADutzBofVqerMOsemO+91/CtVGZMmeYh59BxUCCYdBGTMdgPAGAsiX7BUb1wVaIvEeAsSfifj8cVctSxrPyVKjjZOn6ZOCExN8Klb4jKy2qpxK15pthutFnsQuNoB16Sadp+48LmLhvjR1CkrRGp7ffZLRiOKoSFA2qZ077HsuClZJxCluQCDwL7y+zD5BrY6NIrSZD/cSKcA3XCnBw1xZgpc+NbdZpnHF6X4/1OexU7K13QBtRKwJ0iRM3p5ugZsX6dPlM8uYIOX5cjUMubw6VudL7DJfUlJwnD8gQvq7aXW9Ao8kM4k3ot2JtquBui88mpPpSOhSsQkEwzkIclfC6mtbvqhtJ+ou3B7Z3q07nSomGjp607IjNL7loO8zQld2EzQWp3eaqU
X-Forefront-Antispam-Report: CIP:155.56.66.103;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.net.sap;PTR:smtpgw06.mail.net.sap;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(6506007)(356005)(83380400001)(40460700003)(82960400001)(508600001)(6512007)(44832011)(6486002)(8936002)(5660300002)(70586007)(70206006)(4326008)(8676002)(956004)(1076003)(2616005)(6916009)(54906003)(6666004)(186003)(86362001)(36736006)(26005)(82310400005)(2906002)(316002)(336012)(36756003)(47076005)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 08:07:53.9292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c57051c-46a2-4eab-c4ad-08da243733f3
X-MS-Exchange-CrossTenant-Id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=42f7676c-f455-423c-82f6-dc2d99791af7;Ip=[155.56.66.103];Helo=[mail.net.sap]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT008.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5945
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: d032747 <michael.trapp@sap.com>

Short running applications with a few UUID request don't need
a large cache. Therefore increment the cache size over runtime.
---
 libuuid/src/gen_uuid.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/libuuid/src/gen_uuid.c b/libuuid/src/gen_uuid.c
index 76d5371ea..805b40d90 100644
--- a/libuuid/src/gen_uuid.c
+++ b/libuuid/src/gen_uuid.c
@@ -443,6 +443,7 @@ int __uuid_generate_time(uuid_t out, int *num)
 static int uuid_generate_time_generic(uuid_t out) {
 #ifdef HAVE_TLS
 	THREAD_LOCAL int		num = 0;
+	THREAD_LOCAL int		cache_size = 1;
 	THREAD_LOCAL struct uuid	uu;
 	THREAD_LOCAL time_t		last_time = 0;
 	time_t				now;
@@ -453,7 +454,15 @@ static int uuid_generate_time_generic(uuid_t out) {
 			num = 0;
 	}
 	if (num <= 0) {
-		num = 1000000;
+		/*
+		 * num + OP_BULK provides a local cache in each application.
+		 * Start with a small cache size to cover short running applications
+		 * and increment the cache size over the runntime.
+		 */
+		if (cache_size < 1000000)
+			cache_size *= 10;
+		num = cache_size;
+
 		if (get_uuid_via_daemon(UUIDD_OP_BULK_TIME_UUID,
 					out, &num) == 0) {
 			last_time = time(NULL);
-- 
2.32.0 (Apple Git-132)

