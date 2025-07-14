Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2119.outbound.protection.outlook.com [40.107.220.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE33C27815E
	for <util-linux@vger.kernel.org>; Mon, 14 Jul 2025 22:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752531759; cv=fail; b=ufBmlVUj6cRXsGRf4vi/0rNAb+8nup4unspnQS0T75NIAjAWX/GpyG5gnQ/FMeWqiCdWUpvmIBkL/kNRVgXszFbk8JzFfvoMWof/eVvZ/t2mlXcKNiG+B0RghYwi1NlbWPlQkUqCuv+lEMv7phrASqv6G1EF75aE56vveEKxJf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752531759; c=relaxed/simple;
	bh=ZnYNZUjtDEuOVkaxGsmORUSyPdDysplESs2GOdXKbwQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o6XsXGTVsFr4O6+M8DwP0T4o30eIXh3GenpieTAiuwCtvvqN2uvBNdNDw0o0rw41qqn72JOJD7ijfH8umyRB7WY4O+0E9QPDaF5tCTEz7UgRVU9Wt1O/SP7chSLqY2qos//NPnXsPhmr9ucOV3J/3KA3uKT3+8IQxlfJ9FDGR90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=inF6gxbb; arc=fail smtp.client-ip=40.107.220.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="inF6gxbb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSA3nvIIWKuXHyogRAPndw8hd/5ONLx9affoehN6F9pk02pi9i3OyoWaS3knBA2WLM4/FSfXSRizvZzPs8NFMZMonSsnLRbxhsynpXV5fGvLL9YdGIA8gvNxWV0kbCzMt4wSaKb5MFqu/YTrURbhseOWEolryKY/xiuKmkP7h0a+kQA981cCEb/y01fqjUdnN3mfKN60V7rQ7NJXLvWU6Ek1iEZY46SU7n0nWi6EjjhCB4xCRgXKJJHxkSLFvsT04RY8GqYOkoCvcpADegCi1W+1wMeFrq0tqPS6FXtvvgRx+suTswjNNwDf/cL6FDMfYhjQBPqasrQbjz2zDN0zxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feykHAttJKR76KYfkg0ewH5xXyX/X7GEqBlG7kA2DRM=;
 b=hlSntVfWKmawQZIVe7unw4qeW42JmaUBY2fqjoXdTyoXHIYx68LiaHKl1dLWq70zzGosaRLwFiJvzlYL6B6tPZc4lI+qHHt12/U8r+MTau3iX3gUqpMZLGLuaE8HRMbXdPyM6WKyv3bsrreMSXjwMHumVMyDOcZBAJpSmZ9f7+pOqAfoZdphgNw9OUzZyXXdHDEnL76GEpABJXi6tH/84ZalSILkGulhbgEerHBaDSlWUCky0gWXhan2guwZrQvEIR5EElBtAdwkD1OZxIIK+sY0mFUJ8I8KYZkRTqwMJvB11WizRmF5Qvwtc1J2jMDcY+a94BjkHST+hITA50QB4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feykHAttJKR76KYfkg0ewH5xXyX/X7GEqBlG7kA2DRM=;
 b=inF6gxbbJVJ/1y7uNgG1spKMzK15c3gFrXP6hyWbja1F+WcnMFMFiJxlJIpW9CjbXcVCQ8Oce1ktSZ/F3u/PGmwYflhu2/WJ1+dFvfoc/mw8tpG6BKbRjktnz5TvV4wBNcIn5AeM2LQdT1hl1Qtmy/COrJ8BFpgsqLZovOa1uRM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DS2PR01MB9326.prod.exchangelabs.com (2603:10b6:8:276::8) by
 LV9PR01MB9398.prod.exchangelabs.com (2603:10b6:408:2ed::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.33; Mon, 14 Jul 2025 22:22:33 +0000
Received: from DS2PR01MB9326.prod.exchangelabs.com
 ([fe80::df8c:5f9d:8d38:e60b]) by DS2PR01MB9326.prod.exchangelabs.com
 ([fe80::df8c:5f9d:8d38:e60b%6]) with mapi id 15.20.8901.024; Mon, 14 Jul 2025
 22:22:33 +0000
Message-ID: <eadbcad4-6392-4429-ab6c-8b820fcbd3dd@os.amperecomputing.com>
Date: Mon, 14 Jul 2025 18:22:28 -0400
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
X-ClientProxiedBy: SA1P222CA0144.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::22) To DS2PR01MB9326.prod.exchangelabs.com
 (2603:10b6:8:276::8)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR01MB9326:EE_|LV9PR01MB9398:EE_
X-MS-Office365-Filtering-Correlation-Id: fe6585ef-0f98-41a6-c791-08ddc324edd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2dwNTRSVCtKY3QwcUJ1TmNMTWdVRzhXOTVHTGxmaXkwMEhYZ3I3bS9oWC9v?=
 =?utf-8?B?T0JHVTZvSFR4UnduampiS2RvOGt0YzhnZkduMHNaUXRFK1JDcUhtVU9CVU04?=
 =?utf-8?B?MGZvVXhuZ1duVnFEVUNldk1LK1Zlai9oRmJrcTZQaWpIajRvRWQ2R3hBWHBO?=
 =?utf-8?B?RWttd080dFA4YXRXempvYUpVZTJvU1ZHWmJDZkdTK2tqbk1FdmdFbWtBQ3kv?=
 =?utf-8?B?QThOK25lRld6cGZzNi9waGpoOE9qNkx3U0Z3TTZMazhKS0tya0ZFSTgxd2xl?=
 =?utf-8?B?R0JmSFZKWTR2NkVTYVZVOWNKckxrNWE4eVJlOHBkaCs0Q3J6UUtUMUNUcjFX?=
 =?utf-8?B?anRxd3RqcHVRanZmMTBwREErbERic1QzUXZMTjh6Z1p5bTBDVjE4cGMvVEgx?=
 =?utf-8?B?bmVjZkNxNlhSVVR1V3NIQlBWVTB5MDd5SXpPVjFJckFkZC9uMVNINytEdERz?=
 =?utf-8?B?M1RjMEEzQ0tRYmVsVVdBRk1XaHRtdHhTQmNkMkM3N2RlOWx3VmxmbXorby9L?=
 =?utf-8?B?Mko4T0IyeFpwaVVOWmdnbmp1N09IcUJUUnRXTG9yQUJtaVV2V1Jma0cvN3NW?=
 =?utf-8?B?amR6cHY5VWwwb20xNXBNb09xOUk0L1lQSXNucUhLMEJIWjRqSUJlRjV6RUNV?=
 =?utf-8?B?MDFSSm9pelk5KzBRRVN1bE5Ebk5KWnNqaENtNzlabjdvL0tyYXI2L0dYd2pa?=
 =?utf-8?B?dkRvbWk5TVkzeG8wcmFKNm1kVXFIN3NocnI2UzcwdzNlT3I3SzB1UnFkUm1O?=
 =?utf-8?B?aG5uVGVCdlNpdXhpcklVa0tiWEczSUcveFRkN2JWWUVrcmxMTTV1ek56cmFp?=
 =?utf-8?B?MUQzb2xzelFYRTZuTFNINVoxRUJsL1ZQSlYzUlZLcElaUUxuN0RUMGRhbE9E?=
 =?utf-8?B?MG4yeEtocG0wcEpSWlRFL2VBZlV1UmlVb0dSdmZpMFdNNlFQYTc5bjlyZWQ5?=
 =?utf-8?B?blhzdzZLcWJXbnh6dGtnMUN2V0tMSW9hUVVtRmtZbzhaWjFGS24wSlhnL1Fk?=
 =?utf-8?B?WDRhMG9pUmdzN1lmUlJnQ29jOUZOYjBYRWNYTTd4SkgwbWdBbUFXZXBnaFBU?=
 =?utf-8?B?TDZkdmk3TGJPdGVjUGVyNmova2grdzRQTFBoei91WWJFWVdFaU9BbnFLeS9Q?=
 =?utf-8?B?d2NTTUFwVHg3Y21waUI3SkNCenIrSHRXSzBjT0lYeE9ISVV5OUN2S3Vreitv?=
 =?utf-8?B?YTlXUjlSK3lnVm1McWlSRTd1QnE0UUM4bkhpOFZqOEJZcG1jUllpMDA5YUFm?=
 =?utf-8?B?TEtVMjlhU2MxaTRIQ0Z5MlcyNnQzYXNsZVlUby9SOWc2Vk9pSkFpRXV6YlpN?=
 =?utf-8?B?QWw5b2xzN21DSnc2WUdIcTJJMEsrYTV4UTQ4dkJ5aGU2djZCazcrVjFYTy9s?=
 =?utf-8?B?R3JBWUNLQjkwQWpiYlJJR1NRWDlnelBOb0VsNHAyM2drRVUrVUFzNkROUHNG?=
 =?utf-8?B?dDI1QjQxbGJZTlBTaUZnbTNwK1NSSXBDOEVLL1krN0d0aGR2ZDExc3NuSnVw?=
 =?utf-8?B?MkJQdkNqbUppajMzWEYxQ2ZiQVhVRFNOTVZqWDI5cGs2TTdyUTFCR05pSjNS?=
 =?utf-8?B?dXg4UUcwa2lwQ0hzTy9qSzZqcWo0V2NmaHBYVlE2c09YRTNSWktlS09qejJi?=
 =?utf-8?B?YWlsM1dNYzJWYjBUREtNRzlMWmYzMkRWWW1pVEl3WWYxUS9yM0xwcXhEUFpK?=
 =?utf-8?B?OWZpTEREeHIzUCtJckVIbjVIVk5oVlQ3TmEwckJieTlsZW4rWU1SeGVZVVV2?=
 =?utf-8?B?WldhbUNrNVBtdFo1aG51VkpBWTJxVzJqSXA3WEpOak9YQlhSVlpUQ29DVEdr?=
 =?utf-8?B?ZUw3M2YzTW1NaHQvU0VLYVdrU0d3LzR2MWNpY3hLNFZVRlA3UitFOWJrMGlD?=
 =?utf-8?B?eHRjRTNCVHJWNXIxS3h1a0pUNnA5d1lvU2ZpQ0I3OG9hK2theW5CTVRuVGtR?=
 =?utf-8?B?K1d1c3N2TmpUQ3ZmN3lvZ0ZQNTh3aElsSnArOUdPTytiWDJ3ckM4NE1uVnAy?=
 =?utf-8?B?Nm43aERkVG9nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR01MB9326.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkdzbnBXM253NUJSLzUxekJZMFBEeDJQc2FmZU9HSmxVUXdDOVU0STNDcmNG?=
 =?utf-8?B?R3c0MDg2V21Qc05pYll0Wm81TVBvS3FuaWxzejRGMjNQYzZ5eUo3T01QVjk5?=
 =?utf-8?B?amRSRjBTWTNZUU1Nd1RlWHA0UEU1bWpnNnJVTDFmd2RpTDV3UEtsclQzTTdq?=
 =?utf-8?B?eEtOOTdNWDEwUFdLU1FHS0pMdjhtbGpnb3ZBeHYxQkVvRGlSQU1GQlNzR0dP?=
 =?utf-8?B?S1lXejRjYXVUWUlvbTIxMCt4V09sWWh1UjI2Ynk1dkRGYTRjdE9BNUx6VEkv?=
 =?utf-8?B?V05uZXFpSGJmay9jV0pjVGNZTW1WRmhiT2g1WEUvN1BoWmo2anhkU1Vsc2pY?=
 =?utf-8?B?UHRibHFxazRNZUlsTlR5UEFmK3lMSmUwcHhFVyswNGI5eXRnN1M5MW1TTmlq?=
 =?utf-8?B?OEJlb0cyTHJka2pPOWQxV3lFMTRqWUtjYkl6bkc3Z1dqeGlUT3dJZGJKVjVj?=
 =?utf-8?B?UDVheE9ubzZFTURZUUZXZjUwbE42d2tDL25EZG5CNHdGWDJIMWE3U3lOdUR2?=
 =?utf-8?B?blpzWTZKRXptbDNGYS9jZ1lsVTRpQ1o1SjV4a0pJRHlyRHhhV3VrTk1NNjNo?=
 =?utf-8?B?a09hZmlCTzZQWDRBNHRrSU5uZDdWQk9lOHUxMXUxK3lMZDlpSXBhOUk0V1Vo?=
 =?utf-8?B?R2ZLMFcxdm0wZ1hFYWw0Ulp5YmVRN1MrUElndzlGZHZnUGJBclVlQ0tDR0gr?=
 =?utf-8?B?cVhxK01Oc1ZCc3YxVUowcTJzZFlEQ0VieHNyMXJ3YkRpc0NVb0FMemM3ZHJh?=
 =?utf-8?B?YnMrNXBya2xOMDczRWhhSXVzdUxINlFsdHJsalBFWXFPYW5EbFErTTJ4NXZT?=
 =?utf-8?B?RFpzczJXNExXTFEzY2ljMTNFMFhTN2lyUTY2M3lvc1hMZUFjMXk5c1RzMUJ4?=
 =?utf-8?B?RmVwaTUydXVXc0VXSWlzSGtHdEdGZFdkY0JXdnZoeDJqcVhPMWdNYXBrV0hS?=
 =?utf-8?B?d1RtazBpWGozYTQ0aWVUeHpMblhTdVcxZUVDTjNWNFNKajBrUjVIUGlwVTZ6?=
 =?utf-8?B?WWpGaE1VMHVBKytLOHI1cnNGOHZCNzhiRVRsTWFzQ0IvNHFQN1d1anJRT1BF?=
 =?utf-8?B?NS9nYXVWUTM5SVRyZ29BamhEVGJ6U2ZTZEFXZlhtNmF2STdPeHpBTjFWLy92?=
 =?utf-8?B?OElaZC91QWdiVXJkVmRLS1VtRzV2a0dpYTlRb01BdUZ3cFpaV2w0K28rcFJG?=
 =?utf-8?B?RDlFV1c1UWwrTjRhYXIwQnl2OGMvS1pUQndXYWRvTEpXS0s0bFVTMHFoaFhT?=
 =?utf-8?B?dTVFcVFHM1ZmaWVVRnY0NExWUXYxNytWWUJDdjM1VXZwZEFSYmZPcHRnUHQ0?=
 =?utf-8?B?OUJObEE2U0lhN1VkUDFVUklEVnJIVzQ3c0VuMmRFVmxzYVNzY3FKbFpRd2U0?=
 =?utf-8?B?QVVQTXZXVEdvOGxicnJRSmFqdXc5WFBIL2xXMnhvSnI0TEVLSFpwb1B4TlI0?=
 =?utf-8?B?T0VDNUhaeExwQUFUVEMvYnREUllHRmFNQzBSbVlRQjV1ME5neDlUMWhFVHVs?=
 =?utf-8?B?bDYraWtZdVduQXppcmJ1My9TN3pld08rT0t1bCsybXVtblZqZE5YOVpJTzVV?=
 =?utf-8?B?RGNVYUJsVDBnTmdhaVNTaStHQml6V05XdDlsT1VMeUN5S0RMNHpCdlVzRmEr?=
 =?utf-8?B?cWFDN3BINmpUa29YWVFJa0lTYjhENFlyaE52ZzNzcmxLSnhUSkF2eG01QVk4?=
 =?utf-8?B?WHJvckR5aS9ZWEpIK1cxSVhMdFFHMUpicGxvNEpxZU0zSnV4dEdJVXh5SkJ3?=
 =?utf-8?B?a2UyZHpQMEdWNG1BUXBEclZpRUwwMWNqZzBJNVh5Y2JuZXMwWXc1NVY1LzBC?=
 =?utf-8?B?cEU0M0o1ZnRNcWlzQndXNmozWnpJY21paVBNdTJRWS9HQmJKejFqWEVnY1Fm?=
 =?utf-8?B?cWI5aWQ3TUNHand2QVhUQjhGWHA1SUxIWGJEd05jRjZtRXpUSFM5NWFSbnRk?=
 =?utf-8?B?VDJpWkQrSzdTd2FrNlAwam5Cbk9oTUpoTDQzSTZaODhEM25Id0krVDZiUFVZ?=
 =?utf-8?B?Vml3eUxxdW9vYkpsVUY0VGpZSGkzcFRNVXJnZGdTdjNxcHAyM2JGZTZzU0Zn?=
 =?utf-8?B?bUJRdHFXL1ZDaU1RNmJLV1FxOUNKTkduU0piWi9YbE8xaGRCYlhCT1Fyb2cx?=
 =?utf-8?B?ZjdQQk1NTnkyMldaWmE4YldWelFqRVAwdllSZ2crVWdzeW1VZnFYNzR4ZHhR?=
 =?utf-8?Q?usBmSG+vaVe31NBWKx0XDqY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6585ef-0f98-41a6-c791-08ddc324edd9
X-MS-Exchange-CrossTenant-AuthSource: DS2PR01MB9326.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 22:22:33.5638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pcjUewViGw7ogolLA2L2a8o26kPVNZU5jfC9XgmuqCZP4X8gjAZSmsynu/ftdp03WAXcPOJc1ljQKHFyNcFIszLnvH3wkB+2zw+ZAlwVwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR01MB9398

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

Hi Jeremy and Karel,

While I haven't personally been part of those discussions, that's also
my understanding of the situation.

> If its OK to break whatever scripts/etc might depend on it at the 
> moment, why not just update the string.
> 

That's becoming even more tempting given the valid issues that you and
Karel have identified with my patch.  Though, the nice thing about lscpu
picking up the Model name, from somewhere like
/sys/bus/soc/devices/soc0/, is that lscpu will be able to output the
model name of newly released processors without/before them needing to
be added to the lscpu part(s) table.  That assumes a kernel where either
the ARM SMC CC SOC_ID (Name) handling code, or the support code for a
specific SOC, set the Model name from which /sys/bus/soc/devices/soc0/
gets set.

> Then invert the check so that the /sys/bus entry is preferred?
> 

That's the way I had originally coded things, but I was concerned about
the change in behavior of having the /sys/bus/soc/devices/soc0/ value
override the established part(s) table names for non-Ampere processors.
