Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762DA2561DC
	for <util-linux@vger.kernel.org>; Wed, 19 Mar 2025 13:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742390952; cv=fail; b=h+y3VeVj30CWH69vopFWobAypqNt0eDGGzv9fRmetPkD8dV30f94puvB97slgN0IL042gvoHbzrzAcdC6lz3naGxKB36nhr3Yxqyuyn2NZ2P9BoKbcRAnFnPJyl7aXxvVSNrKVLq5kAw1sN8F8jRQVO57Rzpeezw24Gadd12IBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742390952; c=relaxed/simple;
	bh=uB2uVuF7EVX9dWHsgPDAY8tGaUnWM6VegoHe3vvdYEg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eT74TukAMAccCQdepjAMoC5nSbGh6ogNd1R0NCuYTPj52EMNaCW2MyDOYLna5VMG02b4fJ07nKCSUXekbYnFTbXFGM1DD4EfEhTIEAfS5zaSwVt8cIsWRP3M6tr6fziSoq+rLUerWlr+5hJ+4gvDlbyfKWu21FCrbAQoTdCG8bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=dx0QcEUQ; arc=fail smtp.client-ip=40.107.21.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="dx0QcEUQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fn06VVflHx+FCviQFh6tzb8Xf8eqG0E+1G5aQls3izyGHrJYRO/2vfRS5ZFlWRc/2rydDYSN8rz/WeGEP5KGpVSwg6Gix/xw/be3IAmQZ5am9eKcLhK6ScpL/4lFcZ0pnkfVvHsJEOXl/lM2zL24JAOr+5dsxbNVI7Hdz5Fz+EnCMOh02AxyzM04ZSw05VTO4lOmwCw4V2VDwyO5ve8faF6GoliQjxixd285lfT2OnmfPj8zSZN3oMMPGHIVQMefkotkr3GwOgiQBXfl17/uJCvTyTp+UEaL7zh5lD6JSstt3v+W4L2VxlVP0MzCTzYER29HMZV3ogdeKsMf3yOwnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGUvbe2fVskUZJQ07JFuPaPBWMVVdltd4X42ENC4enk=;
 b=VD3WEiDGXIj7fHi6Nwz1EQnGytZVbfYAD7RVTOLmBtV2pcGlPbv2Q2c9zKFFy8dpIBs6s8gptZIL3WTNx6j5kgbL7BRITX0bFbKHqVc0WpvcShGpXTjsatbwFg3B8aRTPzHD6Vtzjuc1H1JtGyI7KUvFj6jXpXQtxTB4L7ElTcjJkYuUcPmEi/IsGm1T5jbrg12TtXcS8SmmtCjp2RgdIxqb0/VvRYpp8u0IJYo+wefTWfaAdhqSIzOto5qSx/cl2c/nIKCgJ+VC0T3ltR/B05MDoEShmEkON8l07aZWkRBBK0sD//47FBEZYzXLuB0lhojpqR0dnZclxYUx6gVhRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGUvbe2fVskUZJQ07JFuPaPBWMVVdltd4X42ENC4enk=;
 b=dx0QcEUQfvUZ+179qlh/RLwmwl/adWs337ozx33BSEBdrjF5NIZKMUyAxgKaxrmtCBPbHZTM+H/SC/0fb1WLZUQb1cLNxPD4Pi/tGq9bdVvvkMXDdAb71PjzImjAnQ+8BqvoGOpzthQQBsOUFXEFuMyD1KgrWVD6PMmDstu6Vrw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by PAWPR10MB7916.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:369::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 13:29:05 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 13:29:03 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH] Revert "hwclock-rtc.c: try the 'new' rtc class first"
Date: Wed, 19 Mar 2025 14:28:59 +0100
Message-ID: <20250319132859.455264-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0062.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::16) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|PAWPR10MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aca13df-2388-42d9-5581-08dd66ea0444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l9783cvpWpHOwGc2obsDH/8pQznY+dtkKUKtzNL5ezftvqEsbgotImPLk90l?=
 =?us-ascii?Q?KhnnrZ07ZCnc1heWCxKdt4HLxD2M4Uer0jl++yTl7LCG93EiqS+gEJu6h0Hg?=
 =?us-ascii?Q?59PehclcDG9ushdrvS6l2q1O0ECyIn73tDZmqXdMDLQNuDBHvAAVB/5UFfVG?=
 =?us-ascii?Q?Q/C7aM3Ms9BQTdC3OCUDSkbDmES74d6Pnk+Tz15RKOCo7XCZerC6rUPK6/4f?=
 =?us-ascii?Q?o7hdQfClO9r/hsdHxImuTu6TTYfQlhd0Y5yVu8B8ceDy6EeLNL8F0ewV69BP?=
 =?us-ascii?Q?flZiSqPyr12N16o67DBPBUhXGFdt1yvH4qMUq9/EKTns2gDggVzjmjDF2dq0?=
 =?us-ascii?Q?/G/H8SXTJJ8SzpP+wlz7Dclm0ShNsnQ0UBSBKewVOS7NgwgjR593NaXSz5GF?=
 =?us-ascii?Q?swMfr41LyQaObvTk8HZ2me989G4UbfifqY/bKjQmTewxd1CxcoKzKX8J6+FQ?=
 =?us-ascii?Q?1WpEazN6j6pI4l3OPXafyBHqHxT7efXZfVKAMCDXUU/aBG0nEQsqdzgFIQRn?=
 =?us-ascii?Q?nVFWDeC0DM9o60veZiUkY2hz2PPqlPycWWiStXiUtNMSEfy1iEIed+SFDVpH?=
 =?us-ascii?Q?BdpHYGI1zNgEYcy3zPGmhCJtquYAcaeEWlv6LP9EDQWA2L8kQpsxsijBSY2V?=
 =?us-ascii?Q?L5xIsa5+NvlywEE6rGWV5vPEUwHRHi2DwoRLWTan07tlMT3LyDeZGe0vZup3?=
 =?us-ascii?Q?SVCeHLei4o8UHYFjovyA5gxqKwfpVJHfKGXbwHHhvvVZXJVU3CDC2g7ipyxw?=
 =?us-ascii?Q?onp0ewtjXbL+OyouLU7I5x5ZrcXrIx/k2MRevQqFa75CGdQ+wYA9092rooNc?=
 =?us-ascii?Q?KFCTf+YOaLt3TJZ6+Zzo+rRCcpjF9uuQ+m6gGOI/biCfs5yQloX/dihSK1Kq?=
 =?us-ascii?Q?xrHf9LIb8nJZvUBRuhMweufSVjnRLW4XE9SiLEBwg3A5CYjuHl5iVWq0a9g+?=
 =?us-ascii?Q?uA/etqHPX2HBbgLFxWABod/+e/Zu+7fRDDtfUaHJqMPzEKqPg8rPcKsBo0VC?=
 =?us-ascii?Q?K5fLR2zeXvfOTy/xWID6MP0p4eL2glHNcRDGXfgUkYuDFKaqSvgvW67uGMma?=
 =?us-ascii?Q?WZly/S7roc+BZvgz+Mq82PSPik7bLg8EfyhMVSHHaEI+6V+dUpdEwPKOrrns?=
 =?us-ascii?Q?REJ91ycXz41YTERGJhV1G/pnk0ARCDqUG2Di3hePWkDKlr4AY2Fy3vwefR9G?=
 =?us-ascii?Q?B+9NR0BzqxuEW3h9+1FU59d9KLCQ5TDtRYUpYFSoEAdfUpSSymLDSIJEqLOV?=
 =?us-ascii?Q?Fh4nMuzWaqMSCy2+oJFxzsWkBsV+s8NLjYWjEAV/aTRlKg7AB2zyRPUE8pVS?=
 =?us-ascii?Q?HIjBOLIZruqyhk268P6YepvzgaIUWKei0GQ/crRBT5V6WZujx+7XJZfsf48d?=
 =?us-ascii?Q?Yu3bfr3FQqvNL2/0xkXZVIF/M7gYUW6glTQETIT6z1FBc7WqPVXRR8tD1dDQ?=
 =?us-ascii?Q?NfzdadAanaski2vkqoPNA0fTg6daARwp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qc3C4sZo9UfINtLKYwUDU7ZSULp9/1r4oX6DE32DscTaNaOJ8o8G/VDH2ua4?=
 =?us-ascii?Q?o9a2iJbPiHZp7F1i6loo22qVd/7Wgt6DNvTPMViam7meueQ3VgwboWJqabC3?=
 =?us-ascii?Q?Q04d8L9OVVZmfIFG2TvOF6LUgHyc7NBHrvrdBoufbXzqQMb2lpfFeszcgsUJ?=
 =?us-ascii?Q?+1/VSFkXSNkh/UWcSnc0v8p4frI9Njrxk75kJehaZxqBEVh6i93fnlBSRqll?=
 =?us-ascii?Q?xb1VvHxlD/pgO3l+0eO7Gmm056UFW9VHZB8Lfz3Ck6fOyXKoKxZwp1BtUBqy?=
 =?us-ascii?Q?NrJ71yVu4Fqd1JxoHdG/71P6UekuzHmjouFgTWdkPnSN/aLUUkDc6LEHJCqz?=
 =?us-ascii?Q?9ZcbuKkI+2rbeZWdsZtKfo3ukn2/we3k4M6rgvGTUpvVvZ3yHhgRmspHTdTr?=
 =?us-ascii?Q?s04lv8jz4cL4c991e52c2X53sG+Pj+ftb9mq78l0fYqrJZ1JU5CoO1oBNzAS?=
 =?us-ascii?Q?sQOgfq47Mvv2SaU5hqVB4oo+nhw6KgO195/Zhn36PSCeh3dFJweQTk1ew0hI?=
 =?us-ascii?Q?34wiYLNK6wyp+JVT0141J3JKT4DTONrUeRR4Nz58HllMDG7zAK/QefuD4Jiv?=
 =?us-ascii?Q?Fy053LV7qnFPns+urO64XqIi+DvhnwLc6/E6xsRTJunnsWIfdnbOpvOLAB4d?=
 =?us-ascii?Q?cEe0l0qrhhJAgENCUBKGCROYKOXA/f31kf9JNr1D36Yb6uoC1iV4MZSsfCBD?=
 =?us-ascii?Q?JxcM6/2UvzhJSxZM2tswuPNhl/PJURGeDFMez8YDWYzF8SUGGymvFWKN4xr6?=
 =?us-ascii?Q?rJHbJ3ic3kwrUyG+e5BGZ9k+8jpfxW1Wyzxu/C6RZynzDtHtSFRP/bliNb/7?=
 =?us-ascii?Q?JctWE5lVVHAMEMjSsQP5oF9P4IHBphpVpW/osc6iWf4O+Q5g+izVjVzI6Jhj?=
 =?us-ascii?Q?FFdCc9YuWhIK9h++m6ol/062zFAFXc4Oipzg0X0fgCqco2crLW5k8lj+A72E?=
 =?us-ascii?Q?RnrNyLdDYz3Zkm6BnW75jfqrDPlwLqlCRWBdGmmC+2/toD0MbL1HmEkzMR4z?=
 =?us-ascii?Q?ky941DU736juws9GZzh/1WRGdV+BzstqOGaTihQPlpS91C+RVnHJIcwNItT9?=
 =?us-ascii?Q?eiCVLG1RB20/tYuu1yOo609zO67qs/LBcsgLbPQWdf52HrwFqz6mzU7elppa?=
 =?us-ascii?Q?eIPYBZtxXX43PX2ZL6jn6SOtJLjyKyajWOM6Xy82UlskWIoeSOvPgiNn97Mt?=
 =?us-ascii?Q?+WfhNM04BgiNII8myeVpdBO0fq5BEtvrILUD41MoFEqenoqIG782BiOUuI/R?=
 =?us-ascii?Q?ZjRRoePUDASbKKPgmZcTT12Wi0RY568QYwdnh3WZQK3Jxj24QEzB/uS/ITs3?=
 =?us-ascii?Q?skooMPB4zj8HNAsfedd7BZhAFdTJ3f7PDZQ6t37LJgtkMZhAFKWHXMCm3y82?=
 =?us-ascii?Q?NWrP5STlW+JKPq8Oh9SIt3BmPN21KDN7OxZ201EaFIW8n9CVupxrh0IbAYQG?=
 =?us-ascii?Q?UYWOQxSxW37MxptohN1OrEoReL7myBvXIf1QdP8VHK9C76lw2p+d5YipeE+o?=
 =?us-ascii?Q?D1BCORZC3mQBpVmGGzkRKigmr8SmOtekGDEKe0sCmH0sIat9eQFKN7z9HqxC?=
 =?us-ascii?Q?i6M30bDRpEHYZYmvG1s8o0JmZ6q5MpuHfQZwAnq6k4WtNpzI3FJO4spXusKi?=
 =?us-ascii?Q?BQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aca13df-2388-42d9-5581-08dd66ea0444
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 13:29:03.8297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOKeajKktt+F7hqlk298bJYYk4EL6sPo71bGM5DuPw52B1eOZMX4XxzZDDCFGDenSMzViEBZYW1mFP3lsLDWPjPwPrEfAJibEAhoMGMqusA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7916

This (effectively) reverts commit
1811900a91be856e794005511eac7859adb8e383.

There was no real motivation given, and it certainly makes the default
behaviour of hwclock on current linux systems counter-intuitive: udev
has a standard rule so that whichever rtc device is designated as the
CONFIG_RTC_HCTOSYS_DEVICE one in the kernel configuration also becomes
the target of the /dev/rtc symlink. People may have some other way of
setting that symlink, but regardless, that must be considered the
primary or default rtc for the system.

Also, busybox's implementation of hwclock still uses the original
/dev/rtc, /dev/rtc0 order, meaning that installing util-linux's
version on a board previously using busybox leads to unexpected
regressions - it's not at all clear that one must go around and stick
--rtc /dev/rtc on every hwclock invocation in all scripts.

While it's usually busybox that should align with the full-fledged
implementation, in this case, I do believe that util-linux is
wrong.

There is no change in behaviour on systems that for some reason do not
have a /dev/rtc symlink, or for which it is a symlink to rtc0 (such as
on any board with only a single RTC device). However, I do understand
that reverting this after 8 years can itself lead to regressions, and
I can understand if it would be rejected for that reason. However, in
that case I'd appreciate a config option so that one can choose the
primary rtc device at build time.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---

This is https://github.com/util-linux/util-linux/pull/3366 , but as
that hasn't attracted any comments I try with the ML.

 include/pathnames.h      | 2 +-
 sys-utils/hwclock-rtc.c  | 2 +-
 sys-utils/hwclock.8.adoc | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/pathnames.h b/include/pathnames.h
index 34ba11ca3..db836a217 100644
--- a/include/pathnames.h
+++ b/include/pathnames.h
@@ -176,7 +176,7 @@
 #ifdef __ia64__
 # define _PATH_RTC_DEV		"/dev/efirtc"
 #else
-# define _PATH_RTC_DEV		"/dev/rtc0"
+# define _PATH_RTC_DEV		"/dev/rtc"
 #endif
 
 /* raw paths*/
diff --git a/sys-utils/hwclock-rtc.c b/sys-utils/hwclock-rtc.c
index f7d766f2c..f8af5545d 100644
--- a/sys-utils/hwclock-rtc.c
+++ b/sys-utils/hwclock-rtc.c
@@ -94,8 +94,8 @@ static int open_rtc(const struct hwclock_control *ctl)
 		"/dev/efirtc",
 		"/dev/misc/efirtc",
 #endif
-		"/dev/rtc0",
 		"/dev/rtc",
+		"/dev/rtc0",
 		"/dev/misc/rtc"
 	};
 	size_t i;
diff --git a/sys-utils/hwclock.8.adoc b/sys-utils/hwclock.8.adoc
index 0b23a37e8..350d50275 100644
--- a/sys-utils/hwclock.8.adoc
+++ b/sys-utils/hwclock.8.adoc
@@ -137,7 +137,7 @@ This option is meaningful for ISA compatible machines in the x86 and x86_64 fami
 This option is required when using the *--setepoch* function. The minimum _year_ value is 1900. The maximum is system dependent (*ULONG_MAX - 1*).
 
 *-f*, **--rtc=**__filename__::
-Override *hwclock*'s default rtc device file name. Otherwise it will use the first one found in this order: _/dev/rtc0_, _/dev/rtc_, _/dev/misc/rtc_. For *IA-64:* _/dev/efirtc_ _/dev/misc/efirtc_
+Override *hwclock*'s default rtc device file name. Otherwise it will use the first one found in this order: _/dev/rtc_, _/dev/rtc0_, _/dev/misc/rtc_. For *IA-64:* _/dev/efirtc_ _/dev/misc/efirtc_
 
 *-l*, *--localtime*; *-u*, *--utc*::
 Indicate which timescale the Hardware Clock is set to.
@@ -373,7 +373,7 @@ The system timezone file.
 _/usr/share/zoneinfo/_::
 The system timezone database directory.
 
-Device files *hwclock* may try for Hardware Clock access: _/dev/rtc0_ _/dev/rtc_ _/dev/misc/rtc_ _/dev/efirtc_ _/dev/misc/efirtc_
+Device files *hwclock* may try for Hardware Clock access: _/dev/rtc_ _/dev/rtc0_ _/dev/misc/rtc_ _/dev/efirtc_ _/dev/misc/efirtc_
 
 == SEE ALSO
 
-- 
2.49.0

