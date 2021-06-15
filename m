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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7FAC48BE8
	for <util-linux@archiver.kernel.org>; Tue, 15 Jun 2021 02:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFC05613F5
	for <util-linux@archiver.kernel.org>; Tue, 15 Jun 2021 02:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhFOC0n (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 14 Jun 2021 22:26:43 -0400
Received: from mail-dm6nam12on2134.outbound.protection.outlook.com ([40.107.243.134]:27617
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230305AbhFOC0k (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 14 Jun 2021 22:26:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6ZuKubwh0c+oWzS6k7Gxcgtlg2i8TxaKJ6MNz6h1KchkmUgA0Nc2DQBKzFU6vCTM7NgtWKC90ZD6ukONSfxGHumyhyVyM31+ATVbrwN+7a4EDE0jg4qEFDEaZKqiJWIAMN6FUIJv1GUVUyxmPXQ/GL23LdxZmGcwRCWA71PpujGxXSbCxF1/Ha/sSztJpux1krct53pH59Ket8JGLXU4JOsJKRfVtFb4EHDysJcc+3UUkUaIotU6nZ/nNAIsijbn7D0VrC+sEOoxf9QaZamMP6E6D/bayJfJGWa/sDvNJQAEe4OpQm1QqhjZ/iQZS/CnlaQsmoG+cr6Xg1Wa2vZyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKHHRPwYSX6P3orHaQK0xvw+k8w5WMZNODuPkDXAKP0=;
 b=OGQ1qKW9UhAJkiyAEYtZMkD0dLo+lQrrt3wwjDl/fM6/QzK2VZru+n4KZwxXzXVe9taSlVbQvl43an5M3am6Ic33uON54EI8XDZeo5UxKaKYBQMcGkv6npMLGUjG/5kxCEEC/DieRD3JktDI8hBPtqXVU127U2FVm5fdQYrvBh3G7kSasRQpriRjdg8CjXWmr7gPBHXe7oVPedQAeTkO+g6+RBfjqUZNpR+jhEOAmIevwKNZz44zkgTOToRN5us/bYAGgkmntvdRI8T+ch7w4RK1Ww7q2HQWVqoGVCXfnEZ2qXvZrYhqghpe6YY54bWJNgHnXCFSp7P3aqiiMGdvng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKHHRPwYSX6P3orHaQK0xvw+k8w5WMZNODuPkDXAKP0=;
 b=NndUIV/t2MHGy6V/YtAOhY+BXWmjtsGqAjPC4rtVeISJHo9jT1m3dhPZnhURVPQpHfDnMQEtu8xRRPCfR0S7ktPQnrwrUy8DW4/cV/Rcn6+jOxAEdsngbrg9oOr6FCDzqMq3XzUUcEuoV2FOWEPUoUr4aB+a1Dh1gm9UfVhMMFU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from MWHPR0101MB3165.prod.exchangelabs.com (2603:10b6:301:2f::19) by
 CO1PR01MB6789.prod.exchangelabs.com (2603:10b6:303:fa::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.25; Tue, 15 Jun 2021 02:07:49 +0000
Received: from MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::842:9ada:565f:8b98]) by MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::842:9ada:565f:8b98%3]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 02:07:49 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     util-linux@vger.kernel.org
Cc:     patches@amperecomputing.com, zwang@amperecomputing.com,
        mas@amperecomputing.com, ilkka@os.amperecomputing.com,
        jeremy.linton@arm.com, jbastian@redhat.com,
        m.mizuma@jp.fujitsu.com,
        Huang Shijie <shijie@os.amperecomputing.com>
Subject: [RFC PATCH 2/2] lscpu: add bios_family
Date:   Tue, 15 Jun 2021 10:06:39 +0000
Message-Id: <20210615100639.51546-2-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615100639.51546-1-shijie@os.amperecomputing.com>
References: <20210615100639.51546-1-shijie@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [180.167.209.74]
X-ClientProxiedBy: CY4PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:903:33::12) To MWHPR0101MB3165.prod.exchangelabs.com
 (2603:10b6:301:2f::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hsj.amperecomputing.com (180.167.209.74) by CY4PR03CA0002.namprd03.prod.outlook.com (2603:10b6:903:33::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Tue, 15 Jun 2021 02:07:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ceeec36-0128-4293-23c1-08d92fa26027
X-MS-TrafficTypeDiagnostic: CO1PR01MB6789:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR01MB67896178BF809D20FC91E171ED309@CO1PR01MB6789.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:337;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 59qe7jcyBGhoUnKOnUmLpzXbt1b9s/T3mHunEclEH8Yv2NOwHTEzsFrCbEbmUAGczScQKriBUkuFyRS/ek9RCcfQ45/+drZuyU8QF3IdqbpjVjbgxidtZRdMFBNoUgCfQevCdVazdtyyfyAhyv9HpvEA1G6VkPEWVGi9O1ous27VlPj1E6tUAHOs3DrNTDgdafIb2DGUPanjjl8SfPJahfRTVJDQ99QKscxY6ydFuYNUO2gBs1WpVr2mfa9NhX55u+DtCbYEeR+8jwjGpgdaFi63dt/S0HG8N7hNtaSPXd80UrFB/GTnxSqYcsX30IOqtl8vendwhzskEIsBmloLq2n5dvYIVQYzRPDWyqBMyjUwxy84gt45fMhf9abC3rvYIxAaJDfUC3WxUEBHbgHYgtqAM5H3Ghz5URhU8lRJ8b0z37Q7n19OcE7SukXYsPLW92J+X6ZC2ClIG/jo8+g1fZr1Zd88uvZk2kjrr2b0pAWwk8k3VtCHXyiil9VTJv92Oi880udosJzy7eCb3bGyU+wqZTrLd3eKtNWVcYAEUTzz+/r7fViAroJy/v3+CAebvC4BFi7WhLeV/Hnd+qRU8DoIUoNN3q/Xpw6gF0wLRj6aE8riKnKwzNRPiW1k0U/pR+i4xSxTZMI+z+wwCmH8fBhtKWtVjCLpbKZfWIckJOg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB3165.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(136003)(39830400003)(376002)(4326008)(52116002)(316002)(6506007)(2906002)(186003)(16526019)(83380400001)(26005)(66946007)(5660300002)(66556008)(956004)(8936002)(38350700002)(6512007)(6666004)(38100700002)(8676002)(6916009)(107886003)(66476007)(6486002)(1076003)(86362001)(478600001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?whL7JvKEXusYO1HvR2ThlCz0weAUdqGRISBQXHzPdKkdsaW8PExgc4khCy85?=
 =?us-ascii?Q?zZ9MEbkfmyErXEgDKbg2ry0EN/YkL/nCkfmxPxwSQgSWl1Wqh0iJw83QwcSP?=
 =?us-ascii?Q?KZIjLzBs+8holrL/6M7FHhziYDS3t/V30OO/VfQGvkj7Ce6HOVPnruR1hjpT?=
 =?us-ascii?Q?ff8knqvnlo+FQWVNqeWMZcKKLIkja146AT3S5IjtOzJojoipBz0yZsiOrb7G?=
 =?us-ascii?Q?m8CM++t1QUqiIcCIaoFkiJI/Aha4Dwzh2f/WmJTPh+3/XXU8k0bdC1J6Apqw?=
 =?us-ascii?Q?Sh809bQhzfW6ux1MOK208ELjQPOfcjZ6CKjW1hlyEyjPfPHu/2V68s6I3KGN?=
 =?us-ascii?Q?39Nv1i/iQnf7KHQZKCqzi85kiFUbYiezZtskAU1xENCUpiHJ43opYLzCeIzj?=
 =?us-ascii?Q?tQ8LHkXI73C1PbcOExYbhTjL4KSJuPqETvXj3o3WYGhcd9U0pZ5LLo+ga1KJ?=
 =?us-ascii?Q?jzr4pehoqQIiQjYjY6KXojJbyRkGrtkZr/3JlmXSFCN6o3h9zhLD/Wd5cgxS?=
 =?us-ascii?Q?ZB0b/8bqs35uDUySpUNbb5I+7RlnzVokeP0Z9dQyyP+qhNqGIgV/IL7vxE80?=
 =?us-ascii?Q?0aHOb1hh3WcAttl8R3uiIXX9bjAlUKFMmczLKdrKO6ZvcYNXHkwe/IOiH1Hv?=
 =?us-ascii?Q?EMcB+kmFwZaJY53FR2ApgBX6QQWGNm5fr6Fvggo+RXKwblouIVN9PTlWpsMS?=
 =?us-ascii?Q?KSMsn2TzrVX4uHFD+/bzcz/UoMeAPuFlEgiL3cR/tPB+TNEPta1Rjdxt7Nhr?=
 =?us-ascii?Q?9igPIA9sKD95SF6EfdAk7pZRPz+1ofGKvnKMdiMqHE0YBlM6SjO78Sm8boCP?=
 =?us-ascii?Q?nogXWw0kWYh2HzEvdp7B5XfIHOc2Wko9DKVuWJH20oMVPCF6uW2r94lZCcgI?=
 =?us-ascii?Q?U7I3YNLRmkbEkfupAjBC9+0Eq9Mcf1juPXo7Ng3FHlzDfbjyHfssKwi58+3T?=
 =?us-ascii?Q?tjxkJwo8mL8nifvtfsPhhrLXPNszsX9DN2bkO+IcKiGP8iIGzT9rxvRQ7/dq?=
 =?us-ascii?Q?vNEvN8wBje2gY60ie41hRRD2Q0gRpwkbpx0V9SMMjaZS6tXVEptKyhK8uB8h?=
 =?us-ascii?Q?EvbrAwq19BfUWmrQwy7/0b2C/p00Mva3KMJq1scT5+WbAI3SNufQrnO7klh5?=
 =?us-ascii?Q?azEIsBDIN2BLtvIisUkyWKbidMdtYRTz4VXwv+wH8eXcjlj3AmLI3RHoDNZM?=
 =?us-ascii?Q?MT4okNgNGSeg7fpikaGpgCTvSqeLC91tOZD/4yzvGh2tOtNjQq9+/nkzMfvK?=
 =?us-ascii?Q?IlH1/Q7ecezBRKYh05dj6VS4BANKKp/DyccBRzVti1uFP06rSxfXkoe1rxwr?=
 =?us-ascii?Q?Ai9G5z5n03aTvJrfV9lDqpJH?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ceeec36-0128-4293-23c1-08d92fa26027
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB3165.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 02:07:49.8448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdedmTK6sox4vE3n05fzjd/BeZjRci3oFGlKlu4i/aLRIPlDk9VXuenlfLCBqf1nMcPUqyCSFaC2vbUkemrvo7jVrYiidVcMBmP9FCLv5sS9Y01BwKJOWi0cGCj5xJWF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6789
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

In the arm platform, we do not have the "CPU family" as X86.
In the linux kernel, it is hardcode to set the "CPU architecuture:8"
which should be changed for arm v9 in future.

This patch adds "bios_family" field, which we can get from the DMI table.
In the ampere Altra platform, we can get the new lscpu output:
    ----------------------------------------------------------------
	Architecture:                    aarch64
	CPU op-mode(s):                  32-bit, 64-bit
	Byte Order:                      Little Endian
	CPU(s):                          160
	On-line CPU(s) list:             0-159
	Vendor ID:                       ARM
	BIOS Vendor ID:                  Ampere(R)
	Model name:                      Neoverse-N1
	BIOS Model name:                 Ampere(R) Altra(R) Processor Q00-00 CPU @ 3.0GHz
	BIOS CPU family:                 257
	Model:                           1
	Thread(s) per core:              1
    ----------------------------------------------------------------

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 This patch is just RFC, if it is not proper, we can drop it.

---
 sys-utils/lscpu-cputype.c |  1 +
 sys-utils/lscpu-dmi.c     | 10 ++++++++++
 sys-utils/lscpu.c         |  2 ++
 sys-utils/lscpu.h         |  2 ++
 4 files changed, 15 insertions(+)

diff --git a/sys-utils/lscpu-cputype.c b/sys-utils/lscpu-cputype.c
index d5ca8e1f1..d5f0eb7d6 100644
--- a/sys-utils/lscpu-cputype.c
+++ b/sys-utils/lscpu-cputype.c
@@ -81,6 +81,7 @@ void lscpu_unref_cputype(struct lscpu_cputype *ct)
 		free(ct->model);
 		free(ct->modelname);
 		free(ct->bios_modelname);
+		free(ct->bios_family);
 		free(ct->revision);	/* alternative for model (ppc) */
 		free(ct->stepping);
 		free(ct->bogomips);
diff --git a/sys-utils/lscpu-dmi.c b/sys-utils/lscpu-dmi.c
index d05380891..ef82cf828 100644
--- a/sys-utils/lscpu-dmi.c
+++ b/sys-utils/lscpu-dmi.c
@@ -73,6 +73,11 @@ int parse_dmi_table(uint16_t len, uint16_t num,
 				di->processor_version = dmi_string(&h, data[0x10]);
 				di->current_speed = *((uint16_t *)(&data[0x16]));
 				di->part_num = dmi_string(&h, data[0x22]);
+
+				if (data[0x6] == 0xfe)
+					di->processor_family = *((uint16_t *)(&data[0x28]));
+				else
+					di->processor_family = data[0x6];
 			}
 			di->sockets++;
 			break;
@@ -116,6 +121,11 @@ int dmi_decode_cputype(struct lscpu_cputype *ct)
 			di.current_speed/1000, (di.current_speed % 1000) / 100);
 	ct->bios_modelname = xstrdup(buf);
 
+	/* Get CPU family */
+	memset(buf, 0, sizeof(buf));
+	sprintf(buf, "%d", di.processor_family);
+	ct->bios_family = xstrdup(buf);
+
 	free(data);
 	return 0;
 }
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 5a99a9a5b..827e84a6d 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -863,6 +863,8 @@ print_summary_cputype(struct lscpu_cxt *cxt,
 		sec = add_summary_s(tb, sec, _("Model name:"), ct->modelname);
 	if (ct->bios_modelname)
 		add_summary_s(tb, sec, _("BIOS Model name:"), ct->bios_modelname);
+	if (ct->bios_family)
+		add_summary_s(tb, sec, _("BIOS CPU family:"), ct->bios_family);
 	if (ct->machinetype)
 		add_summary_s(tb, sec, _("Machine type:"), ct->machinetype);
 	if (ct->family)
diff --git a/sys-utils/lscpu.h b/sys-utils/lscpu.h
index 4dc8e0a23..79477b469 100644
--- a/sys-utils/lscpu.h
+++ b/sys-utils/lscpu.h
@@ -65,6 +65,7 @@ struct lscpu_cputype {
 	char	*model;
 	char	*modelname;
 	char	*bios_modelname; /* aarch64 */
+	char	*bios_family; /* aarch64 */
 	char	*revision;	/* alternative for model (ppc) */
 	char	*stepping;
 	char    *bogomips;
@@ -318,6 +319,7 @@ struct dmi_info {
 	int sockets;
 
 	/* Processor Information */
+	uint16_t processor_family;
 	char *processor_manufacturer;
 	char *processor_version;
 	uint16_t current_speed;
-- 
2.30.2

