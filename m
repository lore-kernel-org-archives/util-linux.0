Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA262528EB
	for <util-linux@vger.kernel.org>; Mon, 31 Mar 2025 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743433057; cv=fail; b=bub/IsJKpGeg4yUrIf6UJBmV030K98YtxG5fcwScZgAYspJG1/3tTaaDnoK+ANREwS1LmnEP4xIUVasljYt7s07oAPjcxfEktkOlrlqAGzadlOODREEGWaS/TYO1H9kkicv2guB327oojXTB8JDrjBy+CgtGBbFNql8ZHv7k04k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743433057; c=relaxed/simple;
	bh=XDy//Rwb9U48YiRkLBNNe1IIvVzpqC4q3KGm2sAeYyk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KqX4BTXzsty/jvHPLMffHJtG1//AkhtZrFhreFHqfMdcN4yIjv5y3zDpNmzfkeQvd60NbiXTYvQ+Trzp4x9g/hxOS6zknp3hQw+CcEiSpJRN3BdUZxNyWhX3ZXEE21rXy7uqKoO9RTKXxTAm9+ObgztsEX5jvQqDRfePWOVm7Wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f4dd2Mh5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nReqmsEF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f4dd2Mh5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nReqmsEF"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52VEC0fX013052;
	Mon, 31 Mar 2025 14:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ySvjtrg7vKJFIJYKkibZ2hc7/PFCV8T+LinIfxFOENg=; b=
	f4dd2Mh58Acx69YVpUrm+4D77vE4UOu7oScK8yO8Zg36+igZJHGGKiuMvoS1b0U+
	q6xq93djExr/OEcVh11AVCt3wFVr88oI8rfWWtW5Ikwwqj62YzBhr+64TdTJgtKq
	PsWFtBenJ/Bo9L4mTHJPUr59CrmxgHA/myi64plasBwdQpwzaUjbia4JTkG4Ninw
	4SV+TjW5+ITKWw3LVJ6uEw++mNPXshbTFljGTRo73zws5p5TTssvhzTToeCpRnLX
	4MHUNaOFSGK/4RBTSIVF56FKfprkOhRMJJMPQo4wEhnhslCoCAO0hKYkE726Hb9Z
	EcibBymoy6W0qmPjBaXltw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8fs3ecg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 14:57:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52VEUVTh033642;
	Mon, 31 Mar 2025 14:57:31 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45p7a80np8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 14:57:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ED3RDCsrRDhC3q+c2TSfJ/1lwsfVT/7T46/mLF+cPnbb56JHv3a82wwsiFVr44ajABzD3gBNDocWic3zCMtHujpvNiVr+vXeoSqidT6MyaTsI+TmxmuN1VCh5o08g87IU+qNQAx/faLlY4dtKAxRQ85Korj3aulE8ACNdzYdPOK8ybGCysX0JUSoqOxHmAvfcnNfXq/LnFXxKaPy+DnhniyIvayYqrFLiLD3um4K6WdHJHvPd7mgHkjoPYRc8s0FFWb72HnFOrJUfeTMzu0+xUelJSeuNGqj52ANeL+0Z/mnhtrR25hfAyz+7VUKCUf1ELfkhCC/npt0IXCIDWlrnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySvjtrg7vKJFIJYKkibZ2hc7/PFCV8T+LinIfxFOENg=;
 b=vgH6YubU409xojN3YzR6J5ZXYEC1sBS2Eag3cidtgIRWglZuMVSR9t7Ijy5knL67qB18zstWfVFY/cPO19Xpm8V/WTJL5cID+HsEZN+wtCJLXBrWehlU17Pt5yekPfWs/JulRzskf2wb/xWmoWaGz4vavCg2E6tfO1p8i69jVj9368QYlQNqkvBZlkIC0MMUTlzWiKtTiEHVDlg5FIDjyM7VMG/yuoKuUxJxMrbExN6UZToODEMYOk5fpKD6sazUNt/DWHgZVovtDQJZNegkFZarLueJsWjIv1b28WRuVA5NCXifSlr21Hr5hDV4QA4wDu4wYVRgfpUHMYLDfPaang==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySvjtrg7vKJFIJYKkibZ2hc7/PFCV8T+LinIfxFOENg=;
 b=nReqmsEFSozXD/UsTG+y+byJ8ybVYsP+QGTQPTePdMuSn9jffeaDItj0gCFnNkVY1YAsEKAUpf7cbjKGNOT51+KxTI5CkIDvh/C4Mu9iqkv6dMeIBrcopzm5bmTcgMCbvFUIWx4OCp8b6D98XVj27fWFWzxgnsotSHo5gL56cVE=
Received: from DS7PR10MB4944.namprd10.prod.outlook.com (2603:10b6:5:38d::15)
 by CH3PR10MB7714.namprd10.prod.outlook.com (2603:10b6:610:1ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.38; Mon, 31 Mar
 2025 14:57:29 +0000
Received: from DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5]) by DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5%3]) with mapi id 15.20.8583.038; Mon, 31 Mar 2025
 14:57:29 +0000
Message-ID: <53dc46c7-f793-4fcf-b6a5-eda5d22e2449@oracle.com>
Date: Mon, 31 Mar 2025 07:57:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] irqtop: improve the description of --batch, and
 align it with others
To: Benno Schulenberg <bensberg@telfort.nl>, util-linux@vger.kernel.org
References: <20250331094443.9619-1-bensberg@telfort.nl>
 <20250331094443.9619-4-bensberg@telfort.nl>
Content-Language: en-US
From: Joe Jin <joe.jin@oracle.com>
In-Reply-To: <20250331094443.9619-4-bensberg@telfort.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0096.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::11) To DS7PR10MB4944.namprd10.prod.outlook.com
 (2603:10b6:5:38d::15)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4944:EE_|CH3PR10MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: dbae9fd6-9fc7-4fd5-35fd-08dd70645b50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVB6dFd6djV3YURHNDhhbUNkYTdJdlR2UHBFTzNiOXBNUzFOZE9NK21BY1BY?=
 =?utf-8?B?aU9ZOWRzWi9jRmtwUjlNNGtraEwyaExTdVp4RFY5ZmRuMzBWOEw5N214UGV1?=
 =?utf-8?B?YnpRWkIrZnl6OEJhZ2lMWjFwWmRhckdvOVdZbVdKVk1NalV0SUtvN29zY244?=
 =?utf-8?B?L0hXRkJqMTdhZ2d4QmlSMzRHeDNHN29PbEQ1MllCaElGaVhsU2dwc2IyTVUz?=
 =?utf-8?B?Q0ZJVUpaTVhLbGU1Mzh2T3htZXBBOTB3ZFlmZS8vMGpiOS9abmVsS1lEbC9r?=
 =?utf-8?B?YXp5NXUzZThKL0tzZ2M3STBkajNvRUtyU2hWck9xVlFoSktQMWlrWFp0ZVFT?=
 =?utf-8?B?WXNGL3p1YzJYTHNwMVFKUjI0ZjR3VWJLeE9Md0ZTai9oZFZUNnp5L3ZZWnk5?=
 =?utf-8?B?R05SVldERnA2Qjl3Tk82SUg5MGJrWFU4N3R6Smtlb1VnOUkvUlZxdHJzMnNj?=
 =?utf-8?B?WDVaa3EyRDRTNkgyWllSa2Fkb3NraSt6Q0pvbUxTQUdDZ1VNZEUyNlhrUGk5?=
 =?utf-8?B?RURsQjFud25CRUdrNEFpT0ptQW05RkV3d3ZYdXUvVFZhNk1FSHA2YVk1am9x?=
 =?utf-8?B?OGh4SVJ4ZWdnUDRVREpXZkZ2U3NDdGVtU3pEczdya2NFTGc5dm1PbjFVUmgx?=
 =?utf-8?B?Z0F0TlU0WG1DVi9DVEU3WFBuWlNwYzhEN2pxbGJab1prRVJ3eGlJK3VYSS8x?=
 =?utf-8?B?QWI2NHB4WnZKTFhYeVJBVWpSK21RQjRObzBDbUpBd0tIRzdwRWhORGhZTUxJ?=
 =?utf-8?B?ajlzb1FmWHRCL21JSVVxU1JtWWlpY08zSDAwOWtLd3JOTmZ0WUxUOEltSEo5?=
 =?utf-8?B?NWUwNHZUTkNnUEQ3SzRhR094N2tpTUw0eTJHeUdGLzRNdXFtcWU0V3lMY2hW?=
 =?utf-8?B?K1RhMlE4WXNVS1U4UzE2cFdOaEkrWHIrMzdsY1NDcnZKK0dhTEk1bndIY0Z6?=
 =?utf-8?B?c2lCRytzcXRMTjcvM24vOFhqcldvUmMzWlZYcjk3bmV3ckFZY3k1RzU4WmtH?=
 =?utf-8?B?TzRtVjRONWhidVU3dmFJb0Y0YS9BS1NWNUh3NC9zYnhuL2hHY2xjcklIVFhZ?=
 =?utf-8?B?elpoTTAzb1JxZDlKZ0RUZUsxTWZWNmxqMkcyUmpHVjYyRkU3cmR3N3lrV3Ar?=
 =?utf-8?B?RDFmTWZRdHF2WVdhZTNHVjVjbjNKeW50VGUvUHZSb1NmV3JiYkpHMC9yQnlz?=
 =?utf-8?B?WjNwekZ6blFQbk5KelhFRk43QkkyTUk0WTRUd1Z2ekxZWVFvY1RZemZwM2RW?=
 =?utf-8?B?R0M4UGdTZm9ka0NONHo3ZE41YTZXTzlaYlhaUHBDdDRvajRNZFcyUnhBQmhL?=
 =?utf-8?B?THN0UW5tc2YyS0tBQlZtMTA2d0xCYnRDMlhYcGl1Y21YcTRUbWc2allSQzd6?=
 =?utf-8?B?V3piNmEzRWcxMWVkc3l2aUZVVVJjeFNwYWljakg5OTR5dVQ0ekwxM1FuRUxj?=
 =?utf-8?B?WFFvWFpyTmpnZHAwZG43UEZPYWw5ak1zMTRKcTRWVGlvM1BvQXhCRE1UcHFq?=
 =?utf-8?B?Si92SGRSVHdEZGR3TWpFTjNyRzNUY29TVDgyQjRuUzcwekpDalg1MVhoSTRj?=
 =?utf-8?B?MmEyVkRjc0NKWHkvM1dPdjNLcUpEWUlkaEhBMlZqbjludzEzNW92TjdTSHJF?=
 =?utf-8?B?RGVMcXJrbEtpSFpPN3F3TTFzNDlBV3VwS1VlZUp4SUxJcjFiMnVoaTE0Njgw?=
 =?utf-8?B?M2RTQ2hwVFJxRG9kVHFNNmU2MnlCYnNwUGVTM2txSzE5d0VxQkFrR0tjZG4v?=
 =?utf-8?B?RmVqZS96RWNRWFAxNTh1RlErdjVHd2hiWjNFME9mamxHcUp3aWMyRDZ6ZUhu?=
 =?utf-8?B?VUt5aTdDUldSS1BvSGM2VkJ0VS9scHhmb1FmS3hYekhpVE82TEhLRUxobm0x?=
 =?utf-8?Q?8slKaXR4mW7bW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4944.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVdwQW1IVUplSHRCMSt3Wms5YnNMUWZEMktjQWJOajJ1NHBNUnlXWkhFbGxN?=
 =?utf-8?B?SDNld3dpL1h6bFg1YU1CTktRWTFOd0JuWFk3RnpTaytmVlcwK3R1V1BISjdH?=
 =?utf-8?B?ZW13aGRnMmdXSnJ0TnJjN2lRUmlaaEJJOFVzUTBZODJSN2xvWjdrb0poeVlZ?=
 =?utf-8?B?VjRMTkZhN1BNM0ZwL082MTYxbVdWOEZjQXkzaEFVTkFVNkprUk5scjZTN0Y1?=
 =?utf-8?B?NHBBelA2bWVGd1dVOXBrc3NJMjFjOERxaVpzTDhESG5KbWt6eWF6czN3V3dh?=
 =?utf-8?B?aTMzc0Y0RnRwZXp2ejRwQmtySW1rbll1N3JXdXFXY2w2YlFNRHZDeEx2U0Qx?=
 =?utf-8?B?SU11MXV3M251WHFqc25iWlY0K1FlTFdJWVNxTmp0QmFoTjkvMDlrY1YxRlZD?=
 =?utf-8?B?eVl1aEc2b04zT3AyK0t6NzFyM3lRQjAwNEkva1QyWjFqWjJHRjZhN3ZQTzBG?=
 =?utf-8?B?OWh6V1dSYXhaVXliUEcvWjhLc01uTzl1U2Jta3ZwajlQZ25KZWQzSkUwY05p?=
 =?utf-8?B?S3RFbFZ6SHp0ZWVxR05qZHB6Tm1zNFVEU3dBYVZrV1lGZHNaNkNFYVJmQ2Mr?=
 =?utf-8?B?WXYySDZuQS95SUhTWDV4QjR6bnBIZzA4a0ZERkY2UWllSFhJM0tGS3JTRjZM?=
 =?utf-8?B?WGRhL3ovb1hKSmVFNVBLL3ZxRFBIWUE1ZCtRc0UrNElyWFZTT1cvSVhSSzBJ?=
 =?utf-8?B?emRrM2tnYjBDa1JBWG44Rk9jNjJUZHNUREJNR0Y5Y2tmYkM2MFZsVktGWnJS?=
 =?utf-8?B?SW9EaHNMQy9jb2t4QkErY29wTW9vQThvUjRZcEIwQ0RMSmtMK1FIcjkrajBq?=
 =?utf-8?B?bzR6VXZZUGlMck9sR3AxREV0VU5tOHI3VE80eFp4SnAvcEF5VXliZ1lrdHo2?=
 =?utf-8?B?TG5aZGl3U2YwdTlTV3Y3UFFEOGxMc3Y2eXdUU2IxbUlYRTk4SEM4SlRzTkRO?=
 =?utf-8?B?ZXFocHIxK0FhdGV1bTI4enJHNDcyN1RzLzBTNDF0ZEFmSk40RW9aMXpUeTVB?=
 =?utf-8?B?TWtoY0FWM3VpRG8wcGNiKzNSS3daSWtyMk14Y2JFeU4yTXFuN05aQU9SNGwz?=
 =?utf-8?B?Q3JXMEtTVU9Mb2p4Y1JqTWY0T05TeGVGaE5lUzFpTDZHNlRCVlloMzZlY0cw?=
 =?utf-8?B?V0ZCaEo5OG53VHRLZU50aTl1a0twMzM2b09BYThnOVpQVjl3UUZQRUM4TDRu?=
 =?utf-8?B?aXBRRzNEQkRaRUM2VE9IR25jT2cwOVVUR1NxRG1sNHZPRm4zdllkSGROZE0y?=
 =?utf-8?B?Yy9IYjR6bE9uek9lZjU0c0JzQ2dNL2ZpblY3SWtWTTJZaHV1a1VzTnVyL1k4?=
 =?utf-8?B?TkZVRUJ5R3RSdWFjVWU5b3lhaWo4M2lHTmZBM09BUkVOYXdlNHZ3YzFmSDBT?=
 =?utf-8?B?Tys1dGZZc3NCTjNYQjd2M0xqeXBPUEl6dGl6dE9HdDlxdlZubEJwbWIvYTJ4?=
 =?utf-8?B?RkhaaG9ReUVzU3p6dmtTYTl1WHBoZDU1ZU5Lb25RK096eC80Zlk1ci9rMFI2?=
 =?utf-8?B?SlZkVlAvRXJiY3hhU1doUzhNTGR6SXk5aEZudC85b1J6Z1grT3RIVzloRFZi?=
 =?utf-8?B?bzBZR3BzSTNOQ2ZNeGpjNUZqdDFpMVgxamhRMHR1aUZFL2tqV0VzM1RWQTF2?=
 =?utf-8?B?ZTRoQ1c0STROTnRmRjJrSFZIbHE4bkJwd0ttbE54bG5hanJqcnJZdU12c2JL?=
 =?utf-8?B?Ui9hNC8rZUo4UzdLTVVyZGhMa2tRQnFWZTdrU3BEa1JNa1RMZ1I3M0VDNUIz?=
 =?utf-8?B?UHA5VFFNMHd6WmFKVWpNREo2Mm5WWkFYME5BRjk0bGZaVnltOTdsTlBwWmg0?=
 =?utf-8?B?WmJkNHBiVE9tOTFEWGt0L21mbkVMeDl6bGpTQ3JZNWpwQmZ1S2RFMFY1NjV5?=
 =?utf-8?B?cmFqVWVZUGtLL1BhemExUU5HeThadTlKV2dsckxnOFY3WS9IN09QNFIvK0E5?=
 =?utf-8?B?eEJaQnBwQUpsQ2JJOHpPT092bFRncVVOS3I5eUdFVStBdE5uUXFra1VSTE8x?=
 =?utf-8?B?SWdUUnR1WGVHc0s5WXdiWEMrY1ZuNHlGelpMK3ZhWWJFeGNLNWU5dG1zQ2px?=
 =?utf-8?B?Z0R3THl1T2szRjlXc0kvNGFTWDZESFZCakdBaysvZHBPUUhReVlwQmt4MFVu?=
 =?utf-8?Q?hbeYPQWifczOAuDB6SpSVXve3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gn7156AkVbJil6fhlr2tV75ED9lu25axXuG481ttwoqfgnysP9Tg/579hsvcNWg02jxx51u4pJ0etHJ7IGnOKXZ1EU3N1uulUIZBFAs1qnxH8n6SiH770f0Q3SOpH6JGOVP3kAvNmQDbp5rXK+GxJxAYv50sezwZz+iiybUU6N1OMc3d3bLXwpUsD8E1fH6hly+UmJeDGkRUSYcMCJkjoIriXVDdMREH5xDX2ZWptPZtcdVsC48vjRexXyK+l4jHWbIOgCCuv+HBUmMpu9ZtuqHwnbz9C+ODeHgygNDWQyDMSHvsn52LkjqgVZixLSMCR7PMzwXbv3Ok/CfA9/q0KnZu75SRU6IJEZqMvsTEtL4XCZt5vwlETEpnmhVG4KAEg30aTqtnMR+NcbGPlq6g2nYA/NQwV1CchyTDm1l7+u40aZB4BboTnk267u3CKdtOL343LBqgiRHNU8UleXVevR4vyV7Qe9l11RJamoUNrXKT7eiIa8ac5I1ZrNsX0kBuyx2ASSg8kBAULtdojnI/2jlFqfYeBFHuht5z21cQt5F9CGgHrxocmnxmWcHxoasB19PbzHPwF0J35chtTYhgasBg1TjYjWGgyDMyqaaUS9U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbae9fd6-9fc7-4fd5-35fd-08dd70645b50
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4944.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 14:57:28.9688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0hNPbpER6trd2lZvRO3DoZM8MxnR3W9WL4+Uftt8ZKKXrvZQ2UbJAEmE5oikCDa7DDxKVSGr2cQ1a8xQgjGXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7714
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_06,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503310106
X-Proofpoint-ORIG-GUID: gE-MPx5oUw6hMp2MIJcbsO1kwdUEWBy7
X-Proofpoint-GUID: gE-MPx5oUw6hMp2MIJcbsO1kwdUEWBy7

Change looks good to me.
Reviewed-by: Joe Jin <joe.jin@oracle.com>

Thanks,
Joe

On 3/31/25 02:44, Benno Schulenberg wrote:
> Also improve the description of --delay and tweak the one of --json,
> and align both descriptions with the preceding ones.
>
> CC: Joe Jin <joe.jin@oracle.com>
> Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
> ---
>  sys-utils/irqtop.1.adoc | 7 ++++---
>  sys-utils/irqtop.c      | 6 +++---
>  2 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/sys-utils/irqtop.1.adoc b/sys-utils/irqtop.1.adoc
> index 880ee1906..04158a0ef 100644
> --- a/sys-utils/irqtop.1.adoc
> +++ b/sys-utils/irqtop.1.adoc
> @@ -26,7 +26,8 @@ The default output is subject to change. So whenever possible, you should avoid
>  Specify which output columns to print. Use *--help* to get a list of all supported columns. The default list of columns may be extended if list is specified in the format _+list_.
>  
>  *-b*, *--batch*::
> -Starts irqtop in batch mode, which could be useful for sending output to other programs or to a file.
> +Send the produced tables to stdout instead of to a static screen.
> +This can be used for sending the output to other programs or to a file.
>  
>  *-c*, *--cpu-stat* _mode_::
>  Show per-cpu statistics by specified mode. Available modes are: *auto*, *enable*, *disable*. The default option *auto* detects the width of window, then shows the per-cpu statistics if the width of window is large enough to show a full line of statistics.
> @@ -35,10 +36,10 @@ Show per-cpu statistics by specified mode. Available modes are: *auto*, *enable*
>  Specify cpus in list format to show.
>  
>  *-d*, *--delay* _seconds_::
> -Update interrupt output every _seconds_ intervals.
> +Update the tables every this number of seconds.
>  
>  *-J*, *--json*::
> -Use JSON output format. irqtop will run in batch mode.
> +Use JSON output format. Implies *--batch*.
>  
>  *-n*, *--iter* _number_::
>  Specifies the maximum iterations before quitting.
> diff --git a/sys-utils/irqtop.c b/sys-utils/irqtop.c
> index 751e9e19b..e0abddd82 100644
> --- a/sys-utils/irqtop.c
> +++ b/sys-utils/irqtop.c
> @@ -306,11 +306,11 @@ static void __attribute__((__noreturn__)) usage(void)
>  	puts(_("Interactive utility to display kernel interrupt information."));
>  
>  	fputs(USAGE_OPTIONS, stdout);
> -	fputs(_(" -b, --batch batch mode\n"), stdout);
> +	fputs(_(" -b, --batch           send tables to stdout, not to a static screen\n"), stdout);
>  	fputs(_(" -c, --cpu-stat <mode> show per-cpu stat (auto, enable, disable)\n"), stdout);
>  	fputs(_(" -C, --cpu-list <list> specify cpus in list format\n"), stdout);
> -	fputs(_(" -d, --delay <secs>   delay updates\n"), stdout);
> -	fputs(_(" -J, --json  use JSON output format (will run in batch mode)\n"), stdout);
> +	fputs(_(" -d, --delay <secs>    wait this number of seconds between updates\n"), stdout);
> +	fputs(_(" -J, --json            use JSON output format (implies --batch)\n"), stdout);
>  	fputs(_(" -n, --iter <number>  the maximum number of iterations\n"), stdout);
>  	fputs(_(" -o, --output <list>  define which output columns to use\n"), stdout);
>  	fputs(_(" -s, --sort <column>  specify sort column\n"), stdout);

