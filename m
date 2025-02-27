Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38F03FB0E
	for <util-linux@vger.kernel.org>; Thu, 27 Feb 2025 04:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631805; cv=fail; b=BXvwNagWQb9Ikw8dRkPUMJ1kNrMWYy1Dh8EeIdVnrFeQ7xuCrubLRMIj9+Os4Lq4OOtONjDNsMLo3yaOblMyuimoCsvXUx32SqMf0YcctR447i3hh2ThbkACSXKAffRCnZbhfecTnCQbW1ZoDhGeKq77IKs4jG3usQ2G4N3uHkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631805; c=relaxed/simple;
	bh=LwRB1uHik90oNLWsK1jN/rfVJul1gGiCN9A3VScyRLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J3Lzgxo90p5X7tpC6KoaEFUMEipBd4PWsgvyIC8etbySuCDlLyv4VrIb6Gwe/7enV7zG4NVZnqPW50Fgueh17CTOj6FYrSxGQMl9UUay0dLlNwrzpT1WORPWA+Wx63T17YEGawBrWbePEl7NHkDZkhe5GZJ40QMsGTslZvdnu+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hYg9S1K7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y9wknijl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hYg9S1K7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y9wknijl"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R1fnO4027569;
	Thu, 27 Feb 2025 04:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=CJ3zfffaRvPiH+KGJD4J2R8SYGSZYasocEiDOBWT6d8=; b=
	hYg9S1K7nKN0UDtWVbMyiFuzLeDXKUH6AWJpKmiF19JBUoouzcOF+85sTXoqeuGs
	Xwor+4yYUWNtkkmqmUaJk/TdDgLh2RMb9DuTE7toFvk3LlLYb3DJqHcHfH+HPIzH
	TK+/HhFZzkNh4ECdvcaAFsyF//5nyWc/UKWlmQkhRurYFDqoT6VUaF0CWFMAwU41
	a2au3/TOWj1lCZTHOlDobeK9gjuMH7Lbl45HCRFBDcdNP+BOd0vnRpiYLgOaLv3A
	qRXyU6LkZstd4xtbgDOaxFNYMdoIblzK5M3BF0RAnnd9JGYTsn1SXG1WtEALZe2c
	7W8LGpWiVbosipKNKjNw+g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psdjmct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 04:49:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51R2q8Y3025437;
	Thu, 27 Feb 2025 04:49:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51j7462-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 04:49:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DB/Ghud5atetPZ7OsqF5XXLM2MAZoBa/0gAChhB/e+jgHsW31VB7rujiqt6uzsO2eC5TREa2LGBcraT4Zx9eUBWeh2G8ymJ/zMlkewQQJKgNPhRcvqNpU9rDjl2PAMqAicywA+lHr9TrQEtTYx/PY4BHHaHpl26cRNYPl+e60Ax+IcDfDIJzxWzVVBn8UJxHGEZDIN/uA/Zf7T+4NRIUGd2JV8cCEB3YzSGReTklUBnc0GEQeCV+KG3pagGLZkiC5XgyMMLUympjZzdI7KXh5CVvJKTchkCu9SrCbvVA4rLiz7dzXhoLL8BXSUk4TPVdvjoITVfBeKicPvEoa0eH2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJ3zfffaRvPiH+KGJD4J2R8SYGSZYasocEiDOBWT6d8=;
 b=LrYUDlHkgZjxR/yCDy9X9+HU9Yf7HEY7IwfJQzSUp5E/SGO8Itsai6RCCWyhu7AeofR4r/euGZz1XH7gg9+QYEOpLKJFR/HGidC/V4bGLoVBm9KaOqE+1DNwpIlcOTOYtapBQDjQkYvcRP+LFHgvge8IAnPIJTldd6zAe7U8/rK7iSe3CTgcfb+gSGbAKzNWQeePgd9ZyfIGREW+3ZP5c7jsZSw69Lwx8etDGD4zWBdeWFjELMBJiHqpua9hOysXDca+OC3frgdaX6U+6wG8Jj2OL3AANw8dwcvxZ42SUc3aGLUoAX2m6jA66lrXprvR5s3T0ehNUrksvPj4bGu0xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJ3zfffaRvPiH+KGJD4J2R8SYGSZYasocEiDOBWT6d8=;
 b=Y9wknijlms77hlg7mLknZNf6iX0xjjWklJaRHyrdTIa6zZ7eH9HKS64e9IsYyM/0vx3ZMdvdh1tYsJuTEfdxd4SrZCTM+CfUPbxJK9BnbUAPm09ZCYkZs19NbPokYorYAy2wmq7pjzgC8xAtQapAUoM2BK2w8tNQxk1iIXY1wyQ=
Received: from DS7PR10MB4944.namprd10.prod.outlook.com (2603:10b6:5:38d::15)
 by MW5PR10MB5826.namprd10.prod.outlook.com (2603:10b6:303:19b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 04:49:42 +0000
Received: from DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5]) by DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5%3]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 04:49:42 +0000
From: Joe Jin <joe.jin@oracle.com>
To: Karel Zak <kzak@redhat.com>, Zhenwei Pi <pizhenwei@bytedance.com>,
        Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org, Joe Jin <joe.jin@oracle.com>
Subject: [PATCH 1/3] irqtop: add batch mode support
Date: Wed, 26 Feb 2025 20:49:14 -0800
Message-Id: <20250227044916.89925-2-joe.jin@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250227044916.89925-1-joe.jin@oracle.com>
References: <20250227044916.89925-1-joe.jin@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0056.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::31) To DS7PR10MB4944.namprd10.prod.outlook.com
 (2603:10b6:5:38d::15)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4944:EE_|MW5PR10MB5826:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d39e3fa-99ae-4e10-191a-08dd56ea2649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ezOWNNQchA8JRpOvEJKVUoAdvGW4DgRYrd6ITsx6xtacLyyPqG8YUpnWHjYa?=
 =?us-ascii?Q?syBlKN46JEpuk1HVfQUXetIjDnf1PtTeF5GdI+wFBTWouBorSPigq/Mt9QJE?=
 =?us-ascii?Q?eVPOIo2gHtsFljQLF/flNj/2wmQzJ8cj37yO71pfI057UU87eIDx6wKpqWpa?=
 =?us-ascii?Q?hqJhwihoX33lV64RKjm/c7lMxRVh8i+War+vLB/24Wl1qzpuDrQ0b/pocNMK?=
 =?us-ascii?Q?P4LnkkrB354pMRp1kBElDnc3TOpEiYhtIKL6SX0hk0mWbp8LvE/MgiStsSwZ?=
 =?us-ascii?Q?D0WmjUGSYN2F0p4fIVBLlrflzzDTyIuWWvP/b0mGK+KCadPcpGLAoNVbYE5j?=
 =?us-ascii?Q?AlfmgbpdaKSuh+MIdj4zW0bppuFhHkA16L9hbDUYUXaQLQ1/DJM1ZsgveZx7?=
 =?us-ascii?Q?erfJlZtmE3ftLs7a4NRcCFCYcISia87gkMdO73qEe+DWnl729XffWFHzfbF1?=
 =?us-ascii?Q?DxQkA2VW4Hyp0+FY/3cax3QIQM4ReMyhmmqUzQX2bfTVw0/iV4hP27hXA5Jw?=
 =?us-ascii?Q?uVTAI0CvjgX2j86ouL4bhRg9O1uV6ArapYqLxuxn9pwqX6PptTAtz/12PC+v?=
 =?us-ascii?Q?rLsFM0seVZDyIDr7K2ThlO/rh3TDez8/8YaI/a2CUJOyaAFEUVBFR2QWXmAd?=
 =?us-ascii?Q?g8GyIn/OekxJdHIwg8n/Dte3TgAy6vJXwYWJKLgMv7C0jaiOx6zdF11edRK3?=
 =?us-ascii?Q?AO7PUCbQ3BoVJvZdbbaAoNyqk8+7qgk4GDHOlwuHBT5aVvjmjxaskz8S/hvO?=
 =?us-ascii?Q?6VYaBMyjO7QXsBYJt3XyAENkLvQ0AoLo14CRdb5MAPR1bq1IlmwlRv9FUxoa?=
 =?us-ascii?Q?CACv4GDmgV8W1RLmMRTjJ+23vGUE3GD2iI1Cw38WavFtj3+jIgzfn/T/MsrL?=
 =?us-ascii?Q?uGpvyMpVxJiSpwM9iPOa8swUKAWU33/L6IoOaa64liW/h0Wp+dglqaH/uwLk?=
 =?us-ascii?Q?s0OkF0WQ6MNurqp574ZA0TKUvc6tH0ynUXVIl0EDS/7qK4ZZXaDFUTuHk2dP?=
 =?us-ascii?Q?nVeZAhi3XKyb9g8qz2dw0nDH1Ic3PZ7Bjy5gszm0XwTetL1/Cbu7w4GvsRO3?=
 =?us-ascii?Q?ipn+o7/6sVoIH2y5k1HCtWxoAuHEURvN5coN9z++eh/vXYQ3O5ZX2eEWrnRT?=
 =?us-ascii?Q?Hnl/3nOXM99rH0w3a8YPlhCaC6DMY5YTEB02F8ZA/e+ANqJbONYilS8ONylX?=
 =?us-ascii?Q?MMb3ll7N5l+FvmmcjbOGWxVRtlhHifV6Vcq4HV+lkAYeG37QXZ2WXKfWbCiX?=
 =?us-ascii?Q?zuV0sRFwEJ2xhSIVANmIM0ryaK9rnt0oHCFcbApzPUbmkCoUnDfwryHTJ4cL?=
 =?us-ascii?Q?bOrOc/YY9DTbKF5WMxPAsjydXM+YBpZSZ88IzphBMumdJvGCY6cZqBOr8LCe?=
 =?us-ascii?Q?OBkJt6FS4BOjuLGTkSn9hgS8Kqgx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4944.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rt3y0cwxgYql153A0yvbHTUCUQYo6+V3Xsv4i6i0d/onY5wWnx8kgtSW9nzg?=
 =?us-ascii?Q?BnRXxWvuPHOhKUn9yQZbcANMTi1z+zm4vi0BSDu/gAP9RARVPKWL/NxS+4Ip?=
 =?us-ascii?Q?lJW6hyTCIsGlRTrZePkgDRlWHnhaXl5tPBOsanJVwOOE/b+sqIAQFjNRvaZZ?=
 =?us-ascii?Q?b7E4epQmgy36z39VSOTfykQSGFYfKuAQqgBNLQd28DkDEBAb3BsVWFPMbYSQ?=
 =?us-ascii?Q?cq02H8QgQBXZw5q+O/aWKBOXGxXFke5e6YR+LBedbnjGZyUe3h+c9JzKUBcB?=
 =?us-ascii?Q?DGFR1NuUFLpc7w/GZRbodj1Rc4zl+6Pu5iPhIjJbYPvmbT+viAzX40zlP1Xg?=
 =?us-ascii?Q?zeouHFnBSqCF/g/YwLYIUNCWyLnTiZmBFb2mryFVL3QyfK8Kk249upHdBS8A?=
 =?us-ascii?Q?VlF70nJYDlt37qFqYRDEEZxpOoyp8B0IYEkE1qofMkoAWCxZHO67qzV/0Mo/?=
 =?us-ascii?Q?g8udoDuVr320THS5lTO99ytJDcIHewna0rAYZqWbYYG4ywU4kxVvYdtSrIJ5?=
 =?us-ascii?Q?qsrnLHjmXSZieO8e3ZuVtLFipUhfW/496h8BK0YadKsIJCp8Fq63eLGICzJO?=
 =?us-ascii?Q?6lJWe/JP1icmAsRJmbbeYEcO958f0AixyaySvRCi+elBT25dbRN8vIVcsEz3?=
 =?us-ascii?Q?9LrWo4KcBi2WhfuVD7TaqrMmSrdoFNUHPcNYIRaXBbqu5MaFEG7vTVUuaRw4?=
 =?us-ascii?Q?pqnL7a76SYPpkkrhaR3+e1w6ZeRtQZG5V/unPBP05pe7BeK5nccHZib4nI9B?=
 =?us-ascii?Q?fh59r8rhaSUnwuoitUjMGcxR+1P4EzVMmV1Imy1EMhgxsJXDq/FvKoBT4ert?=
 =?us-ascii?Q?V8cWow/U3D/LXDlxxVJDR59ZgoT35u/ERh0JOp9336uPxpo+6zq4rEZuznHI?=
 =?us-ascii?Q?pqtl4DW47TkG2m9fOm40OK89kIumr5fWb1+bYmkp6iKHeEcGS4hIzR7BYqjx?=
 =?us-ascii?Q?pRi134vyu/qfYIv9rJOL5yBzQy51kyNhrk491iMo7RU2ezWYW0qramlfXR0w?=
 =?us-ascii?Q?kfkrZYoP4CN6PsafFwo7LBTRyq6Q1L87PJvz8ZxOOrYedlQL4FD0fDh0Aefl?=
 =?us-ascii?Q?ZnXDXy2yW7S3EsTGpdr+yhZKunf03YqudqmYUFRH2qUO6vlYOWHykJsGsyXO?=
 =?us-ascii?Q?zHqeMIaB7SdRrpzWqIWfVf2eCVG+D0gmQ4nIWh+Du33xuy8KmnxeHwJUlBiY?=
 =?us-ascii?Q?mdVWio1FCLiDPyQBJLnpGy+913TUFrnaUA9GgU4JJvVfPp9rHaVwM6HGrB9Y?=
 =?us-ascii?Q?80zzXzO3fHLUBwjpLTJOv5wZwWVtZ61T7CX58VSvNnDbhzkk/LyzHuz1GSun?=
 =?us-ascii?Q?M8s7ehyDTNPoFF0bpqIoUNVVykkOi2dyIvwnXnJBOGmf6/1+5/gD0jX1sNZz?=
 =?us-ascii?Q?YLxprJ6p0GCfQTOStS0porVGvCeFmZ88gjby0xB4bcYTJGyE47eeKSgWdSoR?=
 =?us-ascii?Q?IdiWw2omp/BFTKQB5f6v5hA1Ay/PRwXFzsv1ph0DQXBsA9MlJOox7xZZF9Lo?=
 =?us-ascii?Q?bK0QqqmYLqXyQXISnYRaIVmswiVZJj2mA4LXbFcnyYxb6yU505CiOjQoijqB?=
 =?us-ascii?Q?HR0hsIJj+WKTE+DCXk4jQyxwf8lx5wbEMZk3S7Pe?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zX446LdJx8rNtpegXv/Ufb/qY2+cGRxFkB6wnO1prVPxn+M3Wt6fw108oInX+un8VNEPF//IpQ47w/NCCyQtLLZnNlUutjzXBZNokE3Pq5Nw7OQ8/eZ9iqZ5rFH4PsIeJzy7FaaI18wQ8bJRNTYr3NCi4RW6vG43KUr37IzANBtUPUO/bEvI5cMs0fmiHDjpPyg9PxYe+zOPiv2/DSdihZp0xXnzDd4epY6vpVlna0BuwXt4D5ak8+wC+IQgrHuS6EqP/z7EArHuKoJlGTWnQp3RFLncH8alJvkWTQEybJPdviJNNhJCzOZ+g6QRphsPWaDRHzdDnsBwbI439sTDuxG/xBD8anYhihVoijCkDSYUNULRuOybr1ifBy0Ex7RWo/ZuEWHZ9PZXJqwHb4vlO9Nkb32jm5Q5JK5QBTZhSbVmI8q6MjOAt7DLKimwUDcWgkaBA6boBofuUjFiRjoGJksCu8YyGXjQb7/9wml4OKggLbrw36q1sLQO4SiX6dONdlX6ZH8XmBexgiG/5p1U8zpnUu/ORp3Ti16hz663ZLkSx3XAvvzaNNaYk9iI3iL+PxmgA2+/eQPSDOm4NTMUDeGMLWqNb8ch1VaNKkYQJx0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d39e3fa-99ae-4e10-191a-08dd56ea2649
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4944.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 04:49:42.3742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xK9TZVsi1m6dreHAPa46dpQD34bgmsH5YsFN2yhbRmWXLuohtATIZLjqpDTIuRMaA8wlPdeE8VRHcnPbQqUAqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5826
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502270034
X-Proofpoint-GUID: r1a1isR1H3VtH095bJOmlTONd88jbDpV
X-Proofpoint-ORIG-GUID: r1a1isR1H3VtH095bJOmlTONd88jbDpV

Add batch mode support, which could be useful for sending output to
other programs or to a file.

Signed-off-by: Joe Jin <joe.jin@oracle.com>
Cc: Zhenwei Pi <pizhenwei@bytedance.com>
Cc: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/irqtop  |  6 +++-
 sys-utils/irqtop.1.adoc |  3 ++
 sys-utils/irqtop.c      | 79 ++++++++++++++++++++++++++++-------------
 3 files changed, 63 insertions(+), 25 deletions(-)

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
index 8fbedb16a..00bf8fe50 100644
--- a/sys-utils/irqtop.c
+++ b/sys-utils/irqtop.c
@@ -83,10 +83,22 @@ struct irqtop_ctl {
 	cpu_set_t *cpuset;
 
 	enum irqtop_cpustat_mode cpustat_mode;
+	bool	batch;
 	bool	request_exit,
 		softirq;
 };
 
+#define irqtop_batch_mode(ctl) ((ctl)->batch == true)
+#define irqtop_printf(ctl, fmt, args...)		\
+	do { 						\
+		if (irqtop_batch_mode(ctl))		\
+			fprintf(stdout, fmt, ##args);	\
+		else {					\
+			wprintw(ctl->win, fmt, ##args);	\
+		}					\
+	}while(0)
+
+
 /* user's input parser */
 static void parse_input(struct irqtop_ctl *ctl, struct irq_output *out, char c)
 {
@@ -128,16 +140,19 @@ static int update_screen(struct irqtop_ctl *ctl, struct irq_output *out)
 			scols_table_enable_nowrap(cpus, 1);
 	}
 
-	/* print header */
-	move(0, 0);
 	strtime_iso(&now, ISO_TIMESTAMP, timestr, sizeof(timestr));
-	wprintw(ctl->win, _("irqtop | total: %ld delta: %ld | %s | %s\n\n"),
+	if (!irqtop_batch_mode(ctl))
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
 
@@ -149,13 +164,15 @@ static int update_screen(struct irqtop_ctl *ctl, struct irq_output *out)
 	if (p) {
 		/* print header in reverse mode */
 		*p = '\0';
-		attron(A_REVERSE);
-		wprintw(ctl->win, "%s\n", data);
-		attroff(A_REVERSE);
+		if (!irqtop_batch_mode(ctl))
+			attron(A_REVERSE);
+		irqtop_printf(ctl, "%s\n", data);
+		if (!irqtop_batch_mode(ctl))
+			attroff(A_REVERSE);
 		data = p + 1;
 	}
 
-	wprintw(ctl->win, "%s", data);
+	irqtop_printf(ctl, "%s\n", data);
 	free(data0);
 
 	/* clean up */
@@ -212,7 +229,8 @@ static int event_loop(struct irqtop_ctl *ctl, struct irq_output *out)
 		err(EXIT_FAILURE, _("epoll_ctl failed"));
 
 	retval |= update_screen(ctl, out);
-	refresh();
+	if (!irqtop_batch_mode(ctl))
+		refresh();
 
 	while (!ctl->request_exit) {
 		const ssize_t nr_events = epoll_wait(efd, events, MAX_EVENTS, -1);
@@ -227,10 +245,12 @@ static int event_loop(struct irqtop_ctl *ctl, struct irq_output *out)
 					continue;
 				}
 				if (siginfo.ssi_signo == SIGWINCH) {
-					get_terminal_dimension(&ctl->cols, &ctl->rows);
+					if (!irqtop_batch_mode(ctl)) {
+						get_terminal_dimension(&ctl->cols, &ctl->rows);
 #if HAVE_RESIZETERM
-					resizeterm(ctl->rows, ctl->cols);
+						resizeterm(ctl->rows, ctl->cols);
 #endif
+					}
 				}
 				else {
 					ctl->request_exit = 1;
@@ -245,7 +265,8 @@ static int event_loop(struct irqtop_ctl *ctl, struct irq_output *out)
 			} else
 				abort();
 			retval |= update_screen(ctl, out);
-			refresh();
+			if (!irqtop_batch_mode(ctl))
+				refresh();
 		}
 	}
 	return retval;
@@ -260,6 +281,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	puts(_("Interactive utility to display kernel interrupt information."));
 
 	fputs(USAGE_OPTIONS, stdout);
+	fputs(_(" -b, --batch batch mode\n"), stdout);
 	fputs(_(" -c, --cpu-stat <mode> show per-cpu stat (auto, enable, disable)\n"), stdout);
 	fputs(_(" -C, --cpu-list <list> specify cpus in list format\n"), stdout);
 	fputs(_(" -d, --delay <secs>   delay updates\n"), stdout);
@@ -291,6 +313,7 @@ static void parse_args(	struct irqtop_ctl *ctl,
 {
 	const char *outarg = NULL;
 	static const struct option longopts[] = {
+		{"batch", no_argument, NULL, 'b'},
 		{"cpu-stat", required_argument, NULL, 'c'},
 		{"cpu-list", required_argument, NULL, 'C'},
 		{"delay", required_argument, NULL, 'd'},
@@ -304,8 +327,11 @@ static void parse_args(	struct irqtop_ctl *ctl,
 	};
 	int o;
 
-	while ((o = getopt_long(argc, argv, "c:C:d:o:s:St:hV", longopts, NULL)) != -1) {
+	while ((o = getopt_long(argc, argv, "bc:C:d:o:s:St:hV", longopts, NULL)) != -1) {
 		switch (o) {
+		case 'b':
+			ctl->batch = true;
+			break;
 		case 'c':
 			if (!strcmp(optarg, "auto"))
 				ctl->cpustat_mode = IRQTOP_CPUSTAT_AUTO;
@@ -394,16 +420,18 @@ int main(int argc, char **argv)
 
 	parse_args(&ctl, &out, argc, argv);
 
-	is_tty = isatty(STDIN_FILENO);
-	if (is_tty && tcgetattr(STDIN_FILENO, &saved_tty) == -1)
-		fputs(_("terminal setting retrieval"), stdout);
+	if (ctl.batch == false) {
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
@@ -412,10 +440,13 @@ int main(int argc, char **argv)
 	free(ctl.hostname);
 	cpuset_free(ctl.cpuset);
 
-	if (is_tty)
-		tcsetattr(STDIN_FILENO, TCSAFLUSH, &saved_tty);
-	delwin(ctl.win);
-	endwin();
+	if (ctl.batch == false) {
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

