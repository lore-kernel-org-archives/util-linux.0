Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37301754B
	for <util-linux@vger.kernel.org>; Tue,  4 Mar 2025 01:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741052355; cv=fail; b=YEobgKAexRz9F19aNVhXZGeZIANnnkj/v2NeHUhxs2fnpW6BxDhf8hgQ8DhUwhogDi+CLyDD5o8j/cW4+oo/jnzf8KkXGB/PyZQtIpITRckqfbrft6X8Rca79mizPf3pE9T71AFrdOpWO9ltAfHQMh8unL35xjoWfwqZ72x6QqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741052355; c=relaxed/simple;
	bh=61hy5kB6kYh/GzW4mkN2hJ41mnSgYiXB2EtlVPMO6+w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k4qvVua+vKB1Xjnx5yV9RIfOYx5qk3eSulGTHEM+fq3O4Y3r6eS/KivOSfNlC/rqzJlFYPFIrdIt0lX1btwDzleh7j30wHS1GwsGOrundwNjGHix9G30eRdAGFQ5GC06qf4EweG+YmxE+J67zfUzHZzmSwYjyvNPC4rDQQHPIiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FqOmd1sK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hvcF6kUa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FqOmd1sK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hvcF6kUa"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5241Mtw3024018;
	Tue, 4 Mar 2025 01:38:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Wwh+yZsWw6aVCPy5Pf7hA5V+KbdRTNJVL91rBxZ0Q5o=; b=
	FqOmd1sKH3Uq9+Mn43xn4gIPGSAw9mWUwvJEZGrZuOAEAEhD513tATD6tjLf7Ln0
	dgMUBZ+3yAWg2I576fgmosNSfVNu/oCnqyoMMqTGw/neSaGXsu23yrOHSBt5I0a3
	XrTflu+6wGJHkJj2KQSoWSUgURCKy2FljyNYH1SpK/J8C/Nm5sQF5cf6pB6cnY3c
	HatALfCqx3l0z5VintiRuUcB7HzfCvZ2sccDaODdnC+X80DKlqyuODw8pzXV0q0g
	3xl9fC0gmeqdbJQS7wRMXgFbVxyqkQXm05pKHeB0VdqhPeC3POcbGQtzpDJQe3N8
	DQELneXRf9jYI0YNgEJqRw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8wkxcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 01:38:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52411cY4021926;
	Tue, 4 Mar 2025 01:38:50 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rwu8jkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 01:38:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJ6sLhh0Rx/WI+4J8qdVmr2UHPKHZ4Kiz0N2nVnh5p4MvJemIZ/CSxHhrnzIWdJWVdnWmANpUMmS8fZtPXxF7tQGaoUCyC/vH39fV2UQvz1lbBLZsipNHUM3QOVYIXYpRoIEsTx1asjBb6fKUh+tbnbOzlMSUjwYmyc27vK6TBCH32bbqeWmWkS/BO8zUbcyMx5YyEAw4RoefH0DXC/bcH7VHWjb2vAcjE7FMYoBHJUKNEUOZ69m26r0a/e7JLEj6LIBdKC2GHTB9T5bEMHiyXBdrhvMPvs0M4nvGsyA3AAqWkJ36qdOtyUxcbEm+Rq+HAdRDAHN1qGGNHugDJAvDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wwh+yZsWw6aVCPy5Pf7hA5V+KbdRTNJVL91rBxZ0Q5o=;
 b=nvS9OTZXY2Jl8p3Ko2PUtsZIAWkszw2go5eBrxo1JT0JypbOeTQLWgIP4HxU106JmGRdCsnMksQdFhk1GuxhO1KYy05YjhedDADcE+EETxfbnXSZMLggk2fPNAAqNF8VQCT31LfFvk8/A/ePGn1fyb95dpdm0q9IYLTpXvXYS9qT0XAqxb5z8bKf+45dmlKjEGF+jA7Hy/Gbx4nEcIL+soWR5a30ySCAo53Wkhfh/2nv/PAgmzPzxE8tNMi5yZH0Dba29f9nZh194loH5y3JKaczjmD4kpKStlb+YQ/D+SH3Mnp+NFLw5cKSrZqoFVJcgMk43k523eE9scMWZV8g2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wwh+yZsWw6aVCPy5Pf7hA5V+KbdRTNJVL91rBxZ0Q5o=;
 b=hvcF6kUavna6Qygt/Z5GcB4QfyUEccdZRLlSM3XMqVXC/WCxVAre4BzA31YRGz5H02XFTQ2NMQ+dJ6nkoKLmQJ4rSBuUVAmUo2rw3etI6rmt5EipZgBpEC2EH2p9DS0YgrFNW1ZdxzGxQ+lV6N+UtQFJKu5cEyh4gz77SuHuwHE=
Received: from DS7PR10MB4944.namprd10.prod.outlook.com (2603:10b6:5:38d::15)
 by DS7PR10MB7226.namprd10.prod.outlook.com (2603:10b6:8:ed::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.28; Tue, 4 Mar 2025 01:38:48 +0000
Received: from DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5]) by DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5%3]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 01:38:48 +0000
Message-ID: <d0410820-4713-4823-8a99-023223bc17d6@oracle.com>
Date: Mon, 3 Mar 2025 17:38:45 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/4] irqtop,lsirq: Miscellaneous enhancements
To: Karel Zak <kzak@redhat.com>
Cc: Zhenwei Pi <pizhenwei@bytedance.com>, Sami Kerola <kerolasa@iki.fi>,
        util-linux@vger.kernel.org
References: <20250228161334.82987-1-joe.jin@oracle.com>
 <ycaevmuxkamyr6m2um4kqxhx5xh7jtcr2xoeadfz2v6cmcmrrf@lgpkcja4h7rk>
Content-Language: en-US
From: Joe Jin <joe.jin@oracle.com>
In-Reply-To: <ycaevmuxkamyr6m2um4kqxhx5xh7jtcr2xoeadfz2v6cmcmrrf@lgpkcja4h7rk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9P222CA0025.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::30) To DS7PR10MB4944.namprd10.prod.outlook.com
 (2603:10b6:5:38d::15)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4944:EE_|DS7PR10MB7226:EE_
X-MS-Office365-Filtering-Correlation-Id: 1611fcd3-2807-45ef-eb08-08dd5abd4f30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2ViM3FCdldBOUlzNFdtQWNRaDJyL1Y1N3QwSHlmVG9ndkJmQmp2VFluTDNJ?=
 =?utf-8?B?RnhFeldGSUFBSVExQVR2MUMyb3UrUU9nY1VDeXY5NitzRGliRnF0WEJEMzMz?=
 =?utf-8?B?b2ZTQ2NHQ3RXTzBib1d0eUhqRzlLaitweXJsd3RhSnBSc2dPY0dzZnhMRXJR?=
 =?utf-8?B?SC9OVUtvNHNzY2gwSmtzVGI2REJGK3AvbGRJdC93TFVsOEF1TUJLbk9yanZU?=
 =?utf-8?B?NG9zcnc3MzY1eVdHQ2x4Yjg1MGZkeVRIWmRpT3U0Rlg0Nk5kRThXWGs4dFFs?=
 =?utf-8?B?ZWdTdVdURVlKSkg0cnRzU0lLR25qK3NOcUc4amNOMng1NDdzUDNTTjFOOS9Z?=
 =?utf-8?B?cW9iK0dWSzhiK2NaWkdKbldFNEFYazdhQ2xRVVlEcXQwZm5SOEYySHlnT1RQ?=
 =?utf-8?B?emV4VmpXS1dURDYyTitBZk16aHRJYkdBQUthd2NLYThNV05ZNTFSbFJiQXFt?=
 =?utf-8?B?UlI3WFdTenEzM2tDZ3A4QmVCM2I0Q3BmU29rRThheFNQbCtCQzl4V0w0MWFF?=
 =?utf-8?B?WUpTa3N5ejIrME52aEhySlBNcnpuaForNTVNMitVdXpadndJUlV2dHVMOXN6?=
 =?utf-8?B?WEV3bnNyZm1LSWZwTjR3bm55eFEyMXBoYVhhcGRrNFFXWUpVWnFRenQ2S1Ba?=
 =?utf-8?B?RllxMlNEMHlYRmpSeHJHZk1DTFozWmJDaDFzakZmckJrZHBwZnhlajZLS25p?=
 =?utf-8?B?ZkxRdFlMU1ArNU9vd3cwclJFWDJyVjh0L0ZSU1dUcFhOUGFmUExUWlA3Z0hE?=
 =?utf-8?B?UTRqUUxYRGRIWndGSDZmMU1sQzNMZUZoMktDWTJTUWFRWFhaYnVFRFR2RGts?=
 =?utf-8?B?QUlCcEJiYUZQK1NvZ2EzY1BLeUEvVlRHL3pwQ0hCUDl0eHloTWoyUEJLUEFt?=
 =?utf-8?B?b0Z0VEJjQStObDlTWm1LM0R1YU1VMlhMNy92WnlPM091WHpoSWlrVFVnOTVt?=
 =?utf-8?B?TmZ0cHlLV0NoVWQrZDhLa1liSEUySDA3RmRPcllyUWJMdDdWRGNNaTRhdlB6?=
 =?utf-8?B?aVJRMUNvY1oxczdRSGc5R3VUSlB6cGI5ZFpJSUpFSUR0OG11WWFXREJhYUlh?=
 =?utf-8?B?QkxRaXNBSmIwcmFSWEJ1ZUc3TXdPSHhtUlI1aFdRTmhlazgvbFRlTysweXhj?=
 =?utf-8?B?d284YmhIS1FHSHJQR0M5ZEJkYWJHTytEeXdLSkZhR1VuZ0tXUkVyTG9xVHFU?=
 =?utf-8?B?bndKS2ZwRFZzd1hFejFnMnN2R1BqdmJvZW80WElScXJ0bVUwV0RCWkQwd0lO?=
 =?utf-8?B?VEhiQmhjdHdieGQxaWs5U3QvMU1zM3l5aGNieVFUSW5hSmtQS2UvaDlRNWdD?=
 =?utf-8?B?dWRCVnZoSUV2anhWTXFBN1hwajhyVmtHYTk1aU5nb0IvZ2tWQmYvN3k4M0Nk?=
 =?utf-8?B?R1lIekh0cHJ1SnZZcGpENE9mUkgvL2Z3azJFL2hWTmdaakhHRWdyRUpLTnNO?=
 =?utf-8?B?bkM0VnRYWmRIeHJ6OUpCTUpoT2FxM2xoUEltdVdyS2FFTlFJVFMvZkxqRVVX?=
 =?utf-8?B?a0VQK0d3aXgvNnhZdzQ2WnhIeVU4OEZKWURGUTFVNkNyZUo0cUpjcFBmUFcv?=
 =?utf-8?B?NWRFTlZLRUorekhaUVNsTHc4V3ZHMDBnL3R0VEFPT1ZpNEtDekZtL0MzNDdk?=
 =?utf-8?B?M1c0YTY0Wmxzc1pkVDFvclFLd0k3UGNoejN3UllaeHh6MUsvVUx0UjlONHBR?=
 =?utf-8?B?WHRseElNRWVlbkRYUG5vQjNqWDVIUWN0RDQ5bmhNek9yWlBQZDE2dkRzaGRD?=
 =?utf-8?B?eHlhQ1lMc1V5eSsySGczY0RWYWJON2RSTkpjaTFFeXI3cXdjc2dEUC8zN21x?=
 =?utf-8?B?UUF6K08xWklWZjhOU001N0NTSDNDLytoRDl5bDNiSFFwb3FMVHd6SjBsS0Nv?=
 =?utf-8?Q?03YTj2iBVKchH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4944.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3FQb2FBVFd0dE5odlpmUThhTm9ET0MvbmRpMGFzb2ZDMWFtWXF6OTFxcUg5?=
 =?utf-8?B?aEp1R1Z1bERyb1JwcjJJN3FzanVaTGRhSW9HOHZIUlJVY3d3WlhDZXlDdjdT?=
 =?utf-8?B?bFc3dWp4Q2g4blJNR1V5aWJCZDRMaTMrUlJFK2ZITGY4YS9pNlVERlhxUjUr?=
 =?utf-8?B?a0RBZXVNKzBGeXNNMkxtekVsVTB3bFQzYzFOWTBINHdqcFVBSk9UQ1pHd29l?=
 =?utf-8?B?NUd5VnRweS90eFpXd1F2RDJtbGV0cUFOdlkzbTJtSFYxcVlGRUFNMzk2eW1N?=
 =?utf-8?B?a3hhR0Q3cmNGYzN4elNsaVFEMlhoUWFrVTV6VHE3OXViekpyZlMrVEM4ZElI?=
 =?utf-8?B?V3lUcURveGpLZGdmaS9uU3F6UysxNlpDK3hzMmtvSENvUW5WWVhIMlZGUFp4?=
 =?utf-8?B?cGpxTElobmJCakhTdGM0QzlFQ1Y2Z3BhRzBmSnoxNjlidzZyUHFycldEa2oy?=
 =?utf-8?B?cVl3L2VkbjRFZUU5YnRXK3ZNcXlJSXpYa0pDWFRPUHUrazg3QjcwTGRXTjV6?=
 =?utf-8?B?RGhyTnh5ZTdpQi9UZ3RwVWhKdnlIelhiRUpNMUFWLzV6S3prenE0K1k2S04y?=
 =?utf-8?B?aTNsRHR1citnaVU4TnFaZDd4d0FRKzRIdFhBeUVJd2hXaUJYb242ZktzTXdr?=
 =?utf-8?B?OHFJeVZxWkpheWpzRFdxODBwZmhHSys5NnloY0d5cFUwZTBwdFdCQUVWaDZq?=
 =?utf-8?B?d0o1dnRBTkJXYWIyckJwcVN5RWQ3UmFlNGNGWHZ2ZnFnUm55cXZuZzVqVUZQ?=
 =?utf-8?B?c1dOWFdLRDdJUmRndkRUdEEvUTg3YjVRREdNdFozYi84Wkc5REpwVHp1TEpm?=
 =?utf-8?B?dURaOVl5UHlwU3NnMDhLWmU4bU9JOFhIZEVoZzlNZi8wZW1MaVZPTG83SkFD?=
 =?utf-8?B?cVhFSFMzc0p4TCtnb1dIbmFCT0sxWlptKzZGNW5DS29MUG9UcW5ISXMwb0tk?=
 =?utf-8?B?ekJIQXRIbkttTmV3RWRJM1k1SnA2N3dkTDRLQjJ3RHppY2htNGhYa09xdFFL?=
 =?utf-8?B?eHlDWlpSSm1GYk8wdjVvR0JPVHRWbDVhc2pXODJoeFNFbU5XMGVoM0paZTJN?=
 =?utf-8?B?NGJJc052aG4rdHZ0Y3RxZ0M5eEZpLzcvZ3VDa2ZWZG8rcW9uWTNYVzRBVDcy?=
 =?utf-8?B?QXBvYSs1MHYwdXUvVnBMS3NhQ0tJVEZmQnpjaGg2NktVUnU5Q3FOOCtkMlFn?=
 =?utf-8?B?QkJKZVF0UHFWZm1PYXJFZy8xWmlHdWRhQkRudlhBREo3dUE1ZU1venVuRTcx?=
 =?utf-8?B?dDBxMTNjS1pSWGk4M2gza0JFTm5VWUJCN2xONGN6Wlcwd0FZaVhTL0JPbC9V?=
 =?utf-8?B?N2ZpdVNkbktQWlFDc2gvK0JSTlFHK0x3djhiYmM1U0VORWdLNHQ3RUYvZmMz?=
 =?utf-8?B?VU8rQXBJZXVFVjFtT1hGUkhGNG40M3lrV2pYc1dFRkRhTlJMNzZ6M2ZyQUVn?=
 =?utf-8?B?SEtaMWxjY3NZS0NzZitnWXJTelByUXFqR21IbkRKeXVVSU9odkxWK1B3bFlo?=
 =?utf-8?B?NmFUZUpCUC84N1g3TWZXNy9RYWRONmxBRUg5eW5PTzNZZFFhRW1XNzF3ZHNz?=
 =?utf-8?B?dFBPcXZ0WHk3MlFQOWU4cVNBRUtaTENEME9NU2czWlplV1ZjdEwvMkVGY2Rs?=
 =?utf-8?B?eVgvb2JWR2tTK2J6WW5XRXRwdXg5K2lnUVVQK1hiMTBzaTZMRnBTbVM3R1pT?=
 =?utf-8?B?bmlYWVEwYSt5V3NNNldOdkJ0RE90U3UyS2N5TlowM3VVNFZpWmdBY3VSREI4?=
 =?utf-8?B?NS9DNDV2WCtzNk1WeWd0cGIrSWF0VzZOenNVbXI5YjR6WDU5eWczNGpteVZM?=
 =?utf-8?B?VEJIS1hhdGFuY1lMUVNVMVE4SHBmVkZlUVNTV1QycGllY0ZScjh6bGZQa3U3?=
 =?utf-8?B?dE4zNDdGbS90U0FyU0taQjJpTmJRTFNYTDV5ODRCQjAyaEJ2N2hPVWZoWEph?=
 =?utf-8?B?cWpRakNqVHBMeTQ4RHZub29yOGkzZE1CVHZkcEFTNkpuRzNTZEpUQkRSTmd6?=
 =?utf-8?B?Ky85b21xUXJmR3BzMTFuQnlPYVJaNVZ4MTJJZ3J1NmJQMXhLUUNRYnRoZEpv?=
 =?utf-8?B?VU84R0N1MUZYMVZreHg4anAvQ0dmbmxRRUFIL2ZBYXBqdnRsOHVKL1RxZmZu?=
 =?utf-8?Q?kxt2B2UHqw5pumMqGPB10zS3W?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U12rxnr1nOD3Er7ThEwJ+hqaGKyqgoObtOrzB3/4yIZHkEX79nI40D+SJT2JtniM9AgaVB9/MbTdI/8SFI/NZxLMnRqRrlAhl1KfA61t5ypAy5JqSMLCpmycNhPciK5vIhH2r1nBmOfTkTI/Z75tijBX7TFqLNmPO9jFrPdiwoCpTeZdG8qq71LJTBZ1KZsOXXoSTFbmRYMfF83f3aL+oG8Iyg4dI9TpoR2qcDTTVUbRFKcxz4ukYzRye8XEpTu8dumJjgKN0zfEPrkDTX992R8BY7DXzFS1sLcAAHcTh+z1knkuAgPgcAb0whk0mVza2SpVN6gl99EfYfjWBfIqbawVNbKkqfVWgoivJ4yQgiMQY8N1rQEJ6VivvCAc7Bsze95qUKmPGUhYC0Lf6TZQe/WO9n+rhB/mSbu3temYwPOltEsBWLTXJwknPWRioNaB8zOuvnjwP5itMy1EektYTZXMDLviE4TbXLpyCI6Im5SoQOaNv9hiuvEgFk2NciGZgGMy72p35PhHKJDXIirKQ/2bY5m7pqUEX4RppwOjtW9vkumtdU1qj8jhVg4D8nyh/bsWsOT3GoGpPncvJ/MvgjkS2ukl9vJWawTc+S78AUw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1611fcd3-2807-45ef-eb08-08dd5abd4f30
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4944.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 01:38:48.2557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0DakiwfKyK4ZZWZV3+llgdO2ZOY2YceWtQa3Zg3+esFIgD9J0fQrup4IA7z4CbQC4aBnFUh35d6Ukr/ecARCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7226
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_01,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2503040012
X-Proofpoint-ORIG-GUID: 4SDcSWzMZn_dlVqIenvGawwV1F_KL0hS
X-Proofpoint-GUID: 4SDcSWzMZn_dlVqIenvGawwV1F_KL0hS

On 3/3/25 02:16, Karel Zak wrote:
> On Fri, Feb 28, 2025 at 08:13:30AM GMT, Joe Jin wrote:
>> This patchset add below new options for irqtop:
>>  '-b|--batch' : Batch mode
>>  '-n|--iter'  : Specifies the maximum number of iterations
>>  '-J|--json'  : Json ouput format
>>
>> Add below for lsirq:
>>  '-i|--input' : Read data from file
>>
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
> Thanks for the update. I have created a PR
> (https://github.com/util-linux/util-linux/pull/3435) to test it with
> CI tests.

Thanks so much!


>     Karel
>

