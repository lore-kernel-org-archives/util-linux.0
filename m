Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023079.outbound.protection.outlook.com [40.93.196.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1D32F3C02
	for <util-linux@vger.kernel.org>; Fri,  7 Nov 2025 21:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762550781; cv=fail; b=USIVsSNW7Cu5D+3ItTmJqPv+/BBF6aRRzAgcqMm4SS07eCO8Wc5ZoSW78T6l3xyktxd2Nul3XC94h1mGc7V0Go2yf5/WA8N8h8T9FEItSj0wBwZnlfliS6CjIhli1uvwRJBT+thKo2TOht2Y37czxHiasqFoiBUp5RgEi4HWDbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762550781; c=relaxed/simple;
	bh=iGje8arKOk5IBtHpxDSgn308mPsUzFu7/iI+l02+/QY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ku81xysH/HG5ZyXJ7xbQKhwVjJuPaideBhhRp5/uJyRw4In0eTF6haocTfGteRVCak9UDESblxtiPqOpj8hXZgrGRtjG1yHQCsAeVeaWyG07NLYI6rhquDDmj0CBebiugXp+SMv48zbNXjumJfXVezpJUI3ONY/Gm01BZ4blopc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=GCnj5WMD; arc=fail smtp.client-ip=40.93.196.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="GCnj5WMD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rE1mvpsfePhyfP0s8tvqqumyh8R5qj0foGqiB/0X74XZTkDR927TwDeiRVyjQO5BuSrddEjSOaoDgVhJA69z78O4IgmzDQ+kN+mJn95cJ40UBYzvvFklBL3R7yE2pk3bPtQrTx9T94RjitUjg+M3x1yPF4NIbECLMoC8X5nxlVJQQM/TywaotGK+pWno2AQExAT/9JqAcEETafLA23XBHyhoLbWVT2dkejpxQzNSZ9PXDJFANFNulwUMi1KYmXu68vB+NXvtaJqzKc7lzF0r1dHxGwGc2sf4JZaVaE/gEP2QYZ56CBRIMB0H/DkF5ETBPIKTxCLcnZPQ52DxpLsKOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AL164KKGHol8gXFyuHkYMf6olLING0QG0u271VdeFdM=;
 b=JIUOXWIQ34dXSkpYN2W02A/dc/Zn5xx7utMu4hWURSBRATesSdAgIZyOim6CWfL2eMn9zwbSB9NHOfE657bmhG3nv+tW4B/rJa8VQJFNPsf+IpfibLLjo4MG/X/QeUWUTs3kH2iKaQZIDFpX5B/T1cK13qy2piRGJQLHJ4Rum9kLAmb1eXXxnBB6h7YdAXOVRo5oYSbEyMaaQWOlFYq6SQU6bq5Ct1fx2uVAkjsp3T7EpZque22+ULLiUxABQ9NdAq0ZF37wvokd3qthG2f1AQ7czGeQQzLslkKVLDIuQFbC+SF+gwtEJCVKhXbNMydPQXlFcdQc0RrOtfN4MRahBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AL164KKGHol8gXFyuHkYMf6olLING0QG0u271VdeFdM=;
 b=GCnj5WMDsOLK+yi2kr8FbHKfWTpebqU3jczN8oPsldo+MgOqfy30c3g/SMEliR8hMFLrnS3I83p2NgDdxmBComPJ2TbgA07o9pCQoakVXLAKeA7Zt5wDjOIlKrh7FWr6qzYcr2L95SvJXswT0dDMUbu65Wqz2oaNuGnXmh5nKTw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA1PR01MB8179.prod.exchangelabs.com (2603:10b6:806:330::14) by
 SJ2PR01MB8005.prod.exchangelabs.com (2603:10b6:a03:4c2::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.9; Fri, 7 Nov 2025 21:26:16 +0000
Received: from SA1PR01MB8179.prod.exchangelabs.com
 ([fe80::f091:2832:ffa:784d]) by SA1PR01MB8179.prod.exchangelabs.com
 ([fe80::f091:2832:ffa:784d%3]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 21:26:16 +0000
Message-ID: <291de2c9-06bb-45db-ac65-585c85e40f37@os.amperecomputing.com>
Date: Fri, 7 Nov 2025 16:26:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] lscpu-arm: Remove the "Ampere-1a" part.
To: Karel Zak <kzak@redhat.com>, Jeremy Linton <jeremy.linton@arm.com>
Cc: util-linux@vger.kernel.org
References: <20250711211648.53361-1-paul@os.amperecomputing.com>
 <20250711211648.53361-2-paul@os.amperecomputing.com>
 <crm5fcuper7bhu7iv7jbejf3rnowwo4tuwrjnutngta56dedgm@zajfg6nh2okx>
 <fb54d607-dccc-419f-b92c-7bc8514213a6@arm.com>
 <muus4f4qyxjt3af2nxjois2twuvbfnbf37glsyiptslb4orglf@rnvwiszoffgl>
Content-Language: en-US
From: Paul Benoit <paul@os.amperecomputing.com>
In-Reply-To: <muus4f4qyxjt3af2nxjois2twuvbfnbf37glsyiptslb4orglf@rnvwiszoffgl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0189.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::14) To SA1PR01MB8179.prod.exchangelabs.com
 (2603:10b6:806:330::14)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR01MB8179:EE_|SJ2PR01MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ff6c121-1410-470e-1161-08de1e44490d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sk1wS3dKWlIvL01PK0tIZEdpMjVNM2QvTU9RaFVhWURuZmlqZVBPeWRNWFAr?=
 =?utf-8?B?RTRibDA0aWs2WmVzSWhDbGJ6NTZMN0NmNy9Oa3Z1K1ZWeHkwakxZeGhTWHIw?=
 =?utf-8?B?UHdFKzY4QnhBdzdkbDhSWDMzRGlkOUFYT3liOVFsSVFCcmhESzVmUUw4bXJL?=
 =?utf-8?B?VkM4UkQwOXZabUN1R2dMRDZXOVhxQXhJbFJYRURNVUFVdEs4bWc2Nkd6ZkpF?=
 =?utf-8?B?L2VvQ0FZTHFNNXJ4d0Y5bVRZZStyUFIrVGNTdFdqVG9OcTFubG9YZFpzYmcw?=
 =?utf-8?B?VVR5Rk5hYmY2TnRwaW16UUk0ajZzWDFqdEs5bXNzaG9lK25yRW5TNUYxU1B6?=
 =?utf-8?B?eS9PL1pSeXFVald4bWY0SWNWcVBOdkZEblo3VEJUVkNZeG9SQWIrOVNacnVB?=
 =?utf-8?B?Q0RrNThvT1dmMnJLL25oRU5hK2kxaUVJMkFHKy9mTFlDbFozVXh0R3Z0Z2pj?=
 =?utf-8?B?bjNBaTBKRHhlazhpY2JCQjJCd3lhQ3dCUTJMSkYrU2NmOXFQakF6VlNYWjZZ?=
 =?utf-8?B?NERsRGt3akRpWWk1WlpTNjA2Zkl6NnN5Z29OeHFnQXFCbW80V01YRDV3SUZ6?=
 =?utf-8?B?TmlySm15ZmtuZ1pjY3FaRG03cFhSWkpUcDdlT3dTT01Nb1Z3Q0hVY0dYcnBS?=
 =?utf-8?B?amdqUW9PakdlcGs3aGRpTmR2TmV4ZTFtbFpxWkdaTnRwakphWndVT2dBWlVi?=
 =?utf-8?B?MHRVNHZsa0tQcnc2eXZlR3lOSm5hQmpveGtXekd4cEJVODBhTFlYRGhVeTJZ?=
 =?utf-8?B?N3UyTUk3aUdhUVNrcUVQcmlHekcrVnk5SEpONkhGWHFPODUxbXFpQk90aXVK?=
 =?utf-8?B?MU8rbHljSlBKM0haZVQ4cnpwMkJSYWVWWUFxQVZPMTRjczg1cUhQMWs4OElP?=
 =?utf-8?B?L3R1bUQ2bS9od3lINUt3WWlFUFhFN1VYUnVDbDRnaTNRZ1Flemx2YWtkS3Ro?=
 =?utf-8?B?dk43RElQYVpwMFhxYlMyVDJmNVBxVUM5Z2V2OEFEVStvdG1LUlhIb2srZytM?=
 =?utf-8?B?SXA5MkNxNDF2MmxKTHBRbVVwcDlNM3VGVldhbFdYa3JMb2hueXluTWZDL2JK?=
 =?utf-8?B?QUJwa2dRSVlNTnVMT2NUVXR3dkZMRkJEdTNtZk9vK2hLanlRTXludDZUVkFu?=
 =?utf-8?B?M25nV1drajdVd2paaXJTR3JhZVB3Qm52YW9uTWJVZXRsaEFPRURyL2c1S0tB?=
 =?utf-8?B?MUNYcm9acGc2c0lPNDZmaHB6N0dReTRTblRzM2QwL3FnbVNsSVRXcGM4ZVBQ?=
 =?utf-8?B?aFBoUk5DeGN2bUVSWU1LOU0vazd0SE1FWUFOZnZxTkFNTW4vekNvejJlQ3pD?=
 =?utf-8?B?WmMyMzE0eUs5ZVZiZGp0RVMvc0o2Ukk5YUFOamdNaHBUUldtQ3Z0NUhhQisx?=
 =?utf-8?B?NnlwRTVUM2djZ2NjaEFBQnd0Z05xTVZYc0t4THQvemRBb1dXWjVTdHhzZkxH?=
 =?utf-8?B?SUJjU3YzQmJ4T01YZFQ0RkYwTkFyTEVOVjJDSlNDRHJ3cHRkMHZLM2xqcWEz?=
 =?utf-8?B?TGdsbHNUMVZzbnR5NTZPZ1ZpYUpPRkduS3pMTkJlS0Y4RUVkWndhN2Zxeit4?=
 =?utf-8?B?alhyc2d2WUZGQWpvK0gxRlJxL2hXd3ZrSUh0cEN4b3FMb0h6TFdGNktPZkky?=
 =?utf-8?B?UVlSQlpZbDFyOHArSVZWaE9sc0FxRUYxL25xQXcrdkFGK25URkxrOFZ0a1pk?=
 =?utf-8?B?dy9QYnRxVVJUUHAyQkdPU3NXOVo5aHZVQldPWDR1RWp0TGxRb0ErR3JKekZp?=
 =?utf-8?B?ckpTblBWRkIrTWFhRENrR3YvRWJxZ2xQMVFvTnRCL3ZVbnFCalhDYWJNYjVy?=
 =?utf-8?B?N0pocnE4ai9ZS2M0T3R5OFIyWjdzczZvYm16c2tmVy9tQUJQMStBNnlhd3Ja?=
 =?utf-8?B?d05hL3IwUHd6RVJXRW5sMGJwclR4UGgrSkZ3OWY5UHJBenZzTEl1a0ZpOXU0?=
 =?utf-8?B?UytUSUZOQ3VwTlpKWVBCL0FjZjBDa0Z6MkNJUVVEeUU1NzdUQmZVdlcxcXVR?=
 =?utf-8?B?RG0xOUhXODVsd0JEbmx2ZVZrTmlKTFl3K25mdExuMFdSa2c0UG5FMndpZG5Q?=
 =?utf-8?Q?JnXNGi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR01MB8179.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2hCczMxU1dQeDhSVXdUMS92Y0FVeEg5clA2eXB6R082WUljc1hIMTFCclUy?=
 =?utf-8?B?bnFzU01mNUZ4aGJ1czYrOFRaeUZmZW1aMkJUODVDTGk2bkIvN3dEYzZXb2pR?=
 =?utf-8?B?Vm1rcEUybCtDYU1yNGFoelZkY0xVZ3lsOE5zZml3ZXY2RnlCeEZaSlI0MUhU?=
 =?utf-8?B?NkJnd1V4c0JSY3FmU2ZTSldaMHRaNmJwTW1JVEZuS09lWWtaYjhIREtCc041?=
 =?utf-8?B?eDBDOE9nWDJOYXdRd1lzQjQyZjY0cmExVGJSdnlFdXg4alMxbzVJVjZmS2l0?=
 =?utf-8?B?TjVpSGgwUThwU0RPSmRWM05YbmNiOCt2RkhxTHpaYytJcUIvM3dCekkzaVQ4?=
 =?utf-8?B?QXhEYnBBeldVb2p3cUMrTmZMTHlhNFczODV5bzdiSG5tbjlDTHNPN1pEaWFF?=
 =?utf-8?B?VzUxZG90a083T2ZTYjBueFVpcGJCQ1A5dExtekt3VlMxcDNZSHVXTTJpZTFB?=
 =?utf-8?B?bkhNcEIxOWVTN2s4US9aTU1ibXFIVmVZdGZOZ093d1NxQUdaTHA2VmNLZDl1?=
 =?utf-8?B?L05EQzVyNDlsSmFaOUI5YTk0VWdUWi90ZFYwMmttdjVWNnorZm55NjlNYmll?=
 =?utf-8?B?Q1RENkFWNDlXK01mWkovN0toL0VmZXlvUHRWWTYyNXA5WnJnVEEzcmFrNVRW?=
 =?utf-8?B?a2pzWG9oTEJtNnAyQlhJYi91aVpJY3gwOXBJREY2aW93WVM0ZnBjb1BJT2x1?=
 =?utf-8?B?MGVCcWxoSmlUdno5L1kzblovcmxvcmhFR1lrRjZwdjFQbXB1TzJMVkR4TjNn?=
 =?utf-8?B?RjJrdC9kLzNIaWtEVTd1ZVBvYm5WU3JtUjdPV2I2YXJ4alhWMnJNdURubnly?=
 =?utf-8?B?T0FoMGovODF3TjhHREJLOEZwbHhBZzBlM3kvNlZaOFFPdWNFZDU2dU5Hbkxp?=
 =?utf-8?B?ZjVObS9YbUZ2Z3JxVlFML3BzWW9WY3AxTE9UM3IxT1lKaXNsMDJqL04xazVx?=
 =?utf-8?B?MVJUNkk2RWhrQXF3ZE5FZlRrTitoTVRWVzVxSEFDLy9oaTVWZ3JhZnNxb0Yv?=
 =?utf-8?B?UmpJTDZHeFBFZEtqU21KYjY2b0t4KzV6NFhQMHljMktIak52S3E1QzM0cW1x?=
 =?utf-8?B?NDV0MjZzbkhMQ0JVZk1vYUVnRUoxcDdaSFp0bCtqRzlScDB3RnppOUhMcUtR?=
 =?utf-8?B?RVdORXZRMWJKSzUwSksvRzJNaml0VXRmNU0vaDVoZUFCVFRWK1FQN2s2YldJ?=
 =?utf-8?B?K2hSdWtXYVVLWWRNVWxpS1hxaGVuVnFrZ3p4R2JKeVFVQlRlTGNEMldSdTZr?=
 =?utf-8?B?UmV1bkl0TGRYcEQ1UlhxRkVQRjIvTU9HTU9yTm05ekJUTldBdWxvNUdLVXBT?=
 =?utf-8?B?bW1ycVBVcG50dXQ2eG83aWd0ZUE5dGJkeExrRzFjYks3SnNoekxvRGxDVzk3?=
 =?utf-8?B?cjRXUnQwV3VtTVN2NGZhWnVZdDFNSHhMSjVpRWFZMnZTQzdTTUpnTWVCVXdJ?=
 =?utf-8?B?YnlSVStxMUpQUlBLeWhPdWN4TFNnejhXZEk5MVYxcjhMRzNrSkJ0YjloU21G?=
 =?utf-8?B?cTFFQk5lLzExeU9nVGwwemJUcXJ3TFFQUjErUjlnUFVxd0E3MHdQRldUMnpz?=
 =?utf-8?B?dzBaTzFITnEwNUl4RkY3SXFobURpVmZxUk9HcGJLN1JXUFVQZEdnaUZsck9D?=
 =?utf-8?B?Y2x1a2gySGpkM3BkcGp2VUhrVkdYMTBHWmgyZFhqcDJ6QnFNc0kzdklxMExn?=
 =?utf-8?B?ZWJOWi91b0l1NHowMWJhOTFIWVAwQ2x0cWN6S0UrMlptMHE5WWVjNHJkZVU1?=
 =?utf-8?B?OXU0d2RrZUZIS01XT294ZUJIT3NpUUhJZFM5VTZaTjZtTzZYV09zYlBLc2ZT?=
 =?utf-8?B?SVlieWJFRlBZSmJkZkd6R0czcGlXVWpESkQ4U0ZCSTlmaTY2Qk1Hby9ac3RO?=
 =?utf-8?B?WTRybHgrYTR5ZjFON3QzMngwQVVnOFoxaUcyYldSckpKdk5Ycmw4YTRIc2tT?=
 =?utf-8?B?OFEzMlBwMkFEM2JYWDhHb0FRUzBtRkFTV2FOVCtOZUZKcGFXUmR5N2ZsMFB2?=
 =?utf-8?B?MXRNRmorV3owVlVNaFBSbEg1RmhoQkpPTFBHM01kRlAvU1RzQldham1DYTJS?=
 =?utf-8?B?R3FnTW1VbnRBMVdqeTBFTmV6b1QybEN3ZEp5V1N5VkNBSEVKNXF0eXZLcU9x?=
 =?utf-8?B?Zi9WOEJCR2hYdlU5L0U1c1YxMVd1NlhJR3RidDMrSmNZcVlIUnRvOHVEUVRw?=
 =?utf-8?Q?KkdiSrfX/JhraxTeZ4NH0uk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff6c121-1410-470e-1161-08de1e44490d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB8179.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 21:26:16.7393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3lpiZJ7FTmLVDK6FrrjBO2/ayIeFH65hwO7Saf1+UOzIEH0NVbjQ5zH7q7J+NvJ+tdvo5ka5BiHZA4s/zUOsYUmXtKVL91ggCpX73dDlaAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8005

On 7/15/2025 5:19 AM, Karel Zak wrote:
> On Mon, Jul 14, 2025 at 03:48:50PM -0500, Jeremy Linton wrote:
>> On 7/14/25 7:16 AM, Karel Zak wrote:
>>> On Fri, Jul 11, 2025 at 02:16:48PM -0700, Paul Benoit wrote:
>>>> Remove the "Ampere-1a" part.  On newer Ampere Computing systems, the
>>>> system/model name will be obtained from /sys/bus/soc/devices/soc0/machine,
>>>> that is populated with the ARM SMC CC SOC_ID Name.
>>>
>>> If I understand correctly, there are old systems without
>>> /sys/.../soc0/machine, right? The change will remove Ampere-1a from
>>> the lscpu output. This sounds backward incompatible.
>>
>> Thats a good point, but as I understand it, Ampere hasn't been happy with
>> the string that is there.
> 
> We can update the string to make them happy.
> 
>> If its OK to break whatever scripts/etc might depend on it at the moment,
>> why not just update the string.
>>
>> Then invert the check so that the /sys/bus entry is preferred?
> 
> I still do not understand how a per-CPU identifier can be replaced by
> one soc0 path. What if there is soc1, soc2, etc.?

Yes, I agree that /sys/bus/soc/devices/soc0/machine shouldn't be used
for processors/cpus in soc1..socn unless all physical SOCs are mapped by
soc0.  My recollection is that I only saw the one /sys/bus/devices/soc0
on an SMC compliant system with 2 SOCs.  The smccc_soc_init routine is
what calls soc_device_register once.  The support code for other ARM
SOCs call soc_device_register from a *_probe routine (run once per
SOC?).  As per my other reply in this thread today,
/sys/bus/soc/devices/soc0/machine will only be used for a SMC CC
compliant SOC.

> 
> Anyway, using /sys/bus as the primary source and the hardcoded id_part[]
> array as a fallback seems better than removing anything from id_part[]
> and relying on /sys/bus only.
> 
>      Karel
> 

