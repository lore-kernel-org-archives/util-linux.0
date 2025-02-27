Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA4F1E3DD7
	for <util-linux@vger.kernel.org>; Thu, 27 Feb 2025 19:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740685760; cv=fail; b=H/QBBexUd1ARwkaaIqbW32ttGq0IqOIHhIzkTguzCdyxcmiUQwBDfBmguj97cgdKLVjSvHDfam6Ll5f7K6YG+aV3SbgpPcjoqM1915/4J0mX5ciQ++OlSzoLCWIqZK4b+bCzM32VNuoPsFjGBtUeUsQPUSD8O3ijeZmF7c5aX0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740685760; c=relaxed/simple;
	bh=eFUkqniH+hS4F+Cp0Loo1TfmlSXe6zioZBg8I8Vh2ds=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oBanujcCMrbAfcHt/mC0LORWeJtRn0cAn2rFz19O36KawoIe4Pdg8DVZgIjYN5gouao91l3Ua0y0nNbRrUHm59vFuK7MWJa+F1y0RpYoho2Ub3yktBtjM56wqkJpTLxXoSCt/eVTqBFkw2bbJP27NLzKWZZgi1YCW+xqUZUDXCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mVUlI8WO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RYvqc2zH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mVUlI8WO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RYvqc2zH"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RJiZaM019261;
	Thu, 27 Feb 2025 19:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2CeCO9q09MMLj3HZGKZvAVAin8eZRWneyzWulCkOOYI=; b=
	mVUlI8WOdEicBn7Z+nCQi6cvYlreT4vkHqKA+4vCkBv5oIRb8dmUIlKzzMa6pTAi
	/t7oWrNaCM3rW+2JcQ72+WAAZWOxK0G79EJINnkVilLKsrV6Js/llbi9IT8Sl+n5
	20DQ3z8MVCboggcgSB6r4pRkutezE+D9n/NWuoBeNjzNZGEulMBojat3dDZVtH8A
	L31OipHRnzTvlShDHjyPmwlAsUeX+/c+AY1ze8GI0hEF/FbMssM3lXbMUDfftx5G
	P8zoSLO2pirLvYZZ8RjLLNARlzOmBZj7uWP1/vTcq8KZ+fXBRqJMEum7gIeBEN0y
	py8JmSsdznlzktiMQX7crg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psf48jj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 19:49:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51RJHgsY012657;
	Thu, 27 Feb 2025 19:49:07 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51dun2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 19:49:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6+BPCFF/6dS964FUXIkm3c4mD+DCW6UUKppl7FjRuOsP3Ql8OqqtyCcv4pOHrRyuHuM/iAfjFp+r5aQuely1V+vkAIq+YrmKhSZVLWkVFFF1J1xLOaxs8afmqXqyT23XQKCrpP7jeFrFR0Tr56+NLmQGcCk0kaqoCEPbEtnwGdg2y233zpPGauSKfUppyjVMX9MKRzOph+Kr3p1KZ68eIZy3x/WKeZDc7m5hinlsFLZsw6JLvvEj+l/QLEHTRPKVjJ1ia8xBwSBDa62yFR0G4huGhaqxuYSyPuDoQr8+X3fxp1y0y1Avd4LaUIatXUo+aUhygEFPVP8lr1x0YppQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CeCO9q09MMLj3HZGKZvAVAin8eZRWneyzWulCkOOYI=;
 b=MJcRbEst0K0OHSbPHL25p8czPtnenYF1WxSTDulp+Lst8JZU+GNzK49eLPXDF9sA0GPag0+SdkFHiKJejAwlZyC2EyuhRlZxpqY255ukYUUy9dzmldDcPnFI6CDwghNpHL/C1ocMdemao/6brWVxjlA4euGz4bNMNswUgRroWCcrzExg3gzpLeMRshp3S8jBIL28CiKcYFostQkvejm0tq2veZNuE9Xvyu7YF8vYP9GabVvUBAkZrtshmJ/s72o5u0s6eiZDgVxkmnNuxAVnTO/0uHtpgiX0USaC8kYNYbkSqq/EQjZq/fs7I7g2MX+AASfnzq1FkyfHoGRy5fmZDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CeCO9q09MMLj3HZGKZvAVAin8eZRWneyzWulCkOOYI=;
 b=RYvqc2zHt+Q5DpFVKo/miU1oYCyxPFx+Me0sC6Gf5c7mzqvDYPQPMl9KjWWe3RRuxX4VM9gmNGaTHTWA5cNS58upJkztpU9lku2oQdn686td+rlaRH8Jyrnb+LYpr1xuMrhDiPOcUfInMspiXIlTp/pmL2wmBUK8MWCaMjRf/RI=
Received: from BLAPR10MB4931.namprd10.prod.outlook.com (2603:10b6:208:331::6)
 by IA1PR10MB7264.namprd10.prod.outlook.com (2603:10b6:208:3fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Thu, 27 Feb
 2025 19:49:04 +0000
Received: from BLAPR10MB4931.namprd10.prod.outlook.com
 ([fe80::2ec9:a98e:942c:3cbf]) by BLAPR10MB4931.namprd10.prod.outlook.com
 ([fe80::2ec9:a98e:942c:3cbf%7]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 19:49:04 +0000
Message-ID: <05a9f610-b983-44f7-a385-daeef089737e@oracle.com>
Date: Thu, 27 Feb 2025 11:49:02 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] irqtop,lsirq: Miscellaneous enhancements
To: kerolasa@gmail.com
Cc: Karel Zak <kzak@redhat.com>, Zhenwei Pi <pizhenwei@bytedance.com>,
        util-linux@vger.kernel.org
References: <20250227044916.89925-1-joe.jin@oracle.com>
 <CAG27Bk0tKeqnPbpuZ27aqd=2q7sx8yt263Mdq-3jock0ePymVg@mail.gmail.com>
Content-Language: en-US
From: Joe Jin <joe.jin@oracle.com>
In-Reply-To: <CAG27Bk0tKeqnPbpuZ27aqd=2q7sx8yt263Mdq-3jock0ePymVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:208:d4::49) To BLAPR10MB4931.namprd10.prod.outlook.com
 (2603:10b6:208:331::6)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4931:EE_|IA1PR10MB7264:EE_
X-MS-Office365-Filtering-Correlation-Id: f94ea331-61d8-4234-f845-08dd5767ca7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlBQRFhkR3U2Z28xYzc0bitTSEV3bGNad1ZLTVVKalVCaUxlQy9WVDNyVkdM?=
 =?utf-8?B?dDU4MHlwTUFEVVU1VldzdjI1LzdzNzlGUWJtZGZXUjhsNW1DbXA3eFFGbGJr?=
 =?utf-8?B?ZEluTUE4eGw5OEh3cGx1QkNuK3RrSjh3N01mWkFCSU1SZWdGOUVOMVVLUmJK?=
 =?utf-8?B?bFlaM0tmakhJWmZaMjFodFRXMFpjbnpuRFFwZDNmODVnaGo2S29JL2N2MVFD?=
 =?utf-8?B?YzJaM0NaM2VRZmc2bEYvVzVzUkpFYnVvRzQwYTdBUWlvN0Y0S1BnNG44eno1?=
 =?utf-8?B?MmZ5YkhqSC9RRCtYVDJVK0orUnQ1TDk5a1IrdnZLd29rU0ltTUo2ME9WeVYv?=
 =?utf-8?B?NEZrRHpHTmFod3NiWUUydHNJMUtyS2JHS3AxeTJHUWFpODVPVkMvL3BaR0Nh?=
 =?utf-8?B?eE9iZy9Cd056bUpYMHdwWHhTcE5IQUlCRTA2dGtRbGlqZ2ppdDE0eXQvMGd4?=
 =?utf-8?B?ekhaRXJGNDVza085eUg2V29vSUsvZ2dRbXEzUUtNS3VBUGdWWW0rS2pLb2hB?=
 =?utf-8?B?MjJvV2dPTS9PK2pSQVRpa0hIZFdheWJKRnRkOFdoc0lOWTVQdzhsNlhsL0w0?=
 =?utf-8?B?VDY5Nzl5ekRYWjlCZmk2VEcwNWxRRnYyTUxqaEdmTFZ6c0NkTDhlTGllenN2?=
 =?utf-8?B?a3k1cTNNZnY1STVPcmRoUVV1dnBWdUxFcGpxOXhndlcxUzFleVkxNnFxSEdz?=
 =?utf-8?B?eUd0VjVZYTFCWHhheXc0cklQaVo0R01jWUptdTdGQ0F0cXp2QUhpNjhYR1pW?=
 =?utf-8?B?eDRMUk1RYlhBUjN4Sk5LYWIwZ0xiTFVxRTQydzNzWDd6VDRJWStzcXl3VFpN?=
 =?utf-8?B?WS83SU80ekxLaTQ3L2h1UjhIZER2ME83YXozMzRmSFUvaHdGZVA5bjdmSjJN?=
 =?utf-8?B?cjBMbnAzRVViNUw5QklXYVBOS08wS0pYZXZUVlE3K0loajIvelQ3bEtUbVBV?=
 =?utf-8?B?TDBkMUhxUXF6Qng3L3VxU01QMnYxdVBWazlQSExQeWtndldIUEt5M3E5TWN1?=
 =?utf-8?B?b2E0QzQvbGkzTXd6bDdEaW9ZYTJIRHZURVhabDJWa05lZVdrWWUxdGtycTdM?=
 =?utf-8?B?TjkwZEMxbXVCZnBtZVFxR3VSRlYvazhaUk1adG1lOFNYUEVLczdHYVBsMVN1?=
 =?utf-8?B?M2pIMFl1RXltRml1SlB2dENrMnNXS1ZYV1ozbXFpQnQ3VHJuUkprVFNvdjlm?=
 =?utf-8?B?YzRuNTNkbkZjdmhTem9pNndDM2xpWXhLTE80Tk9UZ1VtdjdvamZyY1l3VUxS?=
 =?utf-8?B?RTNBS3h3TWV2YVlrWE9iTEkyNmRCQVpNVmVOOEtIRW9rUTRvNWxlVldxNGJj?=
 =?utf-8?B?aFFHcHlyeHM4YkNFaWVESVJhM1JlY2tLQiszOTJseG85MklLZG43ZHYwWExp?=
 =?utf-8?B?d1FFS0gxZjhyWVdKdSszQ2VxVUs2Q2JqcERscWtOWlBFNVFteVZSRmVGOFVD?=
 =?utf-8?B?THdvcHdTeFhqOUNsdTA3Z3pxcE9ueXBMNHRnNmxad0syVVNrLzVhTU5DbWVm?=
 =?utf-8?B?OXNnS2hNY2Y2b2V3eHRncnd5R3dZUzh5Y3pEditJUTVIZGh6eWpOb3N3TGRx?=
 =?utf-8?B?U21JYlZLWmwxcUhxQjhUeVpXc0ozNU1xM29FN0JwUEJOTnVWQmF3bnU3Qk9y?=
 =?utf-8?B?eU5OWng5MzRJY29kZmFmYlZrcnpVc1g4N3ZuYnZrbERJSEFHMkR2enE3a080?=
 =?utf-8?B?Z1BGcVlUMFpJbUtsNytvYkllKzV2Um9PM2ZiRXlQc0NBckh2Y0ZQdjk3cVdF?=
 =?utf-8?B?YUdjcXNCSmFzRkJvMTg2djNqNE5ubjVXdDRzWEcvN090ZjQvSStpa1Y3OHl1?=
 =?utf-8?B?QldTNHlEOXZTQm9sZzJURkt6eWRUWURPckNVbXkweE5IaEdQb212eU11Y09y?=
 =?utf-8?Q?e2IFfdx7RvkrA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4931.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlU5NXNtWlllUGEyNmROOWZjbXVWMmtCSVNMM2FMa3dSY2U2ODBTdUZMMDhJ?=
 =?utf-8?B?U1FNc2VBbEsrS1NuV0FBVkFHc29nV0FUa2pLL3pBclRDUnF5N3FwM0pONkpQ?=
 =?utf-8?B?M3p4d3Vob1BMNWh0cGd2aU8yMTNTUUk2bllrOHhPdVk5NS93V2xkb2pLclhC?=
 =?utf-8?B?a3I4bGVZWUUxeW41blpPbHMwNnhFMzhvV01zL2dIWE9ON1pXTml6SlRtb3Bx?=
 =?utf-8?B?S0x6KzM4cExadWtyUmVXeEduQXZyUE8zbXkrQjY3S096aWJ1cHE5c3V3V0cv?=
 =?utf-8?B?T0JWU0dTNXArNEkyeE1LNEFvMTVobEM0U3BJMXdIWGV0NVhMa252VU45RHBa?=
 =?utf-8?B?ZjFTM3RJM2xTeUtBK09jOER3RFpVc1F3UTJoWlR4STV3QWg1MW1RZitCNUQ4?=
 =?utf-8?B?dlZqSWlMMmY4Q3hpUXl2ZFVWeU9TbjIxR2dlWHphamdNY0wrQzdNRm1qSTly?=
 =?utf-8?B?cVEyTjdGOEZtWVo2QjhSSTNtSlpkQ2YwSXBzeUVxUVpCWUx6QjZhV1c3Tkpo?=
 =?utf-8?B?ZEJyUlE2RHZZa2Rzd2VqOE5JZ3VybC9Lc2hiQlNacW9ZMCttd0NHdzdPMUMr?=
 =?utf-8?B?WkJkL1cxVnJqTDYrc21yMmdmMDJQcG1aTTdqeU1hV3ZlcGdCQU1aYTdaS1U5?=
 =?utf-8?B?UytJSXN5d1Z0c2FsMjZ4MUNDc29XYXoramhpQmdQVjhvY0NNSW5pSHNIN2Y5?=
 =?utf-8?B?dDFWSXRFZ3U0ZkhocU5BVzV1OS81Vk54M29zNm5vOVBCbTFaV215Rmp6Witj?=
 =?utf-8?B?YlZHbFY4VTUrVmR5bFoxekhhd1BTekNDZVl5OXQ0NzNqcVFMYzNQQ0tUclRy?=
 =?utf-8?B?c3FzTVdlcDBDcXJLYTh2c05ucEtHZW1zOXYybzVCdlM4SmxORk1OWkVKVjNn?=
 =?utf-8?B?NFBTNnJYbGVaWXFka24zUUhNSjh3QUd3ZjdkSTU5NjZOazVseDJIdVJnclJ6?=
 =?utf-8?B?bXBGa2JSdjRtYVRjYTY5OUFqa1MvNmtxYUQxTElLblRGb0xweVdXNkthb3dZ?=
 =?utf-8?B?dEVSSDhJM2Z5aFNRUVJiZGRzdDZtU0s2T2l5ZjNOUGViTUJWMmNCSkdtU09k?=
 =?utf-8?B?NXVVOC9hY2JWRm5QVkg2b2Fhdmd2c0U3Y1RQWjYyZGlEWjlzemFFVUNFekNx?=
 =?utf-8?B?UTNyWDhKU3BIeEhpTElxbitlVHZ4eHkyK2NOU0JET1QzTHYzNlhHVWkyMi9J?=
 =?utf-8?B?QTZKMmtZUkhDYTBKR3hIaFgrTTRrakpTV0ZmNzZHdXEySnlvSmh6WWhWZVpW?=
 =?utf-8?B?cTd4NkFLWVZBcGc0b3BUTE9kZXhjY2ZoUmR1UytpUlp1TWYzRVhTTnhSeE0y?=
 =?utf-8?B?SnlxM3FyZjFHK1preWIwRUl0Q1BRclE4WUM0eUVCbm4vNDVqUTV6S1pUTVFv?=
 =?utf-8?B?YUhyNjBldGdVckl2U2VXcTlnNkZpUGhmQkNVbHFOcUppNUkwRU1QaXBCRFJM?=
 =?utf-8?B?WkpTTjI3RHYrUEdVaVNHcktJd2Q2NnRSd2U0NlNneFdCZ1FaTmxLekV2Y1g0?=
 =?utf-8?B?K2F3RnlSdEdUbUJFZTRBenRBV3BuSmgvQnNDalBTYVdjQW9TNjNRUTJWK3cz?=
 =?utf-8?B?UlpySmxDZisyK2dMOTFRUXhpR1ArY2QzVDdTbmlDZXZhWnJ5dmIxdytTUFBv?=
 =?utf-8?B?Z2ZhdCtoSlZLOE5YYVdoamYycEZyZkVWeTh6bTJLTFIyNWVaRXgybW02cmJY?=
 =?utf-8?B?WElZSXJWc2lJNGt3MThJUmFFb21vM0Fmd2RBaUpEazJYYktHdytIaENCMTVX?=
 =?utf-8?B?ZW05Tk5vNXVSa1lIM3N2RFBRa0JxTkRTWjNjWkwxVGFVOWdHSzhlZitZZ1Z4?=
 =?utf-8?B?aUFiWU9NZmFlVEFUNjI5Q0QzT1RDMUVWMkFsWFNLRkRLL2dCRjJUaHVBM0k0?=
 =?utf-8?B?TnpLcTVHb0VTNjA1b0s3L1VzNGMxSkpqR3VkclZOWVhpK2JPZnQvNmZ3NTVN?=
 =?utf-8?B?ejEyTnl5MHkxSy8wUXliVU82QTJaNXo4c015UmwvNXBweUZCQ1lFSnVFbnh6?=
 =?utf-8?B?YmgybklVaURGUXgyakZINFdNSi9iQ2p5OUxhbzUwYmZSV2EwVkxtYXF2T29q?=
 =?utf-8?B?UWwvanZPZW9zbnVENVZ6bTZvbFZjdzkxdkRzbmE2Q0Nuc284V0dScUpnOFZW?=
 =?utf-8?Q?rb8DgTAcUswKh5v9sOO2puRwp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	49X5dIe8e507lVkNW1fTj/q30s8fgSQnJzpZ3jn4D7qPKKW94DOHImnCTv0Ssr5Yk6npE0gHENMuUGY4K33ys0GoVd0RJ33xPllXMhzm9nfx2P0zO0eCCp1xbr/YHeoT23p/Yigya+d7rkkqOKnffPoMhDcPpDK+oxtCGEY56T4F1XTuHs6oEmJO0QfcT+GPoUc0eOgwS9bS0hEjJRP5mm7CF8FACvAF0rL4/tk+TU3dQtdo6WAmSbdlc/rkbc/EiTRIX8ymKfhS+ZYY976SZwX4wOgmcREEWqIxYG9+TMlFhPNaI0mHfvNo7gYjdcrKtk8WdUH00a6KTlu4TnFR7s5QW/ZGDa8fpwgnIyWTi6Sxhf6STciByJK04/kaYp8d27YJw4yuiKTTImfrZat2uEEELpszs7Bc68mZifLhHM2quRFFirvDGt285697KWU0IAkVA/N6mwwaZlWTN2UZi+Zhy8dyM4n2L4Uhe6T4Mg27wwEx3ZqDH/iOfg8Ch0cdzsbUQUR8K63sUtt5eYMQmpOttwSa1mBuYP4wORIJgNNRwgcaJHzflbr7PtH1kS+Gy2vvGbPmwtbPFNs2+uzw5EWYwRPqLtA4o4mNIGVasjs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f94ea331-61d8-4234-f845-08dd5767ca7b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4931.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 19:49:04.8776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0uTHWqGj/uxojwdc6KmqgU/UFFFLEL9efwZuWLBey1F6xq8JnZoq8odIvf3L4uzi5KDTuY+ZkQy2LVzh9KioMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7264
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_07,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=927 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502270147
X-Proofpoint-ORIG-GUID: bQ_gTanEGlgJHqd1BX23FEM2EnUKVjAz
X-Proofpoint-GUID: bQ_gTanEGlgJHqd1BX23FEM2EnUKVjAz

On 2/26/25 23:36, Sami Kerola wrote:
> On Thu, 27 Feb 2025 at 04:49, Joe Jin <joe.jin@oracle.com> wrote:
>> This patchset add below new options:
>>  '-b|--batch' : Batch mode
>>  '-n|--number': specifies the maximum number of iterations
>>  '-i|--input' : Read data from file
> Thanks for contribution,
>
> If batch mode is added the tool should also gain --json option for
> structured output.

Will add new option for json output format support.

Thanks,
Joe
>

