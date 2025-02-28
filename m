Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857DE1AA1C0
	for <util-linux@vger.kernel.org>; Fri, 28 Feb 2025 04:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740716766; cv=fail; b=TKkJwPIUOH6GkGTkjYBial7lJ2NL2ftyR4bh/7mEzWD4cxf5OH3wWmeV/V7vuMeOBZyyNXt6wQkYHg/LIoeINZl/X80z0n2oXndQNiHByDByt9CTfARWF57CNipXWkLIp7a/qcV8/IWYRlWEXONDHTAcbc4+mKTUVZcpc3eBLnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740716766; c=relaxed/simple;
	bh=5/JU4UllvIpXRshAvU+v91jSeZEy2IaWjbI9ZMex2P4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZcDWpSfAL8lbzINcxurDpdrdOnl+PldfwPGG0LALVx9cxf/IKco5RusRQrfXSMrY8rzHihttyBpIZIQn+EGDhpIfy+Q/RBT0a2d0m5SqtDGlULnwpV+/pwEWCU0/ZTF851DmjO7bUuT1OIFgAqgh8+gbQ1hn4uEqztT5p8tAYww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KWpXEnzo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YJOVd9gC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KWpXEnzo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YJOVd9gC"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51S1BiWR024129;
	Fri, 28 Feb 2025 04:25:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=5/JU4UllvIpXRshAvU+v91jSeZEy2IaWjbI9ZMex2P4=; b=
	KWpXEnzo3qyU78KuBHKJ/jiySWQbWSkRC8UuJvkXfdr7z3X3RMZHfexLCtLMZg6j
	2FrfYkiwdUeX/pdxJP1VYs4rbG94UzUCXCaJYb/zTXvEoicEJIBt5VHzu9suzbbm
	wPpnHVzXBlmyDZfwwytJho3rYHqE25eAMMawv2fG/r3vNQQ6lwei+qrqSHw4waTT
	bkra8cjDsc+Leuu6AM9UbGWbNHhnh//uyNo8eIXVhWAAwDxnNJlQWIW7nTpiPOv7
	CpFzZqZGFtMdqWKxo60PerpwSOs92zD4oRlsTGplpMa0bzS3uv91w/a3tPzfEiCf
	vP3H4+kC9XYspJIu3umd1A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psccv2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 04:25:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51S3VecG002774;
	Fri, 28 Feb 2025 04:25:44 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51db8q8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 04:25:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HxWDMTRhLRBV8uELBKPDMEWIjwxU9nZQZ1ytWK7fgFKmfAkhx2eCaDKjtw4XEfy8QT1QRi8I/qKbA63zH6SgW+NS0fStbpMvAfWZh3pMtMPa7yvyoL+FpYmOZ9GbDzcnGTTk6m0aq/VhdNW3WTdhTPLt0U1j771KNAV5cNwNOLVZMA18Dah9KXSBgOBGWkBdVey3YBYOD3EbPtplN2pE2aaKdXIwod5JMFVcA4dGxJobVKQqS51vo5XRpm0rSJ8xVpeYQxf39HH8VfWC0zrmwZ6bjsoHjywIaNuFAEywWMC4JgXaGBu2tyZy2fE6wwpgbQuRDLm5ls6wMvNZMDohsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/JU4UllvIpXRshAvU+v91jSeZEy2IaWjbI9ZMex2P4=;
 b=lCqY+B79HuBtuOnhdRxVKn6grD57PWND9/S8+himncSndyCIB3KBdEp5RHOO7/BwTw6AKjoGrQz+H3Cb8OYJyFrCWek/uc0gK008vQtDy998ZyFKgBo+dJW5Q5+lZcmXR714DlrIgCB1M1l/qdscyOu4KrTLLeCeEUFwBicabBjZierBFKBV83tKX/g6ognCH3bhxDvTbcXVQ9XvXOItHEu1gxi0bngVh3ofWC0bbflPVIhjVNwobuuaJoNMsZWmBBh+JH9jf+DC5C7TLYGRjBpCLW9AeJIAzYN37taWavrchHzNbMlzHFlXLaeUGajMf0FdL/63mQndue/96NvMLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/JU4UllvIpXRshAvU+v91jSeZEy2IaWjbI9ZMex2P4=;
 b=YJOVd9gCc8LLLTRazP/XEUuUOeEZS77VPPj2LqFz3T7LhCegh8/y0sNlhLB2AXjkW1iD18JmieA1WhSNCqc4oU/Lelwj+6ymkPZ1O00sq/7y12l23Mw7Q1Mka2OeWniMhDXNnSE5jX9EKrJHAAw2trt4rhfVRI30wy7bKiRD69I=
Received: from DS7PR10MB4944.namprd10.prod.outlook.com (2603:10b6:5:38d::15)
 by DM4PR10MB5917.namprd10.prod.outlook.com (2603:10b6:8:b1::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.23; Fri, 28 Feb 2025 04:25:41 +0000
Received: from DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5]) by DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5%3]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 04:25:41 +0000
Message-ID: <9ea2e82c-c352-4af0-b51c-3e20e81f2a93@oracle.com>
Date: Thu, 27 Feb 2025 20:25:38 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] lsirq,irqtop: add support for reading data from given
 file
To: zhenwei pi <pizhenwei@bytedance.com>, Karel Zak <kzak@redhat.com>,
        Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
References: <20250227044916.89925-1-joe.jin@oracle.com>
 <20250227044916.89925-4-joe.jin@oracle.com>
 <da045963-e7d3-4edf-b3b9-783483a8920d@bytedance.com>
Content-Language: en-US
From: Joe Jin <joe.jin@oracle.com>
In-Reply-To: <da045963-e7d3-4edf-b3b9-783483a8920d@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::16) To DS7PR10MB4944.namprd10.prod.outlook.com
 (2603:10b6:5:38d::15)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4944:EE_|DM4PR10MB5917:EE_
X-MS-Office365-Filtering-Correlation-Id: 758aaea4-5c2f-4ece-8487-08dd57aff5a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUdjSHhqdi9rK29KRlNHMk9nMHlKRXArd2N2NE00Tkh1SzdVMjlxVGc2bkdJ?=
 =?utf-8?B?bG5DSUpRT29Ja1BkYit4WkV3d2tQYXNuaElRVzd5QXU2WUFoSVdyQTNtL2hI?=
 =?utf-8?B?ZCtlUU5Gb0tZRTd2RlNHbDRvMThaOE1BM2gzMS9OZ0NTUGtSaGhabkpaSDJm?=
 =?utf-8?B?ZzJXY3MraGx1SkRuakl0YUw3amZVQTNBUHUxOFRKN01YdjFOVE14bGlqclNZ?=
 =?utf-8?B?cTUrSTNMZGJYVFZTeXJmRmNKUXZzdklacldiZHNwSjBjS08vajJ0a3JyRzkv?=
 =?utf-8?B?UG9RQlh5NDNsblJUTUsrK3ljbkhFYkVGL21RdVJLb2tjcGdySUg2V2ZWUEwy?=
 =?utf-8?B?cUxFaldLY3ZmVW1hdVA2d21GQW9MTFREZEpqbkpocy9ndmFWdForUUpTOTFk?=
 =?utf-8?B?ZW41M1JzbEQxTkRWc1F0TEJBNFVPajFPQmlhSlMrRVcxcXlCYWVQRVZ6eWlV?=
 =?utf-8?B?L3RITTdza0sybzhYc2ozMXVjNkdDR0dEM2Q2bXc5QXhDaW40SklYUVpxZWs1?=
 =?utf-8?B?T2M2S2IvVm1VOG41VDFrYkVWaFprZG1HVk0vR2dzQzRka1orYnVIaWRmZjJ5?=
 =?utf-8?B?QlRDTTBaRTBVNGJCSWhqa0owWFQrQk1nZXh0akMzZzZ5cFVZdlZvWmo4QUxR?=
 =?utf-8?B?K2s2TGhMR1JaWGlGRUNlUjNYeGJYU0xBRGgwaXZpMVVtR3BhZmY1SUIvV3pz?=
 =?utf-8?B?N1VzUEQ2SEF0NWhIdTM2c0dhTWJrRVpJZENza2ZMQWxjcjVtS3VOTTE2UnJ4?=
 =?utf-8?B?MlBWUUJIRjVmbElmQ3BDOUtRdGQ2dXNMbnJLTmZ6SnVHTFZEZXJhQmxyVUFa?=
 =?utf-8?B?Ym5zbEFUUzRHSUVjQ1kyTnMyQnhrdkx4RHM1Zk1pb21uTVhrakMvV0x1R0VK?=
 =?utf-8?B?OGszVWRNSlRjczQrZGYwL1pkVGVFeWYzUGdkREtFM2FXaWQwNm5neFNsbHh4?=
 =?utf-8?B?MGYyUXdRcjdLSkErcUZjd1YrNWdNS25ZVXc3UDhuQVoybGxtNVp5MVhOUFNm?=
 =?utf-8?B?RjZJenVvNTNMd1F5VmpDMUlxY0pGY2tQZ1ZnZDhOemRUK0lYNURXQnhMb2xZ?=
 =?utf-8?B?R1RHbzMvanY1YTNscSthbmZmOWIvc3lPTTRiWm84R041WFUxYXRGS2kwcUY1?=
 =?utf-8?B?eWJ4R3RUYUx6d3JENi9SN2JaYk85V0dYTlRmN2wzUEhVVXJuZ0ZXdkRZbFA3?=
 =?utf-8?B?dFpOeGV6akFzdlFhWXdTdTJ0TTY0S1JtZUhoaUtDSHRyck42S0ZHOGwvbXUz?=
 =?utf-8?B?KzJQVitCdEtqOElWN0FHSGxQYXJpelFRQ2xHWHJ6K0JFT3hQLzBMR0w4NklQ?=
 =?utf-8?B?d0JMQjVYUlNvbU1CeVk3ZjZUSzQrZXViSHQ1V1ZyOGtmd2ZVM25tMm9iMkVY?=
 =?utf-8?B?TUNCZWpIbjR5aE5hcHl0SzhKUWFUMG9od2hhRmlsM0Q4eDRuUzF2SHNqbGlz?=
 =?utf-8?B?R3ViSjEwbnhTbWY2ekxJWDBnbVpkR2tKaW5oTFFZdzRtTlJuUFpHYVI0a056?=
 =?utf-8?B?RzUvMU9rU3N5L25ORTBncGRnOEIrcHg4Y2hEdjRwS0hKSFlZOGtxWndiVXFO?=
 =?utf-8?B?MFVxbXNERTdLd1JkVTgzNnpFZHZ5MWovN2RWMlBjakwxNWlTb1FqRWUxVFBQ?=
 =?utf-8?B?d3FqcUpRaEFnTjl0ei9Lc2I5TnhnbDY1T2djYkRZaURvU3VtQmo2d2h4Q2V2?=
 =?utf-8?B?ZVltQkdRcWdHTkVWTitGeDNDV2UyN3B4N0EwUXE2M052QU1SNEhtaVVtT0JP?=
 =?utf-8?B?eStpTXgyOHBYcFk3MXpWK05GdWV0Z1htNHNoQzN1VzlMeUF0VTlFNE45cGYr?=
 =?utf-8?B?ZDU3UkVtT2hWWFRxeUFsVFdHMG1ISEEzbVZsY2prSFYvZG5vNjZxY2ZwYzVs?=
 =?utf-8?Q?ACLokEo2LcQC1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4944.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azVxMWRCc3FYR3JGVHh3ZitGNjlFQnA3UFZVMTBkUVUxN0ZIaHlpNjVHMEFz?=
 =?utf-8?B?Y2ZlVmpBTHNEU1ZQeWw3YjN2QWFIWG5GY1N4bVg0ZmRzYWNNSEdYVW10dWw5?=
 =?utf-8?B?VzVCdmR1WVU3Wmt3U2MvcTVXd3RYTW1rQ0YxcUM0MVFFWFJKTWtlQ3pjZE1s?=
 =?utf-8?B?eDN1V0w3UmR6amhwaC9mOXlHaTNRZWJwRm9sdE04L3pjTGc2L2kwT2d5aUFp?=
 =?utf-8?B?RlFmZkExVFlzWXBaUlBDWkY1QlJHaHppbXdmYk1MYlVPSHJBMWt2MXh6N2NF?=
 =?utf-8?B?YjFhcmFMNFJyOU1rKzRHRlNKMGl2cnFQck1uZ3hZdk9ZeVpXbCtlYWt0cTFK?=
 =?utf-8?B?Qk5yenBOdWIvbGdFWGpISE5kY05GQnozeUwwb2lFK0xOMytMUEdoQUVCdUNv?=
 =?utf-8?B?bDBTdXJrSDNmNzVNY0l6THVHVENBMGRpaG1mWDJGY2F2TTNmbDNiWUUybzdi?=
 =?utf-8?B?OXhkNHNWblhzZ1ZCOEl6Sk1NTjVKY3NXaXpqMXkzVzFPL1p4YWhxaEhzM2R3?=
 =?utf-8?B?T2NLaTZzcDBrbks5eFRYSFl1dXhob011M2d5ZVQrZUdtT2RMS0RnSmhhVC81?=
 =?utf-8?B?V09vT0VmNHBMcTRiZ0syMFFFMnNwWCtLdVNQSk1TNHdXSXlQUDFXTHl4bHVY?=
 =?utf-8?B?bzg1cW93VXNnYlh1N2JMZS92Nm1kUmtSMGU1c05QQmc4ckZJM0J3WGVoZXYy?=
 =?utf-8?B?QWRIOGpYY0JNSUp3bEZvWUpHb2Ziei9mdmNvODgrWFF3MXdUZmxKbjRGTnNo?=
 =?utf-8?B?TS8zRjZzMThtUGNRZ044eGQxWU1RcG9tT2g5OUVuN0twYVFSYTNzc3pmaVo4?=
 =?utf-8?B?SEFpWkFKVEN6ZVZrQUNaMnBNcWRoOWovZUVGa29SM201RTF2clNyKzBMRjI2?=
 =?utf-8?B?SStKNkRzUExGLzZNT3BsU2RqajhMYSs1cWtUR3d1RnR3NGRkWElQVmVmc0Mv?=
 =?utf-8?B?ZEJ2aFBPUmpiTnhkcUpXa2FwQmxhWCtFbnYyZmdVcnl4aVd4OVJaZWp2RldK?=
 =?utf-8?B?TnQ5NDZlR1FvcHQzRFdYVVZjWk1Ka1RzUlMrN1JmNlQrT1RMWjhLTXZSenl5?=
 =?utf-8?B?QXppeTRzclFVOCtyZHNwanMreDB0bkZ5U2JpMHlnTVZlSURXNnZvNlBYV0p2?=
 =?utf-8?B?NjN1b2JVYVQxYVhsN1RZTlZ4NEZIclJ0Nk1ncGNIYTdpNXdpUk1rcC9CNVpl?=
 =?utf-8?B?SElPYVhnRmF6MW5KQitPaFN0WlJmVlMyL0F0MWFqOTFZTFh3d082RmVCTnNq?=
 =?utf-8?B?L2oyMS9Fa0htd3JsRjZvN01OSDFZN29VY2o1ZDcvZXlSbmFnV3U3VS9SWHNt?=
 =?utf-8?B?c1RweTJKdFJjdlhxU1lWUEZqeEJob1VidDBXMWFsbFIxMkpESDM2aGk2ZUND?=
 =?utf-8?B?ZDFVSFJGMHVXaGRlKzY3UXFveGJjeUpEMFRzeWFvSDducmJKNXdaTGgvNjh5?=
 =?utf-8?B?THprN3YvaUsvSndhcGRnV3laK3ZQODR5Z04xVTJVRkNsS0R4M1BpZ1ZDVTJT?=
 =?utf-8?B?N2hhTFh5bWphVDVoNnFvdmI2cnYydEk3UDRaWXRjaGE2MEE4OEZFL0RxTUJq?=
 =?utf-8?B?SUt6T29hR2t5YUgySjYrUGVmcVdsR2RvTzl0RHFRQ2MyS2lZRWFrRE1TOEtw?=
 =?utf-8?B?QWJWTTlBQWxPSEpVdTFvNHRBTzNiQTRUUFRTYmhXSGhxY1c3aXpMa1B1a3JI?=
 =?utf-8?B?bE5Sc1hOdTFvejVzRWFhME81dHdHSmNqMkk1YlNNeVlpM2tmYkR2UTU5QUJT?=
 =?utf-8?B?SVErWEU5UXpYWlAzRE95d0VscEE1S1VhVUlqWFF1VFdZcG1GTXFING5WcEdG?=
 =?utf-8?B?bkU5S1ErSWFPYkd6SkRCSFhPVG1TZ0hzUGZHU3BCdThJdDMvTm94eDJlYUdz?=
 =?utf-8?B?SVpnd09Bd2ppWWRCclRBTnVsUi9KeWh4dTgzYyt4SXhvaEVTbkZiYWV3TkxI?=
 =?utf-8?B?a0ZQUitBVzBDaEY1eVd6aWdoZjdjSXhrRjRVdElvVmpSbHl5ZDI5N3k3WWhL?=
 =?utf-8?B?Q0k5QTFNV0o2Yk9iMmg4MU8xRUFZR09rVWR5OTk2NWlyaWpjZXJrYmNhejM5?=
 =?utf-8?B?K0x2SDNVTUFmbk1tbjdBbVA1TzJrM00zZm9LNXpRaXhYcGRYRGY3THh6WnZ2?=
 =?utf-8?Q?fE9s8BJZTHIlGYLqtVyTqLpL3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fG4k5iL6IfBhBLJtLFrXgV5YRswTokLFOS1tz6lML/JvKgG0OSyf9jfNlL18XUP4pC0AgRq9KeAPX4b26TTmsAGMfgBHxQHO2aEDyjnP5ETAu2bIgd2TohoesKJXV9gYWUxuuDWcKifbHlQdneY+Owap6Y2adxbrNHb038ZH76hEpjsX+IKvrIY9mXo4TPRcJCdnj3EIfkBMIJo4IMJoPoaZkcJ7wI+OMgkcjhXmwqP0CV2b87FtfFtsQLI8vP70f2M4+S4/q2r/gR9Owckhi7C7jFznaFBjJgTzqQWDBXkW5keKOJfcnKbvnnvKktYcA200p75Z6t22CXGIixp19x8HWb178sPAqQKHMD7warue457AxEBJExsZUY4gsxW9B/0nllP2S+PfTIUGEhqTtgcj9v/S2qb/S5H2rvKVj29uC4f166iXMn1+s/hDD2XmsXOk1Kr7OLe0eN0q4o8BKsGgYut0VK+X1DGtlGEFSL5HNf33vRFRhP6k+6PpzTmSEK61QmC/v0TJzSLXRssO+yz2fvLJgayv9JJi4+4WVNd7x2JdPp7aG+OQoYjVr9exg/VA0dN487s9dhkF+wRu/Hq+QFsNdoEa4SRyI+OfUHk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 758aaea4-5c2f-4ece-8487-08dd57aff5a7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4944.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 04:25:41.0232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PKTiSuKh5gjXxmYK8aGFV/dHHWQ40venL6tLKlaDEoaJdWIVITTDj99+kuQ5AY2Ue/bLUACvz3VtgbL+3bT6Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5917
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_08,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502280029
X-Proofpoint-GUID: S934HDPZFbJxtiNHMsBfM0dyYeo32jdA
X-Proofpoint-ORIG-GUID: S934HDPZFbJxtiNHMsBfM0dyYeo32jdA

On 2/27/25 17:41, zhenwei pi wrote:
> Does the '--input IRQFILE' change?
>
> irqtop reads 'IRQFILE' and uses the current one to calculate the increment from the previous one, I'm curious about this case ...
>
> But I guess lsirq would work fine.
Make sense, I'll remove this option from irqtop.

Thanks,
Joe

>
> On 2/27/25 12:49, Joe Jin wrote:
>> This is helpful for analyzng data saved from other system.
>>
>> Signed-off-by: Joe Jin <joe.jin@oracle.com>
>> Cc: Zhenwei Pi <pizhenwei@bytedance.com>
>> Cc: Sami Kerola <kerolasa@iki.fi>
>> ---
>>   bash-completion/irqtop  |  4 ++++
>>   bash-completion/lsirq   |  4 ++++
>>   sys-utils/irq-common.c  | 19 +++++++++----------
>>   sys-utils/irq-common.h  |  3 ++-
>>   sys-utils/irqtop.1.adoc |  3 +++
>>   sys-utils/irqtop.c      | 28 +++++++++++++++++++++++++---
>>   sys-utils/lsirq.1.adoc  |  3 +++
>>   sys-utils/lsirq.c       | 28 ++++++++++++++++++++++++----
>>   8 files changed, 74 insertions(+), 18 deletions(-)
>>
>> diff --git a/bash-completion/irqtop b/bash-completion/irqtop
>> index 47b7b0af6..3bea5fc0e 100644
>> --- a/bash-completion/irqtop
>> +++ b/bash-completion/irqtop
>> @@ -15,6 +15,9 @@ _irqtop_module()
>>           '-C'|'--cpu-list')
>>               return 0
>>               ;;
>> +        '-i'|'--input')
>> +            COMPREPLY=( $(compgen -W "input file" -- $cur) )
>> +            ;;
>>           '-t'|'--threshold')
>>               return 0
>>               ;;
>> @@ -51,6 +54,7 @@ _irqtop_module()
>>           --cpu-stat
>>           --cpu-list
>>           --delay
>> +        --input
>>           --number
>>           --sort
>>           --output
>> diff --git a/bash-completion/lsirq b/bash-completion/lsirq
>> index 4c3c9f04f..b913eecd0 100644
>> --- a/bash-completion/lsirq
>> +++ b/bash-completion/lsirq
>> @@ -5,6 +5,9 @@ _lsirq_module()
>>       cur="${COMP_WORDS[COMP_CWORD]}"
>>       prev="${COMP_WORDS[COMP_CWORD-1]}"
>>       case $prev in
>> +        '-i'|'--input')
>> +            COMPREPLY=( $(compgen -W "input file" -- $cur) )
>> +            ;;
>>           '-o'|'--output')
>>               local prefix realcur OUTPUT
>>               realcur="${cur##*,}"
>> @@ -35,6 +38,7 @@ _lsirq_module()
>>       OPTS="    --json
>>           --pairs
>>           --noheadings
>> +        --input
>>           --output
>>           --softirq
>>           --sort
>> diff --git a/sys-utils/irq-common.c b/sys-utils/irq-common.c
>> index f069d8a63..560dd4b82 100644
>> --- a/sys-utils/irq-common.c
>> +++ b/sys-utils/irq-common.c
>> @@ -233,7 +233,8 @@ static bool cpu_in_list(int cpu, size_t setsize, cpu_set_t *cpuset)
>>   /*
>>    * irqinfo - parse the system's interrupts
>>    */
>> -static struct irq_stat *get_irqinfo(int softirq, size_t setsize, cpu_set_t *cpuset)
>> +static struct irq_stat *get_irqinfo(const char *input_file, int softirq,
>> +                    size_t setsize, cpu_set_t *cpuset)
>>   {
>>       FILE *irqfile;
>>       char *line = NULL, *tmp;
>> @@ -247,18 +248,15 @@ static struct irq_stat *get_irqinfo(int softirq, size_t setsize, cpu_set_t *cpus
>>       stat->irq_info = xmalloc(sizeof(*stat->irq_info) * IRQ_INFO_LEN);
>>       stat->nr_irq_info = IRQ_INFO_LEN;
>>   -    if (softirq)
>> -        irqfile = fopen(_PATH_PROC_SOFTIRQS, "r");
>> -    else
>> -        irqfile = fopen(_PATH_PROC_INTERRUPTS, "r");
>> +    irqfile = fopen(input_file, "r");
>>       if (!irqfile) {
>> -        warn(_("cannot open %s"), _PATH_PROC_INTERRUPTS);
>> +        warn(_("cannot open %s"), input_file);
>>           goto free_stat;
>>       }
>>         /* read header firstly */
>>       if (getline(&line, &len, irqfile) < 0) {
>> -        warn(_("cannot read %s"), _PATH_PROC_INTERRUPTS);
>> +        warn(_("cannot read %s"), input_file);
>>           goto close_file;
>>       }
>>   @@ -270,7 +268,7 @@ static struct irq_stat *get_irqinfo(int softirq, size_t setsize, cpu_set_t *cpus
>>         stat->cpus =  xcalloc(stat->nr_active_cpu, sizeof(struct irq_cpu));
>>   -    /* parse each line of _PATH_PROC_INTERRUPTS */
>> +    /* parse each line of input file */
>>       while (getline(&line, &len, irqfile) >= 0) {
>>           unsigned long count;
>>           size_t index;
>> @@ -527,7 +525,8 @@ struct libscols_table *get_scols_cpus_table(struct irq_output *out,
>>       return NULL;
>>   }
>>   -struct libscols_table *get_scols_table(struct irq_output *out,
>> +struct libscols_table *get_scols_table(const char *input_file,
>> +                          struct irq_output *out,
>>                             struct irq_stat *prev,
>>                             struct irq_stat **xstat,
>>                             int softirq,
>> @@ -542,7 +541,7 @@ struct libscols_table *get_scols_table(struct irq_output *out,
>>       size_t i;
>>         /* the stats */
>> -    stat = get_irqinfo(softirq, setsize, cpuset);
>> +    stat = get_irqinfo(input_file, softirq, setsize, cpuset);
>>       if (!stat)
>>           return NULL;
>>   diff --git a/sys-utils/irq-common.h b/sys-utils/irq-common.h
>> index 02b72d752..b9cf72d2a 100644
>> --- a/sys-utils/irq-common.h
>> +++ b/sys-utils/irq-common.h
>> @@ -73,7 +73,8 @@ void irq_print_columns(FILE *f, int nodelta);
>>   void set_sort_func_by_name(struct irq_output *out, const char *name);
>>   void set_sort_func_by_key(struct irq_output *out, const char c);
>>   -struct libscols_table *get_scols_table(struct irq_output *out,
>> +struct libscols_table *get_scols_table(const char *input_file,
>> +                                              struct irq_output *out,
>>                                                 struct irq_stat *prev,
>>                                                 struct irq_stat **xstat,
>>                                                 int softirq,
>> diff --git a/sys-utils/irqtop.1.adoc b/sys-utils/irqtop.1.adoc
>> index 75cfe2e41..715008d07 100644
>> --- a/sys-utils/irqtop.1.adoc
>> +++ b/sys-utils/irqtop.1.adoc
>> @@ -37,6 +37,9 @@ Specify cpus in list format to show.
>>   *-d*, *--delay* _seconds_::
>>   Update interrupt output every _seconds_ intervals.
>>   +*-i*, *--input* _file_::
>> +Read data from _file_ (Which was created by other tools, e.g. sosreport).
>> +
>>   *-n*, *--number* _number_::
>>   Specifies the maximum _number_ of iterations before quitting.
>>   diff --git a/sys-utils/irqtop.c b/sys-utils/irqtop.c
>> index ba5680671..4cf1dc79a 100644
>> --- a/sys-utils/irqtop.c
>> +++ b/sys-utils/irqtop.c
>> @@ -87,6 +87,8 @@ struct irqtop_ctl {
>>       bool    batch;
>>       bool    request_exit,
>>           softirq;
>> +
>> +    char    *input;
>>   };
>>     #define irqtop_batch_mode(ctl) ((ctl)->batch == true)
>> @@ -122,8 +124,9 @@ static int update_screen(struct irqtop_ctl *ctl, struct irq_output *out)
>>       char timestr[64], *data, *data0, *p;
>>         /* make irqs table */
>> -    table = get_scols_table(out, ctl->prev_stat, &stat, ctl->softirq,
>> -                ctl->threshold, ctl->setsize, ctl->cpuset);
>> +    table = get_scols_table(ctl->input, out, ctl->prev_stat, &stat,
>> +                ctl->softirq, ctl->threshold, ctl->setsize,
>> +                ctl->cpuset);
>>       if (!table) {
>>           ctl->request_exit = 1;
>>           return 1;
>> @@ -292,6 +295,7 @@ static void __attribute__((__noreturn__)) usage(void)
>>       fputs(_(" -c, --cpu-stat <mode> show per-cpu stat (auto, enable, disable)\n"), stdout);
>>       fputs(_(" -C, --cpu-list <list> specify cpus in list format\n"), stdout);
>>       fputs(_(" -d, --delay <secs>   delay updates\n"), stdout);
>> +    fputs(_(" -i, --input <file>   read data from file\n"), stdout);
>>       fputs(_(" -n, --number <number> the maximum number of iterations\n"), stdout);
>>       fputs(_(" -o, --output <list>  define which output columns to use\n"), stdout);
>>       fputs(_(" -s, --sort <column>  specify sort column\n"), stdout);
>> @@ -325,6 +329,7 @@ static void parse_args(    struct irqtop_ctl *ctl,
>>           {"cpu-stat", required_argument, NULL, 'c'},
>>           {"cpu-list", required_argument, NULL, 'C'},
>>           {"delay", required_argument, NULL, 'd'},
>> +        {"input", required_argument, NULL, 'i'},
>>           {"number", required_argument, NULL, 'n'},
>>           {"sort", required_argument, NULL, 's'},
>>           {"output", required_argument, NULL, 'o'},
>> @@ -336,7 +341,7 @@ static void parse_args(    struct irqtop_ctl *ctl,
>>       };
>>       int o;
>>   -    while ((o = getopt_long(argc, argv, "bc:C:d:n:o:s:St:hV", longopts, NULL)) != -1) {
>> +    while ((o = getopt_long(argc, argv, "bc:C:d:i:n:o:s:St:hV", longopts, NULL)) != -1) {
>>           switch (o) {
>>           case 'b':
>>               ctl->batch = true;
>> @@ -376,6 +381,13 @@ static void parse_args(    struct irqtop_ctl *ctl,
>>                   ctl->timer.it_value = ctl->timer.it_interval;
>>               }
>>               break;
>> +        case 'i':
>> +            ctl->input = strdup(optarg);
>> +            if (!ctl->input)
>> +                err_oom();
>> +            ctl->number = 1;
>> +            ctl->batch = true;
>> +            break;
>>           case 'n':
>>               ctl->number = str2num_or_err(optarg, 10,
>>                       _("failed to parse number argument"),
>> @@ -402,6 +414,15 @@ static void parse_args(    struct irqtop_ctl *ctl,
>>           }
>>       }
>>   +    if (ctl->input == NULL) {
>> +        if (ctl->softirq == 1)
>> +            ctl->input = strdup(_PATH_PROC_SOFTIRQS);
>> +        else
>> +            ctl->input = strdup(_PATH_PROC_INTERRUPTS);
>> +        if (!ctl->input)
>> +            err_oom();
>> +    }
>> +
>>       /* default */
>>       if (!out->ncolumns) {
>>           out->columns[out->ncolumns++] = COL_IRQ;
>> @@ -453,6 +474,7 @@ int main(int argc, char **argv)
>>         free_irqstat(ctl.prev_stat);
>>       free(ctl.hostname);
>> +    free(ctl.input);
>>       cpuset_free(ctl.cpuset);
>>         if (ctl.batch == false) {
>> diff --git a/sys-utils/lsirq.1.adoc b/sys-utils/lsirq.1.adoc
>> index 02aea16b3..dd265710c 100644
>> --- a/sys-utils/lsirq.1.adoc
>> +++ b/sys-utils/lsirq.1.adoc
>> @@ -25,6 +25,9 @@ The default output is subject to change. So whenever possible, you should avoid
>>   *-n*, *--noheadings*::
>>   Don't print headings.
>>   +*-i*, *--input* _file_::
>> +Read data from _file_ (Which was created by other tools, e.g. sosreport).
>> +
>>   *-o*, *--output* _list_::
>>   Specify which output columns to print. Use *--help* to get a list of all supported columns. The default list of columns may be extended if list is specified in the format _+list_.
>>   diff --git a/sys-utils/lsirq.c b/sys-utils/lsirq.c
>> index e31addaf5..45d542919 100644
>> --- a/sys-utils/lsirq.c
>> +++ b/sys-utils/lsirq.c
>> @@ -29,16 +29,17 @@
>>   #include "optutils.h"
>>   #include "strutils.h"
>>   #include "xalloc.h"
>> +#include "pathnames.h"
>>     #include "irq-common.h"
>>   -static int print_irq_data(struct irq_output *out,
>> +static int print_irq_data(const char *input_file, struct irq_output *out,
>>                 int softirq, unsigned long threshold,
>>                 size_t setsize, cpu_set_t *cpuset)
>>   {
>>       struct libscols_table *table;
>>   -    table = get_scols_table(out, NULL, NULL, softirq, threshold, setsize, cpuset);
>> +    table = get_scols_table(input_file, out, NULL, NULL, softirq, threshold, setsize, cpuset);
>>       if (!table)
>>           return -1;
>>   @@ -58,6 +59,7 @@ static void __attribute__((__noreturn__)) usage(void)
>>       fputs(USAGE_OPTIONS, stdout);
>>       fputs(_(" -J, --json           use JSON output format\n"), stdout);
>>       fputs(_(" -P, --pairs          use key=\"value\" output format\n"), stdout);
>> +    fputs(_(" -i, --input          read data from input file\n"), stdout);
>>       fputs(_(" -n, --noheadings     don't print headings\n"), stdout);
>>       fputs(_(" -o, --output <list>  define which output columns to use\n"), stdout);
>>       fputs(_(" -s, --sort <column>  specify sort column\n"), stdout);
>> @@ -82,6 +84,7 @@ int main(int argc, char **argv)
>>       static const struct option longopts[] = {
>>           {"sort", required_argument, NULL, 's'},
>>           {"noheadings", no_argument, NULL, 'n'},
>> +        {"input", required_argument, NULL, 'i'},
>>           {"output", required_argument, NULL, 'o'},
>>           {"threshold", required_argument, NULL, 't'},
>>           {"cpu-list", required_argument, NULL, 'C'},
>> @@ -103,10 +106,11 @@ int main(int argc, char **argv)
>>       cpu_set_t *cpuset = NULL;
>>       size_t setsize = 0;
>>       int softirq = 0;
>> +    char *input = NULL;
>>         setlocale(LC_ALL, "");
>>   -    while ((c = getopt_long(argc, argv, "no:s:t:C:ShJPV", longopts, NULL)) != -1) {
>> +    while ((c = getopt_long(argc, argv, "i:no:s:t:C:ShJPV", longopts, NULL)) != -1) {
>>           err_exclusive_options(c, longopts, excl, excl_st);
>>             switch (c) {
>> @@ -116,6 +120,11 @@ int main(int argc, char **argv)
>>           case 'P':
>>               out.pairs = 1;
>>               break;
>> +        case 'i':
>> +            input = strdup(optarg);
>> +            if (!input)
>> +                err_oom();
>> +            break;
>>           case 'n':
>>               out.no_headings = 1;
>>               break;
>> @@ -157,6 +166,15 @@ int main(int argc, char **argv)
>>           }
>>       }
>>   +    if (input == NULL) {
>> +        if (softirq == 1)
>> +            input = strdup(_PATH_PROC_SOFTIRQS);
>> +        else
>> +            input = strdup(_PATH_PROC_INTERRUPTS);
>> +        if (!input)
>> +            err_oom();
>> +    }
>> +
>>       /* default */
>>       if (!out.ncolumns) {
>>           out.columns[out.ncolumns++] = COL_IRQ;
>> @@ -171,8 +189,10 @@ int main(int argc, char **argv)
>>                   irq_column_name_to_id) < 0)
>>           exit(EXIT_FAILURE);
>>   -    if (print_irq_data(&out, softirq, threshold, setsize, cpuset) < 0)
>> +    if (print_irq_data(input, &out, softirq, threshold, setsize, cpuset) < 0)
>>           return EXIT_FAILURE;
>>   +    free(input);
>> +
>>       return EXIT_SUCCESS;
>>   }
>

