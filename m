Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CE8C48BC2
	for <util-linux@archiver.kernel.org>; Wed, 23 Jun 2021 21:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FB5361164
	for <util-linux@archiver.kernel.org>; Wed, 23 Jun 2021 21:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhFWVHl (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 23 Jun 2021 17:07:41 -0400
Received: from mail-bn7nam10on2088.outbound.protection.outlook.com ([40.107.92.88]:15424
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229660AbhFWVHk (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 23 Jun 2021 17:07:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhHykqa3kFwf+oRjmEVoxwAC2t0XdVfxnHWw+uFY6WwuD+zB29bwR+UwBJASNWoilT0uxS21yEXuRnd7Ow2n7xRdmjCu7xorOEJ719rQz8j7lg1oX/on4o28X6NYBufcuJxMvOIBRQqSdAEnr7cJTees0kPd38hEP0xXcVE0VmZ0iVVzq/SJ042Ljv9fYLjy9RCqdugGfxHp024mhiOgdnMGGbjFV3H6CWT8bZslsXu9tmmsvXo7U3Z9JgwAfysprq+F4XpsVAk/bDhYtNNMUwwu4iTnXqwGSkB1Mx7123XKcYSPWOGYBNj51BoQ93f4xJhgYittBKejVNeMikMzCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySLZo5ogXrl6vPAeD7/nYBlhQNVzTFQMnPJsbFHp6f4=;
 b=bfWgHc41/w2H5quH7dZd13NCCsggYxYkkXRV10fPFaHhSJXeKOlqyOy5En6Lf+TVPeue9lmz9j1fInZLrHx9yrdC5+7sjqpCold24mRAQh5TUBMGiiblba8lrwm4LLSwVUCZqJidnQjbQxIc1xIDqOCkgwa6ZNo8s2gmxvlgKlAh98CUaLahAHoDuVqk7PviBFsSJmMJLS3TwEncYU4QvCaAzcQE5P5y7EV1v8L6MQDTM+qMrj4+Tf9e+E5B95zCtkdzVRTdBXQbvQoo9I2ILvD2iEoqSYRDwG/DO6GynDdkvBgH/UmA4YSKuTfScsWwopbDNlTIR/GLfP1SGe2zgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corellium.com; dmarc=pass action=none
 header.from=corellium.com; dkim=pass header.d=corellium.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORGFT1575309.onmicrosoft.com;
 s=selector2-NETORGFT1575309-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySLZo5ogXrl6vPAeD7/nYBlhQNVzTFQMnPJsbFHp6f4=;
 b=SEJ3kWphOS6HAtmEnkKLFEMjtIhrUN540MqSwyWEEVN9lCdacOIDFIfz3n2x3noA6hEP1ciyYkpdvmrQj3xnkXlE7BUajjFE6ORdgWK0iZN8EOeHJWvSEtB3RJJmQVDyxjQGZNmFPoTF2DDH/rK8OyIZP8wWv3heWK9q8p+j5L0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=corellium.com;
Received: from SA0PR15MB3902.namprd15.prod.outlook.com (2603:10b6:806:8e::24)
 by SA1PR15MB5000.namprd15.prod.outlook.com (2603:10b6:806:1db::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 23 Jun
 2021 21:05:21 +0000
Received: from SA0PR15MB3902.namprd15.prod.outlook.com
 ([fe80::4c07:e9b8:1c79:84d]) by SA0PR15MB3902.namprd15.prod.outlook.com
 ([fe80::4c07:e9b8:1c79:84d%9]) with mapi id 15.20.4264.018; Wed, 23 Jun 2021
 21:05:21 +0000
Date:   Wed, 23 Jun 2021 18:05:11 -0300
From:   Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= <ernesto@corellium.com>
To:     util-linux@vger.kernel.org
Subject: [PATCH] libmount: don't fail do_mount_by_pattern() on EBUSY
Message-ID: <20210623210511.GA8532@eaf>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Originating-IP: [190.19.68.199]
X-ClientProxiedBy: CPYP284CA0009.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:68::14) To SA0PR15MB3902.namprd15.prod.outlook.com
 (2603:10b6:806:8e::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from eaf (190.19.68.199) by CPYP284CA0009.BRAP284.PROD.OUTLOOK.COM (2603:10d6:103:68::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Wed, 23 Jun 2021 21:05:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d5fbc07-360f-4a76-c689-08d9368a9cbb
X-MS-TrafficTypeDiagnostic: SA1PR15MB5000:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB500064866FDC422A3DF8C569AB089@SA1PR15MB5000.namprd15.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7S63PeQ7FUIDGonwEr3gKpMnYnZBkOeEEfVfAf7UQTPLCnlhL1/11NmT2Tyxx1hbc8Sf2iwD3XmZzqzlH4dXGia03TT9S/j7Utoc4c/9VcwCjKXCcI0TGDp52m6qFZHPTSn2vOM4DbN50/+GQZeCJSl/PFgWi4tldZjj9MGjFOsdBR8DI9VT80XHM2lujN3zandEOsV9jVAu4OhZZOnuLWPbmFI3Agm5/P0qqaOlTlwAMdQgpImog9umzuJ5os6rxWRQ/YzOVm1641mxp+W3PoEQS3fd7ZyU6/uvPmfBhss17P1mMecEEuoEp4/Jzcpglyl1tHhJkqsE3iEHl2gtjUOjtxXHpWcflPEYGx3LIiTi4AyEBkba7u1FRzl841I2MnrAuvMHqauC5gY6q4V2d1UWN34uEBpIB5GF5H5RdN3O2OdvnE/qCKCVV2q4e+aN9GF4j6U+Dd6PRtJE1/+W4cGm4HLa6+ATT8mPfddMbWkJVIXYJgpAXbJkgASk69+WWcFK9bDlEWMMOh101fTHZKvhouRD2NC2f42JsczLQbHNCbiQ/7PpcGyTHnbw9n0iqqR1jx2Mx3FK+cOaozE8+qPdbMZsKYqLu6LBxhVcnSfm4aIIWQikULW7I8jAdb4e0fguHZhE2BlGD1V+pWDUHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3902.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(396003)(366004)(346002)(136003)(376002)(66574015)(9576002)(956004)(6916009)(5660300002)(9686003)(55016002)(38350700002)(38100700002)(1076003)(8936002)(86362001)(8676002)(316002)(33716001)(66556008)(2906002)(478600001)(6496006)(16526019)(26005)(33656002)(52116002)(6666004)(66476007)(66946007)(83380400001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ulc2cEM5STd6VmFWTFdBZllwSlR5TERsR1gxRks0dnlZL2dPY2kwZTAxYnU2?=
 =?utf-8?B?UDFlOUViM1hrcHhJeURZSWtZK0tyTGNVN2laMUI2MUdnOTdBNUpFZXBGbXB4?=
 =?utf-8?B?UnlVSGxNa1c3a1BLMkxXa3FUeFRHNkt5OXVNRkRqd2xMNG1uczJJTUMyRzJu?=
 =?utf-8?B?UjBweUlxMVU4QW8vUXJGOVd6dHpXOHRtb3ZmVVBCVjdBZjZKLzdVOUMzZVI1?=
 =?utf-8?B?THNoZjN4M3hCeDdjemdsSEpGZTFmSllxdUpGalk1S3RTS04rQnlPQWkxV0Yz?=
 =?utf-8?B?ZDhZNnJXb01qcTF4Sy9GM3JyNXRRRW45d1hNSFZOcDVjWDFmbHlTY0tqeU02?=
 =?utf-8?B?d1Y1R2xvcWxxUHNKQ1pOc202Z2R6cTFSVG5oYTFtNVhaMFpIVjR2ZFVjeFpy?=
 =?utf-8?B?TzhaUitNQStnK0w4RFI3d1hMSGc2N2NhZWVhZXkzZUFMbkJ0c29LejUvNXF0?=
 =?utf-8?B?bVpBdjNQbXlsZjFVQzI1ZDBXajkyc0YvalFCTUNQbFM4YktjZUp6dVNtb1g0?=
 =?utf-8?B?ODdpWHpjbG4vcHVPU1c5K0RYYWs5eTd0a0g3QWFsMzZVRnlteVdUcE1YQVUr?=
 =?utf-8?B?UkJkUHVkZ3BMWnJEblZPSmZMZ1BSODFhUHcwa1hXNWFIdGhFeUkzK1dHQkhR?=
 =?utf-8?B?aS9Yc25sVTVLK3lqZXp5VkNta0NuaGIzbFlFQlNLNmY2UWdrc0k1WlFpWFFl?=
 =?utf-8?B?ZmZpRmVFcXRiL1pza0VReFdYMkZJS0lJYUFWejVhTDdrR1h6N1lNYkg1c29h?=
 =?utf-8?B?OTlPYnJvSU5uMjlFUEpNcWd1ZUl5SXQrM3p3ZXlibFNHclhCSkR2NTdxbFI2?=
 =?utf-8?B?b3crY09xdVlKdUFoOGZ0VWIxQllaSHhFQ2xLY3F3REtoK2prb2RPY0RvanEw?=
 =?utf-8?B?bVA2QTdrVW9QMGxKT2REaWh1MXQxZ0c3QU94SHZwUVkzRk41VEwvTlpaaERU?=
 =?utf-8?B?TFBhRDBVSWJ6eW1FUm91V255OXZjajZNVmYvUjlOcTk5SFRMU0R5RTBvS3c5?=
 =?utf-8?B?SUtKWnEwL3BrOGt3SXdrNFpIaGxibk9xeUhaakZyZWVlZHlVOVc3a0J6MlV5?=
 =?utf-8?B?cExhd24yaWNlMXJSTm5zMU1LcVlxRUo2Rk5GY2p3dmVEUCtQQWRPNitiTTJQ?=
 =?utf-8?B?ZzFBTk82bFNVN1NrVHZjNzZneFhmVldQc3U4VDhUNFBSMlRVZDErTmNPS0RE?=
 =?utf-8?B?c0owOEt5MGhITVVRK2RPOGVRRVZJc3hINjhFTjR4eGFmQ0NWd0NQc0xqNGRm?=
 =?utf-8?B?ZUxZbTBORWtlNjNNa1U3NkJEeHo2MHpqbUVFK2NZaGZGY1RDVmpIMHBxVlkv?=
 =?utf-8?B?d0NQTGRRa3hvNUNzczdRSDZZNzVrcGNOekFRc21rY2Y1QjZWOVVpRkI3bS9R?=
 =?utf-8?B?RWlZS1lnaTVabFVtYjh5YjVhaUtOQndLQ0NMVWlhaW1BSnhreG1YOG1sTDYw?=
 =?utf-8?B?TFcvMWRuOGoyYlpWdjlOOU5LZnpucTFBeEIrUzhlRlY2V2FOMFRCYjJQVjg4?=
 =?utf-8?B?QitEdFRxMVdyNytLQnBDaFlxRWV5OGxQbjA0MUUrekVHdVBtbHNLN3d4Q1I0?=
 =?utf-8?B?dEVpNTNTQ21ZR056aS90ZTU0YktkS1dFZ2M4YmN5eFRUUW5tSTVocDkxWU5W?=
 =?utf-8?B?VnVURmxIWlNJZ3J0VmlGZXJaZkdWWUNORTk2RzlHQW1xY2pWb1pKbVgyZWpO?=
 =?utf-8?B?Qmp5dm4rOTB5VkZDcnlQWDU5SGhRWkFWM1cyRkVtN0kyZGhna2ZkUTR5QUkz?=
 =?utf-8?Q?rkw+NYxNm62Hgl0ubAwwt9/zYKLkIypWJpaI9tz?=
X-OriginatorOrg: corellium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5fbc07-360f-4a76-c689-08d9368a9cbb
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3902.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 21:05:21.3589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: cb8b7e88-0f9e-40ec-b342-a8686aa25f69
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a40zU7fYI1T3L/p55Rd4vQBJVLdG7ECog54haoSOzUvf4fGQ++eFdZm9w2QRnXs4zel1Dv9eCin1+QLA1rlrDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5000
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Filesystems with subvolumes still take exclusive ownership of the block
device when mounted. If the mount command is later called for another
subvolume, it's possible that the do_mount_by_pattern() loop will
attempt a different filesystem first, which will fail immediately with
EBUSY.

I ran into this while working with an APFS driver, using util-linux
2.32.1. The problem is gone in more recent releases because mount can
now recognize APFS by the superblock, but allow EBUSY anyway in case
that fails.

Signed-off-by: Ernesto A. Fernández <ernesto@corellium.com>
---
 libmount/src/context_mount.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libmount/src/context_mount.c b/libmount/src/context_mount.c
index 55ebf7945..69dc97465 100644
--- a/libmount/src/context_mount.c
+++ b/libmount/src/context_mount.c
@@ -957,7 +957,8 @@ static int do_mount_by_pattern(struct libmnt_context *cxt, const char *pattern)
 		if (is_success_status(cxt))
 			break;
 		if (mnt_context_get_syscall_errno(cxt) != EINVAL &&
-		    mnt_context_get_syscall_errno(cxt) != ENODEV)
+		    mnt_context_get_syscall_errno(cxt) != ENODEV &&
+		    mnt_context_get_syscall_errno(cxt) != EBUSY)
 			break;
 	}
 	mnt_free_filesystems(filesystems);
-- 
2.27.0

