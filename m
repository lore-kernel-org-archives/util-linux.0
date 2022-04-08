Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FDDC433EF
	for <util-linux@archiver.kernel.org>; Fri,  8 Apr 2022 12:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbiDHMMW (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 8 Apr 2022 08:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiDHMMW (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 8 Apr 2022 08:12:22 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120050.outbound.protection.outlook.com [40.107.12.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3519A2F004
        for <util-linux@vger.kernel.org>; Fri,  8 Apr 2022 05:10:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9m+UO9YPMFo1rHu577pTd0iUlP+RF5rm9sN7QYyF4/suAVgyblaFtOWvl4u1a3rShYzlX17XGA/7+V0bHh8Ed2hoqXpJax5B34rpNS4VSDNdoZUIHDEXIoR7lgvBQ4m4WbNeWmfYzrudrdj3kViG30qLRQOXdz+FJ/yJADEXJJ+U0bN3u9tBMKBSpahVTlPG/QVb3K0YKQS3Ywa4h9aTb/4BQC7NMX2LEFfP2JAYghguvLrxtN2OB6LZxStkdBTRtfi2m9AwPXSCGKn2BcH+uAyv7KL1RkVk7m+AlSC/pLWGSU1mJq5GnsZ4odeD87CZ+wsgpAFvnXKdyZpHeDnHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I69zmHTxb2XTNG3Yda04dv8KQxiWt34JEBgNhKIxybA=;
 b=LJjO/7bGPEkktQNcxGaIWoswnN4kKyrxvTj27NFT/ynaxbcRFvF2FzgalXnyYs4Clo6/sn5KhK6H20EmA9T+qmF6lP99ZBLo/St1pQw3m5XbjDR92EXyD0pb9/G0btENEl/9FVP9FTRJ9kXgW4TOUp3RsiGZDrN0Yi+tMxxb9L7TRnuAz97bi1igImRTkJF7u8qJaCHmM7nWUBpP268xQFP/nZY+NbKmA95vXgY7nj5odk0Sg2xFpQ3IqkSfbevgst2sDDznjlsgqLBsVvX6dl7Mf6WeiknZpvWeYgTFRYYNw5XmztTcFlWp2pHABmLIX86P0MUr5bzlZ0ticUv3Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=softathome.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I69zmHTxb2XTNG3Yda04dv8KQxiWt34JEBgNhKIxybA=;
 b=Ppq2mpa2kSYdlxp/ldrXHt7d8Y0BKoF4iAdYnocoNJu38Ty7zoUsfUPqWE5dajGhQexv992lUIGs4wejY8zFzvB3b3SlhR3+b9TM7WizZFHJ2uTJAVL6USFFKSuiosMo2LMZo8qr1o3SwsLV45b8rHIAa2zE6nIhrvZrEDNQquoIFSegraJ/CyvQl9zF+INEc+P263XXZSnDGhEZYd0hlQud3iE7d6Cf0nDP0zyUvbEIfrLEDSpVgsUDLtO7HdP/2OT44lcE5xx21r3yC3LoycY0Fkn6olRR2ynPuJNe1wpu8ZhHkknWoAjrDfY9Bwac4RGVbvcJ5s4orsrREzwFfg==
Received: from PR0P264CA0135.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1a::27)
 by PR0P264MB4009.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:258::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.25; Fri, 8 Apr
 2022 12:10:16 +0000
Received: from MR2FRA01FT010.eop-fra01.prod.protection.outlook.com
 (2603:10a6:100:1a:cafe::fb) by PR0P264CA0135.outlook.office365.com
 (2603:10a6:100:1a::27) with Microsoft SMTP Server (version=TLS1_2,
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
 MR2FRA01FT010.mail.protection.outlook.com (10.152.50.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 12:10:15 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
        by proxy.softathome.com (Postfix) with ESMTPSA id E5C082007F;
        Fri,  8 Apr 2022 14:10:14 +0200 (CEST)
From:   Philippe Reynes <philippe.reynes@softathome.com>
To:     util-linux@vger.kernel.org
Cc:     Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH 1/1] libfdisk: write mbr only when useful
Date:   Fri,  8 Apr 2022 14:10:04 +0200
Message-Id: <20220408121004.183615-2-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220408121004.183615-1-philippe.reynes@softathome.com>
References: <20220408121004.183615-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b246a6cf-5f85-40b2-54b1-08da1958bd79
X-MS-TrafficTypeDiagnostic: PR0P264MB4009:EE_
X-Microsoft-Antispam-PRVS: <PR0P264MB400953EE3CF34D6B5F9D62D888E99@PR0P264MB4009.FRAP264.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dMcQfCKk+NWDpx43dFTC0kalf6Kp2Gx6W8xMM9Y8kIN9M9HlQdaaCrPhFNpag1Aw8/2+/G0lRaOp1ThgTfvxDbhSXSV6/CozQNeblzTZF7vctZLFq6+y002S1ea0C/2vtUGmotDshjn/O6Z7tBVGXDXiOJ83Nlh6SPinc/G0DvZt25XYF9bdCXk9mB00qfZVzPOIWyLLAlCfcKSjlU045LzAYiDo+4N9QbPGP0GkGdkYbbizPppdriJ1Em+iMRbuqaX+Y1K68f32RD4At9xGXRN9ZxXj3G9Ncm8sth/g4sMnochaZtZi4XT1izNWBP+sWypJLAEbNPmn6xk3qkVcz3+pzf2eMQeYtaEAbAAi3Rpkc3ahrQGXWM53nvXl/8XbxT0Fk/u9rBAQg/Mmepz/ip8xITYmntG4z9gFljHS4XVbSv065o+j5uzZbrRZTGsFAJowqWWjgFMX8OYWP0z+xlDOMCKrM9SJ4zLpK+G1Ipmb3EhkVd2sgNiAPMDcFc89Wt10MjLQWsEBueQjfQMoE1V7i2mZ9o68xdHkT5w1AgFyjJyWL2jQjwZooI3fs/2iNIkvuNoQnmeUCIujQ//r9Ks84QEb87nFau0Orhu73TRdeb5Y+Ao0PT6227FGNQpn4m4zPkTL6XYZnczzJglFC61fO3m7pytp3qU6enR3VESP55xoMQ6lCYaZZ/LY9AyL
X-Forefront-Antispam-Report: CIP:149.6.166.170;CTRY:FR;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:proxy.softathome.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(7696005)(2616005)(6666004)(107886003)(6266002)(2906002)(8936002)(1076003)(44832011)(5660300002)(36756003)(6966003)(316002)(6916009)(81166007)(336012)(86362001)(508600001)(47076005)(426003)(26005)(186003)(82960400001)(82310400005)(8676002)(356005)(70206006)(70586007)(36860700001)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 12:10:15.2227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b246a6cf-5f85-40b2-54b1-08da1958bd79
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511;Ip=[149.6.166.170];Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR2FRA01FT010.eop-fra01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB4009
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The MBR is critical as it doesn't have
a backup, so we only write it when it
is really useful (ie: the current MBR
is different than the new one).

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
 libfdisk/src/gpt.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/libfdisk/src/gpt.c b/libfdisk/src/gpt.c
index 72370a19a..08b0a81dd 100644
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
@@ -2107,6 +2122,25 @@ static int gpt_write_pmbr(struct fdisk_context *cxt)
 		pmbr->partition_record[0].size_in_lba =
 			cpu_to_le32((uint32_t) (cxt->total_sectors - 1ULL));
 
+	current = malloc(sizeof(*current));
+	if (!current)
+		goto do_write;
+
+	rc = gpt_read(cxt, GPT_PMBR_LBA * cxt->sector_size,
+		      current, cxt->sector_size);
+	if (rc)
+		goto do_write;
+
+	rc = memcmp(pmbr, current, sizeof(*current));
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

