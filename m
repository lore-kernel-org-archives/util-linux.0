Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC0D188CCA
	for <util-linux@vger.kernel.org>; Fri, 28 Feb 2025 16:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740759267; cv=fail; b=HoJvPslzsx6s1rp83BcCgdsWxkvahNXZskWJpIGKaJOA9HLgyKR5SY7JfBDqokrWwbnENUVpGmFqE0hWTHDSqzGlM3lcB/AP0Cazoyfh5ChIaf54rPpYG2y35gp7srcFhbuVKeMQ7RxSrovLm83tKJjBQ5MC8pUrWHWomzPaMsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740759267; c=relaxed/simple;
	bh=sF1L5AWC/DMm81bsN3hGgBLTfdRQ5bt1iTxLiURL6Ws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oUWdtGbpfIxN3EN5eTPTTiATqSVlzooK0/QTik9S7BObcu5uLGYt/yqLQgVaxQEbtB5fVE5zwijLvWWSpWwPO/kl+w/GrAmoDlnkZUE0Ra3OrOTBR4WhbtNCXwIlm1glb71cvw6V9dKM2P49gezeW7L2AHvQZViA9xwwXEUBN34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M328K5+t; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nHCrkKJp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M328K5+t";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nHCrkKJp"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SEGaYd023484;
	Fri, 28 Feb 2025 16:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=z3SOJk9PaZ86SrWC2/W5ELCraFCsmKV32/Ldfhyw1ag=; b=
	M328K5+tsf0ST2oXMbxAe3D2+PLcipbiM5ilO9dze4yoliA4ljBBHpcFz8kMohcG
	EzO0PqNhT30gAuHawtvPXxl+QGCfD+JwAQ9NFxKfJOf2LdmghjPZ1TBAdx6/TMEl
	qUbPD2Xv/4kVS60q/BjFBN+DDZtVYi6h1zq169N58WP5P92MArE2X2TrvdgwaJ66
	5bbj9z/tnnEM4jzgfifxeGQalxjTrXZ50xpDns16QS5rbF1TxpxLu49N/6Bk1Iwk
	8i9msKjUmqx77hw0ccG9sgx9RL4AyQd0GNp/5U8854jSJXWHyfCXHlZgg1nmmySd
	LJgNkjffGvhC+cDBQmA5bw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psedvjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 16:14:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51SFGXcM025324;
	Fri, 28 Feb 2025 16:14:01 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51mdts5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 16:14:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aquTCcBZQB3rs3PqN32miLu7do7rZooS/qNZUPa5zYPiYofLHh7Hf3tD/r3/n5ox6NdoNnknSNSYNbuBvUQRaWYCE9Fa16OaFH0ZTliOboxaZ6cKlOIFs5gnQNEiReq0JpxAXSudBkLqY2+hQeymUTSuDNG1KhhMIKad0yj/2GHzVbuIYRqeYJNyRj6yjyqX4ebn8aHQFevqevnSiRTgsihmDu8XS02LFeNKJYHrad/5XfuM4CoZeUVtyIqV6DJlVEeiwmm3mVQX8WPNaZFOF62TOYRT4lSmdrUC2dIDr3P2FMTqL3PhI7ugfRtSSt+POMQP+4HsDsm9+ZFtH2Ik7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3SOJk9PaZ86SrWC2/W5ELCraFCsmKV32/Ldfhyw1ag=;
 b=Cp8ap6FPYa+9pt7/kHedeZVz14SQkruswBOwCqm1Vaj6GkOBiAdw7Sq2+hxqTY2UXv61MmYLdhghABYEfxf1BmdtrZOJTjT7plD7kVoY1lK/YDQRWY/FTD1q5XTo9nYAl3Rbj+sAe2WjCKhnPG+TVI6QWdjtBWPshhlviBeV0aqMreN/bWO+MBGP9sIQOAeq9EPr50o4fB3wxzOKGzOdouQaDiuCp+DPEf+Sem1y+4ls56d7Vub0kGt18RhQ2TzwI7JtiNuaIc9WlP/aIaPd99GlTNxNQVrjL7lJSAPYN0cZbTYPjnWhs+XdMhSf7A6u1AfY+/JkujpH4wYdfGKRAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3SOJk9PaZ86SrWC2/W5ELCraFCsmKV32/Ldfhyw1ag=;
 b=nHCrkKJpcCKvlMl1e2MuYQR24tBOqaBkEgmmwzGLCTGQF17pqLF7agY5g4SMgq+vhPnlIiQDuB151/mymtcVAadSO5yJJL5ryQ/zjcyxXSdAM4X1smeOUg0IB+FYYIMrE/0cyz3+TLRIsQ3R7wPZwSVVZiIwE82oyEl2ikZ2Uv0=
Received: from DS7PR10MB4944.namprd10.prod.outlook.com (2603:10b6:5:38d::15)
 by CH2PR10MB4392.namprd10.prod.outlook.com (2603:10b6:610:79::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 16:13:59 +0000
Received: from DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5]) by DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5%3]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 16:13:59 +0000
From: Joe Jin <joe.jin@oracle.com>
To: Karel Zak <kzak@redhat.com>, Zhenwei Pi <pizhenwei@bytedance.com>,
        Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org, Joe Jin <joe.jin@oracle.com>
Subject: [PATCH V2 4/4] lsirq: add support for reading data from given file
Date: Fri, 28 Feb 2025 08:13:34 -0800
Message-Id: <20250228161334.82987-5-joe.jin@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250228161334.82987-1-joe.jin@oracle.com>
References: <20250228161334.82987-1-joe.jin@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0275.namprd03.prod.outlook.com
 (2603:10b6:408:f5::10) To DS7PR10MB4944.namprd10.prod.outlook.com
 (2603:10b6:5:38d::15)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4944:EE_|CH2PR10MB4392:EE_
X-MS-Office365-Filtering-Correlation-Id: 31302289-0c80-4652-6be4-08dd5812e8ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fjf632FGZ4Ro6uQdXeUYleAsJcC1Qy+03GngyJt+hH81MALnTQv9mkknTVOk?=
 =?us-ascii?Q?2Q+ZhodF0rMBE/mEQWCnQ+ZmiiJLJTFKtNP+OcWNYvPuKqwkakAHie3w/DQp?=
 =?us-ascii?Q?bu4VlnJuKtzVaRz7UwycNQoFCCNOO/XpPz0mcnfe+UlRKfVdvcVNTHZ2y9Gf?=
 =?us-ascii?Q?LYuxdYbfDLH81KAs1y+fO2Aexx0JjgyqsshZ8yqBlpsUYQb2LnCfBpkWOtOU?=
 =?us-ascii?Q?Wx2rztGHFLpEhbb0RgEkdCJaahlHYsFcmHI7DspBZ7szjfPKeO75imZKt3Xq?=
 =?us-ascii?Q?s0RAS/JMVM2PI+hIwIbWG2fqOfhLxbFA4+sxdcTKSebhF5jAgaFRdYYsZX2M?=
 =?us-ascii?Q?LyP2Efokd22wWAh8Jx0nRrQK4FSeJ+lMOVowW/QWoew9bUHV6W4blQBB8Uki?=
 =?us-ascii?Q?TxnHCC4YfK2ubz0t3iM9LvkJtCholk571KxqdfSRqjXq9qTHKy/2HXjUmfJ2?=
 =?us-ascii?Q?ZuUUhpkrwVHVnxY3cs4LyrlJ8AJb3eXHWVINYzocRLrNlAmmJf5BAdmpusRa?=
 =?us-ascii?Q?jbAFlMtlv5VjaGGQMyaEC/tmBXAtnZVn42sSGclSeDHffpgMSJfaZxfNNcCv?=
 =?us-ascii?Q?tcrfEOztGOYn4aWNgluKqENsFvnNnyzZYiWut5PhF5L8JusJiQark8pWVfp/?=
 =?us-ascii?Q?F7F78M+bQJJaC7Xig5tLva+ETb2sHb2IMKhg06v5drlu4uoIY94sN+49kMuD?=
 =?us-ascii?Q?tK8QM9FSGNkGjITLgs/S4S+Pd8gejIPRzPp6M7U4QUyidGAAPcK9gvaIrx+b?=
 =?us-ascii?Q?0+glcwTObTZ9756hPlSroitEQv8UnX7VVypfGoN8vfzJRNy3EeTuGb2Gneyy?=
 =?us-ascii?Q?ely9fXc5CkixKG+LMCIYg7VdEGo8tlVQ/R/a4oDOvzQPq4gXwBmwzbUsOT0+?=
 =?us-ascii?Q?8LJyorigzX8EroN+np4Vj+n9+YkVyg+lGCt2cBw2+sVZTrkirL/buskkc05J?=
 =?us-ascii?Q?ryI+bJ9jkLFR/hw8nBpH6c9lJu7veOq5Vp3HJA6nt55ZjcLUkdrGxGLheSkI?=
 =?us-ascii?Q?CPslXdoDDottjvSvGlA+vNUwZ76C/YWkFeaDA1djhrZQ8JH/2W+Ap9mgZxsf?=
 =?us-ascii?Q?XDTomyv/tHzHDgR93GCH251zYZrZf2MlWJCgii3xzsoW6qeS0kAfuxqWj8oS?=
 =?us-ascii?Q?nq2l8AViAp+T5RBaQ18+j/8mfBoM2hEa9epN0pFOv1CVgDrUF739MAg8LHb8?=
 =?us-ascii?Q?cdwLL8l3QOO8RpV+dZ+uvBB3ANUXZcKvlgF87BbKUEB++petjBn0b+hVqXpp?=
 =?us-ascii?Q?EG9DVpzsL3rm7X4kh+56I+08ouzn6UjtcZ8USNPPLGCYRRDs3Tzt+G4xuaTw?=
 =?us-ascii?Q?fBzNhJzt97TX+akCCSrIRqHluRFjXIws9yQY1x31vD9zd9KRi2Now3wosN82?=
 =?us-ascii?Q?pvmKdn6zFgG/lLqXZh0cZJe4pG3+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4944.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?flV5bD+QuPBNWQ6kn+xIZDFThzZUDgvWGjBbOg2+p1kfRsmnJQaYhsgdBV1F?=
 =?us-ascii?Q?dlm6p8At3CUlRLSB9rHjIcUwMefoUNuOrS+JaSBqaaApjWsMyB5+kqcxrtZC?=
 =?us-ascii?Q?lpWnnmuBbqRz9PqdKnVQ1k73tSothc0yu/AfcbeS1lSyJesV+m3x1V7aM42M?=
 =?us-ascii?Q?oCptOc2giJIoe5aqv2B3fcLPANdp5UFgHtuNi99GyxW8D+PZA9gImDYQFOMm?=
 =?us-ascii?Q?Lx7Ifui5JDxISzRu++YLolVcQZ8Z+anUI7ZT5L7i/hxqBJ1YVVkftW+JW+zc?=
 =?us-ascii?Q?eGbTdGU7qLLueJW9RaWJPq8skg4tw14LKLb9mKLcrHui3R9lW2yAxmA0cmgw?=
 =?us-ascii?Q?PCd4b8xoUMZCk+gIsKGfVjFP9se7gf7GvlB0A9KSVLRh3MFvag+1R0VGJm0S?=
 =?us-ascii?Q?WWVZu3FiGwPgwEzITIynkkKi5145EgHuapewGjg5qXW4a73Za+R5LSbFX5FK?=
 =?us-ascii?Q?f6ZDFVuZD4pcP9EXJzUJe7w15ZznsEWM7urGFWS18DZAuC1auknDvtw5kVuQ?=
 =?us-ascii?Q?WN0yJ/XqXLX6wS+GIRPvddNxP8Ui6ZIjyOTkxpIi19tAuZ3hbfZXMfhhahxn?=
 =?us-ascii?Q?I1ZKhsaZZw8y6vOmg63oLMNIOkZX+hp6VZLtf+bIUnqVjVXy4yzO2uY0OIpC?=
 =?us-ascii?Q?iOAPWDEAsOj8Ip59SmcoZwcFTan/3ON9lzPYrh4VKFLqcmYZd+fMt5JWURJS?=
 =?us-ascii?Q?/sWG9tf0c+QuV5lE6Ig06fYekAEqvo1WNNJuBnTDCRytLb/aB7g8H8JqXeHU?=
 =?us-ascii?Q?twxCItWZ1q6Ryp/EGOro1SaYQm7MFC80AnaMgOk302XFAQdC93RECKsVNIze?=
 =?us-ascii?Q?dS+PqeLd5aozZEmGwpeoAofC3ykuR94x681KGkW6Za32BLA2kU2HqlsVUDVF?=
 =?us-ascii?Q?MOj963jlCQ8NzWPf0mtJ85wO4/zB4BKPFVLgZm6XHvabAB6od5fD8RJxGswb?=
 =?us-ascii?Q?HipGAj+b0hVvMqQ7FRQqKKJZc1HWPmsKan5AJLR5xTnMAsUOzDKPICZ0HtYU?=
 =?us-ascii?Q?oItdmkoqLEF+azS4Q+5nk1SgCxBsAKW1UP8/Dwvh5LVyl8gN2RkyS5Awx/gU?=
 =?us-ascii?Q?Z8CkGokVwq72pXjqbHh9XT3krhfJT2ampxEX6TKjT+exqj2kpaRW9BoHyvVa?=
 =?us-ascii?Q?1UkISAAU4DrW23qhEjJcoNQRWjzOo/QAYxbmHqq9HWz8kMEJkSq4K2fYDta/?=
 =?us-ascii?Q?qJIc3JqgzZ81j2oz5t47w0KnXrceH952RMhW0xLAhxkJoA3hHN0ple+3Wpre?=
 =?us-ascii?Q?cz+NAF225+v/jsJtwi7ukF/W7rslJTFp4CTtoA2Jsgbiw/rElMTHxY22GVRM?=
 =?us-ascii?Q?NshG14LFNAhRYY1nNreRoiC14VoLdj5QjRnaAFpVRGjgfvHDkhDSNS3+WieX?=
 =?us-ascii?Q?L7lLNEglEgbxnebIz0JjYZzTtOMN1fjI65nr3bH66+u4jlaN4bODLhK6It84?=
 =?us-ascii?Q?g/CUCEy2y4R9bTv2Kicjqg8KsnMYf18f0Lnkz+9RAGntV4tcgc4ZA6rBP5nK?=
 =?us-ascii?Q?f+UzWHbI93g3bhBIM5N3n9vcsLiu1jzGQpkmhJsL4TBMmrhbRMAfDTRStN6O?=
 =?us-ascii?Q?jeNpvJaQ8DaFXYqvwQQQVgbTffNuIUzvvsZUNpd6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CA7LlR9r/bkxqfeAOwqpyNubJD6oC+UukAVrxHUwDRaR5uN0KzxMZ0frJtfk9b3/RBgxOP6186dH58q/SiaL+qW+FWkvntke31JZ+mCJgr7sJpVg3q2bdaZhenXmlWsQDSiznHYb5DXp/Zp7Cxz4YoydBi9xPCMJkgl7JnPE/DX3BGzHbdg3KUVEFBB2EhhSs/apUQjgiYRgldWqP8zsVaio1KV7O8ZjFWeJwc1ZQB3Dg0Eg6rVOz0s04+pRwvPuNWIyPrmrlbTAqdp5ALSCMlINZkzERx3Se/kSxhQd1ZOM4P3Cf90JJMzIQkYOWX8qjC5rGD0S3yBoS7ZP+7+k2oW1UGoC0hE4PEbcPZFbQZUNiSO4wGJWf7TIlqVwTn5CbHjVeMKxKfPufjrhi2XH3ae989/0XGO+FdpAsA6QdCQWTT86RgEQv3qsEmUycR+Vwy53SlFUimtLHhSY/4hkLySb0/Q4jAJ+qZvaiTWMa3fd5j8qWSO0UPkWW1zIZ2EfQs0T/XZUbLRf2npxwzUCmNj5BSFzscnjCDkEAyJQL5Yus6s7qfP4amUESWwc2m6EFtpwj4iAMKTB0bN6KwrW3WxefNdxIxbEicBrrEGNIB0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31302289-0c80-4652-6be4-08dd5812e8ca
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4944.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 16:13:59.6695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYq3E3OPb8OdNp7xgC7ei6+ukHlFuRylWrjTlV24zo9y+zhoGc5XxGq9vxWRRQykkqDF3uyl4G4e1EK8PtyEwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4392
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_04,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502280118
X-Proofpoint-GUID: bn9yGOhx98M7jxFBPvzSpmk23rxCysya
X-Proofpoint-ORIG-GUID: bn9yGOhx98M7jxFBPvzSpmk23rxCysya

This is helpful for analyzng data saved from other system.

Signed-off-by: Joe Jin <joe.jin@oracle.com>
Cc: Zhenwei Pi <pizhenwei@bytedance.com>
Cc: Sami Kerola <kerolasa@iki.fi>
Cc: Karel Zak <kzak@redhat.com>
---
 bash-completion/lsirq  |  4 ++++
 sys-utils/irq-common.c | 19 +++++++++----------
 sys-utils/irq-common.h |  3 ++-
 sys-utils/irqtop.c     | 12 ++++++++++--
 sys-utils/lsirq.1.adoc |  3 +++
 sys-utils/lsirq.c      | 24 ++++++++++++++++++++----
 6 files changed, 48 insertions(+), 17 deletions(-)

diff --git a/bash-completion/lsirq b/bash-completion/lsirq
index 4c3c9f04f..b913eecd0 100644
--- a/bash-completion/lsirq
+++ b/bash-completion/lsirq
@@ -5,6 +5,9 @@ _lsirq_module()
 	cur="${COMP_WORDS[COMP_CWORD]}"
 	prev="${COMP_WORDS[COMP_CWORD-1]}"
 	case $prev in
+		'-i'|'--input')
+			COMPREPLY=( $(compgen -W "input file" -- $cur) )
+			;;
 		'-o'|'--output')
 			local prefix realcur OUTPUT
 			realcur="${cur##*,}"
@@ -35,6 +38,7 @@ _lsirq_module()
 	OPTS="	--json
 		--pairs
 		--noheadings
+		--input
 		--output
 		--softirq
 		--sort
diff --git a/sys-utils/irq-common.c b/sys-utils/irq-common.c
index f069d8a63..560dd4b82 100644
--- a/sys-utils/irq-common.c
+++ b/sys-utils/irq-common.c
@@ -233,7 +233,8 @@ static bool cpu_in_list(int cpu, size_t setsize, cpu_set_t *cpuset)
 /*
  * irqinfo - parse the system's interrupts
  */
-static struct irq_stat *get_irqinfo(int softirq, size_t setsize, cpu_set_t *cpuset)
+static struct irq_stat *get_irqinfo(const char *input_file, int softirq,
+				    size_t setsize, cpu_set_t *cpuset)
 {
 	FILE *irqfile;
 	char *line = NULL, *tmp;
@@ -247,18 +248,15 @@ static struct irq_stat *get_irqinfo(int softirq, size_t setsize, cpu_set_t *cpus
 	stat->irq_info = xmalloc(sizeof(*stat->irq_info) * IRQ_INFO_LEN);
 	stat->nr_irq_info = IRQ_INFO_LEN;
 
-	if (softirq)
-		irqfile = fopen(_PATH_PROC_SOFTIRQS, "r");
-	else
-		irqfile = fopen(_PATH_PROC_INTERRUPTS, "r");
+	irqfile = fopen(input_file, "r");
 	if (!irqfile) {
-		warn(_("cannot open %s"), _PATH_PROC_INTERRUPTS);
+		warn(_("cannot open %s"), input_file);
 		goto free_stat;
 	}
 
 	/* read header firstly */
 	if (getline(&line, &len, irqfile) < 0) {
-		warn(_("cannot read %s"), _PATH_PROC_INTERRUPTS);
+		warn(_("cannot read %s"), input_file);
 		goto close_file;
 	}
 
@@ -270,7 +268,7 @@ static struct irq_stat *get_irqinfo(int softirq, size_t setsize, cpu_set_t *cpus
 
 	stat->cpus =  xcalloc(stat->nr_active_cpu, sizeof(struct irq_cpu));
 
-	/* parse each line of _PATH_PROC_INTERRUPTS */
+	/* parse each line of input file */
 	while (getline(&line, &len, irqfile) >= 0) {
 		unsigned long count;
 		size_t index;
@@ -527,7 +525,8 @@ struct libscols_table *get_scols_cpus_table(struct irq_output *out,
 	return NULL;
 }
 
-struct libscols_table *get_scols_table(struct irq_output *out,
+struct libscols_table *get_scols_table(const char *input_file,
+					      struct irq_output *out,
 					      struct irq_stat *prev,
 					      struct irq_stat **xstat,
 					      int softirq,
@@ -542,7 +541,7 @@ struct libscols_table *get_scols_table(struct irq_output *out,
 	size_t i;
 
 	/* the stats */
-	stat = get_irqinfo(softirq, setsize, cpuset);
+	stat = get_irqinfo(input_file, softirq, setsize, cpuset);
 	if (!stat)
 		return NULL;
 
diff --git a/sys-utils/irq-common.h b/sys-utils/irq-common.h
index 02b72d752..b9cf72d2a 100644
--- a/sys-utils/irq-common.h
+++ b/sys-utils/irq-common.h
@@ -73,7 +73,8 @@ void irq_print_columns(FILE *f, int nodelta);
 void set_sort_func_by_name(struct irq_output *out, const char *name);
 void set_sort_func_by_key(struct irq_output *out, const char c);
 
-struct libscols_table *get_scols_table(struct irq_output *out,
+struct libscols_table *get_scols_table(const char *input_file,
+                                              struct irq_output *out,
                                               struct irq_stat *prev,
                                               struct irq_stat **xstat,
                                               int softirq,
diff --git a/sys-utils/irqtop.c b/sys-utils/irqtop.c
index 48b65201f..6d001cb10 100644
--- a/sys-utils/irqtop.c
+++ b/sys-utils/irqtop.c
@@ -130,10 +130,18 @@ static int update_screen(struct irqtop_ctl *ctl, struct irq_output *out)
 	struct irq_stat *stat;
 	time_t now = time(NULL);
 	char timestr[64], *data, *data0, *p;
+	char *input_file;
 
 	/* make irqs table */
-	table = get_scols_table(out, ctl->prev_stat, &stat, ctl->softirq,
-				ctl->threshold, ctl->setsize, ctl->cpuset);
+	if (ctl->softirq)
+		input_file = xstrdup(_PATH_PROC_SOFTIRQS);
+	else
+		input_file = xstrdup(_PATH_PROC_INTERRUPTS);
+
+	table = get_scols_table(input_file, out, ctl->prev_stat, &stat,
+				ctl->softirq, ctl->threshold, ctl->setsize,
+				ctl->cpuset);
+	free(input_file);
 	if (!table) {
 		ctl->request_exit = 1;
 		return 1;
diff --git a/sys-utils/lsirq.1.adoc b/sys-utils/lsirq.1.adoc
index 02aea16b3..dd265710c 100644
--- a/sys-utils/lsirq.1.adoc
+++ b/sys-utils/lsirq.1.adoc
@@ -25,6 +25,9 @@ The default output is subject to change. So whenever possible, you should avoid
 *-n*, *--noheadings*::
 Don't print headings.
 
+*-i*, *--input* _file_::
+Read data from _file_ (Which was created by other tools, e.g. sosreport).
+
 *-o*, *--output* _list_::
 Specify which output columns to print. Use *--help* to get a list of all supported columns. The default list of columns may be extended if list is specified in the format _+list_.
 
diff --git a/sys-utils/lsirq.c b/sys-utils/lsirq.c
index e31addaf5..fa2dcaaf3 100644
--- a/sys-utils/lsirq.c
+++ b/sys-utils/lsirq.c
@@ -29,16 +29,17 @@
 #include "optutils.h"
 #include "strutils.h"
 #include "xalloc.h"
+#include "pathnames.h"
 
 #include "irq-common.h"
 
-static int print_irq_data(struct irq_output *out,
+static int print_irq_data(const char *input_file, struct irq_output *out,
 			  int softirq, unsigned long threshold,
 			  size_t setsize, cpu_set_t *cpuset)
 {
 	struct libscols_table *table;
 
-	table = get_scols_table(out, NULL, NULL, softirq, threshold, setsize, cpuset);
+	table = get_scols_table(input_file, out, NULL, NULL, softirq, threshold, setsize, cpuset);
 	if (!table)
 		return -1;
 
@@ -58,6 +59,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(USAGE_OPTIONS, stdout);
 	fputs(_(" -J, --json           use JSON output format\n"), stdout);
 	fputs(_(" -P, --pairs          use key=\"value\" output format\n"), stdout);
+	fputs(_(" -i, --input          read data from input file\n"), stdout);
 	fputs(_(" -n, --noheadings     don't print headings\n"), stdout);
 	fputs(_(" -o, --output <list>  define which output columns to use\n"), stdout);
 	fputs(_(" -s, --sort <column>  specify sort column\n"), stdout);
@@ -82,6 +84,7 @@ int main(int argc, char **argv)
 	static const struct option longopts[] = {
 		{"sort", required_argument, NULL, 's'},
 		{"noheadings", no_argument, NULL, 'n'},
+		{"input", required_argument, NULL, 'i'},
 		{"output", required_argument, NULL, 'o'},
 		{"threshold", required_argument, NULL, 't'},
 		{"cpu-list", required_argument, NULL, 'C'},
@@ -103,10 +106,11 @@ int main(int argc, char **argv)
 	cpu_set_t *cpuset = NULL;
 	size_t setsize = 0;
 	int softirq = 0;
+	char *input_file = NULL;
 
 	setlocale(LC_ALL, "");
 
-	while ((c = getopt_long(argc, argv, "no:s:t:C:ShJPV", longopts, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "i:no:s:t:C:ShJPV", longopts, NULL)) != -1) {
 		err_exclusive_options(c, longopts, excl, excl_st);
 
 		switch (c) {
@@ -116,6 +120,9 @@ int main(int argc, char **argv)
 		case 'P':
 			out.pairs = 1;
 			break;
+		case 'i':
+			input_file = xstrdup(optarg);
+			break;
 		case 'n':
 			out.no_headings = 1;
 			break;
@@ -157,6 +164,13 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (input_file == NULL) {
+		if (softirq == 1)
+			input_file = xstrdup(_PATH_PROC_SOFTIRQS);
+		else
+			input_file = xstrdup(_PATH_PROC_INTERRUPTS);
+	}
+
 	/* default */
 	if (!out.ncolumns) {
 		out.columns[out.ncolumns++] = COL_IRQ;
@@ -171,8 +185,10 @@ int main(int argc, char **argv)
 				irq_column_name_to_id) < 0)
 		exit(EXIT_FAILURE);
 
-	if (print_irq_data(&out, softirq, threshold, setsize, cpuset) < 0)
+	if (print_irq_data(input_file, &out, softirq, threshold, setsize, cpuset) < 0)
 		return EXIT_FAILURE;
 
+	free(input_file);
+
 	return EXIT_SUCCESS;
 }
-- 
2.43.5

