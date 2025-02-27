Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B336B270023
	for <util-linux@vger.kernel.org>; Thu, 27 Feb 2025 18:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681158; cv=fail; b=LteXSYGDBIliz1dbx8SRtX/J7kHlpMl0ILo7bF8pClza08SiuMGjA2Yp9hkyJvXbzJyrOTVNfW1qAV33/7IYkehGq3RWiFJHaiwgt3MyrJNyP23rM3+yOaiPzrVC5KsH6rvbK59AhDrk5A9AIVQBeRAKg+eZVy6MlYuAJ+Bs43U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681158; c=relaxed/simple;
	bh=OrbFB5c12rsSnyoyYFoFRymn8GozyqR7LPjL+3pkITQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lV+cTjpAzWRD+a9c9CnoGTY0t9fSy3HGRLmMa93TLNviiNftGFmOHGPVfI7SprNImtxZhnzwJx4aJ0v+jHHRKDFxzfrt7ParHCex4w9tqlP2XeQPH3ODpgRhC/mnWU6fSQHfAQl3ZRzvfClifNSfpWYJmDqAi6Amj82XehjJGYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Phgr+1nB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vIPCdFi7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Phgr+1nB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vIPCdFi7"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RGflCu027400;
	Thu, 27 Feb 2025 18:32:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=cgVzf8UX03yf5gVExOQEqhL4en2KEpvfsats0jhvo1U=; b=
	Phgr+1nB8DTrMOVW5pRyCbRuWJJ9V7PV/zDeexlynSU5mZBl2vGXX/33EQ2pB1qw
	AdCp89FBpU0COcnFJskG9nbfcYsbkjNp1m7PqAf8g1LmW02B37nqbhRvxbMzFT1l
	FlpTuGii+nSdH9x3cj9HpPbKDCrtkFk8Ap4B6jeD8M8WHvz3ak9YdwJoseXydeib
	wiVDTl3HjcFrWdEPzy4eHkZbxu55EnTdicNBnpJakj1vbd3jJWFgNg1PKChUD13Y
	6rGchrnE33Sy+u+4oV9dtXmhUTiFf+Wg2VGC8QrF+AEVf2T/PnDMIoMKKLqqGDS0
	y3WALFEwhavCCqx1wKYH5A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psf434r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 18:32:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51RHqPbr024523;
	Thu, 27 Feb 2025 18:32:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51cjjgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 18:32:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EI8wWU2BFhPL6vdWHvvdFsq6QRxTOqX+fU6iZdiD+x72OnJAhyUDs0vKmiAscaveNq2cUTuO99lV0nGvaPod6slDcSirpWZRFB3PwMRBRafyi0zLwYh4cSqbaYPNZEMJNzNHA/P30J9I9s27psNIeLOYTBx76Y0zgNerej8ox7bwoCkG0BWTGKcb3+DZ4jUs7j5gjKcd1mBPlckfygHcThhSjBU9DIN0oHZAwoA4UCvOzbscn7iMG5NttlE5+vlZF/hmwi8mqhU5AT94ciCzgVWqMa6PSwGmMbw7/Oo+4HT3kdRKwBTEBm3uE1+7b8KTsH/RKPARFAJ4VC/3gpzDhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cgVzf8UX03yf5gVExOQEqhL4en2KEpvfsats0jhvo1U=;
 b=x5LrtpJgy2Jf6vFOXsFMUreY3h8+C2k6bNqD7N04RTuXjZT0ai1JFjG+YuimCbgntHPvx0wf2P5nAd6zh9urL3Ned6BFWB1oFwwqMOGC2Ns/c6ifb6sqPhO23cz2PlJ8rmWdMyAIVu6Y+dnG2Fa52GMGrrsnRbaYDzXg7OJCubZzPFyqkYByHteITxLg6AxV50mXLh74zpGO/YfTZI4jGDqcoDv4issUBJuoGbx2JCSF27okO5YDxsk4K3e5On7gG6rkPdihmRPFyvhIIRYGsNAp5QxaiLRZF4Eyn50757gLdr5htxZfS3Ck7ZGXfamVbk8uHYXT8/O1IaCZOOmEFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgVzf8UX03yf5gVExOQEqhL4en2KEpvfsats0jhvo1U=;
 b=vIPCdFi7ALI7SEeZALUK84DYO+5GNJ/2KyWuIKC4Q2wpJclPwuhQiZnoe3n+U18/hddikqlqTM+gKL61/90qNAwEqHTTCDlWR7pu5UmGPqNiu6jEsnQt3cJdx790gyQJA17zF/E2+PyK0ulsurNqcS2P/0KZwtS08nqDEQ2nlDg=
Received: from BLAPR10MB4931.namprd10.prod.outlook.com (2603:10b6:208:331::6)
 by IA1PR10MB7166.namprd10.prod.outlook.com (2603:10b6:208:3f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.24; Thu, 27 Feb
 2025 18:32:14 +0000
Received: from BLAPR10MB4931.namprd10.prod.outlook.com
 ([fe80::2ec9:a98e:942c:3cbf]) by BLAPR10MB4931.namprd10.prod.outlook.com
 ([fe80::2ec9:a98e:942c:3cbf%7]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 18:32:14 +0000
Message-ID: <df430d5e-3973-4553-80ee-1ae3bb868a22@oracle.com>
Date: Thu, 27 Feb 2025 10:32:11 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] irqtop: add max iteration support
To: Karel Zak <kzak@redhat.com>
Cc: Zhenwei Pi <pizhenwei@bytedance.com>, Sami Kerola <kerolasa@iki.fi>,
        util-linux@vger.kernel.org
References: <20250227044916.89925-1-joe.jin@oracle.com>
 <20250227044916.89925-3-joe.jin@oracle.com>
 <pr4fky3knju6kxdk7tkdffc6qcxrintim4y42aoj4rcfrn2wk4@2no665wcutja>
Content-Language: en-US
From: Joe Jin <joe.jin@oracle.com>
In-Reply-To: <pr4fky3knju6kxdk7tkdffc6qcxrintim4y42aoj4rcfrn2wk4@2no665wcutja>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0131.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::16) To BLAPR10MB4931.namprd10.prod.outlook.com
 (2603:10b6:208:331::6)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4931:EE_|IA1PR10MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f178d0a-eb79-40c1-2613-08dd575d0e11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVZQVXk2MXZ6TThnYWE2aFN4WUlDV1RlVk05UWJwMmFYRmhLVlpkL1hBWGRU?=
 =?utf-8?B?dGRqcjNTQUJ2N21vdXJkdkdVbVRXc2ZlRXNCYndKRHA3V2YrUElrWm9senUy?=
 =?utf-8?B?aGh2cE9XS2wzdDVUdmNXak1Hbk5YWG8zWFhQS2pQcXJ0RDVlWjdBdjdEbldm?=
 =?utf-8?B?N0k5djFleWVUTXBVMnNOVmNCM1g3a0RLaUVrVTdlSXpYbkNSKzh0VE9tQ3Zv?=
 =?utf-8?B?eFNrK1ZvQzljeUpGWlZaMmx1V0NUazNxY2xsZjE5cG5TdkExWWdnOXlYSkpT?=
 =?utf-8?B?LzdWMDBsTGlBVmFlY0xjODliK3doT1lEK0I5WWhoMS9vSVJpWFpWV1NYMWtj?=
 =?utf-8?B?QThWb1prbldCYlJ4aTk4VlZGeUViVkZnNXRVMW0vNi9oaHpNZ0pjWDYyY3Vj?=
 =?utf-8?B?YkRpWXFGc1RYelFKTElNaU5ZSE1FakpZcEZaUjZNQW9UdGVSRXRrR3VNWlJy?=
 =?utf-8?B?dEVrR3NOWVRKOXZMd3ZIam1ocEZkcHJkWm8vQXVaVVFocjZsdzJwT25LRXlk?=
 =?utf-8?B?UnhhaXRBbXU1M25Vbi9lZnR4R3BRS3U1TG82cmJLUHFvbkZIdnJkOEQxRjIv?=
 =?utf-8?B?ZGs4ZktkVEM2Mmh2VGQ0TklVbmo2N1pCNUJpTGpkMUh4RHRFK0FDU25pclZX?=
 =?utf-8?B?NjdVZng5dTFIZkhaa3JmaDRlM0FwcnNOTEk4VTBXSXJaRFBlRlMxVzd1ZWUw?=
 =?utf-8?B?dTF5UGFPWXIraHlYQ2IxSlV2azc0cmJYNzdHSzVvbnpMN1RMVUlBdFZ5OFpE?=
 =?utf-8?B?Mys3cWZCclFnWGxWTDl6SGJSSTB1UDVJcTdwWmxIY3E1NGpIMkhqY20zcjQ5?=
 =?utf-8?B?am11emRPTG9IVHNPZVlhSlQwTEFCWXYwbk9Dd3JlSHdWNHFNZEtFdWlGT0h3?=
 =?utf-8?B?VnozclByRmJGZVE0ZUNsaXpGemo3c1FmWVg3OENLYXR1bkVrbDVwUkZPWFAr?=
 =?utf-8?B?QlNZNVgxNWVXdjE0ZS9aYlFRRTVLbUVvc21qWGJOWC8rLzhRQ3hSc3N4Nk1Q?=
 =?utf-8?B?WEtWYzRLS3F6US9yU1owcVBrdDhDZThPYkdMZEkxdFp2V3JGNFBpeHlDVTQ2?=
 =?utf-8?B?aG0wMk4wRENPd3R3Y0pMTXJ4dUczakx4NVRSZUxIZFVuRGZlREEzbWxhYWxP?=
 =?utf-8?B?VHZYNG5hRVVnVUZYemdHYm1mZEw1VDdhaVA4ZldXd0ZoV3hNbFBlb2FRTGRN?=
 =?utf-8?B?TUxFT0szT2MvajQ5cXJjUXZzbHVaQzc3dGtRMEllTTVnZ241TmI3YnY5SjJE?=
 =?utf-8?B?ZTFtc05xdjF1NHkzcUJPMExGZlhvTDY4NGtQUlFvN3V6djdPZklvcWEyTUwr?=
 =?utf-8?B?OVZXVlRWUTVTZk00VTRBODRlMTI2cEZEaGlYOXlDQWFvWUtRSmthNXhMZ0ZW?=
 =?utf-8?B?VzVnYnFVQXlkVGhXc1JTb1U3OENEcGlrM1Jvb21kQ3A1SWFoT0d5SHA3cnk3?=
 =?utf-8?B?MTlnUldsMUluRHdSdWVRN3Fia0E4VllObDM4QTFlSG9RZXBFczFDTHVvcDUz?=
 =?utf-8?B?SU1GNE02cEJJYU5jSE5GVk1CcUNzQ1dIQnFxVnl2L2VNcGlxVW5EZ3JiM2Fy?=
 =?utf-8?B?UFJTS3FKeWpBOG45bkx1ZURVQW1Xc0huTklRai8zSDk4dW9lMXp5bldPdGdn?=
 =?utf-8?B?ZytFUVZQWTZQaEVBWVNwTEhicytDWHV3YlZSSUQyTXEzQmFacTlFZC8vNWlJ?=
 =?utf-8?B?S3l4L0NRZDdSaHRubmh4S1NHMHNNdGJvNW96TVJrTGp5bUswazhDTDQxWGxU?=
 =?utf-8?B?a09Pb1pwU0J1N1JyczFvaDF5UXgvYVhVSEpkQzZFeDV1NWNvbWxWaWhyYzlC?=
 =?utf-8?B?dkxQZFlVWWR5Q3F5L0VteGdVL1ppb1NuS2xCSFFJdG9rZHh6N0tpUkRQYmd6?=
 =?utf-8?Q?evh7lBQabYDM7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4931.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTIwYXI2SUZPUmdBcDhTNDhOVkpFWmxnNEFLRU1OMnhOT0YrbE14L3hwQnd1?=
 =?utf-8?B?c1dhQ2k5V2xHWHhmOFRvcmdlZ3EvWHlkNlZrY0JWaUdLcXpTSlEvdFEyR2p2?=
 =?utf-8?B?T0VBMi9YZW1ZZEliT0lMY3BRejdoVzVTZ3pPdk81UlVGQ01XM2VsV3ExdkhC?=
 =?utf-8?B?M012QlJxTUVicXY2dVFtUVRBRlNpRjl0UnY2cStNMXVDeWgxQkVZVE1iTCtX?=
 =?utf-8?B?UkFBQnFWZTUwbXFmZS81OEtDR2cvRkNsQzZMNFRENE05QXVJS2V0MGpzSGVH?=
 =?utf-8?B?SGtGQThlNUI1Q1FnZmh5MnR3REhieGxNYlpHTnA1RWl2bDRlRnNIdTl0VDJ3?=
 =?utf-8?B?ZVh0VUY3N05sNm05RldRbnh2aktYa2YreElZZ1R0b1BsVFh6YlVuaHNtWjNj?=
 =?utf-8?B?Mm1VQVdZcjZ3cUZMNTk4TER5Ym1YQ3FvTDYrRks4aFBvSlFzMTZJSzRIQU9O?=
 =?utf-8?B?SUhLMHNxQjV4amVKZVA0ZHFMem1mRkhPYXJacExOUWRDQzJ3Rlo4WFRWNjNG?=
 =?utf-8?B?cTYybUdyeXZuYkczMEROQjg2MnNla2I1SWFaakxhL3U5dUR2WlJvZUFyVnBG?=
 =?utf-8?B?ZnI2eldWWVZSelhzbjY5M1E2YXFpb3NvQ3ZSbWk5bmhjOThSaHZXekN3VWEy?=
 =?utf-8?B?SS8yazhYNFNnS0x4YnI5ZTBDSGZwU21KQTB2WnpoSmpXeEpQck4vTk40ZkJ5?=
 =?utf-8?B?WGpyUk04M1c0bFVqUWxKcVQ3TSttcmd0ZnhQSWk2RVBobUpUVFd6aXNjeDl4?=
 =?utf-8?B?TnArQWhqSi85di9Oa0UvRk1QZ3ZRSXlmRVI1VGlhSWZjSlZMcFNtSHFtZDhX?=
 =?utf-8?B?STBwWXhlYlMyWkVMTW9LbDdOckRMUXNkZ3dac3hhbm12cGU5U1BnMlhqT081?=
 =?utf-8?B?WVgvWFFmSFNiUEY3b0ZkRXpRdE5maEQ3N0dhOXA0bHBPNEw0Wkt3aCtsLzdw?=
 =?utf-8?B?MHJ1TFVrMU0wdTJYaUdvMlZJQWFCRjRJa2J0QktCZjBZZHJrRUhad2lrdG8r?=
 =?utf-8?B?VWJ5TDFVQWtma0l3bW9ESFRRbi9ETUVsU1Z1WUlTcnU2Z2hqQ2gxSzkwR3dD?=
 =?utf-8?B?OEZleHIzcDJ4U0VJRlE0ZU9lcXJhS0lUZzU2bXdGOXJPbWFVZTkxcDhFOXZY?=
 =?utf-8?B?N096ZXBzQzNYTFJhTG5DMHhXcG1uWlpTVWdXejVpM3JpbDJLcVBUS1VHNU9h?=
 =?utf-8?B?bzkvM2lRU0l6Y1JUbnhKbXZWbjQ2MFhqT2xEb0lkeUZXaXZaRDNDOEpoMElJ?=
 =?utf-8?B?WmUrUmpRVHRrS2UwakxHUzFZWU1sZkQvRHV5MkRMMjM3T09OclpsVWp2UFVG?=
 =?utf-8?B?RVRRTEpkTEVPdHBNWUF0VzlkWUFvM0grUUhKU1BwS2NjVkxOU2owb2dkSjZS?=
 =?utf-8?B?S1hkN1FHbFl2ZDZRdERVbURvcUpmMlJHSjRNM1NCaGpJQW9CRS9xcmdROWg2?=
 =?utf-8?B?b0pTQmlxNUp0WlJEN3BBUHgzMzZJSmFCL3oreHEwYS8zYUpsa2E3REpwM0hY?=
 =?utf-8?B?VDBQYzVaR2FoeDkwT3JqTk5DT1lsZmFVQUxMT3V0VHhFU0YxdU53VXhhNElE?=
 =?utf-8?B?bGlCYnJKWkFsaEcxcnpBMUJvTnFmazV6cnNqd3AydG4xTlRUcGJsM2dsdUtR?=
 =?utf-8?B?cm1BMEtGSXlwS2VkVjRHNTNiOGFUYm1KVGpWd202T2FmQ0Q2eEhwWjlCNFUz?=
 =?utf-8?B?a01VZlVrOFByMmdYcmNPT1I5M05WNG85V002WFNyOSt6S1pFTW1MVlFUQW5E?=
 =?utf-8?B?VzlYRGNjSVBmNHdUQ1h6bUNjaHJSNVZGMjgzVXB0cExqT0pzMmpGeEdWZW1I?=
 =?utf-8?B?cFR2emM1VmNIRThsb3lpSUQ1WUZDNE5kK3c3VHc1ZGkvcnJDS1c2MlRyS0pF?=
 =?utf-8?B?VDRqQUROdEFjaytrVGdmMG5LbVpNVHVodVRvcEc4dkIyTUg0RU8zYTNncHJE?=
 =?utf-8?B?aEVaMlBad3FmazNzR1FJenc1am9sc1ZsM1pnd0JlQVRta1gwbWwvcHFUaW1B?=
 =?utf-8?B?aWg0M0pvMmdFYitxNGJEQnNEWU81ckNQOVlONVNSL1VXMEhCY3lkNFIwRWdu?=
 =?utf-8?B?ZlNweUJKYUYrTStNRGdkMEV2c0ZkYnBiQW5MZWVIaElUWDBoV1RTd2d5RWRw?=
 =?utf-8?Q?LIIISeoaRpdAE3qbhDdZxT63c?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sitd/qfAB8inNvRL4Od4mOsdP6wo49Cgsz3N8YwJX1eOgXFRUOxTsJW08WlZmgdPcuY9B/c+Ogg7xqO7VW5vypjPwM+IwH7U23L5nzBDjDd7VfOW9f2IKfAz2xKevPfN6XrfVvDGEw1GhN2muEQWn4qJgcxRWzJ4nok00k3yNUwBo1114LoljWYF2QKENoZR1omk/0Yui0Se63WDVJn9NqYg+GuhxxCNJMpKPIeA7r0J4T8LGhTgKpUalgwagKl+h6AuIZkb/7WSfuI8wHGRaSqftPMGszTWSU4/5qvpPjo7GdbpnCBZvqEIVXZLcaAwOq68Hw98mVgbI3/1q6FRysZyq3kiCwfjlsZLxzhgHEXs4a6eR8lek7jwwQ3WI88Rnu5/39QvuopG5ckZF7PALe9Jaxr5kKko8HDeQorxgr6q1kE8KOo1w+QOi6xMhDLwU0DOAkXUfByZNQrpq3suQbXPgAVcsxtas8cYUd7Qr5mUXVy8GlCDhslapkBlmWPuZny+pwZuRn+FZ2u1J3D38CRC/Buywrm/MZh/s5AuPvL5L0CKEA1h0swL4BmpJ33cu9GG3D83qo0QHjdToa9jp4VEFtVhIgaOw9Sh8WI4g9o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f178d0a-eb79-40c1-2613-08dd575d0e11
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4931.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 18:32:14.1111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ftyXTmpw8nLFcEEExksGSGmWTk5bbCkwSy38Pl2pX6Fb4Wk9aAetUbXgzWDHyvYs7MvAiRXkjVLLCWWI0dFkOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7166
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_07,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=932 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502270137
X-Proofpoint-ORIG-GUID: 6X73phh1_U3KD7iZkr9ct5D7KToBYm3t
X-Proofpoint-GUID: 6X73phh1_U3KD7iZkr9ct5D7KToBYm3t

On 2/27/25 01:28, Karel Zak wrote:
> On Wed, Feb 26, 2025 at 08:49:15PM GMT, Joe Jin wrote:
>>  	enum irqtop_cpustat_mode cpustat_mode;
>> +	int64_t	number;
> Can we find a better name for the variable and the option?
>
>   --nloops 
>   --repeat

How about of "--iter"?

Thanks,
Joe
>
> or so ;-)
>
>     Karel
>

