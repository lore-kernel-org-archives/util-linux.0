Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011037.outbound.protection.outlook.com [52.103.66.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBDE1F9F70
	for <util-linux@vger.kernel.org>; Thu,  3 Jul 2025 03:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751511960; cv=fail; b=oAzgFeypviiIig+yFiYPup940Np2KEQ3Cv4CR6MmS+FsR2J53zbD1PJLVdCjGHLbUNqGw5aFU2jhZCsSuxWyvd0R3DYQEKCwOQRjwKhHW0UKjZZhD5JbdC2r0/w/ybhc6hJcAUhnVRE7II3ZjzmyOXMELNLagekz24q9vR3ANks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751511960; c=relaxed/simple;
	bh=po1BqtbZXoeOyNL6Yf59vHBIjDrefVguxg0dUeaBbOU=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=QJnC/IScYD/DvkxSEGMSCdU5BHTYzW2v1ObLuZDqeTLRjuM4L2UxTD7sCrZlr0zG0arS7aIy/3Xv0Ont02y4ecCLR+n8r4xDuF3/M2k9drCnt1g6Mw7jXu02IkJr8Br5Q/AWvJaBZ+hzMH/XfgfdEfI8jK639gdX/9EVES8FvIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Fz2bw5xB; arc=fail smtp.client-ip=52.103.66.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Fz2bw5xB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=me++WH7AdcNoAnSd6LYkUq8syPDXcV/us3Ub/Yfah1lKPtn/OPHVt/dYixsbFUBmQ08Qjvn1q6ztr2LZ1xm2JcaLiOmt/lO/vzkjynVUjJn5JTV0mzLEpc4vc6MQRA+tdDoVXXrtW7AY366j+5B+Lr6xQiytQfZsm4bcM+0ssHtdjofPKjPuhoqstPbmaKQeVfKVhYcOgn5ZKf4CP00xNpFpNbfjOri7q24DJFndhDWbuKZHGDNoUwqgo37M3E38ZVjs6AKEAm1l+EKVYWTpkj76ltHz3zxT7OefNiippbn023C055QBqBFTvCAvBLBkvb19FFtO21yEK2GNleURYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBaasFZMXPPSGpu7RPNPkBWKhGzxYQEzrXwn3vq/fBo=;
 b=BkDt2FqwDms63jyY8Ast1IZdEtYjy+/RsYwBvxVJQFxg0/cTgMH0Xga6oIMlLkmsc0fJB5BsiLkgeu+9o9+M47zgWwc5FSvPGw/Efmlp2nVkwH15MQuVwQ3qj/Ooc+OPKmdIq/hZNWtiOxn0Kk1LdXmnsPUMddyiHAWnC3be4EMHhTfpVjW3df7s8n6Fc3FMd6iUIxee6cf/5cvYOxus6RUUL0kQOCPd7z8ONnOhWzrdPfWryjZ1gGSAVI1g8gj6mNItM8LzSOLY9kUXxCIYXaOlsmQ1yRUvwrVFk+/L+tNtXQEXikkY/sdcmfVlIvcH0HSddtPj1PuSzVFDI/PdaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBaasFZMXPPSGpu7RPNPkBWKhGzxYQEzrXwn3vq/fBo=;
 b=Fz2bw5xBfHUVEXgVng9E2XF5PR1f8BZPrHvEO/d6CBG5i5N8j2LTZnNz4eksivSWDzYvHOgPpw/AT8QaB9Jh2gF3JGDRe2GT8Cw4KEn7v89oH+4qQcc8wL0OZbKfWuya8DptY283WJxGVgVtWJF3DCQdOV1P0kCTsxVb31fNfyTAAdYSf1sN34OwTPb8r26D2Z52k9x14YhcJYXumXCVjt60B6qxYbcFD4HnBXvpLiSlsHncF6wcGurC51cH9MPAynVex7Uk0NLBSBcBl5fvXf1eXw8cxmBhft+QwF7MNhenA7/P244P1eu8VUTPFSKOfk8SUHjbnE0MxD5m+9nyEQ==
Received: from TY4PR01MB13853.jpnprd01.prod.outlook.com (2603:1096:405:1fc::7)
 by OS7PR01MB14763.jpnprd01.prod.outlook.com (2603:1096:604:39b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Thu, 3 Jul
 2025 03:05:55 +0000
Received: from TY4PR01MB13853.jpnprd01.prod.outlook.com
 ([fe80::f159:9189:49ee:bc45]) by TY4PR01MB13853.jpnprd01.prod.outlook.com
 ([fe80::f159:9189:49ee:bc45%7]) with mapi id 15.20.8901.021; Thu, 3 Jul 2025
 03:05:55 +0000
Message-ID:
 <TY4PR01MB1385345D7813E44642723316E9243A@TY4PR01MB13853.jpnprd01.prod.outlook.com>
Date: Thu, 3 Jul 2025 15:05:52 +1200
User-Agent: Betterbird (macOS/Silicon)
To: util-linux@vger.kernel.org
Content-Language: en-US
From: Mio <mio-19@outlook.com>
Subject: btrfs device detection bug util-linux 2.39.4 to 2.41
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AK1P299CA0003.NZLP299.PROD.OUTLOOK.COM
 (2603:10c6:108:17::13) To TY4PR01MB13853.jpnprd01.prod.outlook.com
 (2603:1096:405:1fc::7)
X-Microsoft-Original-Message-ID:
 <9675e1e2-d11e-4165-b564-1dd3987d5baa@outlook.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY4PR01MB13853:EE_|OS7PR01MB14763:EE_
X-MS-Office365-Filtering-Correlation-Id: eadaf618-d636-41c2-3433-08ddb9de8709
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|5062599005|5072599009|461199028|8060799009|7092599006|15080799009|19110799006|41001999006|440099028|51005399003|39105399003|40105399003|3412199025|4302099013|26104999006|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDhuMFE0UWFhaDJBZFJpaWRIYVNxUXZJSFdtbTlicHRPdm5RS1dIMDlhWUsx?=
 =?utf-8?B?UWZsVFVmZWJ1TGFjdWtrTERzckdqODZMNlRtM2JaU2dPV0VZSlhVcm1WaEVq?=
 =?utf-8?B?KzFjUTBQa1NFaWNDN1FlLzRuRHlvT1docWdLOXlXS0grMVJhb3hyQ2lJS2FY?=
 =?utf-8?B?YXp6ZWNXa1BnWWpIZ0Q1V1JRa2lYT3BsYVFyRVdtZ3NxVHd1dkQ4NGMwQUFU?=
 =?utf-8?B?YlJsTGQ0NGdOeVNaaHpTN2xDTEZmV25QQVFnbXRNNENhbEtpaytuYzd1VUNN?=
 =?utf-8?B?ZjMxZDJJWkl3bkJacVowTm9zYmE3VW1LZEdQYmtyb1VNeHhQSUFmamhzVnlz?=
 =?utf-8?B?aWZOS3ZNbkZpSS83T3VueENCSWVpc2J5YXVWNG9SSFNSSDJZaGMwNVRRRXN0?=
 =?utf-8?B?aU14S2kvMjdZZzJQdDRsK1daYitlL2JnVzZ3Vk85NkRKR3BMZjZSVzlPUHFV?=
 =?utf-8?B?ODlCbVZuLzRnSUlDZUxuK2JoemJCWkFwVXFhTS9JOGtROFk5SmZEMVo0Um53?=
 =?utf-8?B?bHdNbUZEbWU1TXpCZkZURzA2WkdFcGF6S29SaWVBMlZyRXlUZVpmTlZ4VWFk?=
 =?utf-8?B?UTlsU0JiNi8zT0RLZENWZ1ZLL2cxOXdFZkJ4U21iK3lVNytMMVdNUy9qQWIx?=
 =?utf-8?B?d0hQTTVsdHd2RnBWNGFrc0twT1V1dHdxS2g0clB3bTVaVGMrL3ZCUHl1MUpJ?=
 =?utf-8?B?VUJMNDBrQ3h4SkwrOGd5QmNMcTE2NmVJK2ZmeFZUQ0g2UVpZL0hqcDQwT050?=
 =?utf-8?B?TDJQZ1pXb2xldlFtQjNDNHNzQjVVL0c3YS9DY2VHVThTeFZ5TGlCVmpVTkFl?=
 =?utf-8?B?QWNjcU15YVhuZWJlMVZjellxT3Yyb1ZWcHNLQWMrY2RtVXhlNzJwVjNYbXRs?=
 =?utf-8?B?b1loUTc0aUNqVU5aUWJvcFIyZTNSTjBqUXRnZnRRRzAxUlQ5ZFZsZUprb3hs?=
 =?utf-8?B?c3BpYXFBNS94UFNpRzU5bS9qK2R5VVBBSTZSZW1EMlR5Rm9NYm5UWmkxS3lC?=
 =?utf-8?B?Ry8zR29CeDVNWmFUYzl1VUdzSS9GYlhqYlBEM0tQc05yd2hybnFnZ0w3U2Nl?=
 =?utf-8?B?QzlaaUNzdzc5cllRb1VvUkFza2RrcmovOGtkc3RzdFpZdGlFVWtqTkFha3NE?=
 =?utf-8?B?SjBjeXo1ek5Hbm5vVHNYVUJ0LzV6RzZpd1k2bHFETVF1c3E1bVExTDJRTzdi?=
 =?utf-8?B?SGhnNzVudjNNZnBmVStTamtJdncwRktaUXc4b0xkTDUxcDYyNkRvb2x6Q1JK?=
 =?utf-8?B?UzlKQTFXRHRRNXpld212YXBIUHFaVmZWUFVwa05KOVIwT1ZNQit4YTh2amRt?=
 =?utf-8?B?eGkxbzJndFhUZVVETHF0Y1d4ZTJaWHFYdHdFRUxvd0dXK245Tk9Sa1MxZnpY?=
 =?utf-8?B?ckhnc1Q4eW5CbDRGV0VWZjVNTFlTK1BkNnN0OWdFZnBrdndMeWlaZ1NzYUx2?=
 =?utf-8?B?MURiSUw1bnhXbTdjK213ZHZjZURGSnU1T3IvNVpOTGdIOXVyVkYvTldSZi8r?=
 =?utf-8?B?dU1UQ0RFR0sxMThHZEhoSmJNbTdUdFRNaHVHTkcxRjVnV09WL1U4aU1aZ0No?=
 =?utf-8?B?TDZhZVd2ZHgyQXQzUjFhVlJwbmdKRGppVytIQ2Y2NUxPNXNCdm9pVzkwYjVK?=
 =?utf-8?B?cm45RFJ1dW1xSzVMZDVSaUthU1I0N2pYRStmeVRjR2E0SVMvdUFxb2g2WER6?=
 =?utf-8?B?cVNuTnlHR0hVeC9sZFU3aHdMNng5eUVLRUxDa1R1QkNuUVF4eFJNeFo2SWRJ?=
 =?utf-8?B?RGkzMGQ2dno3aS9ZNzZQUlJ1bTJaUURIcXJDRGFYMzZhUStvT05CdTUzZm55?=
 =?utf-8?B?YzdjOHpBRlpjSFE0TDBUV2M0Q0s2N05iRFVTbEFlaHpkc2FXUGdCVkRFc2Rj?=
 =?utf-8?B?VzRid2xUdUkxOTAzazRPUWoxQitNeGJQdmEzdWkycGp4R1E9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXZCUE0rYXpGMkQwZEYzbllwU3VML3dkbW4rTFowQTY3MmNSSWMzOU4xT3NB?=
 =?utf-8?B?SC9ZeGdUSTYrNDFDam1iZlA1VG5pUnVySmxaRmlNTm8ramJObE50WEZwaXUr?=
 =?utf-8?B?b29QVXhLNDRCV0lhblh5UC9JZXdqcjRvWFRnUnBOMEJMSUs3Q3VWTVZHNnVn?=
 =?utf-8?B?T3dUU3lWWmgxT2ZTWGZNcC9QOXd6dGRYN2NaNzhYeHR6Nk9hZHlVSkpxZXg5?=
 =?utf-8?B?ZzE0NkVpZDl6OWd3aSs1bnEzTUwvdmMyY3k2TjdBbnNqZDEwRjFpc2N2aDBj?=
 =?utf-8?B?K25HM3RQZldnczRQK2JLdjlEN2ZJOVZEZUt6bGpxa085QThvSXg4cWRTKzZP?=
 =?utf-8?B?Ti8yTURRaCtOSlYyOGtkZnh0LytWRjZqNld0MUJUeTU4T1ltVm9QMk5WQVpD?=
 =?utf-8?B?UGJQc0J6UzkzUllkZVF3Zks1RXo3eWdBWlJOWmdKenEwMGlVbytKV1E5NXpJ?=
 =?utf-8?B?ck9jZVIzMUFFSFBEdmZrSHdJcXF0alF2Um5wMTM2QkNaUGYvNUY1T21WLzUr?=
 =?utf-8?B?dUprWlZmTXoweDcvUDNJY2dKbmZiN0x4MCtLd0p1OHF6UVJicnEwbHNOUFRU?=
 =?utf-8?B?ZEhNbS9pVXlST2lEU3ZlaEtiNTc3dTBuL3lhcnZvTlpaM2xxUk12SXdYZXY0?=
 =?utf-8?B?WlEveVczU1YyS2k1Rm80elF6TmR6UmJRRURxRUwya2ZPNUxyMFJ5RjkvaS9q?=
 =?utf-8?B?VnlBZXZGNC83OUFsYUZZRUVHMk4zQTF2alhxdGFzYTJCaEF2RytXMTBGNWJN?=
 =?utf-8?B?TVhPQlBLMXJna2grRDVvSzg4R0IrTThaSzkxYVdXd3Y3M1V0NGZXR0lVaHRy?=
 =?utf-8?B?UGM1TDE1NDNOQzdjWlBBdGRyMFFPZCtYNmIyaGNHZXJHTFgyQXhjYVN5aDB0?=
 =?utf-8?B?dlFtQk9NQng4QUFOeE5MY2RKRytyRDhWRExyeTkzSTdRMnAydmI3amhEWS8w?=
 =?utf-8?B?cjZXdFR5c2tLdHdlQ3hqK3FTdmI4bFF0S2YvY1VjYStSMzhMaGY1WEZVTzdv?=
 =?utf-8?B?UmplQ3ZqM2w0YUdvd0d5dTM2TkFGSE4xYWZ5S0JqeHIwVEtxNW9ibEVUVTNh?=
 =?utf-8?B?cVBDNTlGZXJrUWpxMEFsdFF5TDdTdkNEdWNRbC9jZW42ZXM2aDVEWlYrOUgx?=
 =?utf-8?B?NVFIR0p1TzVNRXFFNG0yZXA5eHA0WWd1VHJ2Y25SdGR5Vk9ZSXF5Um44cUt5?=
 =?utf-8?B?QUJvZ1piMStObVdxVlpFUjNITXR6aEZQUjNkRWk4dVA5cVpCRkJpVWtRaExE?=
 =?utf-8?B?Y3VCZUhKZDRrSlpjbWxYeXN3TnhBWGFoSWRhU1VwM1J1WWpSSTZCczdtVGQy?=
 =?utf-8?B?WnhTQkNqeFpNL3BTTFdKaWFNek5DTUZzZy93RmxZeSt4K2pWNFBDMEdqbVJh?=
 =?utf-8?B?U3g3T0tOYlJkZDBna0crajIzNkMxOGsyRWZ6UEcxaktrT1J3RnZpS2ZiUk5N?=
 =?utf-8?B?NmZSRGxNdWE5Qm53cGxXVGttTDlBMDNiRFptcE02aHN6VThSWFJvVVg5S3Mw?=
 =?utf-8?B?TXJnT3ZNYm1BL0pVcGpZOFcvemkwUWJQQjhvNWt6OFlhSS9EUEdLSDY1bFRz?=
 =?utf-8?B?OVdoeTRpRVlmTUJsSExRczQ3ZWFOY0xQVmlBWW5KOExaTldOT00wdFhyY1Fp?=
 =?utf-8?Q?WWjOjOWImpCd/IHPghgjOyYitk5MYbla+AbG8+kbslLw=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eadaf618-d636-41c2-3433-08ddb9de8709
X-MS-Exchange-CrossTenant-AuthSource: TY4PR01MB13853.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 03:05:55.8340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14763

Hello util-linux mailing list

I found a bug affecting device detection of my btrfs filesystem with 3 
devices. My test system is currently running NixOS 25.05 with util-linux 
2.41. I am able to run a older version of util-linux with the command 
`nix shell github:NixOS/nixpkgs/nixos-24.11#util-linux` which doesn't 
have the bug.

The filesystem is called HDDPool-data

The output where only one device is detected


$ blkid
/dev/sdf: LABEL="Rescue3" UUID="623630d3-64d8-4917-ade8-412101d23b40" 
UUID_SUB="fa8bf8cb-a856-4ab3-9bbd-7e91aa2f5c7d" BLOCK_SIZE="4096" 
TYPE="btrfs"
/dev/sdd: LABEL="Rescue3" UUID="623630d3-64d8-4917-ade8-412101d23b40" 
UUID_SUB="13536110-8eaf-4d0c-bef5-6dac628c9e4f" BLOCK_SIZE="4096" 
TYPE="btrfs"
/dev/sdb4: LABEL="ssdpool" UUID="119c2a64-e46c-4e63-87f9-3aa3161bec03" 
UUID_SUB="6e5fac53-ae6a-465b-9f7b-cc36f584e3d3" BLOCK_SIZE="4096" 
TYPE="btrfs" PARTUUID="c2ae79a1-1e90-42a9-896b-007df274a07e"
/dev/sdb2: LABEL="RootFS" UUID="b66ce927-d4e1-4237-982a-e924c0cfde15" 
UUID_SUB="a80d43a7-cd54-4579-8720-d4c8e1563891" BLOCK_SIZE="4096" 
TYPE="btrfs" PARTUUID="fe7a32da-c3b1-4b97-80c3-3cb63b5fd8dd"
/dev/sdb9: LABEL="ssdpool" UUID="119c2a64-e46c-4e63-87f9-3aa3161bec03" 
UUID_SUB="231ab628-74ce-4e0b-a3a5-f467dfd9e11d" BLOCK_SIZE="4096" 
TYPE="btrfs" PARTUUID="b9709f1a-0676-4da2-81b5-7e10aaa599e8"
/dev/sdb7: LABEL="ssdpool" UUID="119c2a64-e46c-4e63-87f9-3aa3161bec03" 
UUID_SUB="c2339d28-19ed-4515-b230-44d697269deb" BLOCK_SIZE="4096" 
TYPE="btrfs" PARTUUID="f137692a-bae0-4d9b-9ac6-e0e5e5394df2"
/dev/sdb5: LABEL="ssdpool" UUID="119c2a64-e46c-4e63-87f9-3aa3161bec03" 
UUID_SUB="c1aff881-f902-4d68-b8f5-13751fad06b4" BLOCK_SIZE="4096" 
TYPE="btrfs" PARTUUID="3bcde9d0-728f-4989-a230-b4f26554f203"
/dev/sdb3: UUID="f2e0b6c8-d683-4a51-b2bc-7af13b7d100a" TYPE="swap" 
PARTUUID="1691a4f1-67ac-40e8-944c-55b103eafc5b"
/dev/sdb1: UUID="1EF4-5E59" BLOCK_SIZE="512" TYPE="vfat" 
PARTUUID="2ebac8c4-2714-4f2b-bb09-e2981e77ce5e"
/dev/sdb8: LABEL="ssdpool" UUID="119c2a64-e46c-4e63-87f9-3aa3161bec03" 
UUID_SUB="a3e7378e-ecee-45af-a980-c8b17d332f01" BLOCK_SIZE="4096" 
TYPE="btrfs" PARTUUID="6d991377-7202-4689-9564-6ea09cbe9445"
/dev/sdb6: LABEL="ssdpool" UUID="119c2a64-e46c-4e63-87f9-3aa3161bec03" 
UUID_SUB="b8646ac0-1010-4a20-83cb-d0e3c6e9e92d" BLOCK_SIZE="4096" 
TYPE="btrfs" PARTUUID="fe349a2d-4e8a-4f7e-9f15-90d6a02c9404"
/dev/sdg1: LABEL="HDDPool-data" 
UUID="cae95f27-f8c3-48c5-96d6-e263458efda2" 
UUID_SUB="2e280995-52c7-4e41-b0aa-11a22dd0187d" BLOCK_SIZE="4096" 
TYPE="btrfs" PARTUUID="65a68c39-46e9-e94a-9603-878003ef85c9"
/dev/sde: LABEL="Rescue3" UUID="623630d3-64d8-4917-ade8-412101d23b40" 
UUID_SUB="de2d0690-2b18-48ab-8262-66a767c389e5" BLOCK_SIZE="4096" 
TYPE="btrfs"


The output on util-linux 2.39.4 where all 3 devices are detected

$ sudo blkid
/dev/sdf: LABEL="Rescue3" UUID="623630d3-64d8-4917-ade8-412101d23b40" 
UUID_SUB="fa8bf8cb-a856-4ab3-9bbd-7e91aa2f5c7d" BLOCK_SIZE="4096" 
TYPE="btrfs"
/dev/sdd: LABEL="Rescue3" UUID="623630d3-64d8-4917-ade8-412101d23b40" 
UUID_SUB="13536110-8eaf-4d0c-bef5-6dac628c9e4f" BLOCK_SIZE="4096" 
TYPE="btrfs"
/dev/sdb4: LABEL="ssdpool" UUID="119c2a64-e46c-4e63-87f9-3aa3161bec03" 
UUID_SUB="6e5fac53-ae6a-465b-9f7b-cc36f584e3d3" BLOCK_SIZE="4096" 
TYPE="btrfs" PARTUUID="c2ae79a1-1e90-42a9-896b-007df274a07e"
/dev/sdb2: LABEL="RootFS" UUID="b66ce927-d4e1-4237-982a-e924c0cfde15" 
UUID_SUB="a80d43a7-cd54-4579-8720-d4c8e1563891" BLOCK_SIZE="4096" 
TYPE="btrfs" PARTUUID="fe7a32da-c3b1-4b97-80c3-3cb63b5fd8dd"
/dev/sdb9: LABEL="ssdpool" UUID="119c2a64-e46c-4e63-87f9-3aa3161bec03" 
UUID_SUB="231ab628-74ce-4e0b-a3a5-f467dfd9e11d" BLOCK_SIZE="4096" 
TYPE="btrfs" PARTUUID="b9709f1a-0676-4da2-81b5-7e10aaa599e8"
/dev/sdb7: LABEL="ssdpool" UUID="119c2a64-e46c-4e63-87f9-3aa3161bec03" 
UUID_SUB="c2339d28-19ed-4515-b230-44d697269deb" BLOCK_SIZE="4096" 
TYPE="btrfs" PARTUUID="f137692a-bae0-4d9b-9ac6-e0e5e5394df2"
/dev/sdb5: LABEL="ssdpool" UUID="119c2a64-e46c-4e63-87f9-3aa3161bec03" 
UUID_SUB="c1aff881-f902-4d68-b8f5-13751fad06b4" BLOCK_SIZE="4096" 
TYPE="btrfs" PARTUUID="3bcde9d0-728f-4989-a230-b4f26554f203"
/dev/sdb3: UUID="f2e0b6c8-d683-4a51-b2bc-7af13b7d100a" TYPE="swap" 
PARTUUID="1691a4f1-67ac-40e8-944c-55b103eafc5b"
/dev/sdb1: UUID="1EF4-5E59" BLOCK_SIZE="512" TYPE="vfat" 
PARTUUID="2ebac8c4-2714-4f2b-bb09-e2981e77ce5e"
/dev/sdb8: LABEL="ssdpool" UUID="119c2a64-e46c-4e63-87f9-3aa3161bec03" 
UUID_SUB="a3e7378e-ecee-45af-a980-c8b17d332f01" BLOCK_SIZE="4096" 
TYPE="btrfs" PARTUUID="6d991377-7202-4689-9564-6ea09cbe9445"
/dev/sdb6: LABEL="ssdpool" UUID="119c2a64-e46c-4e63-87f9-3aa3161bec03" 
UUID_SUB="b8646ac0-1010-4a20-83cb-d0e3c6e9e92d" BLOCK_SIZE="4096" 
TYPE="btrfs" PARTUUID="fe349a2d-4e8a-4f7e-9f15-90d6a02c9404"
/dev/sdg1: LABEL="HDDPool-data" 
UUID="cae95f27-f8c3-48c5-96d6-e263458efda2" 
UUID_SUB="2e280995-52c7-4e41-b0aa-11a22dd0187d" BLOCK_SIZE="4096" 
TYPE="btrfs" PARTUUID="65a68c39-46e9-e94a-9603-878003ef85c9"
/dev/sde: LABEL="Rescue3" UUID="623630d3-64d8-4917-ade8-412101d23b40" 
UUID_SUB="de2d0690-2b18-48ab-8262-66a767c389e5" BLOCK_SIZE="4096" 
TYPE="btrfs"
/dev/sdc2: PARTUUID="42c6b5c0-3869-4c8f-8112-b277660321cd"
/dev/sdc3: LABEL="HDDPool-data" 
UUID="cae95f27-f8c3-48c5-96d6-e263458efda2" 
UUID_SUB="6481359c-d118-4a87-8d92-32d9c205362b" BLOCK_SIZE="4096" 
TYPE="btrfs" PARTUUID="47439aab-c752-c348-bc53-47c69dcdd3b6"
/dev/sdc1: PARTUUID="5048125b-8e2d-4558-b528-17a8f6e5cd0e"
/dev/sda2: PARTUUID="3363e8af-efc0-44c7-9062-287e8fd54eb1"
/dev/sda3: LABEL="HDDPool-data" 
UUID="cae95f27-f8c3-48c5-96d6-e263458efda2" 
UUID_SUB="c33bc5b0-2e12-459a-ac95-8638e02bce67" BLOCK_SIZE="4096" 
TYPE="btrfs" PARTUUID="d3e471d0-41e4-8641-8ea0-97b469f16698"
/dev/sda1: PARTUUID="96c699ea-4e75-4ae4-8f42-bd656438bcd1"


I previously reported this problem on 
https://lore.kernel.org/linux-btrfs/TY4PR01MB13853B64BF6DB7BEA98170AE99240A@TY4PR01MB13853.jpnprd01.prod.outlook.com/T/#u 
https://bbs.archlinux.org/viewtopic.php?id=306625 and 
https://github.com/NixOS/nixpkgs/issues/408631


Mio

