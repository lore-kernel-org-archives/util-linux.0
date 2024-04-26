Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2056.outbound.protection.outlook.com [40.107.6.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EC613A3EF
	for <util-linux@vger.kernel.org>; Fri, 26 Apr 2024 05:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714110917; cv=fail; b=GTTarnj2Ambpi0j4HO5DsYjGLxRffVs5aHNp6sXy2qT9+wKyrOgPaxtJGIUAQABeuGNY+r+tQbvlzqIxdC/WwKarQ3YsLkwEjQhZitDCFcwtIG7oKKnG1TFlC96Zwokftao4HFEZHC/gp3Q1J+kcqiajXyQ3Ze8Nx6k0YqB2aT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714110917; c=relaxed/simple;
	bh=7O9kGzr+lni8ybUjmKRD8jCs2+Jy8PToVaIoF3cGMRk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UmMuZ0mJQmoHQP5Up0QURwwN9KAGQ3FWNOycbSKAUH8KxlmaWpFvwi9H2+4Rbl9k4Oyau5x5kAEpDeckZYjQQCk1BmKW8ekQhGizlgFqjYYUQmVEeSsXNDbnMLGrGwH4f76XM1kbKtAWjmdbc6ZnEz0/pSSMkzQb3RzAQG4Bv30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=hlnhGKtb; arc=fail smtp.client-ip=40.107.6.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="hlnhGKtb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3sDEMEbPBt1XbG3DbSaY41O6HFW68BRLxxNnS5UsK4WBXxlnfhOQzZiykxsRSW8XwymMAy6yfzUm9FcpjOfKFkD11xBSvmPDMjvi/RQxfFcISm2b0M55yt/ZNsb3veVytlhsoxQ3DgX6MFEpaLYDvgLThHFcsKS9jkBepe+I52PDzpOtU9FZPvDUpLBcQ5qI9pgNVPNQV4nkkn+IcrjCQIH7jAqIloSoJbGGbCarBKZjptSKU63xaUqc615SzyrBAeX5cnYRBP85R5KYYELU2b1hiQ9YM4KCjs92f5tmdbYTeG55b5G0JnLV06rSTJuH5on+MkLO29Eu6zjxdpzdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tChbyXbJNE+oGVIEL7RuisSVRlwPwhkvAo6bxbYXdnE=;
 b=RLkKzvxyQfYCCbmIuZDbmjkPxZDznACsHyoEcNeTIJKKOqZBmkUs9M0D/4zmprA+LHwU9nLGK/7E+G8reBL6fRIPWP4L2gEMYDza101msfuzsIxQ2Sd+EuEieKST0jF38juGEwDjO0W+ncSmkZ9JjvTDu+AC3+mM9ghI0gqBOxaZAh9ybTSqsch8o5pnmsniw+7jEnF3LZ5TiT4pOp58YHGOhm4sVGkY3647hv8xjxNYU/u8H79v0YoG1+2HS1oXk+6b1XsvIsLOsus8v+jd+7phz+dzYfbzv1xQg7lS4wQJJ44oJvEzhF5ZPgICBhoZeokKIUZzoHpM5iuzR0RY+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tChbyXbJNE+oGVIEL7RuisSVRlwPwhkvAo6bxbYXdnE=;
 b=hlnhGKtbIKQkwx02714SuBZ63r5ydAGTh7ck5ekwGHtakabXdsddQHW8D05Dwzy5P3fkBSmYdFqA4ZykvdHPm4Rfo3AWmV/DW8q5o2UW3lbatIno2UM43ARyvQ2Cxvh77BgOG7jgs9X7RkzqdnesyUoP1j3hu5DZ3xxj7wexWww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GV1PR10MB9014.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Fri, 26 Apr
 2024 05:55:07 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dd6e:5f37:1abc:9119]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dd6e:5f37:1abc:9119%6]) with mapi id 15.20.7472.045; Fri, 26 Apr 2024
 05:55:06 +0000
Message-ID: <0ebbe2b6-7f2d-451f-8f43-3765915a462e@prevas.dk>
Date: Fri, 26 Apr 2024 07:55:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] flock: add support for using fcntl() with open file
 description locks
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Masatake YAMATO <yamato@redhat.com>
References: <20240423120819.571181-1-rasmus.villemoes@prevas.dk>
 <20240425135522.hu6wrdwoanresvvi@ws.net.home>
Content-Language: en-US, da
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20240425135522.hu6wrdwoanresvvi@ws.net.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0110.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::26) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GV1PR10MB9014:EE_
X-MS-Office365-Filtering-Correlation-Id: 09d832d4-16bc-449b-a0db-08dc65b56cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RndEMnQ5ZFI4Y2ttaVNsM09RdnphSUc0YVQ2dDB4SVc2ZDdKS1J2L29McHFl?=
 =?utf-8?B?cHpTZE5iVFNnNjRBcE41dzV0V2RGUWNSbzZkSXVzUnE1c1hCeW5UYlhBWDVN?=
 =?utf-8?B?N1lHV0FyeWsvU0xPUlpEdWt5OVJEdHFZRngyUjBnaWd2TjMxa1NubWhZSVNi?=
 =?utf-8?B?RU9GeCtUVnZVWTBwRkYvRm5XTVUyQ2FOVnd4QkhrRnBZQTJZdkpDazhaQ1BB?=
 =?utf-8?B?RTFwNXgwckRIQjJka3NnbTZjWVJ5d2FmdVR5SW5yQjJ3SlU3a1hXMWNUN3JS?=
 =?utf-8?B?WERWVDBvczJLaEtMNGJoRURxQ3pVVFgwcEFUWjRGL0tTR3gzTURUTUt1NzA4?=
 =?utf-8?B?blcvQWhBazdZMThLb1l4cHMralJ2dlBrQjV2a3lIQWhkNGVzVEdySlpzbytm?=
 =?utf-8?B?Q3pNZnM1TnNVSE1qclByb3hFOFhJOXNVZzJSSVBhNUY3RDlzK3p5dGRVNWhI?=
 =?utf-8?B?d29vY01TM0JwR1JLUVM5WklTamVmVkxyWk94UlZaUUFMSXlyU2xMT2FrZE8w?=
 =?utf-8?B?Q0VjTjlvRDB4bkphYjBDTm9SREZpUnJJR0JFb08xMGNSTTlaVmVPODg5SWVh?=
 =?utf-8?B?akVtRHJvQlIrRGRZRDdVc01qOThiT1FWZEFOdnpSSVc3K1BReEFmdkVWdk1Y?=
 =?utf-8?B?REtVTi83UjRXWWJyVFhmeCtSNkZtYUdnakZGNHZtd2RSRUN0VjRJMitmTmxQ?=
 =?utf-8?B?TDd0OHcyUGJQN08rUGV3WUpoaXFIclFuamhGMTIvWEs1WGx6LzhsS0FSNkxZ?=
 =?utf-8?B?d2tCdmNNcU9UT3BUNUxjdmJjMXRZRXIwMi9yRkplMmFZbUhjMkFadTc5bklt?=
 =?utf-8?B?Umk2Z2lFd3BYSWl4MmhxV3d2ZDIwMHk3OEtTU3huRGN4TFVzZmVwblJvR1li?=
 =?utf-8?B?NkZqY1NNeWMxOU5qcnRiWDBTbjU3eEVhUDU0THJJbWRhaVhUZHNqSjJNTVpW?=
 =?utf-8?B?U1VlR3RKNk9DVFJoWXlDeFNQNWJocXk0MGthNEwwNHlLS2JhL0JJWWVIc012?=
 =?utf-8?B?ZjhZUnJxZlhNSVRVUGs4TzNxRmM5dlp1bldqcFZ4VkhHanVjMDQ4djh4NmZI?=
 =?utf-8?B?dFVNMFNsZUoxYmpZc2pidWcvSXVsOUtOcGU5dzV3QjRLM2dkNmpqRmhuS0tX?=
 =?utf-8?B?cTYxNmRLVDhYL250WnA0TFh3L2Q5VjdKSkY3b3B4MTNlVUczU0tWRzRNdjRu?=
 =?utf-8?B?SjZUQ3Y5a0FZNlNCRWxlOUVWU3B0eHArRUtFaWZGOW9xcCt1VVFGaGkvUEhi?=
 =?utf-8?B?eEpjWnczQkZWdjVxZzJrSmp3cHpUdlR2ZFhtaHpqejdRTnFoYi9UVnV4NThN?=
 =?utf-8?B?TktGb21OSXEwRkUwMTI4Ry9mdzJURlZGa3BBcitFS2ZRVjZOVmZGMHVFS2tP?=
 =?utf-8?B?R0p1WWN4V1pBWGhFNTNBUUJsa0cwVXFiUmlqS09zZUVQZFJQY2srQThZMlpw?=
 =?utf-8?B?SXg1d2I5VEptSDVOWEt1RXhNTEZDcitYekpqTG1qQkJFZDF3RGNvbjcydkUy?=
 =?utf-8?B?aWFOZGxtaHVVdk9hRTFLK1ZsOEp6dm9DZVM2eEFUVXkzSisxUHB2WktNSk5E?=
 =?utf-8?B?dlk3b1ZPUTY3WW9keFJ3S1QxTForTTY4Q1lJaEc2S1hSZEVzaGVXWCswWnhN?=
 =?utf-8?B?Um8yYklxajlMTG1pRllXOVUzelRDOUFETDMza1F0NTh4TmVpR0ZvcTZVTWo0?=
 =?utf-8?B?aXV1eVVGTG51K3gyR0FyYzk2RjhWc3ZXeWVHbnM4dWhJMm1CZTBiUFBnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0wxRm5TWkkydGgrZWp4WGRLaDdhZ3Q0VHhpTGtmRkVQVzg4M1BCd2cvTjYv?=
 =?utf-8?B?a0tOOGI4MUx6U2VlL3NOd1poUlRkYjRMOXBtY3RoUVcrVW4rcjNrblgzdGE4?=
 =?utf-8?B?YVhSeXZlRUhkMUZVMXU1N0ovZE5RVVJiRHRnd2cyNW5wN3Q0dHptTGhlcG9H?=
 =?utf-8?B?djJ3QWhEMWRCRDVmV01Ia1ZTbFdxU3BZK3NDRjYydUJVOFRsakVqa2FiSUpn?=
 =?utf-8?B?V2xXQitZV1BZTVBRSWJycTRqRlJvTXdKMnNYeXU3cWZTR1NKQzlvYmM0eHJa?=
 =?utf-8?B?U0JkWE83L0NObE5GKzcvckRMMVpQeFZSTUxJMHB6Y3RDTWQ5cXgrck1sT1Vz?=
 =?utf-8?B?aWwyNmUraHZSUU5oNzdJdWdUYU40Sldsamc0VFhXRXQvbkIyZWdSRE54bWtn?=
 =?utf-8?B?a1M5MzVBdkJsTTF3eHdSZC90NkNLTCtZSVNzOWNXZWRjSW93dkVHOSthTHE4?=
 =?utf-8?B?VW5GeFN4ZkpEbUo1RU9OSklGVEdHWjA2dmE0VzZDN2RldlpnMVIyS0wrMXR1?=
 =?utf-8?B?M0J0RERMeDQ3TTF2aWg0VVlNeTVpM2hyZmpYWVNpdlFPWTUzeTB6QmRFdnNL?=
 =?utf-8?B?YkFoZmpLRFRmUFhjNUlYMjR5Y3RUeGhQK3U1ZitEMXRvYVZPTEdaZHhzS0lO?=
 =?utf-8?B?ZzJEcVFNSktVd2xBUmdJNC9YbEZNZllmQm5FNmtSenBUWDJselMvWWpkemVX?=
 =?utf-8?B?UGhERXhPeTFkc2dDUGFBcnZUSUdyMUtLYUtYOUJuT1FUS3IxSGEvQVJSSmtX?=
 =?utf-8?B?a1ZFNnNOSE1NY2hDUDUvRE9tMVVzdTlNNFBTQlVKcnBSVVRTK0hQdS9MNFhH?=
 =?utf-8?B?QVJXNml3ak5za0ViQmFacDlsZ1lkalBYZ0tLTWNVcVVoNld0SXkrT1dnQW85?=
 =?utf-8?B?a3RmZUVzUmxib281WkJqU1Noa2hDczA5OW43VEFtdmtXcXE1MW1qTFhKZXkr?=
 =?utf-8?B?YnFwZGNMUVMvZlZXcHpOR2IzaEdYVGhQV2cydjBjb0wxTVJNTG9jR05uWXhM?=
 =?utf-8?B?dnM2RGxkL0JYbnpWUURORjlHYWN6LzlQVmVhekd6OTJMY0FpSGI5cCt2RVdm?=
 =?utf-8?B?bnlKaDZaSDMrVGRITm9pcEhYbnplMU5SSUlvN3dPN25WQVFBWnY3MUlXSDEx?=
 =?utf-8?B?QWtvZ0ZCNUZCQWZBRWUyUFNlMFBlK2VTQS9lVWwyS3NVMUJzb0gvNDJXNUVq?=
 =?utf-8?B?Zi91MExFZ2lEdlVzZjhGTkRkSXdVSkMyRlgvZ1hTdWVzbzJycEVTNU5pQTJY?=
 =?utf-8?B?NXZvdnRNY1drMUNmZHJqUnhWSkRLZTlkUktwQlZZOWwyVCtmaU5VZEhKek1a?=
 =?utf-8?B?MHp0ZXB0UFlnd0NDMk5EdENyUG1UbGk3NGNDQ2FrQ3p6eWdHUDFMek5sSGtN?=
 =?utf-8?B?ckF1VStOK2NZKzBBQ0lLNWVwMUcxdCtlZkNvNzVmdkZPTVRydElVVGdzMzZV?=
 =?utf-8?B?Y0xtbHUxa1pDak42SmVneGM3TEVvcTBUZzgwVGd2UFI4ZUhrTm96RFgzMUVG?=
 =?utf-8?B?TjRITHlEbjBVSEdlZU03Uk1rWjZNazlNQkRoUDl4Y1BvR2hDMWI5MlZuZGJH?=
 =?utf-8?B?cGZNaWtweWx0L0RvWHZZb2JYd3lrK0VrWU80OE9rUmtpb3NpQ0pwWHQ2Rlpo?=
 =?utf-8?B?RHNGbFNBQ21sNm5yMUhjNjU2bVc4YmJLTHNuVFpNRTNPdmxVb2s3OTVpY1FG?=
 =?utf-8?B?N2JCTGdMMFlBb2VScVpndG5tcmswMXEySXNrblMvc3FpSzJ0Z1hWSjczam5i?=
 =?utf-8?B?dit0UExUbCtBaVVOVnlGR3FFMTBUdzJyenhLamxTMVZzVmZaTmdrRFlaUEZI?=
 =?utf-8?B?b0FMYVNyaGhvbnZ4QmYrcWJjUVdmRVZ6VElUaTV4Tk1UZSttRnVFOFg5UmRT?=
 =?utf-8?B?aDBJOGFIcEkxYkZpeng0b01ORWhONHpEaitGa2t3WWd4RmVLbkY1VTVUNThw?=
 =?utf-8?B?UGFZd2E1OFdhYVFOaDFXd2lualdReWxlN3RlZ01NV0dETVRZR21YRWFwcG91?=
 =?utf-8?B?Q2ZuejQ2ZDFMWGRlRmJxOFRmaTAzdjZCTUtWL1ZrcEd4ZnlWQUFFRWhZTmVK?=
 =?utf-8?B?SHpBMGJEdDI1V2FKdDd0T3FmRXVHRkI2TXJUbWRwNVp4amo4VnVlOEYrenN4?=
 =?utf-8?B?dWFXSVJQWFZ2ckJUM3Fld0JKbDFOd0ExaFhZM1BuQ2lWVkhwdHFYV0luMldq?=
 =?utf-8?B?SVE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d832d4-16bc-449b-a0db-08dc65b56cbb
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 05:55:06.9180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: psTOsofLSvLSq3ERAoP9wEetXx6jFc9fzYld3FOnf15TyAwQfm9Wob/JVZTOsc5kXFzH5jyNLbwi2JCW3lEGEGeEnxVVl5dZBEpFE6emjwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB9014

On 25/04/2024 15.55, Karel Zak wrote:
> On Tue, Apr 23, 2024 at 02:08:19PM +0200, Rasmus Villemoes wrote:
>>  configure.ac      |  6 ++++
>>  meson.build       |  3 ++
>>  sys-utils/flock.c | 82 +++++++++++++++++++++++++++++++++++++++++++++--
>>  3 files changed, 89 insertions(+), 2 deletions(-)
> 
> Thanks, created pull-request to check it by our CI.
> https://github.com/util-linux/util-linux/pull/2993

Thanks, but I sent a v3 eliding the configure-time checks. Can I get you
to consider that?

In general, do you prefer PRs, or is using the ML as I've done fine? I
can do it either way.

Rasmus

