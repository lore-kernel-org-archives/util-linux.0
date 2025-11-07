Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022129.outbound.protection.outlook.com [52.101.53.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E31F21257A
	for <util-linux@vger.kernel.org>; Fri,  7 Nov 2025 20:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762548495; cv=fail; b=PJyZJNKxmtCTUgatH932rpwngyR+4z9BQG0V1ERxbd3BEmx26mNjAuPJAHhMTYH46fna/estJnjUx4OG1/emodquMdah6t6o6/wHmXdKSzot6rd0jehxV0h1JL+e6ruNSqSowmyDvJfev4HfmVZq3C2YDIGdSJKrTyNL44U26Xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762548495; c=relaxed/simple;
	bh=7d3FExalVPGxImm1JjbDQ8UNcl8b/apxWNk+EA5anCg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oGoG/lqOC2N2/e+XV+OVhpyXposNw3Cdx/OaYlofhmoT1+WXo5pqlq5MJKGI/1DaQzzHvWsCpJjN+p/1ZMQakcrcJcMlhaqVFOM++r6X80fBYXfLxZ6svRgLXroJv4qi4jU49VGaQjtCoJ05Xhq0u1oNSMbPaLNm5tH4P1Q2Np8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Zd5eXjO5; arc=fail smtp.client-ip=52.101.53.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Zd5eXjO5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVOLcFS0KPA2+qbPysX1C2ccar4nA6r2o1c/Hd1MMBwng3qE11c0QT0hyt0RkJVk6+VRqkSfaPn9kZ09F2M3GNHTfLwdFxUfmR/Homdj8JOsa/emxjmWFxTiVS2pjY+ooqbEwt4Bv/2NbiCjkfccGdXq9d+C9s65WOp7Kbr5y9g/iLXI5W6gIdFY+XseLelra/UiPp7jlnekmPOPKa+C1h/51mKJwRzt2tokj9yGZ/Yf5yyOyqgO/QEV2CRuzsOOgDieL9mY5Whgt1WZDZoC3NhVHVm+dGVMj+aWH/ShNXAe7qky1/CwtpWhBPlY81g7/tg09Sa6IYks2ynmaJ89mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwWjz7U+D7b386X4/3oFwf13Kx0zCPnnCl5jWOF5I24=;
 b=FwXwCLPSae+MbWIxsG1lQtVfsjaOvSzBXNhWlj0t47rFyi2hxkD/StSfcYIxmaOnltbYxVfn2h9HddYclgCWMANUVdZnHS+2FJyHY/YWgJFwuoQQ1ocEEUaFAcz4JC76pbDBL9cZWDOc9Mh5qmJx68mksmhRwUm+7VPtHItUuNDVHAGpvc22UZeRnkdzmzxnwkCrADofhwChk95bjLi65Sz+HC/MIEEhd4KvC5n3bguJAW6zn8O9/B6vvvQCYrzYA9C3AO9KHZHJm21tXBClH1wVJealjhp5Mo62QshsXpT+MAH1jY5sPq7K+FFsRo7wLWjRfR2aykR4fmvqMjpkWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwWjz7U+D7b386X4/3oFwf13Kx0zCPnnCl5jWOF5I24=;
 b=Zd5eXjO5sZUWdi7xi1cSGIXuCupIVrSWSZTQy/Hos/0cODTbFmHvgVACWzFwiEuJTDGhVKkAtw69ScmaGxb9MU+KvTFKdmxNfqnxTfteRGajxsHJb7cbcBGSegMANNqeU9/SZLvPZmkvLgpqMrBd5omYRhGulkLasQA4Z5YLKm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA1PR01MB8179.prod.exchangelabs.com (2603:10b6:806:330::14) by
 BY1PR01MB8739.prod.exchangelabs.com (2603:10b6:a03:5a5::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.12; Fri, 7 Nov 2025 20:48:09 +0000
Received: from SA1PR01MB8179.prod.exchangelabs.com
 ([fe80::f091:2832:ffa:784d]) by SA1PR01MB8179.prod.exchangelabs.com
 ([fe80::f091:2832:ffa:784d%3]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 20:48:09 +0000
Message-ID: <a758edc3-2d4f-4e5d-8951-8aad0c3a546a@os.amperecomputing.com>
Date: Fri, 7 Nov 2025 15:48:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] lscpu-arm: Remove the "Ampere-1a" part.
To: Jeremy Linton <jeremy.linton@arm.com>, Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <20250711211648.53361-1-paul@os.amperecomputing.com>
 <20250711211648.53361-2-paul@os.amperecomputing.com>
 <crm5fcuper7bhu7iv7jbejf3rnowwo4tuwrjnutngta56dedgm@zajfg6nh2okx>
 <fb54d607-dccc-419f-b92c-7bc8514213a6@arm.com>
Content-Language: en-US
From: Paul Benoit <paul@os.amperecomputing.com>
In-Reply-To: <fb54d607-dccc-419f-b92c-7bc8514213a6@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY8P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:930:46::20) To SA1PR01MB8179.prod.exchangelabs.com
 (2603:10b6:806:330::14)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR01MB8179:EE_|BY1PR01MB8739:EE_
X-MS-Office365-Filtering-Correlation-Id: f1566c14-7df0-4c33-303f-08de1e3ef54e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGF4K2R1Z09CbXhtRWdHWW0vZ09tOW4xcXM3eGNsNkJPc0xUVExiZkR1S25X?=
 =?utf-8?B?dnFGQTVLbGhDMmNWb3FaRnUyS2taK0pKYnMzNFk4UkJlRC8vMW5sK2cxNW9B?=
 =?utf-8?B?elJSaUZaUktaSW1WcWRxWVB1ODlkQ3pkb2RmaC9WYktYaThsSHdjMVJNY01o?=
 =?utf-8?B?eDRVOGFEL0pFZXRhd2tQdEljcFVORFJrRE9xMFJXOURlNTlQUGRkRDArOUg3?=
 =?utf-8?B?Smt6bzVPWCswUExZMmJrQzlMWUM2SW9UU2c5ZXB4U1F2SXFEREg2TmEycjlP?=
 =?utf-8?B?RFlqT25qYVl6WGE1YzhpL3JNWnFIVXBnWndsNDR6cmJ2ankvU0syQVZteGl5?=
 =?utf-8?B?VWV0Z25IeDhWaUVlbS9RY0I4S1pnVXBGbXlMOERCTXlBOEdFR1hnUExvb0Mx?=
 =?utf-8?B?elRCbGdteDZmOG1NR2ZwclVSU04yRWdLRUlYdnVkZFl6UGtMTzZvQlVCRWln?=
 =?utf-8?B?RlRNUkN2b0FkdWdxdVgzTVRKekdYckN1NUhSdFRlTzB3TVd1c01yMGIrdlJO?=
 =?utf-8?B?TlRuTFgrK1psKzdIMHJkcHQ3MUVNcmxsQ0syZ3lSSTViNmMyNnJmZlN1MlNT?=
 =?utf-8?B?N3o2bVgyZ2Z5YlExQ1d2Zk5PdVRmUG9Gb1ltaW9hZjJsR0U5ZVJKbithelIw?=
 =?utf-8?B?V25DR2FkZFQ0TmU1UnJRSlliT1pmMG81eUJrNHpJeEpJZkZaTHpheWNpRjJk?=
 =?utf-8?B?VkRkMGhMM0Z2VWppY3JoV295UE5xRUV2SGg0NHMvZmVLN0lwTmdtUElYZjVq?=
 =?utf-8?B?eWtIM1BueGtjbEM5RmFUdURGaHBrMll4Snk5K1FRYjNOUThDdzJ5alVTVU9D?=
 =?utf-8?B?RUVXWG9LanNxdXp3R0VBQVhzekJzZERoa0xSTUdiRU44anRqZ244UW51b2lS?=
 =?utf-8?B?ZTJFNjQvNGpDaHI0Q0ZabHJxdHRHanBweXBTMWJIeU1jUnlPQ29JWEk5aE5p?=
 =?utf-8?B?ZVEvR3d6RjBGcDJOZGpkL09rcVQ0b0VVdVhtRVRyZ3oxd0FDQWVuR2hSc0lQ?=
 =?utf-8?B?TzVNM3gvMHlsMUVENDNrWHdweU1vdUFrMjYzTlpJa2NVSld5RFF4dVpJUVVP?=
 =?utf-8?B?U0xaYXA0eHMrSVNBN2w0L2RuNTM4enZpNkRrQ2p2dzdCQVFmNVRKZlZlVU1a?=
 =?utf-8?B?Q0Rmb05qU1JFNXg0elBXOWJaR1FON1U1MnBPU2IrTDNueldMNkJOL3FNSGtt?=
 =?utf-8?B?OW9Mb0VIcHdNTzAwNG10ZHVwL2ZCUVRJV0YzN285dXNFcU9CdUR1aUgybXh5?=
 =?utf-8?B?V0p5VDRQdll1U2xjcG9qRjR6UEMzRzg4SGlnN2pCZFFqeUN5TDEwMk5HQzI3?=
 =?utf-8?B?ZlNYWWZOd2RxeUVTemthMkhkdmZRb1JQSWI1ajdWTy80dDdrNGZlMkxjbkg3?=
 =?utf-8?B?MFZtMTdvZmh4ZzZaQTNNMmptUDhGSElTWWVBVDRBQUVCK01IYVplY0UvYUNy?=
 =?utf-8?B?d3NzVEVxTldEYnRlcXEyUzI3MmxMZ1daU1hPeGE1ckg5K3NIQXh4SHBaS3Bs?=
 =?utf-8?B?MGo0WG5QQnZmZ2lWTjA1SXRjcG9DYXBPVzJGK2tiUS93ODdJUWZRbUN0eG1o?=
 =?utf-8?B?Y0t2MngyRU9CRUp3bGJzQVBwVUcvYmlGczZ5QUhzTXFReWRPUE4vdDdBWUFj?=
 =?utf-8?B?RFF2UzdGbm9xVTFCdGJCOXFkNnVTam5ob2lNMWlENk1pN1FueWxCUmc4eDRw?=
 =?utf-8?B?NE1GcEVVZHZyZDdEVUp5ZGhQa0JLWFZFNjQzS25oZWVsWU5ES1lTWi8wbTdK?=
 =?utf-8?B?WnBmZTcxZFZ2Q3JqM2F6bkpSd3FWYmlJWFU0disvbTJGN0RGcVd2Y2dacjgx?=
 =?utf-8?B?a0NEYmhVODhyTmFaU1FCVGRMS2dQZkJ5a3Y0b2JaN0lQcm4vcUI2TnFzaVVM?=
 =?utf-8?B?SmpjdDRNYmJHM3IvZ1Q2cXRmbHYzVEtEdnlLazMwS1lCSGlLenFYUEN1MzdQ?=
 =?utf-8?B?UXhuWitsNlhXTU5YR2lXb0xSVkpGYzY1eG4vK0JhUzRENlAvRytUNjJKMXBX?=
 =?utf-8?B?ejVZclYrcjg3OTY1R2Y0NVJENjV4b21GeGhlb0dyek42cThDc1VCNjc4ZTIv?=
 =?utf-8?Q?yqTCgo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR01MB8179.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akJiMElUcmtXNjNOYU1hRDJWclczUFlJdFlEaE9jd0kxSW5ETjVuOUZrNFNF?=
 =?utf-8?B?YzZLaXY5QkxWZndvRXl5UkpqY3UwTzYvOUZLZWRvTHVmQVBqUUtQZWNYQU5h?=
 =?utf-8?B?dzd4R3ppUDVRYkhQZFdMeFJRYjZFaVRsOWZVV2JIa3pqOERTLzJJeE0rV1JX?=
 =?utf-8?B?ZXJaU3c0YTNNeTl4cTc2K0Z1Y1FOVTVtR3d6Z0RrY1U2UGJBaVdzSnRVaGxE?=
 =?utf-8?B?bFM5Nm1iT2RyVVRIZEtsOXl5aW5UdEcvOWR4NWMxYzlXdUllaXRNckk5WTVa?=
 =?utf-8?B?YlRpelRaNmh4SlBVWEJTdjNqZ1V6dG5lZnVvQTlwR0lqMWlRR2ZLNTRFN3Z1?=
 =?utf-8?B?TkVKd1o1U1NSbnVKZ1JGUmlqbGpYckh6ZGhxTU9EZXZOa2VRR0k1T3Q5aGJ1?=
 =?utf-8?B?S2phWm1DVE9oeTI3WlV6dC8wR2VDU2lqUzNneHJVTFlIdE1sT25hTUFCZ25o?=
 =?utf-8?B?eFpoZjlpcmMwK2pQUHhXMlMrbW44b09IeU90cmJWU0pmNWlLcm5wZ29aZndz?=
 =?utf-8?B?OEhOaW55ZlJKWGEzdzRyNGllL3hPeFlPRysxc2lCUVExTDMyQmhXcEVoRUVk?=
 =?utf-8?B?enJKOUdRZnJtNjNZNVdJRU9sM3cvMDdxTUdtd21TQkx6eVMwbDcxMUl0WHI0?=
 =?utf-8?B?eThMZFFxOFBXVlUvM2VlSUl3YlU3cEdHK255NlUwN015K1R2aDhyanJCalUz?=
 =?utf-8?B?RUpwQ3RRQnU1UTlZM3BYOXpwMWNpV2dJbWFGZmRnaUtpUVNJdGpKNEpFbjBv?=
 =?utf-8?B?L0NYQngxVmFXRGJ0a0wxMW5ScTFNQ1k5WmhpZ1c5V0NTQWJuUWozZEVyb0gw?=
 =?utf-8?B?aEROQzhrVzBtaHBhMGZzekdOQ1Z2aWErc1JnTk52RWFyMkNqc05menNEYTMy?=
 =?utf-8?B?WE9KVTFlclg0WTA4cjRKNUNPMytGQTArMVV3SzVacG1scW1RbXI2dForRlcy?=
 =?utf-8?B?anVINUlCaWRENC9FS3FrY2FEd1BPYzh5bHNHNXRzb0hXazRPcVZycVFIWUkw?=
 =?utf-8?B?V09ScE15eVVyTEQyWWtES1NncXA5czQrWEpiZ3ZFQzB0MzVuKzNvUjZuR2gy?=
 =?utf-8?B?U1FJaGw2KzFqaE16M2VGQzl5SXNsZGR0SVprRkgySkJBU25FcndsdU9uNFNa?=
 =?utf-8?B?V2trazJiSUtOT1R3cXFIcFovbjRiR3luM1dVbGVMQlUxQjZKd1FvdHdudUht?=
 =?utf-8?B?eFMweGVrVDFzLzhMUVovTXRqTUliR0pnZXk4T3dJaEw5ODFaTWdGRnpTTGFT?=
 =?utf-8?B?TkdPUnZ3OTdxWVlZWnJhNVQzOEZNNkx6MjdlQytLMEhKUzFlaWNDbkJmUmhl?=
 =?utf-8?B?V2JsZGdmK0ZLdVlsdWhnYjFxQ3NtaGN6NWMrR2VURU9DRG4zcHVnYWVOSCsw?=
 =?utf-8?B?Mjh6cE5lSW8rUEIxWXdISkZCRUZtRlpIeFcxeGM1NTYzcGN4cGJzODZJM2dx?=
 =?utf-8?B?ZkZMU090WGRZL012RGxFYVMyZkRMWXF6a3EzTWYwRisvd2FCMWZxZmQyL3pX?=
 =?utf-8?B?LzJQZW1LMTRzMXZzZTlLREJTTG1lS3kwcnBGcjhzdkZsb2t5WVFEcFJ4bnJk?=
 =?utf-8?B?TmRaNUhiUE9HNFB6RU1iZXRyd0taOXdqSXlyWGVaWnB3b21pbFM1cnJZdyth?=
 =?utf-8?B?em1SNVFLSkVjWjdHaDhFa0lPMExCanVVVThNOVRCcEJZUUZiSmFIc1NhYmxT?=
 =?utf-8?B?Qm9Zay9KY29QUFFkMjN5dVAwemxURS9hUU9ZVmVGYkRkWHkrL0tQdytzOW40?=
 =?utf-8?B?eUNPTlF2M1czN1cwdWVackVjTkEvWjlhSlJINWZEM2pCQ3lqUE1BUkVhUVNQ?=
 =?utf-8?B?bExkQk9BQUk0WEtQaUtxcEFDcVpaVUhpQVl1d29aQjJ2MUtLL2RNL3l0aUJD?=
 =?utf-8?B?cFBiWU9teGt6dEh6MThQZjFTNzVvQlB3OUlGQXF6d1k4TTQ4NWt4Mmh5OGVl?=
 =?utf-8?B?NUp1NGJYT0g0TlFlSGhNc1BNMG9VaEM0eHpvSS94aVNaam9lMHJEa25tUWNC?=
 =?utf-8?B?Z1d5YnZ1dFpKOGc1eitoQTA2MjJaMGpvZ2d3a2VvQTRBVXBvOFA5STRkU1hz?=
 =?utf-8?B?cGFqNzBRTGNieTdkR2hIQys1Z2Z4Vno2T2V3MVFla1V6U21xb1lRWGdqYzVn?=
 =?utf-8?B?clZiYW5xQk5iUjNybTVzNGZnbGZRRmlIU3RicUVvT1RlWUsvQmdCRFkwelc0?=
 =?utf-8?Q?FH2FCM0v6v9ZtSkWxflXG/M=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1566c14-7df0-4c33-303f-08de1e3ef54e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB8179.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 20:48:08.9746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSwH4oO3lzih+dGZ6wbHoIIrfxzTnapqUQ+e/lEeE4aFLYozdpi/FAx62u/B77qYocBH/w8zZ6dYiCjiFF0PDazMZjbX1UxRr5y990aegs0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR01MB8739

Thanks for your input Jeremy and Karel.

I apologize for taking so long to get back to this project.

On 7/14/2025 4:48 PM, Jeremy Linton wrote:
> On 7/14/25 7:16 AM, Karel Zak wrote:
>> On Fri, Jul 11, 2025 at 02:16:48PM -0700, Paul Benoit wrote:
>>> Remove the "Ampere-1a" part.  On newer Ampere Computing systems, the
>>> system/model name will be obtained from /sys/bus/soc/devices/soc0/ 
>>> machine,
>>> that is populated with the ARM SMC CC SOC_ID Name.
>>
>> If I understand correctly, there are old systems without
>> /sys/.../soc0/machine, right? The change will remove Ampere-1a from
>> the lscpu output. This sounds backward incompatible.
> 
> Thats a good point, but as I understand it, Ampere hasn't been happy 
> with the string that is there.
> 
> If its OK to break whatever scripts/etc might depend on it at the 
> moment, why not just update the string.

For SOCs using SMC CC compliant firmware, I do like that having lscpu
use /sys/bus/soc/devices/soc0/machine means that the name for a new
SMC SOC would be displayed without needing to update the lscpu part(s)
table.  Though, I'm concerned that the SMC CC SOC_ID Name won't always
be a direct mapping to a processor/cpu name.  Especially for a SOC that
contains a mix of BIG/little, performance/efficiency, and/or special
purpose cores.  When all the cores of a SOC are the same, then it is
probably ok to equate the SMC CC SOC_ID Name with the processor/cpu part 
name.

For SMC CC compliant SOCs, perhaps it makes more sense to have lscpu
display the /sys/bus/soc/devices/soc0/machine value as a new
"SOC_ID Name" value in a manner similar to the "BIOS Model name"?  Would
changes be required to lscpu to select such a "SOC_ID Name" field from
the lscpu command line, or would it be sufficient to only display this
SOC_ID Name field in lscpu modes where the detailed/complete
cpu/processor information is displayed?  If lscpu were to display the
/sys/bus/soc/devices/soc0/machines value as "SOC_ID Name", then the
Ampere cpus/processor names would need to continue to come from the
lscpu part(s) table. Though, The existing names in the "ampere_part"
table would still need to change.

> 
> Then invert the check so that the /sys/bus entry is preferred?

Prior to my V1 lscpu patch, when I first made some lscpu changes as a
way to test the SMC CC SOC_ID Name kernel changes, I had originally been
checking for /sys/bus/soc/devices/soc0/machine before looking for an
entry in the part(s) table.  My concern with that was for the non-SMC
SOCs, for which there was both a part(s) table entry and
/sys/bus/soc/devices/soc0/machine was set.  If the string in the part(s)
table was not the same as the /sys/bus/soc/devices/soc0/machine string,
lscpu would then be displaying a different string than it had in the
past.  That is why my V1 patch switched to using the
/sys/bus/soc/devices/soc0/machine value only if there wasn't an entry
in the part(s) table.  A way to reduce the risk, of now using
/sys/bus/soc/devices/soc0/machine instead of the part(s) table entry for
a non-SMC SOC, would be for lscpu to only use the
/sys/bus/soc/devices/soc0/machine value if the value of
/sys/devices/soc0/soc_id starts with "jep106:".
Documentation/ABI/testing/sysfs-devices-soc in the Linux kernel tree
says
     "On many of ARM based silicon with SMCCC v1.2+ compliant firmware
     this will contain the SOC ID appended to the family attribute
     to ensure there is no conflict in this namespace across various
     vendors. The format is "jep106:XXYY:ZZZZ" where XX is identity
     code, YY is continuation code and ZZZZ is the SOC ID."

A search of the Linux kernel code confirms that only
drivers/firmware/smccc/soc_id.c is generating/using the "jep106:"
string.
