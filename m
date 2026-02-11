Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021127.outbound.protection.outlook.com [52.101.62.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BEF353ED1
	for <util-linux@vger.kernel.org>; Wed, 11 Feb 2026 21:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770845015; cv=fail; b=ApuHXFTnnPBNyP+eqHPigboZ6kiOTbr66vDaqlTtqu0deFX3b92d3Gd1oqRdK1zDvl+41BFHZueeR6ZTmA0rOjRateFbPtZawdRNF60u5eY+nVYhiJssmtjjIiX4tPJVnqG9yeGy0nRovQSL9ULXP4HURZblGXzDox4tcsmplQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770845015; c=relaxed/simple;
	bh=nTELKtdthQlM2ixIWhQraftsVlFY6RIiQEnPKY3rNMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QbsZRCHHJxmjHd9Tcl6BXG8jnjSch8udZPCA8zTgWPJ0JQBDBopZ/FLGrWNiiNxe1+y4nWE7pYJWUM+7nfbCj8joJgH/mC4gN5EXQRdg/hLhsk4qU2ZOZMfur7mDWrQOOViYEAGvWCNDliwxF8ROwA3To//i5cCVNAdw3y1GqpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=IK60opzo; arc=fail smtp.client-ip=52.101.62.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="IK60opzo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkTq4l2xqXTjP2V4FibVbNysH2eq9CyIcXpbUmAcpTtHU7OOmWui4TBhnkpVKGlEyYySppIVGn9jZDUq8qNeE+ToUtkiF9L6xSYL1mGBFUcM+NSIAqciekiEq+OBhV05fwD4OwsWyXOcMUov6WlZ7ia2na+4cmMSOEaRx/L/Eto4UNxemA2krNx55gp6b14zsN+j9ePUHithX6gxVUUjLCKrG5KerhGopI22p9NBPo/HdKe1846T7p6m3r/PFgwz9swi+YWvcsJkaywnAWmtF6K3aIl6xrD3lxXWs6Vq2JpLOapAR/GE812Y67AJVaxVJOIytoRyIsNJr/Sb4bZg+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Du8OG/aYNy3HN337MDwe0Fi6qJjGZOniY1ryLN3J6M=;
 b=IImuKSqDDwQE34A41LTtr5m7UwFlfZ5yUPm69hiJ6m0/YrD/YEhRbVpHwlBvskGjHGb5kcokq39EcjsEXnaHCgZlw6Jx77Hoq1xI7TUVetaDvEXNlmHRnNZGqT5AWSJh1qrW0KgJH67wriacDOpCE+ukTJy10gfZ2pXJcFvRBF9rRN56fsLfCFKgLEVtkX8ZZ8QgbpmNWOrnxQDcd7+IPNMc/rfWEWWDs+taKUxzQXxPL1vY0rupCBifiuy/L15HIZvryme3f1qYxJb3Eq1rgPlFLsrpyPeM2v4mEw2LJ6fNuswoKgp+Y8Pnkq4iV16mim82zC8M9lqe6gqQyx2WKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Du8OG/aYNy3HN337MDwe0Fi6qJjGZOniY1ryLN3J6M=;
 b=IK60opzorUnFP1pVpzSSYjCq+YCrc1zgjNQcK4l2+i11rwtfv/2+bQ834qzIEeQemacjjERkMUFTRaor3XIxxJNjikkFIPsFMM/FLCge7WuDCW28hCNEGJQpNdxwNSMvzWtBdV/fQEYmE0hb4nO0iAXT5ppNE9oG9Oh50yQIh3E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA1PR01MB8179.prod.exchangelabs.com (2603:10b6:806:330::14) by
 SA1PR01MB994237.prod.exchangelabs.com (2603:10b6:806:49e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.10; Wed, 11 Feb 2026 21:23:31 +0000
Received: from SA1PR01MB8179.prod.exchangelabs.com
 ([fe80::f091:2832:ffa:784d]) by SA1PR01MB8179.prod.exchangelabs.com
 ([fe80::f091:2832:ffa:784d%6]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 21:23:31 +0000
From: Paul Benoit <paul@os.amperecomputing.com>
To: util-linux@vger.kernel.org
Cc: Paul Benoit <paul@os.amperecomputing.com>
Subject: [PATCH v2 1/2] lscpu-arm: Include the ARM SMC CC SOC_ID name.
Date: Wed, 11 Feb 2026 13:23:08 -0800
Message-ID: <20260211212309.126190-1-paul@os.amperecomputing.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <a758edc3-2d4f-4e5d-8951-8aad0c3a546a@os.amperecomputing.com>
References: <a758edc3-2d4f-4e5d-8951-8aad0c3a546a@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::14) To SA1PR01MB8179.prod.exchangelabs.com
 (2603:10b6:806:330::14)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR01MB8179:EE_|SA1PR01MB994237:EE_
X-MS-Office365-Filtering-Correlation-Id: a8c21b3e-989d-4cbc-c4f7-08de69b3ce1e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h3QEoHAYpPkQ4cUhLKPtyBrmvVebp+9PVULL2Zguu8CGqIlP0e9sieOHnlZA?=
 =?us-ascii?Q?2+ciHuZAWu+66gckEy4AGr1nKQo4sTwK4zNFvKqZAiuMr/2CIgwnj69kGRvU?=
 =?us-ascii?Q?25BFZRe0ja+OoLZFMONejUf8n6bnoW3AbUbcxfWgrfrzlJIkC/KqTTKKZtLx?=
 =?us-ascii?Q?68HP18Fh8fjPA9Z1R7iU8qVwmTahpHikEWphtRW3y+WFWX692T5xZA95TBeu?=
 =?us-ascii?Q?wP/DW3fVL850SZtEvEmoFwfe3JEfpzKpcqv99fwy6zvqqbyeyLzFYdtehqhf?=
 =?us-ascii?Q?ZNfqD+r2ORQ5iX95+4IKucqHfbXXNQjKqBYCvjebhfHoOFSduzUyk3i3P9X6?=
 =?us-ascii?Q?FdAoTK4/uThDJGGuR9qKZwgYFh9ymnygR1F8Phv5icXx1R01Qh9IC6JHCMqJ?=
 =?us-ascii?Q?Tm92znCPaBLiCEoIag0nXQ6d2GI343Ep2wXM5G/BiiIfvZrzy4VGG8lvNOZH?=
 =?us-ascii?Q?3HHT+rfWpz17hvHGrGlipBr61pIi0Rbmmo4OH5sk9O57oO4P6BWnMLYHTUWY?=
 =?us-ascii?Q?ojMUYLW+1TrjQzxvL5oMLq6plZx45vazfg2/sXgKy8/N7nES8syNeWNngbeW?=
 =?us-ascii?Q?GLTR7n31EOdE+oeWRFinhFK2eJTKtJNr3C3PCrC24u66U/9+lVEKm4SHatlI?=
 =?us-ascii?Q?b0vNE98FU7INa5BbK+BKutqcGeNWAbJ4ISwMykKbxW1TfnVXQy8JEQHImI+k?=
 =?us-ascii?Q?aEF9okx4QjNzARujsEHjOq0TFJHtAoKMNxZ9IcdgmJ/MVJzNpsOHF9bW5w8a?=
 =?us-ascii?Q?iLOLyYU5tXBA8TzOpSlJIKrAHK9mz5EOzk8krD6EjBbZQD1VgqNZcbYvenAi?=
 =?us-ascii?Q?a+hRqSXPtTrKa6DumCi4F0Te+yKkiNx/EQNoW3Abu6wA9Ux3nUv8g1rEDdgH?=
 =?us-ascii?Q?SwliS1FRu5T7INSZsNkKCtEQoHbC1zncwRCNSou2fjL5OySzw0siH7uuM+1N?=
 =?us-ascii?Q?zU4GPUv83vNlhZrO4E8bRtKZ6DizfO5vfyly6x/yuSYEi8a7sEhICHMKPFDn?=
 =?us-ascii?Q?JmrCU6PkPTSxK8lJ85TkRYKeWiDov1Md+3YX/Sh7PLrPG0gyzFUxpfCbiNbU?=
 =?us-ascii?Q?80BJwMELtgNjNh7H0w7FX05gDQu8wq1qQYLb4kEuoN0xXW2LLLyOz7GfKtIF?=
 =?us-ascii?Q?rJmE19SWfH3AvuTfIG8djM0DPqnJ1ju2n0JOd8d8M35SNazPr4QBHY0gPVGs?=
 =?us-ascii?Q?00Y+fFAH9aXtNs922lbn00YnwuFXwz4w5nyc/3EJ/vwM9oYfiK1IMzeRkX6v?=
 =?us-ascii?Q?YUJzaOcAdb/88pY5VNFPCq++pc/lKSEBKtvvvIL2uBBZl4v15ByRj2rOfUOQ?=
 =?us-ascii?Q?5NXCyYQ4dfBZiYgYuTX0+GlV+3TPEk6/bU23Fm/f4fu2hNfOi0n+LErGpRtt?=
 =?us-ascii?Q?pcZGLwErXjvEVFxbFYdAPE4snE+b7BFTWYwE3/XigoOzrvlsSSh49BSJGjj4?=
 =?us-ascii?Q?zYP7qsRhHprjBdB1Va8VoYBT88aQB7pwApSwzH7Mwktwy057wOrUDEIbsWJV?=
 =?us-ascii?Q?eTiUs4jk/iMJKV7TTVbBc57+2nx+jNq67rYt6h0OpNBRQjzmOhFgLt11nC77?=
 =?us-ascii?Q?TvegMzY/UgY3RqyB5lR3Q20VXBYW+QmQOGIdD9ob5xnhatoAorni35gTh5KQ?=
 =?us-ascii?Q?1cF1JM/BBsABQatianzwsHo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR01MB8179.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rp8i3nzsrH2OjUDha1LSvQzrBMGYYumgyNBT41d9Ad9e9NQ4wETmG3VGcLD3?=
 =?us-ascii?Q?9yGFs7IfYwDHvNNB/1FKsCUyqgRPDH+Bc3qcO3zliJWo+/kQhUw3leS/dCEU?=
 =?us-ascii?Q?96GYv55E3Mkh5f8RqDQZJrgszVwq6RWxyimhC9dE76AaWDRbdrjsQgp55vjU?=
 =?us-ascii?Q?tX/nGmoq+qTLADjIEPvH7Mde0278gEqmdG12Acp7DPw5aD1oU/Cg8ycJao2/?=
 =?us-ascii?Q?Oi9b6IgAfHMM38cD9GlltD2BnZb04/afBmr69DyXVha4N8nIuKrJAGl2Fguk?=
 =?us-ascii?Q?jA6tVdoyzZak7VAviUMgiDIOdgAziMvkA8706fPVL1bq2Pk4B5GlNcdgmrBa?=
 =?us-ascii?Q?NYENtjSbXWwPQ0FmZR/g3T36GQaASDdQMUIPBw04NW/fUq90DOeSqw4pDKei?=
 =?us-ascii?Q?n7aT0Iy0U7LICT05CrbgEysF5cXgRKf3/1uD3vcGtgEGTN7Pw4zOn2u4CjKN?=
 =?us-ascii?Q?6MG2dx0R3XeavHpUmJdCr+3H0sX2JTJLHoHHmnvebBnr5wJwKIoGH6QYlKbu?=
 =?us-ascii?Q?6ip3rFF2yI8htlE0VIKNV98yWtg2dZSZF7FUhgGbI4L+AZXsOmgpUi4JnQ2Z?=
 =?us-ascii?Q?Y9eNx5T7mHsb4zqFaUzUTRgHJTjJvkL/fVGjocYKz/T7us6JVsSJAOoUjc4V?=
 =?us-ascii?Q?yxHgp7epc5Ikv0S8IpENmfWbQ/G1Dfpt4E2dD2/oCHEXuo0VDmxjpXd6Tym5?=
 =?us-ascii?Q?TCOzMQNhmnvzo0U6/fL6cRA8TRL2pwjOrN0+ALuhOGzr1ra6h94dzYIt5AEH?=
 =?us-ascii?Q?kdo8m6mIislcT32cOvYO3Iwg5q9xF2YPpEHmQs9jsmpTFPtaPlo+9lHHYrHW?=
 =?us-ascii?Q?9wd3nXfDtriVR071+UPTuvkoCwE8dWoF0MkKdTy1I2e8XC3Dg/LpLMVb6cEA?=
 =?us-ascii?Q?o5dTKf+VlBqR5dITkvMOvKxycZ3sFtwmy+dE0Q40f6SJlStiHMLPIeLsW2lT?=
 =?us-ascii?Q?7zd9zzBNNZxcpJwXGmmUsLo7UszixhVyh3vfNcNqSpYwzM/dJpwMcodg4w1A?=
 =?us-ascii?Q?avA4yxt0EWOkv9jprt1tmsP2kzeb40aniZGcsrhihBmJQaPa1CvTn6dmAuJ4?=
 =?us-ascii?Q?RKebO/aokQEHDBFEKdmLY0fjzvj5zSfNvZwxgpOXSFDgYPbKWKiFaE4UPfOV?=
 =?us-ascii?Q?/VELs2Fl6ozQjsP+T5yvBH6/UMhVQ/7Y7NP3zthF7HbKty1JILCpL0JweFA0?=
 =?us-ascii?Q?+4702/PFmxuI2ObThFeYyVwt8f0fFcKWXPU2hzCjgvmOv914dOj74Fetprxk?=
 =?us-ascii?Q?NfzpvqnxgazzTfa2KjOvZhCC8tnZkm0xGIosKWI7yi3kjfohDqH4tXtD6WNc?=
 =?us-ascii?Q?+Bs3OeVTC91UujRd/QJer50WxsI1+FyGdgQCQYmy7DJMmPlTB/WpNbGJEYTa?=
 =?us-ascii?Q?sg3afceZPE2qVUDi/Rfy9yXTZWFUIooBxowDJz1zvMQKl6QUZtotqvvFMrnL?=
 =?us-ascii?Q?V5hBtkf8RMTQB3NkFBz0+ClVI5ICXEOti9Ked+roU9eMS1Ur9EADpjPn6cI2?=
 =?us-ascii?Q?F7OaMBIn+6we/sTFKPnHqoDwbWI0lfBDdV1+BnZbceNrP2jEV+2e/o9lJMqP?=
 =?us-ascii?Q?g+r+QTzs8tTzGykwpl/D24BvoKioxPmvsJsw3lVQALihYzrqi7bDL7YdI6uI?=
 =?us-ascii?Q?jmUTTbVDYEuL06o4IGx0jjmtAXyIJJOa02pqhmBCxPLYZCiXM8xPSAB9PWnL?=
 =?us-ascii?Q?FbCOVkDBGhs9s6sDhbc6kYHOTDlTtjq7eqGFYzrw0hRs8LZNe2WdrYen3x4H?=
 =?us-ascii?Q?f2u0/fxtxy0R5tQFHQCnPRvF0MhVNqo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c21b3e-989d-4cbc-c4f7-08de69b3ce1e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB8179.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 21:23:31.5695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUiIbreJ9m806XI6dup3lYE8I2VUreMcvLNIBEn0BaPjmtv4ZvOxcbYr2OIyFngWCkGvPm7vq/G3O8EFcv/Oii7M6iLX0Wno9J5uVOd6yZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB994237

On ARM SMC CC 1.6 compliant systems, output the optional SMC CC SOC_ID
name if available.

Vendor ID:                   Ampere
  BIOS Vendor ID:            Ampere (R)
  Model name:                Ampere-1a
    SMCCC SOC_ID name:       AmpereOne (R) A192-32X
    BIOS Model name:         AmpereOne (R) A192-32X CPU @ 3.2GH

Signed-off-by: Paul Benoit <paul@os.amperecomputing.com>
---
 sys-utils/lscpu-arm.c | 38 ++++++++++++++++++++++++++++++++++++++
 sys-utils/lscpu.c     |  2 ++
 sys-utils/lscpu.h     |  4 ++++
 3 files changed, 44 insertions(+)

diff --git a/sys-utils/lscpu-arm.c b/sys-utils/lscpu-arm.c
index ed255a3c7..f388080ad 100644
--- a/sys-utils/lscpu-arm.c
+++ b/sys-utils/lscpu-arm.c
@@ -11,6 +11,7 @@
  * The information here is gathered from
  *  - ARM manuals
  *  - Linux kernel: arch/armX/include/asm/cputype.h
+ *  - Linux kernel: Documentation/ABI/testing/sysfs-devices-soc
  *  - GCC sources: config/arch/arch-cores.def
  *  - Ancient wisdom
  *  - SMBIOS tables (if applicable)
@@ -460,6 +461,41 @@ static int arm_rXpY_decode(struct lscpu_cputype *ct)
 	return 0;
 }
 
+static void on_smc_platform_get_socidname(struct lscpu_cputype *ct)
+{
+	char *machinename = NULL;
+	char *soc_id_jep106_id_str = NULL;
+
+	/* On systems that support SMC CC (Secure Monitor Call Calling
+	 * Convention, get the SOC_ID name.  The Linux kernel obtains it from
+	 * Trusted Firmware via an SMC CC call, and sets
+	 * /sys/bus/soc/devices/soc0/machine _PATH_SOC_ID to this value.  lscpu
+	 * will obtain the value from there.
+	 *
+	 * Documentation/ABI/testing/sysfs-devices-soc, in the Linux kernel
+	 * source tree, gives insight into detecting a SMC CC compliant system
+	 * by checking that start of the _PATH_SOC_ID value for "jep106:".
+	 */
+	ul_path_read_string(NULL, &soc_id_jep106_id_str, _PATH_SOC_ID);
+
+	if (soc_id_jep106_id_str) {
+		if (strncmp(soc_id_jep106_id_str, "jep106:", 7) == 0) {
+			ul_path_read_string(NULL, &machinename,
+					    _PATH_SOC_MACHINENAME);
+			if (machinename) {
+				if (strnlen(machinename, sizeof(machinename))) {
+					free(ct->socid_name);
+					ct->socid_name = xstrdup(machinename);
+				}
+
+				free(machinename);
+			}
+		}
+
+		free(soc_id_jep106_id_str);
+	}
+}
+
 static void arm_decode(struct lscpu_cxt *cxt, struct lscpu_cputype *ct)
 {
 	if (is_live(cxt) && access(_PATH_SYS_DMI, R_OK) == 0)
@@ -468,6 +504,8 @@ static void arm_decode(struct lscpu_cxt *cxt, struct lscpu_cputype *ct)
 	arm_ids_decode(ct);
 	arm_rXpY_decode(ct);
 
+	on_smc_platform_get_socidname(ct);
+
 	if (is_live(cxt) && cxt->is_cluster)
 		ct->nr_socket_on_cluster = get_number_of_physical_sockets_from_dmi();
 }
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 4556aa6df..cd2d00312 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -895,6 +895,8 @@ print_summary_cputype(struct lscpu_cxt *cxt,
 		     struct libscols_line *sec)
 {
 	sec = add_summary_s(tb, sec, _("Model name:"), ct->modelname ? ct->modelname : "-");
+	if (ct->socid_name)
+		add_summary_s(tb, sec, _("SMCCC SOC_ID name:"), ct->socid_name);
 	if (ct->bios_modelname)
 		add_summary_s(tb, sec, _("BIOS Model name:"), ct->bios_modelname);
 	if (ct->bios_family)
diff --git a/sys-utils/lscpu.h b/sys-utils/lscpu.h
index 0fae5d29e..b8011bc55 100644
--- a/sys-utils/lscpu.h
+++ b/sys-utils/lscpu.h
@@ -46,6 +46,8 @@ UL_DEBUG_DECLARE_MASK(lscpu);
 #define _PATH_SYS_NODE		_PATH_SYS_SYSTEM "/node"
 #define _PATH_SYS_DMI		"/sys/firmware/dmi/tables/DMI"
 #define _PATH_ACPI_PPTT		"/sys/firmware/acpi/tables/PPTT"
+#define _PATH_SOC_ID		"/sys/devices/soc0/soc_id"
+#define _PATH_SOC_MACHINENAME	"/sys/devices/soc0/machine"
 
 struct lscpu_cache {
 	int		id;		/* unique identifier */
@@ -119,6 +121,8 @@ struct lscpu_cputype {
 	size_t nr_socket_on_cluster; /* the number of sockets if the is_cluster is 1 */
 
 	char	*isa;	/* loongarch */
+
+	char	*socid_name;	/* aarch64 */
 };
 
 /* dispatching modes */
-- 
2.48.1

