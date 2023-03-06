Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DE2C61DA4
	for <util-linux@archiver.kernel.org>; Mon,  6 Mar 2023 10:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjCFKk3 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 6 Mar 2023 05:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjCFKk3 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 6 Mar 2023 05:40:29 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E231E285
        for <util-linux@vger.kernel.org>; Mon,  6 Mar 2023 02:40:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqgVTxk6g449DduUWhXCuiHCeUEZWVJi992aKxUbfTps7m6b+1xqYSMzIfGjfI8rwDsawzunhZHotldIOdZPIN1KqGNx/YBB5NJP5bAIFuhLPwoITUeMeyQRIYtoAW8po8WA1tuC+ouTjc1/HmLpw0ALCClD1oarw0rZDlVDs2JvPft1+Rua8hlTFSHsmzy2bUylCkwgwtMEt1v1IZkRzZmAuRZQ1RL+5m8SxS+4tSvt1+VxskmSu7DxXG6LydPqyMysk7xaOF67080GMBVewF6hNVbwGUaY8668VqheEdz5AMBmI2xZHH1mZTFRZQok6lmLgf502gaZopm4/bkK9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pUkRxsea481TLoHIDodtiKQe/t6kkVXHzuMObi/3lY=;
 b=DVrsaNTVw9uopPFH+BYHttylR2Zvgk8wpHxy22vCJO9ifmOjoAER99d7q1TvI9SpnKQBCmWo/xUGDwOrLhPNc6QxRIlITwDFBkscX3/hYW5Zotn+Xju3oibRrZj5IhVq3mVCd4G0hO2cLlbEyncaBj53doyaPcpuJFgejBkEF6iubkpN1uUaoqWwr7OVNt6kDdpQpDyMDYBRqkdwNhisND5UAZORR1Quc7xlaeNBn5gRQwCT9XNMgCxVoIbFW/Xb477O7SCFSbFHEuH4vem2CT1r2osFyJ8juuyIb1oaN+VNH68cJnOSCGx33WzK6alk+Ee28b8zVWzc9EGfWMZfXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 155.56.68.170) smtp.rcpttodomain=redhat.com smtp.mailfrom=sap.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=sap.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pUkRxsea481TLoHIDodtiKQe/t6kkVXHzuMObi/3lY=;
 b=Sl2M8xeBMUKXQFlkoZgJxf8eXVN49t3UshYUJzCDg8TicRiATPQfgUnVbsWmXzoxvQJ0m1WVB+jiSTkvf+2ZJm/qxl0s0RGjKd43y/5AzDVLJ9ha8s0ezTIWZEH3yIHAdYbZtewVnUCkNLH71f8xlTkuXapOPIzvZbjk0RNgoboKrrI82vHISL787ZwGUqDVH9b4t83asbFKBWoQ2N5oRI/8SHbr/OUADjPS+kh6ok4RSzO8ZI7hr5Q+ur4PdjkUabT8mYoDS6Kxt1bL0EdjEFb+uxncugusC73TGdjBlKuyVT0HhvuX1TLGz1VZpviLjAQ+vO5vbw/2BGKN9RrC1g==
Received: from DU2PR04CA0065.eurprd04.prod.outlook.com (2603:10a6:10:232::10)
 by VI1PR02MB10060.eurprd02.prod.outlook.com (2603:10a6:800:1c5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 10:40:25 +0000
Received: from DBAEUR03FT014.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:232:cafe::75) by DU2PR04CA0065.outlook.office365.com
 (2603:10a6:10:232::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27 via Frontend
 Transport; Mon, 6 Mar 2023 10:40:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 155.56.68.170)
 smtp.mailfrom=sap.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sap.com;
Received-SPF: Pass (protection.outlook.com: domain of sap.com designates
 155.56.68.170 as permitted sender) receiver=protection.outlook.com;
 client-ip=155.56.68.170; helo=smtpde01.mail.net.sap; pr=C
Received: from smtpde01.mail.net.sap (155.56.68.170) by
 DBAEUR03FT014.mail.protection.outlook.com (100.127.143.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.28 via Frontend Transport; Mon, 6 Mar 2023 10:40:24 +0000
From:   Michael Trapp <michael.trapp@sap.com>
To:     util-linux@vger.kernel.org
Cc:     kzak@redhat.com
Subject: [PATCH] libuuid: fix lib internal cache size
Date:   Mon,  6 Mar 2023 10:40:20 +0000
Message-Id: <20230306104020.46754-1-michael.trapp@sap.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAEUR03FT014:EE_|VI1PR02MB10060:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e07047e8-1ccf-4614-fc1c-08db1e2f31c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /b/AUcTEq3YpE4yKLESTsuQRmBFyJexYdtuX72XV1pLdF4wD9lhePJuCQJfUyx9LglLWW5fV97AY26aSB7mHpuLiMyxkcHmqie7bB7G2hvFo47oDqoUEDYabLoPkK5AJW1Al9BSBAquq4TQK6oY6jjbkaE+yurNWw2jRme0HCNRpYOLDbWLUWe6Jmv1oEV8dpdsq3r7bvYPde9CgzHeXDcohueGrnjY09WTCYoRgSRgdnxJP5+W1HBbLGloiKS2/7pMazCKu3UntLmjGjgCv0e3VKmPWCXjvEYJhFpzv+aoN7tcDxp8V2Un3lGJ0J74lmmb/ywEzchqnD+gsDMIAQJLakIXuTlMgfmLq0Bx//8Ggr6aQyTwzUg7kJRcs+OEYGR58CKCZS2AVdjDtb2CmRykxf7mHd9JRlT6H7BYEm7nIS9xX68foxIDYsWk+7gfns+8Np1JSge5GqvXBKveb+X0fwDuKWq9fI5SuZd31/skJtEvas8JZNy10E35zeMVacLdifCxorWtRIGR/8JC+iAVKvljcZmnaaioJsI0z+2LhE9OEhvMOIjh+7eTKk3eWbWLbenBuH9r+wwDFtZi8T1cXdUdIyaVZLJERgtZLNkCm0GUaTqcw9X776gqsCLB+YmT0H9sSALVBfIa0+CBen91mJ/BqsOskNjWpZwEP6KwviJV8VaFtQ3xafexY5XC+8HxYDxVKU7eSeL+KZmcB1w==
X-Forefront-Antispam-Report: CIP:155.56.68.170;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpde01.mail.net.sap;PTR:smtpde01.mail.net.sap;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199018)(46966006)(36840700001)(40470700004)(8936002)(5660300002)(44832011)(70206006)(2906002)(8676002)(6916009)(4326008)(316002)(36736006)(478600001)(36860700001)(36756003)(47076005)(6666004)(9316004)(6512007)(1076003)(6506007)(6486002)(26005)(956004)(2616005)(41300700001)(7596003)(40480700001)(86362001)(82740400003)(82960400001)(83380400001)(82310400005)(40460700003)(356005)(186003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 10:40:24.9736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e07047e8-1ccf-4614-fc1c-08db1e2f31c9
X-MS-Exchange-CrossTenant-Id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=42f7676c-f455-423c-82f6-dc2d99791af7;Ip=[155.56.68.170];Helo=[smtpde01.mail.net.sap]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DBAEUR03FT014.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB10060
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The lib internal cache improves throughput in high load
scenarios but for applications with a low request rate,
the cache size must be adapted to this situation.
Therefore the cache size should be changed to the current
requirements of the application during runtime.
---
 libuuid/src/gen_uuid.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/libuuid/src/gen_uuid.c b/libuuid/src/gen_uuid.c
index e1ba3c3d0..619ef0131 100644
--- a/libuuid/src/gen_uuid.c
+++ b/libuuid/src/gen_uuid.c
@@ -528,25 +528,35 @@ int __uuid_generate_time_cont(uuid_t out, int *num, uint32_t cont_offset)
  */
 static int uuid_generate_time_generic(uuid_t out) {
 #ifdef HAVE_TLS
+	/* thread local cache for uuidd based requests */
+	const int			cs_min = (1<<6);
+	const int			cs_max = (1<<18);
+	const int			cs_factor = 2;
 	THREAD_LOCAL int		num = 0;
-	THREAD_LOCAL int		cache_size = 1;
+	THREAD_LOCAL int		cache_size = cs_min;
+	THREAD_LOCAL int		last_used = 0;
 	THREAD_LOCAL struct uuid	uu;
 	THREAD_LOCAL time_t		last_time = 0;
 	time_t				now;
 
-	if (num > 0) {
+	if (num > 0) { /* expire cache */
 		now = time(NULL);
-		if (now > last_time+1)
+		if (now > last_time+1) {
+			last_used = cache_size - num;
 			num = 0;
+		}
 	}
-	if (num <= 0) {
+	if (num <= 0) { /* fill cache */
 		/*
 		 * num + OP_BULK provides a local cache in each application.
 		 * Start with a small cache size to cover short running applications
-		 * and increment the cache size over the runntime.
+		 * and adjust the cache size over the runntime.
 		 */
-		if (cache_size < 1000000)
-			cache_size *= 10;
+		if ((last_used == cache_size) && (cache_size < cs_max))
+			cache_size *= cs_factor;
+		else if ((last_used < (cache_size / cs_factor)) && (cache_size > cs_min))
+			cache_size /= cs_factor;
+
 		num = cache_size;
 
 		if (get_uuid_via_daemon(UUIDD_OP_BULK_TIME_UUID,
@@ -556,9 +566,11 @@ static int uuid_generate_time_generic(uuid_t out) {
 			num--;
 			return 0;
 		}
+		/* request to daemon failed, reset cache */
 		num = 0;
+		cache_size = cs_min;
 	}
-	if (num > 0) {
+	if (num > 0) { /* serve uuid from cache */
 		uu.time_low++;
 		if (uu.time_low == 0) {
 			uu.time_mid++;
@@ -567,6 +579,8 @@ static int uuid_generate_time_generic(uuid_t out) {
 		}
 		num--;
 		uuid_pack(&uu, out);
+		if (num == 0)
+			last_used = cache_size;
 		return 0;
 	}
 #else
-- 
2.37.1

