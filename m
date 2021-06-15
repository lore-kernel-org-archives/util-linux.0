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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29625C2B9F4
	for <util-linux@archiver.kernel.org>; Tue, 15 Jun 2021 02:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04E2E613F5
	for <util-linux@archiver.kernel.org>; Tue, 15 Jun 2021 02:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhFOC0k (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 14 Jun 2021 22:26:40 -0400
Received: from mail-dm6nam12on2134.outbound.protection.outlook.com ([40.107.243.134]:27617
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231876AbhFOC0f (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 14 Jun 2021 22:26:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fow6A4i3QdDOrOzggizM//20VdmX+jhR+LRn9X3D2eVAnpvcCleSIs3OzTgIU+I4tIfURNfbNZti943zmb/H/xlJ9r6A9lgc0BzXDYbje64z+gijFE+moxoENsj08vKhpCscGBZBIvP27K5gxmh2InbzSytQPT9aQC18+SpNDiQ/2s0wfoOHgcWCk+u+a7HNK9e+8ZwGhIJot1lfVdIyEJw0UcTgpctV/NP+8vjw4HTXNUBZQgma5U4GS9mUTeUdUVdUsnZsWQuMAJ1maV+JiFTJiRFiw0NcgHiTYMcJKKj5n4w9PydYwHLIhpMRNCYoTzSl7CrcM+66KbU55PVp6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wR8mSXOtpzY0DQRjipe+o9qNyvyBMUuF15f355dUkG0=;
 b=EA89Es7PUBOdrypyuDkjPqt6sY520ZO+UclKBZqJxfERQSFiYO8+CHphCPnC9eSUttVvB6Q5I0xJUtW/eW0nprYksueBIcCN6/QR1SQBdK4pTJYv71+bTZ809EcVMq3MknlcEgzriMA2UYOtrM6b/rIMF9xXy8ON305MZ+hlPs262ujg3V7+F3XTV/61/k4PJEL+0Pn62mtJEOe0mWUpqlfAXDKNYyfF5U7YwbmW+OD09p/gyHYDH4zbTYR75GGVvFrrkekXGNTbdfK4xmhzLm06+IohgMehSjUzRqQXiZssqpkF8IsPdKAANAbB/kQhORXtEYoafAO2aVKA0OQJ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wR8mSXOtpzY0DQRjipe+o9qNyvyBMUuF15f355dUkG0=;
 b=NYUl5sK87X738ubvLOoumwSeR90YO9frumRPLg8mL+908I9vPVCGChFvqyIONevHPwOhRdKMkcEymIC6bWs81a8DZtkFLSwiFdrZbR8Jzg2iF4fx2EHRNZCCYm9kzeL44DBlhIJdsdfufpV3jJStYxV6pf8oAALFpIarUGaMqn8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from MWHPR0101MB3165.prod.exchangelabs.com (2603:10b6:301:2f::19) by
 CO1PR01MB6789.prod.exchangelabs.com (2603:10b6:303:fa::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.25; Tue, 15 Jun 2021 02:07:46 +0000
Received: from MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::842:9ada:565f:8b98]) by MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::842:9ada:565f:8b98%3]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 02:07:46 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     util-linux@vger.kernel.org
Cc:     patches@amperecomputing.com, zwang@amperecomputing.com,
        mas@amperecomputing.com, ilkka@os.amperecomputing.com,
        jeremy.linton@arm.com, jbastian@redhat.com,
        m.mizuma@jp.fujitsu.com,
        Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH 1/2] lscpu: get the processor information by DMI
Date:   Tue, 15 Jun 2021 10:06:38 +0000
Message-Id: <20210615100639.51546-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [180.167.209.74]
X-ClientProxiedBy: CY4PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:903:33::12) To MWHPR0101MB3165.prod.exchangelabs.com
 (2603:10b6:301:2f::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hsj.amperecomputing.com (180.167.209.74) by CY4PR03CA0002.namprd03.prod.outlook.com (2603:10b6:903:33::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Tue, 15 Jun 2021 02:07:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75bc4924-fae4-4062-518c-08d92fa25e56
X-MS-TrafficTypeDiagnostic: CO1PR01MB6789:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR01MB6789CA6D4CC2C24F0E94FC23ED309@CO1PR01MB6789.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:635;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xtXWQZm463KacrJWR87l0acc+8EwosEKL0TQfQ6nT/wmxH06U6UADBU/sA+h4SYxlRgXi0zs0RqI4izaz8x62kH2ZE2ff2ZtpD9E6oZRhNpuS2NdR4sj7N8zB4ns8TXOFD52/tNftwj/88LPpE+n1m0bQXZyr/92r+3x7OnAVdNp8ewhkySoYc7QsRSiKBGhU7h93BrqC3w6McgqfwB7O43UOGrZQENohcJT8EURkuTKYCA2wKuq3EJP2ewlq3xgOh4Vyk5fRdqh1bm3QEiv7Iawf+e7z4X6y9jywD36WKf+2EGc6sxVoy7HLLhB2WlVR20Eg4QLtc3lzwhl4SRLKSXVV3qfTkxDrO+5Qe1n70nOml6yKk2wmRDzXQ0IA5IFynKmYXLW0+FnPnoNUIDa8tu6Pg30iJdmOvjNdQFB+SuFdD7fEK9KQxERbPsINcmoZjVCb0BMzNYBxISG7tofPPmkfxPKz8O5QjLRB69s3ldRvuoiwXvrLYo/N70z93RYyo8RLjTdSLLvgBAi3k0O/Y56ucsTihsE9G4DFX/8SqHq5TAeh1oz6aev1ZEVlrePj6LhV4+XaL+rGuq22DUwDUuaymTQwSADaO4XnwVr8mY+k5YceK460yYFl6CbVWT4k3l+rAUzuBJFcrtPn2bzxyqB44KcOpExI2uwPwlZYdYfvKjOoPGg+UhqPppb1Z/g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB3165.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(136003)(39830400003)(376002)(4326008)(52116002)(316002)(6506007)(2906002)(186003)(16526019)(83380400001)(26005)(66946007)(5660300002)(66556008)(956004)(8936002)(38350700002)(6512007)(6666004)(38100700002)(8676002)(6916009)(107886003)(66476007)(6486002)(1076003)(86362001)(478600001)(2616005)(15583001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lw9zGDtvWf7S2YZgi0fEGl08tmXNC/EatbHrN7xAlJKnf9mGWqEBo/BfxIbm?=
 =?us-ascii?Q?hJAlu+00C+G5Z2mZTy0bueDPVat+jFAEeb73flmpHBgLVu3hxWULD4JTVoST?=
 =?us-ascii?Q?WbFnu7lt05AusiQoiq+AEWI1eBJx69X/lWmrAUZYH7HMz2r++ZgL165MVXGZ?=
 =?us-ascii?Q?x/XDiIpOb3+nJjxlxlFyN76nPBSXEWzoHL8MQ5qZbZJHSJuz7lq9Z2WUOW8b?=
 =?us-ascii?Q?K+5Gy4wB6IEVJ6R7jqq8dqZEr/W5LDs9Wu7XEQC1oBY6bIYNN9cWofDa8FmC?=
 =?us-ascii?Q?s79ZUui2oYzMz1XnwusJ/Pj8Lw5S858WTL1/pCrEA0ohn16OPKcCTg1+f+FN?=
 =?us-ascii?Q?pZnHk7ljuHob+CHhnbmQijnH/EyEAyq1kUlxDGJU0HgLi7yZ6Icfion4Dd+u?=
 =?us-ascii?Q?YSzUl7ihHwDd2xGTImTRsPRTswXYJMh1CybbyBCFamVNhTFBUKvjOfAXxxI3?=
 =?us-ascii?Q?30OMGwm/FhDx45U3YcqNd9Bl23W0TdgUe1AJFg+h/zscS7gwUpoCFVnk6FaM?=
 =?us-ascii?Q?Q1FsF+AbbQgUaexikNyApUEnPcfJWeEbztWu30WmqgGa0fCrgPqOwFfAGsWW?=
 =?us-ascii?Q?WI5y35LeFiyUg5YgAA4JcnN9YoCAAcy/I+OpKJ/bIj+7Mxcdw21X/QBlYbDU?=
 =?us-ascii?Q?JRHfiJ61q77zqIdx3umhHvvwrsmQtIdQtThff0ZugdPvHBLakxPfhKiYzY74?=
 =?us-ascii?Q?jij4FiG/7T3Dr29ZXbqwRtZw/dKlle9zJbdpFE8wWaMGy8WBVk+X3jk9JZC8?=
 =?us-ascii?Q?2VbgoyAGf+ZXqTerqk6thwWFGOGqk5zjZncs4E1N6g40GYrtOgXF0Smzg6gU?=
 =?us-ascii?Q?QUqxApC48uHcQ6xamCGAXW6XO4pW6k1Duij509+4mojjaNfS7yOHuuls7FnC?=
 =?us-ascii?Q?1d2Zpj9mZ6gfOdDo6zgEM3IX/DI20wDFcNadwESVCinJSPnSMPcoGzTPJQ5W?=
 =?us-ascii?Q?m84WCUnAZuO72AEihW6J08LZzbRXJTxRl6YNjY6xEnqm7IbGTUoGaLgu1Amd?=
 =?us-ascii?Q?8cChgs06bciuKKcbNr/A3Ji3xTs2+rrUVCFcS3aVuWEnfx5ViRzoBeOVW2Fb?=
 =?us-ascii?Q?2Wgl5+/MDDTG/KSbqaNpqk4Tcprg6cK7onCCczNaKmEHHuEfmN3bcjwRBP3U?=
 =?us-ascii?Q?od+i5sucp+4MvsFDiASgAL0Bi7MxkX2qWUFmDLU5KBvLWwlp5+hDasoQWFWg?=
 =?us-ascii?Q?XE8qMIrUszinkqDdXctcnrkgmM4Kc3x7oGLhi8U4xt2A+F8IsZH04jssHgsS?=
 =?us-ascii?Q?09RotGlxCWO+JsxgJfLOlRpPaYx+Wcn8fJhFARS+xSJrcPB9aCO7JHuLaKRV?=
 =?us-ascii?Q?Lle886mqkbuouuwZ5jlmKX5r?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75bc4924-fae4-4062-518c-08d92fa25e56
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB3165.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 02:07:46.8495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QzumyYV51XCeLy2HA99Hw4zcI0QJwBpI/WQ/pEhCRY2i/YcB/0vHywTH/wv08yPL/+D7jc8+0nOPrPK+eBU8mMo3b/H1ZVpkUI9UE8GWWTdycG20F3q/Gil2GsjlLAqV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6789
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The patch :367c85c47286 ("lscpu: use SMBIOS tables on ARM for lscpu")
relies on the existence of "/sys/firmware/dmi/entries/4-0/raw",
which may not exist in standard linux kernel.

But "/sys/firmware/dmi/tables/DMI" should exist and can provide the required
processor information.

This patch uses "/sys/firmware/dmi/tables/DMI"
to get the processor information:

Before this patch, in Ampere Altra platform, the lscpu output is:
   ---------------------------------------------
	Architecture:                    aarch64
	CPU op-mode(s):                  32-bit, 64-bit
	Byte Order:                      Little Endian
	CPU(s):                          160
	On-line CPU(s) list:             0-159
	Vendor ID:                       ARM
	Model name:                      Neoverse-N1
	Model:                           1
	Thread(s) per core:              1
	Core(s) per socket:              80
	Socket(s):                       2
    ........................................
   ---------------------------------------------

After this patch, we can use get the lscpu output
in Ampere Altra platform:
   ---------------------------------------------
	Architecture:                    aarch64
	CPU op-mode(s):                  32-bit, 64-bit
	Byte Order:                      Little Endian
	CPU(s):                          160
	On-line CPU(s) list:             0-159
	Vendor ID:                       ARM
	BIOS Vendor ID:                  Ampere(R)
	Model name:                      Neoverse-N1
	BIOS Model name:                 Ampere(R) Altra(R) Processor Q00-00 CPU @ 3.0GHz
	Model:                           1
	Thread(s) per core:              1
	Core(s) per socket:              80
	Socket(s):                       2
    ........................................
   ---------------------------------------------

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 sys-utils/lscpu-arm.c |  2 ++
 sys-utils/lscpu-dmi.c | 39 +++++++++++++++++++++++++++++++++++++++
 sys-utils/lscpu.h     |  7 +++++++
 3 files changed, 48 insertions(+)

diff --git a/sys-utils/lscpu-arm.c b/sys-utils/lscpu-arm.c
index 230eb5fdd..885aadc36 100644
--- a/sys-utils/lscpu-arm.c
+++ b/sys-utils/lscpu-arm.c
@@ -361,6 +361,8 @@ static void arm_decode(struct lscpu_cxt *cxt, struct lscpu_cputype *ct)
 	/* use SMBIOS Type 4 data if available */
 	if (!cxt->noalive && access(_PATH_SYS_DMI_TYPE4, R_OK) == 0)
 		arm_smbios_decode(ct);
+	else if (!cxt->noalive && access(_PATH_SYS_DMI, R_OK) == 0)
+		dmi_decode_cputype(ct);
 
 	arm_ids_decode(ct);
 	arm_rXpY_decode(ct);
diff --git a/sys-utils/lscpu-dmi.c b/sys-utils/lscpu-dmi.c
index e7ffa88d3..d05380891 100644
--- a/sys-utils/lscpu-dmi.c
+++ b/sys-utils/lscpu-dmi.c
@@ -67,6 +67,13 @@ int parse_dmi_table(uint16_t len, uint16_t num,
 			di->product = dmi_string(&h, data[0x05]);
 			break;
 		case 4:
+			/* Get the first processor information */
+			if (di->sockets == 0) {
+				di->processor_manufacturer = dmi_string(&h, data[0x7]);
+				di->processor_version = dmi_string(&h, data[0x10]);
+				di->current_speed = *((uint16_t *)(&data[0x16]));
+				di->part_num = dmi_string(&h, data[0x22]);
+			}
 			di->sockets++;
 			break;
 		default:
@@ -81,6 +88,38 @@ done:
 	return rc;
 }
 
+int dmi_decode_cputype(struct lscpu_cputype *ct)
+{
+	static char const sys_fw_dmi_tables[] = _PATH_SYS_DMI;
+	struct dmi_info di = { };
+	struct stat st;
+	uint8_t *data;
+	int rc = 0;
+	char buf[100] = { };
+
+	if (stat(sys_fw_dmi_tables, &st))
+		return rc;
+
+	data = get_mem_chunk(0, st.st_size, sys_fw_dmi_tables);
+	if (!data)
+		return rc;
+
+	rc = parse_dmi_table(st.st_size, st.st_size/4, data, &di);
+	if (rc < 0) {
+		free(data);
+		return rc;
+	}
+
+	ct->bios_vendor = xstrdup(di.processor_manufacturer);
+
+	sprintf(buf, "%s %s CPU @ %d.%dGHz", di.processor_version, di.part_num,
+			di.current_speed/1000, (di.current_speed % 1000) / 100);
+	ct->bios_modelname = xstrdup(buf);
+
+	free(data);
+	return 0;
+}
+
 size_t get_number_of_physical_sockets_from_dmi(void)
 {
 	static char const sys_fw_dmi_tables[] = _PATH_SYS_DMI;
diff --git a/sys-utils/lscpu.h b/sys-utils/lscpu.h
index 62f532581..4dc8e0a23 100644
--- a/sys-utils/lscpu.h
+++ b/sys-utils/lscpu.h
@@ -316,6 +316,12 @@ struct dmi_info {
 	char *product;
 	char *manufacturer;
 	int sockets;
+
+	/* Processor Information */
+	char *processor_manufacturer;
+	char *processor_version;
+	uint16_t current_speed;
+	char *part_num;
 };
 
 
@@ -323,4 +329,5 @@ void to_dmi_header(struct lscpu_dmi_header *h, uint8_t *data);
 char *dmi_string(const struct lscpu_dmi_header *dm, uint8_t s);
 int parse_dmi_table(uint16_t len, uint16_t num, uint8_t *data, struct dmi_info *di);
 size_t get_number_of_physical_sockets_from_dmi(void);
+int dmi_decode_cputype(struct lscpu_cputype *);
 #endif /* LSCPU_H */
-- 
2.30.2

