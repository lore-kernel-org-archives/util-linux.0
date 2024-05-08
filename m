Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2079.outbound.protection.outlook.com [40.92.89.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D126D1B0
	for <util-linux@vger.kernel.org>; Wed,  8 May 2024 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715184450; cv=fail; b=tFvLswVolGwJ64iOjizqtW9DySyQj1CMZpIrVvAGkyaHJGUl3/LoKABQkpFhLCTPYshIsmVxlyHcn+gKvjX29BKPL88GTuBcXjVAzdT9vIP22U/NFbv0UmFA+GAMB9rJcDc11UQQKRbM1X9OP1lG/ipAJJACINyH2bn/PIHK3cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715184450; c=relaxed/simple;
	bh=MWR+yyz6IFJK5SERQADGNrXmCzgEFFkSb9DLEFEBvng=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=DCTCcLOZoNW2LOl5z+5F7euS+XoA943nOOUfD8hNOWfc/x/FgKnq5QRdCxttEaHicIWoFDpV3S0KpFP/FRC6th4DZPcjKI+t+jKac3BDPMfVw10B3UOUZ2LR4pRGfv6hqG6wjF6tLUtuBQzmO72adKW1u2L6MqXttFI1d3/9KEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Dw/SwE8b; arc=fail smtp.client-ip=40.92.89.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Dw/SwE8b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kg41fdcA5VK+Kc9gn/OUlKB0zM3Mg47IqIu5napo7mxL8SYqQ7Ef0cj/yMMjHimvFFqivPK7KyD/1jN+nLwpe1YBGQ7EM+ibYzl21+RpTimoPKOJYz8/fuiVYkfHeeh4mv0yARe49lavuYC0KKVVQZcFnBAR0/qG4M6PK2UxqgjQrpCcvX5bDgje8/bwAYXvizH5qo4sgy8HGCHeHM04owuE/ALWCfp/e7DmpDaHmn+LWtBxzD9nDm5CokeL4GWz5qG4feFvoGiI82dhYdU3Idx6IQaQoF+TRhCpNycnRcmH/3QCL9SLAA/iphUy0zrIARUXhufG1oijwHRTQ/zLdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9v87fm5/P27KQazkt6RTkrPTfZ244Dr3Di2HJXcPYw=;
 b=Eh7s3gpNSnYUVYZHKaMjKfGFZAY4OTN+OAPuidi7Jxx/N99C/ihhNU4I/7OKgE6aRfYxEiquoE4EtWjlCIw/B/jRMnVJKsrWmjV+kmlItOns8pbg8ffmkxHc7kKQ5Fyl5rSTcQ3EgUcizZvoQlXKb8ovYq6VihXAuk2L0n21RXSA31yAnNoal0lFrUFaPH256b7199c6bZuS6jKoP23QX4YmruLB5YNkN7TKtwRLOi20owymylvVqslzUny7ELFsEBecmjnqiSeE13picxnEHlP8JlsvQWp86LV9eg2rObl7xrq4T77bTNNkDuZRHZkQBprUmbikkK7K7IzcxNby6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9v87fm5/P27KQazkt6RTkrPTfZ244Dr3Di2HJXcPYw=;
 b=Dw/SwE8bfoxycLNMYixFdBqeY7aGy3CWQV5crOx+q9FTgvIKYE0sL69bCH1Aig8cLOhA68qeRGz6bYAWdWtZT4l72OTi4MPa4VCKYnHzfKxMviSz/5hdl4E+Rx2JFGngFB4w3BB2JSZRGZf0TZg0tmJZw/ArBpx813jtH3ZFroQJh1yykyhuIvgha4cOiYbdsV+WUjSuFXtp2uxBUQFR9xjdpHQ98OrA/m4iXPZWJInJl0vukFwDcM3tER+bDjKAYQV2zIOA6SC8DL7kLlxIGPbGcsure9gUpR3dkDTh3jlgFX+P3+lkKwABWiq4VCTRWJ4TZew1ls3YT5Kf/sHJkA==
Received: from DBBP194MB1113.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:1ea::17)
 by PA1P194MB2261.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:452::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 16:07:26 +0000
Received: from DBBP194MB1113.EURP194.PROD.OUTLOOK.COM
 ([fe80::28cc:cec9:e7:23d4]) by DBBP194MB1113.EURP194.PROD.OUTLOOK.COM
 ([fe80::28cc:cec9:e7:23d4%7]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 16:07:26 +0000
Message-ID:
 <DBBP194MB111315092E137148D78773F3B0E52@DBBP194MB1113.EURP194.PROD.OUTLOOK.COM>
Date: Wed, 8 May 2024 19:07:23 +0300
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: util-linux@vger.kernel.org, gmazyland@gmail.com
From: Vitalii Hordii <vitalnodo@outlook.com>
Subject: luks2: need to check the availability of a JSON area
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [GnFm5m8zWOTKKhUe5QQhY40NuGrc5hgk]
X-ClientProxiedBy: WA2P291CA0038.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::8) To DBBP194MB1113.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:1ea::17)
X-Microsoft-Original-Message-ID:
 <d9cc2f91-64c1-47dc-ac12-0cbfa76c2242@outlook.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP194MB1113:EE_|PA1P194MB2261:EE_
X-MS-Office365-Filtering-Correlation-Id: a16b43dd-9cee-489d-1faf-08dc6f78f3f8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|440099019|3412199016|3430499023;
X-Microsoft-Antispam-Message-Info:
	SWtQ4FsEFapevBtZaGeOadjHtHVQ08o1yHv2GfpMKSIhbp4ioBCFimTKFieoP71HLa6ZBaUIMNiXCkVS0IpCbF5yBY7CVW7yFNkdzzVvZFeq2BZiAlwzRgnu2j8OfPH/4OprR/JvRGn9YiLwsXgGc0W0bqQgcF3M9B+wloyhE8eky6V7XXGur7umCKBgwIGV/dVWabJ9NLp0LvWZTGJA/U/ymUamee9UpTIhg6rnh202GvNoTUYOWrWKhRZTUDMNcCtyUD+NOcChP4vhdVpgZn9te9z5agRseuAqSqVsOFssJypuyCxITNzcFK8R3nvY9y8djaO/ORg9jyXs0uOlayvmM4u0dibmOT/GJHz434AsWdKM4LFeHTdbtSDV3mUD3IMtW4h+z8aZ+5ueeyKDTgdajxkJv2h4ln0/x0RyGIY6lNIiGf8mmtbDUDvpUI3UoiHnNP5no2tj+PiF/N5iuG9RzgkXd5w5fxjFgVP62fnFSnk7y7Ix4ufsiM2XuXzuJnwhtL+nrrl+b4w/F/JlWmxi872zZQQS3mCyRO6sOcKtpvQvnvlTutYzwP5dTIzYuZZdNMq5WQ1sR44sIC7Pr52xROW9BtxRsPZUTLKThB0WXZMGtvK6u47kh6vZdGNaO5IZfVu2oNtinSRScLECJUGKyCBY+yaanl7Y7JS/mr0=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0Q2SGVkckxJUDFSeTZMYUptRlN1bnA4RXlXcnZQWVZvOG93R0tad3FHSjc2?=
 =?utf-8?B?cERSdm9MOU5CcnY0REt6L2wxcmpUQ280TVhvd3doOVo2ZzN4SmI2Nmk4S1RZ?=
 =?utf-8?B?NTI1bUo0Y2lYbElPbU0zU0hXUERLeDFEWVVlTGUzTlEzeGFrNzB0SVdlK0NN?=
 =?utf-8?B?bnY4bEk0WUJ4UEJOMFUwdHVONWp1biszaDc4UGxGdU9OaU40OG9hczhlU2ZO?=
 =?utf-8?B?TmdFZ3NHcW0yV0N4MXBXMHd2cjVJNzNPWlZqVUhrd1FHOWRlZGpieXZmSW9w?=
 =?utf-8?B?STFHTC93Qldqa3ZDbXR2Y1BtUUFKNmt1ZERjM1VKcno5NG5udUNLMjVqeGVw?=
 =?utf-8?B?c3crdjB2dWM1NDJybWFBcXJRc015M2Vtcm4rTzFCLzk0dTI3V1NTZDZjUGQy?=
 =?utf-8?B?b2pwZ1o4VjJ0UWF4c3hLNXZwT3FGbWVhbWVyalRmNElsRTg0dURzejdoRjZM?=
 =?utf-8?B?WkpWNzlDTmVYT0RGYkI1d01kOVVBMEZibWhGdjdid0k4NkpVYm93N0dCZWNJ?=
 =?utf-8?B?S1NKYTBqTGxjbWhrRy9OanNnaEZDa3BSQ29IQWEvU1JVaGhlS2Fqc3A4Z0FN?=
 =?utf-8?B?OGlCTTRuQkZNbzFlQ3M0QkFZaHFVdUJ2TVphOGV4UXA0ZnNxMkZRUGxRRm5S?=
 =?utf-8?B?S2hvaFR0b1A1VGl0T3lwRkVodnpVWWtGdEN6ODdxVnY3NWpOREtKcjl5Slhl?=
 =?utf-8?B?b3ErdVRWWmRYTWliNlR0dG83QndjTklxM0NrUkxlakowcVFRQnlwUFRHZ3BO?=
 =?utf-8?B?Y0hMZU9PTTc3NGN3Wmlia0dFZS81QzVTbzdxc2FzbGRkTEFkYVVnUGY4ZFMr?=
 =?utf-8?B?Mk5YVnF6NlRlcnRWNVJtd1lxNk1HcEw2cXFWNkpFa2RHWnlBSFNFSFgzWGFQ?=
 =?utf-8?B?KzBDa0wzRmxaZjVXalFmTXdRVitpWDl3UHNoMm1CVFhKQ2xoWGlRODYxWmpQ?=
 =?utf-8?B?cDJIdTF1RWZzU21UaFByWGFYOEdSWmlaRWpuL3BsZFBKc3hpUEtLMnZnNU56?=
 =?utf-8?B?OGpHTVZrWm95b0Q4NElNNnNFQldnU0FDYW1FVk9aclF2SFVPZEYxTi9EbCtR?=
 =?utf-8?B?NFF6T0JEMjc1dDM2THdRdlpvdjhhS0djZFRzemxGL3N0NDFEVXJiVXpGVGVm?=
 =?utf-8?B?cXVRVVJxZnFZNEdPdXFldWxTNGE4YkpJc05BcXFPUWJhNzY2RUlleldVYWph?=
 =?utf-8?B?RXFtRlNJczZLTjR6akFkNlZNNmtTbHQvTHZuQlliUk5rU0tKVEd4aWFZY1FT?=
 =?utf-8?B?SWZFUWliU1NiMEVtWHk2RjBmZHk4RzhMcjBpL0w0SE9YR0xjaDBmc3FhbHBy?=
 =?utf-8?B?ZXduaXg3aHcxaHJWTjFOdTZuOUZwUjZRQ1BmRkd1bTBiaHludk5wNHN4K1d1?=
 =?utf-8?B?OGt6bkRTRlpab05pQUFTYXl1cVlzUDIxQVFJK05Wdy85T1Nza3ovVGpCa3Fm?=
 =?utf-8?B?VWk3SlJ2WkJPbEIxWlVaOEJlamZ3QUVVVFhhVXFjNGc1NEJlSldvN3dNY2ZZ?=
 =?utf-8?B?NTkxYll5eXcwVDZqU3ZIcFVHc253TGJxamV6RXl4VTZqSGhoQ2ZNaHc0VHhT?=
 =?utf-8?B?V1FyYmlKZEU1N3FBVm9vQ3VLMVdMQUwvMUt2QjFkNy8rU2RrZS9KaktXVWEw?=
 =?utf-8?Q?mG92vrWIPOPWuCz9elq6WgZniKDWmP7xG+mQ/dEeKEbM=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a16b43dd-9cee-489d-1faf-08dc6f78f3f8
X-MS-Exchange-CrossTenant-AuthSource: DBBP194MB1113.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 16:07:26.2087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P194MB2261

Hello,

I had some problems with restoring a luks2 partition after using, for 
example, mkfs.ntfs because it only leaves a 2nd JSON area without a 
secondary binary header, which I had to create myself. What if there was 
a function in libblkid that allows one to determine if there is a 2nd 
JSON and if there is a chance of recovery? Because as I see here, 
automatically repairing 
https://gitlab.com/cryptsetup/cryptsetup/-/issues/750 is apparently 
missing due to the lack of checking if there is an area here in 
libblkid. Also this seems to be a pretty popular problem on the internet 
when it comes to installing other operating systems. Would it be okay to 
add such a feature?

Best regards, Vitalii
