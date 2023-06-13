Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50323C77B7A
	for <util-linux@archiver.kernel.org>; Tue, 13 Jun 2023 10:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbjFMKOu (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 13 Jun 2023 06:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbjFMKOt (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 13 Jun 2023 06:14:49 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2115.outbound.protection.outlook.com [40.107.13.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EE0186
        for <util-linux@vger.kernel.org>; Tue, 13 Jun 2023 03:14:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIC81u0CDSHGg00IuwzhOpJJ+/H95aXSRYOxY0RucT7g5KGEC3CGedTx43taX+/twJfQ4l4CetsJo8U4h73eoufh6QA0i9sOEysyECeSiAYCzlYKHYOHa7KtleUvT/F35Xk4Y14o1WESyTpIVlxO8rYGbF7ZzNpw+gDS+S+7wuHgWcAJyVrOH0JAdXsIuEXQbz/XSCGw1scytnXLSAaaYk5p+IrCr4RkbRmWnhH7WnRd85MBrmWAU0D184p8W4lzcpcBT+DlZ2VSuFjlq45n6m5BGlbblxwV1AHijzG+eaYQnXygy6LAwuFNr+Po5DDMv2s+gQa1tls+fScslqc70A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=184ZUhCglcS2XEBoV9b7vbpDL2C6oJV4pPMr0nk6+XI=;
 b=Qcbrz3npUfEJntEK/4KdG8PB1HWzoCyvSEwDnjPncXuDbLDFKXTGuAb+lmkm3sjIGjDP19VIzRBJn54JEJ1ws7YrRUNSrPXYwpOrKzgZ+MLtcW+XfjJodybOAk31K9pHTXOxdzWmrlVI3kp25ss/g4n0GsYwPG/80HlltuHrqW9GbNXFQodPCnOmMy8jdQzSJs6l762JyCKoTwtp5qIO/7XJaAA4eHsEVup4EzuYBCNMNvNOQZQA7/CN7kgHjrGnaT7hOdT0pi+Zbz442LMgFQ2C4Nr0zcu8gH8k+f4eI7hjYvUGBijOHBSFhbW9TRVffebMxN9EgxXMcoCQ5oD4Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=184ZUhCglcS2XEBoV9b7vbpDL2C6oJV4pPMr0nk6+XI=;
 b=fXxTIyd+fCnl4ZItrb/dwdE6BrgkqV+JV0gl2YDfITEfoRHnPtZlAZQWWBIRClMsvgaHBcXx8tMzNSw1bXprvDEoasKni/X2S+M8Fff0ayLkQW8cnFZtgJnT6dCj/PfZKNNlOnyzcwiTOsQn69mzMc0Z2C7Q6DETCPXKylE1cT8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by VI1PR10MB3694.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 10:14:38 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d66c:ec:aa54:f318]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d66c:ec:aa54:f318%5]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 10:14:38 +0000
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     util-linux@vger.kernel.org
Cc:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH] hwclock: add support for RTC_VL_READ/RTC_VL_CLR ioctls
Date:   Tue, 13 Jun 2023 12:14:28 +0200
Message-Id: <20230613101428.294827-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0090.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::8)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|VI1PR10MB3694:EE_
X-MS-Office365-Filtering-Correlation-Id: c67e8f14-4a66-4ad9-0956-08db6bf6feb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J3zGAUxl/eLjhaNkpXSXYFMzu1mB9+XOeBEzrL98V+O0WsiwvSBqNqWrTHL8Nz++VBMatVxrM+ID9BmvLL1IB4ehLaTvplRDDsvKHIqgQevpC/SaDoqqsGweG9Of5CMYDOvlH6Nr8nOtUr7kYYyiGOgRUSBOZRath/OqrI+Xc1rbW5PigQ10KNuW3Njpoh9dL+KJcd6/X1JFiWRFjawpDb96oBHf0N8pZpIIlzB0k30uSi8I97hHAxu6Ee9n1Pj4eCVgUgoG+Uhl1DKEz9bb69FHrejnIFhvfpjHXc9CL1NW7n7XVZ8hKceS9Si1mpXrL+dvW8o9NvvQx/2uXCcGaIYpb/lmSbVHDaCC90uBGwMrmL24nWcuqWKhsQzD62G4BR5XaaheqbepYO5TPB28MitJiYLWwDcggIMdDfTvkrmHQfd5++BmBqs9pUwrpYTKMAx2jgONIisGBTTEA2qJT/7yohVsafAzoCCnBtHm1aGnVYYSJhQmW1WSM6uhudEFFEcnDHSYZ0Jw3oFnRYkq6Qj65XAT3NKbLCAjb9GNfE90ZNIGsmqFy2YxOiLRE4YomX6Z0hUfBcqwZWpHiNcZAVzqSW+UgDFsmO+jgiBXF0yXnnAc5GutMCDUR8PXcKxY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39840400004)(346002)(136003)(366004)(451199021)(5660300002)(8976002)(52116002)(8676002)(8936002)(2906002)(66476007)(66946007)(66556008)(44832011)(6666004)(6486002)(4326008)(107886003)(1076003)(26005)(6506007)(6512007)(6916009)(41300700001)(316002)(186003)(478600001)(83380400001)(2616005)(36756003)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sJy2mPOdDaaAKS6MVLR9mG1crRcK8kozGKaIgQcBOjDihZ2UtCjqQbQbx6Ir?=
 =?us-ascii?Q?gmVj+A6iR0yYM0POQdanktp3r7I9BIdNFXJu49efMbgBEWyHjj8CUThzRAz/?=
 =?us-ascii?Q?yFl86GgCOmrPAZXzXUTrZj/yxSIjaRpj3PFPB+hUi8V9nPufXXr7D8HMan/O?=
 =?us-ascii?Q?DlDTv1lpCh9rnu/ZM0YY1/aljeDeXMBvuAmF9uSVqLvsB8pblgwrFlcSrfii?=
 =?us-ascii?Q?Lirtd5EkroRzcY7t/YGDpzeiOE7UX1q1Stjx3ws0nf+rOrNKZkGJgR+yQZqI?=
 =?us-ascii?Q?qyEBtT6ryW3AtPSp0tNLAy1DeKllTpZ7oCtokxKHBRrapElYZSCQ4ra2up0W?=
 =?us-ascii?Q?Ncy9Hkt+l7N41JdbcMzpUuyGS7jxatRiE1FSYszLYJytWS+oEmAet6ExeLFz?=
 =?us-ascii?Q?9iRYQe2qZqLduSq1tbkHzT5vE5RwPb5JNJEfQoSVNltpTiSN92yDvOnQoZ+u?=
 =?us-ascii?Q?G1i9N0Bw3mpUphJQ0dHGIgtDvwQ5xVGp1w/TgK4EX1zxztQXCGKCPS6RVB2L?=
 =?us-ascii?Q?HZli2Qsj7OR8sIvBscmSWjqHbE9m4jez9T+bqCAEpfHKBR79zLU5dzHA6Ggy?=
 =?us-ascii?Q?rKRb1pAmXV2qncZsICN2y7nSNbeImqwjrOu6PQxCmMfYV58wiQTADf7zCVaA?=
 =?us-ascii?Q?aX72Zk2XU8Tbz84W3FxUSd70r0bcKFGqoxiufTcxYTd1Oy3GG8b74FIPa+QU?=
 =?us-ascii?Q?3oLR58XTmVrDqMendDRGL2eSSRuj7B1h5BeNLcKx4gpY3X95KWJ+++7PJeo9?=
 =?us-ascii?Q?Krkv2QvycMHCWd6+6QAdiF76cNEXVaujxHFR+pOdlY6BRMgHJ+BqHUft2OdY?=
 =?us-ascii?Q?T1nAHOIRrd36JzXp579fMNgyTC/+Hl8pKw+FHNBHsC1BWk5ZXpSrGg8Lll3D?=
 =?us-ascii?Q?RKhWjDrSzcesmX++FshT4Sz4zP1GWDRI7hQdmUk031IEkB2Fq2ZKsm0Eg/q2?=
 =?us-ascii?Q?/HAA9JtUHDNUHozw8TBnibQcydGFanB8Eo5M2lhoS9+TIRA8ajli/Fb0J+8g?=
 =?us-ascii?Q?KE8YladGVnYdK5MtBC+KvGU+3riv0H4lvPGzO1d+AJPzlu9VOaNkqKImod1W?=
 =?us-ascii?Q?NrMTGRhTddn3ealEFp02x02BwdEabWOOPdKn/7iFOmC93dMC9ywwCk24/mY3?=
 =?us-ascii?Q?ERQAv8lVERznIqCNbQT/uGDgioWy4c66zabTk364+dxjLq3ZOO6BF3VrvUW3?=
 =?us-ascii?Q?cENoJQkyjVsueYPVKAfAQ/cgnsbWE2oFkMBMaX1flsrKR7nh9NdqVvS3tauJ?=
 =?us-ascii?Q?Mziu4XtdraVSPKnq1PlHJEi6Qde+0sa0sToFxN/z/Rz8aLq3TdRuy5pRV0fP?=
 =?us-ascii?Q?JgmE5B1Yjc1sxnEvp4zXfnAAhlUjK02QO0xyiLci/SOOwpxeIT5LykRWXxbF?=
 =?us-ascii?Q?kLaQ4iBFABY3uv4w46aDUPZCFcC7UyN4rASXSREaX7KmzCLS777HHUNEEHqX?=
 =?us-ascii?Q?/C7q/tZiphmPIZEcCR1olkZ2Qam/bJjeWO2UCKbywJUb9jD9DVOzd/nkwBB3?=
 =?us-ascii?Q?/zSjRk0+2M9llNpHcNiGLCMf2e0UhUSpkqNI1GXvQU5PasCTZrTbIG4eCQab?=
 =?us-ascii?Q?HD1Rit4sig7bZv8BsXeKWCQiwCYzeLx2sGQHNlTd4hKEtS8B1BLNAEz5xpfX?=
 =?us-ascii?Q?cw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c67e8f14-4a66-4ad9-0956-08db6bf6feb5
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 10:14:38.3740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F1VFNiH67+MRCWJdao/P1seuyBHny3UIicNiTjwJfmzhE5ZXBWH2sCoD1LS2GwdbdSfvOHZelsp5aW9H2KQlV5YUW15ii+ry8r1Pm3kf10A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3694
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Implement a way for userspace to query the status of the backup
battery, if supported by the hardware and driver.

The RTC_VL_* bits are a somewhat recent addition (3431ca4837bf, but
really only from b0efe0281234) to the uapi header,
so provide our own definition if the build host's header doesn't.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 sys-utils/hwclock-rtc.c | 86 +++++++++++++++++++++++++++++++++++++++++
 sys-utils/hwclock.c     | 35 +++++++++++++++++
 sys-utils/hwclock.h     |  5 +++
 3 files changed, 126 insertions(+)

diff --git a/sys-utils/hwclock-rtc.c b/sys-utils/hwclock-rtc.c
index 7094cd063..f918272a1 100644
--- a/sys-utils/hwclock-rtc.c
+++ b/sys-utils/hwclock-rtc.c
@@ -518,3 +518,89 @@ done:
 	free(opt);
 	return rc;
 }
+
+#ifndef RTC_VL_DATA_INVALID
+#define RTC_VL_DATA_INVALID     0x1
+#endif
+#ifndef RTC_VL_BACKUP_LOW
+#define RTC_VL_BACKUP_LOW       0x2
+#endif
+#ifndef RTC_VL_BACKUP_EMPTY
+#define RTC_VL_BACKUP_EMPTY     0x4
+#endif
+#ifndef RTC_VL_ACCURACY_LOW
+#define RTC_VL_ACCURACY_LOW     0x8
+#endif
+#ifndef RTC_VL_BACKUP_SWITCH
+#define RTC_VL_BACKUP_SWITCH    0x10
+#endif
+
+int rtc_vl_read(const struct hwclock_control *ctl)
+{
+	unsigned int vl;
+	int rtc_fd;
+	size_t i;
+	static const struct vl_bit {
+		unsigned int bit;
+		const char *desc;
+	} vl_bits[] = {
+		{ RTC_VL_DATA_INVALID,  N_("Voltage too low, RTC data is invalid") },
+		{ RTC_VL_BACKUP_LOW,    N_("Backup voltage is low") },
+		{ RTC_VL_BACKUP_EMPTY,  N_("Backup empty or not present") },
+		{ RTC_VL_ACCURACY_LOW,  N_("Voltage is low, RTC accuracy is reduced") },
+		{ RTC_VL_BACKUP_SWITCH, N_("Backup switchover happened") },
+	};
+
+	rtc_fd = open_rtc(ctl);
+	if (rtc_fd < 0) {
+		warnx(_("cannot open %s"), rtc_dev_name);
+		return 1;
+	}
+
+	if (ioctl(rtc_fd, RTC_VL_READ, &vl) == -1) {
+		warn(_("ioctl(%d, RTC_VL_READ) on %s failed"),
+		     rtc_fd, rtc_dev_name);
+		return 1;
+	}
+
+	if (ctl->verbose) {
+		printf(_("ioctl(%d, RTC_VL_READ) on %s returned 0x%x\n"),
+		       rtc_fd, rtc_dev_name, vl);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(vl_bits); ++i) {
+		const struct vl_bit *vlb = &vl_bits[i];
+
+		if (vl & vlb->bit) {
+			printf("0x%02x - %s\n", vlb->bit, vlb->desc);
+			vl &= ~vlb->bit;
+		}
+	}
+	if (vl)
+		printf("0x%02x - unknown bit(s)\n", vl);
+
+	return 0;
+}
+
+int rtc_vl_clear(const struct hwclock_control *ctl)
+{
+	int rtc_fd;
+
+	rtc_fd = open_rtc(ctl);
+	if (rtc_fd < 0) {
+		warnx(_("cannot open %s"), rtc_dev_name);
+		return 1;
+	}
+
+	if (ioctl(rtc_fd, RTC_VL_CLR) == -1) {
+		warn(_("ioctl(%d, RTC_VL_CLEAR) on %s failed"),
+		     rtc_fd, rtc_dev_name);
+		return 1;
+	}
+
+	if (ctl->verbose)
+		printf(_("ioctl(%d, RTC_VL_CLEAR) on %s succeeded.\n"),
+		       rtc_fd, rtc_dev_name);
+
+	return 0;
+}
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 2a1844309..b043646b3 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1180,6 +1180,20 @@ manipulate_rtc_param(const struct hwclock_control *ctl)
 
 	return 1;
 }
+
+static int
+manipulate_rtc_voltage_low(const struct hwclock_control *ctl)
+{
+	if (ctl->vl_read) {
+		if (rtc_vl_read(ctl))
+			return 1;
+	}
+	if (ctl->vl_clear) {
+		if (rtc_vl_clear(ctl))
+			return 1;
+	}
+	return 0;
+}
 #endif
 
 static void out_version(void)
@@ -1215,6 +1229,8 @@ usage(void)
 #ifdef __linux__
 	puts(_("     --param-get <param>         display the RTC parameter"));
 	puts(_("     --param-set <param>=<value> set the RTC parameter"));
+	puts(_("     --vl-read                   read voltage low information"));
+	puts(_("     --vl-clear                  clear voltage low information"));
 #endif
 	puts(_("     --predict                   predict the drifted RTC time according to --date"));
 	fputs(USAGE_OPTIONS, stdout);
@@ -1286,6 +1302,8 @@ int main(int argc, char **argv)
 		OPT_NOADJFILE,
 		OPT_PARAM_GET,
 		OPT_PARAM_SET,
+		OPT_VL_READ,
+		OPT_VL_CLEAR,
 		OPT_PREDICT,
 		OPT_SET,
 		OPT_SETEPOCH,
@@ -1315,6 +1333,8 @@ int main(int argc, char **argv)
 #ifdef __linux__
 		{ "param-get",    required_argument, NULL, OPT_PARAM_GET  },
 		{ "param-set",    required_argument, NULL, OPT_PARAM_SET  },
+		{ "vl-read",      no_argument,       NULL, OPT_VL_READ    },
+		{ "vl-clear",     no_argument,       NULL, OPT_VL_CLEAR   },
 #endif
 		{ "noadjfile",    no_argument,       NULL, OPT_NOADJFILE  },
 		{ "directisa",    no_argument,       NULL, OPT_DIRECTISA  },
@@ -1439,6 +1459,14 @@ int main(int argc, char **argv)
 			ctl.show = 0;
 			ctl.hwaudit_on = 1;
 			break;
+		case OPT_VL_READ:
+			ctl.vl_read = 1;
+			ctl.show = 0;
+			break;
+		case OPT_VL_CLEAR:
+			ctl.vl_clear = 1;
+			ctl.show = 0;
+			break;
 #endif
 		case OPT_NOADJFILE:
 			ctl.noadjfile = 1;
@@ -1540,6 +1568,13 @@ int main(int argc, char **argv)
 
 		hwclock_exit(&ctl, EXIT_SUCCESS);
 	}
+
+	if (ctl.vl_read || ctl.vl_clear) {
+		if (manipulate_rtc_voltage_low(&ctl))
+			hwclock_exit(&ctl, EXIT_FAILURE);
+
+		hwclock_exit(&ctl, EXIT_SUCCESS);
+	}
 #endif
 
 #if defined(__linux__) && defined(__alpha__)
diff --git a/sys-utils/hwclock.h b/sys-utils/hwclock.h
index b5b72d45d..a690e717b 100644
--- a/sys-utils/hwclock.h
+++ b/sys-utils/hwclock.h
@@ -53,6 +53,8 @@ struct hwclock_control {
 		set:1,
 		update:1,
 		universal:1,	/* will store hw_clock_is_utc() return value */
+		vl_read:1,
+		vl_clear:1,
 		verbose:1;
 };
 
@@ -88,6 +90,9 @@ extern int get_param_rtc(const struct hwclock_control *ctl,
 			const char *name, uint64_t *id, uint64_t *value);
 extern int set_param_rtc(const struct hwclock_control *ctl, const char *name);
 
+extern int rtc_vl_read(const struct hwclock_control *ctl);
+extern int rtc_vl_clear(const struct hwclock_control *ctl);
+
 extern void __attribute__((__noreturn__))
 hwclock_exit(const struct hwclock_control *ctl, int status);
 
-- 
2.37.2

