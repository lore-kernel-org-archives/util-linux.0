Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022118.outbound.protection.outlook.com [52.101.48.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4632BE7AB
	for <util-linux@vger.kernel.org>; Wed, 20 May 2026 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287632; cv=fail; b=bjfAKxQa56uRTqyORYomec4kdIW6l4RoMWMnt/nHVCer/i8KpzMGAD+BgLXf/Z6fhIgD1Fxxe+fzuuxn7KN/v/5oPhIh31/aOdDE0UvvW91RaODGJMPA5sdL9VaLo4ez/0dyVOzXCX7a5ows4ebgykp5AoaGqQ1qGlymCCTDyoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287632; c=relaxed/simple;
	bh=cbXB2YjG1pAKgvKDJB+3Hq5JJFegUAcKEN1o6HiP0UM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V5Z07N3qCoFp2vIPREDdOJ5BVbTmpDlLnyWYkXvrpTa52QLChCc6WNYCvG5/hb0ZClYafIHejIgph5WJJWNfIYRAq0KWhis3bUak/IypKnV6D82f/w9k37pVp14Uvate0xOh5Pp9IKg9PoNb1teyMzvV1MQs1fqvdfM/1Q2ir+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=T8CgqWPm; arc=fail smtp.client-ip=52.101.48.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="T8CgqWPm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljmo4LJVbppv/ruG6C47oPSOuNtJUBmfKsrmOvlEUbP8qcs+HxVjZDhRk3lKaIFNEecKi5va7yGtv95atjb7aKRC//o0L2nwEDwFfn/q+W7FqEaLrPXifA87V70uiHeiERfRGll7E0UI+4dVYq5B69zyvvu1VwtRQ9Zvy5DdgM4BgZO6W7Q1Zt7XTePnuBRTTmXb0e1OwQEaEfP+hsdKTvza9L35gHWPU2l9kPDImINlROhEr9CnRf9osAQOd1bnv007zikDoULLvRGa0Vrb75or4C3DnBArsvhOygsZwyl5ByDTGMsoStGtG3PC8oD/OvgIVBCL/ONYS7cnRpnVIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVJbTbpiO6yDPq2ezlZm5+NQ9JfBp4svdAKrN5Vj/48=;
 b=gAZvorX7/NMQWkLIH/myzQ5rnWOsaoWGh5S6YPTvA0cBbvuI7uE9RgosXKqYrbr9SsWppTy2nKd6cMayNgma1lUEdLtN5qZWsOUiMS98Tw0cfN7SUHs80LiB2pp5r2TznYyNdh3KxJJgbpwPXTdU4xNIoHBUxP6koPgJRog3T9cz6VVhyNZZ5oRhDF4rBtPop9fHcrz/Tm8N7jmAH7S0aK6eHVpkSvmIugqvAFGXVP1BR8R7W2q9iHiLawCIKeHIABOped+XgNl4G9eUHHC0UvRw27TWUPXSCmsjXsW1Qxny2Xppq6Fo7me4Vfzo5GjgWD0EkNVrHmSCB9/C5q8shg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVJbTbpiO6yDPq2ezlZm5+NQ9JfBp4svdAKrN5Vj/48=;
 b=T8CgqWPmjZ5wO1wvl7cueT53jqfqpoY9O/LEL5iLzYEHsT+rb4Y+QTZXpkJQ+Z92dRETcUnxZDZr6P4mq41NwVrxf5FMG4Z9cvE1WXgrjfOz3WW9kFGO1r3rvnhIL2LjsCWg5pkNqjW0An6fpvYXGWNdGySurNBoLbQBtmW294k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA1PR01MB8179.prod.exchangelabs.com (2603:10b6:806:330::14) by
 SAWPR01MB994493.prod.exchangelabs.com (2603:10b6:806:4d4::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Wed, 20 May 2026 14:33:47 +0000
Received: from SA1PR01MB8179.prod.exchangelabs.com
 ([fe80::f091:2832:ffa:784d]) by SA1PR01MB8179.prod.exchangelabs.com
 ([fe80::f091:2832:ffa:784d%6]) with mapi id 15.21.0048.016; Wed, 20 May 2026
 14:33:47 +0000
Message-ID: <9dd167b9-60e1-4caa-abfa-58aad5efb328@os.amperecomputing.com>
Date: Wed, 20 May 2026 10:33:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] lscpu-arm: Include the ARM SMC CC SOC_ID name.
To: util-linux@vger.kernel.org
References: <a758edc3-2d4f-4e5d-8951-8aad0c3a546a@os.amperecomputing.com>
 <20260211212309.126190-1-paul@os.amperecomputing.com>
Content-Language: en-US
From: Paul Benoit <paul@os.amperecomputing.com>
In-Reply-To: <20260211212309.126190-1-paul@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR17CA0022.namprd17.prod.outlook.com
 (2603:10b6:610:53::32) To SA1PR01MB8179.prod.exchangelabs.com
 (2603:10b6:806:330::14)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR01MB8179:EE_|SAWPR01MB994493:EE_
X-MS-Office365-Filtering-Correlation-Id: dd9c9313-6451-4c29-5b96-08deb67ccd3a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|3023799007|11063799006|22082099003|18002099003|55112099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	u7FSGIG7ioEoMG2ae+Im5qfgaHpoQFFSozfx5bauzurvjnl8ZwrkTrUUPHIVPfvhvIv6FBI8cQhkIFAQkanE7vGbMWNeHv6745Dtc+4hMqIg3QmnzqAAsujXmZZAV6WZJ7NNTh1bxayLVNBSZ/SYwzrbSi2EJbJ4N+p+/DcGnrlEvniv9A5gbfyG3WHFhvmIAh/cDZWWH0hWw5CNKV1QCPlU0KnowXt6IGcGcUDTk2Ul1+lWZu2T/l3A0e+EZ8pFvtKDdAKPZoZyVSzjZL5eODf4GM8vbbgMakD4hRXaOxGqxLy6QQzIVL1T84hMzkH6KXdB3f7Q1GAS7oLbO4c7F6QLkZ6GfJRxYYPAn/1MlfN2xzIEN90fOVs26ANkHMqsH1isntCqWbV3+CpgrEH1jZ2ZpZOg8zKQkSFwOIsXtE88hn6WLEPOc/wYIpPDXjexpD676nCdwXlY75nqEMiH5bVJhU+0CwtJpDhZT/yUvS/MSW0PyKXS6w57CwggHmnyt0AnIFD+IJ1En4LLQpzIUogNyPC6rvnUen6IjDkigsSV33/d+HD+0217bMI+bTEB71yEeVyW5bqkYV39alP7NWGcly/t31kv4uSKfWalTrFNNtMx9mn3AwBNO1MFHQD+yb8J/gdLUHaqeHkqITQ4rZGF8/dluU64QAgxejLv/Omy9sHAPoiUnH4hH07Omj7Jfw/3GNl1jsLqyIuri8IuhA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR01MB8179.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(3023799007)(11063799006)(22082099003)(18002099003)(55112099003)(56012099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXNycnZpME84NnM2RlFWZGV1dXNHNGs2UmJqeEJ6Qjg3YjBqdFYrbVNoRFMy?=
 =?utf-8?B?Wjg4cnpib0U5NjZJUG9aK3NIOTNxTDlMckovZi9GSll3V2dNU0FsM2RDNzJL?=
 =?utf-8?B?dmZ4ckd0Q09YUjBXM3A0WkxUR3lQa0d3UE5LYzlyQjVoY1ZxeGN3TDNaZkU1?=
 =?utf-8?B?RGRtZzdpMGhjNjdvMXZqb0xqdG0zSGtPRk15dUUxd3VqRUhPbHRycFRuajlo?=
 =?utf-8?B?eVdqMkFUeVlqSjdJb1NHSFo3a2M4eUVYbVo0eUJEUEZIMTRaNUh1RWVLTVJn?=
 =?utf-8?B?NlZFaTFSbnU1ZUM4VXNLeXJWZTF5TmNSc21Lc1duTUsreGhKTkdEQTljZnBU?=
 =?utf-8?B?UGdCMFJyZTRTZ0tuYkhJbW55MG51eVRSYytiTkd0Y1JRMnQwM0s2OWdhS2dD?=
 =?utf-8?B?SEl5cDBrQ0NKRytFb20vZEV5ZTJRN0hEaU51Nmc4NDdNQUhKU290YkFPNzNB?=
 =?utf-8?B?aEMwQ24rM2xHMy9yMzk1SFQ2cWxEeFRKb25ZT1Q2OUNIRWg1dDdRUXFRaW9L?=
 =?utf-8?B?bXJlME1UTzFJMmpLOXFYTWJQeWtxMmJ2ckpmNWhZbnNhbDdQNjJLWHdaV0hS?=
 =?utf-8?B?c2lhNXRtM1NLOXd2ejF6eThab0RlMCt0UFZMcm9pZ05ad1Z2R0FFekFsTnF2?=
 =?utf-8?B?T0c2czdYaHRHcS9HT3YxcFkvQUwzaE1IaG91bmpTb0NQcUN5M2YySUdXbEVJ?=
 =?utf-8?B?RTMvb29YRm9NY3VoN3FpQXBFczFDMForUjFGN0ZPbGVFN3JNOW12UzBJMU5Q?=
 =?utf-8?B?SnhRUlViMXNmZlk4ekdrd0NRUnIvaTd2L05KSzdSV1VXeVRMZERFTFdqQkxF?=
 =?utf-8?B?UkpHeU82ZWRQTk1renFxNkk0SHdEeDVtOTBRVHUvRWhNcG43VW1NMDY2WXZV?=
 =?utf-8?B?OHZrcFp3a1dXbmpTaGxGQ2d6aEsyYSt1MzUxNGlCdTVEMk5nOU1VcFk0T3NW?=
 =?utf-8?B?NlFtWkV2WUg0dDArb2JqbFdnL1o2dGZZV1RGeWhmLzhMa0VvZVE5VnRTMGhk?=
 =?utf-8?B?cnExSFhtMCtQWnBGVkRoUFpyd1Vpb2FWSFh1bVJhZDVsSHExcnVCMy84Y2p1?=
 =?utf-8?B?WVVVUytkcnRpVm1LZnNSTVdMZ3ZubWlyT0hRaEJEZ2tJbmdybDZiYi9LZTZK?=
 =?utf-8?B?MHhvSitqcHNlU1plV0wxdFk1TElVbWNNZzNSSVVPcWxieERjeHd5TVVEblVS?=
 =?utf-8?B?NjNqbG80dm1UZzBVQUVTUlBuV1lEcjg2RG5McGN5QVNTNmV4bEZvNncxUzVz?=
 =?utf-8?B?Smt3dEhLQ0J6NlBUSThWOHRjdDc1ekhUcm51TnQ2dCttMW5mSE02cnZJZ3pZ?=
 =?utf-8?B?V2RQRjVDcnZuYUpXQUhOb0V4U0kxTjZHRjQ4MnRjOGlOY3d3dkNwQ29JZ1Rn?=
 =?utf-8?B?SEl0WHNpMmZ4QUF5bkMyMFFFb0kyNGJCckgycUV6ai83cHJXWG53RUFBNUVS?=
 =?utf-8?B?QW9KZEJYWWY5TWlTalR1clVudXZPVWtMZmtacUVPSUFaRnIrK0VVNWY2b2Jo?=
 =?utf-8?B?TmdNL0E5MzBsdEIrajFvNURGczFEbTJwMjd6dEZOUGlnY2E5bWZCRGdPSDQw?=
 =?utf-8?B?ZkhsZ0VBZlh2a2k1WHZFakZRNXhMNDVCR0dsOUlKYWhlOWxFOXpEdis4VHlK?=
 =?utf-8?B?UVBBR1JpNjZJNGE3d3hyYXg4RFNnaU82WUMrVzNvbDNvUFZQYUxQTlRzanpm?=
 =?utf-8?B?UDBRTmtVa3Zmakx1UDhmZ2EvZ3o2YU9MTkc4ejI0Qm9UNzMwMmtQdmhLR05E?=
 =?utf-8?B?QmFBcko2SW1JdXdEMFAxS0lvU09sbkFsbUluLzdQQUpjTWx2NUptUEVZUkh6?=
 =?utf-8?B?b1E0NnIveUxFZUxuVDI2aDIwekdOTVVQbk1zMnR5Z0xsc09Sc0JOcFl6REh5?=
 =?utf-8?B?ZGdTaW9yWXpHOXFFbUllVVBxK3JHZGRVS2x4THplemxlTTlIc2gwMVFON3ZS?=
 =?utf-8?B?N0RPbVBjQWhIR3gzT1RSdHphZWZaeUJYU3Vld2dJYmJJSUNZWWdZM2duZi9X?=
 =?utf-8?B?Q29zK3A5YnlyK3JNZ3NNblVHbVIwNDlyS2pCZnh4NVFYNUdpeElleG9aL0xL?=
 =?utf-8?B?OEx2cW02aFlDS2tGRTNRdjYzWkVzOVpoRXEvaHR4NmxDMXdGdEhLL0EzMFpF?=
 =?utf-8?B?K1pmQTE1UjJmZkdEVktZTmtsZXFXWEwzd05lOXNiK0luR1djRTNCYVQyczZ5?=
 =?utf-8?B?MmI2UG5jbER0SmoyUHFiZVppaS82Wm9iTHl6cStaWDdYSVpQVDJUVUYwMHdz?=
 =?utf-8?B?dHRJR2lGazY0amtzR3JsZVlOQnJ2ZHNtZnlzUFFnS3J5MXZzbkxHZVU1Q0Vx?=
 =?utf-8?B?UHk0UlJ3SVBHMTYvQ0pqZm9YWHIzRlBGRUthOWVkUVdFV3N0MWRWVTkveTQ0?=
 =?utf-8?Q?geY4jxUtWORySendOiErah4HFyoLoCO+5p21ZqnZX8Z1q?=
X-MS-Exchange-AntiSpam-MessageData-1: GuIorKWe+R5kozVtVbFpP4hQYsuOT3hDCPA=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9c9313-6451-4c29-5b96-08deb67ccd3a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB8179.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 14:33:47.3128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VoGhFn9BEum5EoiLU5oj+ezy7qi2ERoLZUzCFpgA/XfxmLiMFkp18we7y6kdeuWcxv//UT8vVOUFl9M8jiCNGLXLxr0omb8yJq9inl82gms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR01MB994493

Hi,

I'm checking in to see if there are any comments on v2 of my patch set.
Since it been a while since I sent the patches, below is a reminder of
where things stand after the maintainer comments and my responses on v1.

v2 is no longer using the SMC CC SOC_ID Name as a proxy/override for
entries in the CPU parts table(s).  While it would be nice to not have
to update the CPU parts tables when new SMC CC compliant SoCs are
created, it would only have worked if all CPUs of a given SoC are of
the same type.

v2 will display the optional SMC CC SOC_ID name in a manner similar to
how the "BIOS Model name" is displayed.  the "SMCCC SOC_ID name" and
"BIOS Model name" strings will not necessarily be similar as the SoC
and system/firmware may be produced by different companies/
organizations.

v2 corrects the names of the 2 existing entries in the Ampere Computing
cpu part table.

Regards,
Paul


On 2/11/2026 4:23 PM, Paul Benoit wrote:
> On ARM SMC CC 1.6 compliant systems, output the optional SMC CC SOC_ID
> name if available.
> 
> Vendor ID:                   Ampere
>    BIOS Vendor ID:            Ampere (R)
>    Model name:                Ampere-1a
>      SMCCC SOC_ID name:       AmpereOne (R) A192-32X
>      BIOS Model name:         AmpereOne (R) A192-32X CPU @ 3.2GH
> 
> Signed-off-by: Paul Benoit <paul@os.amperecomputing.com>
> ---
>   sys-utils/lscpu-arm.c | 38 ++++++++++++++++++++++++++++++++++++++
>   sys-utils/lscpu.c     |  2 ++
>   sys-utils/lscpu.h     |  4 ++++
>   3 files changed, 44 insertions(+)
> 
> diff --git a/sys-utils/lscpu-arm.c b/sys-utils/lscpu-arm.c
> index ed255a3c7..f388080ad 100644
> --- a/sys-utils/lscpu-arm.c
> +++ b/sys-utils/lscpu-arm.c
> @@ -11,6 +11,7 @@
>    * The information here is gathered from
>    *  - ARM manuals
>    *  - Linux kernel: arch/armX/include/asm/cputype.h
> + *  - Linux kernel: Documentation/ABI/testing/sysfs-devices-soc
>    *  - GCC sources: config/arch/arch-cores.def
>    *  - Ancient wisdom
>    *  - SMBIOS tables (if applicable)
> @@ -460,6 +461,41 @@ static int arm_rXpY_decode(struct lscpu_cputype *ct)
>   	return 0;
>   }
>   
> +static void on_smc_platform_get_socidname(struct lscpu_cputype *ct)
> +{
> +	char *machinename = NULL;
> +	char *soc_id_jep106_id_str = NULL;
> +
> +	/* On systems that support SMC CC (Secure Monitor Call Calling
> +	 * Convention, get the SOC_ID name.  The Linux kernel obtains it from
> +	 * Trusted Firmware via an SMC CC call, and sets
> +	 * /sys/bus/soc/devices/soc0/machine _PATH_SOC_ID to this value.  lscpu
> +	 * will obtain the value from there.
> +	 *
> +	 * Documentation/ABI/testing/sysfs-devices-soc, in the Linux kernel
> +	 * source tree, gives insight into detecting a SMC CC compliant system
> +	 * by checking that start of the _PATH_SOC_ID value for "jep106:".
> +	 */
> +	ul_path_read_string(NULL, &soc_id_jep106_id_str, _PATH_SOC_ID);
> +
> +	if (soc_id_jep106_id_str) {
> +		if (strncmp(soc_id_jep106_id_str, "jep106:", 7) == 0) {
> +			ul_path_read_string(NULL, &machinename,
> +					    _PATH_SOC_MACHINENAME);
> +			if (machinename) {
> +				if (strnlen(machinename, sizeof(machinename))) {
> +					free(ct->socid_name);
> +					ct->socid_name = xstrdup(machinename);
> +				}
> +
> +				free(machinename);
> +			}
> +		}
> +
> +		free(soc_id_jep106_id_str);
> +	}
> +}
> +
>   static void arm_decode(struct lscpu_cxt *cxt, struct lscpu_cputype *ct)
>   {
>   	if (is_live(cxt) && access(_PATH_SYS_DMI, R_OK) == 0)
> @@ -468,6 +504,8 @@ static void arm_decode(struct lscpu_cxt *cxt, struct lscpu_cputype *ct)
>   	arm_ids_decode(ct);
>   	arm_rXpY_decode(ct);
>   
> +	on_smc_platform_get_socidname(ct);
> +
>   	if (is_live(cxt) && cxt->is_cluster)
>   		ct->nr_socket_on_cluster = get_number_of_physical_sockets_from_dmi();
>   }
> diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
> index 4556aa6df..cd2d00312 100644
> --- a/sys-utils/lscpu.c
> +++ b/sys-utils/lscpu.c
> @@ -895,6 +895,8 @@ print_summary_cputype(struct lscpu_cxt *cxt,
>   		     struct libscols_line *sec)
>   {
>   	sec = add_summary_s(tb, sec, _("Model name:"), ct->modelname ? ct->modelname : "-");
> +	if (ct->socid_name)
> +		add_summary_s(tb, sec, _("SMCCC SOC_ID name:"), ct->socid_name);
>   	if (ct->bios_modelname)
>   		add_summary_s(tb, sec, _("BIOS Model name:"), ct->bios_modelname);
>   	if (ct->bios_family)
> diff --git a/sys-utils/lscpu.h b/sys-utils/lscpu.h
> index 0fae5d29e..b8011bc55 100644
> --- a/sys-utils/lscpu.h
> +++ b/sys-utils/lscpu.h
> @@ -46,6 +46,8 @@ UL_DEBUG_DECLARE_MASK(lscpu);
>   #define _PATH_SYS_NODE		_PATH_SYS_SYSTEM "/node"
>   #define _PATH_SYS_DMI		"/sys/firmware/dmi/tables/DMI"
>   #define _PATH_ACPI_PPTT		"/sys/firmware/acpi/tables/PPTT"
> +#define _PATH_SOC_ID		"/sys/devices/soc0/soc_id"
> +#define _PATH_SOC_MACHINENAME	"/sys/devices/soc0/machine"
>   
>   struct lscpu_cache {
>   	int		id;		/* unique identifier */
> @@ -119,6 +121,8 @@ struct lscpu_cputype {
>   	size_t nr_socket_on_cluster; /* the number of sockets if the is_cluster is 1 */
>   
>   	char	*isa;	/* loongarch */
> +
> +	char	*socid_name;	/* aarch64 */
>   };
>   
>   /* dispatching modes */

