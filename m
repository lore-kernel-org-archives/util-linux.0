Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D37D26B2C8
	for <util-linux@vger.kernel.org>; Fri, 28 Feb 2025 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740759255; cv=fail; b=jMTn8u+GlEf7NlPwKjIjVqmH9Wyxu2x28FobP1fg0FQOxfahFO2CxQQECngcg6tkD4gOCnESeiB5Xkphg0TL1qoeWGmAIYGam6a+4sWpT/KgJFpH3Lch01R1fE6Tq/u7Hm3OP/UFMzScfx4wN9NP6cl6DlTmiNhfzAJii163/s0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740759255; c=relaxed/simple;
	bh=jTe1dkuF1QMJueWhA7KWPAgFPuHQOIHhVVXrOwrjnPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mIahJPBLgMoGi+k6MJ0M5HUpR7q7iz9D9U65WKdV8MFho3XF0moXAEIFRc2HpOhRrqlxe6veiedPZsT+NNeT60yhEDI3CH2qVqj0mNQ0fV7JoxW/RxcqeXu9GAMjn8ruHlcQvhwDbKMcAytKi2Q6nR7NhIC8EWasabpxYkM7548=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XFalczxu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZtgJbBrE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XFalczxu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZtgJbBrE"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SEGiiN019600;
	Fri, 28 Feb 2025 16:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=VyMGllM16WjWBDbsE7TXc0RPsBB+wVtNcz77TrAeX1s=; b=
	XFalczxucoDwGoE1h6mHpunvu7SS2e4vM/mSRGcD4pBrJpNTKWAf18VLq58pJNtt
	C0XuDt7cPkdUojUWkWaX+Ol41OlZ5T/WKP+Y2r3eA8zD/c0MzmRRUlLABdF2nvZs
	d6JjkTsKDj/NvlpmEKFXVn+CaVTE9BwvcUNkZUyp7H2VPLOvkFlyqUusJHtF5nn8
	ox+idAiScWEbEi+4kYiqgdpu9gSK629yJ4wAdtMe6yef4KfkvxUq7H8OZdvw/vvt
	a3LUsaocs2TnmtlU46hqhhuWCqfV7q71tWiOiPAgKkqn7W7yfeHt4FhaF+jv3LW+
	o3cvrbiP5xWVh4Rzzqrksg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psdnu7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 16:13:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51SFIZUu025216;
	Fri, 28 Feb 2025 16:13:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51mdtk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 16:13:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VfgWFOjIBVPQxNE7bvgWSjUBwoM6gmDicanMWIZ3ba9PRhht+lcw2xYuLeOCC+56bNN+Xyx+GyIkImqd7JhuvG1a+Rgdj2tcoFvODQxmBOMyhn1QnLORN4t5HNKIpzDOLIiZpMSqq6bUG8+Qp1irWKCkyqiUEWE2XLzTA52zMGqwhCRIuJNeeTFJiD5gM7ejgC06vAPeMiJfLuO0Gg9o4B1IKlf9Ta4iiFJ7VivJIuL2QIF17DxAEQxvE1CTdh+O8xSFs2u7LDhJJ7HODtM1eQrOlFLF/ULh5nphQb1Ump51I443pMXHv2FjP8CfoKZFrzTLUJhp52nqbicrmpbxmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VyMGllM16WjWBDbsE7TXc0RPsBB+wVtNcz77TrAeX1s=;
 b=m0uYXHzl0Dl1pBnN2Pq7r6tlMVw6I+3w2fsIoVRgdZXmpxVw+JtTck5wL0UuXV48+VYC864YFQPJAXPFayiQQrnjEAzIIV77voyfpcNM1AHHVkFIe/zCgtQLYo/CUuPzdAReLEwi2+sCkA2vR04culWx7SYIWezKPyjxrynb8WSwBz4M9fizOuZOUWxOV4PIFQ4d6i9cnLugdBLi0khC30tzJxnUwIM1K67iINDmSlYYC4QtEdAFi54dwWtzgx0uwkdsD2wW2mnsa9yWa0OT/YQQV+ALpRtkc76SOKusVZ4fgfPaZcRQ9A/QfXM2BjkR3oozYXRxCGNsdvs5MSKAMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyMGllM16WjWBDbsE7TXc0RPsBB+wVtNcz77TrAeX1s=;
 b=ZtgJbBrEFpv4yZ4Lh7112kiy3NA4OGJuQB3JozRiwsQmf2lvs6xBKq7ep36DiWTJgf2VPUSiht2TYVQWS+F4gAgAGNCn4h7fKEnx924jc9s+/TevwqjgUGdchKZaASCZhEEZKxSJJsQmCw0xM9Nrcennk54alZCaC5VaheN/V4M=
Received: from DS7PR10MB4944.namprd10.prod.outlook.com (2603:10b6:5:38d::15)
 by SJ0PR10MB5671.namprd10.prod.outlook.com (2603:10b6:a03:3ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 16:13:51 +0000
Received: from DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5]) by DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5%3]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 16:13:51 +0000
From: Joe Jin <joe.jin@oracle.com>
To: Karel Zak <kzak@redhat.com>, Zhenwei Pi <pizhenwei@bytedance.com>,
        Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org, Joe Jin <joe.jin@oracle.com>
Subject: [PATCH V2 1/4] irqtop: add batch mode support
Date: Fri, 28 Feb 2025 08:13:31 -0800
Message-Id: <20250228161334.82987-2-joe.jin@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250228161334.82987-1-joe.jin@oracle.com>
References: <20250228161334.82987-1-joe.jin@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0930.namprd03.prod.outlook.com
 (2603:10b6:408:107::35) To DS7PR10MB4944.namprd10.prod.outlook.com
 (2603:10b6:5:38d::15)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4944:EE_|SJ0PR10MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: 0de76fd8-b700-4426-17f9-08dd5812e3f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?noOoBr+9kngDeVi36AQS3CAsCmF5ljmRaWimwvVzDxxXjQtYbfb05XlcsEuN?=
 =?us-ascii?Q?hUFGkopKI9fDwZA6i+yPQ6IPzFFxuh7a1vRdN22i8Y2HK18TJCIweKR5YeYh?=
 =?us-ascii?Q?yN6eecERDqeFHbr0nIvuZHrovlEncyiHm65A2zBX08lWTp7wrKMF9rZo9xP0?=
 =?us-ascii?Q?iAY4bziylDFH2ZRIhh0BJihl+ZzER4ErojLAYnZhqQfB6YlvL5eqkyo8lA8O?=
 =?us-ascii?Q?wkgd7ZSkUYTtUChadHOUlHoMhA1arQj1tsmvQsALJOieqXH5igEWg0stQkJK?=
 =?us-ascii?Q?NMHZEY5TjCallmfl5X0FhO10cinzsnbWvhAfA0DqFrPPyvGA+XyBWxZEtdF0?=
 =?us-ascii?Q?G1ntQpY+T1eZfmvgs/1JdX0cx2kir2c+ePLR5V+MO+rlA/AcZrM4gTqVlXRh?=
 =?us-ascii?Q?yWpV4OanOq568DmDoZom7ndLxtMKnq2O/R/A3Lltegk9Bz9rsEBX8fGdLk9q?=
 =?us-ascii?Q?Z9xc0WhETbXjQci6WO1b5Nf5z3SIiCLWtu7uFirXZmBiA6PMWU30ibmWQS12?=
 =?us-ascii?Q?abtJhCKRZTAbcB6z+DySfEfp8VsXQ1wGdjkmKo5jK1g98cHdSZnkFuhsV/wh?=
 =?us-ascii?Q?6w77GUUG6OLu/IxnJohqDymtqTp5QsRK+0WUVjBBOlY48ezlwMcrMmFug58X?=
 =?us-ascii?Q?hHeen4H7/yKq8B3ipkjfW1p327iEZ186kscL0WIIWfOQFqPQm40P3h+FV1Xw?=
 =?us-ascii?Q?jOF8xrqX9DhYxrESmJLDkKZIWeRGgh9l1IqPsqAfW9/iLPhN6YheSQSc3AMp?=
 =?us-ascii?Q?/ZpSNKnLj2gQV2UHGbflZ6UQVXVeVPrKWzApnXdpUNrkIEI4rZOHMb/m1Bv3?=
 =?us-ascii?Q?jpA37xLlQk+WXMrMv7yv/Qk/+UMhSTrAIg5CdGDoXcKG/hpK9SVpYOb59kfU?=
 =?us-ascii?Q?pe2Bmn7ErIay69w3WrRsV3PsRkJsKe3xTrQLtNTJ1XLDr+FeD3EeojndSuUX?=
 =?us-ascii?Q?O3fpD3pzskSRHBg3uEI/3NNSHE8C6zwM5PET7v4D3PTu5WsBrQu375JqcMUm?=
 =?us-ascii?Q?mePJDNFKLKPMxB86SbZcV3imhAUFvtWqf9+8PzsMfPq7Z9CqQawKag4/CS0j?=
 =?us-ascii?Q?NDpa/UMXq4gmwQhaLvXjwdrB/g2beEeJMkS6Gn8w4NaE4onbNl5k4tlYj5Yu?=
 =?us-ascii?Q?2sO3hiP5eYTYOShvqpqaP30Y0cJRU3lMoqv06eTExXPVNZ0lx0WKa0Ye+xVF?=
 =?us-ascii?Q?mf5awnoLWGRDNJG7BcZJq8JRNZ2svNp4p7Tm5g4aqlF7iCPs40gaJYAz80ku?=
 =?us-ascii?Q?WHmubQCWAegpArJQIe3ZdFw5OwkYiaL+NPSckO4i45Db63x6tiiwRsJ+bREb?=
 =?us-ascii?Q?whPy0R5EXvpOK3uhBDWQ7QXPc3RTHaBJ7wglXDlUizKVXjiM9Pz0szQM4QEG?=
 =?us-ascii?Q?UVwkDIuyh6t7sSyk++bKaCRDaT9I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4944.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8Ds5nMn1Fn+mibmqp55E3dJY4C3a4Sl+ugoXxUPAWf3tjqYAhZwwxZ6NQkx+?=
 =?us-ascii?Q?j8zJY63P+uUDZe8BI7hSsQAYcknYeZmnLKLBRO5jvRSSwgdwLdfU324bhO/u?=
 =?us-ascii?Q?uscQ2qYvhNCyVUhbV6VW+7jzhSCDU6HYe9zcLyOGtzYoGnvtQ5i9/HaTadLv?=
 =?us-ascii?Q?x4ibdcVVvoFhjzXW0Kx1cpIJMo+Gdegq+pLP00s5lGB/PZaALWHXmi0ecZ97?=
 =?us-ascii?Q?gIIcZEduaq4qgLu31BagfDPj9kREEVefzB2fn9uplgy+WEkcJSOTwpUUXDc7?=
 =?us-ascii?Q?8GWFvLCN3G7QOe3C+VmoQgqU5JH3t2/2DjQzmiI8lACpyfH97LhrkIiHHWp/?=
 =?us-ascii?Q?OrkKEXfxzLIgh4lFWF50e9V2Nb18BJrNmFvuzXsC1ZJh4E61q4Mzv/xY74Zt?=
 =?us-ascii?Q?kPjw58SWolHxOMGDxgyP1JEkSJgRStWE6uwuReGyeKZ2AvEze1Yu/1kxxQqY?=
 =?us-ascii?Q?r0PIxAqy6mu8PdkDG1rcMjOkJZMNp5o5F5J1v/tB3wRMoeJq+XTvE+pfWa4U?=
 =?us-ascii?Q?1xoAT/Bh+yhCPZyOh9nfqMz9eITTD7gVH8FmrHzOnlma5JaiM6foms8E7mnN?=
 =?us-ascii?Q?AbWkcOZu/OZ9y9h0ULNYAbiBz6Aa69yoWBK4NYgE4tXhVEezsPolSJBX1bF4?=
 =?us-ascii?Q?6BaDXcGVTdTfXycF3gDq4YJZIUpm+jpphe0BiutFzkC1l3Wsaxhxraa3/1Wz?=
 =?us-ascii?Q?BDcq85H9PnQ/aTJNuWgHaetvDDqAofLn+OOnr3+g3/YRvYaptXVXCNFb1L0j?=
 =?us-ascii?Q?oY4PyaY1mlRD3/UhqaFK1/R7qZ1cRXGspthvo8rHqNlgLK98YcXH+FeJK0BG?=
 =?us-ascii?Q?wBnQN8Mni+Gm6kQIqRoFxPskdW3Cr5sCQ8vuP5dXogYKm7EmlgFtj7/RXRbt?=
 =?us-ascii?Q?SkcW8AdPBj/EHtL6AyewUlsccQaSOeUXIdM5BVSJn0/NF30OywBvltDZJ8sy?=
 =?us-ascii?Q?RuB2k8f9XvEoKm6w3JRh4ib1zShJyP1NHpKr0SRtyA96goF6QwX2ey6FNRKN?=
 =?us-ascii?Q?icnvEaeiknDQEGb9yt3xtVVykkNBELXJH2RMxubgUdw/75M+JoWw/tc5/i9k?=
 =?us-ascii?Q?kxwrjKgvn9qwi+XAYOw769Qd+52do199GnWABCK5Jj5+Hd3LrurVFwz9wRCe?=
 =?us-ascii?Q?os8jS+EZ451viIkeB7l6h5NOVAvpd9MVTo4XxNRilP3poYgKbml68prr6yMV?=
 =?us-ascii?Q?mg1+xhVYxnneaQIl4nlvQwdL56XrIFbfAXaWC7iOT+tnOkRcTBRZkxmDnzno?=
 =?us-ascii?Q?jNLdTpz/+PjBpWxF28ez0PWmV1bzthVSAGJbraP/tsa67NyEsEK8YCNgF12Q?=
 =?us-ascii?Q?tdHHRbWTmVC5uDbnrZGi81H6gw8gfwPNcxfZu97Ph+Z+8kWz5N0xUafmfkAK?=
 =?us-ascii?Q?le7k0QfJ1MTEQ1M0jnI4U7XE3Lvd5H0f7I4/Lyis8LcLn6VRLl4oYwtVzsg9?=
 =?us-ascii?Q?pDYwcVsnE0zdWFA1bOSYGrsko64Zz9ZzQCzIfcupAUGWkQ9vvd81tj0qDmfq?=
 =?us-ascii?Q?l46FDxNSuU0JhZZkNSWzOVkbvgxi7eU+Q2kG8qEfKe1vcvtw+MLub2rofxSx?=
 =?us-ascii?Q?xOJmxGDY+aL7nbRmNm2loGKGqiZ/JFiFdo5QWB1O?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FV5GZc0q2sXdl990bmbpceyGQIRUimN9rseweC94/296rL/rFWwoIaeTnYOgv8p5Jv08kNmxM9TTrSCm+LJeuHWLE3DRQHCjyAMl1TDRDE/lUcU4ANeJefFQwt13HzcLi5HPh+A1QeO6XbXsBpINHPEv8lW/MaMLGSv/Mvexqkg+trlVqm77pMnyyhYl1bck2ZBkxqgrFruVzXxC8fPlUqmmnNtlmLF0YRp0qtxjzvfOGM90+DiJoVhZKb/sMFtksbZIdqeHWIKebMcrmht2Lqe16dDGYj01iJ3AayqSPp1SSiZRRLXvnAq2cZOm+Ec3gfLwPIk4z2PRJRTDy7et3s309OkuDJLQ8l/7YuxEN6TWppU5G65rTu/wzyHsDKuc1lMY/MRvMFiIN58aapwSmFGCIxjHVVca72mbIqsjvZxawBV/ZYPMGwYjinnXONzqnwqJflfK6gvRnk+0Gk68ScXqgU2cbOVlpKcSMoCBVVBIPhrG37cRE+BUwmBX3twTW9mxiVFspkGSR0DpHmlZiIwPqp5yxgvKbE71P4xJHWy1uKNVwlLfgqhXws9UCjLMGcCiLz56G7bpErZFyXDL5mjUTws73pP02mEKGj8FjPk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de76fd8-b700-4426-17f9-08dd5812e3f6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4944.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 16:13:51.5548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4yYLLrSdtjyiIBqII/6yuiQ3yngDQP3cZyibqIGDNmWisuPFMyYsHm2r22kr67EFvymygDjLpHSQNYABySArXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5671
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_04,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502280118
X-Proofpoint-GUID: aTKhImbU3bYYU61JyLHtbzQKHs_Dc35i
X-Proofpoint-ORIG-GUID: aTKhImbU3bYYU61JyLHtbzQKHs_Dc35i

Add batch mode support, which could be useful for sending output to
other programs or to a file.

Signed-off-by: Joe Jin <joe.jin@oracle.com>
Cc: Zhenwei Pi <pizhenwei@bytedance.com>
Cc: Sami Kerola <kerolasa@iki.fi>
Cc: Karel Zak <kzak@redhat.com>
---
 bash-completion/irqtop  |  6 ++-
 sys-utils/irqtop.1.adoc |  3 ++
 sys-utils/irqtop.c      | 89 ++++++++++++++++++++++++++++++-----------
 3 files changed, 73 insertions(+), 25 deletions(-)

diff --git a/bash-completion/irqtop b/bash-completion/irqtop
index b9e454d4c..215281ee8 100644
--- a/bash-completion/irqtop
+++ b/bash-completion/irqtop
@@ -5,6 +5,9 @@ _irqtop_module()
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $prev in
+		'-b'|'--batch')
+			return 0
+			;;
 		'-c'|'--cpu-stat')
 			COMPREPLY=( $(compgen -W "auto enable disable" -- $cur) )
 			return 0
@@ -40,7 +43,8 @@ _irqtop_module()
 			return 0
 			;;
 	esac
-	OPTS="	--cpu-stat
+	OPTS="	--batch
+		--cpu-stat
 		--cpu-list
 		--delay
 		--sort
diff --git a/sys-utils/irqtop.1.adoc b/sys-utils/irqtop.1.adoc
index 443e23b84..e81f4fbb6 100644
--- a/sys-utils/irqtop.1.adoc
+++ b/sys-utils/irqtop.1.adoc
@@ -25,6 +25,9 @@ The default output is subject to change. So whenever possible, you should avoid
 *-o*, *--output* _list_::
 Specify which output columns to print. Use *--help* to get a list of all supported columns. The default list of columns may be extended if list is specified in the format _+list_.
 
+*-b*, *--batch*::
+Starts irqtop in batch mode, which could be useful for sending output to other programs or to a file.
+
 *-c*, *--cpu-stat* _mode_::
 Show per-cpu statistics by specified mode. Available modes are: *auto*, *enable*, *disable*. The default option *auto* detects the width of window, then shows the per-cpu statistics if the width of window is large enough to show a full line of statistics.
 
diff --git a/sys-utils/irqtop.c b/sys-utils/irqtop.c
index 8fbedb16a..81a137be0 100644
--- a/sys-utils/irqtop.c
+++ b/sys-utils/irqtop.c
@@ -83,10 +83,32 @@ struct irqtop_ctl {
 	cpu_set_t *cpuset;
 
 	enum irqtop_cpustat_mode cpustat_mode;
+	bool	batch;
 	bool	request_exit,
 		softirq;
 };
 
+static inline int irqtop_printf(struct irqtop_ctl *ctl, const char *fmt, ...)
+{
+	int ret = 0;
+	va_list args;
+
+	if (!ctl)
+		return -1;
+
+	va_start(args, fmt);
+	if (ctl->batch)
+		ret = vprintf(fmt, args);
+	else
+		ret = vw_printw(ctl->win, fmt, args);
+	va_end(args);
+
+	if (!ctl->batch && ret == OK)
+		wrefresh(ctl->win);
+
+	return ret;
+}
+
 /* user's input parser */
 static void parse_input(struct irqtop_ctl *ctl, struct irq_output *out, char c)
 {
@@ -128,16 +150,19 @@ static int update_screen(struct irqtop_ctl *ctl, struct irq_output *out)
 			scols_table_enable_nowrap(cpus, 1);
 	}
 
-	/* print header */
-	move(0, 0);
 	strtime_iso(&now, ISO_TIMESTAMP, timestr, sizeof(timestr));
-	wprintw(ctl->win, _("irqtop | total: %ld delta: %ld | %s | %s\n\n"),
+	if (!ctl->batch)
+		move(0, 0);
+
+	/* print header */
+	irqtop_printf(ctl, _("irqtop | total: %ld delta: %ld | %s | %s\n\n"),
 			   stat->total_irq, stat->delta_irq, ctl->hostname, timestr);
 
+
 	/* print cpus table or not by -c option */
 	if (cpus) {
 		scols_print_table_to_string(cpus, &data);
-		wprintw(ctl->win, "%s\n\n", data);
+		irqtop_printf(ctl, "%s\n\n", data);
 		free(data);
 	}
 
@@ -149,13 +174,15 @@ static int update_screen(struct irqtop_ctl *ctl, struct irq_output *out)
 	if (p) {
 		/* print header in reverse mode */
 		*p = '\0';
-		attron(A_REVERSE);
-		wprintw(ctl->win, "%s\n", data);
-		attroff(A_REVERSE);
+		if (!ctl->batch)
+			attron(A_REVERSE);
+		irqtop_printf(ctl, "%s\n", data);
+		if (!ctl->batch)
+			attroff(A_REVERSE);
 		data = p + 1;
 	}
 
-	wprintw(ctl->win, "%s", data);
+	irqtop_printf(ctl, "%s\n\n", data);
 	free(data0);
 
 	/* clean up */
@@ -212,7 +239,8 @@ static int event_loop(struct irqtop_ctl *ctl, struct irq_output *out)
 		err(EXIT_FAILURE, _("epoll_ctl failed"));
 
 	retval |= update_screen(ctl, out);
-	refresh();
+	if (!ctl->batch)
+		refresh();
 
 	while (!ctl->request_exit) {
 		const ssize_t nr_events = epoll_wait(efd, events, MAX_EVENTS, -1);
@@ -227,10 +255,12 @@ static int event_loop(struct irqtop_ctl *ctl, struct irq_output *out)
 					continue;
 				}
 				if (siginfo.ssi_signo == SIGWINCH) {
-					get_terminal_dimension(&ctl->cols, &ctl->rows);
+					if (!ctl->batch) {
+						get_terminal_dimension(&ctl->cols, &ctl->rows);
 #if HAVE_RESIZETERM
-					resizeterm(ctl->rows, ctl->cols);
+						resizeterm(ctl->rows, ctl->cols);
 #endif
+					}
 				}
 				else {
 					ctl->request_exit = 1;
@@ -245,7 +275,8 @@ static int event_loop(struct irqtop_ctl *ctl, struct irq_output *out)
 			} else
 				abort();
 			retval |= update_screen(ctl, out);
-			refresh();
+			if (!ctl->batch)
+				refresh();
 		}
 	}
 	return retval;
@@ -260,6 +291,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	puts(_("Interactive utility to display kernel interrupt information."));
 
 	fputs(USAGE_OPTIONS, stdout);
+	fputs(_(" -b, --batch batch mode\n"), stdout);
 	fputs(_(" -c, --cpu-stat <mode> show per-cpu stat (auto, enable, disable)\n"), stdout);
 	fputs(_(" -C, --cpu-list <list> specify cpus in list format\n"), stdout);
 	fputs(_(" -d, --delay <secs>   delay updates\n"), stdout);
@@ -291,6 +323,7 @@ static void parse_args(	struct irqtop_ctl *ctl,
 {
 	const char *outarg = NULL;
 	static const struct option longopts[] = {
+		{"batch", no_argument, NULL, 'b'},
 		{"cpu-stat", required_argument, NULL, 'c'},
 		{"cpu-list", required_argument, NULL, 'C'},
 		{"delay", required_argument, NULL, 'd'},
@@ -304,8 +337,11 @@ static void parse_args(	struct irqtop_ctl *ctl,
 	};
 	int o;
 
-	while ((o = getopt_long(argc, argv, "c:C:d:o:s:St:hV", longopts, NULL)) != -1) {
+	while ((o = getopt_long(argc, argv, "bc:C:d:o:s:St:hV", longopts, NULL)) != -1) {
 		switch (o) {
+		case 'b':
+			ctl->batch = 1;
+			break;
 		case 'c':
 			if (!strcmp(optarg, "auto"))
 				ctl->cpustat_mode = IRQTOP_CPUSTAT_AUTO;
@@ -394,16 +430,18 @@ int main(int argc, char **argv)
 
 	parse_args(&ctl, &out, argc, argv);
 
-	is_tty = isatty(STDIN_FILENO);
-	if (is_tty && tcgetattr(STDIN_FILENO, &saved_tty) == -1)
-		fputs(_("terminal setting retrieval"), stdout);
+	if (!ctl.batch) {
+		is_tty = isatty(STDIN_FILENO);
+		if (is_tty && tcgetattr(STDIN_FILENO, &saved_tty) == -1)
+			fputs(_("terminal setting retrieval"), stdout);
 
-	ctl.win = initscr();
-	get_terminal_dimension(&ctl.cols, &ctl.rows);
+		ctl.win = initscr();
+		get_terminal_dimension(&ctl.cols, &ctl.rows);
 #if HAVE_RESIZETERM
-	resizeterm(ctl.rows, ctl.cols);
+		resizeterm(ctl.rows, ctl.cols);
 #endif
-	curs_set(0);
+		curs_set(0);
+	}
 
 	ctl.hostname = xgethostname();
 	event_loop(&ctl, &out);
@@ -412,10 +450,13 @@ int main(int argc, char **argv)
 	free(ctl.hostname);
 	cpuset_free(ctl.cpuset);
 
-	if (is_tty)
-		tcsetattr(STDIN_FILENO, TCSAFLUSH, &saved_tty);
-	delwin(ctl.win);
-	endwin();
+	if (!ctl.batch) {
+		if (is_tty)
+			tcsetattr(STDIN_FILENO, TCSAFLUSH, &saved_tty);
+
+		delwin(ctl.win);
+		endwin();
+	}
 
 	return EXIT_SUCCESS;
 }
-- 
2.43.5

