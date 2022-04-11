Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59734C433EF
	for <util-linux@archiver.kernel.org>; Mon, 11 Apr 2022 12:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240340AbiDKMos (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 11 Apr 2022 08:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237076AbiDKMos (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 11 Apr 2022 08:44:48 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90072.outbound.protection.outlook.com [40.107.9.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D191ADAA
        for <util-linux@vger.kernel.org>; Mon, 11 Apr 2022 05:42:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRIpz44jiUrGANOqcdGKyLMN/Ora8FA4+DoLAkiCsjfpBDucawuAx4uSX8osjbjBvLedaX35T8pFJkTlLCRARHRCXTYM6BIMlsmleA86Abg/60qX4FC6TfM1uXhpUzzLt3wC1qlm2DIFTNU//AQgHGGggLEX5M6eb0MxIPOaZR7zrxx+VAkcJqztW11m8TISU5tx37J24L8AQ8m7d4DJ0P06X6uXZszGVJm+MBUA01X5LP+8a/NVyEkr0n2ArALvmyqnguFIQfiUKS6nZvU2KCmP87K0DPSJKHWVeRVN8IC17wtH/HqhSyQCRKR5+wtsrxne7Eg66DysvDhZCM2fDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AA0g+NWhL9UhLYCKwVUeeCOxVbuwqAVVKIYIqoX75EY=;
 b=A4bip9+h9RId5BSiZGZ3xxjxZEQb6B2u/McP5XygxX/c2wW0D5CY0z2MXDehic0ESSCmee0WnmbCo1vdi87gnHYRp+evTs7StSNJLRDSlny/JmOvohQqNkaV1QnNGRxvvzJRjbeizMoN6VFJ/IgZ4X2ftbbo5NF9SdeSYcIkTCdzex/xrsS8ri/zw/uvVV8McutFTXo4fiDpLb3twQNramQ/AJJu5O+KWpCwTtCcHaiG5dju6jg7H1E5tdqyxJWDx3qwbpxe+Md+0YGWwGGtWZNuBpa01dyxJK8ioQdYxR1gSfpBABvlu4n6rRUiPWT3y4KrGo9S3y0I1cgCgAJjhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=softathome.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AA0g+NWhL9UhLYCKwVUeeCOxVbuwqAVVKIYIqoX75EY=;
 b=s9H3b9c8cA5zglZ60SH5EK3QH/maoeNswjfbMvq6BncRI+51Qp3AnRh5zYabd6ApQdsmKLAi40tQY/48lQt/7Huhl2nYFoTj4VGd2gf4RTPGhYCnsi0khrdX2fzdgKXV0XoxkOigvNkd23BfdujSZaBv+k2bxnjXQ0vyIZMGxqFr5rsJFFk/60Tg7cN0/7/ZvyrcogDhk+nINklHnsyt9J/K8jPkZ7D3yPxhxLqnSlJOP9odcSsp2sK66KnKjXVONxdiPBs0mRN4wHjoTtJugFLCIkfG7MU86buOg5OsIxF4nNtLDJEiopmvnXo5hxs4Htih7vdfUhKoH3dpvcDdiw==
Received: from PR0P264CA0267.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1::15) by
 PAZP264MB3414.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:141::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Mon, 11 Apr 2022 12:42:31 +0000
Received: from PR2FRA01FT016.eop-fra01.prod.protection.outlook.com
 (2603:10a6:100:1:cafe::7c) by PR0P264CA0267.outlook.office365.com
 (2603:10a6:100:1::15) with Microsoft SMTP Server (version=TLS1_2,
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
 PR2FRA01FT016.mail.protection.outlook.com (10.152.48.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.20 via Frontend Transport; Mon, 11 Apr 2022 12:42:31 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
        by proxy.softathome.com (Postfix) with ESMTPSA id 0BE501FEC2;
        Mon, 11 Apr 2022 14:42:31 +0200 (CEST)
From:   Philippe Reynes <philippe.reynes@softathome.com>
To:     util-linux@vger.kernel.org
Cc:     Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v2 0/1] libfdisk: write mbr only when useful
Date:   Mon, 11 Apr 2022 14:42:28 +0200
Message-Id: <20220411124229.232299-1-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7672624a-a349-4f0b-efc6-08da1bb8bea0
X-MS-TrafficTypeDiagnostic: PAZP264MB3414:EE_
X-Microsoft-Antispam-PRVS: <PAZP264MB3414DEF40431CC04BF678F0A88EA9@PAZP264MB3414.FRAP264.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2yxziwRUUNdZydTHECYrX1vTXgf3F2OHJPjTaxW52xiM6p29sp8MQ8ingPDioLq6KVSdrQ/rvLj6v/Wi1tf7YsDUv0R5ZYyMsPFt67SrFciDC7gLONiRCDXXM6N2KBuYF3iAeRyY70VTPpfNJOX29v1fRvKaa1a4+sWPpZZPfyr/ncmacKYkOPc3bNLiokXIAeuPD/0Uo80FlsyLBFEY/0KOXRe/okoH8iexWYWQgHB9c6Y3cmyyXvvXOg/w6yKtaJAB7Ls7EXIg/Icv/LZEqKeAOa7zh7iFh11Ww+lX9ab7JFCRFde0dq2XGvMET0GIY+gQNgu9FHNzKzPq0RxydBtqlrK0uYG16g4S8M2WEezD25Fi6n8Q2vZQRCV8c4E8qFSmBr/nYjCZRENeuH3xkQWISXlW2k1BEoAjjH6ZAQnjFdlBufrD7lLkjgNuhLhWE1oKUCPyn46QQEdQWsffQJAuW7NLAUD9jbKTm506LC0Y1meSvj5Czj1FQA791g8GIQRfPXWK2jAu6tkUuoi2aElA/1fDch/lpr4gRnpiaIAJwqUFFLxzsWYxk8rmtY9SRakwSPil3P5uRi1OlUiqaxZikvCL+TATGDdMert55jbDAzNu4vYY2dZCrQ7IalmnigIRKRdtaVne881N5601V7DnXdz4QQHkC5M+JuNBsnSYGrB1MJMUas7tum7wiamr
X-Forefront-Antispam-Report: CIP:149.6.166.170;CTRY:FR;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:proxy.softathome.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(82960400001)(356005)(44832011)(81166007)(4744005)(186003)(82310400005)(8936002)(6916009)(6666004)(2906002)(316002)(7696005)(36860700001)(4326008)(83380400001)(8676002)(1076003)(2616005)(70206006)(70586007)(5660300002)(6966003)(36756003)(508600001)(6266002)(26005)(47076005)(86362001)(426003)(336012)(107886003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 12:42:31.2028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7672624a-a349-4f0b-efc6-08da1bb8bea0
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511;Ip=[149.6.166.170];Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PR2FRA01FT016.eop-fra01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB3414
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

Changelog:
v2:
- fix memleak (thanks Karel)

Philippe Reynes (1):
  libfdisk: write mbr only when useful

 libfdisk/src/gpt.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

-- 
2.25.1

