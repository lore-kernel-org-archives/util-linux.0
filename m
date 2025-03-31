Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62472147FD
	for <util-linux@vger.kernel.org>; Mon, 31 Mar 2025 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743433412; cv=fail; b=Y6P2i7TNdDmbslmxq6CPlb6MLDt4KLrjZavuQykZpEk9ZWY+glvIl2s3KxGN6Fa10EYnBSSwRPoM23onuvvYxLKtaqZAsSVNwihXc65+q+AnB/mgVrOMIbRBNN3JwgQcOpvQ8CPQcI/iA/2isVmCx1ITjZH7dfRPREGKdTf2DWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743433412; c=relaxed/simple;
	bh=LOXqExeSTJAN0yeSokjW8jWFoR7ZbFhndlemFtYqZQ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WB+3M+u1Cu68e/ZsfqH3trmsr/vnyBe7vbLWi4RmjS+XSchFONviJIed9Z3elJmuZrNetximWA3thFMd7b5byUrrDbB2k+IYM6j8j1tYdfX46pQsdUYFqyZXiz+bPLM4xXwGVm/pwHDi/4G0MBnhPQMTf4xyYHZzavyCvA9Hv70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UjGSrb2c; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OQKeFpHk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UjGSrb2c";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OQKeFpHk"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52VEC29D022308;
	Mon, 31 Mar 2025 15:03:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=JDlrpinyhXSGSSTB7YZ8af+XZDLS0D0jf0GPg5yNoR0=; b=
	UjGSrb2cnCWhy0oJ3+ej4lEiCMP3jrC0iqcZsdXzFxy8WKWBV4Y5fyyjSnQ3t06u
	vovC5SJoKWKCqAbYZtRunEkGMTxmoGDaBNj153foU3EJ8deld5Y06pBg+JNVVdgN
	0pz8omgOETSiCt/znudF5oYAHqh4yIQRLMG2V9IXP64ZUeyzUiOUNc0ksAYw98ui
	Jd10SDRWXOMndhFg0qbMGgVui54rxvfFL0sCZaVcRfrqLkGp2GG/7gZHDoXAVLPs
	e9lDedqH7HQv8UXbUDD2QZPIzWmvzX0ak/46LZbo1lG8ddUDwjSrvadaLc2EQ8O7
	a6OoUCg67kFzBbEIqq3U/w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p9dtbdsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 15:03:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52VDnHqe003274;
	Mon, 31 Mar 2025 15:03:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45pr8nxm3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 15:03:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQtBqiCKmb7Bko1vsAz/TSLWYzUz4fxRrpl89Ax6AmubFLIHSvD+MxBrJa7wj5obBZCPR1Jyr5YIBTxpf9Nb2uDX9X+iMKg3grsGd9HqXayjquuEgh4zj0D1B293O0MgbH1jfaTfTR74vZEY6zF9HT0JIY0GFiZ8ZICFcUpW//FkYnedf0v6ZocfATqngCNhyAxBRjF9J20U7caL4UFJoKn5QKBh3Os6iWuT0PpY3+yQpb89UXDVcdbf2nDUoYZGXQb7zqnAKvLsYdhDSL242sGlzKI2QQWzkXnZ+270g498xZCS2HGfXnYMAVANwLWpjDgYQRvHDRl3/Z9AlnXJrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDlrpinyhXSGSSTB7YZ8af+XZDLS0D0jf0GPg5yNoR0=;
 b=ckQZK4VrnYjyQUS/YyDN6BoZudOvch3N7tHhoUzqCdmCBiMGcO8Qq5xbrXlZgKl5dB4sCgS+ns6G6MI4nhhIBWvs8mtsE5YO8TfTp4l0Q7yLYjcCbKQuWzC6mVxD1KWkme3IKfaLzkjEN6MPp/5QWQJMCewaEYH1DMsCIJz8lIP+YOnQ+KsoQOKe1bqAIwBw/uL/N6IFKUgeI5x/5KrHhmnS7FEdnRzMlftlDfWvXreJdIZu6hIdXzLlzQMy6Uq5DNk93lJ8xbwNJ/JbVGTGH1zeO3gLtRqXTCV7upA3S7Z5Ns0nwasVpwhJcSCy10AN9GBwqDX34XxvKHjL0ZgA8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDlrpinyhXSGSSTB7YZ8af+XZDLS0D0jf0GPg5yNoR0=;
 b=OQKeFpHkjZZq2uVwt2E/H7KrGHDBzlmJzGyG00I2X08B3rgy1LMGUeGQfZEnBHImNhxlewjUlzfTo9pALnjSHlNOpEczlSR0OerGadj/XxH88zKsSp0zI46hTUqA605WhKVMcOvY0G+kMvoetQ2Eev6lz8jKXRlJJaX1bxC2lTU=
Received: from DS7PR10MB4944.namprd10.prod.outlook.com (2603:10b6:5:38d::15)
 by IA1PR10MB7485.namprd10.prod.outlook.com (2603:10b6:208:451::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.29; Mon, 31 Mar
 2025 15:03:01 +0000
Received: from DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5]) by DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5%3]) with mapi id 15.20.8583.038; Mon, 31 Mar 2025
 15:03:01 +0000
Message-ID: <a001f0dc-2b73-42bf-ad7c-1271e9727c36@oracle.com>
Date: Mon, 31 Mar 2025 08:02:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] irqtop: improve several more option descriptions,
 and align them all
To: Benno Schulenberg <bensberg@telfort.nl>, util-linux@vger.kernel.org
Cc: Zhenwei Pi <pizhenwei@bytedance.com>
References: <20250331094443.9619-1-bensberg@telfort.nl>
 <20250331094443.9619-5-bensberg@telfort.nl>
Content-Language: en-US
From: Joe Jin <joe.jin@oracle.com>
In-Reply-To: <20250331094443.9619-5-bensberg@telfort.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:208:160::26) To DS7PR10MB4944.namprd10.prod.outlook.com
 (2603:10b6:5:38d::15)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4944:EE_|IA1PR10MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: 47066fe5-9ac5-442c-1420-08dd706521bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDlQQXhsVVd3ZGFhU2VLNGEzZTRNcTU5UWVLSlhCc3FLeTdkWHRJSjZiVkw2?=
 =?utf-8?B?eTNSTzRWaEgvZ3RNSUNjUGt6THpnbUQvc1VGcE8zNi96K0h4MVNKa0ZPdzBV?=
 =?utf-8?B?cXU2eDRyMkU5SUJUcVFMZ0pQeUNGZS9Xa1I3ZFpaYysvbnJWdU5wWFlMbDVK?=
 =?utf-8?B?bjNjV3c5NGZ2WGdjWTc0L09YZ0phOWwvNkN6TVhQZEVacXRRd21qQTU0Nk1z?=
 =?utf-8?B?RGU2aHBSM0ZtQ3RyWW1vNHAzV0s2TDRtZmpxbm0vbk16RHZaRXBKR0FabFRu?=
 =?utf-8?B?S1g1TGpPKzhKZzhPcTdGK3dsc0VhUFFrRGVEY1lXRlRKV2VCVDA5YWhGOXRV?=
 =?utf-8?B?UktZVkVLUjBnUlBwSFJvcmVwUzlSVktpVkFneVJnVlY3a09tdVhzRGRnL01L?=
 =?utf-8?B?TmFoV2lXc2ZqeXVOZ3pHZUFjZE0zQVdDNitaZy9XMXBJRzZ6VTk5dWdVTEtI?=
 =?utf-8?B?VnVBWnB1L1VJWWp2aVNEVjFtN0NOTjJYM0JEKzN1VkFZeGZ3eW5BYWdMSWQ2?=
 =?utf-8?B?Skd5Z0daaFVWMldad3p3NFRuejlGOVh0bU9yTmd0L3c4SlQ1NXhZT2cwejh5?=
 =?utf-8?B?b0dtTjBadmhkbkRscUl3VUNjeFdaNmY1VEZTZi9Nd21ZRGxvRzg2QjBmWGhC?=
 =?utf-8?B?OUVPaGJqRzJVbE1tVFRaSUNUZnZrY1phbEVVdHZFMDk1Yk1zcTBKWHI1SHZ4?=
 =?utf-8?B?ZFBMcnNTU01zOXJCWG1xWEx4Q0svbGtzSzFpOXJaSzRuNllKSGljUVY5b0xS?=
 =?utf-8?B?YWkvR1E0U3ZhODltTzMrOTV0TkRIS3dBQkNLT2pJZHJkVCt0K1dGOWZmcU5M?=
 =?utf-8?B?YWNQckwrUDFPTEdDZU42aDVCMnNvQTdocHlTbllGTDNkVXRGQ1BEVW5WNzFJ?=
 =?utf-8?B?aWxPTUtYU2ZrVmJMUXMzaHF3MjA2SU8xTGVNcG92a0hiYlJwNUV5dU1KMTRu?=
 =?utf-8?B?d01lS3hEZWVFY2hGbjVPMXplYWdIb21VcXlIQkh1SW9kM1h6OUhWQ3dDSWNT?=
 =?utf-8?B?ejI5SHpubTZxYzA5ZXY4V3g0L3FpQ3c3WDNmamtVZTZHalFYWk9iYVFiK1dJ?=
 =?utf-8?B?WURROVZXRjVHSVJWdU1YakVmN3lLazFEQXBLK0tLL0hndHY1WjltQWxraVRV?=
 =?utf-8?B?ZFhEK0FFYVMvK04xRitPSXFCTnh5YlNMb1F1ZWpSckY1S25PWFRMdExraVVo?=
 =?utf-8?B?WmhVUzdrQ2ZROU5CSEQ4dDVKRVhLMCtHRU9PT1Zic1JtQis3RFV1VEdzWjE2?=
 =?utf-8?B?eFVucGpqVTJYL1R1NFBwVkk5MGFNRE9rSjJMcHhLeCtSRW9BUkpVSVRDNEhK?=
 =?utf-8?B?SHBRVm9OWTBhVWFPYityWS9kRE9hYVpXTnBUQW5ua1JNNVM4cjNqeUNIbUNN?=
 =?utf-8?B?R0tQempFa293cTlUZ0pjNWtSZmdMSWRVQTFsTnl0NnNQTm1uSmxIL292Qllq?=
 =?utf-8?B?OWZabXNVek9UaFZuYS9mTGpJNysrdTVtcUNUTG5vSW1NUW1Kd21mUlBzaXJW?=
 =?utf-8?B?NjhRZUEzTTFtSlBHZ0FXamI2WGNGSHpXTXJmSmJKclA0VUZqY2xNckVNUDNq?=
 =?utf-8?B?VmdXdHJnZElvVzFLdUczeTJFVEhRRU5aS0loanZpR3I3S3lZejJZOWs5TXpi?=
 =?utf-8?B?TlQ1T3FWM3Vxd3A4dXloaFlYeXFNcS9KVmhqYnJOcG5HZm5SYnBmMEVVQWNT?=
 =?utf-8?B?Slg2ZncrdzQ5NkdEaFBIVjlueW5CYVJNN1BBNWdUZGdXUHlnY3VpMTh2L1dG?=
 =?utf-8?B?MTdIWWVJWlV4N3RMcGQrWkhEaW11SE9teWQzN2gzaHBJdUE4STFVUC8zamRr?=
 =?utf-8?B?ZlBNdDlWSFFVWjU4QlcyTEJiTTZDVHZTOVp3OEM1S0RxWHZYM1VQc1RZcXR0?=
 =?utf-8?Q?Zue1mToi2BvvM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4944.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mi9LRlZGQmhhL2drbTlZRDlyRnZjWWNXelQ5Y0p0S2VUL1N2RDFBU0F4b3N3?=
 =?utf-8?B?TDY5TXMzQXZFdjBrOVlzdlZjSUJzNS9WS1B1d3VUMEdlK1cyRStGUVNOUks0?=
 =?utf-8?B?RDZHSUE3S0YvQ2JHMW82aWxQNENTQnp4eURHUTQxd2VZdW1PZWRWUkFIOWVZ?=
 =?utf-8?B?UHJXMUFnbk9IcDlua3BGUzN5RG5rVTI0OXFVb1dhK2R2WjYxcXhPcThQUHB1?=
 =?utf-8?B?cDFFWVdNRXh5eDFuTGVtb1RObU1JalM0WVNpNElYVHBJV0lNSVdkMk5nK21n?=
 =?utf-8?B?VDJBWEg3UzhmR3h1b0JQNXZSTVU0U2pGYiszM1hXR0p1YUFQczdlVGJYWmxa?=
 =?utf-8?B?eXVOcjFLUUNVVUJ3dmtDbUZ1dWF1bk5MUFNNZ0xnenJNZTl0R01LNE1WS2hI?=
 =?utf-8?B?WFlvTGJndWZWeTJ0c1hTNzJEMDNSeitnZDRsa1IvckZ1NU94Vkl5QW5sc1hC?=
 =?utf-8?B?OFBEdlh3RHQvdzYxWjc1WmZzYUVwN0ZQL1hWeDdOL09LTitqWkxpKzZiWVdI?=
 =?utf-8?B?cGlaYnlWWk9QZkNsNTVNYWNZakZieW1QS1VYTFk0SlVOMFY1L2x1TVNqSXo4?=
 =?utf-8?B?TXhRS3RidHkzdE9hRDh3MjZ2YmFxVjhFS0ZTUWorclVIZEQyMWdOQmljOFFC?=
 =?utf-8?B?Wm5MaGE5OHM2MVkvY1lwVXdDU1NuV0d1YXhRVXJiczB4clZVdU5NRFdMUyta?=
 =?utf-8?B?NVA4bldHSEpqUEkvZEZBYkJ4endXdWJSYW83R01SZGYwdlAxMzlhSlVKWnpD?=
 =?utf-8?B?c0VjZ0lYVlovSEFOdEJnbTBUNjcrN3NpcC9WemNuckkzSElMcE1CVmVkY281?=
 =?utf-8?B?TW5PaWdHMS8zL1pJZUsxU2M5U0N3MFZCVytVZHF1d2svanpiTjkveUVEclpY?=
 =?utf-8?B?cHVMNUZ4dW94Y2tMd0FmVEUyc2UrcmlPVytsdEZjZUhKQXBqczduckpTSUFI?=
 =?utf-8?B?eW1KNUo1QTZMRGtDWS9IaUh3cDYzY2ZQT2ptQlZGcnhlN2h2V2xWK2ZPUGhl?=
 =?utf-8?B?dFhGaHRadEV3S0k3cFErYnk2YnkyRWJuQ3BTTzM4dEhGZmtyK0E2YzM3VDVv?=
 =?utf-8?B?MzcvalpVT3FKRlV1Nzlpb29DWXRCQ1dGMk9UU0kxNVlYckxjOXVvcy9vWHFC?=
 =?utf-8?B?VUNnNzQzNEdvY3pvdnlkUjhhbkVBdFhSTVBiS1RkNHNtczE0eG1EZVFoMVFM?=
 =?utf-8?B?aG1ldHRwM2JoOHNEcUpuakQ2SC93NGJCaTEyRDJVa044ZitnZUZsMzgxL3lp?=
 =?utf-8?B?WEVqRTlnUHJVZEZxODZGVTFNTjEzdFdXN3U2amJrVllJSFp2eDQ4UHlxMSt1?=
 =?utf-8?B?S04vdkdjNk5PUHpHa1I2MFNKRkN1NXVEclFpMTdzeUlvL1BDQVk2cFdnbVM4?=
 =?utf-8?B?MnlLVlFIUDQvWkloWldZL3ZJVDRBYUJiNnFZTDN6VTVLWDNnWlNTVk5wMDZq?=
 =?utf-8?B?RjAxT3g4WkRnZ1N5MlJwUXN1aWQvUjAwUmRwOW9tNUpVbGZZYi9XV0hvQ2N4?=
 =?utf-8?B?RTg5Vmc0UkR1Qm9yOHlYTFJBb3Y1T3ZmTGloSllISTMxRG5tbUVxYjk4K1hR?=
 =?utf-8?B?WFJnN2dJQndDcnBKTDNERnQvWFFrTytscjV5ZGY4ZGl2L0w1V1lFcHE1RFJQ?=
 =?utf-8?B?SHB0RXRQRDlRT3FrSHVxNE9jMmN4dlM2TDZDOTRhQzRwT2V3VXY0S0NuNEtm?=
 =?utf-8?B?Y0szeHYxMklEVjJRU05TaEh4cG5iVmFUcnhINVJyMWxXRHRQU1JhYld6b1o4?=
 =?utf-8?B?RzVLTDZxaDZhM0lNQVJOQ0JCMmZYR284ODl2T3Q3OVRaQWFVYXh6ZGNRSTRR?=
 =?utf-8?B?L1gySUJQZXFoWmxibnY2TldHMVN6YzM3WFlWQ0hoZjJlQ2ZDVG1oOVNpKytj?=
 =?utf-8?B?QVB2cElvclJ3dUxrcUdsRGxLbWp6TnA5RVI3UTVPMXAwWHR2VFpic09tQ29x?=
 =?utf-8?B?ZjdWSHpWV3BhWFgyMTgwR3p5SjlJb0h2bUJDSG9rd0drVURvaG5aOVBzdU12?=
 =?utf-8?B?NmlWTlFGUTJ0UkYyRXp4ZlNxNHhYUW55bVkwRDVxSzA5amhLN0ZQWnM1bmdP?=
 =?utf-8?B?WTlxekVKTGRZOFY3YjYwR2pLem5BZFdBN3VYNmU2dUFhR0xheFJrL25CbkhX?=
 =?utf-8?Q?lTAzOnAXFp4pS4ujCK2tpUCmb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	23JD2Qhq2jHjjNgfBnLJsux/sYyZKBfnMHFj9O/LM1T9Z34J9GFPdZzPWkSpr5DSq/UnAWtvQG2OPblSblmlk6VqRQcfjyM80o5X8NVVJeiaQxy/hvtADZqsSgivIcbR3sdz9/na2PForSJcNmZdz47WbTDjjFsB/x+bW5NCuVAgKVcU3jDn40uO7oauid8I7X/S642VWUBKbcGLgn4ykc9xzRu/F+d51xv4GGs0Hz/HChQ60jukLCwTrzSy+DAxn0Rs0KHcH+qYd7jO4T+3YP8/Swv+jTgTp7y8q7B2/6Kk5TI3TgxmJ5Q1ldSbF3uNJ19DjYiLqzPmaRmdtYtXF1dU0rDUrnDJJyAm/3Lekp5mVRy8FRuB6/KiTXOs8ei9wqU9my6eNCffOXQV+yA8NHd+GXflY+Y6rBzA8bFu9SuwNgDQM2b3t17sOugjEFO+fuRW/jEyyiecCKryJxWkMCBeKDtUdkb7TmVtfv/aRZeDwojT4jtHFITTRYSWc2l4ZZZwJqZYk8M71eI0tZiK8jEZ7Z805+FKf/P8p73n6SBPevqxG63wlPyBSt0Iw7uUc1mluwHByjeVchQ1192u0NPvE+gbW/w3SiP0PtqbQoE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47066fe5-9ac5-442c-1420-08dd706521bd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4944.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 15:03:01.7813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gAuN/1Hkc5GwJV9/bUXRAXiVm8nVJmWZLNlfm2uuvpdBEhvHIz8fktrC+kiM6KOrES18hTpeM9NXCyil0w83Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7485
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_06,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503310107
X-Proofpoint-ORIG-GUID: Mbwy82cVUKx13gKqo95JzsQtISmsIXaZ
X-Proofpoint-GUID: Mbwy82cVUKx13gKqo95JzsQtISmsIXaZ

On 3/31/25 02:44, Benno Schulenberg wrote:
> Keep at least two spaces between option+argument and its description,
> while making sure not to go above 80 columns per line.
>
> Also, improve the docstring (there is no need to mention that irqtop
> is a utility) and remove the ugly Q from the list of interactive keys.
>
> CC: Joe Jin <joe.jin@oracle.com>
> CC: Zhenwei Pi <pizhenwei@bytedance.com>
> Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
> ---
>  sys-utils/irqtop.1.adoc |  4 ++--
>  sys-utils/irqtop.c      | 26 +++++++++++++-------------
>  2 files changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/sys-utils/irqtop.1.adoc b/sys-utils/irqtop.1.adoc
> index 04158a0ef..cf258d085 100644
> --- a/sys-utils/irqtop.1.adoc
> +++ b/sys-utils/irqtop.1.adoc
> @@ -8,7 +8,7 @@
>  
>  == NAME
>  
> -irqtop - utility to display kernel interrupt information
> +irqtop - display kernel interrupt information
>  
>  == SYNOPSIS
>  
> @@ -16,7 +16,7 @@ irqtop - utility to display kernel interrupt information
>  
>  == DESCRIPTION
>  
> -Display kernel interrupt counter information in *top*(1) style view.
> +Display interrupt-counter information from the kernel in the style of *top*(1).
>  
>  The default output is subject to change. So whenever possible, you should avoid using default outputs in your scripts. Always explicitly define expected columns by using *--output*.
>  
> diff --git a/sys-utils/irqtop.c b/sys-utils/irqtop.c
> index e0abddd82..3dbd030e0 100644
> --- a/sys-utils/irqtop.c
> +++ b/sys-utils/irqtop.c
> @@ -303,28 +303,28 @@ static void __attribute__((__noreturn__)) usage(void)
>  	printf(_(" %s [options]\n"), program_invocation_short_name);
>  	fputs(USAGE_SEPARATOR, stdout);
>  
> -	puts(_("Interactive utility to display kernel interrupt information."));
> +	puts(_("Display kernel interrupt information."));
>  
>  	fputs(USAGE_OPTIONS, stdout);
> -	fputs(_(" -b, --batch           send tables to stdout, not to a static screen\n"), stdout);
> -	fputs(_(" -c, --cpu-stat <mode> show per-cpu stat (auto, enable, disable)\n"), stdout);
> -	fputs(_(" -C, --cpu-list <list> specify cpus in list format\n"), stdout);
> -	fputs(_(" -d, --delay <secs>    wait this number of seconds between updates\n"), stdout);
> -	fputs(_(" -J, --json            use JSON output format (implies --batch)\n"), stdout);
> -	fputs(_(" -n, --iter <number>  the maximum number of iterations\n"), stdout);
> -	fputs(_(" -o, --output <list>  define which output columns to use\n"), stdout);
> -	fputs(_(" -s, --sort <column>  specify sort column\n"), stdout);
> -	fputs(_(" -S, --softirq        show softirqs instead of interrupts\n"), stdout);
> -	fputs(_(" -t, --threshold <N>  only IRQs with counters above <N>\n"), stdout);
> +	fputs(_(" -b, --batch            send tables to stdout, not to a static screen\n"), stdout);
> +	fputs(_(" -c, --cpu-stat <mode>  whether to show the per-cpu stats (auto|enable|disable)\n"), stdout);
> +	fputs(_(" -C, --cpu-list <list>  show IRQs only for the specified cpus\n"), stdout);
> +	fputs(_(" -d, --delay <secs>     wait this number of seconds between updates\n"), stdout);
> +	fputs(_(" -J, --json             use JSON output format (implies --batch)\n"), stdout);
> +	fputs(_(" -n, --iter <number>    the maximum number of iterations\n"), stdout);
> +	fputs(_(" -o, --output <list>    which columns to show, and in which order\n"), stdout);
> +	fputs(_(" -s, --sort <column>    sort the table on this column\n"), stdout);
> +	fputs(_(" -S, --softirq          show softirqs instead of interrupts\n"), stdout);
> +	fputs(_(" -t, --threshold <num>  show only IRQs with counters above this number\n"), stdout);
>  	fputs(USAGE_SEPARATOR, stdout);
> -	fprintf(stdout, USAGE_HELP_OPTIONS(22));
> +	fprintf(stdout, USAGE_HELP_OPTIONS(24));
>  
>  	fputs(_("\nThe following interactive key commands are valid:\n"), stdout);
>  	fputs(_("  i      sort by IRQ\n"), stdout);
>  	fputs(_("  t      sort by TOTAL\n"), stdout);
>  	fputs(_("  d      sort by DELTA\n"), stdout);
>  	fputs(_("  n      sort by NAME\n"), stdout);
> -	fputs(_("  q Q    quit program\n"), stdout);
> +	fputs(_("  q      quit program\n"), stdout);

Why remove the "Q"?

Thanks,
Joe

>  
>  	fputs(USAGE_COLUMNS, stdout);
>  	irq_print_columns(stdout, 0);

