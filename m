Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718AA1EB5D6
	for <util-linux@vger.kernel.org>; Thu, 27 Feb 2025 18:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681214; cv=fail; b=JpiittTR5dnvFgDKptFRGpen5/1YW5g+hxs0Nq+iNxd/xFvXqz6aE8u1xKcwZfBfQweBnMjJ0vbpwzmpcH4/c2ixmlkrK+vTl2F28tB/BP+LutPISu3QwHtmqxkWqXb5EDdSjGMTNatgZjRiuG+zLQUfvcj5dytf3WRbaFYz7XI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681214; c=relaxed/simple;
	bh=dnm7zNZwTawawVwF6kjlSYspKYEepW9i3KE6vRI+GAI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bc++Mv6j4YQD0kpFknZ7GPwWM0pUR0kMXM4MzJ5tfxm83dSaKoP1csgTj+bqI0XpcwAZuDMo60ZkydsLih8V1kBhF0JCKHlLNgsnaO9BV0MLUwVt96Fin6FISBBmCVY2aYa2MurL5DVD9XDLwShwUrgwCV0E+mexnPffPmnzIv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kQR8r1tD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BvadWl68; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kQR8r1tD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BvadWl68"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RGfhRk018353;
	Thu, 27 Feb 2025 18:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=92COaJIIAbG3sBfAlSLrkydvQVFKtSunwmZjOSNiJuU=; b=
	kQR8r1tDCkQNLD6HAvY1jwsdA2r+Yz6cbsmDmPuouEU9XNJvxYKZhCaTvpRDz9eE
	VnTGQRxJm207bNJdp5qt8UQyBouy8GD7pmwptRYT8mYT/tUD/EDz+SF33y36iwbX
	hRh7B3eDf7pP9WkLQpIQWAAhle86x+8kTYgFmHwSE19OUtGdgs1BVYViXfZkuJjO
	D8Z2Hh5WTYdZg6pSzIpMsdeXZKzR1jpnCwSfJm2TF6ijrUwuNWsAWWaGBhE1UqkF
	++00VQ//I+gAmd2dl6EpHgstZzQkTsGa8kRe6SvUrhzvMhER+hjtUB+F0NsFfSEJ
	pe2IgG04pHo3zGPOANpKVg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pse428y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 18:33:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51RHw0r7008188;
	Thu, 27 Feb 2025 18:33:20 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51jjqkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 18:33:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HuzMSUorSqt+PZ+h0GbChrWfEClWmdEvT1x9Z1wF5UaSHo/H1HqiUs6DCbvutX7bntblu0/7+nZmJOdJCKqb5xGcYzHzXlcWZRBcxIHHAaLinKKR351QzuFyhdzoGHFTZ7f3U06H/9NPsWtYhyHtWVNNkDno4QMrYCuMtm2bUiR5r3glusWNc3woGK+qQNf3R4EuonBWj9pppIbmZVJR8J/JeyOm/LCTwCL7AyspAafUpYBGEGw0vaeKTX96aM5SZwSfsHw6NYChNpV7JTYGlkrEDyCmP8kE60w0y/nZXEt6v6FKKDPD+jeJ+VhQ9BM5cRz9bUqNmv/WE8KJGmv/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92COaJIIAbG3sBfAlSLrkydvQVFKtSunwmZjOSNiJuU=;
 b=LiaN4T22NKKTelrWBiOPWFKdDS6uGOijhSctQ4w7Wg7jdkpvBQD8BebaVTKdPTTwZVjxrgyN0owS4CWiTPdShYY2jW77V62vfNU1jtY0HsRk7pEyijB52hWIGlqElnqPtkXiPsnTDkB8BjCFvRiFQQNCNKBVCkMETWSKHo+vnVg2TC3hf/MW/7m2QBei0sGjvJ2OjV/m6UyJkj7EcCGTiAVC7xgAU7P7VTFSgD3SUzJR/q+yFSIoWc3xOmvStVNBKk7/iu2QU3fYo6U0vrW3YZIDq+JjXVvj8knDuVBFNpBs1mK/QBSTuVIXGj+Pajb8t3/GaM3+4iYYbcgwcod8MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92COaJIIAbG3sBfAlSLrkydvQVFKtSunwmZjOSNiJuU=;
 b=BvadWl685PWwapQnsHlqOSak4ny+lMaLtbdo2BTCY/RwBcQOV3Kwj1BDo9AwMSXzJcz/AXu53u+VrJvY3LiF0cAOZO0786y7g8qg1/AzoWxd+AInPrAXhg9vkfPfFocKCVVHP3rQkajiJvtTohUMp1ENNqT7k0xrJO4MXu5pZAY=
Received: from BLAPR10MB4931.namprd10.prod.outlook.com (2603:10b6:208:331::6)
 by CH2PR10MB4357.namprd10.prod.outlook.com (2603:10b6:610:a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Thu, 27 Feb
 2025 18:33:18 +0000
Received: from BLAPR10MB4931.namprd10.prod.outlook.com
 ([fe80::2ec9:a98e:942c:3cbf]) by BLAPR10MB4931.namprd10.prod.outlook.com
 ([fe80::2ec9:a98e:942c:3cbf%7]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 18:33:18 +0000
Message-ID: <f1cb79fe-eb9f-4895-950b-50711408a02d@oracle.com>
Date: Thu, 27 Feb 2025 10:33:13 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] lsirq,irqtop: add support for reading data from given
 file
To: Karel Zak <kzak@redhat.com>
Cc: Zhenwei Pi <pizhenwei@bytedance.com>, Sami Kerola <kerolasa@iki.fi>,
        util-linux@vger.kernel.org
References: <20250227044916.89925-1-joe.jin@oracle.com>
 <20250227044916.89925-4-joe.jin@oracle.com>
 <tzkpkjopbtqlpmeic2xoephezgfl63xa5e4eytycmg24cbnx4q@qamwltb7ol6y>
Content-Language: en-US
From: Joe Jin <joe.jin@oracle.com>
In-Reply-To: <tzkpkjopbtqlpmeic2xoephezgfl63xa5e4eytycmg24cbnx4q@qamwltb7ol6y>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0070.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::34) To BLAPR10MB4931.namprd10.prod.outlook.com
 (2603:10b6:208:331::6)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4931:EE_|CH2PR10MB4357:EE_
X-MS-Office365-Filtering-Correlation-Id: ca0a7ab1-4722-4535-af5b-08dd575d344b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjdaMlU5cDNCWTJNcUtONTlkRUdjbmkrMVVUSTBxalFwMTM1M3JaL3ZNV2Ex?=
 =?utf-8?B?Z01ZR1hrSlgvK21zc05KWFZnVlA1WllCYWVJcjhEbHM2Y0NhdVhvOFN3ZHNP?=
 =?utf-8?B?b3NSNmZjSkhpWGZIODhQYlpvZU5hbEFqQXFNMDZHdmNxYUo5dExuOUhlUXFU?=
 =?utf-8?B?MjQyT0VTbmxzektDQTRBZXBneURKMmxnWDA0eU94RlQvSjdLWEhMNkxwbVNZ?=
 =?utf-8?B?ZVZ0eC9QcGFtdkZKSTB2b1NVMEJoSFFYTUpGemJZM0JJZmdiakxNZytlRkVK?=
 =?utf-8?B?MXllTmErelk5cjlSZ3hQWE9vbUlJNDZBc29YOE1RZWVlZnZDS053N2FnUERM?=
 =?utf-8?B?eG15NUsrVENWNW5hUUxrOHkwUkNPS3FWMlMrbHZRQTNUL3lTdmFqV3ByZ1pT?=
 =?utf-8?B?djd1WFNTTkhyZlVpQW1UK2had2pXYXN2dmk1cWdSMUdOajNFQTduYkZ3ZGFz?=
 =?utf-8?B?ZHliNzhDSThId3NzNDlRUHJ6aGM4MjdZalpUUDhZQTkyc2xVOHlLZWhianh4?=
 =?utf-8?B?RGllU05iUmRTVjhTTzIvZFlYaElLUFpqQWd0QmNPb0ljSkdNNTRHVkZrV09S?=
 =?utf-8?B?QU5EMWEyL2h1TG5rRERhV3hlNmtuSmFnWlg4ZEZEallnY3BYSFU1eEs5dmtU?=
 =?utf-8?B?SFNyYUgvQ1M4NjUxSXBSOTR2cHVjYTJOVnovZ3ZvZHVTbnpiMDU0QkdTejZj?=
 =?utf-8?B?QVZIMksrcGtxUXJDQnZ4Um91WHBzR29hcWFSWk11c3ZPSGJ4aThYNE9UZ1BV?=
 =?utf-8?B?bDlNVGtUaTJTbTJ6LzZUMEJRYUVFaUJ5ZjBYTnA4RFdNbThEVHh1UjN4akF4?=
 =?utf-8?B?aVVEY2Z5WXM4T3R1Z2RnVlJUS2YvcWpNd0REazFtQk45T1hKK0p0b1lvWFE3?=
 =?utf-8?B?a2c3Ryt4RlRpdGZPRXllem9LenIxWEIxenNrWXZPMzZWeVgwYTNHMXk1cld6?=
 =?utf-8?B?elAyRU9zTWZ0aFRseXFDd3FndUNySmx5VkRqL2MyRlZpRzVuZjg0anhmLzdC?=
 =?utf-8?B?bFhpUnFDeUhrYm5sUlgwWEJ2WkttS3dpdkZ4Y0lSN0V5TC9LVlp1YkhKejFh?=
 =?utf-8?B?ODNGWWNvUDhnT3dLUHc1Z2J1L1krdkhZYUJPNVEvdVd1V21Oc2EvNXovbTQ5?=
 =?utf-8?B?czVoNnUrdlF2aTczNjM4RE9RM1pQS3lwTklWNTN5TW84a2ZHSy9FemFZRllN?=
 =?utf-8?B?cUM4N1NPWUFvdmFOczM5a2pxNXpDQ2hBSytsUEdzeVhSSDd5Rmp0dVQwN0ZO?=
 =?utf-8?B?a29URDF3Z0NZN0d0N0NVbzByMHBvd243WUhCN09yaGYycVlqYkRKeVJDVEhP?=
 =?utf-8?B?azFtQnErWmVKbzd2QTZpUFhwb0JKM2FDaDdOcG5maGMzUWk1NW96ZnFVcTZp?=
 =?utf-8?B?TEFEbjVicXlKRGZaZzM3SnNtN3E3bWFmZlpyTTRnTUg2LzM2OUF6b2hUZXBP?=
 =?utf-8?B?RHdjL1ZtMUViVUVCdGNZODNGNWZlbVAyT0lEOE5Bd2U4NmVrNlg5STQxN2pV?=
 =?utf-8?B?ZTV4ZUZydXdNQlg2Y3RSS3ByTW9QdkNtTFJxUTFmYmc2eEhTSi80dWlGdUs2?=
 =?utf-8?B?T05ScmFzNWE3Q3FydytmUGY4ZlZ0NUQwL284aHZHbGsyUTB2cDdJaGNFLytU?=
 =?utf-8?B?NWY4ditTaWxGSFU0RWJiWXJmSUhFbHpvU3JmNElMUHk0SGEwanpkYWNmR1Vh?=
 =?utf-8?B?SUdKMUhUTWsvWmF2RkJVVDRORDcwRjd0RldyVlFMdzU1OFJCL2ZEclI4MW5y?=
 =?utf-8?B?S2VkSXRpVnlNMXcyNHpKRGxKZnhqUUFCWlEwc2hxVCs4eHAvWEVFUDNxUVZs?=
 =?utf-8?B?UWpWMHR2eGRwWnFYK3ptVHVBZFEvbFU0N0MvR3B1bXFZRlZhN3Rhc1RqN0F1?=
 =?utf-8?Q?v0JryUAXkS5T6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4931.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0VDNUpUTFhrWTZTTVFRQ1NHUHp1cXUvVzFRYy9WMis0bExPRVNrWFd4K0NB?=
 =?utf-8?B?ekVrc25qNFN2ckFuQUM0YTVEOTMxTWV1WVVrSU1CcXZxYU1YS1Jicks0V3FL?=
 =?utf-8?B?S1VuK0NxN1g1V0E2eUdEai93OUxSOGdwTi8wZ1FRYno4emdDdXI2ZXl1Z1hv?=
 =?utf-8?B?MlBKUmtrdkZob2lFZXRod3ZMUTdEL1hlNHZOZVhONWM5T21rZ0dXNTdtZWpD?=
 =?utf-8?B?Z0pic01OQjVIUncwWHZNL0dvVVkvcEp1UG1IRGY4bFNIL2NQQXFaNXQ5USs5?=
 =?utf-8?B?bnEwVmh0Q0hnYURHRm1ZWlFzV29tVnVLZFdYSnVFNHZveXZOZnAwVGp3Kzli?=
 =?utf-8?B?SGlQUngraHRpOUpkaEpXcUlJd1Q2emtYMGptTUJ4cXhROGxCK0NuVDFOUUdo?=
 =?utf-8?B?UG5EOHdlaWxBMXRqczhxV2FIbzNDRUFqMnk1RlJlcm80SHAyV2cvN09kWjky?=
 =?utf-8?B?Q053ZHdqVlladFprTVFHWWJmamhDVW5nQ0c0V0dHb2dWcDBKR3NNUU1iRWlB?=
 =?utf-8?B?dkVVUFlOWW1uQkhDWGFKV0JoaDA4eU1oRFhLZ2xGZUdYTUlaM3lkQ0FiWXVT?=
 =?utf-8?B?TFowMlFYV2h0MG9pczBwYzdwdW9IQVhaaExxSGM2ekF5ZWFUWXM2ZHR1YW5i?=
 =?utf-8?B?SXJGZ3laVXlFemZzbURsdFR6K3l3cWlnN3VISjFFUVU1Zno5enN6dXpqTGZE?=
 =?utf-8?B?aGpCbDBNdUZPS0NkTE00NzJydE5ha1E0UEV6akVmbFNNb1VJQlNZdUdRUmdB?=
 =?utf-8?B?NmlKZjduYzlHNElheWcrMlE0ZEwrMTRycVlWMGFCTDdBY09hQ1QzOU5rTjBm?=
 =?utf-8?B?N29CZ2tmSnFqU3M5emtCV0FjQlVWRFlCSTBDRUZ1TEoyWUJwNXpybzZhTC9T?=
 =?utf-8?B?bU5LaHRRMEFzOElFK1VkLzBJcUMzQ2FUVG5BSi8vSkh0dHN5RG5MaXJPQWhF?=
 =?utf-8?B?QytPZlNCOWlSR1ZZVnBzamFwdzNrNWRhTEJJN1RQVHdHSklVdEFSaXpkUGR1?=
 =?utf-8?B?VWxITmNEVXhkbE42cUJwVE1FQTVSc1gwRG9EeE9Mdm0vOVV5M054TnZQSGs4?=
 =?utf-8?B?alJJQzFoVWszMmw3Tit2SGp2UjB4NVZqQ0lGWDFUWGlxRXlKeitEZWZ2WWVR?=
 =?utf-8?B?V29uZTh5c3gvLy92TGwzOFZzN3M2TGx6M2V6dXVyWnJWYUQxdDhZQVp4QTF4?=
 =?utf-8?B?UXlySGQzdFphRURMUW1sZzZxdGIyTGRCSkxjMW8vNG4wR05CNFZJNy80ZmtJ?=
 =?utf-8?B?b3htaTBleGNtUUlwT2ZFYWFNcms4QjRROFJOYzJEaFhuM0dzb0pXWGM1S09V?=
 =?utf-8?B?bWY0Sm1qQmU3bm52VndrMFFSTkZ3MCsxeFJMbXcrZWp0NHFCcG9LOWczb0dm?=
 =?utf-8?B?cm1BV2FodmRmVTFDZTc1cmphVlhZL2FPeXRTSi9wN3Q5SkhVbkY4RFVjeG5D?=
 =?utf-8?B?Q29oeFpFUmVtYzFPQzNabjYraWlhTTZrdEhRNnVpL09hOWt5cGc5RVo5cUpu?=
 =?utf-8?B?UmlzSFlMRW1QNkMwZVNPeEd4RWlvN0xaNVUyRDc0emcxNE1tWk5VdlpvaXRz?=
 =?utf-8?B?dk5WQTI0cEZzWTlqM0VEK0VJeUhkYTEyb2tVR2ErRnhuWTVMaDBEYTJGcFQw?=
 =?utf-8?B?N0lGa0ZsUmVraFdOVmpoNWpnNFh4OHBnZkQ5V3l0UUpwMDVTMmNZM2kweDlJ?=
 =?utf-8?B?cERmdlpnd3pSb2xPTEdEKzh6enJvNGowMERodW9rUExIVjcwZUh0ekNOQUtr?=
 =?utf-8?B?UDRaY1R4b3l5QVRrM1BLVWI3bnNkWVJJU01PbktrTVpVOWpmNmVvNkU2WjEx?=
 =?utf-8?B?YVl2Z05KaGZBN2x1bTl5R2JMR2cvWUtJSHNtQSttZnlDVkZTUm1vNUdhVFVv?=
 =?utf-8?B?YW9lUnNjUm5sVi9WUHljY29tVHNSbUloYmVsTFZCb3o5NGdyV3IyT21PV3Fo?=
 =?utf-8?B?UFdqV3paOVVKbEJGMDR6NnBvcUhQTi82NW5sT3YwaEVaTW5WY09kWXZSK2l5?=
 =?utf-8?B?eVZKQ2VsT1NqOTB0MmhOdkhReEcrSURRL2MvWjZpWkI5eUoxREVYUDRYdGNl?=
 =?utf-8?B?ZlNaTE5wamVZVzJpeUVuU0pYNjYxSzJLSlI1L05hSmN2KzBrNkNvZnhpd3ps?=
 =?utf-8?Q?ZFQVrNQnOEFMeyki3JURr3a4l?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4GYV4xelLFctUy+knFck+l4O1op9NMhnZdcCK3pVn4skEDfwT3ouYVxxFF2Rf+kp+OtLvHBcXiJmGRukLBEOAkNzvL11BVCCm3GY2JYkp9u3SZRuYMj6qXL09wKw+++DmsJNBAKthhnsCefVgkh/I7D9afkp/lhe3fGfp7VHbWrAaUs9g9IuoaSHMQtSPgxMQ2Q+cxoGxW0TwaLXazJBhbGR2NxQwMkMOFWXZj5oDn6ONyY3V22F5Q+dU0saPgZWlcMNPZq864ifQ7+h2bFXprlaaFvB4iNSgM68lypn+qs6BsVORm/YQMqqer6mesz4iXD12nR0SH2ScC0U/wFFn8q85K66xUjN7asrBCVLnldmH/+jjIu7dvioeIYqaX0dRbn2HBN5UNhgos+BYgWBqTTP47aQrla+VUjop5cXmgWcmtucjidED+9OIbnz4MU2KgZAWXL5GWIQ1iIyjie3BIHrPAMG6E6HhPedfnXR2y+TJOkLgeGXYDLfshmjPM/lStXmuxxz5GcBVux8LfLMHn5OHoZ1cVxwBQ1SXSxzL9qSBbLtDbSea5C87LRFF/hcHEGQU5LKsPtnkBwcdH6GnNX38km9g7eHrtcBB72u9MA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0a7ab1-4722-4535-af5b-08dd575d344b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4931.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 18:33:17.9926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dLwQTn94Hv9FyKwd8bOQ0aUi0jCXFzg7T3N8PAAzx3zRXb4pj29G+zH59tW7+PiTMDgiYR/Nvw4VAyo+PSoX9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4357
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_07,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=816
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502270137
X-Proofpoint-ORIG-GUID: mipyZgAf8mzQmulFPPX9xU4OVfCAlWC7
X-Proofpoint-GUID: mipyZgAf8mzQmulFPPX9xU4OVfCAlWC7

On 2/27/25 01:30, Karel Zak wrote:
> On Wed, Feb 26, 2025 at 08:49:16PM GMT, Joe Jin wrote:
>> +	if (ctl->input == NULL) {
>> +		if (ctl->softirq == 1)
>> +			ctl->input = strdup(_PATH_PROC_SOFTIRQS);
>> +		else
>> +			ctl->input = strdup(_PATH_PROC_INTERRUPTS);
>> +		if (!ctl->input)
>> +			err_oom();
>> +	}
>  Please, use xstrdup(), than you do not need to care about result and
>  use err_oom();
Will make change for this, thanks for your suggestions.

Thanks,
Joe
