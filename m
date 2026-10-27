Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793114664;
	b=v8NU2G2u/SMBqRI8E32i/Yj046zuuyuSJ9REEpweW8nmOQmy9bf38wWWn2h5PaSdvsKD
	 F09fy06w2P+KWUvBX8Qvh310S2YjUmrmHYawHPPK49bh18W04gcmtqZng/D7AKEI89DDZ
	 NdslfFLlo0YJxKSZYZD3y5Vj7zNvBDJ77HK1O+ZQBrZpHojO4orgqBRKP7Y7uX1tcCOHE
	 UMHWx0CYVo2/h3YBMMIjRT3O9kLEWajOXdmcEUhril+LSan8O+XodVPJuUl9Q33gl8IG1
	 KzFDnX7+G/ribb1cOs+j1aYO8VxpeOzVf7VK0A+1vmPcC1Pvo7YccEJtFCC5egP3coQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114664;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:X-NVConfidentiality:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=PW3nZP9iqAQsJN/Bp7LmGSrc3Ohr193EkP40LZ/zqcM=;
	b=NSRO/2gg63YMzUuzoiMmWFVDMULUfJQhz7LXYaAXoPbMQtqajMMUvLSgQmWDVayn+tuK
	 A1QXkSGo54NYG+CZG4MTYwrxfgdfxMba4gXX0VoeMkx9cNkp61gNMdrkBlkLvJRyolT2x
	 G+gNPs0567UFAw7lmUroFhPrfPXZ4MR4Aii5dccv1oR1zCk9tsBV4fXAmuodq+N00mam9
	 L9lAAaArqcSS2G4zg/TUB+8PIsWn5uUhWG/oRnV2g58qLs/yz35FwteilYWxtJdF10VAf
	 LDTZJwucBFytlheaTD04xpW6sBnq70mhMPKAkzXuggbgd41/KHoZUhI6VO00jrw8ZzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Vzc9T9pt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.62
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011062.outbound.protection.outlook.com [52.101.57.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62694606A31B
	for <util-linux@vger.kernel.org>; Tue, 27 Oct 2026 15:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62694606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Vzc9T9pt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xn9xGvRqk7bNCoiT9aWEtHa0UL3br41fYHGITa1dEcWt9qrqi/2nGMHURB19cWlH96BaOoyQs9FveWZ7+ElKgUnBqEY1e2olndlAgrW9g3sFKdVANRSiIzsjdggASBha1dabGyEjQM/GN26yFZ+x87tC6WDpb7XcRui/AtZmpiS3diRYC3wuFh3RODXz9ZKbHSGYLULa4IiKjMJaqBD7bQ+9ktxC1iUvi5zDXz7WwXdvns+ZSpfsAa188VTYwKBIclWJ+goAkIwq5XuVVEBgQWVlQOcekybJLXILCcqkgMoCpwOoxbI6mA5BPGdTXiuH1RJ15WE28pLS19YHP0vKSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PW3nZP9iqAQsJN/Bp7LmGSrc3Ohr193EkP40LZ/zqcM=;
 b=lhE8kFYUnxwsd+RRNgvd1vTePTg72qp3RrizPYd9Ua/OxP9SSRszB5qfKdOthQCEHyomlFvf3Cn3QCgo85iqaWKdg3V8dbJEOtykFagWdwAl3PWbzMJXWFDDn2G8JTxpkQg4s75QrdgPBcZ7Wo+raehiAPjfcDIG0h83YyDN0NpAQlL9AdDKaj0ZiN7UP1T3bWHPwXcsBQ/K5bc3H249LlpxvczctUeUqIg8JDedzqRYz2zJPddQ9YINxLtY9yt915luHeccKQuTV1FvoUBaMN1qJDP8bt9LmiCSPwo7MafDL/GrGzv+V6igRmdF52wy0e9XaJSvIwhUpVhec/ui5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PW3nZP9iqAQsJN/Bp7LmGSrc3Ohr193EkP40LZ/zqcM=;
 b=Vzc9T9pt2sz86M8kbJjTVu45/Egdnah790W2rmIb3s5d+ijn6KQ8BX6qK+OHUQ26o9KujXLNR2s0av66b03On3f3tCVr2bPwzfHmQDjY2jfrr8zC41SSyBI2oxvGVoccc1xcEDvGamruPhPqJjG/v38RPDq6svHk+OZyFFFkoWS5T9e5mHie09Ta7grz2nwTynFeh/AOXLqUMq0jA+XGORGECjfNs5H7XZA0z0Qf1pUywNc+JA/AOnekfxjbBE3MH+V5ItYpeDFbwkDZIqpFBtrjBJIgwREEcz2VVMUMsG0ssRnYc6Gv24vEat4ET2AgDCK+oBw0tgY77rYG4Tj1Ew==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12)
 by BN5PR12MB9488.namprd12.prod.outlook.com (2603:10b6:408:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 15:24:21 +0000
Received: from DS0PR12MB8442.namprd12.prod.outlook.com
 ([fe80::c4df:b439:571:4591]) by DS0PR12MB8442.namprd12.prod.outlook.com
 ([fe80::c4df:b439:571:4591%4]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 15:24:21 +0000
From: "Matthew R. Ochs" <mochs@nvidia.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] lscpu: Add NVIDIA Rigel arm64 core
Date: Tue, 27 Oct 2026 08:24:20 -0700
Message-ID: <20261027152420.3845399-1-mochs@nvidia.com>
X-Mailer: git-send-email 2.50.1
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0078.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::23) To DS0PR12MB8442.namprd12.prod.outlook.com
 (2603:10b6:8:125::12)
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Post: <mailto:util-linux@vger.kernel.org>
List-Help: <mailto:util-linux+help@vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:util-linux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8442:EE_|BN5PR12MB9488:EE_
X-MS-Office365-Filtering-Correlation-Id: c8cc309a-228d-41f3-ba6f-08df343e603c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|11063799006|56012099006|10067099003|261021121427099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FzAElxog4aXuek7Jfr2MtcHiS1XJTZ2ZAa3MHOxuTHVqN4wZUZPcC2zPF6LIO05bxfe6TU7t/gorda303YKO0FrWLO6GKaqnhOkkh/I/B10MpQuDREfobYIyi0v/hWl2Ud3m8Ptxr46JRGmq6z9oWAOP7QosZTjBWdD28BUKktfM6ttmTv3izDicp7bgaBgpnezfp/vavV5vEfOPXlMkzH0VbAIhJ/+Y8OT0foZC5Ia24L9Fg+9KGBEQ6y8XpeETlYnf4zDGFhgUioWAOFabnzaPB79qOWm6bP13Qq9KQT93hsOwJeeCXbToOEr5yP7z/6PY7AqLa9+i3DpEDYJwcjidBDMerasaP3mKVtwZL+grOfcb50UFfpof/JHPxU/MsEKN1lfxE0PYS0DFoSmhrawqqlxzrribqSoFSUmZz6Cv183nu4jVdbFJssdScqNS4uC94txs6wtQxO/zxu9Gkh0wDc8KpKIUpjcZ/c2voCh45QizpLTHyAM9fNjfh2OeB2DaeTUxDb3/I/GZRy7rl2Y4COxVjsItt7hsFHR68IH0DZVC7xZkfHODeWUCdyd/DjUNmOVZP2fwo+QBCOag/L2o5YB+anr6Nov5jqNaqkZnNb34mVmnCBQC66LszBy8jDy5406BoWi42pC3bTqSCWTLEWU4Nfx3vWzshza14uk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8442.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(11063799006)(56012099006)(10067099003)(261021121427099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lK7e4V3US5qbyuQ6dpzfk1V8WcavFMJC6j1kpv5eqb1QHq/VPomRDdNa0ScD?=
 =?us-ascii?Q?YMoG/PO/WNKPTC6VXSN3N+5+ZC8nk/8Mt8nzFoRI1eOngyXqcW6SNQRmc1mI?=
 =?us-ascii?Q?DJFRRAMS3WYPO5yJr0y/A/R/4UkEJSQl8NzsA8QmC6k7WNaKLSe8rPUCx6OX?=
 =?us-ascii?Q?uaCJWk6Z2CvAmqPSP76Gudk8RxGSxy+4X9athNq8/Jqsi/NQmn7/mOIqR6sy?=
 =?us-ascii?Q?tB3tIA52GBKV/Aq+0xfnQKOYzg77pbVl4yFzDttXu9NiwSNN8bnQxrwH846/?=
 =?us-ascii?Q?fvCJeo4bsOUgKx+Z36/u65AqSdyWuypRJ7PJKWcEfyieCpikj7WK4DooFKG1?=
 =?us-ascii?Q?ckpKtaLO8X9J7OlnTlZFkhZMZlX6+DCE48qTFJMHjrAXQAYzjFFtyRTb7egI?=
 =?us-ascii?Q?fyUPa3qoJkHjR7dZKXfwE7292D85TE5qZZDMG3ObJyT5gZjA6lO6dc/yihfM?=
 =?us-ascii?Q?shb9s9FXuKUD85XTWXL6/s3XgHywwrWrW2v5qIaLjnFLM0UgAkFj8SCSx0Mr?=
 =?us-ascii?Q?8Rim8FLqWhp+ljvtTsykAxQCdc/mSnsxi8w5hhYoV6TYfLZgrpWWhYK9oekf?=
 =?us-ascii?Q?kz3zRv4nuvdP2/HguPcSbG4hN4lOS43e473ZhspChwxns4g5LtiuLOi8luug?=
 =?us-ascii?Q?IUFPTqK+wLdh6/AWUOH2O8r3ELGimqN3Po6hI/imix9MIi1Ppv974ckkvfwV?=
 =?us-ascii?Q?ZeGTYp6qbCZUz5zBdm+hogo4MV7Jrwceyoy4+49xwQDJUmYFyIJ8sQ+GscC0?=
 =?us-ascii?Q?JS1noL8oEnV/x7YIxktVcHwUZWz95Z8VYPz/DBNuj2AAw1C+Awa45wGY3yz6?=
 =?us-ascii?Q?lp2IceZ6pELWc+tN8jpOJ22L+VPU/XnQug7tltA6W6LM6xd/gh5bErksicnz?=
 =?us-ascii?Q?MoPP1dW/LG91O46AxwMy7RoNUfaEFQSwZcP+dGVFeWKNh/eOZpXQYmdMu4Bm?=
 =?us-ascii?Q?fvfTdyp2szhvDDNQytukEYF2N4rrvcWC7/iHcAkJZqoRAOb5XrjvJpbIBmcJ?=
 =?us-ascii?Q?Y6uyomvKuXkNCDNQqkxKeUHSRE8cESb+FEbEEjs9T+L2ApnTvKx8uMhihb7A?=
 =?us-ascii?Q?B41XaSJUOo1aRpA7Rgw6Mpkv4YiCQdQz+BAjWt3/V6uZpgWvPmSAYbC4QVgC?=
 =?us-ascii?Q?/Jzi0c4VhvoSGO0+FWusTBZTR2vGeL89msExMNKH7vFT8S7gQ8wxcf2Jtpx9?=
 =?us-ascii?Q?Tfla8lMpr6ab+Va/wGKmYtnN7cJpLeFNnQ/Lg6zCY/c2X769E4fljILSGK/B?=
 =?us-ascii?Q?LMtqyL9Xee8qTr9qPG+FJpHrY6SrqHUE5jFFFOq10dlJcroaCeLXABlGOKF4?=
 =?us-ascii?Q?ruI4ynQiWlXRBEI9jk2V2gy0Fr/5iIqkXPkwF5lfzk4j8cWvHpOFawSyZtth?=
 =?us-ascii?Q?ZIU/25N6YxUvQB7cAH/3jOjrKFa5arXWO/gljPsbaHFm6uw5bMjIUzbpFUpT?=
 =?us-ascii?Q?a8m1WYo6YnxONcSaFoXShjCVJpgqDCPH6854oWMc1cpfgjFB9Gr368A/cpN9?=
 =?us-ascii?Q?8EjGgNi601mL4KsRT4wdHTnrrKQk+H5uu4GloP/7uY+gCuu3TmwPTZ566YCn?=
 =?us-ascii?Q?bG7wLRIZ2gKvEvhInRd9CbKmUpYnyTA15H/RvfAM/jcYSf8C682z0Ke7rYlk?=
 =?us-ascii?Q?/C7DHvmniW6IN4ebaDAUQy4pz02siev0pDBoYZDOGJfMo39jDolmAiJW2lQp?=
 =?us-ascii?Q?1hFkOOuFGKxGpaV3E03pI09J8ZJIek32anml7X+raXpiQnBMM2mtQaSz8HHP?=
 =?us-ascii?Q?fAbDPTV39g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8cc309a-228d-41f3-ba6f-08df343e603c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8442.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 15:24:21.8116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e4GrKkmp0VfhucCDT5GEQqxHXjAAEK52GxKMD44/lUKF5HaNruOXqVOkI5MPLKyG6BZQtDozuk1dHAQZJYMSfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9488

Add an entry for NVIDIA Rigel arm64 core.

Signed-off-by: Matthew R. Ochs <mochs@nvidia.com>
---
 sys-utils/lscpu-arm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sys-utils/lscpu-arm.c b/sys-utils/lscpu-arm.c
index 84b5d1665ee0..effb2eb63caa 100644
--- a/sys-utils/lscpu-arm.c
+++ b/sys-utils/lscpu-arm.c
@@ -189,6 +189,7 @@ static const struct id_part nvidia_part[] = {
     { 0x003, "Denver-2" },
     { 0x004, "Carmel" },
     { 0x010, "Olympus" },
+    { 0x011, "Rigel" },
     { -1, "unknown" },
 };
 
-- 
2.50.1

