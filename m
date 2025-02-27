Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B4114D2B7
	for <util-linux@vger.kernel.org>; Thu, 27 Feb 2025 04:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631806; cv=fail; b=UGGqLA4DSeXuCeiYcb1ZcRgX7tSu2wCvZan1RxaHt8hImHkJbOmcMUf6X5ldS05Of+tgxjDxauSqMDpA4inXTbZaMCDMEKswwSNI92w9bqpr+Tt8IsTko4a/urpnjxS7KjaqGF2T0WCyTeb3uxwgKQL6xpqMDXLRtH6Fsw/ud5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631806; c=relaxed/simple;
	bh=GiczRJYdE/rgKnmDZa37xsUS6YuBSE6djUFxA2bADAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XDYLT4biD6x2+C1kEmwEyXKhQ+4Xuj4S8QTftYbxptMsk/BNdiugSNj838Y02Yk6KDMakxErSYYEjEinReV0o0llfHX8EFvKanZEIfHjBj6gTQSfymZeAgoX81x9OScSgE7kwwuC37qF9B5Sbuf3+LAoSUAoonuj8nlA867sp9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IPshtefo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YlKvPJo8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IPshtefo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YlKvPJo8"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R1gC6v010519;
	Thu, 27 Feb 2025 04:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=hVcMwtohWUY3Re7594uTKKH5r8+iZVW3lgLvzTZxq2s=; b=
	IPshtefo7G4TRm7hviaMJ78CdGgx+sXnHL5L1HZFvqUyWNYuCj1MzGXLY6RkgVdi
	DEA/eo8eLeHia2zgB9kyJz1SlVDaZoG4pZsx87k+exSeVvIQWtOjPsuvXNaeGD9N
	hE23bTZe/OKlYfZ+FNhzmCpG3M9lyorPFBIflHCCfp94nryWdj6Sqiog9P/kHPlI
	YlvfDxJcM6OvcHNquuInmr1t6s5rrL16PxZ4jRPG5QAY48Tyop1bdRu0AVbvphnH
	DFPPoAAG6D12Zb5Ay5i7SZXZpqbNNPPodefjMZ495qOd7n/Qmen6st2zIze1LqmF
	1eoU873ZMThYEyRwNiOURA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pse2meg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 04:49:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51R2QSH2010010;
	Thu, 27 Feb 2025 04:49:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51bbqhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 04:49:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYuybQlKwuPyXvHfjADAM8Q+wHWJSxU+sMpSAvCEwnekUWIcNPNKPJBiOxJYy3Syh9Hctle/gSK/KetKfePhVti2QnWb6sdbhqQodyk1O92zvQRlbY1AfGuzfdQPLQdyx1XXmLEfDVXMs2Z84RT5IZ528oUGCzvSFp58iI7s5NPiC3elsEeAp3iUxMWOvFbkITEYBW/FdsXdsRxBB0VWGGztcLqggIoaq7AvsKL+oM69mS94KjEfaaNBupWwp8ICvg+zgNWVHkk5klxTcKQ7vSBo/Y5b8EVXZcCMu+mGFGwqUlS58ViGA19tUuqr7DhcAZYzLMGNsgvyr/gGHOWlzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVcMwtohWUY3Re7594uTKKH5r8+iZVW3lgLvzTZxq2s=;
 b=u+NY5mMsLklbHuCGkmWm93LKCJCFIl37FrSLq9IZ0BooL4L90pgsHU/1/9CA4x8nOG0zcqo7hnhb9XxNsc1oj4eV5eiCcOLOqV9V28hW+D52zeYduixkEn3LNwMpZzYkvHUElCXaSPZvENGZwkp8X3ORQ19d71EqM4ixrWbLs99RAzlOyuJ4rmawT/m6IxwpCeQ1l6vHr7aUAlMrGAEsmLoavT71s45GBoj2Km/+ih3w+sgVoawa0WKGR7Js46A+pG+Iy5+hpacryLvJ8KtV5ahAXLsde55znCrgZOiMBGU/rTTSLVfLuWVTOfiPUxrut68rHTyvqWS7gbgPoszb5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVcMwtohWUY3Re7594uTKKH5r8+iZVW3lgLvzTZxq2s=;
 b=YlKvPJo8EuQeOqNK05PSApZquUdnqCtkjCWe10yKtHFJAdsZq2iB08w75ry0l1yWlscyhSkqsXO/UUa6sWD/kIFfVo1i2/AlBAgxjDPrVmLO2Q4+/WkAY6eH7Oc9yolO+P5c7OJ533XNk7n/OQzSGKsj90KdjIAuQweuG12fQrw=
Received: from DS7PR10MB4944.namprd10.prod.outlook.com (2603:10b6:5:38d::15)
 by CO1PR10MB4689.namprd10.prod.outlook.com (2603:10b6:303:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.22; Thu, 27 Feb
 2025 04:49:48 +0000
Received: from DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5]) by DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5%3]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 04:49:47 +0000
From: Joe Jin <joe.jin@oracle.com>
To: Karel Zak <kzak@redhat.com>, Zhenwei Pi <pizhenwei@bytedance.com>,
        Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org, Joe Jin <joe.jin@oracle.com>
Subject: [PATCH 3/3] lsirq,irqtop: add support for reading data from given file
Date: Wed, 26 Feb 2025 20:49:16 -0800
Message-Id: <20250227044916.89925-4-joe.jin@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250227044916.89925-1-joe.jin@oracle.com>
References: <20250227044916.89925-1-joe.jin@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0039.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::14) To DS7PR10MB4944.namprd10.prod.outlook.com
 (2603:10b6:5:38d::15)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4944:EE_|CO1PR10MB4689:EE_
X-MS-Office365-Filtering-Correlation-Id: f28c08f8-ba3b-4fbf-53be-08dd56ea298d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S4zGN9TJNTWcfCti3N+99a9Abcn4keLXHTFE4dx8l3BMq7apomhH90a2Helz?=
 =?us-ascii?Q?GakAnW8JooRzSwuCtEIhXwH6whpfwtx68gZZJSr7kWql+nA8OKQv/oqwOj2R?=
 =?us-ascii?Q?KP1nGs0MzfYyAviyTT2478MlYTiuJT7CsDo4oZ2uiJfylbR10T5D9o9xpXZC?=
 =?us-ascii?Q?nSUWAY6IMaXzHu0+ZX4bpJcJmucBDxWWrbPchLSKpiSkn/Kn6SwbPYHsRpeY?=
 =?us-ascii?Q?nLK+yuqNDRB3/tve+J+FARBMmO3FOKz0s2bpvVz5lTOooQfB0D9+2gjwfjjg?=
 =?us-ascii?Q?wJxR+n9jcfhTjqGJCrpLNQXd+KlUiS/ZFT0H8Br4vL0nG/HvcxB9Ov/KmUZQ?=
 =?us-ascii?Q?/9eeIltGRxwfgLb+SH6AbTtv3XHIXhtJ72BdEc3H6JAmPoTfhHx/RMGrA5Rn?=
 =?us-ascii?Q?Gqyz3Dy/FxvBqJEuYD9Y9yEv7X+6NALEbv1rz5G0r9+hMPHYBhc2tEptzjqC?=
 =?us-ascii?Q?5ixROCrsJrJzOJYN9ij0W01997W2Y9sPMTSOyTzyZe5AOlyEecn1YB8WasG+?=
 =?us-ascii?Q?5he45G4k6qTnl8SdaTXodFEp+xV1vTUcg1BylJ1GVMR0K1V2Fn2QayyktpE8?=
 =?us-ascii?Q?j0YBlZkvzCTcYwV5w1kfI/pJYM8B22MGUi6kC6M4hSZbOn8GrWlG5C+dcuaz?=
 =?us-ascii?Q?7ahgV72VaPjPdpCTaofFJT2NmpcCzg6ew+E8Cp11N3+4gelrB5p/z1Swbr/W?=
 =?us-ascii?Q?Y107ed0Kgc0nQ3EGgbEA0uk9MK8tQi6tL2N8rziiPBPoXHYmAYRQYrFYiUMN?=
 =?us-ascii?Q?e20tyF6WgxNrHtWkXxxvaSNQz7HqR32wnMdCDTPLuq4l5Xi+8mi/vyz+8Oh/?=
 =?us-ascii?Q?UtTXuObVXvry26wXcCbiEkkeqC5gI2EjUavK1uRgCd473z9SnUS/6jUIRFzb?=
 =?us-ascii?Q?rgg/YBknjTPXtIJnsR2eoWIEFdZVq2oSoVfYmyvq/migsL4j4tA47A+jA0m+?=
 =?us-ascii?Q?eXkwstGM5KMrnDAZPGKoY8L5lC2UrO0lWNTVLatwtivUrhVA6zB8+lGfrY2d?=
 =?us-ascii?Q?0ECmlpUKE4Dk6RO3VAJ+DicwhLl6CInI2hlJODV+SDsZQI5i+ONZY/Ovee59?=
 =?us-ascii?Q?0IjyKdL8Yseqcveg2+reNqWQmvFUFXeQcpZ50y+Q13DSuYL0mNryg5Rg3nMy?=
 =?us-ascii?Q?gm11WtdvGOIK3cQ3qaLfkmjMc5fJrWYKDqxOWNpZViqS596JfOz4Z56DkDOo?=
 =?us-ascii?Q?iZG9qnc7r9zcIAivJWed3Nxx0iBkin14g18mFtHt182xz3RD48DjoSo1hm4O?=
 =?us-ascii?Q?YGdgl4TOXLiyi6rrC/QIn5/nmYgCDWLPVWDTCjGm+SlFY2xoJbjpCBoPuaRN?=
 =?us-ascii?Q?LJhn3a8OQD0WCvDjF2A05NaJjOFZxjgN14XbBccRQMup7zh7+DkWnckYFH/n?=
 =?us-ascii?Q?v+RTFQd6m9zzBVm8qLJN2KTQQN6O?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4944.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+kqq0Ff23ncHS9EfCtgAJZ4BYfNGTWEqFDz9yzmHf4Wx7QdC6Qz9xz7jszFP?=
 =?us-ascii?Q?vca+OhTc/+pfPo8fxej3OKN77fllu+DQMuMNT0IUrDWxT8XpaIhfDpyCjdVD?=
 =?us-ascii?Q?NRQMSdF+sml9NHSqKp/u0NkAdvGVZchP32ghBNyWByeu0ECqfXGCrj1+EJbI?=
 =?us-ascii?Q?4fAonrFHhY1H40I4iEkzDsravwxxSEUfk0b+oMlcPHDe/TyBo1RngDTN4dBo?=
 =?us-ascii?Q?Bh2/X8ErRyagdKpWzxE7ksy1xBvbnZOckr3WnE/1ls8HesY+V1HfZpzuMQdi?=
 =?us-ascii?Q?bpZEI3c50RIAoJaXwJ4+VEDORM9LJG+6/uYsTq9CsvYk7zP07hgFhGEoI7WM?=
 =?us-ascii?Q?95/24srzgqXW81odosfA0uir56YltVrZvmPLOlZk4WTXZ/IB5weeRxEldtcy?=
 =?us-ascii?Q?8TJO85DXwxdCjuzgGsdOH3B+rQCUYZ3xSF/zIO7PUO5EUbIDkydEvADaq48W?=
 =?us-ascii?Q?p0ASWEEzYz+Uk7BXmOXEt9+SUy03XZGHERgAOpsReUW30bnnlgFQOEfO/DT3?=
 =?us-ascii?Q?YIPviTmsHsnylcEMXB3kus6Nj3VjmWTyGChl4Rnp23+TwoOqvjEYzfG1F7aI?=
 =?us-ascii?Q?IXIPmhfQ3kM6m8fTw8vX349ZqLeO+Mw7FpORroAPI6a7lqlIymMR4tVAWEqr?=
 =?us-ascii?Q?V/Zs3vicIeDjGb9jdSLpuhTCHHrV+n2fYb/QvVVNsgF3iHakrvEdWmrS/iAN?=
 =?us-ascii?Q?9DKVda7JIGaMo/YZjIPnEqqKGVBjhlLQADUsFS5vBFPWdxMVvccTYI2KbF/5?=
 =?us-ascii?Q?0eXA1ljy4Rb+LjG8wjTPUM2yVQxHDTY3uPNt7NQCz89GPs6jY5q6gUlXYqN7?=
 =?us-ascii?Q?do6WphvFe6dRB+eshBB5ESHVtJZ8aB2FAUt6P04ExrNwOYpqwj+mdy42oWn2?=
 =?us-ascii?Q?DlccwzsbhfsoAXtZcIQ04TgfD76NYBYeSC7mqrwwrIBoYjKf7rwnDMJSwpFx?=
 =?us-ascii?Q?aTCxoT4dPtxm66vfgsG5a77flcCvxf1saZnkc2aMlt//hJNXJ8Ao3w3nF9XK?=
 =?us-ascii?Q?KVp/ae4vXCGToEa9tjnvTKzClimKT2O4qm2hXl3vOnNsc+UvJqh2uVhH7EPe?=
 =?us-ascii?Q?2qUqNKf//suRTFz2Vdx6x+yVqB8/nz40NplKnt7Pxm9M5J0JJxb0O8OKN3k6?=
 =?us-ascii?Q?zAsannEs1oMXuBFs3I7raprwrPfXLQAOlqXS+Eh8Ur+Tk2aHS47qLstBXeNh?=
 =?us-ascii?Q?+2GR1nQS6zt4Bf2MVw33XDa4s+PzwsXWwd5yfhPJrwyfMVJhy+uGho4athPK?=
 =?us-ascii?Q?7zDV4KpSGzv2lwMwWwPIObtK0oP0JgiN5sJ97itPJR4MsXHP9f/tPss5BRE3?=
 =?us-ascii?Q?k0x4iq06ywSaZsBm61CmC/QI0btnxaOYqoLDeMPySF0ugiOa7I2RKSkrQo2j?=
 =?us-ascii?Q?k4nXELCuRm7ME1xLas9acjSsJo+kINmBxFsq1dnHGbdSpnhnNO8q3bDxO4zS?=
 =?us-ascii?Q?OYhhZQKDjhMqP2sDjQcUU3ajgRxplf9cvIziyi3U3utsZf9GFo3lCjH4nmaP?=
 =?us-ascii?Q?/v3k/THsURZCXxFBrvw01MQ5nJTDDB/itVRFnsFoBwkHYO/R7UEbgan//Z7K?=
 =?us-ascii?Q?+ZV4rQG6GggqYEQhhbiXSdSn0vbQRjW5pQSWJJ/X?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kPOlFfP/rdFaHv3ap5hQg61m79pxpF4Xcq8uxn9b+F5OfmoQ2QpWo3L2CM9B0z7tT3fPnKvTuo/66m0lG9ckLnAsoe4xx+t+SIbw/Xw1gq1ECRAM0CCea1iBJNZ7Z8Q86hrPq+5nlZhoN2+D+QxoLLXXbQ+Q6GXUvy/pSOshzEcJUm9No9VKSmm2voIia1KRi6d+IkjUyY7M5IPVovPeFFbM4XdEFV2r6ClgbWBzmeFshU/7/dED+VOPyqVOdVUrKgywPILHdt4OJrW0KziZ5e33Sm56OelGmvPkAQMCihqxwg0agbkuUesWFPjg16OgCFDV5JR29UucMsCCrVGJBRgd1XdosAhVd4b/8blRN57tD75xJFwYgByW0fhYheg+UfF7mhNvfpHeD7gTEkJCNy5nuCS1gLfPD/pNjfUrkOsGfrxYkAEMyyFLF257rZJIPjJ83txzh6Nbxn0egRWI9lvWMVGdnSzdutCZlFmSEic9XoYCFaWfIExY8BeEUAFxhXthA1TyPE5BFSwaQSxD3lGSSjrEvPG4Blyce9SOQIZ5nUPLTr3yucUjCzAfHBUtdmK+BNYs8QkxJgODIiQQOfAqAw3pHf+qrWLWgsTewcY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f28c08f8-ba3b-4fbf-53be-08dd56ea298d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4944.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 04:49:47.7385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +vkgiDnlzENt1T5ZcEihkxb8larIeSHlPPW8W3WrLie522q0h5z09TtNkcX0wDtWwEuGcSlBQO6eX3REp3s7aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4689
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502270034
X-Proofpoint-GUID: WtXK0RIFH94g6D_YbK7wYp7RJOCI1qTC
X-Proofpoint-ORIG-GUID: WtXK0RIFH94g6D_YbK7wYp7RJOCI1qTC

This is helpful for analyzng data saved from other system.

Signed-off-by: Joe Jin <joe.jin@oracle.com>
Cc: Zhenwei Pi <pizhenwei@bytedance.com>
Cc: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/irqtop  |  4 ++++
 bash-completion/lsirq   |  4 ++++
 sys-utils/irq-common.c  | 19 +++++++++----------
 sys-utils/irq-common.h  |  3 ++-
 sys-utils/irqtop.1.adoc |  3 +++
 sys-utils/irqtop.c      | 28 +++++++++++++++++++++++++---
 sys-utils/lsirq.1.adoc  |  3 +++
 sys-utils/lsirq.c       | 28 ++++++++++++++++++++++++----
 8 files changed, 74 insertions(+), 18 deletions(-)

diff --git a/bash-completion/irqtop b/bash-completion/irqtop
index 47b7b0af6..3bea5fc0e 100644
--- a/bash-completion/irqtop
+++ b/bash-completion/irqtop
@@ -15,6 +15,9 @@ _irqtop_module()
 		'-C'|'--cpu-list')
 			return 0
 			;;
+		'-i'|'--input')
+			COMPREPLY=( $(compgen -W "input file" -- $cur) )
+			;;
 		'-t'|'--threshold')
 			return 0
 			;;
@@ -51,6 +54,7 @@ _irqtop_module()
 		--cpu-stat
 		--cpu-list
 		--delay
+		--input
 		--number
 		--sort
 		--output
diff --git a/bash-completion/lsirq b/bash-completion/lsirq
index 4c3c9f04f..b913eecd0 100644
--- a/bash-completion/lsirq
+++ b/bash-completion/lsirq
@@ -5,6 +5,9 @@ _lsirq_module()
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $prev in
+		'-i'|'--input')
+			COMPREPLY=( $(compgen -W "input file" -- $cur) )
+			;;
 		'-o'|'--output')
 			local prefix realcur OUTPUT
 			realcur="${cur##*,}"
@@ -35,6 +38,7 @@ _lsirq_module()
 	OPTS="	--json
 		--pairs
 		--noheadings
+		--input
 		--output
 		--softirq
 		--sort
diff --git a/sys-utils/irq-common.c b/sys-utils/irq-common.c
index f069d8a63..560dd4b82 100644
--- a/sys-utils/irq-common.c
+++ b/sys-utils/irq-common.c
@@ -233,7 +233,8 @@ static bool cpu_in_list(int cpu, size_t setsize, cpu_set_t *cpuset)
 /*
  * irqinfo - parse the system's interrupts
  */
-static struct irq_stat *get_irqinfo(int softirq, size_t setsize, cpu_set_t *cpuset)
+static struct irq_stat *get_irqinfo(const char *input_file, int softirq,
+				    size_t setsize, cpu_set_t *cpuset)
 {
 	FILE *irqfile;
 	char *line = NULL, *tmp;
@@ -247,18 +248,15 @@ static struct irq_stat *get_irqinfo(int softirq, size_t setsize, cpu_set_t *cpus
 	stat->irq_info = xmalloc(sizeof(*stat->irq_info) * IRQ_INFO_LEN);
 	stat->nr_irq_info = IRQ_INFO_LEN;
 
-	if (softirq)
-		irqfile = fopen(_PATH_PROC_SOFTIRQS, "r");
-	else
-		irqfile = fopen(_PATH_PROC_INTERRUPTS, "r");
+	irqfile = fopen(input_file, "r");
 	if (!irqfile) {
-		warn(_("cannot open %s"), _PATH_PROC_INTERRUPTS);
+		warn(_("cannot open %s"), input_file);
 		goto free_stat;
 	}
 
 	/* read header firstly */
 	if (getline(&line, &len, irqfile) < 0) {
-		warn(_("cannot read %s"), _PATH_PROC_INTERRUPTS);
+		warn(_("cannot read %s"), input_file);
 		goto close_file;
 	}
 
@@ -270,7 +268,7 @@ static struct irq_stat *get_irqinfo(int softirq, size_t setsize, cpu_set_t *cpus
 
 	stat->cpus =  xcalloc(stat->nr_active_cpu, sizeof(struct irq_cpu));
 
-	/* parse each line of _PATH_PROC_INTERRUPTS */
+	/* parse each line of input file */
 	while (getline(&line, &len, irqfile) >= 0) {
 		unsigned long count;
 		size_t index;
@@ -527,7 +525,8 @@ struct libscols_table *get_scols_cpus_table(struct irq_output *out,
 	return NULL;
 }
 
-struct libscols_table *get_scols_table(struct irq_output *out,
+struct libscols_table *get_scols_table(const char *input_file,
+					      struct irq_output *out,
 					      struct irq_stat *prev,
 					      struct irq_stat **xstat,
 					      int softirq,
@@ -542,7 +541,7 @@ struct libscols_table *get_scols_table(struct irq_output *out,
 	size_t i;
 
 	/* the stats */
-	stat = get_irqinfo(softirq, setsize, cpuset);
+	stat = get_irqinfo(input_file, softirq, setsize, cpuset);
 	if (!stat)
 		return NULL;
 
diff --git a/sys-utils/irq-common.h b/sys-utils/irq-common.h
index 02b72d752..b9cf72d2a 100644
--- a/sys-utils/irq-common.h
+++ b/sys-utils/irq-common.h
@@ -73,7 +73,8 @@ void irq_print_columns(FILE *f, int nodelta);
 void set_sort_func_by_name(struct irq_output *out, const char *name);
 void set_sort_func_by_key(struct irq_output *out, const char c);
 
-struct libscols_table *get_scols_table(struct irq_output *out,
+struct libscols_table *get_scols_table(const char *input_file,
+                                              struct irq_output *out,
                                               struct irq_stat *prev,
                                               struct irq_stat **xstat,
                                               int softirq,
diff --git a/sys-utils/irqtop.1.adoc b/sys-utils/irqtop.1.adoc
index 75cfe2e41..715008d07 100644
--- a/sys-utils/irqtop.1.adoc
+++ b/sys-utils/irqtop.1.adoc
@@ -37,6 +37,9 @@ Specify cpus in list format to show.
 *-d*, *--delay* _seconds_::
 Update interrupt output every _seconds_ intervals.
 
+*-i*, *--input* _file_::
+Read data from _file_ (Which was created by other tools, e.g. sosreport).
+
 *-n*, *--number* _number_::
 Specifies the maximum _number_ of iterations before quitting.
 
diff --git a/sys-utils/irqtop.c b/sys-utils/irqtop.c
index ba5680671..4cf1dc79a 100644
--- a/sys-utils/irqtop.c
+++ b/sys-utils/irqtop.c
@@ -87,6 +87,8 @@ struct irqtop_ctl {
 	bool	batch;
 	bool	request_exit,
 		softirq;
+
+	char	*input;
 };
 
 #define irqtop_batch_mode(ctl) ((ctl)->batch == true)
@@ -122,8 +124,9 @@ static int update_screen(struct irqtop_ctl *ctl, struct irq_output *out)
 	char timestr[64], *data, *data0, *p;
 
 	/* make irqs table */
-	table = get_scols_table(out, ctl->prev_stat, &stat, ctl->softirq,
-				ctl->threshold, ctl->setsize, ctl->cpuset);
+	table = get_scols_table(ctl->input, out, ctl->prev_stat, &stat,
+				ctl->softirq, ctl->threshold, ctl->setsize,
+				ctl->cpuset);
 	if (!table) {
 		ctl->request_exit = 1;
 		return 1;
@@ -292,6 +295,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -c, --cpu-stat <mode> show per-cpu stat (auto, enable, disable)\n"), stdout);
 	fputs(_(" -C, --cpu-list <list> specify cpus in list format\n"), stdout);
 	fputs(_(" -d, --delay <secs>   delay updates\n"), stdout);
+	fputs(_(" -i, --input <file>   read data from file\n"), stdout);
 	fputs(_(" -n, --number <number> the maximum number of iterations\n"), stdout);
 	fputs(_(" -o, --output <list>  define which output columns to use\n"), stdout);
 	fputs(_(" -s, --sort <column>  specify sort column\n"), stdout);
@@ -325,6 +329,7 @@ static void parse_args(	struct irqtop_ctl *ctl,
 		{"cpu-stat", required_argument, NULL, 'c'},
 		{"cpu-list", required_argument, NULL, 'C'},
 		{"delay", required_argument, NULL, 'd'},
+		{"input", required_argument, NULL, 'i'},
 		{"number", required_argument, NULL, 'n'},
 		{"sort", required_argument, NULL, 's'},
 		{"output", required_argument, NULL, 'o'},
@@ -336,7 +341,7 @@ static void parse_args(	struct irqtop_ctl *ctl,
 	};
 	int o;
 
-	while ((o = getopt_long(argc, argv, "bc:C:d:n:o:s:St:hV", longopts, NULL)) != -1) {
+	while ((o = getopt_long(argc, argv, "bc:C:d:i:n:o:s:St:hV", longopts, NULL)) != -1) {
 		switch (o) {
 		case 'b':
 			ctl->batch = true;
@@ -376,6 +381,13 @@ static void parse_args(	struct irqtop_ctl *ctl,
 				ctl->timer.it_value = ctl->timer.it_interval;
 			}
 			break;
+		case 'i':
+			ctl->input = strdup(optarg);
+			if (!ctl->input)
+				err_oom();
+			ctl->number = 1;
+			ctl->batch = true;
+			break;
 		case 'n':
 			ctl->number = str2num_or_err(optarg, 10,
 					_("failed to parse number argument"),
@@ -402,6 +414,15 @@ static void parse_args(	struct irqtop_ctl *ctl,
 		}
 	}
 
+	if (ctl->input == NULL) {
+		if (ctl->softirq == 1)
+			ctl->input = strdup(_PATH_PROC_SOFTIRQS);
+		else
+			ctl->input = strdup(_PATH_PROC_INTERRUPTS);
+		if (!ctl->input)
+			err_oom();
+	}
+
 	/* default */
 	if (!out->ncolumns) {
 		out->columns[out->ncolumns++] = COL_IRQ;
@@ -453,6 +474,7 @@ int main(int argc, char **argv)
 
 	free_irqstat(ctl.prev_stat);
 	free(ctl.hostname);
+	free(ctl.input);
 	cpuset_free(ctl.cpuset);
 
 	if (ctl.batch == false) {
diff --git a/sys-utils/lsirq.1.adoc b/sys-utils/lsirq.1.adoc
index 02aea16b3..dd265710c 100644
--- a/sys-utils/lsirq.1.adoc
+++ b/sys-utils/lsirq.1.adoc
@@ -25,6 +25,9 @@ The default output is subject to change. So whenever possible, you should avoid
 *-n*, *--noheadings*::
 Don't print headings.
 
+*-i*, *--input* _file_::
+Read data from _file_ (Which was created by other tools, e.g. sosreport).
+
 *-o*, *--output* _list_::
 Specify which output columns to print. Use *--help* to get a list of all supported columns. The default list of columns may be extended if list is specified in the format _+list_.
 
diff --git a/sys-utils/lsirq.c b/sys-utils/lsirq.c
index e31addaf5..45d542919 100644
--- a/sys-utils/lsirq.c
+++ b/sys-utils/lsirq.c
@@ -29,16 +29,17 @@
 #include "optutils.h"
 #include "strutils.h"
 #include "xalloc.h"
+#include "pathnames.h"
 
 #include "irq-common.h"
 
-static int print_irq_data(struct irq_output *out,
+static int print_irq_data(const char *input_file, struct irq_output *out,
 			  int softirq, unsigned long threshold,
 			  size_t setsize, cpu_set_t *cpuset)
 {
 	struct libscols_table *table;
 
-	table = get_scols_table(out, NULL, NULL, softirq, threshold, setsize, cpuset);
+	table = get_scols_table(input_file, out, NULL, NULL, softirq, threshold, setsize, cpuset);
 	if (!table)
 		return -1;
 
@@ -58,6 +59,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(USAGE_OPTIONS, stdout);
 	fputs(_(" -J, --json           use JSON output format\n"), stdout);
 	fputs(_(" -P, --pairs          use key=\"value\" output format\n"), stdout);
+	fputs(_(" -i, --input          read data from input file\n"), stdout);
 	fputs(_(" -n, --noheadings     don't print headings\n"), stdout);
 	fputs(_(" -o, --output <list>  define which output columns to use\n"), stdout);
 	fputs(_(" -s, --sort <column>  specify sort column\n"), stdout);
@@ -82,6 +84,7 @@ int main(int argc, char **argv)
 	static const struct option longopts[] = {
 		{"sort", required_argument, NULL, 's'},
 		{"noheadings", no_argument, NULL, 'n'},
+		{"input", required_argument, NULL, 'i'},
 		{"output", required_argument, NULL, 'o'},
 		{"threshold", required_argument, NULL, 't'},
 		{"cpu-list", required_argument, NULL, 'C'},
@@ -103,10 +106,11 @@ int main(int argc, char **argv)
 	cpu_set_t *cpuset = NULL;
 	size_t setsize = 0;
 	int softirq = 0;
+	char *input = NULL;
 
 	setlocale(LC_ALL, "");
 
-	while ((c = getopt_long(argc, argv, "no:s:t:C:ShJPV", longopts, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "i:no:s:t:C:ShJPV", longopts, NULL)) != -1) {
 		err_exclusive_options(c, longopts, excl, excl_st);
 
 		switch (c) {
@@ -116,6 +120,11 @@ int main(int argc, char **argv)
 		case 'P':
 			out.pairs = 1;
 			break;
+		case 'i':
+			input = strdup(optarg);
+			if (!input)
+				err_oom();
+			break;
 		case 'n':
 			out.no_headings = 1;
 			break;
@@ -157,6 +166,15 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (input == NULL) {
+		if (softirq == 1)
+			input = strdup(_PATH_PROC_SOFTIRQS);
+		else
+			input = strdup(_PATH_PROC_INTERRUPTS);
+		if (!input)
+			err_oom();
+	}
+
 	/* default */
 	if (!out.ncolumns) {
 		out.columns[out.ncolumns++] = COL_IRQ;
@@ -171,8 +189,10 @@ int main(int argc, char **argv)
 				irq_column_name_to_id) < 0)
 		exit(EXIT_FAILURE);
 
-	if (print_irq_data(&out, softirq, threshold, setsize, cpuset) < 0)
+	if (print_irq_data(input, &out, softirq, threshold, setsize, cpuset) < 0)
 		return EXIT_FAILURE;
 
+	free(input);
+
 	return EXIT_SUCCESS;
 }
-- 
2.43.5

