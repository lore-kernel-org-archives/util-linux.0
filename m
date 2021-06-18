Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A491C48BDF
	for <util-linux@archiver.kernel.org>; Fri, 18 Jun 2021 04:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F547611CE
	for <util-linux@archiver.kernel.org>; Fri, 18 Jun 2021 04:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhFREtv (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 18 Jun 2021 00:49:51 -0400
Received: from mail-bn8nam12on2107.outbound.protection.outlook.com ([40.107.237.107]:47872
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231693AbhFREtu (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 18 Jun 2021 00:49:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+Su6gGEZ5oCCfVCIZJ9xFHTWeL3ez2BnsGLG7nRpVTaylzD1AJEbszxwiDbtsXpT8QCd2mdZYK2fflYtdGA07EDzuROiworgfX+t+tuzw6ueN5O7BCBpr9hh0+M84QDEStj4WacTdsLGu6hgJIYzp/fJUkRssdZx0v26k7SwxmU88gaa4Te5aKeNcA+qTgSaDF9ZLaLfmOCicx4nCBwMA4AxgWX/XTjtGo2sY6ak5ZcUmCAq9IOsDTOLWmIxz7MiZ3qYJTOrvdMKVxaA8aL8nstjqLfJ6kI8sBXS+uyVNTyotEVukmdXwRJKflpVifStw3cEDi4ju2NYNpQiIQjOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+qtIZv1XPhbqqG/kxtV/1RWe1CkNBtaKWp6ntKJous=;
 b=hlwt5PYFPG7M0Ml7rETZn8NH+WI6hCWW2aAcVzkCRhPCv/jrTaKCW+23j4x0gyt5wyMmyW5OW7WuTiIPP6B57HwIs2gpl2YxrS3r7d8fpc65Fq5BIQfhgcnJJ8TqYPWGAmQCUy+K8v5qR7TohDmDNSL2f/Hn7OZVbMPc/zbTeika4nAx8Vlo7SMTv1xPe7VivQ0Zy/qpOoFiI2L3qS+iJyZ1RXQfEbON1WMGSgtZUpTNsE4IR7mReGyDDhfwLK3IZh+wr+tOtvusmfO4iQFfWOJKKl26fwuabbdGI5oGg9LcE1n+7AWd+YYbqDh9BZDu/Z177Mzt8C0F33Vs9l2pGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+qtIZv1XPhbqqG/kxtV/1RWe1CkNBtaKWp6ntKJous=;
 b=cTtAf/zfl0mTd7CXJLPWr/Szofz34M4OQFZe0/1RUg9Vvs94O6nynAS0DynhKVJ7B5iyk+HUHJynwdG1YVVY4cuklJoFWfOolHpovcI0qyJ+JwcZJYkAP/paZ/XpsIILOKQp1AobPhSubLV+lTXcL9ycp+aUHTIKbxmN+6D5XxA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from MWHPR0101MB3165.prod.exchangelabs.com (2603:10b6:301:2f::19) by
 MWHPR01MB2477.prod.exchangelabs.com (2603:10b6:300:3f::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.25; Fri, 18 Jun 2021 04:47:37 +0000
Received: from MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::842:9ada:565f:8b98]) by MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::842:9ada:565f:8b98%3]) with mapi id 15.20.4219.027; Fri, 18 Jun 2021
 04:47:37 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     util-linux@vger.kernel.org
Cc:     kzak@redhat.com, patches@amperecomputing.com,
        zwang@amperecomputing.com, mas@amperecomputing.com,
        ilkka@os.amperecomputing.com, jeremy.linton@arm.com,
        jbastian@redhat.com, m.mizuma@jp.fujitsu.com,
        patrick.zhang@amperecomputing.com,
        Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH] lscpu: add more sanity checks for dmi_decode_cputype()
Date:   Fri, 18 Jun 2021 12:46:32 +0000
Message-Id: <20210618124632.16691-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [180.167.209.74]
X-ClientProxiedBy: CY5PR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:930:8::15) To MWHPR0101MB3165.prod.exchangelabs.com
 (2603:10b6:301:2f::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hsj.amperecomputing.com (180.167.209.74) by CY5PR03CA0033.namprd03.prod.outlook.com (2603:10b6:930:8::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Fri, 18 Jun 2021 04:47:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd86097e-d59d-460b-713c-08d93214319e
X-MS-TrafficTypeDiagnostic: MWHPR01MB2477:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR01MB2477D8D4D2210AA97CBEE37DED0D9@MWHPR01MB2477.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:230;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: frA1l1RxJY/SBPXd33c5iKgkriUwqEjNnDZHdQ/R8GgczXO9fYCjXDAlmsMRKpS19xySA39xukBRd0DBPiLw0T2ovi0UPUUFPLKVMz/qw03FEIELV5Fi+/Bb39zi4mz4gjaoknP4Oe6eZOSBQ5k+2WhPFjHjs/OSXg1z+BozsvFNplxgCm7B1mCmgltN6Y0Y4y4lF/8fm6iiFcpz8p50tIfF6BbheNFF97qX9/mxHs+pxlbPWzpVlfd4n4WQ8M3hrLFg7EyfFn/KIZxuyjt7rYR/wSm3v+u5Tf/2/FoWlOpAztlAxe6kzY++qJAcImAj/aDoh4GgxNMVAD/afBitFaMFpEo3wPAvMowQbFp2YWfCHPWboQSN0l3DUNbuXxntlAQHFpuGwdquroyLuS8uCn7tEgMGtCUkB35F5IweIVtkcYqxB6skXeUgFfWWJPGSHBYtnoY0vgoJrFlVCxPBtkC8zJfsV97hgYOyyQiZpGKo4u93HegXr5ukLs6DKvbesE97NmEMDNMnG35dBdMnD3dRbXtyT6m9cwJQHcbZmvUaLFs69euU7Gx12ggSeQIFNcWOvtvBgu5FCZwe6XsnS/GdNoBVf+W7zUkpImHKFVWCnua1dDu/+qJ6PDR5tCoc1iLvpkhkdXoFjA5STU+jz/7jgdRfcdVcGz8gha9fAFI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB3165.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(39850400004)(136003)(366004)(6916009)(186003)(26005)(4744005)(2906002)(86362001)(956004)(38350700002)(4326008)(107886003)(1076003)(2616005)(316002)(83380400001)(6486002)(8676002)(5660300002)(478600001)(52116002)(66946007)(66556008)(66476007)(16526019)(38100700002)(6512007)(8936002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CdFepN2oshs/STGOgJUVLNg7oKYsILtCTqvMkosdddLt75wmv5LfTLxCqK+N?=
 =?us-ascii?Q?2+eWkY5uCSLk3+Vc688apjFnvgxzUj3bJIU+UN5qcUZqAQac7cOX0n2y43vq?=
 =?us-ascii?Q?1uzd7AoL8oQjEHgStpCsnAkiVJg0fHS3ay1OfcLCUZZI0ce9kj6RwOAdF6i7?=
 =?us-ascii?Q?D5zgq2vyfmBjMPYlJ21AT14HnQWj2i+G3Y3WArWBP3XlAaGroZjrocbkjFGp?=
 =?us-ascii?Q?JhgdXz35+gVGSurMqOCCCU/ELm/X+lWy1QeJedtF0w3cFbNHye72EbLrQ/nO?=
 =?us-ascii?Q?htdNIz6znWV/Dc4qsISf57sjVNiY4v1EXd0qZnwbTaWC38ut5rFVsYw5VzWC?=
 =?us-ascii?Q?5OizIPYkxqOY4ZjRZBSZJUjq9/fySPI9YnsFghAFGtoSZJ2cy4Z0GpH7cVA6?=
 =?us-ascii?Q?7wRv3+lnwRDYT02hkWaiWyCJ01IQ4WChwV85jCdkQAoOXSz+fvGbXzcIhNNZ?=
 =?us-ascii?Q?ptNGlFnHeuJQ3Tc1JD0XxpknECodcKqT+IyHD8Mc4BI3T5El+O/MBQDFtgkj?=
 =?us-ascii?Q?nCsc4Eoc2Nkevt0jQXrxBDncGh2oi/Fgz/aJ92HXIyfzUZFq7BM+Kmxx/Xmy?=
 =?us-ascii?Q?VMyMVe7iITF4kcmlrCAyXweij9W5CSEwUyeOXvhDEFClDWXsUycfPQ493XNz?=
 =?us-ascii?Q?3+RdrFHDtg07Qb2NoHmmYCA8lErMcG4t3/Wmq3ONXZwQlLUpClQ5Qt/nlkAa?=
 =?us-ascii?Q?j05tDADLoVvOmePKk+oe1+nkz7/0PiSRA8Ba0Qbt3HnONUbtR7cLi/aj3PBa?=
 =?us-ascii?Q?PTsxw3FAfsSxulRp8z6PCmLofGu+07XC+bEEhbT1ZLRoVzn3BzXw6CSWWbRG?=
 =?us-ascii?Q?bKRHXrfLkHlRpT9yRKLx2VzePyd7DPJFJQIpVaIxWM/E0De4wGWChyAwSpuX?=
 =?us-ascii?Q?g4xm4QISTI2HJ9laZlvawMpJJedFw1XLsFzpWp4Glv4llJlnhcN2NxoebrGk?=
 =?us-ascii?Q?tTYd6dWChuLsIpWufGwvjCKDVoJyW2d3U7BWC5BO4ZBDm15V6R/SRewoV5qv?=
 =?us-ascii?Q?RsqUiMG2aKeYJ2Ln75JG4sPOw8ZBjfSOQVfhJrezTOUq2JEFe1c0xC37uCxU?=
 =?us-ascii?Q?YakMYAp1fr12M7/+en+44PkYVsHuTCuZrKe8Wu2/07Tj1yftqvsClU9pGKFs?=
 =?us-ascii?Q?FpHvyyg7siE1452vqyBuxUtrlvC2WqP3MoejYFfZRU34GpZInWEK11sjuBXg?=
 =?us-ascii?Q?IgFnyEo6ryi7U2Bxml9g4IWHiyfnsTPJpKd9pAMOAAEIZcz77OqMECBArFw2?=
 =?us-ascii?Q?4QBPDF6dbABG7t+kSxhFbkhZQsbvCbsqHDF3y3IB7iUDHtYoy4VS251uAQ9W?=
 =?us-ascii?Q?NUX3U37VhugltNlvy4HIJErX?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd86097e-d59d-460b-713c-08d93214319e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB3165.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 04:47:36.7575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /mY4UULCTnjX8ycSNf2hYH8Owtxg3uODj1Aw97NLoDhmbYHXxPUZpCWBqO8yz7HVQ/TpdPAbf0X7TsFi67GjkWnFIxy44LDSUloQK0fvUwMFsnm/4BF/TL5APmpnpAG0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR01MB2477
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

After tested on different platforms, we found dmi_string() may return NULL
in some case.

So add more sanity checks for dmi_decode_cputype().

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 sys-utils/lscpu-dmi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sys-utils/lscpu-dmi.c b/sys-utils/lscpu-dmi.c
index 782881b75..9b63dd685 100644
--- a/sys-utils/lscpu-dmi.c
+++ b/sys-utils/lscpu-dmi.c
@@ -115,10 +115,11 @@ int dmi_decode_cputype(struct lscpu_cputype *ct)
 		return rc;
 	}
 
-	ct->bios_vendor = xstrdup(di.processor_manufacturer);
+	if (di.processor_manufacturer)
+		ct->bios_vendor = xstrdup(di.processor_manufacturer);
 
-	snprintf(buf, sizeof(buf),
-			"%s %s CPU @ %d.%dGHz", di.processor_version, di.part_num,
+	snprintf(buf, sizeof(buf), "%s %s CPU @ %d.%dGHz",
+			(di.processor_version ?: ""), (di.part_num ?: ""),
 			di.current_speed/1000, (di.current_speed % 1000) / 100);
 	ct->bios_modelname = xstrdup(buf);
 
-- 
2.30.2

