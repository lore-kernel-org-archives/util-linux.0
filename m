Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022139.outbound.protection.outlook.com [52.101.43.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D30F212566
	for <util-linux@vger.kernel.org>; Fri,  7 Nov 2025 21:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762551962; cv=fail; b=IycRZdc21eDJtgBC3NqJHuV6OD1ra3+9GzCbuwSgJ9Wuiv+u85LupS/0OaAaYxbbDa+dvhUmdgwOj3jWEFHR14KlO44vj4fr7IexMeyW1yJQg7NCDvUM1CV1xqcQ3BZLDfNhWFtOSjGBz7LvpzxAr2HryqWU3LMjjBtckiVNYPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762551962; c=relaxed/simple;
	bh=/6/Mokqx0Gs+uUeXiyv+pCBWJ1l9g+xRzTMdHgqNPgw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j5vFNgfpQ/lXFteEjE62rG6Lqy0e0tSwoHB/HkwnW8pBbXuVAEDQ6Z/GXhNiFmPaxa0kC5jnxC6IBp93ImZqnYCD7JjQkC482fwBRKEvIGuUaB/eE0gdzUAeqY3ydgpNY5mVGfEhEb0bUPuywFpQEQcIvvAgYli60lqtsr4TbBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=A4CPVkNE; arc=fail smtp.client-ip=52.101.43.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="A4CPVkNE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILyTwpc8deFQDA/mhyTaOvo/MY3JxAm+7hUXaT7VZyu2JLbLSnnooeHD0t8pDBHdi4rO/GTr1KcGYvWTzkZwvC/6210oY8TnpsFF5D/dDKHNbtBh5MlSCcuBtNa348lo/tRLg9WKoKXK9TyZ3UuHBRp+X7wc6IUN+gN8HizqsAK5MJrq21tIuKqO08KsWQmu/6PwJ5F2Di/OJzcsvyZ7/jL+ZYlQUcaO/9mrpaAobWjAaEirG+hGlkdAh7stGvDWsry5p2EGA7x6N+H+OSR3M5Mr3r1IZysF4CSPxfmiXD2NGEzKVSsrw3M2v/3V1k2Sf8+oTHUxLME/qQ8KQg923A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvFd4nQO+aFAna3C6T3e2CBqm8bVBgSexECWBBSjNZY=;
 b=YzSJCD4MA6gLWKtRMLb4KhkLXC4Nr3UX22usk0jk7UfjExWG2icZMlynbqMwmKPFOQR6WWeAxuY5w1fcdSAxFYSZFweSJdI/m8j5jfHfWH83V1zZ9Xo06ElNqzBlTGYSV7gqqlrBdRolfquVQfQEkockTKjYSgZDUAn4mganTS5pz0lMoEbJxq74PSiMrW8vW3IN1QeSQq1oO685Y1AXt4Y92pvtRNrpwV79ehWb5oeAWbqpoeguQZCSN2MguCm+tx0y6sBq2E82zDyGJq8rF7/oHF8ULERU2dU+4ragWGpqJpmsr4oa9WuIT/iBvRSDxKbvkHCiqYnX2ukTBkDaaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvFd4nQO+aFAna3C6T3e2CBqm8bVBgSexECWBBSjNZY=;
 b=A4CPVkNEMpeQNbbu8cIJn5oVG+akZ2oGPHKtT+OwhOCm0K5fnA7shtfD4wAHLxynTksAETNTRjN/WS5FZc+Ie2WzOu4jRF+B+CLEDJMGefzBBDmj9KApmjMrFIg6lF4NMm8+R4tXyoUy7FjB4dKolIAiIfL7NO9WHs+bFDaZ8Mc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA1PR01MB8179.prod.exchangelabs.com (2603:10b6:806:330::14) by
 DS4PR01MB994183.prod.exchangelabs.com (2603:10b6:8:325::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.12; Fri, 7 Nov 2025 21:45:59 +0000
Received: from SA1PR01MB8179.prod.exchangelabs.com
 ([fe80::f091:2832:ffa:784d]) by SA1PR01MB8179.prod.exchangelabs.com
 ([fe80::f091:2832:ffa:784d%3]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 21:45:59 +0000
Message-ID: <be0a8cce-d465-432a-b9ff-8f530f8858be@os.amperecomputing.com>
Date: Fri, 7 Nov 2025 16:45:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] lscpu-arm: Allow externally sourced model name.
To: Jeremy Linton <jeremy.linton@arm.com>, util-linux@vger.kernel.org
References: <20250711211648.53361-1-paul@os.amperecomputing.com>
 <935fd521-508a-4f66-9ece-7ccf2eea61b9@arm.com>
Content-Language: en-US
From: Paul Benoit <paul@os.amperecomputing.com>
In-Reply-To: <935fd521-508a-4f66-9ece-7ccf2eea61b9@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYZPR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:930:8a::27) To SA1PR01MB8179.prod.exchangelabs.com
 (2603:10b6:806:330::14)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR01MB8179:EE_|DS4PR01MB994183:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c90cde-8226-4b41-d13e-08de1e4709f2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDFBZkVDWDNRcmFzdzYvc2dDQkNUeXduaVN1bEVPNGtnK0xZVlI0c3BQVGRw?=
 =?utf-8?B?NmdHT2Q0QUw2M1RIaGVmT3dwRGxlZ3cxZk0wTlgvSWNwNHZHUVVVYmRtMUNL?=
 =?utf-8?B?MDZnaVdMcVp2VDlBN0FMQ1dlTHJvUjlGem44cnJXZlZNUXZ5MVQ5NmY4dmpM?=
 =?utf-8?B?TzRwYWxsQ3UvVEQ4dDA3R0JlZDNIVXNZMTFEdWNZbEZKOXFJT1RVV1dlZURr?=
 =?utf-8?B?OHc0UHU2NFIzUmU1dXIyR0c5ZW9JZlBNNXA3K3M5WUhiOEd1SWRGSTc4NWJw?=
 =?utf-8?B?QjNhYkc0ZjRBNU1DaDJQbGROU3lLZkg1R3FYTGlKWXYwNVJuT2daZGoyRmtC?=
 =?utf-8?B?c3RldlltT1ZlZElQZU1jdW1UVE9oQW9pdk5ieDZkdDRmRmd6VTFCUVVKZHpV?=
 =?utf-8?B?L1hXK2VibEp4V2VleEpMQ2NsRmZGdkUrQ0RCWjVQRjZFNWhqK2V2RVdISlJE?=
 =?utf-8?B?Um5TT1drUldJZDF1NDVzdlVxa0FGaFMwNnN0VFFaNFRpR00rQm9yMlQ4Q0Z2?=
 =?utf-8?B?eXNJZXNiRmlvYk5WelJVNWZnUGErUzdndWVSTDdNUlRVc3plZno5ZGlSaTVa?=
 =?utf-8?B?ajExR2ZnTEQxYmR2SDlVOWdoaE9Ed0dnNjV6YnRWWDFDV05uWGJPMzNFNjBo?=
 =?utf-8?B?QmRvandhSEVGNS90NFQwbEhGRXFERGVWbGNDbGZ0ZDBaQVlGQnJSVzlSRy9v?=
 =?utf-8?B?Qi93bUdCcmVLUlNPejBlM0tsaDZROFVxdWVmeUZTa3BqZ3M3K0lJb0VEL25j?=
 =?utf-8?B?eUNPbVV2OFpuV0lTc2J6S0ZtZDlrT3ZseG16cSswMHRIZ3Q0Y0FQNS92ei9y?=
 =?utf-8?B?aEE1Z2swZkZTMlZlQXRHWkZPQ1ErNGpRTXc2RnNBSjBseGRUNlRCVEFaTGN1?=
 =?utf-8?B?ejBkZ3lKdndmYkZIb3c1QmxCVUNOMGZHb2FHVEo4QWtjYmpOMEdOV3JmbVAz?=
 =?utf-8?B?ODdPUlhWSU9SbnZpN2pqZHRLMGkwQk8vcTJwK0ZzYlk2SnJrYndxaU9yWG82?=
 =?utf-8?B?dmQvYi9oLzFMaGt3QlBJcUk3WUJaYzJKRXhIOGRUVGdxUHBvUTNmaHNvWXFz?=
 =?utf-8?B?Z0RGMmh3WGdjcGQwVHNJR3QwVDBNV0ZLRk5zTzh5OXZ5MnhFWGNXd0VSZ2VX?=
 =?utf-8?B?QzBSNmV5SGZJMmdld1JCbGY4Q00wOFVYZDhVM3ZOVGRUT0dFamJSeklCUTYz?=
 =?utf-8?B?UlhkZ1lqRjVIbHhMVEFkcnhibE1CZkRHa0V4eCtUT1I0RVRKbFBPSjdkcXI5?=
 =?utf-8?B?Y2R5aE5kMWxwYzNtbTgzc3BjbTMwZFhvVXAyZFlEbnYvZkJkaThoaElzZTRS?=
 =?utf-8?B?WGtvSEo2TG9wZERtUDg0T085K3RCOXR3MHVCdkJyY2dWMTI4SjdKQ0l3WWZ6?=
 =?utf-8?B?eDVrb0hvUUhIaENjdWVKUkVoNHRWMDVqS2U3SEhOTUlrRmUzZ05zNTViQ3hl?=
 =?utf-8?B?S05wNXM5ejlWalhMMVdaSXNqL2xmanl1enFoNlhPbEZQUVlvV2xOVjI0cTBD?=
 =?utf-8?B?Z0E3NStkclpJSUYxZnZvNGlZaWduNkhVR2dZQldoMFN6WGVsYmxqR0NzMy9u?=
 =?utf-8?B?bUNpOEdxdWdibXduUHVLWDdKdzlCNkJSUjZVQXNBSUpBK1lBSW5xdGtBNmRh?=
 =?utf-8?B?VFVOUHJFT1lOZytla2k5S216RU9uOEp0Mmk0N0V6STlrd1ZEWkx1ODBTMmhq?=
 =?utf-8?B?TWpqUWdRWHBueG9paHRNUTJEZG1rNnRNaWljN2liV3ljUTRGRlpWU2hRQzBh?=
 =?utf-8?B?eHlub2lsWFlmNmo2bXpTSDlGWHhuZjJPeHFMa0tlWFVNdjJzK2hVYXkwZnhz?=
 =?utf-8?B?dEp5SXkyK0FQZ3dnUk9nbFlJNFJ2aTl2L3BleWtKSTlmZ1FIRG9TSkVPUm5T?=
 =?utf-8?B?dnljNkJkYjl2U3Z6NHVlUStoQ2tmUjJJdC9XN3doUnNMVk82QTlGRXF5Y2Ez?=
 =?utf-8?B?NU03QXFmbXdUTVZKcno2ZmlPZk1xZEhyS3VyOWZvblYzNWpmb0Z4K1VjSUQ2?=
 =?utf-8?B?NXBJSmxXY05LTm5xZ1FLTWR3aHJwT3FXdkZmNlJJR1NvaGVFTDlGZDNNOTc5?=
 =?utf-8?Q?yGgl2T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR01MB8179.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YU5DaHFYZ0JSTXRrNVdVUXRvQWtKbmJHWGN3Uk9hSHJZVUdObmVtY2hsWkFx?=
 =?utf-8?B?NmlaSEZwY2VpNUpIdkhCT0x3aU41MlR6QmJKSGMybDRNWGpzdHY4czlrVTRK?=
 =?utf-8?B?MTJjV2k1SVZQRS9YT295MktjekVHSFBoTVV0U3d4R2g3R05sU1VzNGxjNkI2?=
 =?utf-8?B?R2xhdFFUTCt0RThyVjFjSitVeGRZbHF3V3VpN0l6LzNJbk9VYjJSS1hTUFhl?=
 =?utf-8?B?a244bjVUVXM2ZHg1bTF4bVJJNGRpZUIxZXRra2xYQ1lsa0xjMXJ2WmJTYmpO?=
 =?utf-8?B?QzRNTWlTNzNZVURBZHhma3FhTmdUWW9BZVVRajB0aTUxWWNKam9jdDloU3U1?=
 =?utf-8?B?Z3Rld1dsVmc2WlhoK2kvTnJnSG1DdFl4Ym1SOUJ5YUR6cWxLV0pRbXRPS2Za?=
 =?utf-8?B?b0ZHSUhUeHd3a243Ym5uQXAzK1E4Qm4wandZS29IMXF1blVOWHNBS0syNFpo?=
 =?utf-8?B?cGJORmZOYVFNZVo5dVJqTnE1a0pGaklmWUxPNWUxUExyUW9vdm9UTXpYL0NX?=
 =?utf-8?B?RU4yLzFpM1ovempFeEpXbERoM3NsUEpCVWJkVjZVVW1QZzVMMmpGSVFFeWpK?=
 =?utf-8?B?Si9BRjlGa0VPWnBZNkpIaFJndUZpU2tkZVR3dXg4VnJnQTFscGRNcDJheTVa?=
 =?utf-8?B?SEhmZTBkOTRubngyc0NRdEJFeUNEeVZaaG5RQk5CZkNOK2FWb09QR2diTFdM?=
 =?utf-8?B?eTR2YkVNb3h2TC9VMUJJRkQrZklERHNMVUFoQVA5L08zRUNoTVJEaWxBY3Zt?=
 =?utf-8?B?TkFEQlVJOG0vOEdKeHBLaTd0RndtaWFPWm9KbFQ0Y2ZsR3pEYnlyYS9ydm85?=
 =?utf-8?B?SCtxcEpqeWY1S1JNT1JDWDdpZWU4Mi9uV0IxTFdDRFl4RHV3Z3RxR3UyTFcz?=
 =?utf-8?B?N2REZjA0L3I3WERPUmdScFFFWG1Tb3N6Qk12bGpYYTFlUU9Qd0tYcVF0aTZK?=
 =?utf-8?B?N1k0ck9JTkxIK253eWVnYjVwRHBWTC9ETXF3M1VFSVFyYXhBNkc2VmpPWlBS?=
 =?utf-8?B?OUhIVEZPeUtMbFozMnNwRkhFR2c0dHkxWWhBODJTRGRsTjBoSnliN3pjZFZ2?=
 =?utf-8?B?cjNVdGFvT2RHbkNKUzhUVEVZVlE4S1hzTmhDN3U5NmFsR0l3ZlJySEJxZG5E?=
 =?utf-8?B?R25zVE9zMnF2RERTR1IrcjJ5UkwxRy85cEhIcGtVdCtxQ0MvdU92dXNPT052?=
 =?utf-8?B?ellWRHpTU3dDSEJ0dWVQZTAySFpqYyt3YXNRSUE5WUwzSDdJWUh2YkJoOTZy?=
 =?utf-8?B?Wm5lSDhuNEdDckdmYUhtL0c2Q21DL003cXE4dmJBaGQ2dGVHTGRMWnUyRThP?=
 =?utf-8?B?OEJOWlJXcC80Z0ZXa0dUcmVZMkY4OTJIcTc5bzdtaE5RYXVLcjZNcDZ1UHda?=
 =?utf-8?B?Y3pVa2hkTCtHRGJDMUEwMDhyVnh5SUxxbE1LNkR0VVViSysvSW1sZlpreGl4?=
 =?utf-8?B?b3pnRTA2VFN6T0pqdnZoTFJKd0VSS2VuNlFOQ0I5MmFOdUVIaDNheG9xWGZ6?=
 =?utf-8?B?T1VkeGNBdGVzQURoc0l2OUFjd0RFTkc3ZVJtdlFVSUd0Z3pnN1FYdk5sSTdJ?=
 =?utf-8?B?cjQzMnNWNmdtUWJyMTY0T0p4UG9peHVUZzAxejFONzBnQ1FOdkV5SWlRRGxU?=
 =?utf-8?B?NGNkaFVZMzJWTERhOTR5bGcxMmIxRW9Bc1lyZXhoSzJZMkVOM29QdXJNSGJ6?=
 =?utf-8?B?RTFzZDA5emVWNnpIZ3FsL3Q2alkwaTJkMmd6bC9oTkpvK21wa0Vxc2hqZFc5?=
 =?utf-8?B?VzFkUjFXRDkrZzFWTVRjUWltdEovTXU0YmFCVURhL3R0TkRZY3NtR3MwdjBy?=
 =?utf-8?B?MWZFZnBYbWhGWmtjd2NUdmxVUkNwdVVoWURSZFFBNGZZYkRUakJUMnNNcWQy?=
 =?utf-8?B?RS9GWllSYWlpOFR6V0ZYeXVTaDBPbUN3RHJlczZUd1dnN1cyZ2dta3c2WE12?=
 =?utf-8?B?M3pGK3RyZW56Z3U4QVdRWFdjT0F4eU9FeVRRbDRVN0xjL1NBQ0xwS3ZwMzA3?=
 =?utf-8?B?RnJmdnVuUjBkazk2ZHRQVlVidVpMa0RML3NqWlZBWVAzQy9ZL2pxV2VnLy90?=
 =?utf-8?B?MkdaMDFTTkJKb2svOWp2S3N0ejNDYnBHRkVGRnl5YVlXeDJiWVlicDhWYlVp?=
 =?utf-8?B?RzBvZkN1eWFnYlQvbWRMU0JQQ0luQnI5MTNUa01TNDJuVGNWZy9ET2w3NFhm?=
 =?utf-8?Q?fuAjdnHOGUKSx/jzuRwVvTk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c90cde-8226-4b41-d13e-08de1e4709f2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB8179.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 21:45:59.3116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ZOsYWIS/SOKoSeu1Ub7gHlwO3ZDW7Mn+RoJNYFy0LpQLKLhtaQGmtxoFHGQpXWVtwtJ5mw7CAA9JrnKPfVEIO53GANXVsgZJOgrKCivf8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR01MB994183

On 7/11/2025 6:22 PM, Jeremy Linton wrote:
> Hi,
> 
> On 7/11/25 4:16 PM, Paul Benoit wrote:
>> When there isn't an entry for the model name in the id_part table(s),
>> attempt to get the machine name from /sys/bus/soc/devices/soc0/machine
>> to use as the model name.  This mechanism allows lscpu to use the
>> model/machine name provided via the ARM SMC support code rather than via
>> hard-coded lscpu tables.
> 
> Since this is suppose to be synced with the DMI data, and is sourced 
> from the firmware would it make more sense to replace the BIOS name with 
> it?

I was recently reminded that the SMC CC SOC_ID Name
(/sys/bus/soc/devices/soc0/machine) and BIOS name could be from 2
different organizations, and may not always resemble each other.

> 
> 
>>
>> This code was tested by removing the "Ampere-1a" entry from the
>> ampere-part table and verifying that lscpu displayed the correct machine
>> name obtained via the ARM SMC interface to Trusted Firmware.  The
>> "Ampere-1a" entry will be permanently removed by a separate patch.
>>
>> Signed-off-by: Paul Benoit <paul@os.amperecomputing.com>
>> ---
>>   sys-utils/lscpu-arm.c | 35 ++++++++++++++++++++++++++++++++---
>>   sys-utils/lscpu.h     |  1 +
>>   2 files changed, 33 insertions(+), 3 deletions(-)
>>
>> diff --git a/sys-utils/lscpu-arm.c b/sys-utils/lscpu-arm.c
>> index 8745599d4..a46106bcb 100644
>> --- a/sys-utils/lscpu-arm.c
>> +++ b/sys-utils/lscpu-arm.c
>> @@ -388,7 +388,10 @@ int is_arm(struct lscpu_cxt *cxt)
>>   static int arm_ids_decode(struct lscpu_cputype *ct)
>>   {
>>       int impl, part, j;
>> +    unsigned int i;
>>       const struct id_part *parts = NULL;
>> +    FILE *fd;
>> +    char machinename[BUFSIZ] = "";
>>       impl = parse_implementer_id(ct);
>>       if (impl <= 0)
>> @@ -406,11 +409,11 @@ static int arm_ids_decode(struct lscpu_cputype *ct)
>>       /* decode model */
>>       if (!parts)
>> -        goto done;
>> +        goto try_machinename;
>>       part = parse_model_id(ct);
>>       if (part <= 0)
>> -        goto done;
>> +        goto try_machinename;
>>       for (j = 0; parts[j].id != -1; j++) {
>>           if (parts[j].id == part) {
>> @@ -419,7 +422,33 @@ static int arm_ids_decode(struct lscpu_cputype *ct)
>>               break;
>>           }
>>       }
>> -done:
>> +
>> +try_machinename:
>> +
>> +    /*
>> +     * If the Model name was not found in the lscpu 'id_part' tables, 
>> see
>> +     * if there is a Machine name associated with the SOC.  This name 
>> may
>> +     * have been set via either SOC specific support code, or obtained
>> +     * via an ARM SMC CC call into Trusted Firmware.
>> +     */
>> +    if (!ct->modelname) {
>> +        fd = ul_path_fopen(NULL, "r", _PATH_SOC_MACHINENAME);
>> +        if (fd) {
>> +            if (!fgets(machinename, sizeof(machinename), fd))
>> +                machinename[0] = '\0';
>> +            fclose(fd);
>> +
>> +            /* Replace newline with string terminator */
>> +            for (i = 0; i < strlen(machinename); i++) {
>> +                if (machinename[i] == '\n')
>> +                    machinename[i] = '\0';
>> +            }
>> +
>> +            if (strnlen(machinename, sizeof(machinename)))
>> +                ct->modelname = xstrdup(machinename);
>> +        }
>> +    }
>> +
>>       return 0;
>>   }
>> diff --git a/sys-utils/lscpu.h b/sys-utils/lscpu.h
>> index bd7b64cc5..581602f70 100644
>> --- a/sys-utils/lscpu.h
>> +++ b/sys-utils/lscpu.h
>> @@ -46,6 +46,7 @@ UL_DEBUG_DECLARE_MASK(lscpu);
>>   #define _PATH_SYS_NODE        _PATH_SYS_SYSTEM "/node"
>>   #define _PATH_SYS_DMI        "/sys/firmware/dmi/tables/DMI"
>>   #define _PATH_ACPI_PPTT        "/sys/firmware/acpi/tables/PPTT"
>> +#define _PATH_SOC_MACHINENAME    "/sys/bus/soc/devices/soc0/machine"
>>   struct lscpu_cache {
>>       int        id;        /* unique identifier */
> 

