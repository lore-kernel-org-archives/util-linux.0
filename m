Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5311E33991
	for <util-linux@vger.kernel.org>; Mon, 10 Mar 2025 15:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741620453; cv=fail; b=GPEB+2oPfLdy28oZlU+NhtRHee966iSdfA7mS1Jn/fpF6Xx/VFk26+8cgQLpCRwHaMlxus2f0kuVBIS10y+KTXHapKxbC34135pTmN2KZk/SZqAO4yrIgnzc2hBc7w331VvxWQoWx68K1WYS3n98bqObrgqrRy6Vq9erODX8MPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741620453; c=relaxed/simple;
	bh=aTsN4NSjC9k1iiyeNfYYYmmS7PBZHcLyI7IxjqYNvXI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TPliKDiINw4cBoHHu7mtJPQljTqPt4cYVFge0leT3ADkh/9C8Q54kxp7tHuROhthuEZwo9cJsVifdDIHlInfAY1pI3L/AEvJIClmZ1xLQF3FWSLJMeqP+6AjOTSG8bwltDEw0twBd+P6+vMSH909Ij3c8Y4c14NwQfghMIJnV0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YCbOK6TC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=T1EK2zU/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YCbOK6TC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="T1EK2zU/"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AEtgWH031303;
	Mon, 10 Mar 2025 15:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=3tzHWptAfvizGrOhqBjuT+ED7shV1a/wv/OIkobxZtg=; b=
	YCbOK6TCptT+aO5FZZLrHpPdn+PVtdqV/VzPZmzO4I2H3A4Nq2lTOi/Hm6LXHsNW
	5Cz/SFhck9CV/ytygzMPcdBqS4C3CekbamfIKAxrrS5ybp8oJLByu9TZkccWqnR5
	l+j4/cR6jBaHz/wpAhKOweg4Cd173PtlqC243gGC2XWimepO6d6C8HiePlQjqymi
	kZ7EDhYry4C5ndyMPLCpr7r4FJ8S3ZDYd+dfsh20ps1aA58dFDBvKsjdO8vYXn2Y
	B9o36LHBsvSoaYZd7mftmjA3aUO+3jKUZzU4i96ZIaN60yyVtjFzjwd4ziH6c9Fi
	7kD1XZCpbdbK+Dr+hups5w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458cacavba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 15:27:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52AFF8t3021431;
	Mon, 10 Mar 2025 15:27:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 458cbe8r1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 15:27:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nRXtQjNzfTmktweVvaMFJqg99PSUc/4eAGrPSr3OnoGW/CVl8DI7h5G7C2E3mBYmjJuszip5cE9h/g5cUEnH+0JzhgXTcyIdWQ5ZPQ4+rGkPa/uVW9yZkCoyy3Oo99TRiRT71AZeHaaudo1pPYy7PNeyuRKam+hvPx35XHv2K3qZpSxRBVTy7Psyhh9zOL0h5eDARDq1KbZbzDlgTvkrgTpKqLKrWdzcIf4yw6rYk9GL8bFcoXshEv3ID0dlPJicn+xcdB6DNnygxlK36EemlslRml5apJ+ecL5Dqb3yVmTe6PnS6ojNeluFeLOR1NjyEuWyHopQfQvw8bMP0DJEuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tzHWptAfvizGrOhqBjuT+ED7shV1a/wv/OIkobxZtg=;
 b=xDPL8lVugN1YvYQjSS2p2tjk8V2S8bGS+9gkwRXgr10G09av2jAK3/4CpVJfq0RC1vz0UoQtGqMlTmjXb7xHPf7pkZMpn34J4Tn7gIT8GeqwdtCou2QsFl3obLkhjDK5tl9I6OwbOQLIbaE8OXcFtGoUmDeZG4KX+4Yac18WTuC5FdL7rJiKAWaaOgUGbgIzf4p4SLJ1d96ei45tZ93jsgdUhGlFTt+AWi73Kcykx5MZfvlITnQQz8c+cAKHyz3UrK3jh6Abib2q8mih9m18UQjfcxhbRQXmdT97yuUwmjTKBwD1DpMJryRm1tuIxDLccX99nvTS68TbNTacfKXqOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tzHWptAfvizGrOhqBjuT+ED7shV1a/wv/OIkobxZtg=;
 b=T1EK2zU/qa7uyax3VAaGm6CuctrSMrN5wCzQwPgMUswwSpxGu16UFgUBxhw3uqTGkUub+qvV27SuhWwTDc7Nf7yvfTLNKqxMttFYq/s/lTNhhtxvBUMAjRtYSo5N1OUwZ7SpBrLgpzKkVdSaXr6VwbekIv0HK99Y6zztDjhJeTM=
Received: from DS7PR10MB4944.namprd10.prod.outlook.com (2603:10b6:5:38d::15)
 by LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 15:27:13 +0000
Received: from DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5]) by DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5%3]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 15:27:13 +0000
Message-ID: <f7c71470-1ecd-4022-a7b1-189ce7fa3fcb@oracle.com>
Date: Mon, 10 Mar 2025 08:27:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2]lsirq,irqtop: Add filter support
To: Karel Zak <kzak@redhat.com>
Cc: Zhenwei Pi <pizhenwei@bytedance.com>, Sami Kerola <kerolasa@iki.fi>,
        util-linux@vger.kernel.org
References: <20250307025201.92541-1-joe.jin@oracle.com>
 <qdiia2fmgfxwgr75qjdgxuiitaoo66tsthajqxs6mrtca6oqh4@irpn3e44w4sw>
Content-Language: en-US
From: Joe Jin <joe.jin@oracle.com>
In-Reply-To: <qdiia2fmgfxwgr75qjdgxuiitaoo66tsthajqxs6mrtca6oqh4@irpn3e44w4sw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::9) To DS7PR10MB4944.namprd10.prod.outlook.com
 (2603:10b6:5:38d::15)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4944:EE_|LV3PR10MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: 5141b5e3-29cb-47de-c18b-08dd5fe80869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnpPV2VZSmc5T2VyUThLYXdSbHNzdG03VlIwWWpwVXZBZm9sVE9WOE9Mb09w?=
 =?utf-8?B?MFREdFNMWmE3NmtNbU5sL0dvSTRjMURVTnNCNVNDRi84cDU4MkpWRGNHQXFz?=
 =?utf-8?B?VTJJbmRzK2ZkZ29OU0ZPWS9jRWtDeXlpWUtuekZtTzFxeEdKSWJhOFNTT0ky?=
 =?utf-8?B?S0ZraGo5Z1pBbmlIVUV2K1hBb3J1Q2czVVBuT2dWQm9PUnhJSkp0TkpyUm56?=
 =?utf-8?B?UXRRSkdOdlFvK2NMYWVrOWxuWnRiZ0l1ZmZMMWV6TXVXei9UWlBSeXhqaXdB?=
 =?utf-8?B?RUhIMG91aUVaVmJzU3ZZeVpmOUZteFArMEVvOEhGdm8yd2djcEp3L3BIRC9i?=
 =?utf-8?B?VFY2Tzd6d29wb2tsVDRFcEZxejUzZXUza3dCNGh6eXVPNmU0STNPRW5MUHNo?=
 =?utf-8?B?QjJzRzVhckJwUEp5ZW04RUk5SlpDTHdZUVZyVGhiTGEwUVdCS3ZaN0RLbHd3?=
 =?utf-8?B?ZHdBbDdwY1RPMFdna1hwdE13TENLQU4xa2tTREVNeTFTRUsxMUhJTVkyaG5h?=
 =?utf-8?B?bWdJRk1kZlowUmwvRjlnbllMWjA2M3dLYnFHc0tMZnVINnBZdkZSc2V1Zzhw?=
 =?utf-8?B?L2I1Ulk0SVlYQzNzTGtRRlJ0L3JJL01UZjA0VDJVcEFLOWJLN2VDWkdLTS9a?=
 =?utf-8?B?VkF5STRiVy9kZVNlcXN2QzJwNVhIbWdwRXlMOG0xMmNkZHQyTmJwWGxEM3VP?=
 =?utf-8?B?ZUdycDFNenBJOXZzYmk3ZmQrNE1HZXZ5Z3BVK1kxZnFiQXV2TmxYUVR1NVBu?=
 =?utf-8?B?Smt3dk1jNmJDNU9DdC9CS1RCNkxNamRDMEo5RU1Ib3dBQnlaSEhzUEY5WFdC?=
 =?utf-8?B?VjYvSW1RSmg1K1A1dmlCSElTSUFVdENVQWpNbkVBY3NKdjZTL2h0eks2VG52?=
 =?utf-8?B?cjIxWDM2c2VSMERUY0s2Sm4yNkF0clU5U1dwZ1FnRlV3TjJFVThaRnNhZm5L?=
 =?utf-8?B?bElzUitqMnlHUys5OEZ1RGtQN3BhMDN5bEVkei9OOE1hdVduSFlXOENzMlNI?=
 =?utf-8?B?RndOZjBnK2lmdUdoQmpLUUF0Q3FRcXlQbU5HS2QzVktWbkxVOWE1SHlvRE8w?=
 =?utf-8?B?N29kV3RrU25iTHdxS1JNUDVNQTZYOVNSZysvU0VlTXdqVzg2TXVpZTdnQ3Bu?=
 =?utf-8?B?TTc3TC9Va3NTWk11K281a1pUZllvdnNXUkg3Z1ZDTnZackJNOE9xZlE0bDk0?=
 =?utf-8?B?MnM1ZzFsaFpITWFpSmNVcjJ5R1E4akhDd3F6TVhPc3VsVzR6Z0FQenVhbHNi?=
 =?utf-8?B?Q1JPT1piazZ3bXZxYnMvSU1lU1o4M1lrTkJlNTRNWTZ1NVVaYVY0Q3QwSmhS?=
 =?utf-8?B?QVA2cTRBQ2FvMC82UmwyVVYxcFUwMTVRRDJUYjkvNTdTdXpFMndWRExMQzF3?=
 =?utf-8?B?Y05kejh6dllIVlNXaSt2OHlXVmtsSmRlWjZtc3NQMkN2bFU5ZjUvODE4VEV6?=
 =?utf-8?B?ZmlUTU1oTncwdFFFZVczTU4rQ1MzUGxvSytnU0l5dFl1bzVlcURKM0VzK0N6?=
 =?utf-8?B?RGtPNi9pWFc2d3J1d2g5bnFjZzBuc0wxT2JBd3ZEOTRueCswUVQ4NWJzWUM5?=
 =?utf-8?B?eXJFOUEvVjk5bU9ESFNIMkhhM3JNQTBSUy8zOFQ3WEx1SjZicW9VMDExTHJV?=
 =?utf-8?B?Rk1iN2pINWQwbE5EaHdGR2hhM1V2Q1hiMDd1aWR2NktBb2pSbUJnRm54bkdH?=
 =?utf-8?B?Tk5tci9hdXFqeTB6eGFWY0tGL29ESW1wUm1aWTRIakwzN3ZqK0hyd25xWDRl?=
 =?utf-8?B?dlBvNDgxeGZpY0dpTDNMbWhodjNjYTNxSnl0bExNdEt2Z1lHMVN3czY5ZGJU?=
 =?utf-8?B?RWN5VWdVQlBTaDZSeWdEZ0p1SDRhaG1EYllGUHJjUndEMGQ3djI0MHhKdFV2?=
 =?utf-8?Q?Wx0hQ6yCNhmZs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4944.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWxpZlNHa3BiWmJya2VZN2Fia2thRmFYRHE4dWVkWXdoVEoyNmFFUmNjNzQv?=
 =?utf-8?B?Mlp4NmxZSmFxS1AwemRWdmp0WkNmOVQxZWtSQ2RZNjFpT1daNkNzZUp1UWZX?=
 =?utf-8?B?QzdnT3ZrYityeUZVV2ZPZDg4aVViTkNWNEgybFdUM0dkWWtOWWdBdFhvMFRu?=
 =?utf-8?B?bzlJWjg3c1VlWlF1a28vSVlwdVlORzlPc0FEQ3NsNkZkTHYzME0vRTAwT05v?=
 =?utf-8?B?OVRCb1R5TjdhSTVrU0VTYk5JcUwzU25pZ0dkNHNOeDVNZ2xYTmJBTGFiSWMy?=
 =?utf-8?B?eXltcWtFMkUyN1A4YXZab1ZaTjJrNHQvMzJIczVEb3NqNG8rUXd5TzZPVFhn?=
 =?utf-8?B?SE5EYVZxNFkySW9vanEzUlJlMUtwWDRTUXVPRTFjc056SFVvUUxKT21pblU3?=
 =?utf-8?B?Y1R3SllYVkwyWWM1eldpNzR4WG5xSVNNcUVsR3dpQzlXckxEQWNsN1F3Kytm?=
 =?utf-8?B?TnlET0tkZXIxTlNnWWx6RmxLa2FTSnpzeEdPc1NpWFYrek1UbStGU25qWjR1?=
 =?utf-8?B?alZ4SHhWVGQ1d01XaFlYQXVSR0NXRVU1aGV5VEdtS0MxRFU4aHRPZVBTVlBp?=
 =?utf-8?B?QzZGbzZsU2c0Uk1TT2F3dFRsd3Vua0RQc2ltK283TUJtc3NZdTFuaU5IUmtk?=
 =?utf-8?B?YktPcGpCeFBsb3JkaVVIVlBGbFVmU0RrS0JQL1JJOVRqS0hHY2FRQTVrTkJa?=
 =?utf-8?B?anhpVU1vVk1VTC9Ic0grdWhwYXRZNEVYaE5VMHZIRmt5SkIybnVQTTZkbWJX?=
 =?utf-8?B?aEVLakY5T2VnNVJiODd5Z3VPQXZnYkxDQkFUWnRNY1pZcG45MmFJbDQ0T25I?=
 =?utf-8?B?a1lYR2IvY0FlSWpSL2lwUS9EQ1dtWVFMR0xCcms3bUJ5QWM2UkFHRHRXNStY?=
 =?utf-8?B?aW9PZit5UDlaclRZbGcxTGhhcjBxdnBtNUlRSXp0QkloeHV6UEEvYWZEdDNx?=
 =?utf-8?B?ZWlKZGVmZUY1VHg4VUFBeWlyWWJZVUUvZDFKN1pLSnljbDBCQkNMb3BicTVT?=
 =?utf-8?B?eHM5bStkSGFjcFNIWDRRbStBZlp4WXVHWXFqODJPNlZCbDc5NzlxemI4eWdr?=
 =?utf-8?B?ajdyMmdXWWZNVVRwNlBYekgvbEdvRllKVENQSUwreW9OWmYvNGtnd0pwVXFH?=
 =?utf-8?B?MWlIelRjWWowUWFtaHdiekJUYkhrdmpIWnZ5VjAyamVMRklJVUhNSEJxRlU0?=
 =?utf-8?B?bG9aWE1UVGoyQkl6NHprU2NWS1hwMGVRQWwzSGlrTUdibFA0R3JDVFdyUGtU?=
 =?utf-8?B?aU5qTjdqQllDMFVGQW1LdVJna1lGNW5WVXJRVmM3elI1aEZOSmtYSGpLcEVV?=
 =?utf-8?B?emNpNDRHcnhoYnNGaGx4N2NLZ3diTGp4clRZdU9nMjRIcFpFaGZodnJEZVlO?=
 =?utf-8?B?T3paS1hZVldKNTBxTWZ6ZHZpVmd5T001WVQ5Q3EvcHh3UEQyYURZTzZPckhL?=
 =?utf-8?B?VzZzQ1JkS1RsVWczZnpTZDVWZkFKaVRHeS95YWNYSnVyczBXODF6SWJ5Z0JH?=
 =?utf-8?B?ZFNQUVB1RkY1RnAzdVRzb1JSYnkwcFZmZzJMYnhIU1NEeXJ0VGtMeG1SWUp2?=
 =?utf-8?B?S0N0MkltSUFNY0hla1ZsWXMwTXU1Vk1PSDcvNUt0ME5ldzlESDJQN1BUeFNR?=
 =?utf-8?B?UGxEMEtYM3NGeDRjMnNrWjVFZ3ZaQXhzR0k5b3hDcUF2WlpCTlNMMHJkRGxV?=
 =?utf-8?B?eFpRWFJRTGU2VUZIQmhRSGFaajlvMVhsMTlvTE8yM09sQmZISXc2MUh2VmZu?=
 =?utf-8?B?UFdRdU1UQ0xpZklrNUsxNlpnVVpCRmMrZkUxbUt4ZUc0RjRTeGxncUxKa21S?=
 =?utf-8?B?MDJpY1VCWk9WbnFDUGtWY1Rpck5IUHk3NGFGQVFnZUdPTGluL2JCRzhTejBU?=
 =?utf-8?B?K3IwbFhSanE1Y2Z0cEdla21FZlp2ekRsWmFrTE9sTGJOR1lLUk0yc1VXNWVm?=
 =?utf-8?B?UVlIc0xiU0ZWQ3lHOUNwR00vc0E3OFpLWENxRDU4WWZvWVF6c1BVMGFlUm03?=
 =?utf-8?B?eGwreVErU1A5bGdPWFE1SDhXcGFIS255NkhDL3FvaXdsSXYrUGNOY2lXRzZo?=
 =?utf-8?B?eTdzRGZFdXJML0RzblE2Q2wvZDg4dEtLbUttakhlVWJVNnhPeHNsUDRzdzQx?=
 =?utf-8?Q?p/rrC8aB+6a3FPI6Bamuimfgw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qJKQDc71iGEMwgfSgAJNlcyIuBTWNlAikhvPu343lfJAKWsXdLli3ZvCLQiFxVQzqhEZ0sx+lx1rz24S+rWLRC3vyDOq774hcUwAbR/8pUECtRgmzMiqaa6CMg8qwSfhnSkqENpwGWvqJO2/SbpNna1q1qEoD1/0C9r2xY6eMOXBuL6NMxL7cHBeAZZ9/lhPMGQZDgKogMgOhtnHKiGZAynhGdYz1tQfVP2dHjVjqXDPVpADTlqtf4WcbuYC3fMvzvwd2YTWWn0vVoINhggeEOAwxYgqihamn7O8dmaBaChpbwpA33zcUV/ttbkO6MYoSkZllXADmEp5OkG+GOIT5vXDsi2qMoPqxY7vXwK6ISGJyoCyq3kjgl9hI5+36IWB+N7BAKhJTVOb9nHS8icSFGObCX4LJoHIHMdJHZMIcughbOj3dJu6v6ogsXB/LESJYWwGgl7OnCPerMBvRrE7bh/h0X/tt8AbtKn+VAkgcuk6/lj/r3eUdUUrODmSlagVfvRUQybaAlxQCDcNnX3cducdPKnyfRz8ZZwW/ubcdnAJY6lvAkrmtApSL0Gr3IArI4ppHl+EaljuHWl5HBCyI/GlMBlhiJhn79dyYx75Xv8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5141b5e3-29cb-47de-c18b-08dd5fe80869
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4944.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 15:27:13.6552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VnQLjrP36Re4uKNOWE6/xShJ5av0uM5zR5WzhSlbsYS9W293sf01UgVBMCvRx1LIgbdHS4LOByEcj+8gfYSeyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7868
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_06,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503100121
X-Proofpoint-ORIG-GUID: _3VSaCgMP-pTWXm_bcJmCiXnTls9sQJf
X-Proofpoint-GUID: _3VSaCgMP-pTWXm_bcJmCiXnTls9sQJf

On 3/10/25 05:14, Karel Zak wrote:
> On Thu, Mar 06, 2025 at 06:51:59PM GMT, Joe Jin wrote:
>> Sometimes people may only be interested in a specific IRQ, adding regular
>> expression support can help engineers find/monitor IRQs easily.
> Ah, the libsmartcols provides a filter. See, for example, misc-utils/lsblk.c and
> the "-Q" command line option, and also "man scols-filter".
>
> scols_new_filter()
> scols_line_apply_filter()
> scols_line_is_filled()
> ... etc.
>
> https://www.kernel.org/pub/linux/utils/util-linux/v2.41/libsmartcols-docs/libsmartcols-Filters-and-counters.html
>
> The filter allows the creation of complex queries, so if we integrate
> it into lsirq and irqtop, it will be possible to use things like:
>
>     irqtop -Q 'NAME ~= "PCI\-.*" && TOTAL > 100'

This looks more powerful, thanks for your suggestions.

Best Regards,
Joe
>
>
>   Karel
>

