Return-Path: <SRS0=Tf+r=CU=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6C0C43461
	for <util-linux@archiver.kernel.org>; Fri, 11 Sep 2020 08:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47EA920665
	for <util-linux@archiver.kernel.org>; Fri, 11 Sep 2020 08:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PdKPR1bb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LEgd8PK5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbgIKIsG (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 11 Sep 2020 04:48:06 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:63562 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgIKIr7 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 11 Sep 2020 04:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599814079; x=1631350079;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=0DKFyI3ch5SmGphJ1Ty7VXx7vDz9plddVm7Is9YbOP8=;
  b=PdKPR1bbAQM/bL3Yh8Eff8jhdAxaRzE6E09CWkdTH3bTB5x/U3q/5jcp
   AFA2K4bciHKxfqQlShZJVlz8Y95Mm7UgLuE3RLcFs5sAuOyp59t8tXcjs
   aeElSQ8V+V5WqmJMwg6HLueU8zEGBpIM9dcYaJY0teg3h8dU01n2XRk5z
   33M0tYcyablOZV5xNrALlcDrGp0wOLmIUMMqhVD9J09ED6FGvBxx7n55S
   +PAoeCkq0AUaGM5TRS/gFh5QNyvi7Rqsn/UKYiCjwVFm/eYUjbV/rlJqI
   vUjlXO0zlVRAejfULjCjhMpTkJf/zVtVjUJlCAFcVRzAOJP3FUMXZNHb8
   A==;
IronPort-SDR: EQz8Ki1Q6I4yZ8iStMMV5M8VC2k8XmV74cJL/Z0PHTr9Nm1+dZR4tKXvVw778Znnep1S0dlUca
 gB4OFI4s2dKmP0BDEQUgtdm7Gqm9evte8myoZ2eIj5jUKt7Q9p28YPbWsxi+Bdcu9KcGwMInpM
 gZ3Jrd0WECx+rprb1vtyXeb4WyusRR4qDSXUfJSsGx2cA/MNHfC8c9fkNJvqfQPFYcsQw+LZbU
 NsGbx95icX48dzWAzcBhCX2k58vwfxp/2HqUaT2z9qTeLhUCB4cJyrRbhe9ddOyRjmK3Ddc4SP
 6fU=
X-IronPort-AV: E=Sophos;i="5.76,414,1592841600"; 
   d="scan'208";a="147113473"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 16:47:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+r0FHg5V7FHhbTasHCuShHfbWxVJHPSxbWE8wvIxmsWD1vp+9rwTEBXpo06io5POGQebU8+ywld5u6UDOXMk8k1aigVW42tW2i14CIM1YA4dL7/gjXBaMOUuXktvy9MbyV95hafOsofg66BZQ3oESwI7xXnfkxpOcFR8CdLNS1bhoAWeNYoKDcid3gPWA/TZg7NCckDy0uhQwwPSrhBqty4iZ3tFEJWQhRitNhJwceAtAgzKraEEJ7XO9f5fIOiV+Ie9auOOzmKqlOIpMj+eiorBL6Z/rEN1QIklsQaEV1xcIH0soMX/BlJs6s869smCWGMO8iIdFts3BrkTxKyjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuKEfTNl9izw26+sCoSJHj1L3zaUqi98Ux20fLEoTsc=;
 b=i1EPQsFh3ZTkzC06T6sEnsO4/1n7PGZNKjlwVOpsKXXYiUaDI7E9yMM6lNdJCKTDG2YvaPIQyaJK4AFAr+9bS2UBQmlP3p/OMP6Ghnfa80Pow2HWsS/gzgt6q4e3qDfhv7Ak90C5+cIcFCSwLmmu63gVrF4udYLE7gNnnDC6xxGm7xaC5wgon8hd+XrbV+E6ITRw6NkbP3OioLwx5Eb1+a4UsUzjPF4L2BE8BqrH7Q9MscVOyEaWJQo16EjQkG/UNIIdVX9pvoJz9hrBXdkfL/MAu8L3rVP/DKeS0ddoq4K8rbUNLTdGrdUYflES+OJKOuXVkgka5ckBpdDCbT2Ofg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuKEfTNl9izw26+sCoSJHj1L3zaUqi98Ux20fLEoTsc=;
 b=LEgd8PK54ZNa7t6h5lfupUhQOblCqAxG/0ui5HvKRVblVrDUWfH4hu/JVJV4vXjxYQMX8NDHmhuNoKcULXguLMRo99VvS2RijXIiUaFf2GUWJzbUmwxz24LikGrZWT9O7/r8P3XYOV5+XwrW0LVTTba9paukeqHPbc5Ms7CTlu8=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
Received: from MN2PR04MB5520.namprd04.prod.outlook.com (2603:10b6:208:d7::11)
 by MN2PR04MB6205.namprd04.prod.outlook.com (2603:10b6:208:d5::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Fri, 11 Sep
 2020 08:47:57 +0000
Received: from MN2PR04MB5520.namprd04.prod.outlook.com
 ([fe80::ca6:a2c4:3c0f:f7ca]) by MN2PR04MB5520.namprd04.prod.outlook.com
 ([fe80::ca6:a2c4:3c0f:f7ca%7]) with mapi id 15.20.3348.019; Fri, 11 Sep 2020
 08:47:56 +0000
From:   Hans Holmberg <hans.holmberg@wdc.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Matias Bjorling <matias.bjorling@wdc.com>,
        util-linux@vger.kernel.org, Hans Holmberg <hans.holmberg@wdc.com>
Subject: [PATCH] blkzone: add report capacity command
Date:   Fri, 11 Sep 2020 10:47:23 +0200
Message-Id: <20200911084723.14996-1-hans.holmberg@wdc.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR09CA0067.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::11) To MN2PR04MB5520.namprd04.prod.outlook.com
 (2603:10b6:208:d7::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from gsv.bredbandsbolaget.se (87.116.37.42) by HE1PR09CA0067.eurprd09.prod.outlook.com (2603:10a6:7:3d::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 08:47:54 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [87.116.37.42]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 994c5cc3-74e1-47f6-6c08-08d8562f60c4
X-MS-TrafficTypeDiagnostic: MN2PR04MB6205:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR04MB6205AA8F88512ED5A10A79B1EB240@MN2PR04MB6205.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gAfRX3hpAaCx2pzrPDvBvB/F9FJGZ+CDhSqhtMh5CcdNelX16jE7CR3QjSYwkABTlSpK7LZx53FnfUvH6X07E1fe+v/AvFxnYcoRC+dGfYpZx/ypcg4Ee8zwC+i+b4UGe3ellb/d9nEQpgndrh/+KA9ujfTx3stMLoSd71rou0hrbM9lUk32I8W3Paqz9lMhkOZnijDq/gk2/+Jy7T/y4+dzLnLf0w6H0iJnCTGPCg9mMAFWkyed61A0quetpIPOOfPP7ka3tzjcJyd8p9qNDKHcA2bBl2JnWcHLL7seufjGHC5zv5vNBfSNtk0Z/Lm2mEewQTfmd0FNM30C79K2ag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB5520.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(186003)(4326008)(6666004)(66946007)(66556008)(36756003)(66476007)(83380400001)(86362001)(5660300002)(52116002)(2906002)(956004)(2616005)(8676002)(44832011)(26005)(16526019)(316002)(6506007)(6486002)(54906003)(6512007)(6916009)(478600001)(1076003)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: GsrIPCa8yUpx+QCqsQeeixweyI9R3WLf5xT7yvW+i6NRFK8jQsZo3463IlUzqUY/5APqkPevxDvT54Ssoe4yFEydcy5sY+AWzRWSduqDIQ2myazR6qkVgIhIYWnxbdwrZbT6Ox4/Xpy1uT+fc6XxYs8dUU4ACR76HbI11mxuHvaZO9BSfiGMDQG9cvK8mYjufX1qgCpNqUiO5iIL+BdAt5j549O+R9j0nkFxUfTPslmUyfpAi/eSyVJB8gduMl+VykLXQIEULQWUD+DhatZr5LUW16ex2y+7oPKla6CqlygyTph1SP5MJEg5C7A1LovaBvGdd9xsezrUJbFj+LytK0f6D7rIgIuJFMrRTS8gvoq1QCj+UioyiFlvcv5gP0r4Wxsx7jPcAV69b8QA5dWdusEpfKxB/9hr+4p/Ocm3VVXPX1IqJw2UP9BdH665q46U6TWsBMy/3nMuaH95a6w0hSKvDpy7o6xqzTg9lgFbPJE2StAgWeAXFh3gW3v7p32kG+V0vWk/RM7n22LCpQFBON7a2gR3ZIRS//0MSjStOTP1hhrdZQbQxzYxPenYS6RAu2IsEO/tkCMpmjeSHv8LxoXK61v139+u6aIOorF5jreLwJ9sLqinHwLlJ03mevqJ+z12pfgE1Pw4yEuBEOVY4g==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 994c5cc3-74e1-47f6-6c08-08d8562f60c4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB5520.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 08:47:56.3989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oF/P9YZiqbZjJ8p/gAzRibTQ6U5jl4I1huuktfHlTitedxEGeJfZeqq9VqNGJMsTTZ3skKYzMzks0Vqxdgk3JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6205
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Add a command that answers the the question:
"How much data can I store on this device/in this range of zones?"

Implement this by summing up zone capacities over the given range.

Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
---

As commands like blockdev --getsize and lsblk returns the size
of the entire address space, it is useful to provide users with a command
that calculates the actual storage capacity in that address space
for zoned block devices.

 sys-utils/blkzone.8 |  7 +++++++
 sys-utils/blkzone.c | 28 ++++++++++++++++++++--------
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/sys-utils/blkzone.8 b/sys-utils/blkzone.8
index 043bc96e23ac..958677e1bffa 100644
--- a/sys-utils/blkzone.8
+++ b/sys-utils/blkzone.8
@@ -52,6 +52,13 @@ ro:Read only
 x?:Reserved conditions (should not be reported)
 .TE
 
+.SS capacity
+The command \fBblkzone capacity\fP is used to report device capacity information.
+.PP
+By default, the command will report the sum, in number of sectors, of all
+zone capacities on the device. Options may be used to modify this behavior,
+changing the starting zone or the size of the report, as explained below.
+
 .SS reset
 The command \fBblkzone reset\fP is used to reset one or more zones. Unlike
 .BR sg_reset_wp (8),
diff --git a/sys-utils/blkzone.c b/sys-utils/blkzone.c
index 67eaf1a02430..c416e0711fc3 100644
--- a/sys-utils/blkzone.c
+++ b/sys-utils/blkzone.c
@@ -91,6 +91,10 @@ static const struct blkzone_command commands[] = {
 		.name = "report",
 		.handler = blkzone_report,
 		.help = N_("Report zone information about the given device")
+	},{
+		.name = "capacity",
+		.handler = blkzone_report,
+		.help = N_("Report sum of zone capacities for the given device")
 	},{
 		.name = "reset",
 		.handler = blkzone_action,
@@ -224,6 +228,8 @@ static const char *condition_str[] = {
 
 static int blkzone_report(struct blkzone_control *ctl)
 {
+	bool only_capacity_sum = !strcmp(ctl->command->name, "capacity");
+	uint64_t capacity_sum = 0;
 	struct blk_zone_report *zi;
 	unsigned long zonesize;
 	uint32_t i, nr_zones;
@@ -290,21 +296,27 @@ static int blkzone_report(struct blkzone_control *ctl)
 			else
 				cap = entry->len;
 
-			printf(_("  start: 0x%09"PRIx64", len 0x%06"PRIx64
-				", cap 0x%06"PRIx64", wptr 0x%06"PRIx64
-				" reset:%u non-seq:%u, zcond:%2u(%s) [type: %u(%s)]\n"),
-				start, len, cap, (type == 0x1) ? 0 : wp - start,
-				entry->reset, entry->non_seq,
-				cond, condition_str[cond & (ARRAY_SIZE(condition_str) - 1)],
-				type, type_text[type]);
+			if (only_capacity_sum) {
+				capacity_sum += cap;
+			} else {
+				printf(_("  start: 0x%09"PRIx64", len 0x%06"PRIx64
+					", cap 0x%06"PRIx64", wptr 0x%06"PRIx64
+					" reset:%u non-seq:%u, zcond:%2u(%s) [type: %u(%s)]\n"),
+					start, len, cap, (type == 0x1) ? 0 : wp - start,
+					entry->reset, entry->non_seq,
+					cond, condition_str[cond & (ARRAY_SIZE(condition_str) - 1)],
+					type, type_text[type]);
+			}
 
 			nr_zones--;
 			ctl->offset = start + len;
-
 		}
 
 	}
 
+	if (only_capacity_sum)
+		printf(_("0x%09"PRIx64"\n"), capacity_sum);
+
 	free(zi);
 	close(fd);
 
-- 
2.20.1

