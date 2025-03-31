Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDED586347
	for <util-linux@vger.kernel.org>; Mon, 31 Mar 2025 16:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743437578; cv=fail; b=Ltlk1EWfiRq07/uqht7IoM8sBQ58zeN+ay/4EnPRQ6tsHQbu+ZYKJBHB18fVpwLQLSTw2QrbU2Q+fdUXrcf8oZiDgnr4c3n9CY+UQo6YOl/4dg7JtzdA9yAIL0cJ1zns4ac6nx4oJLS8pnuV1xuxzOUxndL0yK/xnid1OPEFOqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743437578; c=relaxed/simple;
	bh=Nq3hVxADtY8VurTN7U+gIPTzBSgbJKNbyMfR2KCE4xY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q8UqAVf9027vuOEHYEjtSuWv5bfckLLS53rnsgd+6Nkk9MfJbS0i0HDjMX1p94e0a/cAw2iqN4gtdUmzbvAand0nbBKrN4OM+vCHjGqg9klXPh7VMNP7SymgLiWUNbFAgYtvr9x7L1VzHFtjfUxnia3MdWuK+ndcOP/UUJ5hBOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IWm17kLG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dtALXfBj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IWm17kLG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dtALXfBj"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52VFuPX9024973;
	Mon, 31 Mar 2025 16:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Nq3hVxADtY8VurTN7U+gIPTzBSgbJKNbyMfR2KCE4xY=; b=
	IWm17kLGxbKxx5lVrhhzlLBjm3PsMOeV6OeEIRm8ddTeTMhLM4wKU12LASgKHWt0
	NzyjpBh6ghWAAFEmnq7f29hN48SXUJxypYrZe7ZDCls5wIuc9U+YPyV9sR3zeYdW
	RLfPF7ZXAGYZHGaDiIZ2HLCB+6aiBkLjnAPXmhJkqcwNjSyf+QW7RBDgD3Kqdcel
	8DeOTp9vpuxr1Y6DS17CJeUoIj84cnR53fkFeDMuZ3VLDGk+mg57UhLbVTALvMCW
	aOv93cCedcZU0wGid6K+/KLe5qh9wGlnXb90k5UXP1aQxOZQxNqPTKMRiZ7oeTdN
	fcjXNnPeCZDtdUa43YzuNQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p79c3kwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 16:12:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52VFoBMB032658;
	Mon, 31 Mar 2025 16:12:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45p7a83je2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 16:12:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KeyYXdjKO1kMKcFWnwySrtZhVvCL6Uylb+TccDipXcPmocOwE1blVRqLeCSlT0IA9QfXjzC+WaviwGhsiasxoM18fSHgXtnCyHLDiwIFStzD+0/9sx6zq5bDg9GJqnAjWRFK2D5jnFvmXUtC5ciHaPmwMhPUPx4qJIHafoeu93GVByiuXjR6ncmeoP/6kqCmPaSmmeUSOdJIHzcStu1lq1OdpsvettcNFywYssDNWDSXfVWD51Bf9o8liIkJsm1JmhVvrQJgypCnXngZsNW6ZBtSFM0tuVDzb4Cubl75ELr7ZKXdZfUhDwh0qtjAdKiuu/ML3Md0fBytRrU3GI47tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nq3hVxADtY8VurTN7U+gIPTzBSgbJKNbyMfR2KCE4xY=;
 b=u5+pVgd14HZzP5wDyFvXSm2IJsETgm4FDdGam/STdqcFWpK1elgqPQjigRQDGGoBTKy7yCZVoQaWOrchMuDqr1iM1uvPQMlVMRkbt2HZY3H9b87RaCXD4ypm/0fV772EZTTmnzH01BtYrCHqYYBcI7IQAcdPUs5nwCLGjGyIA6OIy+1aFYWr91bAOaUzV/k4P9M7QKFHw08Vrp24y/b0cCnMyfsBQ/lk6VpsslassYUBLeuiK2GrazDQcf+cLKdQK52GMqOqH4SGEmmwVKaBStJ9h/uboK/Wd7Eq43vXttG8iaWtegSIQ0Rpggu7T96306uxhGMDDzsMhxErGAtR9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nq3hVxADtY8VurTN7U+gIPTzBSgbJKNbyMfR2KCE4xY=;
 b=dtALXfBjLIuVEn0g8Grh9MDYoBFdAiw5ILxR/UUkpKBOsi0Su4FXZ6UxMDSTNmBtlKHFFfLsmApsRkUNDEUFh/c2gxwc4QD+AWKV+Wa3MCN6a5KQWTpiPjG0/gZffD7IPfuBxiSIZ+11n5/Vl3QmjuIJFFJ1d8n7aUTJynMxb6c=
Received: from DS7PR10MB4944.namprd10.prod.outlook.com (2603:10b6:5:38d::15)
 by CH3PR10MB7576.namprd10.prod.outlook.com (2603:10b6:610:17d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.34; Mon, 31 Mar
 2025 16:12:43 +0000
Received: from DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5]) by DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5%3]) with mapi id 15.20.8583.038; Mon, 31 Mar 2025
 16:12:43 +0000
Message-ID: <e45f45de-62f4-4263-ab71-828780e878bd@oracle.com>
Date: Mon, 31 Mar 2025 09:12:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] irqtop: improve several more option descriptions,
 and align them all
To: Benno Schulenberg <bensberg@telfort.nl>, util-linux@vger.kernel.org
Cc: Zhenwei Pi <pizhenwei@bytedance.com>
References: <20250331094443.9619-1-bensberg@telfort.nl>
 <20250331094443.9619-5-bensberg@telfort.nl>
 <a001f0dc-2b73-42bf-ad7c-1271e9727c36@oracle.com>
 <7c31b1e6-1510-4066-a565-2d8343b99b36@telfort.nl>
Content-Language: en-US
From: Joe Jin <joe.jin@oracle.com>
In-Reply-To: <7c31b1e6-1510-4066-a565-2d8343b99b36@telfort.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0092.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::7) To DS7PR10MB4944.namprd10.prod.outlook.com
 (2603:10b6:5:38d::15)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4944:EE_|CH3PR10MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c71423d-703a-48ae-1270-08dd706edded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkEvK2tpd1NVcTFqbDROSkM3RmsxVk0ra3R3VFdqVWRnY0M5SHFvOGtVMERR?=
 =?utf-8?B?Mjl5TTdzbDdieGpwZ010eTZ3aGNlZmhxbFBEN3E4NURQK2hBc0xCSEhlODR2?=
 =?utf-8?B?VUt3Rk9lOUFnUnlCNVNUeCs0Z0M4MXdOSWxrcmxMRFJZZnQraDRhODlralgx?=
 =?utf-8?B?K1NXZ3FnRlk0NENkWmVBTlUydzhSY3JNZVpRM05WOGcxRHN3S0hsbmd4Tzg2?=
 =?utf-8?B?a0dPcnFVaTdMRUh6akRQeTF0SStFSkNWYVc0bmRWMkF3MFArdGpJY0R5Nmkw?=
 =?utf-8?B?UXYxSHhkcS9HTVZXcVRROExyOWZzci96ZWxoT2NjVmdTVUVKVWVnQnBScCs1?=
 =?utf-8?B?QTZYYkJKU3hnV21mZEo4S2xydWRtdTdVQVBWa0ZwbXlpNGwraCtTWW9sQ0o2?=
 =?utf-8?B?QWtSRVl1VjlUSmpVb0QzbzFKbmw3eFVkUDgvT29yMnAyQ21yNnEzQ1kyR1Fv?=
 =?utf-8?B?TjlBbDNoMGN2N0hudjd6ek12K3FWRElRcXMyYmpybXU3blQ3VHZEMXdPZmlq?=
 =?utf-8?B?UVNOcnlMK0x6OUVRUGtFT1NQRVhNTzNiNmVjeW81VVJWS1dQZTVvMnJ5ZkR0?=
 =?utf-8?B?YjcrNW5RNFdOVE1sSzlCY0NwdXFmU0RBbnlEMndMTjNpM1gvTjRXR2gzQnBl?=
 =?utf-8?B?YkVmaTE2Z0tsWnZWQXh3QTFLNnQxZUVwczdyYXFOb2p4d1A3UGRISGprY0x5?=
 =?utf-8?B?R3dWSGNaVWp1alV0T3JGYzk3Sm9HZTVHUzVDMS80aFFoWkxEMFhBb2NMc3Fm?=
 =?utf-8?B?VytmZXJ0VUh6VzlhOWZLdHdyeCt1SEZ3L3E5SlIrb1N1YVV0ZUhzV254cUxz?=
 =?utf-8?B?b3JURVcxT3NCbGNLaTVhOG5ySUZQczc5MnJ0eE9UOGxhcU5SSFdDQStMZHRX?=
 =?utf-8?B?U0VTemZKMVZDYVVzZHkzMCtiMTFzVitJaGVEdGxpZjdaYU5tQjBvSCsxc1lE?=
 =?utf-8?B?eUVQc3BzOFI4OXNGSVdzYW5JcUJzVFlCVDlmWktoODNLQkMyYi9wL1hjbDJm?=
 =?utf-8?B?VjFWbmhwelNHVnRRdFRYbU54SWt3a3k4UEFOOWhzWnE5ektFNUxBa1BFUm9q?=
 =?utf-8?B?UVIyV2hVQVA4ckRySm8rZWsvVWdIQXpRTkY0cEpjRkRUWmV1WjNReHNjRzZW?=
 =?utf-8?B?Y0l3cUJEK1NhZVR3RWlSbjd4NVAwWWhwc1hzemo3MytLUlZXU0dHUU1JaGVW?=
 =?utf-8?B?YkRsM2U0aFRvNTRDUGZtL3VsUDNYSzZWc0RwaGtWUlhGWVZvOVdxd1I1dHZO?=
 =?utf-8?B?ajAxTE1kbFRTeVE4UjdMSm8vRERVL1hxQ2JUU1IvYnNseVNlV2YzcXRkWmtX?=
 =?utf-8?B?KzFuZ2Vzd1g2NVZWYjVNTzNWSW40cTdmMTVmV0ZEU2RYQnBicUM4MzFqbWd6?=
 =?utf-8?B?NWlWQWcwVmczREZkbjFiV203SWdrR2w2VUZyTzNOb1lRU0lnNW53Ylh1VzdJ?=
 =?utf-8?B?U3V5elZLcmd3UTltQWVkZFZFYVMvNlV3aGRqaUJGSER1ZzhWL0FGYWhmcXVh?=
 =?utf-8?B?Mk16M1k3ajNCTm9yb2pMeG5CZjZMVzVrQi9iUHFLQjFpQkFBVHpKbXRQMHRi?=
 =?utf-8?B?Z3JmK0VmeFRqZGFzbCt1RlBxK2JaSmNrTWZwVG1QUzBMOEtZNHhENDRIVDRO?=
 =?utf-8?B?ZlFrWk1YZ2V1dWRlYUhUOVNPTktmakNFdzVFQjVhTHRpRG1WUjV4anlHaGRi?=
 =?utf-8?B?bjYrbmNCTjJxVEZZc3lYVTdCREFHVldGOFM0Y1M3ekVSYm1JK3pDdVVadUR6?=
 =?utf-8?B?T3EvL29zbVRSMmlvRlorL0VJc3cxWHNnOGxBTDUxQzJxR1B0aGd6MGpBcUt4?=
 =?utf-8?B?bVBZWEltV3dNWGp3eEJoOVdYZHNkbWx6SWNoL0ZPVngwNW5QNjQ0Tit3eUUy?=
 =?utf-8?B?a3ozdU1rd0YyRGJBZzZHNTVqcGhUTzBiYzYxZXpVK1o1NkM5dWx3SUs3c0h1?=
 =?utf-8?Q?JUH99t1r+5I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4944.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clFJVlAxRHYrTzlYT2tkeERMYVVpeHVST2dYeFZUSTdKMktkVk5kVVJHZmhy?=
 =?utf-8?B?V0NiMy82dGdUbUQzMXdzSjVyZ1VoU0x1SlRBVGVGNnViRkorTkxqbm5OMGlO?=
 =?utf-8?B?bU9PelZGZFliNGpMVmdnRlFCeDFWREQrYlpwZFlGU2N6cmRVSHk2U05nQWxD?=
 =?utf-8?B?TjdMamFwNXhqVC9xK09PNmY2UUwyVlZBeXBxb2Z6dS9iUXdzS0JpSHBSUDZj?=
 =?utf-8?B?a0pDWk9ENVMzM2VCL2d5RGpVbGFkc25qY3JWUG1IaGNBbktIcFJ5a0FTb2RZ?=
 =?utf-8?B?MlE4d0dsZUREWC9RTjZkQ2tDRE1TbmtKTy9vK25BVHNaZkNPSzAybmFOd01U?=
 =?utf-8?B?Q3FRTUFCRjlwRjFwUXhjT29jSmtsNGd1enJkWGo3KzYyMlFpbmxWenNrSlF2?=
 =?utf-8?B?b1kyeWltdzEyQnAyQWJFSzdzTHRMdGVvMVZHZ2NOMHNHbm00T2FDcFZaclFI?=
 =?utf-8?B?aDQ2VDM3VERpdm5WcGhXTVFLaUFlRk9VMHJEbDM3azhKS0pIanMzRFVERjZk?=
 =?utf-8?B?ZURET0VOaUFPZDZpRWgxSENEMmtKcTIrUGFnb0VJb01jN0Y4Qzlyd0xHK01m?=
 =?utf-8?B?VjNqRGFCekVKSVpnYTY2RThDV1Vlcm1HOWJNUzlsN1JhMi9wRmRPVDBGNi9r?=
 =?utf-8?B?Mk4xNnhCODM3QzJkeEJtV20wdytTbFBLT0E0V0JBYy9CL2lIeDFjdmNxRExk?=
 =?utf-8?B?WC9QVnhYWU1Ec1BxUW1Wc2c0dUUxeUJrRVVBY1JUT29YZ214NU1GeFVldmRU?=
 =?utf-8?B?LzdIMW9kbVJiMTk4VEV1V015WmlQOU9zZzhhVnFsOGsyK3VzMnJqN29XdTZE?=
 =?utf-8?B?TnNvdyszaWUwRkdnTGEwK3BtVmVmSThUZGF5Rlc0SmhVaGlCelo5QjBoL29M?=
 =?utf-8?B?VTFGQ2hXS1U5MUNPbHN4TFNvZi90NHJ1bllxbllVaGI4ckhGY1Jqc2tLY0oy?=
 =?utf-8?B?TVk3RkdMQ2NQYi9hb0FSclNuaUdENHRvZWRGZU1jQitLT1hvVEdkU3hYM3Nk?=
 =?utf-8?B?RTdSRjB4MGFqaTNiYVdkakR3dlo5aE9KMmNFdWczcFc3RlF3M244WjlHcTlE?=
 =?utf-8?B?SCtEakUyV2hnQnhlSzFTT2hZUjZaTUN6R0NyRzhIOXVFbS9nV1RmY0gwOTAv?=
 =?utf-8?B?ZFplbGtvSjMxOUJ1R1UrUmg0ZllRdGd6Q1BVVXdvL2cvN0J3SE11aGFSYjR1?=
 =?utf-8?B?UHMycVFYUWFJUGJVRVpGbTd4Y09idEZHYkRTRG5GZlluSlVNQXY0VzYzTEhp?=
 =?utf-8?B?eUtQSVBZdnlBc0pMNWJVV0ZLRmY2N05NM3pFdWwxeW0yYjFFYkZveWZrendL?=
 =?utf-8?B?bXhlZEVsSEZVbTZ5SmlmaU5Db1gzUDNSY0FsM3JGVWc4VzNuOVM1MW14eUtO?=
 =?utf-8?B?Ym9wcmQ3clo5bit2bWRvMHNRNDBBTHF4MzF0MC81U3RlbytlMk9GRDVBd2dT?=
 =?utf-8?B?alk1bzEvRjUwTk80UUZ0UlRUR1lyM0Vkbjc4eGE2QWtleHpJMHJzUWE0YVFM?=
 =?utf-8?B?eitEdVVSYU9JUnNJZ25CTXJJQkcvNGplM240SU5GcG9zWUdtTjNnSWJMeDdr?=
 =?utf-8?B?R2wwcExhL0h3czNWU2RBYkJaazh4RkNvck1YNHhlOXAydFdOdUl3RWU2NnFQ?=
 =?utf-8?B?THJleWRoOXFxbUJ6TzhjRFpHNDFlZEtrSUphaDIwSzFmdkcxRzRLS09oREhl?=
 =?utf-8?B?YWtEdEw1T0lKK0YrRGZsQm12YS8zb3gwdHRXbDRDeTB6M3NKYnBzcDR3Nmtt?=
 =?utf-8?B?WVZBL2ZCbG9ERVAwNEpRNFA1Rm9VMS9HZHhQTzBZeGh6QWpZOTlVczhYcUhl?=
 =?utf-8?B?THdqSE14ei9TamxuZzBIb2tJOEFOYVZTcnlLMXUwNW95VVJEdWl6aDQ0WjRU?=
 =?utf-8?B?Q1pRWTFTYUZsbmx6MWx1UWtyMUo0dnVLWlhnMVpNb1JaeDA5RDhCeDdLU0FB?=
 =?utf-8?B?WWVXcnV1YjBDcFdUbmRjcVpoTFp6UzN4cXJ6S0JXTCtDdVlEbERKWld0OXVw?=
 =?utf-8?B?cmlEV0kvSkZkR0o1OXhnWlpXdjliZEJXS3dKNjRMLzMxNHpsMk96RHVSalpx?=
 =?utf-8?B?SzdteVErYUtwdjQ1MytCN2c5ODY0bWs3L2JiQ1lxNDVCV29scjltZnR3cXEx?=
 =?utf-8?Q?zvx/cqVbd0OlWI+cRIeK3DcMU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Gn4Wbxr0+ZUBx+taUq0AH/xsy6USTTQ3mYlL3UTu97oz7pPHHUd+sZ7BAZS8+nBS7VhZsy+tKE3qGY+QXEk2ysJ63YhalhauiywHcPamk8vYWGQ1vpGqzneh3j1dSOLAiGqB/ICtgOSqcIPGKniX2ve+7nsoZcrPXBzCC77XKG3AdzjlEyaCFMO0eYKJYsWIGMSHUYzakARelLaPx8m3Q2AcnNN+vPXhejxa2DBIXafCgzUfSij295Ye/GTCdSgsnfZSCuHURJGzyEMfqC5vD2f5Yn/PTJYfDry1oiFo1X+uXuqvfubslwy2idBH5QN4vqbNZ9XnwXvNqOrceAgBaJ+rXFm6VHQwDJAPtQStHlsTBvGanj5u42r25YqIfH7pmw9pmOiLuYtGJwerheC5ayX5Qo2RTev70Cys3WOzeDY7dieaFRp4e8ws2Iyf52DLzHaKJkuHgLFlgMZrF/NLy5bMy2swBwHhIgdGjdiuhGFqDMY/QIjtRHpoaSwiY1dve/QcAhiFcpEIo+5A/X+aTi38Vxf38BrPSKqkMP8xQwNxxh3hUsmcW7ui9X/OFbOMo5TVKYGekK+YQOJVXVzbM01DscQ3NUjORAz9Xk3CjtA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c71423d-703a-48ae-1270-08dd706edded
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4944.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 16:12:43.0527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQwSLNjfpgO8PaW1SoC9soaTpLmiSA79lP13zsyZJ9HeWWewrZFfDpNT9h4evbj7lW7URICFTaqKactpI8UTUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7576
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_07,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503310114
X-Proofpoint-GUID: tOvFXVg3XXLeeE6tP263cUhORmDvsEe2
X-Proofpoint-ORIG-GUID: tOvFXVg3XXLeeE6tP263cUhORmDvsEe2

On 3/31/25 08:47, Benno Schulenberg wrote:
>
> Op 31-03-2025 om 17:02 schreef Joe Jin:
>> On 3/31/25 02:44, Benno Schulenberg wrote:
>>>       fputs(_("\nThe following interactive key commands are valid:\n"), stdout);
>>>       fputs(_("  i      sort by IRQ\n"), stdout);
>>>       fputs(_("  t      sort by TOTAL\n"), stdout);
>>>       fputs(_("  d      sort by DELTA\n"), stdout);
>>>       fputs(_("  n      sort by NAME\n"), stdout);
>>> -    fputs(_("  q Q    quit program\n"), stdout);
>>> +    fputs(_("  q      quit program\n"), stdout);
>>
>> Why remove the "Q"?
>
> It looks ugly.  And why would the user want to hold Shift before pressing q,
> when just pressing q will do?  Holding Shift has no extra effect.

Then should it be removed from parse_input() as well?

Thanks,
Joe

>
> If the user has CapsLock activated, they will simply press the q key, and
> expect it to work -- and it will work, like they know from other tools.
> No need to explicitly mention this, because it makes it seem as if it is
> something special.
>
>
> Benno
>

