Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9F11A08B5
	for <util-linux@vger.kernel.org>; Fri, 28 Feb 2025 04:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740716682; cv=fail; b=FziCt8iZyD4i+d92/yMvsgDnjdulFI7ouYnpiKYS7Dm8vLEUwDieZGyeoJsJwNatUyXs988PCEM9M1Qj+r3bIIUMww8a9NQeEmkyDoEXkT6XAQKiqilkdUuSzCY9abfz5FxoqF98PMFOJ1mrZjvR9nYZv+e4CrszaxieWG5DInk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740716682; c=relaxed/simple;
	bh=ABDJ1PgsAe4akAuDlHx/uR9HefsAdUBpSy0cuNIVfs0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QJR49c0V14LmP5QWvEfK9wvTsxM10XQELU1qz3eSJA+qUXx5QHnjov7RFYSsCDE5WWOEevkwlmNHoB5KaG/gHedYpHrkbo0feM+qsDJfHptho42yxXsOFBofOtOkiphkEoz4VuB6Sqg1AB+wwnRwuq8rnCRdQJ/1a9uFjzXQ6OY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hEnylb0+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GhbqPo/y; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hEnylb0+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GhbqPo/y"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51S1BlND032633;
	Fri, 28 Feb 2025 04:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ABDJ1PgsAe4akAuDlHx/uR9HefsAdUBpSy0cuNIVfs0=; b=
	hEnylb0+Yc/o2de5u/8kNkhEZEK2AYHl9XXg0t+dLL9YWTM7NCo5ACfRV3PzVRvo
	E+9QO7GbD793sLhHszXrIuL3ZBrOtx3x4IgzhDbzHOcLi6iDWqoZN/i4PCxj6FWO
	U8j3E8okJf4CVg/WxYyLtVi9vBhHRNZTF83/rf4DfDEz1FZHSO3xbUExisW14NWv
	e0+xtaQJ0GDEp/fWJLUtLHTX80M4KkXuRwVwyuzUCDw/Ofh+B1v+m+lRR67SzHFX
	3KvzKLoDSTso37X+JTla379eEU+utu7W/PrwpNQ68TQF3I+ItsLEcalYrWeYaGfr
	d/DW1ssSw+2FWWhKvZbaHQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psf4u6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 04:24:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51S2diO6012788;
	Fri, 28 Feb 2025 04:24:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51ebra3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 04:24:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7fJN2N6RVXpxoeNnRs8dJNXZ0yE3hXxeqOB0sDIg4YsK+Lva+rErPMEFrDq10z1WcMOzMijW7xexvO79AWECi4MAxNuToTGinqFX0J/G8Wc8d8AarLqzPW4K5ML7DYBf7JvKpq3PjwTVmGa6M74HML2MmioZzTzWVPc9HcJjIQ417aOx2V0yisuAD/6zjwINPiPjkgyDUPfTmJS/krhGUF+fVC1gJqIEzfiHINp4dtsNxjQ1UXAC6L85uXmiOPE9eDT+eEBvOzL0dHTzXES8Y43xm3lrxUnpIUMWmaCC6l7E46k7J7I1dJWtSWaLP07O/Ut1FnVJfS/82H4MFtgwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABDJ1PgsAe4akAuDlHx/uR9HefsAdUBpSy0cuNIVfs0=;
 b=iVM475/oP2419LfUNIR/hQtrXmPeKBdKtaGFWBw9JQFlCkgDv98wKWVkt/r6gADx92n7pl/2J+FUtL23dpz+AOahusTl1on7/XxNdNEnLGidFzyxsuhIOskAFYTIN+mLdBzHsOVpqcdEIKRxzQXpHCsEmuspKAHAaMq5qVmJG9RI0TbwwCVb++GbGJpvGD8FGgoRAReoRxSrUdPlsE2uWHHRNRrN+CncG2xB2vZxh1Q80ZPODcGYw9co5ABsezjb6Fc0YUMjGbe2njRuMjcclhjW46lJvQoBWmBn70yyu64H3cbx7+qibqClQzXA3UdafuuI5FPnGDJ3rCUK0peQew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABDJ1PgsAe4akAuDlHx/uR9HefsAdUBpSy0cuNIVfs0=;
 b=GhbqPo/yWlL2jkfaDmXV2a/qYw4CZV71vzNIOs9Yk3RnntdNVs7oH8I/V7tsky7EQd4H1n5IuxpDS10x/hPL/Lgw4z/fcb9XPMtgkIm7CjtRgu84XDSi+jQA1A7u4yPacA8EXlXVy9o8QHFo0tp9+Xeuo2f9Ho8YYKLMGmn0y8A=
Received: from DS7PR10MB4944.namprd10.prod.outlook.com (2603:10b6:5:38d::15)
 by DM4PR10MB5917.namprd10.prod.outlook.com (2603:10b6:8:b1::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.23; Fri, 28 Feb 2025 04:24:12 +0000
Received: from DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5]) by DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5%3]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 04:24:12 +0000
Message-ID: <44fa1260-5a46-4097-b5d0-4f908e743dce@oracle.com>
Date: Thu, 27 Feb 2025 20:24:08 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] irqtop: add batch mode support
To: zhenwei pi <pizhenwei@bytedance.com>, Karel Zak <kzak@redhat.com>,
        Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
References: <20250227044916.89925-1-joe.jin@oracle.com>
 <20250227044916.89925-2-joe.jin@oracle.com>
 <75000d2c-8f17-46b2-aabc-9cc5a3c97e2e@bytedance.com>
Content-Language: en-US
From: Joe Jin <joe.jin@oracle.com>
In-Reply-To: <75000d2c-8f17-46b2-aabc-9cc5a3c97e2e@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::47) To DS7PR10MB4944.namprd10.prod.outlook.com
 (2603:10b6:5:38d::15)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4944:EE_|DM4PR10MB5917:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dfc8e5c-7077-4810-21b6-08dd57afbfbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGRoRU1MMldYZnZJZ3Z3T1FaMGNkbllsT1lNc1RwU2dRRHNHcUZPRmFObk1j?=
 =?utf-8?B?bVlLbzAzM3BiOFJFY04vMU4xdUh0b0dvSDJPeXZjQnRmNzhxbWFNcXloeUxU?=
 =?utf-8?B?NW8wbnYvRkxGMGU4c2hraHZ0WW84Sno3M1AyREpvNVZ4NTJYZll4SEhXSWNr?=
 =?utf-8?B?UGtrNFRRYTNlVGtxeXRiQm11MElYVlBaQVNlakcwT1RIVDR0cUlPMy9LVDcz?=
 =?utf-8?B?YVBEWlNqOVAxVW1jUStqTS9ZSnVycFJZTk9uLzVRZ3IycGZnNk5DbS94dnV3?=
 =?utf-8?B?ZnM0Ykw2LzBPNW01SFZoeXZNNTM1NGNaOFNzajExdXIwZWgxdGZkWXhhOWxr?=
 =?utf-8?B?VlRVVTNHUXNrYnlPL013YUtXZGFiVzRoVlVlQjU1RXVtVWZBWEREbm4rMWNR?=
 =?utf-8?B?c00rTUc4akpobFprMGQzeXZyQlhQSUxMTDgrVkpwRjk4VkMyYWtLb0tLd1lI?=
 =?utf-8?B?cE5FMks5NWtPUkpmSGZ0NW1rejYvZWx6bzlidkZMYkdUTVZjNExxbkpXYVdr?=
 =?utf-8?B?Z0dsdDlGR2NDdXlLRGlCU1NTTFBTZDhBbFM2ZjlOaW1BR3dYanFLN3FvamZZ?=
 =?utf-8?B?RGdUVjVWVG9NMlQ2cDRmUU9hUEZlL3BlbEs2Ujh3RzZOZlBoc3pMZWI3OFpL?=
 =?utf-8?B?UkhKamFkTHc0cXBlYVlnS0xVcW03VkQwMG5nM3JpSVZlOHU1eU5yZ0lrMDN3?=
 =?utf-8?B?cDMxakFYaVVGL1ZiNk5RamJSSkZqMHVpa2FGNzluc0M3enFKSm1NU0pVU1ZJ?=
 =?utf-8?B?a00vT0t2eUxoSWhWZFJCejJJc0lYd3RNM0VWeXNQeWtDNzZLN094MmlwZzNx?=
 =?utf-8?B?d2VQdGtZRy9XT0ZSQnVXV3pWUUdJd1ovY2dLY3V0aHRqMXozL3ZHczBxNlB4?=
 =?utf-8?B?NCtlYUNtSkdkRnkwYVJlZHdSWGJ1d1J6eWdmdXRlWmVQUUlUYzZoT3VRUVk4?=
 =?utf-8?B?ZUZoZnVBN1pNTHpzZW9tNGpmeitMUEVTMlEzdFJremFuRmdoUXB1cWJQRDM3?=
 =?utf-8?B?aVkwc0ZkNWlkbldrekcwOWhLYnY4MGQrY2ZQRGI3TDVGNFFGYTl6MFI5WnpH?=
 =?utf-8?B?d3lOTDBEZDRwejg4aEorRkVNdFlDc25oREZkVit1MlpZUHAySFE0WGx0ZUo3?=
 =?utf-8?B?ZW9kUE13Z1ZBR20rd25tdEsrQnVvaGNJUms2cHNYTDBNSVpYQ1NTOVViNnpj?=
 =?utf-8?B?TytLZUgzWUNETkgzdkgwaWpUd1ZEYTNTSXluMm1HTkVFdUZXcC9zMGRaSkFC?=
 =?utf-8?B?MG9MVXkyL3N4SnBscHBoUG5BenN0M0lmSUFxWWQ2aFgvVGJUSTJRL2FhQlZw?=
 =?utf-8?B?d2lzcUVGVW04RTRmaHV6d2t0dHh0ekhzVERtamZ3S0oydDhtbjE4VkwzS2dB?=
 =?utf-8?B?dUdFbDNvTmhNMW0rYi9meWN5cW1LSnEwY2pUOFhEVHZwc2dYS2Zza296WmNs?=
 =?utf-8?B?UlMxd25oYmYvUHRTQ3JpbWNsK2pqVmtPUm50Vml3OUF3QmlyYk1TUlZOTHls?=
 =?utf-8?B?bDd3dzhscmt0ZWVwbjN0a0FOK2paT3ljUVUwME4rbnpIeG9wZGlCelRGdzBr?=
 =?utf-8?B?YmpDUmVqcC8xQ0Z5b0t1WksrVWpJM1FiYlZZajNKQ0RKdVVJVjF2M3BhbTNI?=
 =?utf-8?B?UnJvWXVML0VMV2ZBcVhSYjFxQTU0b2lINGtlMlBnclJvM2J1Nk5vQTh5RGZ1?=
 =?utf-8?B?TXc4djlQSDBRczBDQ3FWSDVaYnBkY05WY1J6YlJsZDczMWdMd2Z3VjhkZ0t3?=
 =?utf-8?B?SHJ0Lzh6Z2V4a0h4aDJ5VGFMdHIxU2hKRCtuQ0JhellIOVlFeXNZczVpaXlj?=
 =?utf-8?B?cEtEdzBXbzAvRVhENUZSMVBEWXNRN0syOHA5alFjekt1MWF4dFNvTTBpbk5x?=
 =?utf-8?Q?tboyQn7gSdGb9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4944.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VG13a3pHNjNweE1YSlVzZnk1ZEgyZCtkQ3VHYkJtVEUzUDE0VUZ2ZnpMdDlX?=
 =?utf-8?B?YUp3WVZqdG9CMytFN1g3eE14bXdMOWVSTHhHd2pkOVFQM1d6SHlyMVF6T09T?=
 =?utf-8?B?ajY5MlpRdHFQS210ODkzaGxmbW1pYVNjdkpna1NLQlBPVW5KL3JnQ3JDOE5Y?=
 =?utf-8?B?SXlZMnM1OVNrcEVyU1hOWC9ESkI1Q1lnUTNBL0hPWW0rcU1kWVBUb05wSjgx?=
 =?utf-8?B?ZEVId01LVTd3eUg4eUFXeEV0VkNjaDAyY0x2bWRkOWxxdmhBc240RWYxK01Q?=
 =?utf-8?B?Q3oraHkxWmhZSllualgyakZIVzBQemVHa0VOb2hnZHFyVHpwa2VZUUtRYVZr?=
 =?utf-8?B?cnNDZVJyQkdZaUlERTlpbDh0bFg4VmZrU2x1YWVZbXFSOHZwbmwwdDZFS2Rq?=
 =?utf-8?B?UUhjZkFnWURqb3FueFFXWW5IRW9QRmVmbWxIQS9oQ2N5VVhuOVo2bUl6UVpW?=
 =?utf-8?B?TkdUUzdwWWZ3T280VlYxcEV5c25qVW5YOVFxdXJ4cGwwNzFtc1d3ekMwTHhn?=
 =?utf-8?B?NGtPOUFqdnd3WE5oTmRIdmpvU1U2QVNLZlBtVmJKd3plbUhlQStPeTZJT0VN?=
 =?utf-8?B?aWNZQmFQd1ZubHZVWXVBS0piSkhTMDBuanI3MkIyVVFSMG9kZCtRNEpRSDZN?=
 =?utf-8?B?LzFlNDVIK2NRTW1OenQ4SGQveWRjTWI2MWd4bzRFSnF3Z0JBTld6OGtnYVY4?=
 =?utf-8?B?Y1JJRU91Tm15Q2VQbS8xSUlkZFptdUtiS1k2L2hDL2kvQU0yZHZLRWZ6QVpP?=
 =?utf-8?B?L1dIVkRsOGFwNHFFNmM3VXVMT3Q0RlJ2V25nNTdQc3h4aW8xYklGV2hHblZQ?=
 =?utf-8?B?NnQ4TXZ2VEd5dVpWMTlsbTRYanF4NmpxajdWTzJya09oNFlmM2FrV09CRGMr?=
 =?utf-8?B?NlE4Y2Vib1pqMjJnZkRyblZKeWlzd1NacHBvbjhkalNkbTV6UUJmS04rWWlD?=
 =?utf-8?B?UkMrcG04Si9ML3JVbWZsb2k5ZUJSMmJMYm1CdWVBNXJXUU4yZmhrUm1QQ3pW?=
 =?utf-8?B?aURnYjRxbTBZNjZMS0R4aS9TZEt1bHZuZlZ2U244eHlzQ0ZEaUs2NWh1WThM?=
 =?utf-8?B?OW1wQnFyZFhacnhUdlAxd00zT0JDSDNyRkM3QXdtVG5CRXVWdktvU0gvT1pZ?=
 =?utf-8?B?cmYyRkZtbHUvNGdiYUlhVzROS3lGTlpVOUxsQzNNNXYzK3cwZGQ5LzJCNzUr?=
 =?utf-8?B?Skkwb0ZkWUVhK2NRTDZjdTlQUTJEUnBzUWUxaGdWQ1M2SWx6UkJ0ZnIzamVQ?=
 =?utf-8?B?UjBTeTROVXB6MEhMLzJ2Qlk3OTZXSnozdU5kZVZnczQ0WXRPRnJTemRaTGVx?=
 =?utf-8?B?cUxheXFkbHVJN2p4anpycG51MDduOEVRQnREemllN2VkQVozd3k3SGNkV2I3?=
 =?utf-8?B?WFljZk16MElHaTBzT3dvREpIeGZMTmtINTlIenRxV3A0UWRteWdlb0hPZElj?=
 =?utf-8?B?M0pFK01NMDRqcEhRaXdmWERUakVjQm9GbkNuUFdoalpxTlRxWWpqOXJwRFls?=
 =?utf-8?B?ZnBEV3dIMVdjdDcyT3ZyOEJqcTNlbkx4RnQ1ekNUMk03aEZqRSsxU0JSaTAz?=
 =?utf-8?B?YWlKdHBseVpRdGhUTWJNcVNCNDZvS2x3aW42RnMrd2tFWUxFVXdVa29BWmg0?=
 =?utf-8?B?bUk4MTRGbldnWHBKT3kxRmdZeGRYcVp5akQyVFZyYUdjc05uVnNEVDlNdzFu?=
 =?utf-8?B?ZEdnZGtmMmRYUy9ld3h2ckg1UzRnTFJjQ0xjV0wrYlE0V3RGbk9iQmFycUVx?=
 =?utf-8?B?RVRBWEdkTWhsMUlKVVZqdWVwcno0N3JaSC9VNlpyR3Foa0tiTEEvWVFSNHhT?=
 =?utf-8?B?dnBNQUVlRnhrUHZuVGozYm9FaEpNaXUwd0F1YTZYaEd1M1IwMnRFQ3NxQUtY?=
 =?utf-8?B?MzU4S01LSitqbVgxdXA2dmNxM2dqSng2MkFxRTBWMzV3SkVwYU45WjZobUJ1?=
 =?utf-8?B?WjdyTmswZGh4a1dmRlR5YXJVNjJxRDV5eXkzVXF1dXgxNkhINUdnU3BPSG4w?=
 =?utf-8?B?VDROR2JZMXRpYWJlS1IxMVZVSkgzVkM3Y2ZodnBsVm1zTGMyU0xXR0tzWGVo?=
 =?utf-8?B?ZmVYcXhmc2JyQ0grWDU1WjlUeWY2S0lIOTNJdnF2QVRPZkcwT1JqV1FLR3dE?=
 =?utf-8?Q?gkXzeOXCKm+dxU3Mh6ElDSdFv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	M1B117HLRxeW4w0qdsvzFrYpox9p9f59F+cO7yznwLnXwPMVQH2g9jR+wqAhb7xZOr1gHNLzLXyT+G583JPTSXXAWBcYf6g0MHhuaZnkBV2iBsky6iN9OzN9gfx7n3o2kXbJiT2xzDY103inWBt+0qW9ullriibXpR1L5Vm92XIuGODNIj/WjdOa6nrm+Djp5kw1XI1dmZX6ahqrROgrSOcxaE69b0UxpvnKOdD+IEUUlhvUh64M1X5QoA9HnNIzn8nWHh8TXTyYrm3hzHj5zVycT2Q7npv0ZFiBav7WbCk/WIz67HUefqUhxtqp0WdsA9ynT2ykCb8ZqiG8A/I9iqOzOZwFBzak/8WcXbKqY9SrlLxLuNF4FVihXzdLPuEOqUTthiflKm1BGQA8CP7yyRbWkdQrLPkdWXU5cUk/+lI/q4Dgy3WJCqbFGMz9nl7lmUsC0e13mqrjyL4sxCRHRrb5h1Y9RMreH7OUJMG2uis+xYYR/xGiY1GTpscNRUrURBqt/ljZapbqZA/Sk8PFk342quoENt0SeUGtEK4JD7DdiDjDIhIFFkODu4X4gMqFKoiTJpNS+wiACjdBiium/36PKvMQqIacDDng05Taglk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfc8e5c-7077-4810-21b6-08dd57afbfbd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4944.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 04:24:12.1790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tiw3E5IYJk6hFn8g2lUtpJP0Occ/UCb4ReHRV/AFct5nXJso1nb9rVnJNQSq4CLuQOkBxyVuDNc9LBAUecLbWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5917
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_08,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502280029
X-Proofpoint-ORIG-GUID: cG1AVsbrw-DNCpGCRbTYCvtWUgbR2K4Q
X-Proofpoint-GUID: cG1AVsbrw-DNCpGCRbTYCvtWUgbR2K4Q

On 2/27/25 17:34, zhenwei pi wrote:
> Hi Joe,
>
> I'm a little confused about 'batch'...

Most time the purpose of batch mode is to capture data continuously.

Thanks,
Joe

>
> Rather than the original terminal formatted style, the new change brings 'raw' style?
>
> What about 'raw'? Hi Karel, what do you think of this?
>
> On 2/27/25 12:49, Joe Jin wrote:
>> Add batch mode support, which could be useful for sending output to
>> other programs or to a file.
>>
>> Signed-off-by: Joe Jin <joe.jin@oracle.com>
>> Cc: Zhenwei Pi <pizhenwei@bytedance.com>
>> Cc: Sami Kerola <kerolasa@iki.fi>
>> ---
>>   bash-completion/irqtop  |  6 +++-
>>   sys-utils/irqtop.1.adoc |  3 ++
>>   sys-utils/irqtop.c      | 79 ++++++++++++++++++++++++++++-------------
>>   3 files changed, 63 insertions(+), 25 deletions(-)
>>
>> diff --git a/bash-completion/irqtop b/bash-completion/irqtop
>> index b9e454d4c..215281ee8 100644
>> --- a/bash-completion/irqtop
>> +++ b/bash-completion/irqtop
>> @@ -5,6 +5,9 @@ _irqtop_module()
>>       cur="${COMP_WORDS[COMP_CWORD]}"
>>       prev="${COMP_WORDS[COMP_CWORD-1]}"
>>       case $prev in
>> +        '-b'|'--batch')
>> +            return 0
>> +            ;;
>>           '-c'|'--cpu-stat')
>>               COMPREPLY=( $(compgen -W "auto enable disable" -- $cur) )
>>               return 0
>> @@ -40,7 +43,8 @@ _irqtop_module()
>>               return 0
>>               ;;
>>       esac
>> -    OPTS="    --cpu-stat
>> +    OPTS="    --batch
>> +        --cpu-stat
>>           --cpu-list
>>           --delay
>>           --sort
>> diff --git a/sys-utils/irqtop.1.adoc b/sys-utils/irqtop.1.adoc
>> index 443e23b84..e81f4fbb6 100644
>> --- a/sys-utils/irqtop.1.adoc
>> +++ b/sys-utils/irqtop.1.adoc
>> @@ -25,6 +25,9 @@ The default output is subject to change. So whenever possible, you should avoid
>>   *-o*, *--output* _list_::
>>   Specify which output columns to print. Use *--help* to get a list of all supported columns. The default list of columns may be extended if list is specified in the format _+list_.
>>   +*-b*, *--batch*::
>> +Starts irqtop in batch mode, which could be useful for sending output to other programs or to a file.
>> +
>>   *-c*, *--cpu-stat* _mode_::
>>   Show per-cpu statistics by specified mode. Available modes are: *auto*, *enable*, *disable*. The default option *auto* detects the width of window, then shows the per-cpu statistics if the width of window is large enough to show a full line of statistics.
>>   diff --git a/sys-utils/irqtop.c b/sys-utils/irqtop.c
>> index 8fbedb16a..00bf8fe50 100644
>> --- a/sys-utils/irqtop.c
>> +++ b/sys-utils/irqtop.c
>> @@ -83,10 +83,22 @@ struct irqtop_ctl {
>>       cpu_set_t *cpuset;
>>         enum irqtop_cpustat_mode cpustat_mode;
>> +    bool    batch;
>>       bool    request_exit,
>>           softirq;
>>   };
>>   +#define irqtop_batch_mode(ctl) ((ctl)->batch == true)
>> +#define irqtop_printf(ctl, fmt, args...)        \
>> +    do {                         \
>> +        if (irqtop_batch_mode(ctl))        \
>> +            fprintf(stdout, fmt, ##args);    \
>> +        else {                    \
>> +            wprintw(ctl->win, fmt, ##args);    \
>> +        }                    \
>> +    }while(0)
>> +
>> +
>>   /* user's input parser */
>>   static void parse_input(struct irqtop_ctl *ctl, struct irq_output *out, char c)
>>   {
>> @@ -128,16 +140,19 @@ static int update_screen(struct irqtop_ctl *ctl, struct irq_output *out)
>>               scols_table_enable_nowrap(cpus, 1);
>>       }
>>   -    /* print header */
>> -    move(0, 0);
>>       strtime_iso(&now, ISO_TIMESTAMP, timestr, sizeof(timestr));
>> -    wprintw(ctl->win, _("irqtop | total: %ld delta: %ld | %s | %s\n\n"),
>> +    if (!irqtop_batch_mode(ctl))
>> +        move(0, 0);
>> +
>> +    /* print header */
>> +    irqtop_printf(ctl, _("irqtop | total: %ld delta: %ld | %s | %s\n\n"),
>>                  stat->total_irq, stat->delta_irq, ctl->hostname, timestr);
>>   +
>>       /* print cpus table or not by -c option */
>>       if (cpus) {
>>           scols_print_table_to_string(cpus, &data);
>> -        wprintw(ctl->win, "%s\n\n", data);
>> +        irqtop_printf(ctl, "%s\n\n", data);
>>           free(data);
>>       }
>>   @@ -149,13 +164,15 @@ static int update_screen(struct irqtop_ctl *ctl, struct irq_output *out)
>>       if (p) {
>>           /* print header in reverse mode */
>>           *p = '\0';
>> -        attron(A_REVERSE);
>> -        wprintw(ctl->win, "%s\n", data);
>> -        attroff(A_REVERSE);
>> +        if (!irqtop_batch_mode(ctl))
>> +            attron(A_REVERSE);
>> +        irqtop_printf(ctl, "%s\n", data);
>> +        if (!irqtop_batch_mode(ctl))
>> +            attroff(A_REVERSE);
>>           data = p + 1;
>>       }
>>   -    wprintw(ctl->win, "%s", data);
>> +    irqtop_printf(ctl, "%s\n", data);
>>       free(data0);
>>         /* clean up */
>> @@ -212,7 +229,8 @@ static int event_loop(struct irqtop_ctl *ctl, struct irq_output *out)
>>           err(EXIT_FAILURE, _("epoll_ctl failed"));
>>         retval |= update_screen(ctl, out);
>> -    refresh();
>> +    if (!irqtop_batch_mode(ctl))
>> +        refresh();
>>         while (!ctl->request_exit) {
>>           const ssize_t nr_events = epoll_wait(efd, events, MAX_EVENTS, -1);
>> @@ -227,10 +245,12 @@ static int event_loop(struct irqtop_ctl *ctl, struct irq_output *out)
>>                       continue;
>>                   }
>>                   if (siginfo.ssi_signo == SIGWINCH) {
>> -                    get_terminal_dimension(&ctl->cols, &ctl->rows);
>> +                    if (!irqtop_batch_mode(ctl)) {
>> +                        get_terminal_dimension(&ctl->cols, &ctl->rows);
>>   #if HAVE_RESIZETERM
>> -                    resizeterm(ctl->rows, ctl->cols);
>> +                        resizeterm(ctl->rows, ctl->cols);
>>   #endif
>> +                    }
>>                   }
>>                   else {
>>                       ctl->request_exit = 1;
>> @@ -245,7 +265,8 @@ static int event_loop(struct irqtop_ctl *ctl, struct irq_output *out)
>>               } else
>>                   abort();
>>               retval |= update_screen(ctl, out);
>> -            refresh();
>> +            if (!irqtop_batch_mode(ctl))
>> +                refresh();
>>           }
>>       }
>>       return retval;
>> @@ -260,6 +281,7 @@ static void __attribute__((__noreturn__)) usage(void)
>>       puts(_("Interactive utility to display kernel interrupt information."));
>>         fputs(USAGE_OPTIONS, stdout);
>> +    fputs(_(" -b, --batch batch mode\n"), stdout);
>>       fputs(_(" -c, --cpu-stat <mode> show per-cpu stat (auto, enable, disable)\n"), stdout);
>>       fputs(_(" -C, --cpu-list <list> specify cpus in list format\n"), stdout);
>>       fputs(_(" -d, --delay <secs>   delay updates\n"), stdout);
>> @@ -291,6 +313,7 @@ static void parse_args(    struct irqtop_ctl *ctl,
>>   {
>>       const char *outarg = NULL;
>>       static const struct option longopts[] = {
>> +        {"batch", no_argument, NULL, 'b'},
>>           {"cpu-stat", required_argument, NULL, 'c'},
>>           {"cpu-list", required_argument, NULL, 'C'},
>>           {"delay", required_argument, NULL, 'd'},
>> @@ -304,8 +327,11 @@ static void parse_args(    struct irqtop_ctl *ctl,
>>       };
>>       int o;
>>   -    while ((o = getopt_long(argc, argv, "c:C:d:o:s:St:hV", longopts, NULL)) != -1) {
>> +    while ((o = getopt_long(argc, argv, "bc:C:d:o:s:St:hV", longopts, NULL)) != -1) {
>>           switch (o) {
>> +        case 'b':
>> +            ctl->batch = true;
>> +            break;
>>           case 'c':
>>               if (!strcmp(optarg, "auto"))
>>                   ctl->cpustat_mode = IRQTOP_CPUSTAT_AUTO;
>> @@ -394,16 +420,18 @@ int main(int argc, char **argv)
>>         parse_args(&ctl, &out, argc, argv);
>>   -    is_tty = isatty(STDIN_FILENO);
>> -    if (is_tty && tcgetattr(STDIN_FILENO, &saved_tty) == -1)
>> -        fputs(_("terminal setting retrieval"), stdout);
>> +    if (ctl.batch == false) {
>> +        is_tty = isatty(STDIN_FILENO);
>> +        if (is_tty && tcgetattr(STDIN_FILENO, &saved_tty) == -1)
>> +            fputs(_("terminal setting retrieval"), stdout);
>>   -    ctl.win = initscr();
>> -    get_terminal_dimension(&ctl.cols, &ctl.rows);
>> +        ctl.win = initscr();
>> +        get_terminal_dimension(&ctl.cols, &ctl.rows);
>>   #if HAVE_RESIZETERM
>> -    resizeterm(ctl.rows, ctl.cols);
>> +        resizeterm(ctl.rows, ctl.cols);
>>   #endif
>> -    curs_set(0);
>> +        curs_set(0);
>> +    }
>>         ctl.hostname = xgethostname();
>>       event_loop(&ctl, &out);
>> @@ -412,10 +440,13 @@ int main(int argc, char **argv)
>>       free(ctl.hostname);
>>       cpuset_free(ctl.cpuset);
>>   -    if (is_tty)
>> -        tcsetattr(STDIN_FILENO, TCSAFLUSH, &saved_tty);
>> -    delwin(ctl.win);
>> -    endwin();
>> +    if (ctl.batch == false) {
>> +        if (is_tty)
>> +            tcsetattr(STDIN_FILENO, TCSAFLUSH, &saved_tty);
>> +
>> +        delwin(ctl.win);
>> +        endwin();
>> +    }
>>         return EXIT_SUCCESS;
>>   }
>

