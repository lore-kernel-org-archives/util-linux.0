Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D9C270022
	for <util-linux@vger.kernel.org>; Thu, 27 Feb 2025 04:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631806; cv=fail; b=ePIUH0S37rbSQXj5pDxrIuhQr6c+TKm5lk1azlFsYSPdHVJbNy4EPbIUiIb/5koq7lIisUp7NCDFoq/llY3IFvEfmI6oacZvz+YeiKDKvLrDg/7lYLmeECERPIuIDHUMwt6BvNYsjyAVGFtThIkiJR4RjD4Is28xAUJH3K0h4HM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631806; c=relaxed/simple;
	bh=cjgZkRHq5RMXfV1Akxw8cv5ZAkjRVXQMquodIpvNLAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O0HfI+kCZH8R/lwMzFDvN3SZJG/D9FsyclfK2itwe1gyeXoaRZv67E7nrIueNaOrwZUyBudWUSDrD44tux4R+bpPbhWDGT7D8Ao5ICc++CYaxuZrP0UUVZjgLieTcco4X12TSvnJHJU1GDx8gW8TNrvr5ocJEMffXJw/AsNtQpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UAWlIxiz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DQbTU433; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UAWlIxiz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DQbTU433"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R1fvPj020065;
	Thu, 27 Feb 2025 04:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=4IhZdqlOOgF502mB16gUoA8m+NRFMg6/isacZK5eK84=; b=
	UAWlIxizDH5jQgOvvhbFcrADQvewInc3csfHXAqmsE+D3hecB4+GZBSQbzjEjZ5b
	R1XX016Dz7RmQMxqIitj5pxsG9HR+xlzoqO1qzKQpAX0zfC8dGcKfz/Xdx1RHmt1
	N8i3Z2AfY/+PbYaqz4wjBIa0weaSsnzsbdB4BaGGDA+J314KmeyUsQoFlQ+oph5x
	WJNxYkoGTnj9EIWkiNJqSvJiJcMwDzxMVqyvIeI1hj0BT21Ul6u2n8vAFbLESUhM
	k6aTwRHCpqgFE0cx7Ngo2ui+rQjoOy684zuomlf3OEE3PxLdQu8AJZoXQLfa0x39
	3wDUgMnKqsbPlTV2CW/GZw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pscanys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 04:49:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51R2q8Y4025437;
	Thu, 27 Feb 2025 04:49:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51j7462-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 04:49:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+jZeEbsZNpDyVdJHzJnW3K+hgkCDWBxmrn26sjxSnmYoLg2trpiGc/YevKhg22ww5IKhs/WZs2v+5gc1I2CZCim8OQcSrEHQ1eEUYkLlvi/22cyqt8dpd6EV9K8Y0S8ZWXDpzslg/aViL+0+6+M3tXAQOjO2V5JbTvnkh60Hj1kuAiGD7kaqaHiVyKtRqc2AYPbDZ5AhvZyHUQ0oapI/TPwbyHrCjR+UuBWY5julPUWPEWNyGdK7WnQalLawVHUztNZWTUO4TtazmReXs7//MZn4ecb10gMpXnJOZg3BRFgMNfPEs2jnCuCvibVe9c2ctyRGry8wnDPWoNlq6sGtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4IhZdqlOOgF502mB16gUoA8m+NRFMg6/isacZK5eK84=;
 b=Xw95w3bcyrZWhcaURUNQrGtjhmOMw7570wTaRS9SiCatzCPcxq4G5nq+MKNeMRmSGiB3chNjgnh5tTGkAjesnluXDGW0Ftpgh1DHbzf8tbdjp9E097Vl6ysY7FHu8Xo4BgmPiPbHq+2UarGp+myo04yP9q3l2rgFsK5+SvvZ2AkqKYAyOSbfl8qhyn94/bhb+PZsLhHxJoFT1hwQBoaxo7gria6LSYuWAlV8LxzwJK3+JVCVzG2vO3Ypo8ZPbHFtCD/NtwstUNvCKP1GtPTGBxLyWQ5B1F8G979UvolSBAeYqaT9zmZRQ1XLtvcAcUbzQnAaqUBOVxCtdg2DOGfejQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4IhZdqlOOgF502mB16gUoA8m+NRFMg6/isacZK5eK84=;
 b=DQbTU433dCWZi4IsLVNYSQOZPQY8fmREigZA5dgw2OggbH1ZJjaFZm+27WvUbDqrgIoTYuvaSiAm3G5I51gZ3AhaD7kT8qegByzRKsIAtrgqys1zdnyQoDr3YgFECKXgrmM1CGgR0rtNt0PTU3e2DRkrfM5B2+4c2FpdB4rDGys=
Received: from DS7PR10MB4944.namprd10.prod.outlook.com (2603:10b6:5:38d::15)
 by MW5PR10MB5826.namprd10.prod.outlook.com (2603:10b6:303:19b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 04:49:45 +0000
Received: from DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5]) by DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5%3]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 04:49:45 +0000
From: Joe Jin <joe.jin@oracle.com>
To: Karel Zak <kzak@redhat.com>, Zhenwei Pi <pizhenwei@bytedance.com>,
        Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org, Joe Jin <joe.jin@oracle.com>
Subject: [PATCH 2/3] irqtop: add max iteration support
Date: Wed, 26 Feb 2025 20:49:15 -0800
Message-Id: <20250227044916.89925-3-joe.jin@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250227044916.89925-1-joe.jin@oracle.com>
References: <20250227044916.89925-1-joe.jin@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::34) To DS7PR10MB4944.namprd10.prod.outlook.com
 (2603:10b6:5:38d::15)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4944:EE_|MW5PR10MB5826:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a5d90e6-f65f-4edb-d40b-08dd56ea27fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3NttZC/Hr2Ay95y+HsHUfHbFUjTendP1oWsmmXlivLIKkndXy6FPNBGdcQnY?=
 =?us-ascii?Q?0o/2tmoHtfyC+zaUFmJkk1pCJN5po7mDNcaaKTvzJuBoD+LKCivhw6Tw6VLF?=
 =?us-ascii?Q?fDmHxdtBMz+yzZsW8c4gxmacXils/3C8a9QKPuShl3Ijf3z89J7GvsWx7UUP?=
 =?us-ascii?Q?MFROK91kO4oNuWQw+SRUUKpvBUAdsVnxvHzRdVHjeN33z+Srm0wDNEr2wOjT?=
 =?us-ascii?Q?261DISX/9mQMSmSRmhnK/wsweO41h+y8PxQNCH/mmL7E2e7To2oyTfQmAaTo?=
 =?us-ascii?Q?Kl1eST7pAYaZ3AcwuPm0raVz2a4bYuCEonwioC4Ol3VmKsUmzOCdc1NLOP14?=
 =?us-ascii?Q?OAclzpYewkVojLdz+ZH7qlrJ1Iqd3A9cyaeWvW0anLkSMxcOTCypuhLQTdA4?=
 =?us-ascii?Q?tWziOfbFPyUIwqPX9nFGM9jF3T3Y/nWdTfkBkhH4/2gohz5GeSTgW8AQcubW?=
 =?us-ascii?Q?f6glGhhxTCG7qsA2iVYFqHJ6Llp6mbR5hq3wws0/V48344/KuZzUvBKqKeKi?=
 =?us-ascii?Q?nXFg/BiITG64z60jM5ciGs6Ucnmk8iiXBfo40ZhWMHqUnHhyH3X9cR4aMlCb?=
 =?us-ascii?Q?dN3b4tW4QA3D2pPvn6u/v3BkfA7oblJ5vfo3Tm2gT2wqWbGqp9oDNekcIO/d?=
 =?us-ascii?Q?Qgq75oihCKZiQGQWoAdEUGOXdUnzifcdGFU5R+OLfSRiRkuc748gXlW+JaQY?=
 =?us-ascii?Q?5PPtmok1EuBFQm8c0T43qWuify5hBGU63APayBLftNFSNUVZSEKlOxmWf+lT?=
 =?us-ascii?Q?TPZ0IIJ3lIiyxjyuhwC3jgMhYOieKtVPCROQRHHxnPyxhHDHIdM03gkIMDoO?=
 =?us-ascii?Q?A8NU6DNDusHVljZSEqtrZN+Cr+NWRZypbZoWi8nBvv6kCK2bct2KSZHx1YhD?=
 =?us-ascii?Q?wSc4vFUZxkgriqY2pvG/0TxMEZrFmav2sC64cexA9PsNIDRHQLREVtlA+8aP?=
 =?us-ascii?Q?9uXpKkrsJR4whUD+4JzfYMDlcl3fa98799G1ITtV845Tm/wDfEd0kShywI5U?=
 =?us-ascii?Q?rVPvV1KplisQQ0+Feq1a9Qxr45mYNEJayf1oDjjgazJG9FooSJ385yn8XPdl?=
 =?us-ascii?Q?ZCHqKV+o/gVQENk3ynbq1lWBTbJ8LU3UblSMBQbNPH131QRnwUlbGOcoz8IK?=
 =?us-ascii?Q?O3jBZLV5Vojge+Tir7Va6G8VwZAcJtdDL2ixjkYScXk4I82DvAohvWAz99KT?=
 =?us-ascii?Q?3F6KNUDEu1lMZuBc2rw4LIlf/yaIsw/7rxafsjYskgE/RDBY20P1OvXM0Tu2?=
 =?us-ascii?Q?1yzj/444uZRmmD63jya6H1ijrYsFSaguwlZunE1HE4qWhwxxpWum2rrjIvPh?=
 =?us-ascii?Q?D2eJ2wuYz9zmvbsCQy2I30M+QvzpXM4HNkxi4/xiD9myHpyS1bArTagbrRpO?=
 =?us-ascii?Q?vmC8yaELfjV/yXQE2n8eagtsJljU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4944.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xM9AGLS4g+lz4gfvmv5/znMBXXNp0WnbnFA58Mt0iH5ED+7r6jHFTRcZqS2T?=
 =?us-ascii?Q?Vo1uzNGN/HNpXQnUJFRn4WXwu2gIJTLBKgkE9qwQ9ANZ0PAydYivtpH33n8T?=
 =?us-ascii?Q?Hmb9m3yR8bnCzXsOn9aXvejqgTsEKHKEtpK0n0FtuNL7NyY885f8QbWmzSPA?=
 =?us-ascii?Q?4k4AVqW8cXljgiNTOs8OmG4Hg9ucKL1aAKlgRr/aZyBMLauxEdutB8mSLC3x?=
 =?us-ascii?Q?XIksC9UBXNcaI3r4gqhbZCw9EATrepLkRWvYiygolKTVebhoZkdTrMF7mNUt?=
 =?us-ascii?Q?sCJcbKRNcnIQH+0DG9IXVSCbWlKVdhv6AxqIAwhE2Xs7t2XkThNh7i5KWurp?=
 =?us-ascii?Q?kjdAkl67phrUwhH6F03uYlpi8QRHlQkWgG0xyJ9Fv7fZm8UmwGj1wHI6X3Nv?=
 =?us-ascii?Q?2LqVMEde+hTy1EI1kEBlI++eAtCK7tF86cczh455qVIyC+42sTV1ZWgv9agH?=
 =?us-ascii?Q?XylH5+XDamK3PjtC0nBumU9Y0ec0bhDC2UHDyQaMMmgZWnCDYidaqMMUDA41?=
 =?us-ascii?Q?pRFvLtmYMzUzBTaEfqkzWljr3ZLPBHmI8alnd4s3jeTPFkhgGOhcQUpyxMp+?=
 =?us-ascii?Q?rg/EGR0BmzGbaIQkNOxgmr2E5MZT5e+tjuh3HBoqTwgCeASEMQ8wx0JP0cYX?=
 =?us-ascii?Q?rowtpnqUlsFuh7o8vrL5F1DGSdwk8mnuDS1xfE/ikscn3EDr3v9rP002TI5s?=
 =?us-ascii?Q?wau85FkdGLdz8na6s7y9hM8dvSOJFxt0Amo1567XzFdEGj9ZiXq8OoFp4z5K?=
 =?us-ascii?Q?g+7Q1JcsMgYwJ/+6E843oPx72MIWx2DAEsSNwBLIoR72rC+fjBr99/UAYtia?=
 =?us-ascii?Q?fJ8zV781lxOYCsikmRaJA5h63QeahCaKA/x2chp68z9yVJAAvyaMGEe/GGcj?=
 =?us-ascii?Q?OXV9dIIp8pf8y9GbDFkGH56+hp+roJh3LWYg9S/HoWwi8ihJq263jZLKWFlW?=
 =?us-ascii?Q?fjvvLr6m9YH9SfHrFMX/jcSoECMOYF5vVZ07PgBL1/wAfko/pdHH5TliJ8IK?=
 =?us-ascii?Q?U4CijAYibUemdcoF300KhB/YX9Hn/JDfCp9q94XunsWC7OIx+BSd9d3iAO1X?=
 =?us-ascii?Q?IJuIfQJBEqdD6KXxlqK4A2fKt477VqHN9isNtBhnJ+1MMQ6QWGzr3GM0nf7d?=
 =?us-ascii?Q?HU5PGhxViT3V1wHDSTNYyrtohpuU66EkAjbH7fV2bySn+RyF9qaxzZhUVCVl?=
 =?us-ascii?Q?ueE7EdvL64VI3UrfKfEeFd51sl1QM0eQnaBR8OVBajkVKy6hrYxYPMhtRnPZ?=
 =?us-ascii?Q?5BkTVZtM/SsYAkBZZHAbnid6DXT6WqAwIA8yq8jxMs4mn8K2TXb3QxTT1OlC?=
 =?us-ascii?Q?5WMvXOgINW+Mt6TlqSlokLS3kFjeUxpXUBLpVy/ayUDgeWyzx9Q6lRD3CPkF?=
 =?us-ascii?Q?ho5hvUnoib8+kfpNarGp2N28Gmf2EHhaAV3oEdRUNGov3fPZ1Jk6xLoHY1dN?=
 =?us-ascii?Q?K9fhBt5D87Un+1vsGG/PF1d2r2OaTAHAkKrtK4ycaQRkhFLQlVGdHAijdBR5?=
 =?us-ascii?Q?M2SQ4TY/L+hjyLqcWlKkKga66SOtPDS0kTlGeVXp1qrAVi89aCrYbe2+2YRo?=
 =?us-ascii?Q?poYJrkCf1TfQdPv9WVzRbJIo7G6lPPpN/81T6CSw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	njNBk1U0+ZlqtwvoRBa+Ed7k2TN6u+RjarkTRGZF4YqpYFJ6tsh2+ORZ3y+sz4hhSKbz6Rvy5NSWuVapfiuddJzoSIfA1KxWoCYksuN6g6N2Vil7PknAK3uvufCfI3buGrjuhjaP8DNIvwcfscSpv9htsPopbyPzJbv6R/QSS1glfCSN3n/ZqO6yj3Li921zgcG+x1HgzpXaW9+gDdLWxoe56OGYjsbv3YTECq9qEThWm1GCP8agnbSMR3DGDrruG60Rpmc7J28CBrdnSBWOAnSksWtCkSPvFTfSW8ms0xhaK6tYEZjEyBDRa7hnuA+zwvj2jXh1LvTgfOJvE8Ey103qKpecJYBDPJ/RyaSKGmR8OysouvCLz8c8PAzJdrlmcwjpexQsqxPxebd2kh2fHaV9UZP9jXXKU4zQwwADVAii4u/E99vuJ3YVoNaN6oe3rOBqe4iwbGyqipm3PPvxalOLW6BilXbkA61M3xlLX8uru19HN9fm22/So1aNHE9qFImwHo/C9lNd33VNz/gWkMwAmVxpyCNqti9HnhHrxERyuMdTf6ppr+NpHTaYMnKpMVgIBVRBDZ+moLtlojQX/ldszrU4PBoS+T+CMMgzpQ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5d90e6-f65f-4edb-d40b-08dd56ea27fe
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4944.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 04:49:45.1290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EIn4H20tf3OYQPgR6yI+LRY56UVqeKPITlwrArzBT/Re2Y5B3lolobXFGF3HnnJ0VEGL8xtJQsL9yoLgDaGwVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5826
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502270034
X-Proofpoint-GUID: V0sAPmPiN7LMXneKngDVLxR2I-N0Y4Pe
X-Proofpoint-ORIG-GUID: V0sAPmPiN7LMXneKngDVLxR2I-N0Y4Pe

Add support for setting the number of iterations. This is useful in
non-interactive mode.

Signed-off-by: Joe Jin <joe.jin@oracle.com>
Cc: Zhenwei Pi <pizhenwei@bytedance.com>
Cc: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/irqtop  |  5 +++++
 sys-utils/irqtop.1.adoc |  3 +++
 sys-utils/irqtop.c      | 19 +++++++++++++++++--
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/bash-completion/irqtop b/bash-completion/irqtop
index 215281ee8..47b7b0af6 100644
--- a/bash-completion/irqtop
+++ b/bash-completion/irqtop
@@ -22,6 +22,10 @@ _irqtop_module()
 			COMPREPLY=( $(compgen -W "secs" -- $cur) )
 			return 0
 			;;
+		'-n'|'--number')
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
+		--number
 		--sort
 		--output
 		--softirq
diff --git a/sys-utils/irqtop.1.adoc b/sys-utils/irqtop.1.adoc
index e81f4fbb6..75cfe2e41 100644
--- a/sys-utils/irqtop.1.adoc
+++ b/sys-utils/irqtop.1.adoc
@@ -37,6 +37,9 @@ Specify cpus in list format to show.
 *-d*, *--delay* _seconds_::
 Update interrupt output every _seconds_ intervals.
 
+*-n*, *--number* _number_::
+Specifies the maximum _number_ of iterations before quitting.
+
 *-s*, *--sort* _column_::
 Specify sort criteria by column name. See *--help* output to get column names. The sort criteria may be changes in interactive mode.
 
diff --git a/sys-utils/irqtop.c b/sys-utils/irqtop.c
index 00bf8fe50..ba5680671 100644
--- a/sys-utils/irqtop.c
+++ b/sys-utils/irqtop.c
@@ -83,6 +83,7 @@ struct irqtop_ctl {
 	cpu_set_t *cpuset;
 
 	enum irqtop_cpustat_mode cpustat_mode;
+	int64_t	number;
 	bool	batch;
 	bool	request_exit,
 		softirq;
@@ -180,6 +181,12 @@ static int update_screen(struct irqtop_ctl *ctl, struct irq_output *out)
 	if (ctl->prev_stat)
 		free_irqstat(ctl->prev_stat);
 	ctl->prev_stat = stat;
+
+	if (ctl->number > 0) {
+		ctl->number--;
+		if (ctl->number == 0)
+			ctl->request_exit = 1;
+	}
 	return 0;
 }
 
@@ -285,6 +292,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -c, --cpu-stat <mode> show per-cpu stat (auto, enable, disable)\n"), stdout);
 	fputs(_(" -C, --cpu-list <list> specify cpus in list format\n"), stdout);
 	fputs(_(" -d, --delay <secs>   delay updates\n"), stdout);
+	fputs(_(" -n, --number <number> the maximum number of iterations\n"), stdout);
 	fputs(_(" -o, --output <list>  define which output columns to use\n"), stdout);
 	fputs(_(" -s, --sort <column>  specify sort column\n"), stdout);
 	fputs(_(" -S, --softirq        show softirqs instead of interrupts\n"), stdout);
@@ -317,6 +325,7 @@ static void parse_args(	struct irqtop_ctl *ctl,
 		{"cpu-stat", required_argument, NULL, 'c'},
 		{"cpu-list", required_argument, NULL, 'C'},
 		{"delay", required_argument, NULL, 'd'},
+		{"number", required_argument, NULL, 'n'},
 		{"sort", required_argument, NULL, 's'},
 		{"output", required_argument, NULL, 'o'},
 		{"softirq", no_argument, NULL, 'S'},
@@ -327,7 +336,7 @@ static void parse_args(	struct irqtop_ctl *ctl,
 	};
 	int o;
 
-	while ((o = getopt_long(argc, argv, "bc:C:d:o:s:St:hV", longopts, NULL)) != -1) {
+	while ((o = getopt_long(argc, argv, "bc:C:d:n:o:s:St:hV", longopts, NULL)) != -1) {
 		switch (o) {
 		case 'b':
 			ctl->batch = true;
@@ -367,6 +376,11 @@ static void parse_args(	struct irqtop_ctl *ctl,
 				ctl->timer.it_value = ctl->timer.it_interval;
 			}
 			break;
+		case 'n':
+			ctl->number = str2num_or_err(optarg, 10,
+					_("failed to parse number argument"),
+					0, INT_MAX);
+			break;
 		case 's':
 			set_sort_func_by_name(out, optarg);
 			break;
@@ -413,7 +427,8 @@ int main(int argc, char **argv)
 	};
 	struct irqtop_ctl ctl = {
 		.timer.it_interval = {3, 0},
-		.timer.it_value = {3, 0}
+		.timer.it_value = {3, 0},
+		.number = -1
 	};
 
 	setlocale(LC_ALL, "");
-- 
2.43.5

