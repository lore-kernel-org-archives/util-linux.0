Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803A7C433F5
	for <util-linux@archiver.kernel.org>; Fri,  8 Apr 2022 12:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiDHMMW (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 8 Apr 2022 08:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiDHMMV (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 8 Apr 2022 08:12:21 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120043.outbound.protection.outlook.com [40.107.12.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA66275D7
        for <util-linux@vger.kernel.org>; Fri,  8 Apr 2022 05:10:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hn7CQvSXQ9pV82VbIbq/c/Jwzf8qyzuN12jaqXtmPXeS8G2GMYUjzbZwI2oGaAxlkdTsiQaQbVG63kKM2oxGYGWVPK3NCatvtCYmV8cK0DGfQGrVtfZ5Su7kbAkaM3TGVaDum7CNm++PIZX1GsgSJ/9nq1ENcTMk3hEdoExyXZ7tlhPqLS/0eYwo2VzZapNUYyz1yMbhmcxSOgWKbu0Mf+dcSGWZGoYpmQYSVkVvTM01R2TR5WpITb692QVzd0HG+tYy5GZLHqGKSz9xNu6CbMPdgy71lyvWWS2ZEr4uVOg5SXru/5wQZYsoBMWuFO+3GRRzplvYPbnYVfY/bVt1ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dt2s+OnH2kt0ETidyYmHGD4Tq1qDpyT+s1kdHzxkcEc=;
 b=H/vaUbVsJjISjmWpTfEzcPtpJ9oPWBwpUhFagBpwudSIXflgAm1iLTHaQI9+yx6k+K7Krgf8xQOjgsWldfgEE+GW8NxYGbsqE0TLjHiAfEMhveoNsIoFV4lXqxgieUaIKRHumidvACHIbtZWzcU12cui2iPUgcEzItQQexmlEAJe+yNGPEIUo1DCp2U/P0l5dFy8YbhWiq5nz4Y/6p0twrRYuEmpmKTz5hYs7PpqanqBtqQmNexR6mjZVtFx5uZSDhDYbLiFjARKVX4lE/4m+9z95rLytgDFiV/hqsuMJQdoXcIkcUP7Pf77PLPCWymuGB/j3s8dZi9HzZvsa6wCUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=softathome.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dt2s+OnH2kt0ETidyYmHGD4Tq1qDpyT+s1kdHzxkcEc=;
 b=QKlZrTP9Js3bxF2mlICiU81HblEnPqNKTBObPADSN9NoGhx2ySWH8ZDcfsPLlG6i/nC8S6QDUkKVEd95taqOeawp7rGebhccbf7oFMxb4SkHe2h+8zu+sDg0JbSJ5ozy2FNYU75UW+1UKb3Ymkqefa/fmzEtylK0jMD57ga4u19AeSOL+6mgTVDWImObyKZSJH2MW0KZA/yDO0cAhTq80Ga2HlcKgc0JjHju/EkaORSWhZf6Ut/ohlsylTjhGRPlCG/KlCWGiNHIYpPA7ygLvSshLWGaI6zTTfcmDdjPDXwUEtbXZfUW1aYYj9BGG8V3FFNYt4Uwyg2tR4/VArJ2iA==
Received: from PR3P251CA0016.EURP251.PROD.OUTLOOK.COM (2603:10a6:102:b5::8) by
 MR1P264MB1539.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.25; Fri, 8 Apr 2022 12:10:15 +0000
Received: from PR2FRA01FT005.eop-fra01.prod.protection.outlook.com
 (2603:10a6:102:b5:cafe::cb) by PR3P251CA0016.outlook.office365.com
 (2603:10a6:102:b5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.25 via Frontend
 Transport; Fri, 8 Apr 2022 12:10:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com;
Received: from proxy.softathome.com (149.6.166.170) by
 PR2FRA01FT005.mail.protection.outlook.com (10.152.48.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 12:10:14 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
        by proxy.softathome.com (Postfix) with ESMTPSA id CFD6D20040;
        Fri,  8 Apr 2022 14:10:14 +0200 (CEST)
From:   Philippe Reynes <philippe.reynes@softathome.com>
To:     util-linux@vger.kernel.org
Cc:     Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH 0/1] libfdisk: write mbr only when useful
Date:   Fri,  8 Apr 2022 14:10:03 +0200
Message-Id: <20220408121004.183615-1-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1f070691-cd95-4308-eabe-08da1958bd51
X-MS-TrafficTypeDiagnostic: MR1P264MB1539:EE_
X-Microsoft-Antispam-PRVS: <MR1P264MB15399A8C3F2117A64165A2DA88E99@MR1P264MB1539.FRAP264.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: btNw8BB8AnmAEnn1jiOmKHCvUHT/5g8FJqA+1yfPl6AXZckOMuV1/4tVc/a+N03SYL8/RL+QUELYsCdHxGaKn8dRsrW1PVKM3n5LdyW6g/N2K6afa9g5RJmjPreOIdxAJP1x5U3brtNSzY4BxfsEwiFPsA/WONo9onjSy42ahGrQTSQHYWhWgc8fRIYjyTcYntT5t0kJkQxPLP6tYGVCHLPgvFfHqusRvgS/MjR1uv2De34/OZMUYHsE73Kr0qbCDKKuJCWmhnuIlWcnmbwsTe3Hmt1L67S2F4dP9HdTvr4TI19EuyoNzFQHm6d5Z2A2wUtzBFErDw1dlSrt+JANBIiW50NDWDIFk9MFi9JTOGT8XKWcMR17wij51myq3ds18MzpewuaxA91eas95MFFMXNKHs8fP/y3LLZrBDPOg4paFIk0wNq6Z/oVISi5P3P30xQcwg0XkhB49gr1nYsnKuFNbdRSCi2cYFtYrmRY7JgwavXp9r8tQaBh2eOb7pxLrKzeU1JR4xMRLWmzB66mCisN/NhFPEgxPCwcwT0gLmbtxR1gm9/7YGgKIy0LWty2t/XkqzC1t2TPtmIrYItSl15uSDVoT395cTDkEOWDT8/pUw/En2pldGK4+oljQxFIaqiJh+PXpCniOlULn2XEXgoHwWhYArddmpvkcfdSk6fMSYbl5lHgXGtDbumqHWNc
X-Forefront-Antispam-Report: CIP:149.6.166.170;CTRY:FR;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:proxy.softathome.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(8676002)(4326008)(7696005)(6666004)(86362001)(356005)(83380400001)(70586007)(70206006)(2906002)(508600001)(36756003)(81166007)(6916009)(6966003)(316002)(6266002)(47076005)(2616005)(82310400005)(8936002)(44832011)(5660300002)(186003)(426003)(1076003)(26005)(336012)(4744005)(107886003)(36860700001)(82960400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 12:10:14.9956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f070691-cd95-4308-eabe-08da1958bd51
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511;Ip=[149.6.166.170];Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PR2FRA01FT005.eop-fra01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB1539
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The MBR has no backup, so any failure when writing it
may leads to critical issue. But when only using gpt
partition, the protective MBR is always the same. It is
useless to write it each time the gpt partition table is
updated.

Usually, the gpt is not written in the life of a product.
But in case a product uses a dual bank scheme to update
a board, the new version of the firmware will be written
in backup partitions, and then swap the name of primary
partitions and backup partitions. This leads to update
the gpt table at each update.

A failure while writing a gpt table may be recoved at
next boot, but a failure when writing the protective
MBR could break the board. So this patch removes useless
update of the MBR, enhancing the reliability of the gpt
table update.

Philippe Reynes (1):
  libfdisk: write mbr only when useful

 libfdisk/src/gpt.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

-- 
2.25.1

