Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72B6C433FE
	for <util-linux@archiver.kernel.org>; Mon, 11 Apr 2022 12:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbiDKMot (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 11 Apr 2022 08:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240146AbiDKMos (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 11 Apr 2022 08:44:48 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90059.outbound.protection.outlook.com [40.107.9.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD3E3DA59
        for <util-linux@vger.kernel.org>; Mon, 11 Apr 2022 05:42:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYEDIXEstx7nWPUqDbt7eX7YbaqKtOhnRZvtQ1IQUadZMRd1LputPaC4dFb/WBn5MCJCoKxapp6dqd6JTuCU5CX1kio607jFc2snkw09iJyg+u19Iox7yrT1pjRb5Jin9nHvRPBjddewGW3scrteVlYS9moWr97hFo+rdD3Q4JB/gt2WMOl9TXCwzlzkFPHKlWarTS2Jn2edbfq6WCf/DtlQ9d4bGyFSm1s6yNGuwHDg/Gn1EJza+jTLnysPNB52r7erPP8z+A4jvDFI6JSWtO6RfA+EKmck6E4CZ8H3F7zl18sv8cXwmqKkhEhkUPWE1D8lop0QeLr8iOHUJ6qj1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlYJwj7enV5pTMyfSwyxq574lbk80IUHRPbBSH/ZHtA=;
 b=nRPJ/gI0dk8qwjDtWEIhpQ/YBD7JOfcOl0831UY49PZmFJBVLo92IrmjpPYK/LTxcnDWoG/PtAPwPoaaKmFv0v1ozwGG+MS5rf8CLgi6gkHJ7TXAfUfPzc93NU+SFffKYpJp+FQPrx9qffzhFD9suVdJcLFozA2TkWoPGIDAlIRx+rgHqW9PnVww0ONz546a2ZnYhixeILzn5Kp/XAgcKnAhOO1GcBnjz53IgIXsXjvgO7iX8jUD9fuO+m20xiteAhAqyLMAZ9gFVt+jiavXTD7JxOUj0lx4h1Xofp8UfC90R4/2H1N5LAAlc2biiOQ74RkpE3FzNNdNoPsjhCIqWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=softathome.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlYJwj7enV5pTMyfSwyxq574lbk80IUHRPbBSH/ZHtA=;
 b=cEeZTHYQUR91d6mxAywmPlPdTGqOjTvvGQy/uHLF5UhkmXXc5ETByCzToCcodKlPJs8gd2qNz5cN8KTbJCfRsatDtc8idvlmAOLo70yqzIc75ZECKrRs0gl3GTqJDQu7kqhDBf6HT+HaNAdtMATz4rYQJMmjIdtJY0uB6EGbCmCIW4N0Zugy7/Pd0hn8WH/14lryE/9JETstMg45VrTWe6mjlavcQtLSilIG9b08bFYNc+ajXnukGtRCkWzM4EIOv8s78q9qoKXzNOblDix5k0of0HqRwpSdeU2K/5wPQNuu0NIpdkJBLJIYmaC3f/gJOv2+7T2ppP6kUNoa6C8TFw==
Received: from PR3P193CA0030.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:50::35)
 by MR1P264MB4243.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:25::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 12:42:31 +0000
Received: from PR2FRA01FT009.eop-fra01.prod.protection.outlook.com
 (2603:10a6:102:50:cafe::bc) by PR3P193CA0030.outlook.office365.com
 (2603:10a6:102:50::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Mon, 11 Apr 2022 12:42:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com;
Received: from proxy.softathome.com (149.6.166.170) by
 PR2FRA01FT009.mail.protection.outlook.com (10.152.48.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.20 via Frontend Transport; Mon, 11 Apr 2022 12:42:31 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
        by proxy.softathome.com (Postfix) with ESMTPSA id 19A642005B;
        Mon, 11 Apr 2022 14:42:31 +0200 (CEST)
From:   Philippe Reynes <philippe.reynes@softathome.com>
To:     util-linux@vger.kernel.org
Cc:     Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v2 1/1] libfdisk: write mbr only when useful
Date:   Mon, 11 Apr 2022 14:42:29 +0200
Message-Id: <20220411124229.232299-2-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220411124229.232299-1-philippe.reynes@softathome.com>
References: <20220411124229.232299-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b10d4d0b-c252-4c41-3838-08da1bb8bea0
X-MS-TrafficTypeDiagnostic: MR1P264MB4243:EE_
X-Microsoft-Antispam-PRVS: <MR1P264MB4243D1CC69DED3B98C0A872E88EA9@MR1P264MB4243.FRAP264.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7DT0za6zaOVyffU62tOAnu4N9v0MsJ/FsO2NiuK2Ptqrs7dZ9lGGPrN2+FjAgAvoP5Km4z4KYPOMpjHVGaAKYw8eFiKXHYr64DsWRVNvfD165baZcsTrkQOGUEeGipAoWSIQtCDOENrR1hLL8D3Pcdvz2Upn6oTHSFfgUF7wuyL28FKTqK33Gj37zvYp1QfoxI+H/YNlc16i86FPpyvvRz4jpYjtZn7/PRWqSDOrgYcPwM2flL53NJ63a9tb2CyqhMLevWrv1lkpB9lA0Rh2CgFZ83m5U3r17roPgVjMgXb/kFQOIzBgFyVh6/L0PBjzDUO7at0ytd60hzLWw0sgHljitBRqYsyv+FuyUjfqOZD7cK31viBwnxJBRn9VxARZ/wVSrDwfqBseAeS3GN+2lj7gSFq1TuU7L32oyxWDuCi67xHdlV8bkUK60yDEnzNzibFfNj3fAAqP9oGBPVub7pHsnM2HgY4y56DAE/amMLtkNdzTiugmwnZAPxlqGqoYQwrv4I8tWCR/G1T0ZMOXVbnWQioE6jhwtFb8p9iG9RgZKYFrr3RtzBGbFfVfL2APQGCVIKy5iW7jL/1pdGXM1Ka85cBGhGmVhRaYmiZK0bAym9kNNkh9+EJoL3fpJGPb2jKyWR49dURKz+//ZbAAuHkZoMkeet2Zvf6BmspEM6+9ahdwMPYXdMz6ORtByGJl
X-Forefront-Antispam-Report: CIP:149.6.166.170;CTRY:FR;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:proxy.softathome.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(8936002)(8676002)(6266002)(26005)(5660300002)(2906002)(82960400001)(356005)(70206006)(70586007)(4326008)(81166007)(44832011)(7696005)(426003)(86362001)(1076003)(6966003)(336012)(2616005)(107886003)(316002)(6916009)(47076005)(508600001)(36860700001)(82310400005)(36756003)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 12:42:31.1981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b10d4d0b-c252-4c41-3838-08da1bb8bea0
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511;Ip=[149.6.166.170];Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PR2FRA01FT009.eop-fra01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB4243
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The MBR is critical as it doesn't have
a backup, so we only write it when it
is really useful (ie: the current MBR
is different than the new one).

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
 libfdisk/src/gpt.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/libfdisk/src/gpt.c b/libfdisk/src/gpt.c
index 72370a19a..c6f482fd8 100644
--- a/libfdisk/src/gpt.c
+++ b/libfdisk/src/gpt.c
@@ -2024,6 +2024,19 @@ static int gpt_set_partition(struct fdisk_context *cxt, size_t n,
 	return rc;
 }
 
+static int gpt_read(struct fdisk_context *cxt, off_t offset, void *buf, size_t count)
+{
+	if (offset != lseek(cxt->dev_fd, offset, SEEK_SET))
+		return -errno;
+
+	if (read_all(cxt->dev_fd, buf, count))
+		return -errno;
+
+	DBG(GPT, ul_debug("  read OK [offset=%zu, size=%zu]",
+				(size_t) offset, count));
+	return 0;
+}
+
 static int gpt_write(struct fdisk_context *cxt, off_t offset, void *buf, size_t count)
 {
 	if (offset != lseek(cxt->dev_fd, offset, SEEK_SET))
@@ -2079,6 +2092,8 @@ static int gpt_write_header(struct fdisk_context *cxt,
 static int gpt_write_pmbr(struct fdisk_context *cxt)
 {
 	struct gpt_legacy_mbr *pmbr;
+	struct gpt_legacy_mbr *current;
+	int rc;
 
 	assert(cxt);
 	assert(cxt->firstsector);
@@ -2107,6 +2122,24 @@ static int gpt_write_pmbr(struct fdisk_context *cxt)
 		pmbr->partition_record[0].size_in_lba =
 			cpu_to_le32((uint32_t) (cxt->total_sectors - 1ULL));
 
+	current = malloc(sizeof(*current));
+	if (!current)
+		goto do_write;
+
+	rc = gpt_read(cxt, GPT_PMBR_LBA * cxt->sector_size,
+		      current, cxt->sector_size);
+
+	if (!rc)
+		rc = memcmp(pmbr, current, sizeof(*current));
+
+	free(current);
+
+	if (!rc) {
+		DBG(GPT, ul_debug("Same MBR on disk => don't write it"));
+		return 0;
+	}
+
+ do_write:
 	/* pMBR covers the first sector (LBA) of the disk */
 	return gpt_write(cxt, GPT_PMBR_LBA * cxt->sector_size,
 			 pmbr, cxt->sector_size);
-- 
2.25.1

