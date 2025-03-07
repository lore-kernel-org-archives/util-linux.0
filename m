Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E34188735
	for <util-linux@vger.kernel.org>; Fri,  7 Mar 2025 02:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741315956; cv=fail; b=bjdX8Z48D63daywZgoUCHNsEm5uZAQeBOYSSxXMqhOTRVBojw7frtNkMOgNT+9bidhz6JJC/+12v05tqvzkBW2HapkAxs6Fc+ZUJm9Ng8J5MXshncNgz+2tbi9Ak+QzWkAtB+4DtDdEiGefpWE9ar01Ty77JWqheXuXLOGXwNWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741315956; c=relaxed/simple;
	bh=+EWPiv4oPPNNLV0TdlN8Smq6UXfP1QIGvQ935tOEjm8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=t35pmjpSNJy/2ZF9Lv++KUUjudlBgxiDfL2cW86PgrDiPUtZ5x9JGdg6t8mhtVkQ20vtREYndVmSm7fBkPNfsqmnCH1fMzS/yD8LTtgIFtCAVfu+nyfLd0BXxdxiM80xmbNlUEeMYkVoiyewSHNa1j7BV6yyELuVR+bly0ytY4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kX6cqsy3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n/l93DRH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kX6cqsy3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n/l93DRH"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5271uWeW025185;
	Fri, 7 Mar 2025 02:52:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=y27pjxC0w4Z8Foqr
	GkclegFD+Qps9poee4TqYgmH3ig=; b=kX6cqsy3owytb6gQiUAOOKvuYmhR48fo
	AKHDuUsfLU3CFDkxBKCiC2JFtZFSqqRftvbPikROhHtI6H6go0LxrPXj4GlqMmxp
	5mP5YPiFGCVAWvC4EifmhN1m9gJD33xdbLcaQGm83FgBJHTo2HhkHYBflrxKSysQ
	1GPWfZ/PSKjna+TcSo/jARxrQszt21gCXHj+qAeLD1u6FJbNgab/2GKuRADk6hqT
	oi89IsG4Q0WHvRpPvl/UQNcAkFin4/Ysbwldv2HX6+b1Rrwr/ha0gAWMHXSWu89K
	3/thqH2+eQxE7YZ9CH7/f6NtbB8vNY0iWyTooW6mIIZOuLXYrNu3Mw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u9qkhyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 02:52:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5272dJ1j003179;
	Fri, 7 Mar 2025 02:52:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpcyg0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 02:52:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKhQBHyuOM4HZvyQwdPl/ih2sCeEDinKVtnQvhMbDUWdsZ1CK1fObGqcWPBZpTztPByjNXZ8ze44WTx+ryyWRxhpJNrkMjselYKZQz+Qv+vT5MB/udTTx2bxffrYFNOnAV5nwi377W8+5iiQt0gjUnVey+SOJ4f+6syG0RE3RdNdeA9Qbv5tbn+HYCbhfLz5RiX7BrI6BoPesgnqVDoDHppBUPjLSt3caa19WQ2VTzCptugkLkImoPr64ylyKUVLwQdF5Um5d7WGtTH98mWRS+8z99LQTmqtn5U24W5K1j4JdlxGg0FBBP4mwJaQSmoQUjNtrWkrAuzu4ef4AlPpPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y27pjxC0w4Z8FoqrGkclegFD+Qps9poee4TqYgmH3ig=;
 b=pUxpcug8yES7qYYPBUKC4rCulDxx9x8HqKVVmBjMRgHqizkaTcDn+l+CnZHIbwb15oupY7Ta+Dx4VGwrZ9tWQTv+FObPQEam5pX0gnRPD0QiIawgEx5rMIHqA4FNJ3mfGzyCu/WIjUN+U4Z6kkrQ06wcbCkhAafZrB7hyQK53jYBZxGRR3hx+NACNcWCcNykRkk3HZWoRcMCPfQG6m2EJc7CHGFUmFKfQhDDitzje7EsLDUO40jdSxQce7JdX1i2XrR3LZrAj5eoMDH5klN1C6l+IG8TEYbVOp+q6eyyPCtdaDovGmFYi/q6NLfaGSTbUP3Yz2hMxXmtIBW/qB0hIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y27pjxC0w4Z8FoqrGkclegFD+Qps9poee4TqYgmH3ig=;
 b=n/l93DRHUL0EllMY6IK7VdyzaoGfM+ptzJ6yq7S5lMNtMs4NsftfOa37Sml6bpTzSxDtmDNDP2GH6IExfJk9mElLU4D0KwI3hmW1I+4VrReEkEPvjsJDwsSHl2YTaeqAZZv0Tdh5ln90iasMlmChFizP9gqw5cmacf6Qw66sLA8=
Received: from DS7PR10MB4944.namprd10.prod.outlook.com (2603:10b6:5:38d::15)
 by CH3PR10MB7356.namprd10.prod.outlook.com (2603:10b6:610:130::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 02:52:06 +0000
Received: from DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5]) by DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5%3]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 02:52:06 +0000
From: Joe Jin <joe.jin@oracle.com>
To: Karel Zak <kzak@redhat.com>, Zhenwei Pi <pizhenwei@bytedance.com>,
        Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org, Joe Jin <joe.jin@oracle.com>
Subject: [RFC PATCH 0/2]lsirq,irqtop: Add filter support
Date: Thu,  6 Mar 2025 18:51:59 -0800
Message-Id: <20250307025201.92541-1-joe.jin@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:a03:180::44) To DS7PR10MB4944.namprd10.prod.outlook.com
 (2603:10b6:5:38d::15)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4944:EE_|CH3PR10MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: 66776f83-c7b9-4556-68f0-08dd5d230c15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QKNnEWT0e7Jtw7yNZGFwLjlmMSYNoC9GkKzrus4/4JQVMYoqY9V/S1yOreUF?=
 =?us-ascii?Q?VCVOSSGTnueGF7tuKXI9pzetrgM/pePtya9ObI0gcOsU+DHiPWA/UXOTH3SF?=
 =?us-ascii?Q?cTw5wVNSgTvkkCxwBM3Jiyjsmtf5Rvm8GTnpEO1ZdGe3alLuLiyPuwQ+f7HF?=
 =?us-ascii?Q?mPfPW5Gpp4FPMT8Hagn8L/D7LaGqqHJHGPWBIwS7zILEREKApI0Z02x8UsfM?=
 =?us-ascii?Q?FFKum0owZvmdrDJCoHDChhQPxSop+p58EAhHxsPGueMHb7Arc8TIkJDAnxbo?=
 =?us-ascii?Q?jpRPmM1SRwhQ/jV4XucAVi9fsT/Re9RsE4zr88fQuUDN+MjikTQAxLJb5VI+?=
 =?us-ascii?Q?2mB6/67+Uz3UfmzFzm2fhiCz0VE0/bOfqGbzqkKan/zI65ZS0eipbw3F9EcA?=
 =?us-ascii?Q?xb0/oeSTykle1CML9kh0rNEINWY32Og2raF9lfDLe3y7zI5TQWDe6KgLRfeZ?=
 =?us-ascii?Q?1+oegU4oj+1GaUFETXDEiB+3R4HEIiV3WWCIkv7WEt9akZovOUlRpifIvikd?=
 =?us-ascii?Q?NK22l/OLJdw3vYgpJVnFDuX2BE1WLkDshiS9IcKlSsh11jN3pkJATFIRFFxq?=
 =?us-ascii?Q?/ewgx8L7TMKFhJX5e26pE+aSAVvGey/St+J+XCiYb4Pew70MfvKjgSK4H5wU?=
 =?us-ascii?Q?wnv36/T6twUHTitJRj7HVvbxthMBy4V5iFdlmEjT7ERxCU6ODYk6XAPauyki?=
 =?us-ascii?Q?wdQ2v5Al637Snrci+yh87oevBnMWO/zkwK8uYXIcDk4iBBQoDD/Aildt+LiA?=
 =?us-ascii?Q?SAoLqJkVc6n2uMpiaH0f2j7nCjblwarDDOrY940QpfT3yszpos2pl9R1N/Rx?=
 =?us-ascii?Q?tBoWyy/VM3wUPjpzIk0d8m1fQG65DkWetogUfyU0nAMD80sJPeT6qZQ/y5bK?=
 =?us-ascii?Q?d3ilfiBPc5eVDfOnZGhpxMA205iI/tsmtjqSQmRBmMPPa2ehZ1ZnjHiQ0S0y?=
 =?us-ascii?Q?MW/Gky8Ov1FXjddQInp2JMzqZRig3NP7w2iM569Ctf6aRGJBC8dOHvvpuHhB?=
 =?us-ascii?Q?4v70tlPiDZ7rHEIm+0Scm4g0LYT0fd+ks9AfKlOw5v36wLA85gELm2bv0cb6?=
 =?us-ascii?Q?MbLYIrsdtaDJe3Gy/u7RwsyO0IEYgfJsa+odh5/Ls3vKF8E+Qt2xM0XZRZEB?=
 =?us-ascii?Q?WrLFjV7lUYBaf1K2rkGGgaeNurnUKsCB1KqyUbkucwWy84XJ5+qBr50sEPf7?=
 =?us-ascii?Q?Q7typSGEURk6jeztHmYlO2zZOP0OoQOf8d4tG9egK6GOd7ZsmA2d75nrtUvk?=
 =?us-ascii?Q?v3Mz+ug1mdTzt//3ZCc7YgRk+6FhojKcurMLc9I6r2rfuPNkDwMYU702liaE?=
 =?us-ascii?Q?zuV7Rjx+JDrIvlL9uBWkaEpv8WCP3H/cJWGr4Yqj37ONz+dwPjzFeo0ZYSMu?=
 =?us-ascii?Q?gMIgZ4Sn26D+X1EQErOgqf4gfgAv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4944.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aH2da9jsnznvBF0EJCLVJ9B5mqcmJyRGqibzEwBa45znsUpkVotYo9h24SJL?=
 =?us-ascii?Q?maQOvTo7P1/Lxr0cBclsAIRyXCVlgz8wsZkllvgJCYdrXBTX7hT/2WSr2Hoc?=
 =?us-ascii?Q?kMqsRsYyaSX+9VHXbplkQDKEIYTKg53vChbdaS3pFytTedued+wAT+65urW6?=
 =?us-ascii?Q?GPufMSikjxpoliOO6h+ZLp7GEo6RuN5weAWixShO4Xtz42145ijuI6TSaTr5?=
 =?us-ascii?Q?XAJndm/AcVLvcn1wQ9qCGUgXfqHqBL8IlZlk+DMN97FnBvAjs/qu0bIEQv6b?=
 =?us-ascii?Q?5OUgM1LmFXFs3eSlTvS6c4mBVfCSmrDkgUgZFKFj9Uf2yAt4T7rmfEpNecR/?=
 =?us-ascii?Q?Fml5/jvBo+nzwUPpJctvmPmzuVzq+OISrMh9P13LuY2WXPalO+65ZE2m22TR?=
 =?us-ascii?Q?x1Ym1Aam/IBFDriZxw4k1a8YdLh+ctoH2lITPUwm2FIdo9dUJ9dP/Vs5OPPI?=
 =?us-ascii?Q?jla2UjxrNe/J1gJE2XN7+Ezj3GHt06/Wux1mwnbJViHBUpskAUNIVe69JVXH?=
 =?us-ascii?Q?Tgd/UpoZBoezO83ZMurXh3KrrJ5TAKa4UcdFzOICFQ7RI/jGADYW57a38Bah?=
 =?us-ascii?Q?JP60B4GLeCbhYLUs1yslGSl/zwcDZjDRzgZDrcE3loh1R7bkkJiiW5Ut/ykB?=
 =?us-ascii?Q?1o+JpX9HrfBcYLEevoOked7RFh9f3mCDucjl4aeQHhHKY0H05hVq3EMI0mv1?=
 =?us-ascii?Q?Eetqu5+PmyPFy8PVANBbH7PYGnmugkUzSSoPnrlnvaQPAix04/UGbePgu836?=
 =?us-ascii?Q?Kg/lTppvWOxiLvTDbqXxUQX1xCCaeR8bZlwhCD4skV/e2hG1qICxBr8GsGMs?=
 =?us-ascii?Q?+8WJURv3eDTwluGst1ZSGQyhiUOXzYsiIFne/rNPnZf7IOCbOh92hUE9Jh/g?=
 =?us-ascii?Q?rH6t/0oOArA1oZvMU2KsHP+2416RNzN6vMlVLeiFo9z7wGdDmpcTP/bcFSeg?=
 =?us-ascii?Q?yyVklEu2CeTGJfLZz9agh1YMg0SPKKO3QzSR7Olc9lTdFcL32WXD1dS6rmwt?=
 =?us-ascii?Q?ah9jixN6MPgAm9273W1Nm8K7AcK2hBy6dIFBW1xYQ5Z2R8f8tih9v3ZVBfUZ?=
 =?us-ascii?Q?DdQPrR09+smRsGdeQA8pBEglefu3qE8eaUz2fzQp6t4J6/NdhPGYO8/HH1IV?=
 =?us-ascii?Q?mzc+csjTD5IRl8FGVaOrmhqAC2Rm2H6664hizHtO5cBQAJCEmWi/aIH+TzNZ?=
 =?us-ascii?Q?4OwTcie4Ch2WYvtf05ZVBp+aCNYwRaKyMyrc+J+PAfnebg3qDZKbe3KvH1u0?=
 =?us-ascii?Q?IFtwMEnPB19vOhjfPGqchYbEwiqQFGekWnnMxLOWR94qW0BIjcb4+jphGC8a?=
 =?us-ascii?Q?zPzCPat4eI73qoYOGF9fh8NJNiqTb2B7UCE4xLy0g5vtQqMVVYU/hX2jcHLj?=
 =?us-ascii?Q?82iZCuer0PqbZQJurLC6COjpSAYXOgeTtl8MWLrAxbHp4N3XkTUbXYRUV42+?=
 =?us-ascii?Q?G5pMQeVlLxSLgPAjxdXPkDVFgUWOvxAQKDnI+6LPF6ZL4a/0B0BNQDsTOeKl?=
 =?us-ascii?Q?CBi+53xYcd1GuwOxOSeqAknDEPn39OmF8hteuTOrCbSTFvFBki12p1m21VpL?=
 =?us-ascii?Q?VZbHApvS0oSYBjVTFGs296QZfvf9TDjlDavkWsvd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pofT2pR70aEPj0TzMZ1oSFU8MT8FuH1wwDWDr2avELvQp45X5m0BA9FU41h15hYOInFmEvLQ1Wl3Tx65VhFAU7Z3NkwBIz1IsHVDl+QoffbgO0e/QAZTeSdHapNUF5t4QlNe/6EvvjW/vQ+BjXO589JdDBck1fvyjkUhnt79KdqOOzkNSEcvzoy3TuWAIWjD4sa/htk8BUSzSdgXGArzl+9C2aOHeFO+rWya9C7TOqFthvXMvnKoM+cNtBW0fXY+LklW0dsbiqPtvePfqrZ4VdJMppTQ+wyjL34e6tpeHaVmc4iYF+xMWnWyJSoGia+6WYNoihEkCBD4gVez1OYjXVUldQW5MvUrD+2neu7mTH40xjlQwDdEoiT8SEdaz1kE0zt9PT3vRgMvcKLiigaBc42TAQ3THNVV9y2pPsxvDaQFmlvn1FvNlkhKpPafbkmflNwqCByRUozsmOPiMZNVVBpLrLm6+gaPHVXIEOLkT8zUv4Pfe6ZNikv2jB7mXBm7hyP5xSv7URhuJ/XMtqAT6E2/3Dq3PxNoiX19ztTUC3zI7O9Sle5OiJOjZYvpBI8GXSySfx1PUxstyUkmEF0ILMXNsRef75HMTgiJq+JQBHA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66776f83-c7b9-4556-68f0-08dd5d230c15
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4944.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 02:52:06.6355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gRDTKtwvCJ0Su6C1zG03HTmptGgYcmmSB9Js2MI3xp/+Y5MagUKWCGhuQDQUya6eavkx1ME4ZdQVV0iUOoVfcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_01,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=794 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503070017
X-Proofpoint-ORIG-GUID: bfINyq01Oi0WmGGluVj57VCsBlbUmFzN
X-Proofpoint-GUID: bfINyq01Oi0WmGGluVj57VCsBlbUmFzN

Sometimes people may only be interested in a specific IRQ, adding regular
expression support can help engineers find/monitor IRQs easily.

Joe Jin (2):
  lsirq: Add filter support
  irqtop: add filter support

 sys-utils/irq-common.c  | 88 +++++++++++++++++++++++++++++++++++++++--
 sys-utils/irq-common.h  |  3 +-
 sys-utils/irqtop.1.adoc |  4 +-
 sys-utils/irqtop.c      | 29 +++++++++++++-
 sys-utils/lsirq.1.adoc  |  4 +-
 sys-utils/lsirq.c       | 29 ++++++++++++--
 6 files changed, 145 insertions(+), 12 deletions(-)

-- 
2.43.5

