Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFC8C2B9F4
	for <util-linux@archiver.kernel.org>; Thu, 17 Jun 2021 04:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5CFB61245
	for <util-linux@archiver.kernel.org>; Thu, 17 Jun 2021 04:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhFQEoo (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 17 Jun 2021 00:44:44 -0400
Received: from mail-sn1anam02on2132.outbound.protection.outlook.com ([40.107.96.132]:13934
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229495AbhFQEoo (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 17 Jun 2021 00:44:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UusL6z5ZBvEkrBq/3a1c6kUnZJWQFXM09d4ImU0YVtBWnjWlxg3vyuk7nESCmhoiji7T1BKJcVaKw8Gr9SkNQGonTY8MNBeKOE4VqDJTsQ7ROnVz6jh7pBSLcu+U1RGy16Sv88MzZwewtv8xncTfDsQ2RaCx7r5MIaUh5LtPKJolRqLkmvIdGqQkVCMJI36hcPs3+m6uzcoLfewL/qhP36QWWzSGImD9TIuRWx6R4wm5v0C1UqDxOEX2hJCGfszM0uz72kvErgTwXMw2SkjQ4oYYGnjFwYUontHm/nFf1wv5BQgms2nPWpL4Nnqa2S9AFXaXbElTCo2uhOmoNpYvWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fU1PO6r/n2P5l51BunPb3rlVolN8itubAMTJofW5Aow=;
 b=dauyi5FO/kuyc1Vj3yRPUbaDhhzSEwQ9BYTLpDvCqZaWhK/DSfCUFccgPa15kfS29unDcG/j7Ojy91JMsdx79ahqm7oREIAkDChZsGS+9X21BAMrLK5Q5GguhT9MRIHsoGlnELITYOWLgfVBh/VbbzZqNOYEERNKiN0irzzjnejc+n3TzVAtgxtPI86FmqbFTM3KGe7WudTY7Qx4dP3S2K+HqsnzJ62VtI5HVyI8eK9q+I6s1hjQTRajUPL5qlR7XBsWYmaIi0pXY4YTsh0U2+3seTrpAeI6qd8524MoMtpzqGAPgff1Uv2aro3kDf2YLKZn+PEvctj8ZOxQoxYFLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fU1PO6r/n2P5l51BunPb3rlVolN8itubAMTJofW5Aow=;
 b=rkGM8YjvVOK00ymOsIftWy/PxGV4lkp3aXfxQ3UwW++8Ok5zP3ptZ1QgtiIms/iLCTg0VUz2xLEpuVRL2vyBmZc4Na7hVboggFJqaNhdMgcVHcXLJu4OxsJbgxZmEt67sC53SN2EirGrVRf3eiIwD2H0g8fFFFyl3lCbZRM1KOc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from MWHPR0101MB3165.prod.exchangelabs.com (2603:10b6:301:2f::19) by
 MWHPR0101MB3150.prod.exchangelabs.com (2603:10b6:301:2b::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21; Thu, 17 Jun 2021 04:42:33 +0000
Received: from MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::842:9ada:565f:8b98]) by MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::842:9ada:565f:8b98%3]) with mapi id 15.20.4219.026; Thu, 17 Jun 2021
 04:42:32 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     util-linux@vger.kernel.org
Cc:     kzak@redhat.com, patches@amperecomputing.com,
        zwang@amperecomputing.com, mas@amperecomputing.com,
        ilkka@os.amperecomputing.com, jeremy.linton@arm.com,
        jbastian@redhat.com, m.mizuma@jp.fujitsu.com,
        patrick.zhang@amperecomputing.com,
        Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH] lscpu: remove the old code
Date:   Thu, 17 Jun 2021 12:41:16 +0000
Message-Id: <20210617124116.6841-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.30.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [180.167.209.74]
X-ClientProxiedBy: CY4PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:903:32::13) To MWHPR0101MB3165.prod.exchangelabs.com
 (2603:10b6:301:2f::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hsj.amperecomputing.com (180.167.209.74) by CY4PR13CA0003.namprd13.prod.outlook.com (2603:10b6:903:32::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend Transport; Thu, 17 Jun 2021 04:42:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44960fb2-c216-4373-58f5-08d9314a51d8
X-MS-TrafficTypeDiagnostic: MWHPR0101MB3150:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0101MB31507B70AD2890434B946B3FED0E9@MWHPR0101MB3150.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gczxbnh24F8ROJKyM1TxozNvNVSHqCYNjFIorgEGuCbH6zNX/VSlcBSlzYwPVbet+xxcSh/IzGjvNM5g8CXeUIadjB/4SSz2+B23YUnLupxVOfX5x/uCiFXMxtYcfgH6XVEgQwSkESln996KBGWJ7Hk8VrSzpJALZO4p6JQuMrcy3Z9udbNn7rkFD87ad7gVKKHmY2ickQw89gBMR3oX8be5w3pbI6cmVVUwYw7dnRoLK5KzE9oVnaujZ0iEY7HAvUK3OCeF7Scr80Wte3lsBAQO53Ym3plCj5VqlPE2krZoZk3HVNsRJ9tMBVDVJvLc4vI8Y8/CDPSLcR5iHJLLvUKjarvVVdOhZHiGXuJfTtHtmsEqquIUV//2++2SO8RCohN2WQrGXhpJsI+v86c5+MWFvNJXjpL8mut50ae50e023HAscGSrBTIX6rBB7mSBUuKXtd9TozKpV6Koe/nX3tmVgHhXnVxsLtAmbFZzZrk2YVzX0oHoY1ktNiP8ysLK0QlaeNCp7qsch5ZyC8OJCbs3dpkHOEyoSXYNaTk2lYmLkL+0huQfkO9DndzLldB3rAeA3nzQzEEY4ypQ4PxPGXNDWCmYVWp7t5sP5U3O6jdsyVdXQFf7XWXp9R6UAvQbvs4nnvagyJWAcs7bXUgFrVlZGqNwQh1RK4ScgIw39sc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB3165.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(346002)(376002)(396003)(366004)(6666004)(86362001)(52116002)(38100700002)(26005)(16526019)(8676002)(2616005)(186003)(66556008)(956004)(83380400001)(2906002)(478600001)(38350700002)(6506007)(66476007)(6916009)(107886003)(5660300002)(1076003)(6486002)(4326008)(6512007)(316002)(8936002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEJKYkxXNEVaWFdEUHY2dU5waVRrUTJOcVJlMzFxd0wwWXgvQWFHUU1BZ2gx?=
 =?utf-8?B?OHVXVXZQWC90MUFZcUxpU2tGcFJzUjN6dy9jWGJXTjdObmlsbVN0Wk0wb0V4?=
 =?utf-8?B?Q0JnVXFjdGxBOUVRZjAvckNYYllHcitFU3ptRFU2U2tyblUzVEtTYkQ5RWY1?=
 =?utf-8?B?WXpocVZBd0VWdUE1dDAvVmk3aHVocDU5OHlrL3ZkYWFhd2E2M3g1RDFxUmJ3?=
 =?utf-8?B?cHBtYThWV2ZGZWJCQzYxbFdpam51K05XTWtZMGdTcEUva1M3cHlvRHhaM293?=
 =?utf-8?B?Q3ZEbHVQVzg1cmZRNHZsQU9WY243TEZUZUR5dE1QQ3pPcEUvYVZxN1FTenJ4?=
 =?utf-8?B?Q0V0WnNxbXcwRE53ckczeC95eDVWdWk3ejdzNmhIaDd5ZU1lQjRSRG94a3Jp?=
 =?utf-8?B?eG5RWDRFM3FyMjhNUVVlc09lNjJPQXhMV1E4SXBra3o2UTV3RFJxeU9sVHg4?=
 =?utf-8?B?VEFoRFZVQjZOZ01QZ3k2aVNiaVBPZ1VIbHRwbENUZFBvc3lPNHJGL20yNnIx?=
 =?utf-8?B?cURZSzVPbW1QZXJKQ1l3NjRlTjVhcUsyVEFaUStkSTVWY2JiY2FLa2FrVGJK?=
 =?utf-8?B?TE02a1BFUmM1ejdmazFzWWhXeHdJL01mL0hYYzhyUXR2Z0ROMzFFeER2SHBV?=
 =?utf-8?B?NnFtRFZvRTE2WHg0WEV3NUJwdCtyUENCY0cwRzU4Z3pTTUlVZlV6dERkaE80?=
 =?utf-8?B?NE84enBtVUhyOGFXU1QzSklKSVpKZWhwZUc4RTRiQko1aU5Ycmg2azA0dm5L?=
 =?utf-8?B?RjZKU01TQ1VoR3hCaEh0U2txTzNhN055NVhoSUhRdDFEaGtIbUxGSjg3bDlr?=
 =?utf-8?B?R0FmSG9iOWkyNWI3SVlSZzZSdmJ3S2taUGtMTzZyZWJjQWdoRDgrZkl2SS9h?=
 =?utf-8?B?eXN3WUZOTmFobkRrWWMxRFJmTHhUQ1Irb0p4ZTRuS0ZTUVhKYlQ2cUQ4ZFJP?=
 =?utf-8?B?YlFCUW9rSURyR25rdXFPbUp6ZHJMYXprSGdRSERHUW9MQkRFeVUyUzR0RWVp?=
 =?utf-8?B?L1VQR1pxOXNQTXkxbXZTTEtFbklGa3Zud0pBQXZqbHVoRk00T1B5cEY3QlFz?=
 =?utf-8?B?Uks1b1NLbUJVTXBXVFY0U3FkcTZTTStuRkJlZkc1Wjg3S2d6Q3lkTUJTOGNV?=
 =?utf-8?B?TzRuNlhYMVlYSFpSZWZmNW4rckVKaWE3RmVxUE9UT253OEV2UEVDQ1dEaDhD?=
 =?utf-8?B?c3IzWGROOUczZW1sVjJQTjkvZkovOWZrbld3MlEwRW9LZHJsaGVWRkxCYnFm?=
 =?utf-8?B?UnN1elJOZWRBVmlvYnhncnExU2NIYTU4aFdQak1BQVJSQWoyVDloTk5IZEQy?=
 =?utf-8?B?TVQwbGk5S3psTFpUYWRVRjY2M0hlaWJBWldBSktQQXMwVUxuNUdPZHpManRx?=
 =?utf-8?B?NVBvSGJlOTRpZ2hLU2JQTmc2TUxSUGNHWFB6UTBxbjBERE01TURQblZPQ2hH?=
 =?utf-8?B?SFJqYVNxbWJpWVV5QlJtVTJ2MzVOSXo1dVV0WkcvNUN1UERxVGExcitoaHFW?=
 =?utf-8?B?eGRHem5NRE9XcSs1SEo1UG9YNkJyQ2JEWldnaXJuR1BFUGE5SDAzRGdOVTI3?=
 =?utf-8?B?Q2xsTUdCR29TeTB0KzhBZlhjWmwrQ3pkMm5Uc2VRbThvU3Z4QlBEWW5Fbklk?=
 =?utf-8?B?ZGJnMUwwMUEwVVFhNWdtQnlsYXUyVVAzSUcrK0dTZE1VTWl1ZnJ2OHdxeHVM?=
 =?utf-8?B?WG9wZ2Z5aGpTRUR0eHkvWkpFUWNCOGxRVmZxNDNpWDJURUpJRWM5eExlL2c1?=
 =?utf-8?Q?ejxjF3fyJQi+HK+whxd3ngeYsqvemzY8K4SyEgb?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44960fb2-c216-4373-58f5-08d9314a51d8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB3165.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 04:42:32.8014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1VN0EXEEW+lX6s+QyvW6GmlLMyhe+eNuD5H9P5kuCldKUa+21OZMipTque9xRnyjmTsttGjhhs5HTGHnxg2cYTIYaqCRmP1r5M0FCgDrNma2dY4qKjno1rjjv3/BRUAJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0101MB3150
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The file "/sys/firmware/dmi/tables/DMI" always exists.

The dmi_decode_cputype() can provide more information then arm_smbios_decode().
So remove it to tidy the code.

Before this patch, we can get the output from Centos 7.9 who has
"/sys/firmware/dmi/entries/4-0/raw" and "/sys/firmware/dmi/tables/DMI":
  ----------------------------------------------------
  BIOS Vendor ID:                  Ampere(TM)
  Model name：                     Neoverse-N1
    BIOS Model name:               Ampere(TM) Altra(TM) Processor
  ----------------------------------------------------

 After this patch which uses "/sys/firmware/dmi/tables/DMI", in Centos 7.9, we get:
  ----------------------------------------------------
  BIOS Vendor ID:                  Ampere(TM)
  Model name：                     Neoverse-N1
    BIOS Model name:               Ampere(TM) Altra(TM) Processor Q00-00 CPU @ 2.8GHz
    BIOS CPU family:               257
  ----------------------------------------------------

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 sys-utils/lscpu-arm.c | 46 +------------------------------------------
 sys-utils/lscpu.h     |  1 -
 2 files changed, 1 insertion(+), 46 deletions(-)

diff --git a/sys-utils/lscpu-arm.c b/sys-utils/lscpu-arm.c
index 885aadc36..d52765f9d 100644
--- a/sys-utils/lscpu-arm.c
+++ b/sys-utils/lscpu-arm.c
@@ -315,53 +315,9 @@ static int arm_rXpY_decode(struct lscpu_cputype *ct)
 	return 0;
 }
 
-#define PROC_MFR_OFFSET		0x07
-#define PROC_VERSION_OFFSET	0x10
-
-/*
- * Use firmware to get human readable names
- */
-static int arm_smbios_decode(struct lscpu_cputype *ct)
-{
-	uint8_t data[8192];
-	char buf[128], *str;
-	struct lscpu_dmi_header h;
-	int fd;
-	ssize_t rs;
-
-	fd = open(_PATH_SYS_DMI_TYPE4, O_RDONLY);
-	if (fd < 0)
-		return fd;
-
-	rs = read_all(fd, (char *) data, 8192);
-	close(fd);
-
-	if (rs == -1)
-		return -1;
-
-	to_dmi_header(&h, data);
-
-	str = dmi_string(&h, data[PROC_MFR_OFFSET]);
-	if (str) {
-		xstrncpy(buf, str, 127);
-		ct->bios_vendor = xstrdup(buf);
-	}
-
-	str = dmi_string(&h, data[PROC_VERSION_OFFSET]);
-	if (str) {
-		xstrncpy(buf, str, 127);
-		ct->bios_modelname = xstrdup(buf);
-	}
-
-	return 0;
-}
-
 static void arm_decode(struct lscpu_cxt *cxt, struct lscpu_cputype *ct)
 {
-	/* use SMBIOS Type 4 data if available */
-	if (!cxt->noalive && access(_PATH_SYS_DMI_TYPE4, R_OK) == 0)
-		arm_smbios_decode(ct);
-	else if (!cxt->noalive && access(_PATH_SYS_DMI, R_OK) == 0)
+	if (!cxt->noalive && access(_PATH_SYS_DMI, R_OK) == 0)
 		dmi_decode_cputype(ct);
 
 	arm_ids_decode(ct);
diff --git a/sys-utils/lscpu.h b/sys-utils/lscpu.h
index 79477b469..8cb0d630c 100644
--- a/sys-utils/lscpu.h
+++ b/sys-utils/lscpu.h
@@ -32,7 +32,6 @@ UL_DEBUG_DECLARE_MASK(lscpu);
 #define _PATH_SYS_CPU		_PATH_SYS_SYSTEM "/cpu"
 #define _PATH_SYS_NODE		_PATH_SYS_SYSTEM "/node"
 #define _PATH_SYS_DMI		"/sys/firmware/dmi/tables/DMI"
-#define _PATH_SYS_DMI_TYPE4	"/sys/firmware/dmi/entries/4-0/raw"
 #define _PATH_ACPI_PPTT		"/sys/firmware/acpi/tables/PPTT"
 
 struct lscpu_cache {
-- 
2.30.2

