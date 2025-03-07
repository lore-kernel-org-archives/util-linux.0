Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EE3188735
	for <util-linux@vger.kernel.org>; Fri,  7 Mar 2025 02:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741315959; cv=fail; b=l4/A93zMa/0NAYB/6ZczVZfJzhtC8rMA+14lPozVM1XVbAuNqISEXHIhQ80K+TQfj7t6UkXoGddSSB1otg7MnvOW7zWzgqicUes4T/8T9CP3b0OACnrXEmdn0LYCIzBW0rSY4qMyKtpV0AQIdDEz4v1Tx6F9T5Lr9Pg79tlXMa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741315959; c=relaxed/simple;
	bh=156juf3ny4GHOYG/29p7ys4cDfbcGHXG6eIbK5jwamQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JrdTG5Hbc+EuvqhKDBCvlDrLRAAa9VKKhKv1BkaCG3oLWdmhKSQrrDKWFe0rUDYjfBHPmp8yHSCPtcJFSS/CdwrhqQs1w0E15iGMjrvdIRl34s6A3RhsozmrU7IRxUAu64xCYYkgNp6ZsBFSf8jvc7It+lstiSqkttCUE0dfHEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C/D8VBCE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=btqQYgvD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C/D8VBCE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="btqQYgvD"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5271uqsc030353;
	Fri, 7 Mar 2025 02:52:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=7bq+/AcUlResZJW7anM69wWk6aZoKUXF+uRIPpjR7qk=; b=
	C/D8VBCEgYIWHd5FIPcBL5nBGPm0J1yoEJ1772POHQOfN22XYYgaTyy59InGBMT/
	uGqldnF62VTwsxYsokSklKc4ein8XxawjBq/b7wO32Th7vzv172YkGVU7N0nAUYl
	Px8vJFhTXfNYndMbgrKIhGBxhfmcHgpEOkcespLgouBWLUNGfNUsZdt0GBbN1dbv
	ni9xb+HtV5S+WFScDYw1YD3yNi4jzsBQ2g6d5YEX+ltRHpvM76cHbaA4Bk8fe+4e
	gFPNyiL+5j0VP/Slof6+ZtCzjpMzcTcPQPflUecN5M1o/oNIYjRvga3o/PlUTIiD
	ck49eyb9txlRDcB4OBp7rQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453uaw3cws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 02:52:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5270V0g7000516;
	Fri, 7 Mar 2025 02:52:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpk8g68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 02:52:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xSdEPv5M4WwLYPssOEwioRCOvh3Zg0ZXhkzDe88Z/g6eod+7dyqZx35wI2X3vb/18a6vop6QN4jJiNCTR7xUL0wzAzY74uGPDcVdobCh/1oMIEDG9dXOQmDD7vxyAlYp6DVgWr3gKWvTnf4aZygzY2askN01LNznGj/w07xI7EjxdPcGfs2ZvvOaoZHL6tLDgHFHuSJdiajYDJ30DkWPy+QnAUkQqZjWrJz7xUV6l8f7LQPe1lg+j9xaYzTrZ42eJ38sTbeaitsJO4G58dRyYdgqXdZyPwv+tjnuvT9CISvYyOyg6+/4JaeyuAICCHtF8/9+F3emTP+NO+P4ZwCqrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bq+/AcUlResZJW7anM69wWk6aZoKUXF+uRIPpjR7qk=;
 b=T4cEg9D8R9fozGbjB8XqcAIR+qAuEW2Bn5VDtq4HKU4t7SF7bQ+NY5/6kHw1HhotWHraSrrraom8L98I3fvTGpk8IXgVFSnt9MIijrIkLtIxiQcozkkqANMA0CocNqAzrwTfasVUn+HBm7W1h/5tgkynFNZkyBAxKsaYmA4UWjCY3q8QUJRcHEFDyKNZj+EKeeuvIQpElGkJyTPGFoo27R45R8Ky+iWvMusdqIaJuf4tXKFbp4QVBJRqb90lZ4E8PZYBOO/s9bzCFBH87FRFHYdTJNxXxX+SE7IXyXsSxM0V/+m+I7gvnXUiYpXJTgWhWFZbmgNr+2tIhZMshTdyWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bq+/AcUlResZJW7anM69wWk6aZoKUXF+uRIPpjR7qk=;
 b=btqQYgvDXqV3NOpsaWpVCpVoSBCh20zb7o+aFXi31v1oLmiNnjEFCJRS1JGMqIRV3xs6nsMASVd1xNzNzbLl9xGEbtOhscsBua1SZal+HjsIRel95va28/1h/ypmD/dlPTgmTl/llY+zFw5UpW8WeXUJqlbKmLdx/V7rc97HirI=
Received: from DS7PR10MB4944.namprd10.prod.outlook.com (2603:10b6:5:38d::15)
 by CH3PR10MB7356.namprd10.prod.outlook.com (2603:10b6:610:130::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 02:52:10 +0000
Received: from DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5]) by DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5%3]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 02:52:09 +0000
From: Joe Jin <joe.jin@oracle.com>
To: Karel Zak <kzak@redhat.com>, Zhenwei Pi <pizhenwei@bytedance.com>,
        Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org, Joe Jin <joe.jin@oracle.com>
Subject: [RFC PATCH 1/2] lsirq: add filter support
Date: Thu,  6 Mar 2025 18:52:00 -0800
Message-Id: <20250307025201.92541-2-joe.jin@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250307025201.92541-1-joe.jin@oracle.com>
References: <20250307025201.92541-1-joe.jin@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0963.namprd03.prod.outlook.com
 (2603:10b6:408:109::8) To DS7PR10MB4944.namprd10.prod.outlook.com
 (2603:10b6:5:38d::15)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4944:EE_|CH3PR10MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: 64c4452b-c207-4980-afe5-08dd5d230da3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S1w5BIDXRLEIeNbtqIYMIwdiulUrJ5h0viLMDFzXLYQJ6JYekwuyBYzMuBoU?=
 =?us-ascii?Q?CqSzMPj9XDaUWnl+2J5UTYugiNqm0UQt0K6umQEikX7xfhDwrnh139i3bET/?=
 =?us-ascii?Q?yXq3d3b6JijKLwre94y09cZERhxIheSCEcsZoC818rzCXN6IBVCy8Jj1ddCu?=
 =?us-ascii?Q?i6iuDPADEJV9Hv33RfRaQM4k19kJydOEX/yG99iiMXqoIWhylNH86B8sjxRU?=
 =?us-ascii?Q?oulYipoDKywrYwvdI2k/2Owsrp/bNBsOATt5kDyqFSwEHllCzx98/UOGfu15?=
 =?us-ascii?Q?lD+4KYG7Ed5K/X45Rf5MeV6A+but1/SBfs5J/v3x32pxEMFiPYfIsk4Moha0?=
 =?us-ascii?Q?5a50rxEj93RDy4p6qwYhT7SER3cbpT/lssncgCnKdw+ZYbIxuEqZKdgKIqP6?=
 =?us-ascii?Q?YZ2Sz6Xz4siNQDo40e+e/7FisRziYgeNPkhX+jWWmbxQ9kjTIEi2VSm4vZcp?=
 =?us-ascii?Q?H+KvCsPpdQlStziUwbSX0c6ucSMxUKUuwBsrxghRGYXmD8qRjGXVF7kkuni1?=
 =?us-ascii?Q?NkkJWWYLkUdRTJJvT6eEnDfva7l076iWW135g5SZitqoCKF1jybImp9g2HSi?=
 =?us-ascii?Q?xuJ4Y+SPLsH58i0o0tdhDgOZcJph8YPA9wUWOlKQcLOtlNows6oJ6phe9tSA?=
 =?us-ascii?Q?afjKEbfV3NuvCymbkSNq0k5jcqS6NIx0R8y2cTCrI8KengGrZP0kd791sxRL?=
 =?us-ascii?Q?y6LjbsX4ge/zQm4xKz035A6UR9vfj+N9wQ9kHhn+d+Fcu6n5UGrNu7w1e5Hq?=
 =?us-ascii?Q?JYbgDaevwSwy8l2wt3e7eeWaFJ+tci8WHqO+wlCI3UcqArPlyuqq/5nF7cGA?=
 =?us-ascii?Q?XeHGRlnLB0Gw5/dQJhllmISEWnZqmeDK6QLy2mt4ZpvnA59mjr0GBZOI1kBe?=
 =?us-ascii?Q?VX3rP9JyQCRQgBxbLfNWrilrFJfQO3motrFVCVjhugs71YUYVrNjdz/bakUn?=
 =?us-ascii?Q?I5BhQ7ejO4CRGqMMPCpr6xkZBsOFstO0IL1OO3VZ+j2NGaJqZ6go7F32d/XN?=
 =?us-ascii?Q?9jas9SohkGnHLpBKE4Z86xx1xUGLojfA499G9tvqhCF1mBZEzY9yQTmg96Qe?=
 =?us-ascii?Q?Du6tUYdE50e503XCruNl2BvGWtwEmv5iUNgdLl960zaNdcMTyO/x9adeh/1s?=
 =?us-ascii?Q?aWuAlViyQKt5Bqq3B04YmC40QR/bOEmQpbX+M3+QjWJ1AXKu/zGk/jj5qFbI?=
 =?us-ascii?Q?k38TxxILoyN0A8NLYPazmVEVMWPAwbnApeKOfF1MFM0bLVFUr0smWu7jDwFv?=
 =?us-ascii?Q?ghNeksewl/Y1SS9LpzuXnqLRgC04o+avrZWGzI2RRpCDXr+Nd6bieTE577EB?=
 =?us-ascii?Q?ESuKZFypZ+GKOU6pKqmH70llv1Bgp4zNorWpbxt2CtLsR4bvRw+DOPFWnuXI?=
 =?us-ascii?Q?ZlFIrr9fNYGydoIBTM/gsQ7PpimC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4944.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U46a4xNFs6WyBg903PW32y9b3Fr1qTcgOrG/uaQo/qkmf6WEHQrRgDQUimkN?=
 =?us-ascii?Q?q9y4dF7A2uySwHKq6PjRjTOjilu9uBjHOFXvouvLO8Ta4WaIVV5lrcOuwKfd?=
 =?us-ascii?Q?IIjMHA/wVrwFxbwFpwu+CQtqaAhinWcuPBLQJR4Van0antYkaySkOV26nmjx?=
 =?us-ascii?Q?nvIsG9Tl0CTEeP/y4kvnJl3t95QjLSYa/I3neDSJTL6wt/Ykcpm9+L54il3R?=
 =?us-ascii?Q?6M3isTGhbW31lkbL1s8rY5TYd3HgNukL+wJpId+qvRJnyK9lTAhn/wg43mPl?=
 =?us-ascii?Q?1Vsblw1sF3s2wZxVgVdYGgCOEMu9/VEa712lFEMdeaNTKbqolIrwCzzVV/6q?=
 =?us-ascii?Q?l1MZIgdLrBRIY3YY6Y05SkHvQXUhy9VIEEu6a9uw/wpPuHmM62StRuDlcp14?=
 =?us-ascii?Q?epkqmLaqyxFS1/GlcCDay2DVLf4kR/Tcby/irIJP1Jp48PltsKV6PAF26is3?=
 =?us-ascii?Q?Wnxj0NxPesWAGO1QTKOfy8Qs///5oABOwNzJb1cvrEwXDvJp32U9OU2QARvv?=
 =?us-ascii?Q?01NSa4BL3jfgXnSZ50aS5oBJ91RyLDyY4npZNWICTK97QaikDy0gmSPwkAx1?=
 =?us-ascii?Q?XIOp64S5G3woU05g8diT8VF3ZcHcyJJS9j+YWTwqL3nvkAkCli6nbBjn9Z/V?=
 =?us-ascii?Q?v1bMrwYP7RBcl/VY10GK09TqoOrhR35nPKMJeT9C8sQVcT62HG1R5BlDFqz9?=
 =?us-ascii?Q?V2+zj13uQ7YEAumBg5GTdPHCGhzoPsNidiIIc1//yqMO25ljzvPTNSnPK+12?=
 =?us-ascii?Q?Bwr2ixh2R5k3PjyYpZC3wX3mRA7BlY0S5yrB/OwkJOUTXVxJ8tlyVvvDCY3L?=
 =?us-ascii?Q?4bN8+Vn0mHxitkSB7yGVahsizK29H/ff9q9SKbsO/9eGizur2gug0/tXUUS6?=
 =?us-ascii?Q?VsDYQmLmNgCcQCKHzahjtcDZZtgu9ZTabnsM+7S1yCgDkHlGraRfuzAUGOo7?=
 =?us-ascii?Q?/pEe+ocPdsr6Xl53Kn5c9jl8y78aiFoHQNTeX737HC8ZzATob6MeJGTPEQyc?=
 =?us-ascii?Q?NnMO4yqOLS3Xhk7B3GPOGxJ0ZxHz55yMkn+wX/tcihlziyzc/sxV2NoRJhs4?=
 =?us-ascii?Q?0lGAKSdM3sPSliF9cJYLjKBDgO+5e/rNNcYvoSoDJ0UiQGrWClkLtIT1LMUl?=
 =?us-ascii?Q?X4kScYYWo84ApbBfNbXNSEr4jtBkDhWM834khwMEYA0HXCGWDpPiqr7dZOhY?=
 =?us-ascii?Q?HflXjEqLzJSg1hjI03CzIF2MGRo9UaTy8yFd8y+TU4gT5mBU1H9qc5FbLaGU?=
 =?us-ascii?Q?cvym8fYL2KXSwO4MveJWYfziybp5VyhF8D3132C60dmfHX9K5/OST7K8z6S1?=
 =?us-ascii?Q?hOf7QClQKUGoACefuO2StSfwnsQ32BNPKw1Mx7qiHuMk2SYnvQ0Nj7/UWvZz?=
 =?us-ascii?Q?5aArYMG2kBrHYzzXcn2zwodkKnajbbCGIauCfUWscyM1pLMT1b/tQxCpQ/wU?=
 =?us-ascii?Q?nxvERdIJ+PddU9LJBB1EWJNDnRehAvX3UZadgwH4O5PLm1XsAKQ7+1ouJXkT?=
 =?us-ascii?Q?YDOh+4Qd5Il9zV0q5Gu8So+e3+AfbfUUNXtx0RxDppaUDwt3Xn5QC/jA3J7N?=
 =?us-ascii?Q?RS/diRCC9i8geNqS4szU3kfZHnJN6zsfiyGyl5Gk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0AdhAjQY71fZV3sH11vHxqgjmps+6tRMjPExiYYjivZhv0Jh06JChak2s48yYH6bsMKnq0w6pMZJNfjw4Ir3rPPtnFc+D6idRJFO+3TNHP9NKsYO28gCiBrlgoi6rB0u7jhvsI+K+iTfxO1EoDrkKy4Uyf3P/EBJZu9bhyJvPjw4iGWSaVHLVL1kHW7yVibxFZUyY+5L7sy2h21Qkh24mNJD8RzhlxI4D1bsq/xUapPxFsPTzEAIeWagXsggv2z8cC1dkGLFJV8rBcOEj6hu49m08XBoL7Bn+3G8onXI+KhjW5iHGcu/+uwHyv46MK5lpf7JQ44Dn4xfNAT6nnD/+4ZNxkdB9QLHZmMfrYlzssbGRbD3j1qedo6pHS0fbah0jaG63MblU7yU0fP9iZ6xw/7pvUaeiiyBGfaaKCyAH7Ik/enJAINVhFEtpjNweeHYQoClZvqonbZzTLwqqtySUqED8a4qt/M7rh5tSnGbJs6efmxjwFS1jjqGnrvoJwttmNtdcoLXDw7pgyVDM+ibkGWXdAp9Elo562r1kpfsUcOdWvQFVtlVKLL5uv0jpu4/XmThflVPQZ3+UzxmVOWKT8TsQgjwgBIWLOFFUpLrqVk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c4452b-c207-4980-afe5-08dd5d230da3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4944.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 02:52:09.2253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R1RoJvPC8n2kcj0Sk0nHnzVdZviro65ePPLCJR3QdZhEs+oI7jtNH6tqgXVrT3wRy73UKgZ+2Ky0Pe1vyb65iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_01,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503070017
X-Proofpoint-GUID: -OZ7aQ63FA-9c6uxXMonOjncto0bKKMa
X-Proofpoint-ORIG-GUID: -OZ7aQ63FA-9c6uxXMonOjncto0bKKMa

Signed-off-by: Joe Jin <joe.jin@oracle.com>
Cc: Zhenwei Pi <pizhenwei@bytedance.com>
Cc: Sami Kerola <kerolasa@iki.fi>
Cc: Karel Zak <kzak@redhat.com>
---
 sys-utils/irq-common.c | 88 ++++++++++++++++++++++++++++++++++++++++--
 sys-utils/irq-common.h |  3 +-
 sys-utils/irqtop.c     |  2 +-
 sys-utils/lsirq.1.adoc |  4 +-
 sys-utils/lsirq.c      | 29 ++++++++++++--
 5 files changed, 116 insertions(+), 10 deletions(-)

diff --git a/sys-utils/irq-common.c b/sys-utils/irq-common.c
index 560dd4b82..059f57e3a 100644
--- a/sys-utils/irq-common.c
+++ b/sys-utils/irq-common.c
@@ -21,6 +21,7 @@
 #include <string.h>
 #include <sys/types.h>
 #include <unistd.h>
+#include <regex.h>
 
 #include <libsmartcols.h>
 
@@ -230,11 +231,67 @@ static bool cpu_in_list(int cpu, size_t setsize, cpu_set_t *cpuset)
 	return CPU_ISSET_S(cpu, setsize, cpuset);
 }
 
+static bool match_irqname_by_regex(char *regex_str, const char *irqname)
+{
+	regex_t re;
+	int ret;
+	char *expr = NULL;
+	int i, j;
+
+	/* Exactly matches the string */
+	if (strcmp(regex_str, irqname) == 0 || strcmp(regex_str, "*") == 0)
+	       return true;
+
+	/*
+	 * To generate ls-style regex we need:
+	 *   - Add '^' at the beginning.
+	 *   - Replace '*' with '.*'
+	 *   - Append '$' to the end.
+	 */
+	expr = xmalloc(strlen(regex_str) + 3);
+	memset(expr, 0, strlen(regex_str) + 3);
+	/* Add '^' at the beginning */
+	expr[0] = '^';
+
+	/* Replace '*' with '.*' */
+	for (i = 0, j = 1; regex_str[i] != '\0'; i++, j++) {
+		if (regex_str[i] == '*') {
+			if ((i > 0 && regex_str[i-1] != '.') || i == 0) {
+				expr = realloc(expr, strlen(regex_str) + (j - i) + 1);
+				expr[j] = '.';
+				expr[++j] = '*';
+			} else {
+				expr[j] = regex_str[i];
+			}
+		} else {
+			expr[j] = regex_str[i];
+		}
+	}
+
+	/* Append '$' to the end if necessary */
+	if (regex_str[strlen(regex_str)-1] != '$') {
+		expr[j] = '$';
+		expr[j+1] = '\0';
+	} else {
+		expr[j] = '\0';
+	}
+
+	/* Try regex */
+	if (regcomp(&re, expr, REG_NOSUB|REG_EXTENDED) != 0)
+		return false;
+
+	ret = regexec(&re, irqname, 0, NULL, 0) == 0 ? true : false;
+	regfree(&re);
+
+	free(expr);
+	return ret;
+}
+
 /*
  * irqinfo - parse the system's interrupts
  */
 static struct irq_stat *get_irqinfo(const char *input_file, int softirq,
-				    size_t setsize, cpu_set_t *cpuset)
+				    size_t setsize, cpu_set_t *cpuset, char **filters)
 {
 	FILE *irqfile;
 	char *line = NULL, *tmp;
@@ -280,7 +337,7 @@ static struct irq_stat *get_irqinfo(const char *input_file, int softirq,
 
 		length = strlen(line);
 
-		curr = stat->irq_info + stat->nr_irq++;
+		curr = stat->irq_info + stat->nr_irq;
 		memset(curr, 0, sizeof(*curr));
 		*tmp = '\0';
 		curr->irq = xstrdup(line);
@@ -316,6 +373,28 @@ static struct irq_stat *get_irqinfo(const char *input_file, int softirq,
 				curr->name = xstrdup("");
 		}
 
+		/* Match filter */
+		if (filters) {
+			int matched = 0;
+			char **saved = filters;
+
+			while (*saved) {
+				if (strcmp(curr->irq, *saved) == 0 ||
+				    match_irqname_by_regex(*saved, curr->name) == true) {
+					matched = 1;
+					break;
+				}
+				saved++;
+			}
+
+			if (!matched) {
+				memset(curr, 0, sizeof(*curr));
+				continue;
+			}
+		}
+
+		stat->nr_irq++;
+
 		if (stat->nr_irq == stat->nr_irq_info) {
 			stat->nr_irq_info *= 2;
 			stat->irq_info = xreallocarray(stat->irq_info, stat->nr_irq_info,
@@ -532,7 +611,8 @@ struct libscols_table *get_scols_table(const char *input_file,
 					      int softirq,
 					      uintmax_t threshold,
 					      size_t setsize,
-					      cpu_set_t *cpuset)
+					      cpu_set_t *cpuset,
+					      char **filters)
 {
 	struct libscols_table *table;
 	struct irq_info *result;
@@ -541,7 +621,7 @@ struct libscols_table *get_scols_table(const char *input_file,
 	size_t i;
 
 	/* the stats */
-	stat = get_irqinfo(input_file, softirq, setsize, cpuset);
+	stat = get_irqinfo(input_file, softirq, setsize, cpuset, filters);
 	if (!stat)
 		return NULL;
 
diff --git a/sys-utils/irq-common.h b/sys-utils/irq-common.h
index b9cf72d2a..ec6c89d01 100644
--- a/sys-utils/irq-common.h
+++ b/sys-utils/irq-common.h
@@ -80,7 +80,8 @@ struct libscols_table *get_scols_table(const char *input_file,
                                               int softirq,
                                               uintmax_t threshold,
                                               size_t setsize,
-                                              cpu_set_t *cpuset);
+                                              cpu_set_t *cpuset,
+                                              char **filters);
 
 struct libscols_table *get_scols_cpus_table(struct irq_output *out,
                                         struct irq_stat *prev,
diff --git a/sys-utils/irqtop.c b/sys-utils/irqtop.c
index 6d001cb10..dc59f4829 100644
--- a/sys-utils/irqtop.c
+++ b/sys-utils/irqtop.c
@@ -140,7 +140,7 @@ static int update_screen(struct irqtop_ctl *ctl, struct irq_output *out)
 
 	table = get_scols_table(input_file, out, ctl->prev_stat, &stat,
 				ctl->softirq, ctl->threshold, ctl->setsize,
-				ctl->cpuset);
+				ctl->cpuset, NULL);
 	free(input_file);
 	if (!table) {
 		ctl->request_exit = 1;
diff --git a/sys-utils/lsirq.1.adoc b/sys-utils/lsirq.1.adoc
index dd265710c..7a3bfb69e 100644
--- a/sys-utils/lsirq.1.adoc
+++ b/sys-utils/lsirq.1.adoc
@@ -12,7 +12,7 @@ lsirq - utility to display kernel interrupt information
 
 == SYNOPSIS
 
-*lsirq* [options]
+*lsirq* [options]... [IRQ] [PATTERN] ...
 
 == DESCRIPTION
 
@@ -20,6 +20,8 @@ Display kernel interrupt counter information.
 
 The default output is subject to change. So whenever possible, you should avoid using default outputs in your scripts. Always explicitly define expected columns by using *--output*.
 
+Displays interrupt counter information only for the specified _IRQ_ or for irqnames matching _PATTERN_ when given.
+
 == OPTIONS
 
 *-n*, *--noheadings*::
diff --git a/sys-utils/lsirq.c b/sys-utils/lsirq.c
index fa2dcaaf3..a6528889f 100644
--- a/sys-utils/lsirq.c
+++ b/sys-utils/lsirq.c
@@ -35,11 +35,11 @@
 
 static int print_irq_data(const char *input_file, struct irq_output *out,
 			  int softirq, unsigned long threshold,
-			  size_t setsize, cpu_set_t *cpuset)
+			  size_t setsize, cpu_set_t *cpuset, char **filters)
 {
 	struct libscols_table *table;
 
-	table = get_scols_table(input_file, out, NULL, NULL, softirq, threshold, setsize, cpuset);
+	table = get_scols_table(input_file, out, NULL, NULL, softirq, threshold, setsize, cpuset, filters);
 	if (!table)
 		return -1;
 
@@ -78,6 +78,8 @@ static void __attribute__((__noreturn__)) usage(void)
 
 int main(int argc, char **argv)
 {
+	char **filters = NULL;
+	int filters_len;
 	struct irq_output out = {
 		.ncolumns = 0
 	};
@@ -171,6 +173,18 @@ int main(int argc, char **argv)
 			input_file = xstrdup(_PATH_PROC_INTERRUPTS);
 	}
 
+	if (optind < argc) {
+		int i;
+
+		filters_len = argc - optind + 1;
+		filters = (char **)xmalloc(filters_len * sizeof(void *));
+		memset(filters, 0, filters_len * sizeof(void *));
+
+		for (i = optind; i < argc; i++)
+			filters[i - optind] = xstrdup(argv[i]);
+		filters[i - optind] = NULL;
+	}
+
 	/* default */
 	if (!out.ncolumns) {
 		out.columns[out.ncolumns++] = COL_IRQ;
@@ -185,9 +199,18 @@ int main(int argc, char **argv)
 				irq_column_name_to_id) < 0)
 		exit(EXIT_FAILURE);
 
-	if (print_irq_data(input_file, &out, softirq, threshold, setsize, cpuset) < 0)
+	if (print_irq_data(input_file, &out, softirq, threshold, setsize, cpuset, filters) < 0)
 		return EXIT_FAILURE;
 
+	if (filters) {
+		char **saved = filters;
+
+		while(*filters) {
+			free(*filters);
+			filters++;
+		}
+		free(saved);
+	}
 	free(input_file);
 
 	return EXIT_SUCCESS;
-- 
2.43.5

