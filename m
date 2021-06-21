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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D575DC48BDF
	for <util-linux@archiver.kernel.org>; Mon, 21 Jun 2021 03:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCBCF61151
	for <util-linux@archiver.kernel.org>; Mon, 21 Jun 2021 03:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhFUDM6 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 20 Jun 2021 23:12:58 -0400
Received: from mail-dm6nam11on2102.outbound.protection.outlook.com ([40.107.223.102]:1248
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229877AbhFUDM6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 20 Jun 2021 23:12:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUU+slRXtPgeJsSnRkTJzSBFTXnvN6hKp0nh0u/Il6EHZx3shrw7xS8NEiPr6ZibRoeIq1ruRwkIw7cpdqZu8e1GkL4E789nllKXtTiMXqjA2+frIoBOD2hvjUjahzE+LOS7/MlfWL0ihKcM1FlszaJKCV3dYAx15wqFe3mqSm6xBavSgzZQ3/B4ueVBeO0uhXmboTevMVXpHZ7h9i7Kmagkzo2KfsvTl6SCHKW5KJ16qlfxvHM0tsDvZTuhD0yzgr1O9ElFIMUSqR9X0NH8Np2JqeX5TTb8Nh/ozYKiGatwPmoQkwtvWoaMApoIF87z8pyLeNl1KY+ZUv8ZFGBJ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+k+ZAN1SvRqp2QAgOTXuKSb4yLQaG9ZVN/PQ+dVKa8w=;
 b=YJGZNPwI58n9QarmuwtidYfIZCofBr7N1dD9CBuMwD96XVrC9TWpxGdNo+EVTZKBYksGnrtRNDkgZL3fawoHDuNBwfUC2FB+uzcm5dIT3yDBmNPDclKyFNO2yTXNnhXbbDUiwASEiLhrN7KG7N/XUM33KxikjXqF9sOnJzaMzCPuyiz+3oqFjhfjz5KhUT1Ha682KNYxVA8o9b2h6c5irjmOJImdQBVrVEiVrZKbwqYc28tQWOU3XaDWi8aG9CATcW68epwP9PCevAWrL9hUtdseF7InfrqaWB/Xwht0o6det4F+OkHfwrGwmocKGrknG/9gzJTaUXR9LFgpzo3QPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+k+ZAN1SvRqp2QAgOTXuKSb4yLQaG9ZVN/PQ+dVKa8w=;
 b=H4RHNdqGledWnQWj3x12+aT0arASJrHtSZ9TrhnZpwn/gORWeZ3LEQezyPdTr3SbbaontxpEbkQBmMQwoYdnFVUaV7vm5eiGJ3ZK1VYoPlyLUob8yikZZnn2PifyN40Yzxi1Bq0NOJ3TqPPFMI/uC4HHwfwBpcsPC5NU2loR2tE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from MWHPR0101MB3165.prod.exchangelabs.com (2603:10b6:301:2f::19) by
 MWHPR0101MB2990.prod.exchangelabs.com (2603:10b6:301:2d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.22; Mon, 21 Jun 2021 03:10:41 +0000
Received: from MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::921:cd21:94b0:c87b]) by MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::921:cd21:94b0:c87b%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 03:10:41 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     util-linux@vger.kernel.org
Cc:     kzak@redhat.com, patches@amperecomputing.com,
        zwang@amperecomputing.com, mas@amperecomputing.com,
        ilkka@os.amperecomputing.com, jeremy.linton@arm.com,
        jbastian@redhat.com, m.mizuma@jp.fujitsu.com,
        patrick.zhang@amperecomputing.com,
        Huang Shijie <shijie@os.amperecomputing.com>
Subject: [RFC PATCH] lscpu: get more infomation when using  "/sys/firmware/dmi/entries/4-0/raw"
Date:   Mon, 21 Jun 2021 11:09:00 +0000
Message-Id: <20210621110900.41043-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.30.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [180.167.209.74]
X-ClientProxiedBy: CY1PR07CA0033.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::43) To MWHPR0101MB3165.prod.exchangelabs.com
 (2603:10b6:301:2f::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hsj.amperecomputing.com (180.167.209.74) by CY1PR07CA0033.namprd07.prod.outlook.com (2a01:111:e400:c60a::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 03:10:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7e36105-f61e-4e8c-79eb-08d934622629
X-MS-TrafficTypeDiagnostic: MWHPR0101MB2990:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR0101MB2990D4971042C2CC8A989896ED0A9@MWHPR0101MB2990.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EYLexc0oGp8ijOwhevBKZPbvlsGwXMTWgybm78fB19jUlbHQQG/G5UytbweuGgSQW2J51LPDu07iwGNUmgk6VxJybpPThHL8aR+2HNSJZvS4hPe/Xc62cN5nutcVVEH5+/5O4C5s9X51gCKDD88K9UIKrGJjKRgNuuNUU52GU9l2DcBg+Db2p5H91x/rjW9/7qiMS0NGf/5Xnl9RNRbDMYSHNQAhEOxByG02aeB//PL/oHXwZ4u8JWRGu5nuATBsI5ij5OiGRiQ6zJmZJWV9iK6ZG0Be+gk8zfiUg7S99J7tztLcy2PoEYCo3500n/qjqU8JnW5DdQU4rZK67nE78Q2iuMexnY5umXst0AuoJDXPB71sp2oSkwpV3GFpwKgiUC/9vXy51K2XcVtouym+pS37HUjKOJ3NGGBR8xMH0XBGxcMwRD4N/007aZ4Al1j465iPgrwNeN3r7V+5mws7s9GNVaa4/oQ58aMoW0H0Ke2PplZZPqLf48y10eLbg0Sxk7adQ3h/i/KKTS65agxc10mzOH83x2q7tPa9sRHJ+MTB3rn6fB/3RIh9dR4NFyc1YtxtaRcGIQdtfpjT4AtATLOAMC8pmSR7iby6blttIeRfMImxxLTItEt+7NF0TlwQourSoag6nSkG2a/+3cE4JA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB3165.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(376002)(366004)(136003)(346002)(396003)(2906002)(8676002)(66946007)(4326008)(8936002)(478600001)(6916009)(956004)(6506007)(316002)(2616005)(83380400001)(26005)(6512007)(38350700002)(38100700002)(5660300002)(186003)(1076003)(16526019)(86362001)(6666004)(66476007)(6486002)(107886003)(52116002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGdUNkNGUlhpOHdUS2lqLzVJS0k5Z0pCdE5tRmtZZjdFRG5IOHRNSHg0UXdy?=
 =?utf-8?B?SEhmeVhmL3pkdSszOEdKVys1c2RtSVcyWlZSdFBTUkIrNkltWUF1S3NNSVVr?=
 =?utf-8?B?TzlDWmtZRXNmUDJncGpycUdMOXNqSitHZHRwNVpISjNyNTk4Wmp3MWllZEE2?=
 =?utf-8?B?TFhubFJEbElFQnA4akFmdGFveDVUdmtQWm9oMmNFNWk4emh1VUQxZ09YMytY?=
 =?utf-8?B?MWtjYXdCOWsvSTJ3TVdCK0tWN3pxd2ZRRnhhaXZSNWRua2V4WXYzRXU5SmY2?=
 =?utf-8?B?aFBDWE5mMmZoVFg2U3licUszRGhsYnVCLyt6c1czMW5JS0Y1aHN5ajIvbGc3?=
 =?utf-8?B?eFhOekRlWHltUWRWQ1BBTHoycWY4TDFJTEtFOXYzTlUwMTBoQzdyOVFhdFV1?=
 =?utf-8?B?U2hNNTdhN2x4Smo0SWY3RW43RHF3MlpTcm1MQW1qWFZ0bnJnTUwvV3J6Kzgr?=
 =?utf-8?B?aFJsUmZmWTlBQXN4UjNNYkViamZJeVZCMlp3MlI1YVdJdCtTUGFuYUZGTHYz?=
 =?utf-8?B?bnhDd2taZEI2WVY4ZkdlT3NzeXpSQUFVK3RzOFhQMThqSVhBRGVIampPTzJ6?=
 =?utf-8?B?M0FpNEMwRGs5MDJXang2SnptWmExL2pUdGlGTElCZWl1QVlPaVQwdnl2b3NG?=
 =?utf-8?B?Nm5TOUNVbG9lbExBYnZubGxwVnJpNWJSLzEzY2dGWERQZHFtOXVqbzRVM2JM?=
 =?utf-8?B?MFRFUkxrbFd2Smo3NnNZM2xHTUpRZ3FiTHhNc3RQaHMzd2ZLbWV6SXJtcUtw?=
 =?utf-8?B?bTgzd0xjZzVTbW01WmdFbFZCVk9MaWVvTXoxUk5qUlVERUczUU1QSzI5WVFu?=
 =?utf-8?B?UEF4NXZiYm5CNndCNVlGaUx0eU1MaE8wTzh5Mkw5K3FOT0VZL3hNbG0xNExO?=
 =?utf-8?B?UHYzNWRDUWQ5dFREMXpidzFDdi83dTJwdDQyZ2FGRWVoRlowQ1gzWUlrSVR2?=
 =?utf-8?B?WnpCTDBmZ1JySWY4WHZreHRwamljNER6Y294dUhab2RydkRRK3FLWXhWb3VD?=
 =?utf-8?B?dDBXRmNVSC9NRDJjL2crSElmQnptRXVNVjkxKzdEeCtIekRxM1Z0MmJZUElE?=
 =?utf-8?B?YjVjRHFDclFwNjFVWk5KT1l2VTJnMjlHNzZFTFIrekU4RGVDbmhDaTRWVU0y?=
 =?utf-8?B?UXBLR0k0dDRDeFBaRk9lU3J1RjdvRGlLZDRvQ0dzb1VDSE96VFpDSHh0aW9k?=
 =?utf-8?B?SzJNTjQyYW0rdFhjMXl2VEdCbmF2VUE5bUp3WUtSaGQrQUE5bHI5dnJhcjc1?=
 =?utf-8?B?VVUySHN4Y25WRWZVbUZKMDUva1NsMHkvNFZHenRHZkJac2lka1R2K0dmb2ho?=
 =?utf-8?B?VE9SQ1R3S0I0SXkvK3lFUmJ6bkVVMHBsdGp1MmsrUEgrN21vYk5GSisrb3dq?=
 =?utf-8?B?aTZ1V1dwV091NWtZcG1QTW9ZSFBKeWlLdzhPc25rcHZZOGRaYlQ0VHlZNmRj?=
 =?utf-8?B?Sko1TVllYzBJcGRzTHVUMUJmY04vWHlscmxMNTBCZDBoOTk5bnhNVVZJdkh4?=
 =?utf-8?B?bG5ZS3VoSnkwVFlqeXFhT0V5YmcrYVZlUU9LMjFRRkg4Y2IwQ1JIaXdqc3lo?=
 =?utf-8?B?T1ByQ202aHdLQ1NXZ3JOZmtTZjc4MEVGNkJkZ1dnOGg2bitvS0NGaE5UcWho?=
 =?utf-8?B?c0YzT2FRanFFdnVUNmRCWXFSbHV1ZHRnaE5MMytwZWZSWGY1cjdMQnJRWDRF?=
 =?utf-8?B?cURHYzlERVN0SFJMZURVaDcyQlQvemlIWUZlZVg2NXZ5RFdHUHRYYXQ0L25s?=
 =?utf-8?Q?x9SnfrHtAy9VGgM833l8jGzXkHXjXG1F09C1qCc?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e36105-f61e-4e8c-79eb-08d934622629
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB3165.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 03:10:40.6914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IUB1l5rvfHzL21yFLPrtIeFvGjBNTG0Kw0TfLxgjx+7S1BGOxiOCV87pbm6W7513tQWjDqSfFsfUi03itDdmx6ZDg3gZGLucbqfQUv7E5M7RoIz53OlDqy536oFkwjY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0101MB2990
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

This patch gets more infomation for "BIOS Model name"
from the file "/sys/firmware/dmi/entries/4-0/raw"

Before this patch, we can get the output from Centos 7.9:
  ----------------------------------------------------
  BIOS Vendor ID:                  Ampere(TM)
  Model name：                     Neoverse-N1
    BIOS Model name:               Ampere(TM) Altra(TM) Processor
  ----------------------------------------------------

 After this patch, in Centos 7.9, we get:
  ----------------------------------------------------
  BIOS Vendor ID:                  Ampere(TM)
  Model name：                     Neoverse-N1
    BIOS Model name:               Ampere(TM) Altra(TM) Processor Q00-00 CPU @ 2.8GHz
  ----------------------------------------------------

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 sys-utils/lscpu-arm.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/sys-utils/lscpu-arm.c b/sys-utils/lscpu-arm.c
index 885aadc36..1af689649 100644
--- a/sys-utils/lscpu-arm.c
+++ b/sys-utils/lscpu-arm.c
@@ -317,6 +317,8 @@ static int arm_rXpY_decode(struct lscpu_cputype *ct)
 
 #define PROC_MFR_OFFSET		0x07
 #define PROC_VERSION_OFFSET	0x10
+#define PROC_CURRENT_SPEED	0x16
+#define PROC_PART_NUM		0x22
 
 /*
  * Use firmware to get human readable names
@@ -324,7 +326,8 @@ static int arm_rXpY_decode(struct lscpu_cputype *ct)
 static int arm_smbios_decode(struct lscpu_cputype *ct)
 {
 	uint8_t data[8192];
-	char buf[128], *str;
+	char buf[128], *str, *str1;
+	uint16_t current_speed;
 	struct lscpu_dmi_header h;
 	int fd;
 	ssize_t rs;
@@ -348,8 +351,12 @@ static int arm_smbios_decode(struct lscpu_cputype *ct)
 	}
 
 	str = dmi_string(&h, data[PROC_VERSION_OFFSET]);
-	if (str) {
-		xstrncpy(buf, str, 127);
+	str1 = dmi_string(&h, data[PROC_PART_NUM]);
+	current_speed = *((uint16_t *)(&data[PROC_CURRENT_SPEED]));
+	if (str || str1) {
+		snprintf(buf, sizeof(buf), "%s %s CPU @ %d.%dGHz",
+			(str ?: ""), (str1 ?: ""),
+			current_speed / 1000, (current_speed % 1000) / 100);
 		ct->bios_modelname = xstrdup(buf);
 	}
 
-- 
2.30.2

