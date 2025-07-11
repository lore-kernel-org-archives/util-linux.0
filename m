Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2112.outbound.protection.outlook.com [40.107.93.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3841C3C11
	for <util-linux@vger.kernel.org>; Fri, 11 Jul 2025 21:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752268655; cv=fail; b=I1P0BOoVvGD5AhkzAfsWAejn4Ov3q77pI1EXqwiPZZJc0/AMcsU5wK0+BYuZOMeKFTDc75NP5nfZNPt1Do8LgnIWA0RFAmB1fSQ3X9avU809t2tFBmLl78OUbhFWeoBT6nNUI9BTZotHlzU1F3x89GdWnJNY8Wdb7SQsH/7ubdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752268655; c=relaxed/simple;
	bh=eWV+Pdb071/wptA5Knum/bsYch9GAF480CsENJTHX1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mzg0KaOMSoQSpzbK983P+t/Ss4TTRa1O0SyPaMW50TTsV2KJSFbhDwyZe0J045k6zS7nrgJJvjn4bt5C6pgUWoj8SLPDQPh0WCfZAPCf1GiddRN+Rah14SLjyPGkRWp/ovph7sksZ3goiWgFHGNRHxLnmmQKbU3nu5orBXAlqnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=BzFFlA/H; arc=fail smtp.client-ip=40.107.93.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="BzFFlA/H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=raB1AQZCBmokvp6J2jDGCu69mcxp4cLjpdcgJrEW5SPV39XFgWRMyzpG1ri0oVavUKAQE0onDjX+SgNgvZzFHA32WLCT1NBiJUBgowpKFPQcqssEGSlmkPzh7FldSBfc210Jojfg1eyV5KmFP9NB110QZsypLu8lDlSFGFROTD9isWtJbsqBt++QJCjzvUdJ5bIXyPu0NYlczRZeY0e9NzoRK95XzuQZshF1C4Gp6AQy7FyC2PZWTv9HB59X1113exS0ZzCZs2qgKYA3jIrgqSAnNm6ZdnBUo/Sy1RDsdzSq6/7lyhjOeE2klZWiPfJBMfc5yjebGmLeQ4ql7KBJ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=up/415JcJxf20v9jkG6Vf+j/mt0zN++X0dqpXfE1yTs=;
 b=OPM7FtQfvspmQPSspUjtDdSpQrBz56VgyM2cYAUKZFhEyNts4GroGHu48Z0UjPySTgSu8F6nhN5mZ6zUq/qolZ6+m8TJYHHkSj5YgMWN+qDc27tVpUDbD2jOCEJPotZ7M6KToyoRWue+WkUMzAo5wM3sNevUuQ/i4xYqoFIGamLhM9gSMu1h8U+i8d+pI6EYjBjk/taHlzM30dfmzwz058G0fIwJXR8p0QAvdUZcugIFPC2P1gxlM9fK874aizkYnvBRKsBg4xwvBYGdgeMHMjQ2TnUJoJGvKdlgJKQQ6WXyM7TgzMQqExwyx96DN2QIxYqV0fTf+YYxqlY/KA9LKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=up/415JcJxf20v9jkG6Vf+j/mt0zN++X0dqpXfE1yTs=;
 b=BzFFlA/H8utt9tv8zppoI9xwAqESQXsIbPOZHktuW4G6v32aT46x+amXsSQMb9nhaj7aQJA22MMMI0f8nZ2tmpd+AcZULDFk2w+TcZgk1kYown+kV7epNvBOg5qcCnlf+Y4D/0dnfwgsMhH9v1d08wsuVeTB9MntslG5xRpF0S0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8501.prod.exchangelabs.com (2603:10b6:806:39e::18) by
 DS1PR01MB8747.prod.exchangelabs.com (2603:10b6:8:211::15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.26; Fri, 11 Jul 2025 21:17:30 +0000
Received: from SA3PR01MB8501.prod.exchangelabs.com
 ([fe80::f7ae:9cc3:b435:c49d]) by SA3PR01MB8501.prod.exchangelabs.com
 ([fe80::f7ae:9cc3:b435:c49d%3]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 21:17:30 +0000
From: Paul Benoit <paul@os.amperecomputing.com>
To: util-linux@vger.kernel.org
Cc: Paul Benoit <paul@os.amperecomputing.com>
Subject: [PATCH 2/2] lscpu-arm: Remove the "Ampere-1a" part.
Date: Fri, 11 Jul 2025 14:16:48 -0700
Message-ID: <20250711211648.53361-2-paul@os.amperecomputing.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250711211648.53361-1-paul@os.amperecomputing.com>
References: <20250711211648.53361-1-paul@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0275.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::10) To SA3PR01MB8501.prod.exchangelabs.com
 (2603:10b6:806:39e::18)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8501:EE_|DS1PR01MB8747:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ea4b059-96fb-48f7-057e-08ddc0c0584a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KycXwCJxGONqNpr2JlAj57lSaEdFPiqQMbf8/8klblSvvyP7SMJrtdDn+5WG?=
 =?us-ascii?Q?N5pErVaCb9pp0E8LBGIgNS7vMp5jvVh8qsBDfINxJM1z//4fewXGA9QdEou+?=
 =?us-ascii?Q?MuuXCsV61GHHqbOaFqqGwrdLsGS1uOTw9dZP2aJIhcazrnK+hsmcCPs+tJQd?=
 =?us-ascii?Q?FHOHEAbjERgKsznySkshmm/XdGXrQsYV1ltrxBWuWpd5TqtqK69pS2m/lpto?=
 =?us-ascii?Q?oDJ9zP41BHp+HwLseDW3zf0Gb+nTW4p5XnLH14RC5v4aNBk30wf13QkO6lBg?=
 =?us-ascii?Q?IRXo39FPyzsmaTaOl/KMYX21WZbFslG+4HEBwp2auRnPjSLIKDPTSYQOQGGf?=
 =?us-ascii?Q?RL3QXyWYZN3pX0Oi1NcofGjVo6KKQL1edJcTDVhiLTnoLnoG9JeGSFh1RtD+?=
 =?us-ascii?Q?rnPCcOKApJ9RbydCL5zZMLm6LlguX48/8KMxH0vCoH0vSUfqv6+qCZVlPcHm?=
 =?us-ascii?Q?JgaiEDrlfDbfJ5/jV92m2ysv9wEYD5JKxUXVICH43FfW5VYxidXR9+zIK5vN?=
 =?us-ascii?Q?Lrwf6B5ebqRr3KQccMgBC7ENlZ7uPhU5YZNgcWQJSjK4Tw7AGpPqSVdo+sxY?=
 =?us-ascii?Q?6FqXE+6NoiorvFmAm0rh/HabRaWnPDOMsLWuuApm27RBhgvbQVXTeUI+BKD+?=
 =?us-ascii?Q?v3O44e68b6RpS9jQl84NmTzGPaPfi4nTiZUhlZB7c6oTyH02456SE3qKOl0N?=
 =?us-ascii?Q?TIWwDlMRX8KHeCCWbh/O495jF2DJUKrWakU4v62XR+v6Id63yo/QDIV592Sv?=
 =?us-ascii?Q?R0XumPzpg5JOQAJE8pSq20VsJgPj6aBaN4XEY1eZB5MDZtJcCw+ovYFt7T3m?=
 =?us-ascii?Q?5TetXNPjlhfX5vnvCSJKOJLuYQ4E/CIUV3Ag2bmnShxxxZffQu9MJLypd0Lo?=
 =?us-ascii?Q?1wl0FdG6WyGGEa2uOyZUm/SBabgQApisEkRBEWxkA74sldm243D6eY8MljpJ?=
 =?us-ascii?Q?L13iBICKD0PWkCLxoSCshQc7nGLo5HatyuyG6Cma8YfumzJWqP2g5PTJFrZ+?=
 =?us-ascii?Q?0EcqIzTK86RtqY/O0KSLMwydOE08gxSM1uKjEHDRbSrnNcDzQ0SdDhy8FaSj?=
 =?us-ascii?Q?QwRdegUaUbr5gn4bsjy9mYnFaTLAgMNbRKn1MUmZ/I4IDSFPpkxdYYJGmAPy?=
 =?us-ascii?Q?7fj6zrcqCt/74TOku2b8mn91Wzh3ZFTdPctDAce3/VHxaHdYMXYPaOxyP3H0?=
 =?us-ascii?Q?dr5ZXV56mDWX8+cFzHHLeqzkyHgq4Ww3fCcmT/plRSljKeCI8cuzMTW9Qaxj?=
 =?us-ascii?Q?U6Cz/NL0oevAkTk43/7bYYjdeFKJNlIL35Anxh+fstysr7D/UFQa5AWUCe3r?=
 =?us-ascii?Q?7kzQiKHX2oE0tnd7EVRtJyMtb3spA9hPJ7ZBXJlbOV3wkPtxWSDSlnHH+ZJU?=
 =?us-ascii?Q?rwFl2wIVSCdO9vaBysr/uLAK/P0HRNSYquIY8ePsJFRGvGSGJPaZbaPYO9Rd?=
 =?us-ascii?Q?dsScUoqpQ2pGh8K8FNpCFJSjsxJowRSBKJI7aVvtiuva5DcsxczAqw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8501.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AKLBV6VuqaoK0/S7+mCpvuxOUUDCKA7k5nqo+niZJXCf99d8IREl3hBIBTMn?=
 =?us-ascii?Q?dsVxttImqe2ZswEue6zPF1KbdISigXqRLbYTGSzchuRKyJ/E5f/Fl/HDY1aZ?=
 =?us-ascii?Q?Nps42kpVjKmtej2HSvYzZ/lRbV2k61rP7OjECsbSs0kjsMGe7w+3Ji3S59lN?=
 =?us-ascii?Q?cWm8OuND/1skLgPqI1M1ffq94BJBmqUZs7sFhfxFiqz6/pG82YNe+qOp41Rl?=
 =?us-ascii?Q?Cu6GDBpzh/b06WK1IhK0GNIwiRRPelu8Q5pPRgZ5wF9lBSf14XWHwt1MRfd/?=
 =?us-ascii?Q?0ec69QSUIABYbjykUgMlP237ASQf2PxfVpvh3Y7E2uOVOOr4MjnYmraJ2vGN?=
 =?us-ascii?Q?K0GMVWIxUEyKDSOx4dFiDxQSSDJ2FlvwX3b9anpOUWr1+P97cCZCA49fV9R8?=
 =?us-ascii?Q?mRfAZGk7XD0N3QaZKc0PFyLpdvOXaukEX2v9+DbtfK8UA04qW7cTMZVAzUm3?=
 =?us-ascii?Q?ab8dwXb6eZXsH7KYCD8WqeubH2OMRHWvarVMYd6LnMH8o1dEqVcvZQJvjIzs?=
 =?us-ascii?Q?oZ3DXyUGY+Qp7dsAaaCN3YneiwQt5mShEUWv/5nlVX3raHS2rziFfqAYzF2d?=
 =?us-ascii?Q?J/aac5zyFEXrmQtPE5o+yAvYJoc9aHZEYbSZfxXKLyKNQpSn8UR2HldVCeiB?=
 =?us-ascii?Q?wHSkffhlXY+TYrt3/XCTMFQutwvcoq9Onor0mY7nu/OcYPUt/JvqhHVfJrXy?=
 =?us-ascii?Q?tndyxdevUARuwL2tmzoRu7hnlNwHouwp1SOhanbADnWe9U4v62F4FYXyRtDi?=
 =?us-ascii?Q?Z98Vaj4jK2l8dGps4003sabcFDvvDwEtNuMM0HKxU7SU9iDAvzjbgSQu3a2v?=
 =?us-ascii?Q?ObzXj0moFFosiT4zOzyCFKqU/4Df7HNtH3wz0H0jood8E91jlqLV3hkf7CzW?=
 =?us-ascii?Q?zADEDiJeu3Nb4CBGiwWRzMVZwAIwnMimtSLLC4/dT1pZHxu7Ix//M+fyziL0?=
 =?us-ascii?Q?Y/UadMCHKV2rkb0Das7sYZuvcU9Kc/nsoWoLYeBCcj3MTOqmVPwpXRayJ9B0?=
 =?us-ascii?Q?1pxJAmvvmWOR48cQYl21v1k6876xj/3lTjj4VTEahyvfBObzL4FaCv7yUSHR?=
 =?us-ascii?Q?OkC+RdmoKabDlXrlWv4xox44e7xlN8fodi6QKAfl/ORjX9bBvxh3MP7Ha/ng?=
 =?us-ascii?Q?a5/ujbLBDFg7WVnVrWvRd3ee/2YSq0cct+luYLkIONcmy5WiqoDuF1+VMzza?=
 =?us-ascii?Q?K0v93JWyn0KC7+vTcsO4IO+2Xs3f4jxsao2ZXc8ppydta6JQ7QP7CzHUjJYD?=
 =?us-ascii?Q?YcPFY7Iv6/jstYTc7TjupweCus1MEpDlpFWy0MsATgbK3yEpMhOx8WIzoyk0?=
 =?us-ascii?Q?/DyAMgoswiuQlPKIU+oJvxagQORIFnXPB8KcPmTkUt25Aq/LTOJ9OqOv5Ogq?=
 =?us-ascii?Q?1amlDNXurOp+cux4c2pOMOeCVE4wCWSYra1oc9ntNb1VfwKU3UjhcGlg6U5x?=
 =?us-ascii?Q?m1Hh1f+H9P1lkImF8XFItfHEhkC/a5JkxoRzlQQtxC9EkMjBuXBy7HfVp8yF?=
 =?us-ascii?Q?0CIzM4TxOKXyOSdJ2ngkTA3v6P5DRcEECh184/Vwol77vDK/izZ+cCrq8f8h?=
 =?us-ascii?Q?hhVi3ZXsXqYMoJU2gi8GMUmuCBtnsqM9r/+CGaFCMljvYmvNwbJNe/Zi5QaY?=
 =?us-ascii?Q?zgc6MY9CRoQR4E2rVscl2pU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea4b059-96fb-48f7-057e-08ddc0c0584a
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8501.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 21:17:30.6183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/u/xU1786Vm6t1Zeqze7F0sKSatbKJZE4rA6HhTkLR7DA8jACMtF6pTBCoBsFaHYtuk4bPpKp5/JQgIKJUvKs6wl7SJZ4V1y6/LIsKlbzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB8747

Remove the "Ampere-1a" part.  On newer Ampere Computing systems, the
system/model name will be obtained from /sys/bus/soc/devices/soc0/machine,
that is populated with the ARM SMC CC SOC_ID Name.

Signed-off-by: Paul Benoit <paul@os.amperecomputing.com>
---
 sys-utils/lscpu-arm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sys-utils/lscpu-arm.c b/sys-utils/lscpu-arm.c
index 8745599d4..4ea555d86 100644
--- a/sys-utils/lscpu-arm.c
+++ b/sys-utils/lscpu-arm.c
@@ -268,7 +268,6 @@ static const struct id_part hisi_part[] = {
 
 static const struct id_part ampere_part[] = {
     { 0xac3, "Ampere-1" },
-    { 0xac4, "Ampere-1a" },
     { -1, "unknown" },
 };
 
-- 
2.48.1

