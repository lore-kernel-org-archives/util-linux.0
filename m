Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F3A14F9FB
	for <util-linux@vger.kernel.org>; Tue,  4 Mar 2025 04:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741061581; cv=fail; b=T4azo0lx22V2I6MuJuDLc31gXLhHSwcWjZKhftBiDFgdp1pCxtmnOvN2y7izj+Mt7u4UgcydKvrOq58t657zsiqXRL8r4+00VZuv7N5xyap5FJZAnW5tXrKHAYTchUYLin/KLok2+2nuPevrjYhMig+V7V71Q7mG6ObJigZkxSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741061581; c=relaxed/simple;
	bh=COSgNQxyFzdolXGgNyd3QL/1aQywv3YWa/4ZTuIQu2A=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hC69rx/VT8FQay02mGYkEFJ7cerrSqKbt5b8XVcstbwrQW/7HG4icgCFLWyNo3ML88XRdiaVJZjpgTjjkwN8XzZuNR7O9C0OPBF9vES574MBMQUAMvEJHJKA0Ro7Di60YFURrTfNXVfYMQyoJydP5Tp66PvxzaMaJynC8+erKa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ID/+U/9z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SiGYcPVP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ID/+U/9z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SiGYcPVP"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5241NBtY016125;
	Tue, 4 Mar 2025 04:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=corp-2023-11-20; bh=COSgN
	QxyFzdolXGgNyd3QL/1aQywv3YWa/4ZTuIQu2A=; b=ID/+U/9zMNOtE69xGT7gP
	Y1cvjinbuu6jYLOEYURAuImHJ0wK6AhmrhX+6Ktfe8F54PrnGOGOypjjJ+rhZD4u
	SIJVKdrI8bEUbDDzDrpww3sOY1ulPJovST3EV7hUBHlx1ZFdxEEjZlXhw8OE+TBR
	LLnMvZbu60fMusoP5eOxq21wZvQOLFcHU91LnPJG65npUvkUpHdq+EdRvlg2V4iq
	QNsc2CRlnAnpCh3WB1Yh5bu725D2ENzhNc/3MMeggiukgXAGy75hgzn525ovLr7c
	QwXnljviATdPoZ8Sojtck9UYvBl0D4HPi1jZyobFdSi002e3/mm7cZw0nys67RyL
	A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u86m4r9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 04:12:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5241H5ra003268;
	Tue, 4 Mar 2025 04:12:45 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rp8dfrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 04:12:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJjHSRzsYqEt0ZsPWRtw3Oqcr5XeMd1I8K11+O/kcN8+fy4vVZa7KNOBocssqDFAxE2HOeciEPk+L+UEux8IIERanpaQJhQYih91Mvv01aVLOXH2I9ARG/HsZdxsF5fzF7g9Swz37kGFuFZZYZEofO/s9VMEcua6QNc0gI/i8zNKZT2S3FGQn7XJ9UC/rB/ebc9dX6/GvisEf4TyTPY99ksCTBELOcOzgW0MnPR+eRrDJ5Qs7+5BbdAnP0S4y1ybe03dQ5Me+zQy24dgvM3PK8u0BnA/5dGEfuajZRJQMK93Ux+YxNm++IYTHsdODIdv6Q07SDGbijRKSTJW0TOxDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COSgNQxyFzdolXGgNyd3QL/1aQywv3YWa/4ZTuIQu2A=;
 b=BCpNgVLnpg9yf0UVLY8GA/j49JgofNslqCx2PzD00ZDStztRkzXR219nf5r37UsbqRI4YYe+eUsFVz5Ghg8KGPqYhgLifJVYW3ceoDbZKxUle+30zUFmeu+L6gTctmpzhY3CM1bKvwEJAAX+TS138Eb8LDUvENTNdEFSFs6g5hGDa46KTOIizbYFJQJBVnlll9K0HjusyhNejNnChIiMBWWC4x65VDnD1LY/4Ba+xGT5FT/Q0OXH5nS/ZTSVlF0u19nRjRwFIVIVFJTxxXLQniRYhgytoJaWj3LIEurmnuBVJifL8sowM18nLKhPf0gvvjUfLD25Wyni6pmgV43sfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COSgNQxyFzdolXGgNyd3QL/1aQywv3YWa/4ZTuIQu2A=;
 b=SiGYcPVPP9qNyjRfTfHmTTC03wa4BNnngV/BLJRoAapo5EEMVkedakT0wFPIV0YDEHRO2wGclkocS+mQU7WAir8Ev6V5dFd72JtncXMKGQH/So2+jvT7savAgiM/8/RUloM3U0QoQ3q9aQgQLbI6aV1AMSKL3i2TYfpWOZBwxUs=
Received: from DS7PR10MB4944.namprd10.prod.outlook.com (2603:10b6:5:38d::15)
 by IA0PR10MB7349.namprd10.prod.outlook.com (2603:10b6:208:40d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.26; Tue, 4 Mar
 2025 04:12:43 +0000
Received: from DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5]) by DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5%3]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 04:12:43 +0000
From: Joe Jin <joe.jin@oracle.com>
To: pi zhenwei <pizhenwei@bytedance.com>
CC: Zak Karel <kzak@redhat.com>, Kerola Sami <kerolasa@iki.fi>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH V2 0/4] irqtop,lsirq: Miscellaneous enhancements
Thread-Topic: [PATCH V2 0/4] irqtop,lsirq: Miscellaneous enhancements
Thread-Index: AQHbjLut2r/35fJKDkOSCsA6nxM2eQ==
Date: Tue, 4 Mar 2025 04:12:43 +0000
Message-ID: <BFFCDBA8-2635-4AB2-B95D-B86A555613F8@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR10MB4944:EE_|IA0PR10MB7349:EE_
x-ms-office365-filtering-correlation-id: cb570de7-31e8-49af-d7ce-08dd5ad2d002
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TVFnRVMxMGdkaVQ5QlMyeTNidFpwWExpMHdCcTZqWVBZSWI5WG5TelZSeHlY?=
 =?utf-8?B?MU9zYk5GVjgwWUdWSWl1SCtvWU1iUWNhc2w0Rk05dnYyK1RjcG9WQU1NUFZM?=
 =?utf-8?B?cWdURUNnY2toNlByM3Q2cmRRTkRtWTI3OVZrckwyWFlTcE1oYlQ2RlZWZ05w?=
 =?utf-8?B?VW1seW9YZUQ0VHdENnovT3NFNGU5MTUvNnI2ekttalRzSElpdlFLS2VLNUx6?=
 =?utf-8?B?YVprWVBvSmlYWGVJeEw1eDFmM041Z2ZIZHhyN0hiZXFwUTNoWE1LcVJCZC9T?=
 =?utf-8?B?N2hxaXo3eGhJZ3RmbXNueDhIUk1FNWswNmw5dUJkd2tlc3B3L29LaGFXWGli?=
 =?utf-8?B?alZIRVkrOGcxMmRBZUhmdTdIdEltaDhiUE5Da0RhMTlXTnBuUWo5Ym42S0J1?=
 =?utf-8?B?Z2hUYUhHY3RlK2VORDhNSGlFUlcwWkU3UWh5UTd4c1VvNHd3c2FTSUltRU5Z?=
 =?utf-8?B?RDBpdDEzSzBuZ01wcGxFcUNWeWRTS3M5QmtyUEJKYWNCVGFScEdFNS9Eby92?=
 =?utf-8?B?QnNOa3B6NWRxQ2lpYlcxOHc4dWFaUXNRaU9idFRWaVYvTk1EQnVacUxmR2ZI?=
 =?utf-8?B?TmhsMWlBc0p1aS8vaXlKNHZKclROWEdSOEhtNXVwUW1yUlpQd0NRdGtjdXhy?=
 =?utf-8?B?aitnaDRtd3ArNStCeEFuYkRJSmZmeTkzczgrRnRRY0NpNUNNcHNFTnpqL1Z6?=
 =?utf-8?B?RFZFR1dHU2R6dXAvVVh0TXFlaFNMVG5TOE52TzZrNmlOTGU2K3VjL3hvSnha?=
 =?utf-8?B?S2xTa3Q3SitGVVVHazV5MU85NWtkS0c1aitGRGtTUHkwaEl5RGtzRFFCZUlS?=
 =?utf-8?B?YVc5NzV5Yk90TnUzMVRSZlorSU93ZjBxOG9nMUpSaWxLRmsrbFBUazRHVjk3?=
 =?utf-8?B?VkdmcjZMeW5xM1M2dDh3U1pUN00xdXk5eENwNzRJcW95VmE3cHpOeUZqL2U4?=
 =?utf-8?B?VkVtV3hPeitHbFg2UTZNM2VWc2lFaGo3a1ZzZHRwNzFlek5kK1FXYzdjYk5l?=
 =?utf-8?B?UnlDVWtGcS8yY2hsZ2lzOTVrdndCK1VBTTNGMEo5aGZpbVZ3R254cys3cXhZ?=
 =?utf-8?B?eDNnL2dMeFNmdWY5NU5wMnVzSWdaMEM5c3hPYitaSHBpd2Nyb1lBTWJ0WUYy?=
 =?utf-8?B?M2p6ditjMGV3STJYWEpHdzVQSUFlV1A5b1BIM1BlN3c0eS9oTzFHMllselJ5?=
 =?utf-8?B?S3JDbDRNZUVka0hIaGpyMU54VDcxMVBTS2ZQTXZEc3VUN1Z2cHVTL0x2bHRB?=
 =?utf-8?B?eEFEaXQyaUo4cWtiSnI4SjgzS2FTb25qQjdvV0RGYWUrSEhDWTY4VEdIcjlo?=
 =?utf-8?B?eTZFOWRkZmdHNjl6bnUwZzRUaDNlM21mc0lGbmF4WCtUVXplVmkvL0pkS0ho?=
 =?utf-8?B?NDhveUdQZTNXaTd1SFRISXBjMnlsUFRtRmtZN09TODJsYmt2SXNUS3UxaGRL?=
 =?utf-8?B?dFJQMWZobC9JaUh0Z2NjZVd5MzhiUjJrWCtBTlNBVUcrUjFFTjVvbDRyQ2VF?=
 =?utf-8?B?SVB3NFZkME5CUEExK1Z0dTJueEh0YktXRHoyTkFZU0pIM2doaW9SemppS2Vo?=
 =?utf-8?B?TzdCSllobmVnTk44b2xPcU1mNGhMckhyeEdYbzk1ZTNjUld3OWFkbmhINTlP?=
 =?utf-8?B?czhFV0liekRZY1BtQkkrWEQxMUFSYXRLSUtQQjR2ODdKa2t1NUpGT1VEZGJB?=
 =?utf-8?B?WHNTRFNHcFNYQTlSS3IzTHJjYWdYTm00cmd1NERQT0ZvRVNCeHpBOGNIY0dW?=
 =?utf-8?B?cnFQcWVYa0hBRmpxYjVubzBOdktkbExlZEFYU0k3SDh6VWpiRkhTMnpTVEMv?=
 =?utf-8?B?WVJmd0g0d2EvOWNVTEd0anlLU3lHaGpNMTErayttS3czb3dWOEsrWk5qbXNI?=
 =?utf-8?B?UytDWGxuaDlZc0wvVWYrSUJuTWNhOCs0TVhhZGFWVnlLM2dISWhuU3RMZDI1?=
 =?utf-8?Q?3VnE90LqmzsMLeb5nhHocgyfCmiL7olr?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4944.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V3RvUDltNTd5SW1TS0ZCN2VER2FEekZVNHM4MWNxMzU1aHdVMDlsRlJvYWRB?=
 =?utf-8?B?TU9DSEc0SjREa1BoajAzdHdGSEVFQmJHRzFOTGNyVzJjU2hXQTlIL3VWN2JH?=
 =?utf-8?B?SHNJVmVpQ2F2cUIyOGlld0dLcmp4RSsrVVRJQ2dnTDBQcm9kQUlaT2Q5MHZh?=
 =?utf-8?B?V25KaVExQkp3OCtESDBZdnhvM1RRdWw1d2lBT2poWnQybkRvMUk4SE9Sa3Vp?=
 =?utf-8?B?ZnVBazZBaEhQRmxTdmNoQ2RoY1ZTbWR0MVpsYmtRRllOSWZPcXhlOGFYUlZw?=
 =?utf-8?B?ZDcrN1hKbkJFbUFwOHFFY0NZeFZjYUpycjNZN2JRMkl0bEZwcXZMNFZSdGtC?=
 =?utf-8?B?b3haczVUNk13Rng2cWEwTStSSkRtdEVFTHNPNWlKQmFsYzdrbW9CVXNENVV2?=
 =?utf-8?B?SXdNL2F5em9JUHpOclBxQUx6Sk5PeDBZQUVXRkI4RFVoN1d3djlTNWx5Rnph?=
 =?utf-8?B?b3U3MFVucllxYUJ5RHBCNmkzUW9vV25zcytPYURsODk5OHBic29QZTJMU3Av?=
 =?utf-8?B?eW5CdFhtazU3ZDVLdWNQaGpPNys2OFJiUS9SZ2FFdVJ4M2JocEJuU1JHQ200?=
 =?utf-8?B?RHFlL1o3amdNekNwcTdHTzM1K0ZIZFUvLzdBNThqV2JLU1p2NFh0RHFHelJD?=
 =?utf-8?B?QytaaE4wVmpveTdaZU9YUVNzSWdCWjIra1JsY1FCYURjYzQ4eFJEcUpuQXdw?=
 =?utf-8?B?TW1HMDBJd1k2NU9sOVV2N21FUDJNdWtGRndEcWVMNmFSSDJITTdvUjlMdjhW?=
 =?utf-8?B?NzdYOVNJN0ZFcFZFQmZoZjlONml2eU52TkM4SDk4Z2ZXa0NGOVVUMWJWMmQ1?=
 =?utf-8?B?YTRxN1BORVZKby9BUmpDa05YTUNxQ1V6YXdqMkRoQVh5SDc5Skx2SmZjWndJ?=
 =?utf-8?B?eE1RTlQ4LzlVNFdXU1pvSHlmNVpnTEtkYkJkYTFFRXkzMksrTjZlSVkzNm5J?=
 =?utf-8?B?QjROd1B5L0hGMExVT1owa0pnTmdZTGIraysxTWRyS2VXTGpSWlNZQzk5eXRO?=
 =?utf-8?B?L3pVUUFhVjhoTlJ1bHBPUGM5K0E0Rk9ESnZkdVBydERsQkw0M2tMYzg5c3cw?=
 =?utf-8?B?QVJzNnlVVHVwbzgzYWZrQXdaM1VMQ0J4bEcyZjNVZ3hlbXRra29GRjRSZUhW?=
 =?utf-8?B?clhkSlJ4S21xTHo4WGlzcUVnbm5HUm9CQk1ZYXVLT2pHb21pU0R1TGdTZHdO?=
 =?utf-8?B?VXhKVWFkSGltRzRIMTZoQTh3U0hMaWdWck1Gd0trOWlLeGh4aFdMQnY3WVQ3?=
 =?utf-8?B?Z215NzQxaUFmZVJnZ3FGRVFMOXVaYmhVb3lsQW9WcUdPOW1pWGRoNVA4V3Zl?=
 =?utf-8?B?TE52OHBmUmtpSjUvR2YrUkxHLy93TFpoNkJUYUErcFFIV0pWYlUyNUh2b2Ew?=
 =?utf-8?B?aEZEQlhwVWYxYUZjMmJQekt2TStwR1hOS05lZ3FQOVM5aFFydkFPeXpKQ3Zq?=
 =?utf-8?B?N21mUVhMeFBRbzd2VDQ1S3RzS1FSVVhDNHVXaHNvb2tIZGgzOTFwRDczQjNl?=
 =?utf-8?B?Y09ZSStDaEdpMWFHYlJSWXVaMDU0c0NtNTlGLzFVa0czVTRNQ2dwbnE0RXZG?=
 =?utf-8?B?R0xDeE5HWmk0SjFIT0V4ZFZTb0FocXR5ZTFHSnRWNmhjTjBRNWoyQVl1U2gz?=
 =?utf-8?B?TDdzYkd5cUpHNWIvTFh2eUhoODR0WkZuVjBwWVNjL1pXRW9qK2JMRFJBOGhX?=
 =?utf-8?B?bnY0Vm9YakNSTkFKNXl3RlhaQnBLNFJsT2xSb09FSGZOT1ErZVpiV1Y4TWdn?=
 =?utf-8?B?UGV2VDNpWlZnbXAxVmE2WGVVMTlSRkR5d0JUdHR3YldzRk5DdTFjd0doVmps?=
 =?utf-8?B?V3pLa09laVBQZ1hpYVcyWFdkdE9ZQjBVN3FvN3B1RUtlVzl0UTl4ZVlsYnUr?=
 =?utf-8?B?SFVDSGZxWlFFQlBBdy9lV1hUaUpTVXBwNyswUHIrTHNUekVnNS8wdmpXUTJG?=
 =?utf-8?B?Vk90Q20xbWdqNDE3c1VYVjZmMWNXTEVPME1IMVNJZVdmVHZBb1FsQ2w4TTJH?=
 =?utf-8?B?T3lxYjhDUDhTTjdzeTMyeXhDc3k3QlpuTklFRzk5N08wQ0RFdFZERHNQc2VN?=
 =?utf-8?B?Y3RJRFo2VFFXM1dJUENZM2kwQ09JRnNxbkJ4ODgyUmxyN2FwTWtnRHZvWEdz?=
 =?utf-8?Q?dqJlbQrB6MC3oZo0QcQ+iwHZ8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EA90B24BC5B644DB659C2BFB0C32955@oracle.onmicrosoft.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	n8tRdwPamkaHMq4GjVurRWdR2Vf4V3t75GqwoDnPXpctNY6up6ngGVkJ89h0+Z4nF9bYDWQXyNdUraZrHBCik1gkUc4QEFKHC4BmHa4Do/+eTW7qYVQzp3V3IAoo4xIAVczKwsHaMRykCr1ELStSBvPTwb9E+JepvcqlfBNuCHK9XwwqGfZgRA0CcwjWWsf82k0xYqH6dvkCtgPMvS48HkCMHBgmZOo/X3dp1ZyV2gpamQP5D2GEBQqU/WPnSAqDecuzc7QQUSnEL5m/sOqkDe61rRbKtQh9Jc2NJJOpXRUhd/W17O9BUFIwqxxH9R44ZaKvuy8Wd2dUZa3M/QrFeg8jROwq8VTMNRIbGhJ0+On5oFnrYS7gUtECfont3tu+r+S0eiWVfMf/gveCXnZ+fJjygPESrhtS8+U4+iTqBrxRVfDRgeYOtWCobAKQKBglx+oLk8fqRLt+I67XnhFtD0X5hhU49x4E4IrTEpreiwTfK855IKqw2Aa6w4sFX0RB4fHZsIYmSObF/P4x8tS8u5R8+YjFK/5Rgo51JYTJcmjyDR11kL2eCoNJoNB7W3Fht0eM7lF2SiF6B95C7fVK43V9G0YAIkf4UTk+XWAIawY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4944.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb570de7-31e8-49af-d7ce-08dd5ad2d002
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 04:12:43.5669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rO2GYF0BVpyNSJoUemkubKmG/Gxxtt7XuiZUsfKZp2upDFcXfy+qqQM0e+FQNDYUSOzq6xybOlXt8SVBNjZjwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7349
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_02,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503040032
X-Proofpoint-ORIG-GUID: WGbM-pzQ3_6Xwp3GisXACDy_yXcnQGBc
X-Proofpoint-GUID: WGbM-pzQ3_6Xwp3GisXACDy_yXcnQGBc

DQoNCj4g5ZyoIDIwMjXlubQz5pyIM+aXpe+8jDE5OjUw77yMemhlbndlaSBwaSA8cGl6aGVud2Vp
QGJ5dGVkYW5jZS5jb20+IOWGmemBk++8mg0KPiANCj4g77u/VGhpcyBzZXJpZXMgbG9va3MgZ29v
ZCB0byBtZSENCj4gDQo+IFJldmlld2VkLWJ5OiB6aGVud2VpIHBpIDxwaXpoZW53ZWlAYnl0ZWRh
bmNlLmNvbT4NCg0KVGhhbmtzIHNvIG11Y2ggZm9yIHlvdXIgcmV2aWV3IQ0KDQoNCj4gDQo+PiBP
biAzLzQvMjUgMDk6MzgsIEpvZSBKaW4gd3JvdGU6DQo+Pj4gT24gMy8zLzI1IDAyOjE2LCBLYXJl
bCBaYWsgd3JvdGU6DQo+Pj4gT24gRnJpLCBGZWIgMjgsIDIwMjUgYXQgMDg6MTM6MzBBTSBHTVQs
IEpvZSBKaW4gd3JvdGU6DQo+Pj4+IFRoaXMgcGF0Y2hzZXQgYWRkIGJlbG93IG5ldyBvcHRpb25z
IGZvciBpcnF0b3A6DQo+Pj4+ICAnLWJ8LS1iYXRjaCcgOiBCYXRjaCBtb2RlDQo+Pj4+ICAnLW58
LS1pdGVyJyAgOiBTcGVjaWZpZXMgdGhlIG1heGltdW0gbnVtYmVyIG9mIGl0ZXJhdGlvbnMNCj4+
Pj4gICctSnwtLWpzb24nICA6IEpzb24gb3VwdXQgZm9ybWF0DQo+Pj4+IA0KPj4+PiBBZGQgYmVs
b3cgZm9yIGxzaXJxOg0KPj4+PiAgJy1pfC0taW5wdXQnIDogUmVhZCBkYXRhIGZyb20gZmlsZQ0K
Pj4+PiANCj4+Pj4gdjI6DQo+Pj4+ICAgLSBSZW1vdmVkIG1hY3JvIGlycXRvcF9iYXRjaF9tb2Rl
Lg0KPj4+PiAgIC0gUmVwbGFjZWQgbWFjcm8gaXJxdG9wX3ByaW50ZigpIHRvIGlubGluZSBmdW5j
dGlvbg0KPj4+PiAgIC0gQ2hhbmdlZCBvcHRpb24gJy0tbnVtYmVyJyB0byAnLS1pdGVyJw0KPj4+
PiAgIC0gUmVwbGFjZSBzdHJkdXAoKSB0byB4c3RyZHVwKCkNCj4+Pj4gICAtIEFkZGVkIGpzb24g
b3V0cHV0IGZvcm1hdCBmb3IgaXJxdG9wLg0KPj4+PiAgIC0gUmVtb3ZlIGlycXRvcCBpbnB1dCBm
aWxlIHN1cHBvcnQuDQo+Pj4+IA0KPj4+PiBKb2UgSmluICg0KToNCj4+Pj4gICBpcnF0b3A6IGFk
ZCBiYXRjaCBtb2RlIHN1cHBvcnQNCj4+Pj4gICBpcnF0b3A6IGFkZCBtYXggaXRlcmF0aW9uIHN1
cHBvcnQNCj4+Pj4gICBpcnF0b3A6IHN1cHBvcnQganNvbiBvdXRwdXQgZm9ybWF0DQo+Pj4+ICAg
bHNpcnE6IGFkZCBzdXBwb3J0IGZvciByZWFkaW5nIGRhdGEgZnJvbSBnaXZlbiBmaWxlDQo+Pj4+
IA0KPj4+PiAgYmFzaC1jb21wbGV0aW9uL2lycXRvcCAgfCAgMTIgKysrLQ0KPj4+PiAgYmFzaC1j
b21wbGV0aW9uL2xzaXJxICAgfCAgIDQgKysNCj4+Pj4gIHN5cy11dGlscy9pcnEtY29tbW9uLmMg
IHwgIDE5ICsrKy0tLQ0KPj4+PiAgc3lzLXV0aWxzL2lycS1jb21tb24uaCAgfCAgIDMgKy0NCj4+
Pj4gIHN5cy11dGlscy9pcnF0b3AuMS5hZG9jIHwgICA5ICsrKw0KPj4+PiAgc3lzLXV0aWxzL2ly
cXRvcC5jICAgICAgfCAxMjQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
LQ0KPj4+PiAgc3lzLXV0aWxzL2xzaXJxLjEuYWRvYyAgfCAgIDMgKw0KPj4+PiAgc3lzLXV0aWxz
L2xzaXJxLmMgICAgICAgfCAgMjQgKysrKysrLS0NCj4+Pj4gIDggZmlsZXMgY2hhbmdlZCwgMTU1
IGluc2VydGlvbnMoKyksIDQzIGRlbGV0aW9ucygtKQ0KPj4+IFRoYW5rcyBmb3IgdGhlIHVwZGF0
ZS4gSSBoYXZlIGNyZWF0ZWQgYSBQUg0KPj4+IChodHRwczovL2dpdGh1Yi5jb20vdXRpbC1saW51
eC91dGlsLWxpbnV4L3B1bGwvMzQzNSkgdG8gdGVzdCBpdCB3aXRoDQo+Pj4gQ0kgdGVzdHMuDQo+
PiBUaGFua3Mgc28gbXVjaCENCj4+PiAgICAgS2FyZWwNCj4+PiANCj4gDQo=
