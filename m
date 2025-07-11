Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2138.outbound.protection.outlook.com [40.107.93.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2591C3C11
	for <util-linux@vger.kernel.org>; Fri, 11 Jul 2025 21:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752268634; cv=fail; b=gDLKo021YCdf6mXF97bf/KwRdycuQY5rNh6UmBCpTlWLqoDI0L+83JZgVJfVCpS9fy0hTzNMwR0hWZx6D8Ft7SVVNAXMnA1/4zsZckBcxx6IieXMy5dmJ51F66MWP54aOncPbfJ21Un2SB4ThuCZNWnxFW1OnFtmJbS1yaEWf0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752268634; c=relaxed/simple;
	bh=C9kHl7fnGav5JE9UfoOL3Cv70yVAGi8RDVpovnl9zsU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fQ7uoFuOqluEI5xqrohdop9Td1TdNRwJTaLrj/KDY7IkNoVRFVvnugtvvp/AC5e4uL8EBf8h3twlZ+vu1LBJvo4RRu++wYAONOTBxfzXtWLVgFm5Zfx2tvKgvq7cEC0cwMIgIBH5TuT404DFfQcwYBYWYU0RO6Sm59RkD4hIFXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=nw4Vh1fy; arc=fail smtp.client-ip=40.107.93.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="nw4Vh1fy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tkBJOqW+MGtPcO2h8K0M96DFWkYSBgHoysmD8P/HhrkqBErhU84bwdZ/7YOd6OamDsmkgpwOL8z4e1XLGjsAGAV3ssMlFw3JYFNQfCpSiFpgsm/bZEqNpvWkdbZ9hrYdmzPWAPFK1DjOk2+8ofmC31ORpt5RPNrIqfk2ndDbo4xWP3N2ORoVmZLyCqg18jq1urLN8Pv4NwvtVXJHNKono/WpTu+QRaYpIor7mcjS4x1h/2S0MFv/hF4hBj29b07kgUrjTcN0WDyp1iCKCeB1oLt/xbl+eDDBZ9Lcl5D3Gs1CM2fmzQ4Ww5CAoiiorMQKruvlkqraY/k9XrIW588yPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4s9OkbzHQyv1IBxg/JkBPUc1i/oUf880nSfCesgnKg0=;
 b=PTtwMLwU1Dy8OPfRTwx4K++tIGczv9CEKn/DGvzxyd6skaLq5S+Qq0OV1vu/U/nRSsIAHS8r59ZioN/vAuGDxvV/QEJs7ndroy8BepDGzZLqOTfjfV0ViEm28wToKpYKG2YFdv1E+42bk25rVjUffD7BYvah8j5t24vBpEtnHlgERALWSdb7hoQjK5XPVpeWBc84upLHUJ49RrZtZSXQ9QgJw9i3+tAysDWehaWshA2CVgV0UBfqnf9BJGipd0GoTYCDOexfiVTeynZy9XoDFguL7CabLcMSRMZzI9aizzPtnPu2w4tl8oyTRIoPtHZUSHBnUUnkqMGiM2ZilFOAAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4s9OkbzHQyv1IBxg/JkBPUc1i/oUf880nSfCesgnKg0=;
 b=nw4Vh1fydLN+5E0rTX2jePaM9J7ptmV0UiNbG9G/bwMII9dSZNkNp+Yut6pw/zmLpFIDdfacAoa44ttNiO1V0Quw0NtWTkGrS8hv8or9ao//bn5XwKyH2e+ljWaWNgpseDmfDS8Gg2X5sk58q1Bzwmt9t6DPcjuj5lNMXTu3hEg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8501.prod.exchangelabs.com (2603:10b6:806:39e::18) by
 DS1PR01MB8747.prod.exchangelabs.com (2603:10b6:8:211::15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.26; Fri, 11 Jul 2025 21:17:10 +0000
Received: from SA3PR01MB8501.prod.exchangelabs.com
 ([fe80::f7ae:9cc3:b435:c49d]) by SA3PR01MB8501.prod.exchangelabs.com
 ([fe80::f7ae:9cc3:b435:c49d%3]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 21:17:09 +0000
From: Paul Benoit <paul@os.amperecomputing.com>
To: util-linux@vger.kernel.org
Cc: Paul Benoit <paul@os.amperecomputing.com>
Subject: [PATCH 1/2] lscpu-arm: Allow externally sourced model name.
Date: Fri, 11 Jul 2025 14:16:47 -0700
Message-ID: <20250711211648.53361-1-paul@os.amperecomputing.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::27) To SA3PR01MB8501.prod.exchangelabs.com
 (2603:10b6:806:39e::18)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8501:EE_|DS1PR01MB8747:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c7fa16f-1d58-456a-d189-08ddc0c04bad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OYlGhGrfODR9gXM6LWdQqfveeXlbxRp8S4H2/ktWf4jlufeLlsMhbnn45CEB?=
 =?us-ascii?Q?AGl+doNKFJ2fWQ6pDxb/0MIJFQygO/sEfzMcfcBWoW2lYGJR2lZlNRunMPhh?=
 =?us-ascii?Q?DoOJ3ZUt8rC2fQEHdsEvGahA/Av7d2ikLmkt6gx7JbBe9ymmkv3Fdsabgdmf?=
 =?us-ascii?Q?G+Mvp8eQ9efr/90yj0L4kCm+GUxyZuvVKmhQbprjXksjBfUcrv3v/w9VtEto?=
 =?us-ascii?Q?etkOylo98TL4cS36gAXeak+7/g9JNQ7pGLa/yyD7i46V0Js5X9F3jAxchLoP?=
 =?us-ascii?Q?guxAbxUYmg2R+YUAI3tTi2uxbRx3PomFfEeDyHM1CFObnzVcx69t6+8vyQc9?=
 =?us-ascii?Q?J8ftSQi7QwKzSAQP7MgcTRoQYzmNkrfi37tBQe0zcQ5ELXmNDjcuk2yJOEJU?=
 =?us-ascii?Q?C17zKlAvLPkkSgf+O7MS/Y5XfXiWCW9EDymntZniRyPoGNdgoI8vui8mtcTy?=
 =?us-ascii?Q?Nmqhxh1e7l00K/mvUgD90xDwRqYyJUaT7PzuC7TRU39tfATJtKORgZ73xrPm?=
 =?us-ascii?Q?gpR5o295CdKOlKNFGj+RcRUFYvPEXg/xSrrrQykMhAMhT5vUcMZE/sCneQn6?=
 =?us-ascii?Q?gwTrsqg7zXnTJ+/xtQvr1rUFo78GdOvn+isG1lEyhfFJFaWH6Cnpu0FKtjBn?=
 =?us-ascii?Q?dM1lImZNTf6rVKK9eJ5oq/fIr5cZig6mHUIaDpa5Fu6Be6QlM9aEbiOdUmDm?=
 =?us-ascii?Q?kfj13N+shbCHRxA7vXgc1oXkV9PkDSTRDdV6uUGxT8fSeopxGPLQiCea3E4S?=
 =?us-ascii?Q?r/EJ26SNbfL3xWvPyf8D81Wyfh/ALTwOSGxjUG3zWtbvVUV9nOpYgKuigKP7?=
 =?us-ascii?Q?20V42m46JAvfpZjQNMdQCfJNyzPhbr7vs4FdkOmg8jATH1oKDToZ9XO6rKxK?=
 =?us-ascii?Q?Mx99+clSsiMOnTTTUlbEdn0y16ZIiZ0kK3w+2n3rj9VscTJK8V71vh73t0x1?=
 =?us-ascii?Q?DVHPO5SK3F5UWxsUdh/CmUmfg1fMfnNaL0xLyXFGSZjqh58omIiX07DcpBqt?=
 =?us-ascii?Q?5xHhno4q1dqN+ADvOrZZIMmEgXfaYKaneBZgl6UvZwg4b7LM42p5DA7FzE/P?=
 =?us-ascii?Q?msMCgnUFEkTX5Q3/wvyCfvrWBBM+YsLKmO20sj5usjYdPJQOzc215NRdgUpW?=
 =?us-ascii?Q?EsxcEa452iEOBjCQ1QEKk46ngf7nSGIOv5SyXlXhyId7pN0JZq1QGJ1BEDF2?=
 =?us-ascii?Q?6RM6lylio8pf7YNJCqezNznKNCfNGZ6UJR6AgXNh941NM+o3HvKJCSnTQxOT?=
 =?us-ascii?Q?H594/kxn7l0OM7d3WhgsTEEk79ZLrMDP3jEuC48z5mP7IzhNLm86YpXtdz07?=
 =?us-ascii?Q?TbWNs3265FtV1J21MY1SYNp09ZKtUR5M+tVCz8Au99hc6hIdjYUPhMHYuZ+7?=
 =?us-ascii?Q?O1/Cxrq1k6zNv3gm2lVt4/lqn/xPXpwDcX7o394FqMmG1CoCCLYlAFzoRopa?=
 =?us-ascii?Q?7qdEBHfOVA/UkJAo6xGuj5SW86Z/TyQKgOMVoyrEOHeKFUo4tbwinQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8501.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hALIa9DwWOVCG5aOvLjWJjbVfaUce7hbDvQajTjic00bKvL9U3sVHRzu5hfm?=
 =?us-ascii?Q?syzlOvn30rLW5W0tkT1t9k39sjSHflCLUOkgXvJbqUbiD3Es1kBTsj1HgUUE?=
 =?us-ascii?Q?0fci06KI0RFHlvYddcFhLLK7NgtzQM5c7B+W1FtwJXIIz7zQGOsyHe1ytjTr?=
 =?us-ascii?Q?FVVQ/zm9JObTxm2c6XccxZyUuUSRVnUfDD+doVG7xq9w0XcGHXbGDVettnp0?=
 =?us-ascii?Q?BjDUZcr7OQAmDMbJCP7VIFeKBqc983C1z0/rkOkp97W8WnqaT+lwkDX19abc?=
 =?us-ascii?Q?HMlIVDsWqFCQSGk35SPAVGDlnzgy5xQ3lPx030Y9HjE0n3sI9f80RpFn9s9g?=
 =?us-ascii?Q?apYoNdt7fdyPs0B2Yg6sw5NInH1liBb6Sda+fAXxIom6pSN5/L+zbjMqTfMd?=
 =?us-ascii?Q?fOWABgKGwXDOs95q22HytVEXGgKV4HzF5zX0ouAY20NYxY3ZQ4Bb233G6O48?=
 =?us-ascii?Q?bFR7Q1OqLwt1hvHbrfx+z1td4zzexpxtZv8qQNmqCkCIys8XiF8L/QUAsY6C?=
 =?us-ascii?Q?soCkm89wi3nEWKNhM+naM59SvtyM80fRI2INLLdfA/gwf34zkQdrufieY8S1?=
 =?us-ascii?Q?qDqdJ43DrR4XeZkrnxczepgoXIjvhaFM2N2bOIsxQ8FrRI9A8aQTASWsStU5?=
 =?us-ascii?Q?tYD+HYsnS7p129eYRypLxlJIDXCZ6RLf8/wjNC7JDis8d6YufCTgq7iLH1bA?=
 =?us-ascii?Q?N46p7CJvI1CQrVW1N5WPLbUHlpmu91IT921KW9akwp8thCNurAaOuOMllwNB?=
 =?us-ascii?Q?mGPiZg+vpfmifRaKVgA9YdxSsVkWkKXujuzgUkBuew31AygHE8YUh4rd1DnA?=
 =?us-ascii?Q?CllQRnLS4V4pND38oq65vQuNDJWj1gQcC+I/xsAXDq3lX2nYxUdvLE7ljOSr?=
 =?us-ascii?Q?7aPXQQRsbmeaQIPwO6bJM9Mm65Ghv/eGAvCBxgEBNTGgOtPTVwm9cDJVMrL4?=
 =?us-ascii?Q?VcqeF99yHdRq3rSKZdK7EwcsFsfVzxqgNV5gB5SkXZdcb0zEvSCr15Sy+OMX?=
 =?us-ascii?Q?5HhyRHN/4zdO3rRcP4aeFVZwnxggPrIqQ/5hb4j8uCAtGHkk2j//O0jjEkwY?=
 =?us-ascii?Q?AKF0FVUQ+0OuBJW0OmjLAOd0Y3eyvCdk73cHIn9QNPoWe8+LNJf6sNu6LS2y?=
 =?us-ascii?Q?cOq9SnQJoBYeqrUEeQZtyGqnUeCTj9wx4kT4fOMToEunmpqdsfgMU8Z6YJ0k?=
 =?us-ascii?Q?Ncoh6ug4cqLfrYgnhecnMqfXMCzFgVex13GuNQkVgNy0zvvJP0jT7+mtyoK8?=
 =?us-ascii?Q?SvnvGNH9uiPI+226PeRhDYJ/ctoqBLLFz80J2SmwFJEuXA9/M1IcF1vZAqy9?=
 =?us-ascii?Q?2LDGXD6JShtpLKJ/lTYCV8s6HFoyL6aDX3CxTYus64DNOhf97M6PyA2AqsE9?=
 =?us-ascii?Q?mRpSLYpixMl6SkFOPamJ7a1yr8jbNzCimtURxP1b6fWkr/nY2MgsYdFDR3Q+?=
 =?us-ascii?Q?LPK5P+/UjxkKsVS+04HMgGJEwJv28Y7FqOw4I7DzTFt9IH6mljwJerLoR0iI?=
 =?us-ascii?Q?2RT70B9/RCVq+kQ/UEX195GEHcv4gKmlGWDaMHEAKKVG8xNNxWjri3nB9EWI?=
 =?us-ascii?Q?A0wq5reP6lF0AYvkHuFs2tgKj9+Iny1SP5Q1pzIy4zT8an3nkwEeOQOH0hgr?=
 =?us-ascii?Q?nI6VwyNG1+Kln9U75AkuCDM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7fa16f-1d58-456a-d189-08ddc0c04bad
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8501.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 21:17:09.7174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCO4cRLG5jIw3oYpbGsi7O4TufVQ4lyDXPqlM19UPB0sEA2c6v87V3+HjUcdtB2Zj5h/ziYFlBrZ00GQOrZugwjxKMAzEcC6evKF5EOZBoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB8747

When there isn't an entry for the model name in the id_part table(s),
attempt to get the machine name from /sys/bus/soc/devices/soc0/machine
to use as the model name.  This mechanism allows lscpu to use the
model/machine name provided via the ARM SMC support code rather than via
hard-coded lscpu tables.

This code was tested by removing the "Ampere-1a" entry from the
ampere-part table and verifying that lscpu displayed the correct machine
name obtained via the ARM SMC interface to Trusted Firmware.  The
"Ampere-1a" entry will be permanently removed by a separate patch.

Signed-off-by: Paul Benoit <paul@os.amperecomputing.com>
---
 sys-utils/lscpu-arm.c | 35 ++++++++++++++++++++++++++++++++---
 sys-utils/lscpu.h     |  1 +
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/sys-utils/lscpu-arm.c b/sys-utils/lscpu-arm.c
index 8745599d4..a46106bcb 100644
--- a/sys-utils/lscpu-arm.c
+++ b/sys-utils/lscpu-arm.c
@@ -388,7 +388,10 @@ int is_arm(struct lscpu_cxt *cxt)
 static int arm_ids_decode(struct lscpu_cputype *ct)
 {
 	int impl, part, j;
+	unsigned int i;
 	const struct id_part *parts = NULL;
+	FILE *fd;
+	char machinename[BUFSIZ] = "";
 
 	impl = parse_implementer_id(ct);
 	if (impl <= 0)
@@ -406,11 +409,11 @@ static int arm_ids_decode(struct lscpu_cputype *ct)
 
 	/* decode model */
 	if (!parts)
-		goto done;
+		goto try_machinename;
 
 	part = parse_model_id(ct);
 	if (part <= 0)
-		goto done;
+		goto try_machinename;
 
 	for (j = 0; parts[j].id != -1; j++) {
 		if (parts[j].id == part) {
@@ -419,7 +422,33 @@ static int arm_ids_decode(struct lscpu_cputype *ct)
 			break;
 		}
 	}
-done:
+
+try_machinename:
+
+	/*
+	 * If the Model name was not found in the lscpu 'id_part' tables, see
+	 * if there is a Machine name associated with the SOC.  This name may
+	 * have been set via either SOC specific support code, or obtained
+	 * via an ARM SMC CC call into Trusted Firmware.
+	 */
+	if (!ct->modelname) {
+		fd = ul_path_fopen(NULL, "r", _PATH_SOC_MACHINENAME);
+		if (fd) {
+			if (!fgets(machinename, sizeof(machinename), fd))
+				machinename[0] = '\0';
+			fclose(fd);
+
+			/* Replace newline with string terminator */
+			for (i = 0; i < strlen(machinename); i++) {
+				if (machinename[i] == '\n')
+					machinename[i] = '\0';
+			}
+
+			if (strnlen(machinename, sizeof(machinename)))
+				ct->modelname = xstrdup(machinename);
+		}
+	}
+
 	return 0;
 }
 
diff --git a/sys-utils/lscpu.h b/sys-utils/lscpu.h
index bd7b64cc5..581602f70 100644
--- a/sys-utils/lscpu.h
+++ b/sys-utils/lscpu.h
@@ -46,6 +46,7 @@ UL_DEBUG_DECLARE_MASK(lscpu);
 #define _PATH_SYS_NODE		_PATH_SYS_SYSTEM "/node"
 #define _PATH_SYS_DMI		"/sys/firmware/dmi/tables/DMI"
 #define _PATH_ACPI_PPTT		"/sys/firmware/acpi/tables/PPTT"
+#define _PATH_SOC_MACHINENAME	"/sys/bus/soc/devices/soc0/machine"
 
 struct lscpu_cache {
 	int		id;		/* unique identifier */
-- 
2.48.1

