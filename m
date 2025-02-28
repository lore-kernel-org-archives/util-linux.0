Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76581188CCA
	for <util-linux@vger.kernel.org>; Fri, 28 Feb 2025 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740759262; cv=fail; b=jFVXVv9FKntsprr6YAr5AXiNrbb0YuAZo6gtltp5BY7IIBGCKXqISX1lQMz0Wx8PTi6wOdYm+kQQCJTmgeRoipvC3yLeP14s2UqaPwWAdIq03V6btIbdm9iH9TkFnfcM74NIPhD+IUKMFTSjB+VSdZosCm9Q+tBNdHVbjF2TWrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740759262; c=relaxed/simple;
	bh=9YU9HVK933fSxgG9aj4gAgqQNVLGjPkKYCkFquRNntg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hMejHhureypoOcGyIxpnTkNRkAifb8m6mxaJe1wWQHNcPVbpPQnnOnyM9SC0YvBji+grTkgCbpHF5dDC+gIGDO8X9SBQdyZwK2yfhyuGUl5btprf1IGHKOyf1A3iwQy7YVvPZlNXqmDw9YCYEmn0wcZoGZWk3wV3ARj259MWI18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Cm7XKDXE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=L1Ui+e4s; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cm7XKDXE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="L1Ui+e4s"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SEHZ0b002771;
	Fri, 28 Feb 2025 16:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ARN4byimVFhQO/Nqt/IV1e9HP3cWLzv3L04r1naYqZc=; b=
	Cm7XKDXEHXJmZgwNMUbekFB7CKPn1C8qQFz1NwWihsGdjp9HxAT2NW0RQuBqXFxF
	Igak3SPmRT3a1HP7tr2/7cEpEeYfkitB4Mo7MbJJFqGltgIBd2XvxHWT/RBVJaMZ
	rzZONlpxf2sTYbsYMt5TTO8oHmvGvqKc4dKD3l1UkbZydImwnCOpTUq+XqiFH06C
	Yh+tH6cYslDMm8LZJCL1Ra0EAPDXcELxFCjdra0W12F3tGFP06ZaTpHvelzmHgzE
	vnhXScWmKmlj+rIV7h6hdDQ16KZ8rZsBBF62THoWmISjquP0adxGpM3jgy0RgtJL
	7BsErLygAunfzb/NbyyjUA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pse5w0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 16:13:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51SFLtGU025364;
	Fri, 28 Feb 2025 16:13:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51mdtp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 16:13:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Etj4LL7WRcT3wwzYeehmMATcHb0VnDAePTobvuMkn6Wr2g1rTQVuDy5XJ3IEum6Ar9KU2VojCEndVIxahkPTW2nj+dA+laX2lT/2od55jg/1pr2bA9epQy6Cz+DSQhy1NVLRI6LiSKLpczVFPhQhoQPG0NRuDg0+Nr/m/h16q+Sql8FZ2bSpVs9Z5cfpkqsq4TFNYX8yS5Xr+1zWzQ5pgSmMUcsS0jyfABXgL/iWb3vs6w1Um81jYJN5qmwnQC8jxy7kJClz1tVvlWLxjcDSTIdokmQvFF7P5kyTshHDAmFuEveC8MxPHowDHDMXAwsbn84huVpp05K31l+SO7rBNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARN4byimVFhQO/Nqt/IV1e9HP3cWLzv3L04r1naYqZc=;
 b=F5j3T4K7p5xXRBD78Do3x7G1ix86gRhZIh8MX0xp1/+cCIWlNmjipaDud1eou5z0z/kXL7Isn8KYCd1r6d9k6igBLefcBCWPFZ1/KOWLa+nNnq1/aH4i/NyvveflOBomxyRDxWraHjakVTX7LIOmh7mComQLZBKVY8sjz+6wlOdeR+EB73Y+UDFh7K293eoUpWEsveCKLrPCPbsZLU9xzAJLa7q1C6CbtuRDs41tSKdjsuN3BNdBXCRRK6NZUYCDO9mrQ7FmqKYUFu90vbG1HNJeG87X5FkFe8Stbq0HB4ZCawIMZlV1GBGRn/6tP6pvNpM/aEmGNPtPdZ2JMy1viA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARN4byimVFhQO/Nqt/IV1e9HP3cWLzv3L04r1naYqZc=;
 b=L1Ui+e4sS3zsxb4GDyWwXC6zksJaE4WwxF4gwAccDy1MeRAZX50MO7/O5OXBTGYxQ78CsHZOZ94O+N7diuVtcLETLKzBfYdgTlDMswPimFWWywLUUomu+uZ23V+vWP6C2AfnfN4l3msYueclLqFH3/gO6vav1OUhzxgpm6ytJY0=
Received: from DS7PR10MB4944.namprd10.prod.outlook.com (2603:10b6:5:38d::15)
 by CH2PR10MB4392.namprd10.prod.outlook.com (2603:10b6:610:79::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 16:13:57 +0000
Received: from DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5]) by DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5%3]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 16:13:57 +0000
From: Joe Jin <joe.jin@oracle.com>
To: Karel Zak <kzak@redhat.com>, Zhenwei Pi <pizhenwei@bytedance.com>,
        Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org, Joe Jin <joe.jin@oracle.com>
Subject: [PATCH V2 3/4] irqtop: support json output format
Date: Fri, 28 Feb 2025 08:13:33 -0800
Message-Id: <20250228161334.82987-4-joe.jin@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250228161334.82987-1-joe.jin@oracle.com>
References: <20250228161334.82987-1-joe.jin@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0800.namprd03.prod.outlook.com
 (2603:10b6:408:13f::25) To DS7PR10MB4944.namprd10.prod.outlook.com
 (2603:10b6:5:38d::15)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4944:EE_|CH2PR10MB4392:EE_
X-MS-Office365-Filtering-Correlation-Id: ca6a3091-d8c2-40f2-30f8-08dd5812e739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8t5BUpxIV0QteNqJa/AIYajvORT6PR/H8wDih1Z06Qn7wV82huwEsaxkcfUI?=
 =?us-ascii?Q?VN+VxXXe3VNXC1LGxP8uytxlQT04eOG2XsBNTHoGtlV/i+ZdmNvhBWTCJIIX?=
 =?us-ascii?Q?UUGv2o6//zgoL1FY6xB3jTDFjh6rAuYV6ynjJaMW7xMSoszGng7BGVrtw0gN?=
 =?us-ascii?Q?s7qNWaDtssPgSQQBVVLi+9J8GCUiWnh+tzpt0sWiWbNSHdp9sgkZcsYzptlO?=
 =?us-ascii?Q?E79TJVuAbaXBr7ZFSif81Wlu+6YlFShANynCjuRK8PL64EWwOokXvjFx5yjJ?=
 =?us-ascii?Q?QqJBpigYX+jd+yN7U22PGow9a4QM4lp4jL19cSVpqyvkcw1GIIjz7JAWF7dP?=
 =?us-ascii?Q?CIJZgFjnQx4uwoKzuLZWxa6k1Lk002k+4jOATYS1TyZpIohYqURE//wDL3hi?=
 =?us-ascii?Q?ay1CMCj36/tkzA1fWFVizdjj92mKsw3qqCOogSWwptHRDpoz2ZzrWTXOHLCw?=
 =?us-ascii?Q?REiQpoc/Tmt0BiC6nIl20n+cYAb2FNZ7I9m8CqGvFlNWc/ZzgaGC4KjusyYx?=
 =?us-ascii?Q?c2TdQUl1WaswrL4TFgrMPgIbfZb+cGXeN3IzboBkDYNW+Wk0zRra8TuIZGa2?=
 =?us-ascii?Q?VMEsORcfUUofXR+GndyqINmFOxL2N2aVyzz2kqHFEQDqOMp/pUfk8cv6BovQ?=
 =?us-ascii?Q?Zb/BSN4WVHXRVPiT2KwzvrvwYcz2lAwCxIEC933OsmEJcmEfKII87XkNUgXU?=
 =?us-ascii?Q?VGpzONLPrPfYyoXA9/TyS8wfw+PAV6gWvTy6mF9p6TVhKRCU1MWQjIYDWbiy?=
 =?us-ascii?Q?SZf/0C4snHnKciKHdzWTB3T3peXAnnpu3FOSvjAeMr5TTQPVs05JF/6/+kvd?=
 =?us-ascii?Q?ONlBAwkF0U9N+3Iinpi8duLvJPe5Osqoljlo5RBt3g1OrzjsDSXJQWSIxen0?=
 =?us-ascii?Q?5z2gQNuMegaUA22Y3O5I/Ny3B0PB9eyzKDZ9QSBcWBFasXZljiqss3Bdy93D?=
 =?us-ascii?Q?ywbhor6Uxrg4HMEAZQO60qOjf3xKkunbvnI0IA3hbeJiq4JGrtrn07kS5fD+?=
 =?us-ascii?Q?QPFcQu1RQeOnn6RilP30lyYfnNYMPJk7dB7oY+OMbLS8oNc/NzhslKnBQ9Sl?=
 =?us-ascii?Q?TY6r9vkWHWRt5fjkZZ3IZqt1BB7c23+PBx+54LSodyR7csb2JnbP3fSa/Msi?=
 =?us-ascii?Q?hLlxBel9zPbhX6K3Qj8Rv6ui1tG8RaPe6YJytN+RabzUDWVNZ5LyYFVkmFhw?=
 =?us-ascii?Q?59Hjaq7e5x0daDmuQNdLh8j4SidEFDfGb+4ZFVFxTP4aZy6/6cOFapN443dB?=
 =?us-ascii?Q?Vrk0Y2qrR7K3ZLkFyPnRaMtBMSTCqntXio9uxEaWY1VqX9M5x8eJJo4YoSTl?=
 =?us-ascii?Q?zMBoREgZk7l6npyauCPZ8+jFQk0kQc1MI26wo6aAvukHZkDArH/I1aJuiAY6?=
 =?us-ascii?Q?ZwXqb4kYTnlshSeeYd9Jk4uAcbTA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4944.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+Oc7urSkuLxTcYzwSh9XnSW1UKdNFfm7VrugdIroWngkBmEQclDJ5dnk1zkg?=
 =?us-ascii?Q?sFoZ/JK9l/OaHKTo4iFRY1cq24vPrzMKbQ5CiN7N1ee7eWmzS3Q0ceKQCFNU?=
 =?us-ascii?Q?HNhOf6TaEY9DnC1bLfSPeVN8d1sGIJC5PpNdqkhrj+Ym1TCTv5gE3Mr9xqrM?=
 =?us-ascii?Q?agoQnqK+FBfcJhf/CiNViqxtD/RAo6CNBWfigDFg09YblzBuV1aRrZsyJZGO?=
 =?us-ascii?Q?EfavOdcPXhh0vxFeagW+uHYzBixBH9oo/ahVz6PZGLUji0Cr54aA2t3GbOTU?=
 =?us-ascii?Q?ccCGKFpkIKmcaj3MPgEU8lxYzl4M0oeLXl9R9jjfd1OiqeNwO2gtWyyes2HP?=
 =?us-ascii?Q?3aUchhDxMOCl7PKFxc/mK4Yd2KQZDE/fKSbLTesK7B3iFvTiUsKvKX0dqsJ9?=
 =?us-ascii?Q?Qv5rSa/AyDYOihAx5uhlW7GVG45rp9Rgg57RkccXgXE1wXCj37H5msUplKXy?=
 =?us-ascii?Q?jyYFmf2tS6KDEygGrS8FcyAOyCPbPnvrO8g/UDaDkdiUAqGVvFzcs8LTwOkP?=
 =?us-ascii?Q?WjzySolTBNfWptR1CG/9eB39TqzyrdMdCQVyJ6Iz0Wh0xWTip/I1Ag2ce09T?=
 =?us-ascii?Q?M24gjxw6C3ChCMxCdFY/bRt/gNnE+zdk6dZ6yZHkgbznj+hsn3OQsQPPDoEd?=
 =?us-ascii?Q?ZM2y8NTOqSfNZrUpa5mFjsOpU5Irkx4Kb7ddP/LB1BYataT/q/2oJrjC7hFm?=
 =?us-ascii?Q?jwsD9hKPWK/dF8/oCwzysRatDMhNqEJFjgyweqkeD98HrgCUfOIjCUkchw+F?=
 =?us-ascii?Q?zbGqfJRiY95zYaA8CoOKZAWT5qp1yuyVcQmUwun3UudGmRHcB3AqBfA+sPcm?=
 =?us-ascii?Q?P0+T7qTEER32Hy4mn6X62KA+LX25MwQGOMaTTojYhFteika5IMuX/M6Xo8GR?=
 =?us-ascii?Q?zCgwNzXkA32JyRi4w49YQ+R6glKnv/7u3pHWIdQDNL3GjcwWiNd1zCBZjyZD?=
 =?us-ascii?Q?NmztAEtxLjMiabUbaN91SxcqqodmfFSZAaRaSKm4DaLtVwpaRJoKllt+liMK?=
 =?us-ascii?Q?q8OHpOm7+CLU1YAfx/z9cxWr5V8WRerIdGIfe0IVhszX8gYM2XO3M2A8vBsQ?=
 =?us-ascii?Q?usKQB0Our/qADdVojnWnBWUrBF0eDa89Zk+FecusW0n3hAXChJGVZTP6R7Qs?=
 =?us-ascii?Q?cp3zIHiW9AHSdYryl0vjdOzML1tpcDzkb6nqlJHPD+voUwh9J1wyfhxC5O/p?=
 =?us-ascii?Q?VZp6D8NQdEpnzlBeAXx6SVd+Q53Ievj5EOX3G0HVMMf7SpnS1bjl6eOT+UZO?=
 =?us-ascii?Q?2YBBcEjF0zbRqmLgBS3yR09uNt5d1aXjYPvyOT/XDZAQsil3Ojo/tk54WFux?=
 =?us-ascii?Q?d27p3oKtVVwxejKwkn/Yftg0yH1fSEf5O2Is/2aSrbyjdnR9GCDopiOY/zwu?=
 =?us-ascii?Q?hLsBygc4REKlroOL+99XRf2VqgbM4gXbSIwyVhZWnLMvfN+zYiSxve5NPKH4?=
 =?us-ascii?Q?j1qWLkluijDfYSsAA16uJPi4Elq++XCGBaFWjo45NH8Y89uxpb/Ju1TTefLk?=
 =?us-ascii?Q?GelG7XryoysR3oq9q6jpMZVf6qBFrv0lTH9vDBSGQdtH0CR23Xj4ZNZ3c1gw?=
 =?us-ascii?Q?o2wimH/E/CYqRYjHEWss8AvdatiMWqUb4RyoRhCS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+drI3eu4B7hlQf2wZtGRZnJwMyFwr5DqL+wzcsYSZ8DGcEdlrrMydNeabXwcUaoPkNPCD6oNaAw4qajsDWCcRIWr//Wj9iHmzKt+bZmbcOso2ueYKdc6k+XjbXiquKS0RD+KhqU+jotTaJj6uoKw5E8D18NGMyfrFF66CJmh7VNX9ZiS9unpaNP+AGf9b5tofElQeV5TmEjypVpodi7biDgnxrjEfJ0Gx58UfPK1WlPgQvWcdgXtUQLS/mrKaHpAUwNIpD5ytFq7LZe8xD284iik980usRk51sPL3SLR5g8IWYA005NOOaHLJZowBYw2hMHWdIqnfw+GSCcSUXLx6pfU6UbBNg3Wx3iA1BiV5mgVitYRj9XgzAClAZ/Cih9yxdSZ6O9+A6ifPouSUDDZR4U55oAxm/Zxc0KAreOZgjLUaGk85LDW5+hA1Du9mbCsvRjUXat5VSrJEzEyt6KILENWBYFcG1XGEKU5aqWUivyvTxBYT7fuLeIidf2xANImMLJHL7i8t2vKpcC8TinpFjCPnzurlrPUmGmjdqIAIUt1/UuktTYEpv9oOrx+KHhH2KitbsA8sZKp4EjZAXYsdnxAvffvh+81xO+1ogBW42w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6a3091-d8c2-40f2-30f8-08dd5812e739
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4944.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 16:13:57.0136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DK08DZnR82taNEPl/WVyws+hRg+raQkMRxKNKjYoRkX3w+5pHeOZFnpQOnIj6TZYi92KnD5XWiEa3M0Y6NfblQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4392
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_04,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502280118
X-Proofpoint-ORIG-GUID: iDjbV7QueuumSHmEIySmq0nwP0Yuobo4
X-Proofpoint-GUID: iDjbV7QueuumSHmEIySmq0nwP0Yuobo4

Signed-off-by: Joe Jin <joe.jin@oracle.com>
Cc: Zhenwei Pi <pizhenwei@bytedance.com>
Cc: Sami Kerola <kerolasa@iki.fi>
Cc: Karel Zak <kzak@redhat.com>
---
 bash-completion/irqtop  | 1 +
 sys-utils/irqtop.1.adoc | 3 +++
 sys-utils/irqtop.c      | 8 +++++++-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/bash-completion/irqtop b/bash-completion/irqtop
index d18ef99bb..5faf122e5 100644
--- a/bash-completion/irqtop
+++ b/bash-completion/irqtop
@@ -48,6 +48,7 @@ _irqtop_module()
 			;;
 	esac
 	OPTS="	--batch
+		--json
 		--cpu-stat
 		--cpu-list
 		--delay
diff --git a/sys-utils/irqtop.1.adoc b/sys-utils/irqtop.1.adoc
index 75930f5cf..880ee1906 100644
--- a/sys-utils/irqtop.1.adoc
+++ b/sys-utils/irqtop.1.adoc
@@ -37,6 +37,9 @@ Specify cpus in list format to show.
 *-d*, *--delay* _seconds_::
 Update interrupt output every _seconds_ intervals.
 
+*-J*, *--json*::
+Use JSON output format. irqtop will run in batch mode.
+
 *-n*, *--iter* _number_::
 Specifies the maximum iterations before quitting.
 
diff --git a/sys-utils/irqtop.c b/sys-utils/irqtop.c
index 17c7d72cb..48b65201f 100644
--- a/sys-utils/irqtop.c
+++ b/sys-utils/irqtop.c
@@ -302,6 +302,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -c, --cpu-stat <mode> show per-cpu stat (auto, enable, disable)\n"), stdout);
 	fputs(_(" -C, --cpu-list <list> specify cpus in list format\n"), stdout);
 	fputs(_(" -d, --delay <secs>   delay updates\n"), stdout);
+	fputs(_(" -J, --json  use JSON output format (will run in batch mode)\n"), stdout);
 	fputs(_(" -n, --iter <number>  the maximum number of iterations\n"), stdout);
 	fputs(_(" -o, --output <list>  define which output columns to use\n"), stdout);
 	fputs(_(" -s, --sort <column>  specify sort column\n"), stdout);
@@ -336,6 +337,7 @@ static void parse_args(	struct irqtop_ctl *ctl,
 		{"cpu-list", required_argument, NULL, 'C'},
 		{"delay", required_argument, NULL, 'd'},
 		{"iter", required_argument, NULL, 'n'},
+		{"json", no_argument, NULL, 'J'},
 		{"sort", required_argument, NULL, 's'},
 		{"output", required_argument, NULL, 'o'},
 		{"softirq", no_argument, NULL, 'S'},
@@ -346,7 +348,7 @@ static void parse_args(	struct irqtop_ctl *ctl,
 	};
 	int o;
 
-	while ((o = getopt_long(argc, argv, "bc:C:d:n:o:s:St:hV", longopts, NULL)) != -1) {
+	while ((o = getopt_long(argc, argv, "bc:C:d:Jn:o:s:St:hV", longopts, NULL)) != -1) {
 		switch (o) {
 		case 'b':
 			ctl->batch = 1;
@@ -386,6 +388,10 @@ static void parse_args(	struct irqtop_ctl *ctl,
 				ctl->timer.it_value = ctl->timer.it_interval;
 			}
 			break;
+		case 'J':
+			out->json = 1;
+			ctl->batch = 1;
+			break;
 		case 'n':
 			ctl->iter = str2num_or_err(optarg, 10,
 					_("failed to parse iter argument"),
-- 
2.43.5

