Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204D626B2C8
	for <util-linux@vger.kernel.org>; Fri, 28 Feb 2025 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740759245; cv=fail; b=lhO7FU9MaRW5IeELVgMpw/pAQlnseOhZwfm9epxXQmgHoP88/j2NwsPGLBvGGvNnNRPzAZ4rElYUfH7sbbUz6X/7ExkDwo+2BZhF89Ii9ix3vICtsn5W338rxtCy8xGXFm6iUihRZkndC5O68nf0r+2a5ExmrR2sZ+5Pn9Jdx2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740759245; c=relaxed/simple;
	bh=bwtVQZJOQior/4wfpAnvlOXDTEsxSci0NidSFgtFT/8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=egCrshv3fveMi912k1NVbAGzwEPtusOV/Jjg+qFYPExWe8g0tUL54TrXWNKHJx3DTsypfIj2iX6QcDbmyEPpM/MBvXh3LUwWNtguffBf1Fr9mbZ+vx1LvFUkgBjKgE75mSBw5gGQtABYSvuDrEaN4wJDg+8VK7twnsU4r+qbFTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZvPA+oVa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I5gqwaHi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZvPA+oVa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I5gqwaHi"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SEGuXC014683;
	Fri, 28 Feb 2025 16:13:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=rbjN4crolykVgYuK
	PApVqkXVUSqW3mrUkCQ6wijQIEA=; b=ZvPA+oVayMa/FsDtM4ZAkMO7FCm/Na8c
	zeNk0zSx1Aji/JWf8bzbVtgdoQhVzuF61ZgkwjmbAaAoiWgLYxiv20nXNvc/+AWI
	svMBL97kPwG5CH8F2af2k6WcIyryi0gWYJuz0GHXoGxHUYw8YGJBtKp0eB31foas
	j++dmouwfv18Xf+fA1VaSdcuzgBDhtBFLtr6X/OeKXKKblE2fCVT1ejDno82FFH/
	Ew3Iu/n7yMiKACHouR5a1la28mRpt62tZlffqKgDhWMyRAzRPA8sVgqdj1MvE23K
	Bpa10PTqh96hrwrZB1ft6znOi8kapou0psX5tr7AQWfyhyUzW683og==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pse5vhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 16:13:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51SFEtUJ010297;
	Fri, 28 Feb 2025 16:13:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51dgspq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 16:13:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+5aAMgoUTygi0kAMaShikhC4+nC+Ew9UBg5B72/rywKePD0gvT1tjuRdiPy2DPx1JDVh45Aq7TP7D6NoDKytp4rFzzQUemtZPe0KaEZAgVR3tqhZaYgW2AW6RqwBxoYNn++UKRbbH1L63cdGczpROPKjJauO5KpFtZVDH2yU8BWI6BZlVRaK2Opt2VKaeoIuUydiTPlXrg8hH45t3Hw/8Aml2OslYlIzhRDO+SZAZtzgt711DKVpGUSzHKK6AfW0bQAc/eSiiCRHtSODyXBMRHDQvulDzaZcjMNG08nsHM/f1P0OzJNdJTfRNfvv15wshX2brPHFAs7hcSjdO5JNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbjN4crolykVgYuKPApVqkXVUSqW3mrUkCQ6wijQIEA=;
 b=oPqiSRxKSMlafGhvRXKSYmlaiNOE3ypjsDJXWg5ZYRdDnc502Ah7QdpcjBa3RDReyUjsqqN28cCBmK/N5xlZ3jwNZ/3ThRjAPmR+cP/vyrlorp/wOGnu3zVR9PIJd8cTc4tIfydtuaTjwqVlquMDvMZcJ+UEIXKdm+Tt6UlJJJvYxl7wbKybfePXy3X6B6umVD6BgNpC1W9HKpf/MRLKtZXysm+6fYHPXuvnaQQLnHUu6Gn1JqNQDmd1GGBu2N0hix0CAspNFy6hhbraxncBWg5gXprw4XxnkM/lPmHqYeZcfUKbSLElE+BXtMHXfCtlGOcdgvE/YK66QkkJG+nHrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbjN4crolykVgYuKPApVqkXVUSqW3mrUkCQ6wijQIEA=;
 b=I5gqwaHi5V2eHb/bNDpW0VenukrsGs/2rqilLeDao3EgeX/TBi3M5GFpgCmypkhykLlnMP06lWVtRLebp8o+qgaMIsDnXp1SMWSYSJXtEefb8pJzufCxs8sJCd0uEluU2GCbJCxnlStIIQROe50WLTjDZucXziA7WPJ85lqDxl0=
Received: from DS7PR10MB4944.namprd10.prod.outlook.com (2603:10b6:5:38d::15)
 by SJ0PR10MB5671.namprd10.prod.outlook.com (2603:10b6:a03:3ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 16:13:48 +0000
Received: from DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5]) by DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5%3]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 16:13:48 +0000
From: Joe Jin <joe.jin@oracle.com>
To: Karel Zak <kzak@redhat.com>, Zhenwei Pi <pizhenwei@bytedance.com>,
        Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org, Joe Jin <joe.jin@oracle.com>
Subject: [PATCH V2 0/4] irqtop,lsirq: Miscellaneous enhancements
Date: Fri, 28 Feb 2025 08:13:30 -0800
Message-Id: <20250228161334.82987-1-joe.jin@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0289.namprd03.prod.outlook.com
 (2603:10b6:408:f5::24) To DS7PR10MB4944.namprd10.prod.outlook.com
 (2603:10b6:5:38d::15)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4944:EE_|SJ0PR10MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb3e946-51cb-4d21-7c91-08dd5812e242
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?phsX4mF9TZkmspp2bUSUvMSsvASyAbpvSkn754uFPffPPwe21mHis2goPB0o?=
 =?us-ascii?Q?Is1uEk6jKWrBca3SLDrSqsbQLb440UrSsmWGIZdnKihOtVVc7wsLjbatC0d1?=
 =?us-ascii?Q?S9yHryAgmgvcn9JsxOdWjYeFRsIEdroWHLnf6RN87GiLB74MzWNHf4Q8vg5s?=
 =?us-ascii?Q?FowcD/PL7VE/ocbpF2slc7Jr6ctLQO7xEc9Wa0hJ12D0I4dljnU643SuYz3o?=
 =?us-ascii?Q?JG2GDnFZWmtL3FHgMtEDZcdckZWQClv9TkYjfv/8fjozbydOqzlQvQuKiKSW?=
 =?us-ascii?Q?OuGE+Gt1vSf45LUAPvefKvX/KaPrZYU7PBEkE9UHc5pfiHRflqJdoUsFQhkO?=
 =?us-ascii?Q?+c9C+VY60wc3l74bDFexlxTKjppHX1+AImTCV3G7EuUYUsdhmcBLEL152U4G?=
 =?us-ascii?Q?3jCbAbmCUhx94MFaLc+bpYpG+m+zi6kryKnaXtyDSPjnCW5Gj/agGyZrOoSd?=
 =?us-ascii?Q?F44BcvXzNzvouEZGIDGRZWf3AOes3MqlEAWf8JeWQRpLo3nQ+k9EL4dwo4rX?=
 =?us-ascii?Q?NYpkplO6giJHY/Ro+n6RLFetL7B0NA+u9+aIAMbs1/T41AcI3nqg4IkGLXx6?=
 =?us-ascii?Q?wfxlQ/XkZ8MFntDk/Jzgt0BA2HkbcCpbLkzybFi9r7qYWOCFxVdkf9KHvU3f?=
 =?us-ascii?Q?3vvz0gbseFIt/LA45hh6CxkW88kzH55BNkDD/WIwsjnbwI940BONw1DOtt89?=
 =?us-ascii?Q?g8ZZHYJTvc0SqjRON5wRvDjrbH7tn/BWYilUhmJ+jUbKRlKwe+puudZnMA91?=
 =?us-ascii?Q?DoAWcnxtsUNTsJQMVOqsiDFcWs+aq9/0xFrh2Frj7v21lONDg5zy7LT+Wf9n?=
 =?us-ascii?Q?MsijkbkFQVl9t2voKjGOE9QNb1Tx7vI7/DZgqNur3YyJ5XIt5hKMbXjfpevy?=
 =?us-ascii?Q?Lbkj1WBGIfYrtpjMKnjcRfU7b2zzaW/xLbvVS2Peb/6kwas6Z+/s6sDH/Cck?=
 =?us-ascii?Q?sQI9+2GPv+2CiT3hIC039BYzPKPx4uC84lKCS+XoRGJyQbkChpDjqcud4oBF?=
 =?us-ascii?Q?x3xcjsfRKpXEbKUhx8aI867LWFvs5xhBRYP5LNAC6uzEbLSxHAbGxaqK9uBC?=
 =?us-ascii?Q?oz3TO7LtbPGc2zxH22kxKH6hKZqpFiX2s8BMe2QA7QEoPwvU+rV547pPtz90?=
 =?us-ascii?Q?41S8SB3bnImBqTxZ5hfvs1BGsODkxcj/97tn8I1Gxx/NvelBTBOzjixgab33?=
 =?us-ascii?Q?gNp/KLyNpzyN7ppwnJ7LuBksV2uwlMSdO3MnW6Rbdb05stlL/M65XbbqKBuF?=
 =?us-ascii?Q?e4zquNGIOrq3EeNPiSfbggu5QmqtslZR4Mm0z5J23eLuurTbJIemM/S7pRN/?=
 =?us-ascii?Q?vmPp5GO4O+L9GsdAq+DYAHETpvoO8Os3lLHABub4YlECqfRe2RqKGZePGVos?=
 =?us-ascii?Q?oItIGLw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4944.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OBt6oVHew0Jn0nswHGICE7TDRRMIdHcs1NMZQAmohdN768cbJDUnObH1BHjT?=
 =?us-ascii?Q?rk1EQGEC5EZnN5CbSEKEr8/QVUVxjybirvdtwijLtyz1WtxkIgFACPwLn3GW?=
 =?us-ascii?Q?ap06n1OnhJNqR4xi0nax3XDbYYqP3SLuTwv7Sm2KyxU8msp00IZIE/1X0x2I?=
 =?us-ascii?Q?5eZFWJCaOqHJ+/2rCNnISUkVQM0NnqitE6HTPHTqwg7zT1xuaHi5XmzAbRQv?=
 =?us-ascii?Q?l8aShdLsULnpzWGcPjW/eytNI2xFXcdxg8YcDCmk/+b9tjxBdXmkf4cyD4in?=
 =?us-ascii?Q?7mE+y1bRt/BCqIrqYoaXmsIW7zIBU88sJbXsmbt8LzqeomC3MhCAypm4jMsj?=
 =?us-ascii?Q?pinWSkxr36u+eUJwOii91b67tsizfqAWX852mmiY6L2ey/Yw/0j9OclVMlZd?=
 =?us-ascii?Q?BNN5oj2JW/L+vcnNiUDyY/pttW4U17LhmyC+OLbqP56SrxMBItuNdBV14n8+?=
 =?us-ascii?Q?ncWXApJCNd+Oe8rPEW4e1xH6Uaf/d4F54hOwQAE5TiZH5snsKwTvemeUbv/U?=
 =?us-ascii?Q?zlaVecM5u3BATndpwZ2we83SjKo4M7PxwllEGbQHzoymq7eDNBAGri6bBOwZ?=
 =?us-ascii?Q?AOV5RzLNA9nVAq+31may8CoOPXX5WHrwn72wAWz5fshxRtMYpvxNhXhAAXwI?=
 =?us-ascii?Q?2CNeEvjAF46kC0HWgfHQwXA6oEYN8otZ4A0MsjJtzK/nsaMQ0bhQSJtr/pPi?=
 =?us-ascii?Q?X22izUV485AIyzEsIPkmE+7sIFdWdY3AKW3yzt15tsNBNuDYLAketTITqwrg?=
 =?us-ascii?Q?BF3+z36fPgBl8CiqY5wilEBkpp6tWhDssihwAeZcle0BTSNyGjIQup3geGsi?=
 =?us-ascii?Q?NElPg0HJx2N+/xnu8HDs/dYJknSl1wEzQGCzQxhJjPY3mGdK8O1Jwc1uszaM?=
 =?us-ascii?Q?OGjILpSe3r0Ph4uSf3JTpamtfWA+Dj5OqW8x/i7VwOLydOfBJebtuW4a5x7s?=
 =?us-ascii?Q?oK72Lk9xvtqVkZDaT1zBPAXgGrmkkdIE1zz2Dpo/QhcMH4kyCtJ3PB0/xHYZ?=
 =?us-ascii?Q?pOWkElimhKKyZz8deD/It08/9uUFuv9J+91+PD2rAK1pkC31o0pTUdqms+60?=
 =?us-ascii?Q?C/mLJV3IaLF/GCkHGyVER/g4XVpq7XdVSRaDDq9nY53kL6qi8FWRQWCDJEjz?=
 =?us-ascii?Q?ExchNOYt1v8OthRltJpJ0NY2od8P4ZA1bikIq6r9tMfHcK4kmm7SUladiiKr?=
 =?us-ascii?Q?usoiXRIfMlJMr/n/chfxxq4I4NY0wHgyiq6UmITh7+aucf70vrpbT6/cOYW3?=
 =?us-ascii?Q?zj9FLB0VbQ1p1nMWrbKWFG60qtBWaHD0pPps5PZemf8nfaooAuYWPdMKhWEu?=
 =?us-ascii?Q?wzVQBaBd5+Cx2E5OiW0/UPhT7aY4oB0NWyqTllBv/zQlKiUbIyyWbUyr21MZ?=
 =?us-ascii?Q?/9p5FFzy/jH1KnZIqBJKSSHiovmm0LLzCw5n3PeC6zU2vmfiEdv8s+3jF+wr?=
 =?us-ascii?Q?KACNwpSWkzCBheSEsZsyKVx645mMRS18YZl+GLxKxr6NC4MVK11XdoxCUBhn?=
 =?us-ascii?Q?3kLutfOwI7E2+mDDmqFC2dLrnozd6KOKSjQfb2PlLdu0Qw4wgANLi7qRtR1q?=
 =?us-ascii?Q?ygUNys1ZOqMU4IEqwf/r9iufbcgMQ5T3xBm8Xq+2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ofwBPnRObkmnkZcFOcCTbWb66CgXKXQPgsKL8KiBKD9vWiFfH+T0EJa0Gfl1VYnZaLx5ZecDPBGnvKOQ0jksFgWQDucfYmPw1K5IUdD98XIrG8nDpUzn/AG6rakOEuyawY4BZb8ks6T0ilHxHgZJnh0WT+I07YqQhl35gV+TW11Gd6QkQgb5jPe4m6xGzQwQnvlo/7uYXGMydvzIJFpA+NKYciAZ7Y/XtsNSWmjSIKapRLSYZiRYPuyKFqrO2FWx6aejR8ylVP2fMcGWzr/PQe33NmyNxCwXuc1GOrKcj2YXZvcq+yHtp/hlmnkT1Gbtg/HeZjN3qiymZYHN3MuzboF1cFvY2dE+SVed0YxeFe+P/JGzLpaYGJIOztFbDnDQjJpiS9gm43Z9DvCrXFyc2+Cb7kw2VqGYpXOHBETW+u6Ta/HwItP4g+Erk6IBjh8i1aG759TJz41FJ9fiEYqH5UYuS2szPYLewel7lIMm55l3FHgc2j1byndcLYb7gnfIglHmaSjBBJj8xh8EJ+TIGEtRk1e8ZMYXIPJ1AtbXZ4GMOxbrkMMx3tQUIXrHaVaiOFGO8MuO+TFE8jueGcqtRlHEi1xq40rTh1hrRY/Qwmk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb3e946-51cb-4d21-7c91-08dd5812e242
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4944.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 16:13:48.6816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3jsePIg4XDPKB3H6fknkgz0+MaXrLEhf47SP8ugBX2mnK4SHmu+ElLCSoLXX2K2vHTbmD+BbE6NhNx55SVehVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5671
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_04,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=927 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502280118
X-Proofpoint-GUID: EjX1OWkYjmys5bITkLhJB91pI-o9zWpp
X-Proofpoint-ORIG-GUID: EjX1OWkYjmys5bITkLhJB91pI-o9zWpp

This patchset add below new options for irqtop:
 '-b|--batch' : Batch mode
 '-n|--iter'  : Specifies the maximum number of iterations
 '-J|--json'  : Json ouput format

Add below for lsirq:
 '-i|--input' : Read data from file

v2:
  - Removed macro irqtop_batch_mode.
  - Replaced macro irqtop_printf() to inline function
  - Changed option '--number' to '--iter'
  - Replace strdup() to xstrdup()
  - Added json output format for irqtop.
  - Remove irqtop input file support.

Joe Jin (4):
  irqtop: add batch mode support
  irqtop: add max iteration support
  irqtop: support json output format
  lsirq: add support for reading data from given file

 bash-completion/irqtop  |  12 +++-
 bash-completion/lsirq   |   4 ++
 sys-utils/irq-common.c  |  19 +++---
 sys-utils/irq-common.h  |   3 +-
 sys-utils/irqtop.1.adoc |   9 +++
 sys-utils/irqtop.c      | 124 +++++++++++++++++++++++++++++++---------
 sys-utils/lsirq.1.adoc  |   3 +
 sys-utils/lsirq.c       |  24 ++++++--
 8 files changed, 155 insertions(+), 43 deletions(-)

-- 
2.43.5

