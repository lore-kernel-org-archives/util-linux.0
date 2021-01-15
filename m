Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FAFC433E0
	for <util-linux@archiver.kernel.org>; Fri, 15 Jan 2021 14:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A5F92336F
	for <util-linux@archiver.kernel.org>; Fri, 15 Jan 2021 14:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732260AbhAOOB1 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 15 Jan 2021 09:01:27 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:20233 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732574AbhAOOB1 (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 15 Jan 2021 09:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1610719219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=V2Aa5aUsuOWeXiMNa8SMCpAOk/rm1T2scTv3IJNAJ6U=;
        b=iYsHGsjfiV99JLlYDx4beGchHDMRqUbTtCOIldmevY6yz7MUv67gCVxIg1DnWxEuX6nh0p
        Uh5+qDsMMuBqCCH7DBebs/RNf6JKgEzvPchXUrOYZx0X+jOl4mnuAXX6oQyQyG+V3NtWFq
        6Gizh2xeTadvbUFpLgZr361GwrdTjaE=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2110.outbound.protection.outlook.com [104.47.18.110])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-19-vrZetkyWMdikuJjv5XrJVg-1; Fri, 15 Jan 2021 15:00:13 +0100
X-MC-Unique: vrZetkyWMdikuJjv5XrJVg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9aPAdJbFMxQvRI4Wp38DhV4+1iSzRyFDdNWRUVxrQpNLoyF/D9s1Gfh3/353/4EFAJz/rIXbyaHnMW+8Z9KsQ+BtPpe01wlqjrhfIfGcvBzP1RMNplinjc1wi576G0yhFPud3qw9YpMcGncVyN3TtvptGISqFUqKOb+utse0gwgcIp3aTkI1DLMZjmcC4c7YL3gBk8uD/Z16AxdSrL5C+VcaLoDOHJV8jtwEr51KeYDW5nzQdG9cBSk8Rmpk1A29ZqT5LXamGYgdjs6HFUOeXnZY9idprNldzh7bmGK+Yt6Plezv9BP6UT9HerY14ZhSuTl9rOQBDhDA5EOpwrHqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2Aa5aUsuOWeXiMNa8SMCpAOk/rm1T2scTv3IJNAJ6U=;
 b=EbLZUux3mJaQJocoa4Iu/PJgwJ0uA7TjxSMOYFh1RYTxb95uDxMu9jY5oC7gyS3Y+zGC5uAPznrx0/jOiuf2wo5qoP3NSpx3U7OYtE+i9bS2XSyB0XYZfXbRLgJX0VJdg3iYOFd0XdMBlUZujgnX2nB5eqZy1Tt4j1I6Swcz4BL4jrFd9VQwwe+8r4axiJa3FccLxEFK1mEt87GIguDEH66uQucFGKNm4p/ZqxusJFdkfABo4x9R4bReyLAvsh7KYvFXEzYtUxQUSHJbhdDsqiTg54+qxJm0OFlVhUnv+GoMpkIbF9ONtxTXfD0VRRl89P+3qNiFfVEH7B+6xq/VAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB7173.eurprd04.prod.outlook.com (2603:10a6:20b:122::11)
 by AM5PR0401MB2500.eurprd04.prod.outlook.com (2603:10a6:203:37::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Fri, 15 Jan
 2021 14:00:12 +0000
Received: from AM7PR04MB7173.eurprd04.prod.outlook.com
 ([fe80::1838:a2a2:486d:2333]) by AM7PR04MB7173.eurprd04.prod.outlook.com
 ([fe80::1838:a2a2:486d:2333%3]) with mapi id 15.20.3742.012; Fri, 15 Jan 2021
 14:00:12 +0000
Message-ID: <2f66f8913a6bb2d70201e46efa369b51817ea243.camel@suse.com>
Subject: [PATCH v2] ipcs: Avoid shmall overflows
From:   Vasilis Liaskovitis <vliaskovitis@suse.com>
To:     util-linux@vger.kernel.org
Cc:     kzak@redhat.com, ruediger.meier@ga-group.nl, sbrabec@suse.com
Date:   Fri, 15 Jan 2021 15:00:11 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
Content-Transfer-Encoding: 7bit
X-Originating-IP: [78.55.75.166]
X-ClientProxiedBy: AM0PR10CA0015.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::25) To AM7PR04MB7173.eurprd04.prod.outlook.com
 (2603:10a6:20b:122::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.9] (78.55.75.166) by AM0PR10CA0015.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Fri, 15 Jan 2021 14:00:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 826b2bb9-a9ad-44fb-18c7-08d8b95de067
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2500:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0401MB250086592FC599B2F17A5134B1A70@AM5PR0401MB2500.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AT+vKiiIFuKL+xKGAHofW9myX9sTPefBUK1CxEcBrmXAz6Mn/Cl5mYka9SybeW+L0w73jQOjoREIEcFktLumPTj/DjtQ9PESL+DPHx0UkyAYuS4AChHCp15yJbRooiQIXPCa9DX4X9V0yBdLKlBeGYPT6ynBJ383qr9/+Ep3MIOo8ifx9fQXEExfhTuZHBH7zBZhtKNH/zZO830mQ/ijcC0dl3sHSMBOp+nCCeFcM15f/zzZWzo1WfTdX/RfB92vvkaH6hTSA5aFjw4Z3JXGE8IxcO1fPs03IHwdx2v5hMXimVUPf2uLHj5Xo284hZlil4wYaDXzWjGM2dACWVNFECTOVVUboPQvNUWbyp0jfkqqvegTr/OWvwt5M6rJEEia4IqZ+64CtCNzwADOWuE5Gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7173.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(136003)(396003)(366004)(346002)(8676002)(83380400001)(316002)(107886003)(4326008)(66556008)(186003)(16526019)(66946007)(26005)(52116002)(6916009)(2906002)(5660300002)(2616005)(478600001)(36756003)(6486002)(66476007)(956004)(86362001)(8936002)(16576012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VmlIeStQcjNWT0dSblMyRmo1Y0ZtK2dIak5GUEUvWjc3dWJtYnVnSmhYbkJa?=
 =?utf-8?B?cWdaSlgvV1RIUVU4alg4ZXhMVjJjZkZOZVgzd1hsNGg2ME1vaHAvZnVTSHBC?=
 =?utf-8?B?cHk0NS9tUlJCTXJJNWovYlp1NCtXYlZJVEhtWkRtT1lsWmt2SHZ5a3N1ZFh3?=
 =?utf-8?B?MVVhellTcllRMmxnMDFrUWpsQ0NSeHZPcmNZN2N6d0pTTTMvK2FBMVpFZWM3?=
 =?utf-8?B?ZnJrSW9MUy9iQ3VRL1l1VGhMZzRqYXpLTjdPQUZtbUhuNWg4OUttRU9NaHQw?=
 =?utf-8?B?eTlKUnBJa2twNnA4Rk9Uc2l5MlYyY2JGZUFjNzNlcnJYN3Jva0lYMlRrVWlS?=
 =?utf-8?B?L1VpOEVNek80OTUyMytsclQvUlordkxoeDRiUk1ZYlRBa3ovWDJ3M255ZnpW?=
 =?utf-8?B?bFhLVHZQQ0MxU3U0QXkzMVJiS2tmU3B0dFNNRDludmZCcWhDMDJaWWMxQW9M?=
 =?utf-8?B?RnVEczVwVHBudVVRVEJEejh3YkFFK2lvMWpJdWJWOHFDYjRqcVE4aFpsV0xm?=
 =?utf-8?B?aUUzckhTT0hXcGUyVGxTbmRHZ1RWejRtcW1GbzlUWUJVMXcyeU9uNkY2ejZx?=
 =?utf-8?B?N241cnRZUHJOelhnQWd1QW42eWpVcExoUGxIdGhKRUVCM3NLa1kvTzJyLzV5?=
 =?utf-8?B?QmNtT3NNbi9GQndNV0Z4d0F2dDlYb1RXNEJtV3lIQUJjT2c2YmdXTWx0TWFI?=
 =?utf-8?B?endCK0xpYWg1dG81MUFOUjlFc3dsZ215b1lOM2p5SmsvTlpNditDUUUzbDVC?=
 =?utf-8?B?KzEwQWRBdHVPVlJ0a0JRQVZYR3kzN01JVEFyYkd2UXgrUmZKWjhGTzBkTWFl?=
 =?utf-8?B?czJOY0oxYkxqVEdiLytqTlBBN241TERzSndNMHI2Tk8vOUFvMXVWTGhMT011?=
 =?utf-8?B?MzZwQ2t3ZXBjb3lLQ3dUaCtMUHAybUZQZnNjd0todWY1RkZlK0crV1BlN2FN?=
 =?utf-8?B?VWJBMXIreUNZQ1lLK250YjVGSWhPVGlyZHQ0MEdScTVVcnpEVE5uUlhNQXBa?=
 =?utf-8?B?QzZWcHpSMmRjNTdxcDVFdUsvNzdwNlJiOHphcGdmUHIzSG9iNDBwNUNvVStP?=
 =?utf-8?B?Z3M3WjE5akxrb2lzQVVSczBpK3Ryc0tQQnNmV0lZd3RKTEZOM2M2TGI5bVlL?=
 =?utf-8?B?R1A2ekUzZ1Fibmx0cEhqWDdqdHRYT0hyaUFJOVV3MjZVS3JVTDZOcGNxZUhj?=
 =?utf-8?B?a2U0VythcDErV1RHMnJxMVphWmtOS1FzSDFWQW1xdTc0T3QvUy8zWElIRTJm?=
 =?utf-8?B?UzJzL2lYNENwSGsrSndxTWp1Z1pNTjRpVm4vWVlJc1N0ZGZmckNnNlRWRWZu?=
 =?utf-8?Q?3Dk6p/kHbTdtM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 826b2bb9-a9ad-44fb-18c7-08d8b95de067
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7173.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 14:00:12.1990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bKin0rqbTLpF3aiojSx2oDPjRxQvfLHiQSzqH77ljLyiuWApTjMWCNIfS1pRhYUWDL/QZwnOEyJkPfQOpY+tNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2500
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Avoid computing the number of bytes in shmall, by only
computing and printing the number of Kbytes. This avoids
some overflows, e.g.

$ echo "4503599627370496" > /proc/sys/kernel/shmall
$ ipcs -l | grep 'max total shared memory'
Before:
max total shared memory (kbytes) = 18014398509481980
After:
max total shared memory (kbytes) = 18014398509481984

$ echo "99993599627370500" > /proc/sys/kernel/shmall
99993599627370500
$ ipcs -l | grep 'max total shared memory'
Before:
max total shared memory (kbytes) = 18014398509481980
After:
max total shared memory (kbytes) = 399974398509482000


v1->v2:
  Print the non-overflow KB value only for IPC_UNIT_KB and
IPC_UNIT_DEFAULT.
  This way --bytes and --human options will still get an expected
output
  (but not avoiding the overflow).

Signed-off-by: Vasilis Liaskovitis <vliaskovitis@suse.com>
---
 sys-utils/ipcs.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/sys-utils/ipcs.c b/sys-utils/ipcs.c
index fc6fba4a6..d36cb1d2a 100644
--- a/sys-utils/ipcs.c
+++ b/sys-utils/ipcs.c
@@ -216,13 +216,19 @@ static void do_shm (char format, int unit)
 		ipc_print_size(unit == IPC_UNIT_DEFAULT ? IPC_UNIT_KB :
unit,
 			       _("max seg size"), lim.shmmax, "\n", 0);
 
-		tmp = (uint64_t) lim.shmall * pgsz;
-		/* overflow handling, at least we don't print
ridiculous small values */
-		if (lim.shmall != 0 && tmp / lim.shmall != pgsz) {
-			tmp = UINT64_MAX - (UINT64_MAX % pgsz);
+		if (unit == IPC_UNIT_KB || unit == IPC_UNIT_DEFAULT) {
+			ipc_print_size(IPC_UNIT_DEFAULT,
+			       _("max total shared memory (kbytes)"),
(pgsz / 1024) *
+			       (uint64_t) lim.shmall, "\n", 0);
+		}
+		else {
+			tmp = (uint64_t) lim.shmall * pgsz;
+			/* overflow handling, at least we don't print
ridiculous small values */
+			if (lim.shmall != 0 && tmp / lim.shmall !=
pgsz) {
+			        tmp = UINT64_MAX - (UINT64_MAX % pgsz);
+		        }
+			ipc_print_size(unit, _("max total shared
memory"), tmp, "\n", 0);
 		}
-		ipc_print_size(unit == IPC_UNIT_DEFAULT ? IPC_UNIT_KB :
unit,
-			       _("max total shared memory"), tmp, "\n",
0);
 		ipc_print_size(unit == IPC_UNIT_DEFAULT ?
IPC_UNIT_BYTES : unit,
 			       _("min seg size"), lim.shmmin, "\n", 0);
 		return;
-- 
2.28.0


