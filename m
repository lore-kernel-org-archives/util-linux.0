Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9447726B2C8
	for <util-linux@vger.kernel.org>; Fri, 28 Feb 2025 16:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740759259; cv=fail; b=HbgkcAR3u4cVZTHRaQMT6OzFxy1w3Q9biJ2aiqhkiituPQUdnBKIqlwG+0KldYxVl53btpv0VBD+WBGABDd1sULBgEh3I38zBxNn4hMw/HeLfZjuTiiokgz9BupI3Xx0nFztRwKM/FXdnulgUMhFfYxMdA2Yf5xGOhcq914wikM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740759259; c=relaxed/simple;
	bh=EZzQ0JkoAE3BJYjOl5GXnmLpl6Xc/c4b1HiRaj2gdmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=miU8gRPe6Sgp8a365lx4QJsLcEVHGvZuRjlH8KNz2pE9SButw/jj4MwcQeKJ16DJjSxxqHxp9/qhDtMPd4oWedwjl65Pnb+N/zNxqCPxD6si3uXLuse4bAM6t/ZkDj6jPKr2usq/NxYLtRTr9ey/zlz/smtdngkymjDMtscyw/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aGlU7xpe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QyzFYHdA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aGlU7xpe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QyzFYHdA"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SEH3CG005705;
	Fri, 28 Feb 2025 16:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=k1iE5oUXtCRc8/7k5MAO3wL4zOnUkPNJdGTScOsFGpk=; b=
	aGlU7xpeQ+9uC0Ya1ySEgDpfNNTSRJH/H+BxfeHmKF6kcWa4wNYCXATlj9ErOE59
	EZDbbirsGCkxd/kbPCITLrPcOaWkFjw2Hn4UTDKPZGXmVPqr1cjG/I/vtthS5+bG
	IsjOCIdvOD1bVva9Bnzwyme3NqAyK4/XVQi15LX6uYK0R6rB/MgcZ4RyL7Iyc8En
	F/Xm2n88hjUhnYigB9qWZ45SFpf4rSTafUA//q+DQ20icca1lOmikrYi5KlhO/LC
	obzFRGfZ4BGpc3I2/tLlVcOtkyx81gHIFy1QSsoraYIkV0zZOIZCricF2zuqn7/8
	NttGQ57Sfu65RLAH8RxbdQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pscdy1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 16:13:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51SFIaKY013176;
	Fri, 28 Feb 2025 16:13:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4530jx287j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 16:13:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSLD4Ssl9cnp3UOoHq63voVZCzX82IRxO67ChLRWh1I1NLEie8qR+mi8BlqgxvQx4AompnOwcs6fg1rs3XVU7yAImxWPdd7TpdTOBsTFDlh51lSia+yLFXI2myF5A4L7rE/EUWTucgrYav2sTXgrXh027szkKpMQlWbJ0vjr7DeQl22GeCYI9gXRJe+WlB67Z+JFdbMFgkU4ID07vKcMYP69uceMqsFkxvGMVxerfAee9GtTWOYfANeQClsYqdrDf5KcjhQ0qw4zF4Y+hY8378dratZsvyAG7cLP1U89hei3aPkbkiJMfyMXQebFgkWA+kaLmiyJ92Mnz2n2UU6pqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1iE5oUXtCRc8/7k5MAO3wL4zOnUkPNJdGTScOsFGpk=;
 b=yCtCL4w9xnoUft8R/CTW/rbJZ8z/Lbt11k5iMlpy/NThxRNBUuBozqXUDb//+/v5m+4swEpj4QfNW2uROpTvtYKdcB411YL8Tr32Vx7wIBj8Ih3E5ToXzBjTL8VlQUpTsj+eFq0KEchI6RgcASqUS1in3m+z1GiTqVCUVQdocgzZNcmZrvI+fs9P2UgOtWPUmKTsX1yp9Vjea+5xRf6d+plUcWaiwnTdcV8pjbpbSOqDuKO62zBGbd4RuYwe0zQMU5OiAdJyrOelDrgpQT4+PTA6fopuO4r0oBmIyP8emMxKYA8IVaGWOl0bt4sH0gqLUmCF/L7docZUBiWAfrBmwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1iE5oUXtCRc8/7k5MAO3wL4zOnUkPNJdGTScOsFGpk=;
 b=QyzFYHdAiB1neyVInrdsl+FQLwjBjDNRBwLZOLwFBJ7hUuPRWjmwqs1dG9BeI9JS+wG7ILBOiYSmIa1MEHyFlGxP8Fh/G3fAfvq6aK0oO/AQmple/+HjvNmuprksuNKJYrPAsHepjyFGr3Yh8nMXMRjJpiF6ZooGA4z0zwwTrWQ=
Received: from DS7PR10MB4944.namprd10.prod.outlook.com (2603:10b6:5:38d::15)
 by CH2PR10MB4392.namprd10.prod.outlook.com (2603:10b6:610:79::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 16:13:54 +0000
Received: from DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5]) by DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5%3]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 16:13:54 +0000
From: Joe Jin <joe.jin@oracle.com>
To: Karel Zak <kzak@redhat.com>, Zhenwei Pi <pizhenwei@bytedance.com>,
        Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org, Joe Jin <joe.jin@oracle.com>
Subject: [PATCH V2 2/4] irqtop: add max iteration support
Date: Fri, 28 Feb 2025 08:13:32 -0800
Message-Id: <20250228161334.82987-3-joe.jin@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250228161334.82987-1-joe.jin@oracle.com>
References: <20250228161334.82987-1-joe.jin@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR14CA0014.namprd14.prod.outlook.com
 (2603:10b6:208:23e::19) To DS7PR10MB4944.namprd10.prod.outlook.com
 (2603:10b6:5:38d::15)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4944:EE_|CH2PR10MB4392:EE_
X-MS-Office365-Filtering-Correlation-Id: 06ec031b-b0ca-4fcf-940f-08dd5812e56e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f7fmu7tKzdlfhMwD3iAJ2s4ShekcZxZkdAYQflEyF4dDoty3DAen/LFNbQ7o?=
 =?us-ascii?Q?ngi9apmxwhSBDaE8JAjo913NpGAih+4rJJPmzNC4WmsKbUaer3yqC3B/CVSY?=
 =?us-ascii?Q?sc4BeH97w4X8ujTOnTLvko05eFZWf/9LCqowMJvx+Jn3CHJt3Bw0IHqOUOhU?=
 =?us-ascii?Q?CZ7oZaXGuTkzwwUbr8q03PGSonrNUETGg8skgZTerUZ80UvJKMN5bBtKk6+i?=
 =?us-ascii?Q?a0wJnklnEYi5/u6r4rUsq5yAcl5LQ37xWFNh6jskNQYfH0Jj1HDRXq14MzU3?=
 =?us-ascii?Q?lCSp10H7190CtfgaoS0GEplVVPpVIrtLC0zuQahoqv+WWU2sHPI3RuYuwdaF?=
 =?us-ascii?Q?XCJWb2q+hx1S4HeRURZB4e62OKfbjwtvaJr9gC3eyekMvBmVjP1seK7D0Ez7?=
 =?us-ascii?Q?ZYB4O1YsvexuVLI1YOn1n8D+GDMhIOfk6PMq7JGfD+vZTo0sPlp0x88aq3My?=
 =?us-ascii?Q?KHFtWVabUo+ea6kEPOaipCZEdYMTS42jlY07vgmBMiEAjMJ1ZBFL5iMLHNbe?=
 =?us-ascii?Q?rD3gZTXEcqK6jQOr2d7Sbt+xBMKgbgJmLVHGslsaV2eM9npsgnPUAr36ZPZl?=
 =?us-ascii?Q?9QcH16m0Ynw2FzbxTPWEedjteLsrth7Xi2q9hC+ndrS19UYPhkScO+uyxfQu?=
 =?us-ascii?Q?iOnHTdoOC3FBeT5zp86luNFaSPDlGE1ekOgXoiZknD4kBLJNYGqJghgHztEJ?=
 =?us-ascii?Q?5oK/byLsArvxL+C/Y2OC/qrxSCAkYWuwOuCd2DsM2f6X96upg2ORR1Qwz+jk?=
 =?us-ascii?Q?JcFn1bsnojwkMCFiKAOg4rmFpyKo2MC1yPZ34I3o4fUKez+oNGIEyHrLNwUm?=
 =?us-ascii?Q?foolrnfnOAtJcYxn09xcLEG+5uAOpvbbqBGQ+hPSXD6RkEebmuOn3YQjgFn8?=
 =?us-ascii?Q?SwpbHQDLF6q55ZF1OQtA8341WfpBULPZP3JenTKhlnOlJzTPWrsqMl0aBP2p?=
 =?us-ascii?Q?MMz3a6U2gJVSvh9qlFyIlxLI5qUN2sZT08aWpDuhv262b4007U+cw7TlEGc4?=
 =?us-ascii?Q?7XDwDRxnwKz6dtWNL5ifZFQWFfGYGzRz6s3okAZhVREFHtKOlhsAdhF0yzRs?=
 =?us-ascii?Q?+gS9X7Gbw6zUjJKCMJGZiZR5C9J9xXVDklUHqix+zel9HulJdLCYR4/bIgeP?=
 =?us-ascii?Q?uI5YPxSzHyf7eNU5NwuXc45Owc16/V1gOHUZURs9C7Dn2WGkA1pgwhZbN9Zu?=
 =?us-ascii?Q?9CMNHNrs0wvGh6KG1cqFuq+KGQeH1afmhxc5mIm7ZA9LJntSagtPabCgiTAZ?=
 =?us-ascii?Q?dbSZHBi88byX2jcVK4zZ1XAYFnh9LbaF2WX5hCAauyaJuioL6WJ/kgVC5UtG?=
 =?us-ascii?Q?2VghsvDseHjJ7ewBr4HXu/WdBAokE2k2d0exc2jFBSZv8x9MBNHOVvbDj3k3?=
 =?us-ascii?Q?pYW2qBH3vxlotg34RvLXdgxhpVB8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4944.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mopjI0BkTCTz9W2iibfGenL4SWPAVy/xST4wdLvoFwS+aupSSIeFYCYimXeQ?=
 =?us-ascii?Q?CPVJgGhhAe5DRNNiCEq3exe9/2HXmCEqvcEU8ervIYn+agx4hBxxxr0/kHUd?=
 =?us-ascii?Q?M95kyH9+VVUJ+IdqF+cdZFaQFj12+C9ux5A+vwEHhrEu0q7cCBqXGzev0jcJ?=
 =?us-ascii?Q?80xtJxBd0h5xbn5rsKPB4PuK0aytpXmAxU58U5cf+iUrz33AWC07z+g+NrzR?=
 =?us-ascii?Q?+xSn6CHRM02nukFxVsCccAZ+44dy/i0iKUv4vs3LQaTufwejLLjFu96wdwbL?=
 =?us-ascii?Q?AtRt0u9Vqjzsmh70bBVoZmgGoWdyHFNHWSQUxeJ0cDdNMWG7OERU3WqDaYRb?=
 =?us-ascii?Q?G+UepRxmF1nRZJk5m5sRhLICpsglXKv3YAtnArNkcTLePCR+YLF8Bd6Vie1J?=
 =?us-ascii?Q?FJIx7NcnSRszOq1644//9NNV+I6S8AtXmagDnI2ll05/GoLkWnop1PibYmCQ?=
 =?us-ascii?Q?DujUC7TPPre3wCdv4WBv8nGfUhfKUTF6907KwibJGBfK4Rs+IxggZNK0cVTk?=
 =?us-ascii?Q?g7DtDKdHhmllpkDFFLpqGlszLRtauzLKJcxXIXZkvLT6VuD7GU9iJRzTzw98?=
 =?us-ascii?Q?V2gq/9u2UTPtvv2TJOK92BCp0dXsIEl8g4aENpSU5lQsyz2rYNzQpmbF1tVA?=
 =?us-ascii?Q?9ObSGsrksO+W5gVAcqLNMuTIMCne4jJmJN1ZVIW12b+/5u4IqdptereVM+oC?=
 =?us-ascii?Q?39fMGK2KUaQIqNhDYAJvs7REQrIyqvCdqIYzY9Z+rD5LxXSoiwJJ5MIz06Gf?=
 =?us-ascii?Q?fvswfa29i1fdz2tt+I/bLQDcb4WTGIQWpQvHszCNlH/cKgE5q4PPrOXMgRfB?=
 =?us-ascii?Q?ngsqmRXIoFqwV18dEI//5n1ITKCuimzcFWWHpunQpwcCsR/04QCZR7/Trc8+?=
 =?us-ascii?Q?bGjSxzWA9IAMUQFQ0C9OXonBzd8FWw7Ra04zqFHUpEBe0VumMBlYOVbllMpK?=
 =?us-ascii?Q?Wa9TVGgzxirxStJ3B1snsHMJ5IeJywF15lRd0a5rXYlAsgu98UzJELVYmOuv?=
 =?us-ascii?Q?vxpRXhAnb/fchP3lORQ2Qp1Cx7+QwJAeqr1GjNoXFX27E4wi7Zk5sPdZFdSx?=
 =?us-ascii?Q?sF0shYeecIi/7NoIqkfpgD6gsMYHEiJVnOvsyPK5kkexHcumscqYz/r8Fqhl?=
 =?us-ascii?Q?cGXFgwL2EwrMUvKHveRAGD2X8PhbplY8R2pdTfP2QGqrWLt18UMXzpGEN79b?=
 =?us-ascii?Q?Eb/Cp4gVJiqvhchU1PgwREqeVlv9rcrdOEF5zJHX2Su7J5rTqYp5FXrBmWUJ?=
 =?us-ascii?Q?pKaV1Lob6x5UTMa/zWp/r9COI5SBvFRyrYC2sK8br9QX4V8qRquRIiZtZRlV?=
 =?us-ascii?Q?VqY/TuzTS80iAjZdr7R0UMxeV1zGfdJS07mDvdf1cRm2tygMW8fKtD2PpBbC?=
 =?us-ascii?Q?r5TABiySzxpkp8QKznQNdkkjom5vpMyAL6xeH+5EGqwh/hli9oc/YfvCIfWD?=
 =?us-ascii?Q?tfUXoWEExav7WU3ssQueUPd3xk3Irb9XBxe2Y1Pa9En/E3InJkqEUacGAyHO?=
 =?us-ascii?Q?tShTHhdItQba0mnIdjcsSPOOpEDefZY19PIVpL30o0/4R8AVmmjNhJ/btq9Z?=
 =?us-ascii?Q?m5erYwJC6aMD8zsMkAfxKIwoQLR8LF3sgUbDOp69?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JH00z8Vg22uJiWi92NcNUjSHBOxeKP7/Iq7YPIG808Kp62U8NGbi/qFBz811SLgQDhlCiekdF3aWyinzx62CmkAX5g5zTDXgB8p4XEdOX9h4IIsL2JxEIbTRJ5YBM4yn6av7xJ6u/5S4vRpRW6AbMTUq/AhSIOnhrjNejn+SDAlYcFFggaOVdHjwj9mARRf5KkbRHjorpJo5B0i+ZkTMiE4U+8rveNFyfWZ35JWDZSC8fwWT9Z5cvB9EASDUW/jd9kX9oGBNOGaV7dQOtG+pIeZFJ1MwBt7CF4sDcK7gxMZBKUGC3W02KUZuePJ3UhxgqC0ZgWRuGpfR0OhxvqxyLx6XxGAOYUDOvUc+ZVglzCgPnVwhgvOAGKa3yIqrVZ7L02dzkpaef/1KkT/dNmcg4fdiKT50MknKUbU2GgiCiSyLHR7yfQ6w//dW9wGBDeSzscGYglSOk3bSphZjqrRvEZNjUjRbifwpQnah6mAWVRbORf1nzJgBCwQvh1WYXyakZK/92kv3ilE1eupqXJgDfMpoZPLCVPUIyXb5H2rM9OKuaZmlyThScJ2iof9GVniiPG0JEvtZnPdOF73JRNQxoJuIMG9HmUNcWdkdp3BoW+8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ec031b-b0ca-4fcf-940f-08dd5812e56e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4944.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 16:13:54.0914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uaelvu8awx+KPB52ZdGXFXHdIHyTB+8CJ0UWcbwe7n7hKBqvwPknKeaGpGGr/kx2zD5ol4CNCrubXTT9zvafDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4392
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_04,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502280118
X-Proofpoint-GUID: hKAeflxlnHnMd3b36iO0W4lVtqSGvqt_
X-Proofpoint-ORIG-GUID: hKAeflxlnHnMd3b36iO0W4lVtqSGvqt_

Add support for setting the number of iterations. This is useful in
non-interactive mode.

Signed-off-by: Joe Jin <joe.jin@oracle.com>
Cc: Zhenwei Pi <pizhenwei@bytedance.com>
Cc: Sami Kerola <kerolasa@iki.fi>
Cc: Karel Zak <kzak@redhat.com>
---
 bash-completion/irqtop  |  5 +++++
 sys-utils/irqtop.1.adoc |  3 +++
 sys-utils/irqtop.c      | 19 +++++++++++++++++--
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/bash-completion/irqtop b/bash-completion/irqtop
index 215281ee8..d18ef99bb 100644
--- a/bash-completion/irqtop
+++ b/bash-completion/irqtop
@@ -22,6 +22,10 @@ _irqtop_module()
 			COMPREPLY=( $(compgen -W "secs" -- $cur) )
 			return 0
 			;;
+		'-n'|'--iter')
+			COMPREPLY=( $(compgen -W "the max iterations" -- $cur) )
+			return 0
+			;;
 		'-s'|'--sort')
 			COMPREPLY=( $(compgen -W "irq total delta name" -- $cur) )
 			return 0
@@ -47,6 +51,7 @@ _irqtop_module()
 		--cpu-stat
 		--cpu-list
 		--delay
+		--iter
 		--sort
 		--output
 		--softirq
diff --git a/sys-utils/irqtop.1.adoc b/sys-utils/irqtop.1.adoc
index e81f4fbb6..75930f5cf 100644
--- a/sys-utils/irqtop.1.adoc
+++ b/sys-utils/irqtop.1.adoc
@@ -37,6 +37,9 @@ Specify cpus in list format to show.
 *-d*, *--delay* _seconds_::
 Update interrupt output every _seconds_ intervals.
 
+*-n*, *--iter* _number_::
+Specifies the maximum iterations before quitting.
+
 *-s*, *--sort* _column_::
 Specify sort criteria by column name. See *--help* output to get column names. The sort criteria may be changes in interactive mode.
 
diff --git a/sys-utils/irqtop.c b/sys-utils/irqtop.c
index 81a137be0..17c7d72cb 100644
--- a/sys-utils/irqtop.c
+++ b/sys-utils/irqtop.c
@@ -83,6 +83,7 @@ struct irqtop_ctl {
 	cpu_set_t *cpuset;
 
 	enum irqtop_cpustat_mode cpustat_mode;
+	int64_t	iter;
 	bool	batch;
 	bool	request_exit,
 		softirq;
@@ -190,6 +191,12 @@ static int update_screen(struct irqtop_ctl *ctl, struct irq_output *out)
 	if (ctl->prev_stat)
 		free_irqstat(ctl->prev_stat);
 	ctl->prev_stat = stat;
+
+	if (ctl->iter > 0) {
+		ctl->iter--;
+		if (ctl->iter == 0)
+			ctl->request_exit = 1;
+	}
 	return 0;
 }
 
@@ -295,6 +302,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -c, --cpu-stat <mode> show per-cpu stat (auto, enable, disable)\n"), stdout);
 	fputs(_(" -C, --cpu-list <list> specify cpus in list format\n"), stdout);
 	fputs(_(" -d, --delay <secs>   delay updates\n"), stdout);
+	fputs(_(" -n, --iter <number>  the maximum number of iterations\n"), stdout);
 	fputs(_(" -o, --output <list>  define which output columns to use\n"), stdout);
 	fputs(_(" -s, --sort <column>  specify sort column\n"), stdout);
 	fputs(_(" -S, --softirq        show softirqs instead of interrupts\n"), stdout);
@@ -327,6 +335,7 @@ static void parse_args(	struct irqtop_ctl *ctl,
 		{"cpu-stat", required_argument, NULL, 'c'},
 		{"cpu-list", required_argument, NULL, 'C'},
 		{"delay", required_argument, NULL, 'd'},
+		{"iter", required_argument, NULL, 'n'},
 		{"sort", required_argument, NULL, 's'},
 		{"output", required_argument, NULL, 'o'},
 		{"softirq", no_argument, NULL, 'S'},
@@ -337,7 +346,7 @@ static void parse_args(	struct irqtop_ctl *ctl,
 	};
 	int o;
 
-	while ((o = getopt_long(argc, argv, "bc:C:d:o:s:St:hV", longopts, NULL)) != -1) {
+	while ((o = getopt_long(argc, argv, "bc:C:d:n:o:s:St:hV", longopts, NULL)) != -1) {
 		switch (o) {
 		case 'b':
 			ctl->batch = 1;
@@ -377,6 +386,11 @@ static void parse_args(	struct irqtop_ctl *ctl,
 				ctl->timer.it_value = ctl->timer.it_interval;
 			}
 			break;
+		case 'n':
+			ctl->iter = str2num_or_err(optarg, 10,
+					_("failed to parse iter argument"),
+					0, INT_MAX);
+			break;
 		case 's':
 			set_sort_func_by_name(out, optarg);
 			break;
@@ -423,7 +437,8 @@ int main(int argc, char **argv)
 	};
 	struct irqtop_ctl ctl = {
 		.timer.it_interval = {3, 0},
-		.timer.it_value = {3, 0}
+		.timer.it_value = {3, 0},
+		.iter = -1
 	};
 
 	setlocale(LC_ALL, "");
-- 
2.43.5

