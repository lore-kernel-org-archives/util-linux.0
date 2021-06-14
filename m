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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52682C48BDF
	for <util-linux@archiver.kernel.org>; Mon, 14 Jun 2021 01:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22CBD61107
	for <util-linux@archiver.kernel.org>; Mon, 14 Jun 2021 01:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhFNBvs (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 13 Jun 2021 21:51:48 -0400
Received: from mail-bn8nam12on2100.outbound.protection.outlook.com ([40.107.237.100]:23841
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232269AbhFNBvr (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 13 Jun 2021 21:51:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ec4Y7nV2B1igyQAe9MKWjShwi/OgXCDDO7YANIIaFTUpbewHvIMEhNrk8mK9rt5+B7W3xXkRCzpRlqOnJcGkFLQ2QAq5eyVaUnFoh5OjLiSh48PbNP1FMlTRM60PWuLa6oecxo9Pkbi+4RlnAX/ija9on0N5qVRmxH8fdIGEpAPNuMnCcolIEA8esMOC9Zo8TLEKDUhzH5zmt5EsDiPK7Fn5QcjAD8HAVriHZPMghpgkNljdwUw2r6/TtMyHjjfg2tdSD/mGDdXVGL8J0ImHGay8TrhsSoWnoZNyiiWjyULUz1cujkx5u6ZQn7FFnRBw689G+a7c3syB/y7E9ESngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eu5qnz/iF5fJt2jYiofZ9KY0xSzvbVQRM0rkz2AJ/Ps=;
 b=UhQxtcoJD2RKoYKpJDVhgw7anuOxOvRhdUOA6gDvHHq7DJ/IZ8sktxUPCxVAmkJtBPfBagfUfMDpfYLHymJpg0gN3OnrLZw4Bd5UyyPtlAjn4dBVixqr388H12wn4wg8ZDXzwRpQbt/MeafL80UcM7t0ogjKwmon/LFfAMQW6foNx4RiUGv73aBnknKKCaILw/vedtdZ8jgC0kUhxikqQdFXSUNLrrEDvF4fSsZKfQ6p3l542WCB+qBEpi2RAbndGfsQWh2TuEe5rCWr83ftI0ViLKvDDATTbtja2xrl8EoJCf1dKqNm6JecvAB7gcDJ8fMUjNMgBPKiepBZyb3YPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eu5qnz/iF5fJt2jYiofZ9KY0xSzvbVQRM0rkz2AJ/Ps=;
 b=tN/dwCT9pmUwbr9rxPpYImkSX2ZEazkH4g5TD6svbADA48MYQODa/qem47FRDKBGgfjgRuj8zpduL6pU7+h3FEfnTLTrZeOfQu3lLNw9JjEyT4R8vMdw5hmIrKqGxkdwmB+CerUrpm325xH5kwbtB25chF8RC6CCIccpiHWySXk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from MWHPR0101MB3165.prod.exchangelabs.com (2603:10b6:301:2f::19) by
 CO1PR01MB6518.prod.exchangelabs.com (2603:10b6:303:d9::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21; Mon, 14 Jun 2021 01:49:41 +0000
Received: from MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::842:9ada:565f:8b98]) by MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::842:9ada:565f:8b98%3]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 01:49:41 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     util-linux@vger.kernel.org
Cc:     patches@amperecomputing.com, zwang@amperecomputing.com,
        mas@amperecomputing.com, ilkka@os.amperecomputing.com,
        Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH] lscpu: get the processor information by DMI
Date:   Mon, 14 Jun 2021 09:48:45 +0000
Message-Id: <20210614094845.13958-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [180.167.209.74]
X-ClientProxiedBy: CY4PR18CA0050.namprd18.prod.outlook.com
 (2603:10b6:903:13f::12) To MWHPR0101MB3165.prod.exchangelabs.com
 (2603:10b6:301:2f::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hsj.amperecomputing.com (180.167.209.74) by CY4PR18CA0050.namprd18.prod.outlook.com (2603:10b6:903:13f::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 01:49:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fda2aabd-127d-4e56-af96-08d92ed6acaa
X-MS-TrafficTypeDiagnostic: CO1PR01MB6518:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR01MB6518F26AE8330B8C874EEE17ED319@CO1PR01MB6518.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CwdEvQigaJ44rLh4riLvifOhf9hTQXIfUyiytSY0jRj/JXWTMzL8TPoL2gKOFL3Qa+3X0wmt/XJvtocsWK/1ljDvxpqyTn8+e6/YwTZcH7lo6XooBUX/1Bj4kLvi2MeRbkxx7Uy+/DxAVK9Rjoh91VbvsBW4alfovGG+WPUUsAQxpnMdeiQZpJQ3Haxor5rUtTSfRHiql5dhgj5rWDkmj5fPYy6tVjQ2ck4tnIKj60jQ6klHJoztJNv+i33WUt+8SbVjdqZhhW8S478mv24dckjZKxHVwVnXXYBVhxpJGVrbxI4w9wN56tSHbpfe2bi2WxgTEZ814dgcxzKiAvCR5b+rzPGTGT6RN0B+DQu6VknKU4gA+QPr1VyYQuhip//yFDll2/SUiSgS+sVm7wIsGOEL4ynXyixB1sZUeMP6aAMfngp8u38ycHa1c6WYjPo0uDZ44R8MtITch/Qz7rejw7Ram5J6b3zWiwU90jrPgNIrffIY4nZybGmsm7GoTI/3hVTq+B1CC007RhCLgvPQBsFqKhyVKMVynRZOu5QkMR10aj4EoGoPxSmMtd8eQruhbPvhSkCP1iJIShEkFgxMt0IcbLQ7CRCqrQZ7BEGjZlN8bwjnYmUd7ohcfYEqRbCwaw5PsqoG0CxVWR6WerSFhzU0EVdrfbgT4DjvItMUO8Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB3165.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39840400004)(366004)(376002)(136003)(1076003)(478600001)(6486002)(26005)(8936002)(5660300002)(83380400001)(38350700002)(6512007)(86362001)(107886003)(186003)(316002)(6666004)(6916009)(2616005)(8676002)(956004)(66946007)(38100700002)(2906002)(52116002)(66476007)(6506007)(66556008)(4326008)(16526019)(15583001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?knKgdjKFRKAZ+hcWGyAAic5IrZ8+yn/Ix3ulDVJy83xWHDdFI0XTnrW7JLVh?=
 =?us-ascii?Q?2Ebnhf8mKEHzQJEXjWG6Ixnaaimdm0fXvqlrJMXd0B74/1vEfX0F/9k5rK3j?=
 =?us-ascii?Q?7XfD8m5NLhUhEfHFU6Rto9x7OiTWrbyghCRlQkoqr8k0SCC8OrXSjwlVfGD9?=
 =?us-ascii?Q?RfB3djuyyMwXuyO1W8+U7Ij4FVrgaCUolg3wf6znxjeekfbQRzLS1SfWX+6h?=
 =?us-ascii?Q?qwI9XKDIEaWsemABXbASWyvYbx3nxZzXE27x6Ygq2ZEuTfMSW2BU5MABL7jw?=
 =?us-ascii?Q?UoQxnqNCC0E+LXiPwAl3ImcZvtCdO5Rmh3qxfyw3z3MWFCphaQ31N2nSisjp?=
 =?us-ascii?Q?wF/Ia+urJVZ7k5Dy5MJcENR6F5GlkKlyiEcr7B00I1O3elN0kzNXduLNElVj?=
 =?us-ascii?Q?q7TV0ESsAOycxAsDjONE18MMv2eL51m4kxvLqb3gbTV0pwDfZwt5WcxDLfVM?=
 =?us-ascii?Q?oxi2NA8bl8VAobhpskUfGzVcxQajxv7EisGg0B98DAuLxeqAZqaB3Wo9eFFW?=
 =?us-ascii?Q?3bLlrbmHujf6rLAqe4uaqtDG53LO5xluHvcpQPTT9GUCFO+CjPtoLep47sVi?=
 =?us-ascii?Q?DB9PXsUpmG8a39uYgbJ4kjFX0KZM+63GYtffIPVoGJEKO9nLDE/qxvcYPM2n?=
 =?us-ascii?Q?L9zf64KRHbnOO2ToEVtPRzejyZnFVqpAvGh+a4yLGj3AMfmF6FdpI2LAfhlZ?=
 =?us-ascii?Q?2tiXPF96O7kG53m+mqLIuiFPrc2sjaOmUzghdYIBp9HKy9+FbfLmO/flPzOw?=
 =?us-ascii?Q?bwia1ni0C6YeyKW9NztSkazizaWa6fbWNq00DGdp3wDxFakr1pCFL3GZQwjb?=
 =?us-ascii?Q?sS+o5/vMbAi2CU8Na2QL9FDNxdGFFhB1NmWtTG21uvzMRQqq4U+arXhoIbIo?=
 =?us-ascii?Q?DvDvLx9NzuTO8QqUVJtz/ubXfO7OTuzgCHtPDcxWbBCPM6SlX/aon0n2CpQB?=
 =?us-ascii?Q?BxwMlcPPuU7LTw/7oIBEcXcURuB61CgovgsnzR+Y65mAYY20NPEZMssG+lOU?=
 =?us-ascii?Q?8Fb7OuipZstyYac7ZWKjNH3O5YM14CuNPGRTB3hFVzdBWniUJeTbCHTQD3K9?=
 =?us-ascii?Q?XqTUDvSjaDmhuRbMl22cUzt4AHBlJDgOv+hw5VppQZq2ndYJFvGjBlDxi/ll?=
 =?us-ascii?Q?p1EKa2SFBRF/9/CtBwpackaBk7m69NW9uy+qxkG6VzQlT5OEKzmvXh98pCqI?=
 =?us-ascii?Q?sLC9/ZzzcKVCt0qoLW5HEK8jQwE2MFUAyq7YeCkqkJg/cJCvbjdtmVOjwxrj?=
 =?us-ascii?Q?ly635B9v3H4svshaWzfYNLwnt6kMY9Cl6KkQeQ4VqEj977Ik77ur9dIptNnl?=
 =?us-ascii?Q?015t+h9yz9GBaDmGVLBUKw/R?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda2aabd-127d-4e56-af96-08d92ed6acaa
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB3165.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 01:49:41.0258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9aAJnHv9+Lqseo0rPZtV7dSupFkXabiOh1UN2eKQM99Fbld+troIAC/kWx7k+ntz4THzeC7/+RK/QYqsRlTW2G1kXTKjlOOCEe/e1caXIO6eMclEHGKV4URFrLUMAfO8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6518
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
  1.) Use the DMI to provide more accurate "Model name" information.
  2.) Add "CPU family" (keep the same output as dmidecode ).

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

After this patch, we can get the lscpu output
in Ampere Altra platform:
   ---------------------------------------------
	Architecture:                    aarch64
	CPU op-mode(s):                  32-bit, 64-bit
	Byte Order:                      Little Endian
	CPU(s):                          160
	On-line CPU(s) list:             0-159
	Vendor ID:                       ARM
	Model name:                      Ampere(R) Altra(R) Processor Q00-00 CPU @ 3.0GHz
	CPU family:                      257
	Model:                           1
	Thread(s) per core:              1
	Core(s) per socket:              80
	Socket(s):                       2
    ........................................
   ---------------------------------------------

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 sys-utils/lscpu-arm.c |  6 +++++-
 sys-utils/lscpu-dmi.c | 49 +++++++++++++++++++++++++++++++++++++++++++
 sys-utils/lscpu.h     |  7 +++++++
 3 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/sys-utils/lscpu-arm.c b/sys-utils/lscpu-arm.c
index 230eb5fdd..0993ea5ad 100644
--- a/sys-utils/lscpu-arm.c
+++ b/sys-utils/lscpu-arm.c
@@ -358,11 +358,15 @@ static int arm_smbios_decode(struct lscpu_cputype *ct)
 
 static void arm_decode(struct lscpu_cxt *cxt, struct lscpu_cputype *ct)
 {
+	/* dmi_decode_cputype may get more accurate information later */
+	arm_ids_decode(ct);
+
 	/* use SMBIOS Type 4 data if available */
 	if (!cxt->noalive && access(_PATH_SYS_DMI_TYPE4, R_OK) == 0)
 		arm_smbios_decode(ct);
+	else if (!cxt->noalive && access(_PATH_SYS_DMI, R_OK) == 0)
+		dmi_decode_cputype(ct);
 
-	arm_ids_decode(ct);
 	arm_rXpY_decode(ct);
 	if (cxt->is_cluster)
 		ct->nr_socket_on_cluster = get_number_of_physical_sockets_from_dmi();
diff --git a/sys-utils/lscpu-dmi.c b/sys-utils/lscpu-dmi.c
index e7ffa88d3..155b21e32 100644
--- a/sys-utils/lscpu-dmi.c
+++ b/sys-utils/lscpu-dmi.c
@@ -67,6 +67,17 @@ int parse_dmi_table(uint16_t len, uint16_t num,
 			di->product = dmi_string(&h, data[0x05]);
 			break;
 		case 4:
+			/* Get the first processor information */
+			if (di->sockets == 0) {
+				di->processor_version = dmi_string(&h, data[0x10]);
+				di->current_speed = *((uint16_t *)(&data[0x16]));
+				di->part_num = dmi_string(&h, data[0x22]);
+
+				if (data[0x6] == 0xfe)
+					di->processor_family = *((uint16_t *)(&data[0x28]));
+				else
+					di->processor_family = data[0x6];
+			}
 			di->sockets++;
 			break;
 		default:
@@ -81,6 +92,44 @@ done:
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
+	/* Get module name */
+	sprintf(buf, "%s %s CPU @ %d.%dGHz", di.processor_version, di.part_num,
+			di.current_speed/1000, (di.current_speed % 1000) / 100);
+	free(ct->modelname);
+	ct->modelname = xstrdup(buf);
+
+	/* Get CPU family */
+	memset(buf, 0, sizeof(buf));
+	sprintf(buf, "%d", di.processor_family);
+	free(ct->family);
+	ct->family = xstrdup(buf);
+
+	free(data);
+	return 0;
+}
+
 size_t get_number_of_physical_sockets_from_dmi(void)
 {
 	static char const sys_fw_dmi_tables[] = _PATH_SYS_DMI;
diff --git a/sys-utils/lscpu.h b/sys-utils/lscpu.h
index 62f532581..9e6362bf4 100644
--- a/sys-utils/lscpu.h
+++ b/sys-utils/lscpu.h
@@ -316,6 +316,12 @@ struct dmi_info {
 	char *product;
 	char *manufacturer;
 	int sockets;
+
+	/* Processor Information */
+	uint16_t processor_family;
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

