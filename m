Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4C1BA33
	for <util-linux@vger.kernel.org>; Wed,  5 Mar 2025 02:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741141441; cv=fail; b=kRuFFaQBm92dRiZlgApkw6F6DlwfC00rbGdMNPaoKTG/tUv6PX3HCC/TvMbFH2O7+HWxAjeeUkFfzBtJPTa6tvW7GuvPie9MP0ZKaw7uMV5R4CCBK/nDjD7wzmYs5xpLsP2eyqsFbM/ISF+TdgeqxjClXF26ZQnGx072ilGQ8Fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741141441; c=relaxed/simple;
	bh=Jg8Sj4zei6vgkJVkRLmbtzkg2kbu6WxNOofQ0PVJzJg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mNHAlClALICgV+BzhN6p4zTlE5Uz9mzbgCcz2k4A+wq/IbHLmN0fC2zR5CdMAxEmLwp1IryjNYAamZM+7oN5wws1UYUOqL3ZO1GIDY/XuK1m97PLoxci08FDFbXBX9KxEaiHFV6UwqHg4iM8oZVC/ySXDthhTnkm0oLF5xMXpNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dghxd/Su; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bHb5i5El; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dghxd/Su";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bHb5i5El"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5251Oi9L030136;
	Wed, 5 Mar 2025 02:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=vVYFYs2vRUF+h3jKAz5ITqXdDbSt8VjsbNufbIwi4xE=; b=
	dghxd/SuZzA7tUwyEYH/kAB8BdlfpmkveZUYJJMJvg9GD9OtA7czxEy/BmBiLXkr
	AsM+tRfmFeQrxHQvnJRoikvZ9jH1kOa5GqfRFUeUI0OkLrsgx+et1sAk4JemnIwn
	A8/ZH3kfoWbO5rK0G2tc9MKx/ocn3UJIxTzMyTvKms9fduNVTh95jScW5sgvE9E3
	yucBFXVpoaDmTtDw1PZ+kn8aH7BWv7NxXkIfUKfaAm4qaZahSgQcPsBsRnw8ZYr4
	49aZqkNZwyDkq9RHWl7tlBlIGDJ18YhyAVg6sFIJlFmDzpdDVI+B6dxsvhIdQ0MP
	wJobyIqfuaUve/G4x6/Evg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u9qek4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 02:23:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 524NlGGe040417;
	Wed, 5 Mar 2025 02:23:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpg241w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 02:23:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ezwMaSF1HdoD01mQkYIgLtJcHDtWSsL7MZXlsHyb5TKBZXtorPmpvAnoxfRfSq2lDDFRNmvXAXukqzuYwnaXIiYG7kG4nsdskBvEIGKaUBSiLjarHBgLljL2e0r5sKmLdPfygkF2eLMdihpOlbvPDbSZ5EkDNpYvvGHsA5D431XAuKI2WbXMkVUU+0sR1TRKDVWuFSIBKuxTar0clGHWFpwmO3CNJ+OCJgGhb7ObsbJga1PvG4qSl4aAII3qCEGRsLG/24ECHtP7rohFzWxscqctL6xlvqWTFRHNxw4K3qQGywBVRJvkDD3ZCC4Wkk4Klk0Cms5YvTebJ3m4GGlGdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVYFYs2vRUF+h3jKAz5ITqXdDbSt8VjsbNufbIwi4xE=;
 b=olLvUTN6RyujuuL+uUjH3ZtSS2IRfDkE6MEeKpYUa4r6h4kem+gAt97HpffKpuGB6UAqKCqHDK0fXzMCXedWUNbA0miLacUwoSAC8vKekptYXUPdqBfTO6se9P+zKP2PnATwzDRi6CjtlvG6tmnMlLabpLTaNBMGN/ywTDqNwzlBxpumZ1LuE1xfJQpwg0zm4KaYEipVcUV3lwZj6Bj/WLuQEdvdDcdZ7PTK2AX3jJwqW0hH6gjqC73WScVs1wWgZwVch7oRs870CIui4Il94yjdrkDmCmemc+Cv3caKnpRRBNzb+PKlgLo8a0BkmJrVhH7/XwuQcfKSn2VreYRc3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVYFYs2vRUF+h3jKAz5ITqXdDbSt8VjsbNufbIwi4xE=;
 b=bHb5i5ElTsJjcudY2UT4jJO6qW4L662V2ws91eVwOwILbjwX+zwCGX622m8fUpuppxjnqWWhrSoGRm2336PvilHk503R8+nwjWGqAzJIMFPfQnMe/cDkkVCFDGIFNkoRzBJMVjqOSWGZS4kCtCO0jjB6nLcMwYv6pRzNEI1NJgo=
Received: from BLAPR10MB4931.namprd10.prod.outlook.com (2603:10b6:208:331::6)
 by SJ0PR10MB5600.namprd10.prod.outlook.com (2603:10b6:a03:3dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 02:23:40 +0000
Received: from BLAPR10MB4931.namprd10.prod.outlook.com
 ([fe80::2ec9:a98e:942c:3cbf]) by BLAPR10MB4931.namprd10.prod.outlook.com
 ([fe80::2ec9:a98e:942c:3cbf%7]) with mapi id 15.20.8489.028; Wed, 5 Mar 2025
 02:23:40 +0000
Message-ID: <ed9678f8-f22e-4b86-9890-b01735ad4ba2@oracle.com>
Date: Tue, 4 Mar 2025 18:23:38 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/4] irqtop,lsirq: Miscellaneous enhancements
To: Karel Zak <kzak@redhat.com>
Cc: Zhenwei Pi <pizhenwei@bytedance.com>, Sami Kerola <kerolasa@iki.fi>,
        util-linux@vger.kernel.org
References: <20250228161334.82987-1-joe.jin@oracle.com>
 <slmym5tvcnf5evhcbgydkhnfhexmoqrv5wsmzrpg2uafdicxcw@2akbzvezgsam>
Content-Language: en-US
From: Joe Jin <joe.jin@oracle.com>
In-Reply-To: <slmym5tvcnf5evhcbgydkhnfhexmoqrv5wsmzrpg2uafdicxcw@2akbzvezgsam>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0896.namprd03.prod.outlook.com
 (2603:10b6:408:13c::31) To BLAPR10MB4931.namprd10.prod.outlook.com
 (2603:10b6:208:331::6)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4931:EE_|SJ0PR10MB5600:EE_
X-MS-Office365-Filtering-Correlation-Id: 56a4c89c-08cc-4d7e-605d-08dd5b8cbe0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTRObmQ4eEZwa1B1SkRta2lvR28wVndLNGtSSXVOajk4TTh1ZVhXYnZaQWxw?=
 =?utf-8?B?ai9FMjRtenhXdmVNNDc2cTNvN1FnRCtiODcwQ2dPK01MdFM5Mm9LQ080VXlF?=
 =?utf-8?B?bHpUYzR5SVpSby9VMVFSQTJFVVdRSzdGUHFHTVZWUEluc3hIU3U0TFUzMjZX?=
 =?utf-8?B?Q2Zpa2orVnRCVi90Umc0TEphVWVRY1JHL2Nvd00zdzRDZG51Q0lHQlhjOTVK?=
 =?utf-8?B?SE80d0U5bHZZK25VZmVYRlNwZ09YbGI2VXpmUzZBMjdZQzVkR3hHWUZGNFZB?=
 =?utf-8?B?TW1lSGVTTmY3K2YrU21IUHdwSXZFTEw1RWJMYmFrc25nVW5lSDVQWXhmcEp4?=
 =?utf-8?B?VEpHdHpnQmNTTUdtRGI1TzdJZHUyUUJEWkZyRjR1ajVqTlgwR2VmdlJtWFpt?=
 =?utf-8?B?WHJwUVNlTDhjVFBBeERIQnMrMSt1OC96SEFIZHdmdnBweG5aNFBlUC8zeWUz?=
 =?utf-8?B?cStqSzcvUUxqejdBUTVON2dLWG9lWThtcEdtL3RDaW9XNmpNVTA5eTV4WFYw?=
 =?utf-8?B?ckdocks0WHdMRzdFb0V5WWVhNzJ0c2x3WnRhRHhXV0syV2JoSVRrY05Lamcx?=
 =?utf-8?B?RW8xbUI4bkVSMEozcGV6NkJqMWZiamhqOE16NGtQZThWM2RLZjNPaGNRNTZX?=
 =?utf-8?B?ZGRxbHR5ZmJBb3ExUFdoakFVZCtsaDJPYkVVNUFKQVliWDNLVkQ2a28rZWx3?=
 =?utf-8?B?b1VhblppaGJBTW9BU3ZoRHRESEk3NVVudmJXTmllRUI3SUxrYVZDWk01NktT?=
 =?utf-8?B?ZVR2RWc4eU5CbG5BT1MycWlrd3A3Q1BPT0tXbmp1ejdYY3VnTnhBWnVJdnRk?=
 =?utf-8?B?WTBWYXdDcFRiZU1KdGd4VDNvd2pPQlFLVHRkOUJNQmw0TE8vd0lWRXFleksv?=
 =?utf-8?B?Y3ZqdmcvcUdpVnhXSDF3aXVOMTZ5Z09EbFJhS0tmYnVtcmcxcnFjR2tMdzVZ?=
 =?utf-8?B?Wll1Smd1bUViaDlXdzViK1pCUzZmWTNJUStEaTNiQ1haelN0ei9HSmgzZlFT?=
 =?utf-8?B?bHFJdW82NTlKVm90VURNOTBqeWI2SUQ5NUJTekZvb3RkTFFvZ3V4TEY1bVRG?=
 =?utf-8?B?Mzk5Z2MxdkJnNFA1SC9ydldtYnZMcklMSzFmZjhtcEtmWm1ROWhURTV2YUhr?=
 =?utf-8?B?bEVSMkRzV2ZiUjhLQzJ3NEUxeXdSeGhYQkZhS3hnWWthazd0dGh0Z2U3Rzhw?=
 =?utf-8?B?VEpBU3J1SllBUTEyUzh6bUI1SVY0enM0bDJLUmNzWVBkLzQyeDZSR1licU9O?=
 =?utf-8?B?dU1RcUU4c2xoYVdLRms4aGMzRnB4ZFVYR0RlUG5XQkU2TXgrancwV3I0VU9L?=
 =?utf-8?B?SlU0YkplZnYyN0JZdWdSQzBCelErOWkzRENMbnZtcjY0Z2NFSkw2L0NhdWJ4?=
 =?utf-8?B?WXV0aVVoZlYzWHRpVjQwVzZXRDQ0TW5BWnpsTWkvRXB3cktMMDlGeWxTRVgx?=
 =?utf-8?B?Q1Y3UjVDKzBSVnlmd1V1MXdaNE1XNkJLdklnWlFIODNsNnI2RFl4TkNHLzA4?=
 =?utf-8?B?OU9tRkwwWDFVM0hjTVZ5cHlwdk1PYkRMeklFNmQxWEVpVGdDQStYdFNtUlor?=
 =?utf-8?B?L3NIK2ROMG16N1A0bis3QUJLd0dFNlRheDltNjgvczFLcWVZVUJheklXQ2dF?=
 =?utf-8?B?bWwzTTc5S0Q1TkwvTDk1SW4yWTF2SWhSREMvUS96bmpmaHJGWWo0clM1WSta?=
 =?utf-8?B?RU1XV2FIUml4Sk5tbW4ybGU3S0dwR3VCN2o0QVZNbmRDMERmUC9jY2lrNmFi?=
 =?utf-8?B?Nm5salMrZUVOTmhVbHZZdGdpaStJM29FOXNFWWFuUjErQnViODIyTWZjc2N4?=
 =?utf-8?B?c1NBcGVJcDJGcVA4SjFXWVpacU1uZ2xNTVc4eEwvam8wQUZVTHhpNmdFdGxy?=
 =?utf-8?Q?l+fzM80bm2TtG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4931.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVFxdWVBeVhCcXVDNURTZDVaUG5mcVRuR3k1ZUVnN0lRSUp3VnZHdGJyTWhI?=
 =?utf-8?B?U0pyVEo2NlMySXlNbklmWVRHbzliMGVSUzNmWFh6MTBXVnJhMVRUYWgzczlJ?=
 =?utf-8?B?TVcrQVg3R2dSdDhraTRWdDVyN3ZVWklyQ3VrU013MFJlS0RwR3lod2puNFNN?=
 =?utf-8?B?T2NQbUdReUd5NW9SQ3JKNTlSdnBjcVBBZTVlOU5Ta0ltQnZaQjBZanlaK2xL?=
 =?utf-8?B?MkYzWDFpNTFoRGlKcnl5Yi85WGk1MjhwNHljc0ZoVHY3Yks0MGVJNkdhZXdK?=
 =?utf-8?B?TCtQMzIyWmREMlUyZnF6YlRYd1BTZnRwR2hWT1FNakhON2xWeUxYNE5DYjdQ?=
 =?utf-8?B?aTR1ZVZ0U0dsOXpxZkl5TVc3cGJSRkJ2K1JZeVowMzlxQmU2VFI2MGZsSzFY?=
 =?utf-8?B?MzlHS0NuL29wMkNJVWVTSGNlRE1Fd1pPSXZYYmpSbExNMzJjY2hkK2JtQ1N0?=
 =?utf-8?B?endHajRGZVR0L3dMN1NEZkhQa21oaEdpeHM3SGlvUlR2UDhNM0FZUlFoTm84?=
 =?utf-8?B?em9XUEJDUHg4OWVPdWxvMm9zYUxKNnR5a1VPVlNObFpZbDZxY3RQdmpZc0E2?=
 =?utf-8?B?RDNuNGZ4UFdJb2VIV1U2OWh0clZGRE5MNnJkQXF6TUhVbUNNRXJteksyYjk5?=
 =?utf-8?B?d0VSd01LN3dIQm40R2pMNnppZkJ3NjlMME1UT1d4QmRJUEtkN3VMWmxNRlM3?=
 =?utf-8?B?ZjdaTTdLOWV3QjQyb09TTDZ2cmVLWGhENkZRREtzTXJsQWp0NDdNRVVKY1l0?=
 =?utf-8?B?TEpvbWtPbWg1SGNUZGlIczlpZXV2VDZXOWZZRFhFYW1XRDg3YUc2a0RiWTg5?=
 =?utf-8?B?WGxBenZMVFZnMktkVklyK1E3c29yRmcyVmhjaVI0SHVkY0NhV3BxOXVwTGpQ?=
 =?utf-8?B?cTAyS2hCSktVeFJjNzI2RlV2MnNsV1U4VkQxWDAwZFlPVmV2MFdTQWlIaXVN?=
 =?utf-8?B?Qm04SC83MTZQTlI1Rm5LYzVMbHJKWVF6KzRwUkFsVWJWZWdHQ1RCQ2hWV3Qw?=
 =?utf-8?B?OHRkWjNCVWJpQW1qWGhlc0dRamVrTytObGNTM1pwS3FXVjEyd0ZFdWlVYUUy?=
 =?utf-8?B?ZnpCa2M1NGY4NGVkMHZ3UDRzRG1wWTRUNWk4TE11ampZNnAyTER3SDdiMnA2?=
 =?utf-8?B?NkgrVTN0M2hHUU5mWE9mdDJ3ZGRxSm5DUHYzdEJoZlBUMGJ6dW1EUjh2bHpE?=
 =?utf-8?B?VWZvSTRyUkVkT2sxTkhUTWY3dnhvcEU0bkEzRGhqSUhRMUJjSks0UGtaS1lD?=
 =?utf-8?B?ZEZiS1NKWG5PSWd5czZsYlBwZmg3TUxPOStvSkhSQk1MeHZUQTNscU5qaStO?=
 =?utf-8?B?WWR3STZEWDByN2JpU1VwMGJocTRtd3FwTkdMQUJHNGJUWDBmK3hQMlVDMnpL?=
 =?utf-8?B?Z2NkUzZ3M2tmQ1VlT2dKMTErblFBTGpJYlgwYlhTVE56djVmVFdGMmM5aElT?=
 =?utf-8?B?QjQrR3hyV2lnK09XMzRuZmJQNXF4WlZZUHI0bWs3cE5ML01Yd1pYVmJrQkt4?=
 =?utf-8?B?eW9IU3NFVno0U0RIRlN2NVk3akJvajB0UzZoNlJPZVpibHI2b1RDT25kQjJP?=
 =?utf-8?B?QlBsUDJoODUxb1hDdFQ3UThJSmhLR0FtMy81MzhsSENzRXl6bS9pUEFyTXZR?=
 =?utf-8?B?QlBGbDc5YTA4dE45NitMbFd3Zy9iWTJpejYxdVhveXluU0FidWxYUGtLcDVQ?=
 =?utf-8?B?RnpGZkVhS1FRbVFaRmR4bTF5OE1TaVZkemxEVmZlRUZ5QWY4MlNCeTZ5QkNv?=
 =?utf-8?B?Zkxhd2F3WHdxZjJKWjBjd2Q3cWJWR2R5N1ZxSXgxUndGQXhwZTNFUyt4Wncy?=
 =?utf-8?B?aXNpa29DdlRxdVpMTE52UFoxK1E3LzJJdURZUEcza2I5czRMeXNUK1ZBdGds?=
 =?utf-8?B?MTl0NU52UkkvYkw0TVVPVkFZRkxndEllVUlncXRsSnMrdGRBSWV2ZVRhQzBp?=
 =?utf-8?B?V0w5cStSR1JwNVN2ZFduRE90VCtYalpVMjNFRTNRYnUrREVTS1hWTFJCYjJN?=
 =?utf-8?B?QVpwbXRMaExIcFpxTjdzU3hocXVXbzRvZ3BubTBjcGxxVDNWaFdQRG1yS2wr?=
 =?utf-8?B?eDExeEdJSi93eTR4Z0FqTHJ6L01sSmJJcG1aeUF1Z1JVeGVYUTVMZzhWOVla?=
 =?utf-8?Q?mIuPqfMq+Qz73fUnHdVBnw9nr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	n/IMFqzMzhkx0MiXk8IpJEdisYRDbTdpgeKfK4XCYWiD/FYGd0WvLWlI2CPHv6l6mhV8lufUg59Nn/iOtc+ICVlVuoMw/d/qZkMz0gWSE/opYodvmP+90RlK47VKjmjSlvh6Ns+AGAB4FJ44jq/UUr9L55K7kZVZ7X5YKlLpw8CSKfw6X120woADm6TPr1rLpNE45+R7Rm6PDtcZTvULd3nsNblsTTV8H+TlMgCdDuv3YNOkA6TMsqiwf/+KOqIaref0Gsi0O5ys1mrK1gQXZTMnAeiwhsjy0W8wO1cbrvL2AKJl04X7PbxyICEwAr0m4L1kJQJOGiLb3/jmxMfCOFiZzGwFmr8B/hjuCcZGBQ7g3/R/couLmLr/YXa2js58CDbSVZMFQ86veA5KEMTo/qzFcRDg2nEqEeRnHWdh/v0AjB28vUbZoHMjA/E/mz10AoIfGG1yE0dEvMW301FsHUO7+9qawWmW5A26Da6gG/AN0wlNkJ6NXY5E4xVKOBdDUyb+GHTI9eShcF6LhFqAsHIA1YS9l6/GiItIqxBj3TctQC3RMnkog+77MUsiSRtuieRvV80gPbn9WR+jWxX3fyvGJ0lc+GTfPgP8SOVS78E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a4c89c-08cc-4d7e-605d-08dd5b8cbe0d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4931.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 02:23:40.0050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CaxJo3Cgvl5p0LHxtCnAAhIuqUHMYKDvVwHl5jFzqEUlpe+9utXul42yqHurzU1BpY12TuGvWMiUKEL6x6lOpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5600
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_01,2025-03-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=903 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503050017
X-Proofpoint-ORIG-GUID: jlQxL_gxMc2tjEzQRcY6D0Ko4zXwAyKO
X-Proofpoint-GUID: jlQxL_gxMc2tjEzQRcY6D0Ko4zXwAyKO

On 3/4/25 02:58, Karel Zak wrote:
> On Fri, Feb 28, 2025 at 08:13:30AM GMT, Joe Jin wrote:
>> v2:
>>   - Removed macro irqtop_batch_mode.
>>   - Replaced macro irqtop_printf() to inline function
>>   - Changed option '--number' to '--iter'
>>   - Replace strdup() to xstrdup()
>>   - Added json output format for irqtop.
>>   - Remove irqtop input file support.
>>
>> Joe Jin (4):
>>   irqtop: add batch mode support
>>   irqtop: add max iteration support
>>   irqtop: support json output format
>>   lsirq: add support for reading data from given file
>>
>>  bash-completion/irqtop  |  12 +++-
>>  bash-completion/lsirq   |   4 ++
>>  sys-utils/irq-common.c  |  19 +++---
>>  sys-utils/irq-common.h  |   3 +-
>>  sys-utils/irqtop.1.adoc |   9 +++
>>  sys-utils/irqtop.c      | 124 +++++++++++++++++++++++++++++++---------
>>  sys-utils/lsirq.1.adoc  |   3 +
>>  sys-utils/lsirq.c       |  24 ++++++--
>>  8 files changed, 155 insertions(+), 43 deletions(-)
>  Applied, thanks.

Thanks so much!


>
>     Karel
>

