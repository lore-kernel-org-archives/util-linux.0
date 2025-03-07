Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E8818DB11
	for <util-linux@vger.kernel.org>; Fri,  7 Mar 2025 02:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741315956; cv=fail; b=NIQBWEflMBPUW5IsOMhhn9HlgBj5wYqT+Qw0cDOqAjzbMvyS+IOzqPm73l0xY1+VNtbLZYQWt1gkXeK/fpv3Ra4zFiPhgx4/4YHUf1kXqNP2W+oO37DkLRLWWK9nzfE0dbSy7POxSHw7spCZpSoYudIF0JY0oDAEMLc0+kCjSqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741315956; c=relaxed/simple;
	bh=gqyhF6hQOPAv8lJS8uht+sRYTDGcWhTmkhK+RB5rS+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ToFugMs0fzh1Lw7jDnRWyVlctO4un/BRxwjgSP8cVwzeBAMowP2V4PCrUQVadn9tSI+zFoYXyf2LUmAObgrK2vGoZTmNlqhXUntswkqrUGBnZiTJU56Mt3xmUGT18dCXzClU8YYb79j4OFUPpuJyfRl5INR1Gdt9nQKJiou45jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZptZS2sC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y3FSBhTw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZptZS2sC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y3FSBhTw"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5271vUGU004071;
	Fri, 7 Mar 2025 02:52:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=HVbGVNDBAYPhCmv1H9CSQSGGLJzcaxbA2tqZpomoUjE=; b=
	ZptZS2sCFUZMapuA/vuv46Ds8XHQNaOmuVdstzlwNm/6Ad4eP6JJtS5b/E03Zh/2
	OrXkr/OLvppCRXAxnN23KstF5RPjjN6fuwnWVqok+n0Pnbr6bJNlKaav7OTZC9oV
	RTvMtKVP5Us+QOAeZf+PWBTvqGfMyaPTWdrkUwVZ97rPLt9UL6nxve3I8Spoe0BX
	2lDEOdRR8DI9EH29CSlLiRds1vcecpmcIE6NKHrq4taBOtadKFcH681JeXK7mjd+
	oApGD9yWb0pwmGDTKp186uTp/o93J7whox/gjag3HPAh1IwO1YUkVu1yWrRFWWK5
	wpx3tu5WZk7+vP1js3c+aw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u823ga0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 02:52:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 527011v5021934;
	Fri, 7 Mar 2025 02:52:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rwyxt95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 02:52:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9eyN/hkuMQ4+/quXTVITQEQyLFDPBdgLppLcqWGETpJ6/eitlgunEKQc0kFZ+dZcBL9Suca/qxd7wgWD8EYm1Ay8GpADgoKGoHMXgN1/KN6E7IpjFWcttpiEm9Y512lP8bli/p5cvbbqlZZiu0oovZBLaem0b0cQhFzEP0LUV6MZLeyq2OAklxqOkPR8wR6YHIpKHSFPahqeU9UCXgwM4RKrgQVuC2d+kSUu04ogm0DIJHjH7NLj/67ynA58QboXLxyrxvWBFxoujM7WE/wH8CsSDQcTDG34xa99Kn2KjS+ADyywkHxEyTExf6xyZFKyJUl9ehhWmnKEtgkmp4/9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVbGVNDBAYPhCmv1H9CSQSGGLJzcaxbA2tqZpomoUjE=;
 b=RZcK+OZb+3TfkBmWc9XsjWoULfKAZb2fKzHJu21cAu8tuxBl3Wu+j38C1QsFO+5uOAsG9PRsL/fZPNXCoyuRtqFb/F+XOK3bvPdkTNGhCjsa9yt9MXX2JZ9aZlnu0fZ5cPhBfOQBChlOFmLt6fFma5ESGb1stCxIIUlNDex93/aA/y1gD4PNChlGrW0EmeA4GL5qtGCZ1WkYWbkJh0teWv8C/FRACKQAln2Anxpz5Fp1jMEIcrfGUIp62AxVxpZMeyr/5SihdItFdC2LaGrj/RNsFs5fiZCZ3BRkJpGaESrRf/Yt+S255yvBb3o2ykwbUMb+rvr03zv/5XEJP+0eag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVbGVNDBAYPhCmv1H9CSQSGGLJzcaxbA2tqZpomoUjE=;
 b=y3FSBhTwYm5l/mvqzk6PHV/l41nA6taYK30oBhXlcS/ZCXk7gfR8PW9iTyQlDmDD5mKKSS7uwOnZnoZbpl21a5NgaNZ2YszDhm3yCLVi+t2tjd4SXBJBXFH88Y1PqTEvajAl2Vr7RIQv3IZ5LaYDo8jHi+NsaCa8N+HaKgJ1K4E=
Received: from DS7PR10MB4944.namprd10.prod.outlook.com (2603:10b6:5:38d::15)
 by CH3PR10MB7356.namprd10.prod.outlook.com (2603:10b6:610:130::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 02:52:12 +0000
Received: from DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5]) by DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5%3]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 02:52:12 +0000
From: Joe Jin <joe.jin@oracle.com>
To: Karel Zak <kzak@redhat.com>, Zhenwei Pi <pizhenwei@bytedance.com>,
        Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org, Joe Jin <joe.jin@oracle.com>
Subject: [RFC PATCH 2/2] irqtop: add filter support
Date: Thu,  6 Mar 2025 18:52:01 -0800
Message-Id: <20250307025201.92541-3-joe.jin@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250307025201.92541-1-joe.jin@oracle.com>
References: <20250307025201.92541-1-joe.jin@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0961.namprd03.prod.outlook.com
 (2603:10b6:408:109::6) To DS7PR10MB4944.namprd10.prod.outlook.com
 (2603:10b6:5:38d::15)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4944:EE_|CH3PR10MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c4dc7a-038f-44c6-e692-08dd5d230f81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+GlUbYp4L2RGzZ67AuZL2dWXj3M0Mcr5orvxOvVagWWxH29uYrQgEkpVEsxA?=
 =?us-ascii?Q?VHtC8pD1Rmr8fBYmSxTluGXzzXskWLDnjM0GygR16OrvqDxQ76vkmZtzKGYp?=
 =?us-ascii?Q?jvmhdPjJFmPFQ89BzqJZMb3Xzw+ermlnJBwvKkqpEw+NtQumXS8cS3jL3FkH?=
 =?us-ascii?Q?tanbEhVu8uWnpgYdj1XIxIGSh8LFlgEaz3xGZxH9qbOvnHIsR437bG+WfChk?=
 =?us-ascii?Q?1s1ruuYV+DxxszWjy4CaRFbZTMkH5nsxVfU6I2U2w2EN3J5Hbuh3xsooc8tl?=
 =?us-ascii?Q?V5wVWyE/PaTMGcJsyVbnLgdz4ql5K6KNWBZUsq7WzDpNF2a6RmBkO3zpH4Qc?=
 =?us-ascii?Q?jZZc4ZDGj2gssMr75ye1mQTwi7wdDC/EYYdp7VeHCSAT1kvdup3V2W7MDDT5?=
 =?us-ascii?Q?82pL7RxLXoFWmVdNaL+NwcHMdeYwAvWZcEVFm+/0rapVonuFXyBr9X8An1RG?=
 =?us-ascii?Q?yt+kCGH7SdM4T5d+6nV5JRzRdTX8ZzlV/xvCL0KVAe7blvTS+oYtyrEwCsco?=
 =?us-ascii?Q?inm3Ggq2eeuK49izToBZkisa8AmmllN0bBUZPDmgGUxmGgGj0Hlly87VNU2v?=
 =?us-ascii?Q?EVauzLUb0keUYydbwl3WQxUCoSe+jOFTJXVsPJaleHQSp5Jx9+kMd2ks/jle?=
 =?us-ascii?Q?z+k2dG6QmreEUpLhXl3Ugf2tBEEEu5XIi4HK4EQeA4Cd8S5q57Y7kqBJBEct?=
 =?us-ascii?Q?P1jQYjV8WJKRskMfMB2FHimmi7AiwU5Pg1zdsYCCPs3c870FOCYwJYl9Xavv?=
 =?us-ascii?Q?JQ1gYrBwS9qcpIGS2+J922ynXa9TmMjFmqFIusFwNTPEbwWpyRVPgI7Vd3Ih?=
 =?us-ascii?Q?pqE2oKycgl+BIYUW05UiwUgnpuY0c3M0POIPgy32efI8AQJd8d3BusiRriEo?=
 =?us-ascii?Q?0izsLoRw5jdPlM3EqCN5i75t6Z5xurkc09SxJ/pq6FFa3bWPVSibDJk9tk8j?=
 =?us-ascii?Q?NUHQIe9jwDdV4MN7nehNAL0ETTIUUHdGkINJqiufIZSJLFPbWltDYlubDBdI?=
 =?us-ascii?Q?vP90lvV2fZWbAjieZa5P2m7MNXcgC0goet5FoAVh+r4hAbKjRz0MJyEvruWk?=
 =?us-ascii?Q?uy9tdaa9jy4A63P9FLZR4URyYjymDeqayTfyRHquyYgkoR2bfeFnzWrLBnOl?=
 =?us-ascii?Q?5sG3WDtkfIuMNFUTmlrzYEIu3IzvAsttutQDjFbsEosVSHjfWMYyk/Nzzi5h?=
 =?us-ascii?Q?GHj25/0KZNoc2TOmVQvvZJiA2xV1FhBBaRsh5rDHAsCUPR5xlbn9rUNUfIq/?=
 =?us-ascii?Q?5xWVAh0MmfhsWK87ZTMpbYZ3IL3LRAjzwqX3F/mSp9dLQRmKQ0sOhtRUoRg7?=
 =?us-ascii?Q?tO6MrS1G4ZM7nssrb+8IYUlyax8KDfyTBjzKldeFZIQ7OJ/4rOvLWLLPY7R4?=
 =?us-ascii?Q?7gkNTCDUloY2YIiurg/St/qQx0vk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4944.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CQYUC3nPd/OKi3u+bGbspeydBjWwj11c9vgaSS2/7yTldzlPzQjVX8gQXYqY?=
 =?us-ascii?Q?PK9MWXyZ1Giik/s9b3oC5/8WR8rjMN5zdjK8+nV+HJ7TQEXYK5gMgtritqkQ?=
 =?us-ascii?Q?GvcoveuK9AgtWanzbvYtSWvnsrljRf9DThhZDyiXBbMrHpy0UTi7jYGyC5Ml?=
 =?us-ascii?Q?fQS2LyEEr/BlqhabeaZGa0dqHs+OzgtDB+NzHQHFiEAae3L6bkpDlXhfs1Gx?=
 =?us-ascii?Q?Rh4eeHM9qv60YkVfnV02K5PorYsU7uWgoincd0w3VGFUHCGBSroidscn2K3H?=
 =?us-ascii?Q?4Z/g5EVVTeC95+DeOlrn/fMOqgZOi2PIRi1X5HlhBAE3Y90VtZpMkoflK/nm?=
 =?us-ascii?Q?subNl+CuzNL3VBwhHjFOlRd7ZwczA7XC4Ntb3gFTlZWOf8DD++f3CvCyGQ3E?=
 =?us-ascii?Q?jiCKTgQeOWbhD+ydw91ILWZofPjjDvbs2AuuXUWWEK55DoUgzfQ88t2DZxnI?=
 =?us-ascii?Q?kB5it8+kZ6BXq0EaOZWBPYd8k5cktP422mMY1gDEmNRBhOWG0tPr5Lujr0om?=
 =?us-ascii?Q?vA0vG8PZptBmNCwLyZJIwqfwzyljzbM/6IjVG+LIIXGOOIix2sAnqSor1HWF?=
 =?us-ascii?Q?rynWNQz4lsmKdo5apHdz1o9oYcrX4Dxiz2Cnul4TIoAj3eBEGcRedMLmbSA7?=
 =?us-ascii?Q?QZq25+aKwJtXkdNSoPcRo3twE5PgLWM6ybU9yaJv/MQUALq62yRnOjqtt44P?=
 =?us-ascii?Q?gO2OgVdJ/KDyQkQbl+O+SyrAL+uyMreS3ig/2+RCse22aNR1P8igBHxJUv7l?=
 =?us-ascii?Q?jYmCHPgACc2dOdrI6o5AndAf27bJIuXvgFG5mEVGtsg5AN3+XP9CiW+J024z?=
 =?us-ascii?Q?2W4r9xMwgnfZWs/MIVcTKj7RlRDejecvRWOIGCoRNeS0eQrWMi2Y4vOd5qhH?=
 =?us-ascii?Q?J5o/gu/6McUEeSPJtiQqwEEIsGoELCi2fPeYCS2JWZzUGHAkbFuj9buWioKr?=
 =?us-ascii?Q?4QErSCcJEaU5/0amQN/ovN5Do2E2BJdM4qgMJ90DHaFdcEgKs4kjr/A4l4cB?=
 =?us-ascii?Q?lmX676LonFCFtk+JO/DCyFAy3VQiOwjEd5cFrDqziYrtSE9ao1U2R5RZvKmp?=
 =?us-ascii?Q?e84qtv6y5Ho2lIeg05NxZbV0im5ZHIi5pFD/R9Wvh6LlesKBDU+wXNLTnf42?=
 =?us-ascii?Q?HY3rVNhtp4ek/4Rda0NZLRXj0sQUtFso+f5hyVUWsB62NlgsSygjDuXvek64?=
 =?us-ascii?Q?bv6O91dZvPzaxVyK6fBjL/MSvhPjYB/QZm+jjM1G81T3DMs4b28N9M8/W1iM?=
 =?us-ascii?Q?lJhOBPK8ZZrYoPq7BAyVa4Pmbp6WjkyvXjjpRPqcnfpOjlDq0AHrle7nhN+0?=
 =?us-ascii?Q?8GuHDfg8iTltPRxzQ3lfURGV9azsXjKl1F2Gp7Z595pU4UDqAPhSlFNBChGy?=
 =?us-ascii?Q?AvThOaMzxr0W7T/V0/VE9k5rorD5agfMQPqPY9NRT2rgIIdnH5hI3AVMCtlC?=
 =?us-ascii?Q?W18+yDkvXysnmZiD5rnfcxFqZBPFBbjrkhBwhLu3cFTJzunwyt6htFaPHG+f?=
 =?us-ascii?Q?ujy4iqbVTl4gLC2ji65K3PWFfht+mqSPh/ky+/1PqaKZ5E9eJelAkM3firZV?=
 =?us-ascii?Q?Q1FLzoxQ3DAaeNS2/jQl7ypG5L2rGNjdrBB03rMT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LN9HwVArLI+OLqb98QIPck2WAhgs36eLnThravz7mKk03zWNrpet5gwLDL/hLsFJaxjbw1zLmqlq9JAZYL3F9tWXt5dfUFsWEsKIHrZJtft2oI5lerKPrXq2KcADgg0frr88A+ZfxLFr+xhJvKAbMp/FCbg0rAPd8adAtcdTiRt3e3Z9LS+ewUd03HmmSpRM2Y5C66Ga8quIBLd7hNZv3YgD6zSWdI5USVmQrB1cXCyAqn5dK6UhlwJJGuVG1yt789s6ixv2duQB7pedyhRRRvUOf40MVrFFxGfl3vokdmGKMM37xwrPqZmtQikCfENKK0o2EGLz+mX3ELN8hp3zofgwkRda9wdMOmTWDGnIbkts6dnksKbDVtELVn1cc1UEqgvUk7CKgYCpqITDFf0R7pNvWnYai2qftnMtOAzo4SaTrTILdhiqpE4UQlOd8bgmA1bVMpxlJh9DLPzOo2I5mhl9BAX/YCxuLix56VwIJzxpFg/VQXZVpuuNq0M4WOvp0dwqWc+f+QQSFq6DVpdPoesQE/FgeaWSApOybk4d8ijeMJ59oCvI/cKpRACTlm5MSVu7MKNl32omv3W03CbnkSt08P19SxbEQJguoWHUTHg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c4dc7a-038f-44c6-e692-08dd5d230f81
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4944.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 02:52:12.3550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Q2r++afJbiMmp108dVHFYn07zXW4omtBetbuI8z1eVfVWYxORongkpS9KhJynyICGq3jii3S1hTaboYlqixZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_01,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2503070017
X-Proofpoint-GUID: Z3xSMBkPbvKhmsDYtjzA4sQ8423W1lat
X-Proofpoint-ORIG-GUID: Z3xSMBkPbvKhmsDYtjzA4sQ8423W1lat

Signed-off-by: Joe Jin <joe.jin@oracle.com>
Cc: Zhenwei Pi <pizhenwei@bytedance.com>
Cc: Sami Kerola <kerolasa@iki.fi>
Cc: Karel Zak <kzak@redhat.com>
---
 sys-utils/irqtop.1.adoc |  4 +++-
 sys-utils/irqtop.c      | 29 +++++++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/sys-utils/irqtop.1.adoc b/sys-utils/irqtop.1.adoc
index 880ee1906..b9962ce1c 100644
--- a/sys-utils/irqtop.1.adoc
+++ b/sys-utils/irqtop.1.adoc
@@ -12,7 +12,7 @@ irqtop - utility to display kernel interrupt information
 
 == SYNOPSIS
 
-*irqtop* [options]
+*irqtop* [options]... [IRQ] [PATTERN] ...
 
 == DESCRIPTION
 
@@ -20,6 +20,8 @@ Display kernel interrupt counter information in *top*(1) style view.
 
 The default output is subject to change. So whenever possible, you should avoid using default outputs in your scripts. Always explicitly define expected columns by using *--output*.
 
+Displays interrupt counter information only for the specified _IRQ_ or for irqnames matching _PATTERN_ when given.
+
 == OPTIONS
 
 *-o*, *--output* _list_::
diff --git a/sys-utils/irqtop.c b/sys-utils/irqtop.c
index dc59f4829..c5deb840b 100644
--- a/sys-utils/irqtop.c
+++ b/sys-utils/irqtop.c
@@ -87,6 +87,8 @@ struct irqtop_ctl {
 	bool	batch;
 	bool	request_exit,
 		softirq;
+
+	char	**filters;
 };
 
 static inline int irqtop_printf(struct irqtop_ctl *ctl, const char *fmt, ...)
@@ -140,7 +142,7 @@ static int update_screen(struct irqtop_ctl *ctl, struct irq_output *out)
 
 	table = get_scols_table(input_file, out, ctl->prev_stat, &stat,
 				ctl->softirq, ctl->threshold, ctl->setsize,
-				ctl->cpuset, NULL);
+				ctl->cpuset, ctl->filters);
 	free(input_file);
 	if (!table) {
 		ctl->request_exit = 1;
@@ -426,6 +428,19 @@ static void parse_args(	struct irqtop_ctl *ctl,
 		}
 	}
 
+	if (optind < argc) {
+		int i;
+		int filters_len;
+
+		filters_len = argc - optind + 1;
+		ctl->filters = (char **)xmalloc(filters_len * sizeof(void *));
+		memset(ctl->filters, 0, filters_len * sizeof(void *));
+
+		for (i = optind; i < argc; i++)
+			ctl->filters[i - optind] = xstrdup(argv[i]);
+		ctl->filters[i - optind] = NULL;
+	}
+
 	/* default */
 	if (!out->ncolumns) {
 		out->columns[out->ncolumns++] = COL_IRQ;
@@ -452,7 +467,8 @@ int main(int argc, char **argv)
 	struct irqtop_ctl ctl = {
 		.timer.it_interval = {3, 0},
 		.timer.it_value = {3, 0},
-		.iter = -1
+		.iter = -1,
+		.filters = NULL
 	};
 
 	setlocale(LC_ALL, "");
@@ -478,6 +494,15 @@ int main(int argc, char **argv)
 	free_irqstat(ctl.prev_stat);
 	free(ctl.hostname);
 	cpuset_free(ctl.cpuset);
+	if (ctl.filters) {
+		char **saved = ctl.filters;
+
+		while(*(ctl.filters)) {
+			free(*(ctl.filters));
+			(ctl.filters)++;
+		}
+		free(saved);
+	}
 
 	if (!ctl.batch) {
 		if (is_tty)
-- 
2.43.5

