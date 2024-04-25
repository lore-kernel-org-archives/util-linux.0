Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2075.outbound.protection.outlook.com [40.107.7.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E6F3D388
	for <util-linux@vger.kernel.org>; Thu, 25 Apr 2024 07:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714030584; cv=fail; b=QEMCkZp06njSs/If1uZHHsQnkU5FBV+68JeqOgHCzZCAtHfydDkkp+0SurFdcJOIvbm02UhkyuBR2P7QjDHqy7tIGgy99OGoWdBUURGHIV9HH12B1Hla3nbHYlgL0EpYIz3PuzN11ReZOMhPmF9c6c0WfjqkyrrVpn1Jphycycg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714030584; c=relaxed/simple;
	bh=eCxt2xVMhSF0wZxkG2FlInE6hNxCGGa5P+atB4HeRfU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qRzC99JFe9DwhQLMEiajyByym9u+3l83hesZp63RA98Rup6L7WbsRp7cbe62A1cyuYgYl7R/9G+Cw8tAfVF1rd8nohDkaaevzV8g3RG7objMY6YlPP3RfKXDoZ7rc3TxRtS6GTGqGk1S4V8i0xne7aSAmLKe7S1rEYPKrYvDcwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=e3KGziD3; arc=fail smtp.client-ip=40.107.7.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="e3KGziD3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkpXSWirgvmwazOYIbx+lU030UAzfQfKRwpIce9qulka69nlXRkarz6jE4rH9BymCQJ3JJvagnCoHUbGNlmFGGusA+Jh/FyCEszEaQUtWqtIKMlwTOL5qLdh8lA/kosUCzoYaVMI4dR5fNK2Hjx804eX7mfu1iXdvLfgOPsppuu5h94oKsOduh4XeOy/G6SSmIj+fUdXIOKbKBAvJywzWtp2ZPVQ3qsVbwxzvgo/XwpiGDyZ3oPkxWeuR4V/gCBVj2AmGocmGVbrfkM77DM08Fp/1tj3aIY5JbI+ZnWuQtagzBR2uAf7hlcXyQPMDNrMjF+TCZxBfNZOnfD+84fSDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=il4J566ry2Rn5IPpRtpN9v15NlIOUzZpiTLlylML1pg=;
 b=FvzvLB9G3lD/Dpobf/X8Lpv/l9i/0vL+pVHoJ2fXjvKHY8dz9Unlp6KPSjX46RTwY1vJHvdCp2P8KMaVBj2wIfSoIK29MmUp/6/7E6r84a7+vshmUrbrld8mWhU3mCYhHMaGWJodMB4o4e9C3a+9fYwfZ1s6XyIUHoFcD1kDKnbTjobF8Lnl1QMsLBRtB9eid/BWCCuZ6wJCZGmpIqENErWurjYKqx+ujM6JuWK4IIMz6NO35/yspzb8PO027PSUJMOI/0e6DhLYkrKeg08XNa22Ql7+i8/JM8MOsiNkDPwaLADk/AR7ok1m2TF+CWqfSq3+XKx0EBey0XMKpxzcuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=il4J566ry2Rn5IPpRtpN9v15NlIOUzZpiTLlylML1pg=;
 b=e3KGziD3SiIMscwLfKmBmlpepjhCHdMMAnSLS4Yiz7qU6E/tjV/w/2z8vG94qzvxqM9jhF+aV+K/agowJOjw4IPM+0grNwxI0s0NUFkZJ89yMlyO9yJTzE0ar106AtQt/o/1x2zR7UE7onjT0gfHKm9QGkYKnjcwVyFjz/S63L4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GV1PR10MB7978.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:8a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 07:36:09 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dd6e:5f37:1abc:9119]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dd6e:5f37:1abc:9119%6]) with mapi id 15.20.7472.045; Thu, 25 Apr 2024
 07:36:08 +0000
Message-ID: <fad6d1c0-00e0-4429-9d33-74b2179c0a83@prevas.dk>
Date: Thu, 25 Apr 2024 09:36:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] flock: add support for using fcntl() with open file
 description locks
To: util-linux@vger.kernel.org
Cc: Masatake YAMATO <yamato@redhat.com>, Karel Zak <kzak@redhat.com>
References: <20240423120819.571181-1-rasmus.villemoes@prevas.dk>
Content-Language: en-US, da
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20240423120819.571181-1-rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0036.eurprd04.prod.outlook.com
 (2603:10a6:208:122::49) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GV1PR10MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a63243d-ffd2-4200-ef54-08dc64fa5f79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2FsSUR2aG8xTkk1eDJiamd6akhpNFZvcGI0d2xIQ3VhaGtjRkhjYm1JTmt4?=
 =?utf-8?B?ZFZicWFPY0FyU2ZlRlBLYnV0aGYxMk13NTBBcVBIdDZhWnhtd2Nkd3dwem5N?=
 =?utf-8?B?T3VGaTJkZlVVdTVKYzdEWmw4VzN6a0hJNk1xVGVXUnR3VDVmZVdUdTJoN25t?=
 =?utf-8?B?TGViUGxWdzE4SVdHUmUvS1cvaWhzcDFiTVU4NGordGg4UkNDVk5BWXZYMHR3?=
 =?utf-8?B?MVI2bXFsT2t3VExLSWtBUlp0cTZIbTI1aWZTcGQwVGNzZ0lkS3l0YkZ5amRx?=
 =?utf-8?B?WU04Yk5nYS9ZQnU3YXp1T20zNnFGS1dtKzFtN2kzUld2L0xMaVZwZXE5YXB5?=
 =?utf-8?B?N1FjQ3NWMWhaQ3ZmazZNVjJCSDVndUNQdU9CRWxoYml2b0h1NUlrT1AxQVJ1?=
 =?utf-8?B?Rm9KK24ySjJETVQ0NVQzTUx5WUVPSFphS3M4b3FzaWI2OTVxMU5qeDZjcFJV?=
 =?utf-8?B?TnRmOGxuVlB6SjI5bElKQTdDMkExUkI1NE1PS1VocU16T1BKUmVhVE90NU45?=
 =?utf-8?B?a1V6WnBCNStXaksyYThHYlcrMGN0NkNrWkZaNWFTSjhvZXhjemJXS1JOdWxF?=
 =?utf-8?B?SHRkcVhOY0VpV2tkRnFJNm1QNjBrT0RkTTl4bW83YnJyMXJkV0dBRFY0NXQ0?=
 =?utf-8?B?Z3MrU0R6Vk1CNkEwTGhoZ0NjRllrV3VvZG50UW13UHlJa2x0ZXNsODJ1N0NH?=
 =?utf-8?B?RXQrekV5ZUN3VFN1dnFQU0VsUjhhMU5yUGRINUNqNmVKTTdkdEdTMndtaW9N?=
 =?utf-8?B?UUxITGdTc1hVendNSUx2aUI4NktUd0dsV0pZc3RhRG04UkJ0TGZERDIwMVhG?=
 =?utf-8?B?ZVkxWmxaa2pCeVFjVThseTBqUkZNbDlYQTAvbWFUZ3R3U29UUzl1a3lSZFdQ?=
 =?utf-8?B?TVB6d2Z3UVJPcDRlVFdxbFpxUFB3V2dyL1lWS0NJV2gwS0lZeElIYTdiWjdY?=
 =?utf-8?B?TlZFd1Zka1ljRE5GbWVmVlZSWFhYUW11emdpWU9BaTBrMmxhRWFEdUNwOTVx?=
 =?utf-8?B?K2NRZW5XSEJ3YnI0QVJQQWdTb2VoTHhYTys5TTczWG9XMkcxbkJkbHUyeGQ5?=
 =?utf-8?B?NkgwRmRKWkpOdlB4Qzl5TnphUlR2QWNTTlEvMDFBMlpNSnRpcjBpbkVMYzZ3?=
 =?utf-8?B?dUNKeXJoMmE1SHJRZllHb0lTbUdvYkhwa1phZDlDL1hicWJpVnF1dGhRbkFu?=
 =?utf-8?B?czk5cnFwR2lURHBVTEJaT2RWWjFVM1c5TS8wd1FsUXlScDdVdkg3STVSSHJG?=
 =?utf-8?B?TVd2a1FWelRGeXgrZ0kzVU84eENaTnRjRWxsZ29mMW1iay90RHh2dFR3ZnE3?=
 =?utf-8?B?RjBoSlhWSzM1NkZmTjJ4TXRPdCtzUmRDdTRaOGZzWWlaL0RJUmFaRjFZNFFE?=
 =?utf-8?B?N01sK0FXcS8zYmFuTE9hY0FMTEcvd01vRml2Q0taT0NGbkRLVkNSNnFHNHA2?=
 =?utf-8?B?M0ZvQUhYZ1cwQXo4WG52N0haVUZDTEplSkRmamZDZHBpUmthSTVOREYxYi9n?=
 =?utf-8?B?dnRWREhhVVFadXZrOGswaGJKUjc4K2ljZUpxZFduSWdFeVhuRzlMMEJmdlpt?=
 =?utf-8?B?N1pGZE5pSytRdytKQjlUQTF0THB4eVM5ckoyY3huSk9MN21zWGpDbFQwUDFW?=
 =?utf-8?B?cTR6eUxnQUt2WkR3Mlhud244MzBNRE50ZDczek52eWNPVWVMMHNib0hsTUQ4?=
 =?utf-8?B?OVU3djc4WFRmb2NuSTFHK2NzaFNobFJjQmRFUUpEWHl1VmdERWU4THBBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U09WelhjTUlYVkI5cGtSN2NLd2JEaUpuTG5zeHpFaTJnWmptQWJLZHNNQlJv?=
 =?utf-8?B?SXhCS1cybjZWVXArMEN4VTNwQ3ZqVW1MVDhSbVQ5K3cra3hyNExaZnh6SDE4?=
 =?utf-8?B?Q0ExTmhlV3B6WnJZV1ZVWVprVWt6elhUOWNVekYzNkJ0WWt1MC9OdENtam9k?=
 =?utf-8?B?b3JZVjZDVHd4ak9oK1k2R2V1NndveS9LUHpvczJNZ1lXSWUrNXZGRnVIaEpQ?=
 =?utf-8?B?aWhSN0xTbEhzYU5YSzNTWTZzLy91MlNWT3BpQi85cmlWdWlibFA2K2VoVmxQ?=
 =?utf-8?B?N1B1ZHZVMnBsdDcyMjlUdkxxcjgrRkhiSEFzVDdrd280VXpPdUNoZE56YXRJ?=
 =?utf-8?B?V01XelViQTlpV1hGa3d0WGppdVZ0SFA3ZXV2S010bWFzRWhuYTV0RFBuVnBt?=
 =?utf-8?B?NWNlTnk0UXVFUUhWd3J0ZVZBYzNEQ0RyVU5EWVFWR0x3UjZzOFZHZTBqWk5Q?=
 =?utf-8?B?OFhnMmUwNzBUaDllRTgwUzlIelVlNVZ0QVRsOFh5SXFDaXZkdHNjQ3JTbis4?=
 =?utf-8?B?c3UzNC9qN3B6OW55ak9Ld1NDMGwyZllQKzRHYVdlMGlJb2Jya0RiVXJCc0tX?=
 =?utf-8?B?REpjbHBlUythNUQ4RDNocUJuc1J1NzF6b2ZoUVBKaFVCYVFoT29VaUZGcVRI?=
 =?utf-8?B?YUFZQUNTWGc2MXNZWXA1NWh5MGovN2ppd1oyWThoY3Ivbk5CeVVQUU03SEty?=
 =?utf-8?B?dmo2OE0za2F1Zm9nY2ZQVWE2SXl3Qi9HRUx0bURPckxISDQwbzdJSjl2UTNG?=
 =?utf-8?B?d1dJR3hTK3JuVWc1OVJHamxIVUlxU3NwNWxPVXZaeWtzVU0xZUpHam5RQ0ZM?=
 =?utf-8?B?TkdzMGlvUEdSV2Vhb3YrQW5SdFB5SlgrOVFkNjUyaXpXNVBad0I3ekpJcVRn?=
 =?utf-8?B?bU1GZ1NoTWhhZVNFVGNFUEVoUHBhVGtNcVppZkhXZzZQMjRvVE9PRjJLUDd1?=
 =?utf-8?B?YXZXamxMenN6Nk9OMkx0NTRKRlYzV1ZCSjg3T1JhS1FmeE1ETVNlRzNrekpE?=
 =?utf-8?B?eE9CYy9meGxRdm52TEFxdHBSRGd4K0p1bU12VEk5azFSNG5rUDczSE1NZGpF?=
 =?utf-8?B?UXJJVG9YRVRPck0zZ2tsU2haSHR0KzJMOElERUJoS2gzdUpRbVoyU3FiZGdn?=
 =?utf-8?B?KzdGT29hRG5BK3VHL2dNRVFGYXFPT1ZzdEdVWHVuTXJETVg1aUM2SFUweFN4?=
 =?utf-8?B?Wi9aZGhzQU53UjhqT0liU0Y5djRJNnVDSUZ2aHkzcWEyZzRzTnpweWFuRzcx?=
 =?utf-8?B?U0tPYlR1SFJYZXZrak5OUm9ET250YVViYkVXa09ZUmNpenI4aExuTTI1bzFG?=
 =?utf-8?B?c3ZqR2RsUmdQUlpieUNubkp5QmQ2TmFzZEhlNUpueG9lYjM3UjN0QzFRMzUz?=
 =?utf-8?B?K0J3U0Jsa1FzcksxWjBFYjZ0em4yN3lweFdTUzJ6UWhRaUtSN2lKVDR2ZFVh?=
 =?utf-8?B?eGxobGxDMWNJbWRldkRxK0tsbzhmWWErZndFeHpiNXdCRXBXVVpiVVU0RHk2?=
 =?utf-8?B?cUErSlAxbTBESmcxVnN5VVpLRUthUU9JUkhVeHhNSjN1VDRoRm5MUWdyelBk?=
 =?utf-8?B?THp0YWZPZ1RabGJIcmR1MlpNbjN0eVdJR3RNYjR6SEFtdXNiYWVaeXZtVFR3?=
 =?utf-8?B?dmVrSDlQQ05mUGRlcW5TaFMwSkJTR3lsQUprTjc5bzJYNTlvTXAvSVBzV0dL?=
 =?utf-8?B?Tklta1duaGF5aDhlaDB4aSsyVEF0TlQvQTBNTmpYMTFMbzBXU2lJcjhlM2sr?=
 =?utf-8?B?Qm5udTRYcFZvcm9aWklPQ1g0Y0J3N1ZONWlvWWIwR2wwZHFVTVdTeTBrUm5l?=
 =?utf-8?B?aTJRSG9sYnlSeEVtcU92YkpzRzF5MGQ5Z2g0WFZjU0E1aGNJK3FHaGQvbnRN?=
 =?utf-8?B?UW9NU3p6UjgrT2dpc202ZnBZL2UwLytqQlVLTEk5ZlBYdUtyemRvT0Z1cXZi?=
 =?utf-8?B?OVBxOFpQMlI4d3hLcjBsQ1UxR2FjUXJWaU41SGlPdzlpQVFCTHVvZkh6bi9l?=
 =?utf-8?B?VGNReGRhakZoajVld2ZCRjZ3U0dyb0g3OG1UOXl5N00zaEUzaEpyREFGZ1RH?=
 =?utf-8?B?ODhCME5MSEZZMWVtWW15V01oajRDd0NhejRFNmkva2szRDFMdTBTNG9NNzht?=
 =?utf-8?B?V29uQURYREVXMUlqQTVWVk5uV2huRW9VYnVsbmFOYmFjNEVEWWxQVVUwNEFm?=
 =?utf-8?B?R3c9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a63243d-ffd2-4200-ef54-08dc64fa5f79
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 07:36:08.7581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cdp7S0YDK+ATsGPwfKHolJykdfdYo5uEK7EiC//S2tsGCBAInoI1QB9/I1YPoVOgi4A9R8+2vvPCM8nL7xuJDUjYZjbm9d8wB7IjeHUCXVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB7978

On 23/04/2024 14.08, Rasmus Villemoes wrote:
> Currently, there is no way for shell scripts to safely access
> resources protected by POSIX locking (fcntl with the F_SETLK/F_SETLKW
> commands). For example, the glibc function lckpwdf(), used to
> protect access to the /etc/shadow database, works by taking a
> F_SETLKW on /etc/.pwd.lock .
> 
> Due to the odd semantics of POSIX locking (e.g. released when any file
> descriptor associated to the inode is closed), we cannot usefully
> directly expose the POSIX F_SETLK/F_SETLKW commands. However, linux
> 3.15 introduced F_OFD_SETLK[W], with semantics wrt. ownership and
> release better matching those of flock(2), and crucially they do
> conflict with locks obtained via F_SETLK[W]. With this, a shell script
> can do
> 
>   exec 4> /etc/.pwd.lock
>   flock --fcntl 4
>   <access/modify /etc/shadow ...>
>   flock --fcntl --unlock 4 # or just exit
> 
> without conflicting with passwd(1) or other utilities that
> access/modify /etc/shadow.
> 
> No single-letter shorthand is defined for the option, because this is
> somewhat low-level and the user really needs to know what he is doing.
> 
> Also, this leaves the door open for teaching --fcntl to accept an
> optional argument: "ofd", the default, and "posix", should anyone find
> a use for flock(1) taking a F_SETLK[W] lock.
> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
> v2:
> 
> - Shorten option name to --fcntl instead of --fcntl-ofd.
> 
> - Use a do_lock() helper function switching on the API to use, making
>   the while () condition easier to read and making it simpler to add
>   the mentioned --fcntl=posix should the need arise.
> 
> - Fix up places that need HAVE_FCNTL_OFD_LOCKS guarding.

Hm, actually, since the values of F_OFD_ are the same across all
architectures, and the API is pretty old already, I think it would be
simpler to just drop the configure time probing and all the HAVE_
guards, and simply add five lines

#ifndef F_OFD_GETLK
#define F_OFD_GETLK     36
#define F_OFD_SETLK     37
#define F_OFD_SETLKW    38
#endif

after the #include s. After all, whether or not the constants are in the
headers util-linux is being built against doesn't really say whether the
kernel it ends up being run on has support or not. Then I'll just
include a note in the documentation that use of --fcntl only works on
kernels >= 3.14 (besides, it would be really cumbersome, maybe even
impossible, to have the man page not mention --fcntl even if flock was
built without that option in its --help output).

Rasmus

