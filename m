Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173A554673
	for <util-linux@vger.kernel.org>; Fri,  7 Mar 2025 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741361447; cv=fail; b=i1NyLRpLTLPUGoC43rhHYOtOGEmJTMm/4AkGU2V4vbqprQSsMwL4mGvgPKqnCNEvSrQRq3CdfY+J0a6YGKFJfJaqBViQIR8+Ycllh/RukTXp4nyk10jU245qBO4n+Dp2UfJY7Y7UBeJXqKSJbmFldv/qefhFOYTy2byxKd3k3Bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741361447; c=relaxed/simple;
	bh=Q9lek6lzsHYqcIefW+onTGtli60OlcgyzCX4/IURbhs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mNawd+inbgJY+GozjiO1ZWWrMn6mOPhTzcN0n1XSARf+3qVWg3ZwioIGBr49FQnzZOEBiVl53xOLd3yQIw7X8sbSpWIWVoVJna36FJj4WhCy+BJqndnz9MOt8/YaaIU8FoKQMuPLwnFGGrX8VJeV9TPgk3nxOQrkfIn8IuMo77M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N7psiUgJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HvwOABXD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N7psiUgJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HvwOABXD"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527EOGxR029923;
	Fri, 7 Mar 2025 15:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Q9lek6lzsHYqcIefW+onTGtli60OlcgyzCX4/IURbhs=; b=
	N7psiUgJI5utLbDW7J1b9V1+OxCnRuYOvGojFF0Z+Pdd01kAMuWUp+mxXzjMfO0n
	oSKPmFkiCV2ADFEjmI4WiqdjSDzoPLqWqeZ7WkY/MgyVRATVHZt8vAZWWgazm4X4
	xmuIOAxFVGNoqdkWXlilFh0BQpLYVm1Gquc5mYHOF5bhVaiAmj5XctgVcHV6uAX0
	eFAtwcVbYNkhIKOuAI0zbrYHtlsjq2ek4cGXbtzlEVBIXIxH5hREyqfaT+qpC9kg
	C/HldUlLlv65zGBBsUrqxn8X61Hnbpd9LFqrkM4QlUmkC5CFWpJSbh/jlDa2ofvV
	GOQVOwsADyck94oOqLASOg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u9qmmdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 15:30:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 527FA2lv003191;
	Fri, 7 Mar 2025 15:30:41 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpdnsse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 15:30:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khCdCsVrYltOWe+AEPonC7hlp2t0fVCvgLSNs9NsuRzoo6IurTYLmUGGZwE3W/Jl22kTN0PnT1qvtsUiFgfKIjsrvu5eetYkPOmne9a34ydQV92uMHUBpB2f5T+ziNuw7UDixyS/ddn/Hw8nPXnomlCQ36yMTWsxUx+Glmw8QLt1aVcB+eOWJBH3NaTVciHtNdhjC71Dh2mqb5ZxrnOJO7KI+ceHTsEpxw4s9GRRnEygCcotG6xLCtMU8Ad2Usf97rSWKTjull75oslAFJ5SrVXFLtpVBUHTapTYDJVbY7jRf8q+nENDT4RXHI4bwqJ7pBL+o5o5SsCnXHsvofNipA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9lek6lzsHYqcIefW+onTGtli60OlcgyzCX4/IURbhs=;
 b=d6p/+yd313QGz0von461h+IDn0ek9XCPwNvBTfXMCegSOsSiZEG7DqqId77W17OxSIHwc6vDlL8aL9ZoHjUILN1d7F7h5f3jG+j4Ikl73dcYst+KOfsjnHRu94KmVD2DNCF21zXaZYJMS2e2udj/wl+sRmaBhrewRakhoqRn9QJ7+U+dEvyfdOtxvF5J7U5JG+9F1E2Fat1p3YzU0f4bggbcCp3YP5wgCh8ttF1BW0eqTDyrpcgudYlNHqUQbCZfaN0C5+YT9j91jY9ydgLZT1JJHjeE3tGY1YhPuwo67E3uHigq0ti1gGOrMqcg7+FoBTwhRTKuRQ6gDyFHiVuXJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9lek6lzsHYqcIefW+onTGtli60OlcgyzCX4/IURbhs=;
 b=HvwOABXDuJkJPLddyemfj5YRRnJ+2CssUoT7tgHwsbtx3VeUiEaEbbHez79v7Cl+OZjdOhhcntcxB2RBXdoHLd71+G57mwIe2Hzy+0xII3L5hiUCaug8I81NZADAAx9m6WcTn43Qs0+STYT3Ox63AAy94EbtL6Qe5U/3teL/kGA=
Received: from DS7PR10MB4944.namprd10.prod.outlook.com (2603:10b6:5:38d::15)
 by SA2PR10MB4410.namprd10.prod.outlook.com (2603:10b6:806:fb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 15:30:39 +0000
Received: from DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5]) by DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5%3]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 15:30:39 +0000
Message-ID: <a40d0051-42cd-4edf-9e4b-a942a443518a@oracle.com>
Date: Fri, 7 Mar 2025 07:30:38 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] irqtop: add filter support
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
References: <20250307025201.92541-1-joe.jin@oracle.com>
 <20250307025201.92541-3-joe.jin@oracle.com>
 <c64a9a6a-8f8e-44d5-9ceb-f9dab99a3ad7@telfort.nl>
Content-Language: en-US
From: Joe Jin <joe.jin@oracle.com>
In-Reply-To: <c64a9a6a-8f8e-44d5-9ceb-f9dab99a3ad7@telfort.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:a03:331::7) To DS7PR10MB4944.namprd10.prod.outlook.com
 (2603:10b6:5:38d::15)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4944:EE_|SA2PR10MB4410:EE_
X-MS-Office365-Filtering-Correlation-Id: cd7deae9-9cfb-42cf-854b-08dd5d8d03de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2FzRC91ZGdUaUtab25GRjljOXBLZURpcU1qbWhzSFBYakxFcTJkLzB3RStn?=
 =?utf-8?B?dU9pTnc2VisvZkF0TnIxakVYcmF3Ty81T1RROGRhdXAxZXcvcVdTNHJMMWZ3?=
 =?utf-8?B?SzhXS0U5Vk92a2h3VUIyMkNuNjVody94T2Uvb3k5MkFLRzd2SVdPemtxWGto?=
 =?utf-8?B?ZXBLem14M09NdXcvMG9BaWxhN0N0bkwzdnN4aCtHY21uRzlxd2xHSzB5emU2?=
 =?utf-8?B?Q3A3d1liM1VUbkVqYkl0VmpZbEExdDIxeU16NVl5UUw5N0JPSnFvWTFHK3A0?=
 =?utf-8?B?bHRXMXovakJHNTEzeUJCMkJBczlHTzVYV092bUswbVJRNEtpdjh6QWMxamxr?=
 =?utf-8?B?RmdvMEpENm1KVHpxcnhzd3FLd3M0M2ZxeDZYdkV0WXBZejdhRTNRUlZaaVlG?=
 =?utf-8?B?S3YzVEY1RC9QamFPNU1ITHFIYVFWci9nb0Nxa1BLM3JCVE0vcy9tWERmekZ4?=
 =?utf-8?B?MFExQTJuRmlQdXhCeG95WTdxK0V2cEJxYktiRVN6OXR1elh2R2pMQ0hVVWdY?=
 =?utf-8?B?Sk9RMVVSeS9jUE13dGRKQjRKNGhEOVBLNWV2bTRXaDdkMlQxRm9tY2FUeGdl?=
 =?utf-8?B?L0hiUk9hVXNTODBTcEVjZHZjbjRVUjBaODVuNEZwTitKblJtdGNPRTFOTXZi?=
 =?utf-8?B?dU5kZ0piWjZyMXllOEJ5OGtlbVREUFEzc2Z5NnNqdmY5N0huSUlLeFdFaEkx?=
 =?utf-8?B?OElkTkxhaWloa1laUzZaUWZrRzJ1ZzdYeGtjb2xyaEtzcXlzL3FtbEc0U2pW?=
 =?utf-8?B?QVpTbUtEWHlkcVdpTHNuVGpGWEMweXBqSHYrVjNSSDFIVzlNeEc2bkdRbGJR?=
 =?utf-8?B?WHAwRkVqQ0JlempwTXRCaTBYUjhTQ1lySkNSeVZYTHpVMnpGWHVNUXhoS2oz?=
 =?utf-8?B?UHNkak1JYkNhZWFLcWc0RW5FVHFtK0JVVUIzUEVEN1BIb0V3ZXVqZ3dYcEJ6?=
 =?utf-8?B?UGdnamZxQmlQT2d4QmdySUVCMFFEeG9CN2FacWNaT1hQMG0waU52aytzR09G?=
 =?utf-8?B?VFZYekVLb1JKaG93NEVUcjBFMHZyZ1lYNS9yemtBMGgzZ2wxRVJOK3hENnhV?=
 =?utf-8?B?NDRmZEtsWERmQlBpY2Q2cTVHQ0VQUm1kOFpTQXA4cktXbWV3b0pKMjRyVUtY?=
 =?utf-8?B?L0pVQXVYTTVzenU3amRaakk5M3lwTFFERkM5WkZlS1lkOWhlSldOS2RqckNi?=
 =?utf-8?B?N0d2TTdkSmFORkQrNkdRKzBSKzRwcFk5VnpDQXl1U2VibExuU0JmcmFXczVl?=
 =?utf-8?B?ckdwdWdkTy91cFpWeGxVK25TVTAvK2hMQzl3YkZmN1d4dmVsKzFpaVFwUXNG?=
 =?utf-8?B?NkxhaUNXajRCWUlZNkNsYjk5cmJWQ1FyTVlYbE9jZktnWEIvc2M1NEV4UFBN?=
 =?utf-8?B?UlFlZWY1UVFhcnRQaE9udmJSa0NkRXF0Z054b0g0TCthSHI2S0NZUVhkZ3Ev?=
 =?utf-8?B?R1NhcmFlQXo4cFdJWEt2OHYzQVpWbjM4WEJzN2JvS1VvOXJuYm56V2IxVVN4?=
 =?utf-8?B?cVdrWmZSeHh5bFhsazZmVm9vSFk5Ly9ZSmxYdWNRdXRSSU9wWFRwQlBmVzQw?=
 =?utf-8?B?dmFxWXp3YWxDemNva0MwczZYejA0bWJhTlA1TWZGbVdUVWQveDl4MHN3czM2?=
 =?utf-8?B?bDRGVVpCbi9vRnFTK0VXbkszZ0NrbDFqbVdSVHN1TkVuYTZ3Q05LcythTlVM?=
 =?utf-8?B?RXdBVnROYWkvZ1djTlNKbFZMUXZSK05RRVFidUlpYmpCK3NoM2Z5TC8zSC9K?=
 =?utf-8?B?RS91REh5N3NiQ0ZiZlhNeEZhVU1yOS94YkNtZ0JDdTB5K0ZYWTJMRmprNmFZ?=
 =?utf-8?B?SE1KVVJhOGxCMjM2VHhwRElicUl1c2tGQXAxZkZBcGU0TXl4Q05rbEE0N25n?=
 =?utf-8?Q?WjKzc3y4BDwPH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4944.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGhEUldIVHFjdUJUOFhhNEhJbXpza2l3RWNZNkRPKzVVbEJwYXZjN1FGR0h3?=
 =?utf-8?B?RE9FaitJcWR6MEQ2Nk9lM09yU1dubUswZG94a0MwVG1sV2ZUZWo5bit2QjQ5?=
 =?utf-8?B?R0daZ3ZXVnErMURkVU9DTmZYR3VzZ1lkbGpPcjM4WnorbkxsNiszb1hQSzl6?=
 =?utf-8?B?T0hhM212RXRUTTVUam9oQUpQM2prYldSV20xOGhQeU9JOVJ0R3lzeEMxUHVr?=
 =?utf-8?B?eVZveWVWNVBObkVRVEJnSy9mZ216QnR1cFd3T01DUGEweFJ4WlNOQXhPb3R3?=
 =?utf-8?B?YjVtZHo4aXVtSUJZYWxYK1V6WWt3WFJxbVppejIxQ3BYbk1qVUxVdXkwNFBu?=
 =?utf-8?B?aFJtYjZ0RlgwU1pkM283dmdPKytmS3lHNlBudVY3b1B5LzVpZmFWVnlMWHUz?=
 =?utf-8?B?NmNnRFlqbG80NVVnM2trSWhiTHVEY2V5ZGRBMWFyeDk1ZEZVaEljRkNQTlkv?=
 =?utf-8?B?d1JzZU5oRUhMMWk5RnhrYXdZYVFwaVJiZStOUjE0YXZwMGUwK3k3cVNBRFAy?=
 =?utf-8?B?QjltR1hxM3llOVJMaERtMlRMYnQzU1JJbS8wbitaRFU2QXZaSjkvSEtnSnJ1?=
 =?utf-8?B?aW93M2k5ZG9ablQzMG9xa1czUmNTZkJ0N0ZXRHpNQU10SlFRRXg1K2R5Q1Rq?=
 =?utf-8?B?aE02bm9LS2l3WldlM2s1ZTJUOFZFYWdKbXMwRWhTbGJPc2VnM05hc3F5UnJi?=
 =?utf-8?B?d29kMlVTenQrZ09yZXp3NFhjTlZsNjFCV1RTdU5QSlhMSXZrMVNFTnh3RVJF?=
 =?utf-8?B?REhYSkZuV0Z0ZVJTUU9oSXVaM3l0WEgwOU93UE95TVJPRjNSQ2lnMGhNWEN5?=
 =?utf-8?B?NWpjNmduKzNLZXkwVGNoWjlLZi9NVEsrK1h1bjRTL1dWcmUzdnJyTTlmQmw0?=
 =?utf-8?B?VVJnTUFoRmRWTExOMStKcEJEQjQycGVpRFZiNG5lMHcvM3FHOXRaa0tmckRG?=
 =?utf-8?B?UWN5aFowNzFtS2xFbGVKcW8zMytLdVNqTEJoa3IwKzhzc01uUi9pN1Vvb2M0?=
 =?utf-8?B?bDJwdkNqbEFYeVFNODdQN1VkL2E3d21nUHFGQXBKcjYvVTJkY0s0ZGFEWnR1?=
 =?utf-8?B?cUtFM24zaXBVc2ZoOHVZM0tTNmRDcnUxd0swenJHcTd6WFN1OXJ4T1Z4azdC?=
 =?utf-8?B?S3BuK1RkSlBTbndtM1lKZkFybGlYZWw1UGhZV2w3SW9NUVF3Wk1xb2tIVkJt?=
 =?utf-8?B?VVhqSFlRMXR4dCtPUytXMHVtdzdMbkZyRGx1U2ZFTWlXdm44clJ6cDg5R0F1?=
 =?utf-8?B?R1dveU9WajZ4RTdYYUoyR3cwMFZOSm5iYWxjS1RxM2FYYyttWm5qTmdPZDkw?=
 =?utf-8?B?Uk92V2ZpUG11YkpTQnJtbmlRazZDY2dUYnhhSHlXQ3Yyd2lRTFR6MGZPY0dJ?=
 =?utf-8?B?MWxOVHdwajY4eUZSYkVOc25VN0t2VTFlTVU4bmp5cnlxN1J2azR1em1KWE9a?=
 =?utf-8?B?WllUdWkveDlWcnN6dEJVYVl0UXN5azFpenRLVmNNNnJmemFNbTczL1R6cCti?=
 =?utf-8?B?TDlQSVY1QVNxRUN1SFo4bXM1eVhTTzB1UlBIbGwrVTh1bmpRQU8zVzNuQ013?=
 =?utf-8?B?Q1d2U3MrUTEwZTFNUSszN05mbE16dDRjamt1YjBuY1ArL3JoVWZIOWtDbm91?=
 =?utf-8?B?ajVYMTRhZU0yV2VLRzhhY2FZbURTcHpOZ1lpNXJJRGo2ZjBncXZmc0RwalFo?=
 =?utf-8?B?YzB5R3VKUjcwQWQza0VpUWVkVGhybytrY2hBT3FFZ2IybTl5Uzc2eklrMytx?=
 =?utf-8?B?VEE3Z1VtTnE2R3VXbVliSzlPYkdlQ3hwSVZqY0RCcmkzamhGOGFma0ZTcExt?=
 =?utf-8?B?Y3RLRGVGbHlqZjMxSDZqSDJSNW9uVkZQMjhwRXgwV0RjMmp4YmNhZkVHa1FQ?=
 =?utf-8?B?WU1vUkpTR1pWRisvUlZQeHhnRVh2L2k4bUFyb0UycXdEdTF6SVpydlNhSmor?=
 =?utf-8?B?Ylpwa3pBY1RpdU9jbHE3cHQwVGpNQU9RckhOT2xncTFuOFJXQTd4S2NWSE1R?=
 =?utf-8?B?YWRsYWJ1TDJoaWF3Z01FQVgvVGhXN3pMSGU1ZFgvNy9tTGZCN01hNkZMazhz?=
 =?utf-8?B?b3h4SG5BY0VJcG5CbUpHWmxiT25tMWptakVzakVoVWRSc3JSNEVnSThBVkpt?=
 =?utf-8?Q?eJwxBJpYowrWo+Tk9Hend9yL8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5XOqQLx2+mlgt++XsZiLATNYNq4JyYG3zMykEJo8v9NzBtZ2h65exAhYBnGcnK5d+NodwGDnq+EwjCbt5e9WIYsgupe78jGPXN+r6LzodMFxd9OiH1BZGNEnytTLHq9jKOQHuK9Q80Jvi7pjbXwfAbmJaBpi0eB/DLKJNffzY1SHh+CnhCpGT/AD8kxZqYtnoTcA999b0A15vtdnOVhT9MNQybWb6UQMBEpGdm3EFbgx/4u7wwEzm4zIHZ0c7I381efyTDyIZ/9+j0JvP2RnNOX1tlQURKYB+EA1SBiVFLWxgFG/M+5FynXQVZcnHF1eZLjM1l+rWe3EWR9yVRHZZ3Enk2P5ag5jVCa4q8pBkZVxYtZY1iDHhd+/l2EYsoCt6efY0klcd5TfUj+DGK+E+5/3V1eUyeDKBp8mHJgAhKjQwLo31Fx+lWZLqssfehYMd/ZRANf1ypT1qvKTvLtohbPF3/C3vqMbhAV9/GuW2S157DX5o1g33GrFe4LEO+RLfgWHq+RmxLMSF9QQqJpGlGklllpyzK2bpE03v6JC/XBKiWxvtYlY72dQWdWIRkJIJ3BebHNI19oUvOJrCK/tOAjbF1hP/w0W4qwyTrE4tiE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd7deae9-9cfb-42cf-854b-08dd5d8d03de
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4944.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 15:30:39.5786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0XBd0LjOr59WFUT0l4V2U92VxlY8zsQJ6T6WQx7/MHSldbn0dDPMdcy7H0Dq/N4FlB/LobPtzkBVUwi++61VEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4410
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_06,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503070115
X-Proofpoint-ORIG-GUID: kXRlY8OdIU_XIbGJ3lYmRghdYJkqlprm
X-Proofpoint-GUID: kXRlY8OdIU_XIbGJ3lYmRghdYJkqlprm

On 3/7/25 03:45, Benno Schulenberg wrote:
>
> Op 07-03-2025 om 03:52 schreef Joe Jin:
>
>> -*irqtop* [options]
>> +*irqtop* [options]... [IRQ] [PATTERN] ...
>
> There should be no dots after "[options]", as the "options"
> word already implies that it can be multiple ones.
>
> (True, it's not fully precise -- better would have been:
> "[option...]".  But don't use that.  Please use what all
> the other synopses use: "[options]", sans dots.)
>
> Also, the convention nowadays is to put placeholder words
> in lower case and between angular brackets:
> "[<irq>] [<pattern>]..."

Thanks for your suggestion, I'll make the change.

Bests,
Joe
>
>
> Benno
>

