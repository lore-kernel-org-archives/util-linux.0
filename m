Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1339F270022
	for <util-linux@vger.kernel.org>; Thu, 27 Feb 2025 04:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631798; cv=fail; b=WKarfFFotQKAhFuZWodKqHaK/RsVwWXqS3z4V7yQVXzEf0bkev+HhqIrh1HxbeDlPI4uUStrlI3OpFJyOKLWEmiquT+8WIWuDmdub9bN2WB4QUGh67Z1OTVoOxVZ1BsqQ5ClRwtpbBP83fjB/rhElazOUnZXjWFZG1wLFPrvNvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631798; c=relaxed/simple;
	bh=FD83mR8fUZnrUfU1ES9UZj6LH8l6H+bjj+bpYv5kGaU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=P0O2lDaFCWh+F8SBCri0Tr6NjCznCHzihEHz9LtRyg2rEQ6JTTjElmzfY3OQr6F8FWlLhCmQa1el8Ai3IntzTdE+X3xMNtMwMCZdKvNMrzicSTCKWuMTibmSC2cK0vDBznoJLofbcNQk33vuo5BqVq1BXt6jT6H4ZXlu5OLdIcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mAganIoV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Bj9Wk8g1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mAganIoV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Bj9Wk8g1"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R1fkLC027545;
	Thu, 27 Feb 2025 04:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=6eECSWjg3E6ccP2I
	OUvu8is8fQwhBJofTmB/hUHsqM4=; b=mAganIoVCiE4Im6eExDRLxTBejk0vNyv
	Jt1QewVOckhfFexvlY2k4npBzWQ63QWBPTb3o35DaKgfOZN3DE+dY9Qzd0XDsP1E
	Nv36uiKXndLTQv75aTuRvkIrLtKf5oVG6chraI4ZUrjMXr5e11s8GlQ35n77H6pX
	wRnEVj4e2ic17EY3Ex74Aeei4tdLpbs9vFVdEbw63lZjjC9TiiDVxhUlNlzS6iOo
	jQkX+eZ4i3yllkMpqxo4CyDsyAv+y0rN6a/zezZs/MTuLF9RCcX5UsFwLp9iO9of
	dpEV9u7e1ROeJoHsMnNqgXYwJ5/gkJglsqFhdd/dzLkyBBj9+Opd/A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psdjmcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 04:49:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51R3x7p7002792;
	Thu, 27 Feb 2025 04:49:40 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51buspf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 04:49:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nrGaEmw5NxoxwR6GgbYayIZYEn/z9azjvPDs3DpvTCJs7n6h9MoIWASqy6eFcVxqHW21dh+odaQDIfDW1r+jAjrJHzJjw8vl3TJpggU2g5eQBIiXG84HznVSNPT2y2I2wt6xKBEYttGadKO208nEgecKSBsJPSqpJ3HOq+guHklmMjHKAZdlASFDnZAOJTuUyizK60DZAubw6RdxWfANLAGT6cP7BEylWgR2fYpYpLCAE2Ew0B1BRpa90Ku4NKeqpbSFn2DSjIWBQhRyGIt4XtuKaHeEOSTEIxqmehDqJdUGO/XNurKnG+LE+x3zhFIGcvlf0M85ANPrX2QwvMujRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6eECSWjg3E6ccP2IOUvu8is8fQwhBJofTmB/hUHsqM4=;
 b=uZjZR/AJ2ThrvNCT+BZ+EcfD0L7DYirJxMF3c+TCA+Df6BT2vSpzZMGuSu/nfu+kjyYwCqzGyinR8LSuzuyc+LqwPs2hSnRDr5Y4sg4paRBFZ9/zeS97x8BxOPz7tiUvmRSnm6SmWRBdLe01Jg3mo2F8nU+pBr8rnW1zVAJnnxHc2FqAL8TDF9dUw7/a5x0Vu2z+dIG3z/3/JPkMqcrZNJH4UE9/kDy4T7NhSWIj3oX4epGMnAT+YEti4/cDCwTbdO1qrJEBO9jp9ziwLRKnYFbsttQ5aKAUEPVe6ChNavLZvc9GD5RuiKn5uVYJHpg9hYJiBt0qX+yYP2KXLq9yDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eECSWjg3E6ccP2IOUvu8is8fQwhBJofTmB/hUHsqM4=;
 b=Bj9Wk8g1khQuddGihGVA8d0iTdA3oL0H52WRu2A53L+WWwvpWVdBVzVTexoky1gbZTX5T+RR9L+fJkb+8nQ10O6Zbx8CbKiBRYtXw9GYPb1z5X7F93WlTBAmSjxfYV5GUiOmRahjsUtyAGvvWqOXMYHBGtIaekRIyYnUMlTxVis=
Received: from DS7PR10MB4944.namprd10.prod.outlook.com (2603:10b6:5:38d::15)
 by MW5PR10MB5826.namprd10.prod.outlook.com (2603:10b6:303:19b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 04:49:38 +0000
Received: from DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5]) by DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5%3]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 04:49:38 +0000
From: Joe Jin <joe.jin@oracle.com>
To: Karel Zak <kzak@redhat.com>, Zhenwei Pi <pizhenwei@bytedance.com>,
        Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org, Joe Jin <joe.jin@oracle.com>
Subject: [PATCH 0/3] irqtop,lsirq: Miscellaneous enhancements
Date: Wed, 26 Feb 2025 20:49:13 -0800
Message-Id: <20250227044916.89925-1-joe.jin@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::23) To DS7PR10MB4944.namprd10.prod.outlook.com
 (2603:10b6:5:38d::15)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4944:EE_|MW5PR10MB5826:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ac15ec3-5669-415d-3862-08dd56ea23dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g88zd53PqbCAGNK5F2wLWCe+GBIibPEEhwi2Thvzgvd6q6VBri6+tLKXhoFF?=
 =?us-ascii?Q?UYb1IBtKUdtUAZhnC1IpPk71N0NJSCeKgJqEUcsmLJe0ssFvFvGumq/yfGlc?=
 =?us-ascii?Q?/szNEZ6MhXWTSChGTHLhQJkEXwre40lW9PGAg0uFyBmHTKXPrg24Io0Vw7AD?=
 =?us-ascii?Q?nElw5v1GULK0MROIjzh+TXiAzi9vEHZAQ3DVudzJuLWwCgddVn861ArmBO/9?=
 =?us-ascii?Q?82970Q6FpodHxMSteAr7JVtYX1uD9XKduGuwMV9akIryg+0Etv4ouJbBarWx?=
 =?us-ascii?Q?pT1ghGDYNMexZGP23bWE3GkVFRc7LUGQ9Gl5ZhmmN9nkT5Y/1A304SjL01/D?=
 =?us-ascii?Q?K99+o5jJFPCdlVy4KkkWvT0VjwFq4vuT7VOGxLw2js3n6FtQswXWTQOmpFio?=
 =?us-ascii?Q?15ijylBMYHqIbGYPb0RrIbX9137bSix3dVGthBiF9jOeRIF76iM7OomPYmyr?=
 =?us-ascii?Q?yDnlnxAjpNUuRqAI6lPWNT/zxIREBushQ93Y6qcDftpXuRQuJbdYgDMLwAzU?=
 =?us-ascii?Q?ebMFVNj0Gtpiv2zsNM5JGNEo2oGQCmXBAtd28ATGXAkN8YrE3jWmkH30bZpa?=
 =?us-ascii?Q?F4+wJfKDtltDySrMJTK5KpSmwb8IlQdLHHooWP9yZLebcaV5dSyMSugoEmU1?=
 =?us-ascii?Q?IvOJRFawftG2VDyqqCkRRV63Cfya37CJY6zIbp+NijhEl54/sqjz5h1QrhFE?=
 =?us-ascii?Q?U3L1o9b09KGoEZA0gmSYReNx8d+vgfnTDN2MX/ICO3cAMotcOt7UhFIZOs9f?=
 =?us-ascii?Q?RIh9c3xQNEdITMNh5t2I9kgS7Cm9hQa32OOyfao1pAGMqaKQWyFrhmIlDWS+?=
 =?us-ascii?Q?NfYtwffSWypex+6L4PG1ZSmVakN7KrDUWev0zpHB0WwMc9GKpjJCW6pEz471?=
 =?us-ascii?Q?HTm1ejewvkC4FHjaA6/WhHHfiuVtzpWZkPDHqwo1MGgxZkOuQeE6vmDNSKO3?=
 =?us-ascii?Q?mDoiDKeXK1k8VHLocWILUF1Y15l9YVACxkbbL4yG6zj9ClUkXGo3DHdKA0ZE?=
 =?us-ascii?Q?n6AwC3hj2iGBILFGEzuvie0JJ1J/24wcwhZ3DqFYhvDP/Ro7BBLF3qSHE9qx?=
 =?us-ascii?Q?o25BelFlHp/wilSYVT3vKpr6zjBlUQV9Iqy2f7CabW92xsNSB1cwZX/rZhuk?=
 =?us-ascii?Q?lRwF7SHXE5+jSbivHYSp1HJZXFMpsBftkqiqbAgweTL1hZN/Gt+pZhEEzFNm?=
 =?us-ascii?Q?BB+xEi/mmTfme9H4ZPMqhtYcnpOSJjYPvkKfMkVXY+f9VK9fTyWcgF5cKjKC?=
 =?us-ascii?Q?Q2iJ1D0jky2eKusLLvquPcaoeo/infdWuPDJIG7fz2h1bVkfCux0ZDr+F8La?=
 =?us-ascii?Q?1HZb7U1jjfAPtdOvYNTojLh+ndHYkPZhZJ5Ky4UE9VAZ0r69qHX+E/gmFBVy?=
 =?us-ascii?Q?s12GDjseNEqM19FrZMB53tIAK+Jx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4944.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LE5pKPDth14POsj6FRoFbyZxNxaXurronjPkF1BSMqM7bdXinUMRi2hrUW7j?=
 =?us-ascii?Q?Wt4vIkuVbMfN6rMDR1s3EwPG1nuKQk8RdiIV2qi7cbQywMr+OTnsfWD3wKps?=
 =?us-ascii?Q?U7t5/PxYO66mbBMODscpmWrgEZLGzWhgaF5I+2vyZw7uBQf9JDKCZaKnzr4C?=
 =?us-ascii?Q?gUfA7usQ1ZVYivh1DvdQv4xgM0ZhfEF6uo74QGEg2ITelZN2vLrpDGzJRYaA?=
 =?us-ascii?Q?HjHnXh1bnWSHkNhUQOC/loFhXmqaITdBTHU9wJIEEigWiRkzT4zi8uLfMcqO?=
 =?us-ascii?Q?n1PaLB0beK3fq1w5PUPXV+mU79DcIwQWi3w3xDk4omZezWEbB3zPBswIgk9c?=
 =?us-ascii?Q?n1Y+lt/auUuerNIU74+kRJXGzvlDxzJxlRlFIpmLuXJBmCIwy2tqW45zZGkw?=
 =?us-ascii?Q?G4Z3y+cdfychqn1PRVMwhsDuo4mUK99YJkqjC659xFIvK3pj5c9vXuxU8+GC?=
 =?us-ascii?Q?XqW69zcQdzFybBNSYiXDKZrd00cM3pb3HaExCwi03VCFaJJRttb79ZugNnHR?=
 =?us-ascii?Q?4yzKIRQ6N7zPd01pluec+ux05sYWtu/k7n31NE0ybcSh2LvM8oMJSVgHgGyE?=
 =?us-ascii?Q?ScM/YQcJUq8uhI3DIC7Nx0KpqQK7Ga3PO6nUg6qCpYn6sNKhzN5am5kal/za?=
 =?us-ascii?Q?vETRnjIdvbx3SQUPjAkHMPSRFy4c25/btMtShY2kQd0YnkGJss/AU5t63ecN?=
 =?us-ascii?Q?MWLLuGTkgkqFYZ2zsSAcNppbaOng4Hdn7KDvSzZBmt0NRblPGDMQqaWBvNTg?=
 =?us-ascii?Q?PpicbpH0jfb4UCndXcsQTlCgL9TUbqrURhoqZnJB/uA2dXE0UjWSF8kLvRsH?=
 =?us-ascii?Q?KteX0D4JKe5H1+oaBorYYk968W/VCGP+StgJLj382vgTxbWRpjcBsP3t0OFO?=
 =?us-ascii?Q?VlC/5dfPOT54mwbjVtDm2AxqwE0V2dABRyb3uJCMPRwOUBuPOgHUq7ES1Uc5?=
 =?us-ascii?Q?SIQNZBQBW9Q7aMGja8vlnVjHgsrU695cfav8HSjyTycItg2Nhi/wUgKHgXh5?=
 =?us-ascii?Q?bZGVmx+UaMm87j/7UxzbhRB/7L2qs2L2Ek99JBSqovhKnBKmYC9IKuYqdeJK?=
 =?us-ascii?Q?k0T5rzGFkr1uOZKyb5B9X5acidOTLtw41Dfbjj88zFbpAf6ddjd3NwUTvqrI?=
 =?us-ascii?Q?luYuyuT9w/njtC0bU65bbs/m7XHzV1Kq+0yh5PXIYjs/FCi+1Q8D7GjeInOA?=
 =?us-ascii?Q?Ycb6pU0+F99DqFxpub4qTvqhp6MhWPm5r30HSlsPfErl/PlGh9ZhZBX1oBaA?=
 =?us-ascii?Q?t4BitXBWcoyI/G/EjxcvczM3mWMQvaM9miwn9DJ+PJQLPSk8JXpCEkJbn7lY?=
 =?us-ascii?Q?Xs7/YMZOPJHnR26mJ6qLAc2C+HE7JUN/y37JsrJ8ffYkcf5H9hkFbuRwfzVG?=
 =?us-ascii?Q?zJXYiOHKVm2dAMQgwfBo3wvieY4wHxUiY+h2F+LLmhjGzQ5rPj/fU50RD4s5?=
 =?us-ascii?Q?DN43fhGg64qdSWEYSmWFGr926/4ezvCWmve1As8HXferKiPiTuAfjDCcJ5pl?=
 =?us-ascii?Q?a718TZDMmiSr5ikIOKlA+GPd9ZXGVFlFlk04NTXg3M1r5Chj5U5KlpKj0T8l?=
 =?us-ascii?Q?JQKEGai7ETDnewDea3b11i58J3JJ1Y7AkynyXgFk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/b1JDiwCsQHkmCXe1GRQorgxj68im8pgFJESQWTGizQU1B/KE8S9ZGYtuNuSyIzHO0hZuKRVMhbNFDNl3HUCRpZpoIg3OFkruNmptXPohCsR6+zBnWw3NJenX8sztGuZ+rRe3ZGRGm+BtsaocTK9Nwb4r1SFWll5SFxpqEo7D5Luz5dl2jggXJAK3HWVCupbH1WwNwbOpIXMZEetUAcXb9CdBhASvcPEt6E2007hwmuEYT5QLfv1H27JJymFK4AnE5e/Aoo8AAz8luND+X5GhgWCa/UXZF+00nlpJCaohXgfLEaqZwi6YyHa8SfZwnl1ZMOFHK6nKqOOFqWda0ccEHCyFz4ubkFxdVqGiLJzCWXYvRyd6W6IDLQ2bQwFVjveRgHcrToEGFEIuonq9fJNfJ4FKtT8N39yI3oaIo/yJEmmqRAATnCvlenJ3RBUVRO/+7RmZtiwfxTp9n5pMfynEUAYS/engPU/NpMjcUGUmvp3De8HFiDyXVqJyo4tgZSuwQti8vnyR0WuDHUZKPTZ+/pu85J7ekITZ9OPstsqMunRDuLoCAgbav+NY0swnocka3PDnRnp2l8O9DAcWWJz6bkPAvZN5j9BNXYaYj5JIX0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac15ec3-5669-415d-3862-08dd56ea23dd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4944.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 04:49:38.3297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V30rx6s73tbYvVq38rN0AGJu0InfyqflfeolJxPlcHEG7lz2SEjYb1xkbPhACQBDOzprW3TXD/eoFeldS9F4Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5826
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=839 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502270034
X-Proofpoint-GUID: bBHa0VA_5ezbgg1XczasgHq1fg-jbk8F
X-Proofpoint-ORIG-GUID: bBHa0VA_5ezbgg1XczasgHq1fg-jbk8F

This patchset add below new options:
 '-b|--batch' : Batch mode
 '-n|--number': specifies the maximum number of iterations
 '-i|--input' : Read data from file

Joe Jin (3):
  irqtop: add batch mode support
  irqtop: add max iteration support
  lsirq,irqtop: add support for reading data from given file

 bash-completion/irqtop  |  15 ++++-
 bash-completion/lsirq   |   4 ++
 sys-utils/irq-common.c  |  19 +++----
 sys-utils/irq-common.h  |   3 +-
 sys-utils/irqtop.1.adoc |   9 +++
 sys-utils/irqtop.c      | 122 +++++++++++++++++++++++++++++++---------
 sys-utils/lsirq.1.adoc  |   3 +
 sys-utils/lsirq.c       |  28 +++++++--
 8 files changed, 160 insertions(+), 43 deletions(-)

-- 
2.43.5

