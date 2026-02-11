Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020092.outbound.protection.outlook.com [52.101.56.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAA14414
	for <util-linux@vger.kernel.org>; Wed, 11 Feb 2026 21:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770845033; cv=fail; b=JEQHGhOzNG3Owi+x7ukRuZciioI3ylsda7Zmhs2lXaa7mNwZTAPmziWKXTNlGSD/7XUb1ngabcmxOBlSQMavQ3ljXDiPJDEF3/KY+NbC4Hz5sH6MmIjszJzXCTFc41ldyFZLpJ6NrWsiVEozBBqbqHxLAMI30XNmaIa/fLZNUmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770845033; c=relaxed/simple;
	bh=D5gWxi4lGJAwvD8iTsmA7Vspo3oM8c5cMpCEJKiukUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NLPEsnLhO2uNi6z1/3cmREK2zVmSpQvp6OR+8fEZzFXF6WOQhp3B24nHhDpoeFtoDmWfUH8eIGrkxoniSIhzl6JKxL0rFPsHJPx8wLejzx2Y0Zmpq272kPARP983TY8TQLnc2c1yRh/SnVMGXRoAX08o0qMsfuZOQYHAztzsKmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=FRY7tyu5; arc=fail smtp.client-ip=52.101.56.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="FRY7tyu5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6n9w6m9ajeNNPi6DZ2anAY5gSGMi8bYSx1we2FU1BWpO+Gxfzmw8RcSm8lD4IwsdBxzShrjHetrp3mamgfbvJ1bdiitOwMN27XJDrcVl1rGwnNm+76AQ1+ESY0UxWz61FSYT+oCkRSHtempN5Q2bj4ZPNrJR64t9E+abwOhooG+QTnq0qobm87Ss7GJwE9Q9Sz2Sa/2b7OrfCdeQeUbrG9AfKK5U1QZMHtmMC99bu6P4SdFUicYIRE8+KuO7IBYVMLJKvqq0zvpoGSWT7QKYCwzanBT4wNPK9Y9DdusZlN9FzCABUn2PVCoWprm7gZQa87S/PtHEoo7FfzLqELtjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWJF/DB96Oxyk+U9f7+IzJZrWgMpp+1o9Qpd/0EF7Vk=;
 b=YlSqgswrilPxxud3r111oiHpGv5IBH/oOqQbnzI+tTeLA+EZkmvzoLq8LAlAB0qGABH28Ks5a9JoulSRdG/0QDLdD5CpdrD7hqJ+FcqLha8X7HaOpF4cJ/U8+FE+vsulC5lh4ENcv2bWO9vAQjt91oqv3Abc04EaJNKr6IzXnwmr+PNPDZBwopN1OdtZsuuY/PtbbNudk9BBa+uUyTLen0scodl8N7tR8WyQBgBLoSxQvXCNqQ+TZ8II1lt4tqCwzvw5s4VdKaO4CKPHQW7X8t7TizbNZl0f5mvx4WKzToWSrYoe7kgK11XGdmg5mYtAobTJQMP23723+J3U5Wh70A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWJF/DB96Oxyk+U9f7+IzJZrWgMpp+1o9Qpd/0EF7Vk=;
 b=FRY7tyu5amVu5dzDEaqMKLfXq4aeYy+gO3La9hTG+lLDGxgQHcf/3xtIKsPdfWKFfV4JXTLF5r2dk1HjbYeVMNC/hmYB9A9CAHOm2wlEYmbvXLKZkhkNgFozxM8/Z4sDRRh6rHQJs4cOgIbnPEHGGNRV0KC4NvDm4g06mVDOSKg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA1PR01MB8179.prod.exchangelabs.com (2603:10b6:806:330::14) by
 SA1PR01MB994237.prod.exchangelabs.com (2603:10b6:806:49e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.10; Wed, 11 Feb 2026 21:23:50 +0000
Received: from SA1PR01MB8179.prod.exchangelabs.com
 ([fe80::f091:2832:ffa:784d]) by SA1PR01MB8179.prod.exchangelabs.com
 ([fe80::f091:2832:ffa:784d%6]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 21:23:50 +0000
From: Paul Benoit <paul@os.amperecomputing.com>
To: util-linux@vger.kernel.org
Cc: Paul Benoit <paul@os.amperecomputing.com>
Subject: [PATCH v2 2/2] lscpu-arm: Correct Ampere part name strings.
Date: Wed, 11 Feb 2026 13:23:09 -0800
Message-ID: <20260211212309.126190-2-paul@os.amperecomputing.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <a758edc3-2d4f-4e5d-8951-8aad0c3a546a@os.amperecomputing.com>
References: <a758edc3-2d4f-4e5d-8951-8aad0c3a546a@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P221CA0057.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::12) To SA1PR01MB8179.prod.exchangelabs.com
 (2603:10b6:806:330::14)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR01MB8179:EE_|SA1PR01MB994237:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f3e1cd-ef6a-4fba-cf06-08de69b3d97d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DplKzu/LhRexAYlYD5OgQzDiA7O1FdUaKf3E4BOmUqyTPeKO5HGPy952MDHV?=
 =?us-ascii?Q?WShFDnQ5b9+Puu8fF8XQa9gvCjJLHIKcCIq8RPX4bMFtARkjmV0+FFS5furO?=
 =?us-ascii?Q?DQo7Si7ueVmRYlZmNy3rdpa8nvS/C6z5IA4ROL1cHvn/VrJ44WtDUOUGQzR6?=
 =?us-ascii?Q?DFejm9ylM2UMUf0vD85zZIdpKKVMCiqEeo0wewNOIpq38DBJhpFfH2BJoBNf?=
 =?us-ascii?Q?NsTrhe8C1eRro/SLvFGSZ+ul/OV4f8hHrCgY6w1QtenJNx6sB1FLB2hOFDB+?=
 =?us-ascii?Q?AVNYSl9c+pEvWQzV1ENNmXoONbuUSDcKBOzDfCeKV5LiHr/1BAkl4W8Smd8+?=
 =?us-ascii?Q?QQqBJpgwudkPouuijPEhKj1FnLkf4ZPT/Nhby3Fiz1sE9058Sy1HW5t65KFw?=
 =?us-ascii?Q?r4h1x3EE7SUZ9qztjjyxjMhdZ1qKz62wqaSKH51tryimPdGV8LDuhDlcCvOQ?=
 =?us-ascii?Q?2geuSdlbZaZcIN5ikAIJKIk1UREyeSz7DYS8zcOj0h9yikugiKeDf7CPAFyv?=
 =?us-ascii?Q?AJT585aULqSm6tOmXuA//pT+ynwMDa05SRLIhkeOl8Dqh6yiClXao5bfcc/w?=
 =?us-ascii?Q?xRqTrDWD3gqThuo7rG+XPb1Uuc9cLFOKWa0+Pn+FnKavVmjVyoy9Q7rLNe4/?=
 =?us-ascii?Q?VT6+uE+n3SF2JNt+/15CwwEhs4caWDVns6a34ltlnSdD9lQk6JqwcIni1doF?=
 =?us-ascii?Q?roOlh994ENQPfoMd/f0lH6xPNAzwhKsHH7I1Vt0Udesh84JAgbJy9j1/V76Y?=
 =?us-ascii?Q?WunbC1c11aEXf008UmO/O8VJr4epW4xfPRFHrR6+XGyiamEjjQnRqOSXw+e8?=
 =?us-ascii?Q?OoCkBF5AJifKrXgDVbY4Tw7CB6qGpLQj4RCiHgfOiW1QNQt7I81XLTGl65J6?=
 =?us-ascii?Q?fA3t0V1XGpsaJwRskE9hgSESLNv7wpXfcNU+PcUxcDYPbcB/Gs/awkWrTMov?=
 =?us-ascii?Q?GopPrizqNSrn8ggwv4abdZOvwYVdg8irmIi0gt59VGBfcB6QtvXYgbgklL2h?=
 =?us-ascii?Q?Q32TX3x2PNuKkD5XduXY247H3mWnAqLs7EYlUw+rsnuHd1Xe4vO0m7oEcvVg?=
 =?us-ascii?Q?WORBOzhAOPiTKweujxWzaPu9FrQ9P9RgdM4g0QBEnaGdTimTHf1lB07c2KvT?=
 =?us-ascii?Q?aXSB1iW/IvLjxAxwUHhPq+yN9HFASIYrfT+a7+YcMsK7jcGWo/Kn+O6iY+7s?=
 =?us-ascii?Q?+ZKehKKMyNLJZwQrkKmgf8+6vvYl9hxv8l81dGSmbcqI3bRKLL6vnoWfYk50?=
 =?us-ascii?Q?kLK2rCivF/rKmTZD6zezItEidGULmYOKTHcsy5te5GUabK9K3FLIv/Wd3g69?=
 =?us-ascii?Q?Yt+Rgq/mUMkbuKqdpXNrdXRRb2siMaLfmEe1q7DIJvkmWQTVaG0meknO3LEq?=
 =?us-ascii?Q?VtkMYSS9HxfGNUd20YO9PtCEPPANAJ/ZcogOcHEeytFntZIejkIMNhofobP6?=
 =?us-ascii?Q?UiwxCrQ5xPxpHj7oWD0/Tavcu7VhiiehorW1T3CdQdEvJp3WlnVFG/HXaFGr?=
 =?us-ascii?Q?KctokoMrqiaNEj9bbzw0maGyCcNQOB83zMyDdbT2vw7KG0y6LxWzt2bJ2wZi?=
 =?us-ascii?Q?/wqlmmuhJ2VgsGyRllqfvco2Jo7P2kqjV9NiqAgbV9pWrhAJ+bk62PTmQGmb?=
 =?us-ascii?Q?L/hjYuind0SbVVN7VId38hM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR01MB8179.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aN2LK+QD4XHRt1OyPXAtaBEa0LB53W98ymzcmX/Ff+d3khzxZ2hr5QdkWGKR?=
 =?us-ascii?Q?DrsQndFxk3qxre/pFYeRMizel1+9GGKoYDocfdEGPoRf7+vJeiHHvjg0dB1A?=
 =?us-ascii?Q?RlZPEgKuFND/WGNLdmUCVoazXtXzfAekzVSE8h1Vde8nrHiMpeZmCdJhqu49?=
 =?us-ascii?Q?NYwqsZHNgKglmk3qFBOAQ2mLxL1g155QtKgGjgAS4lv3Ma7kfXNsDLA5tYF/?=
 =?us-ascii?Q?FvNuoJKAG/ifBUUiQaSkuBoRYbxG5aBL0ZsKX3ZQYX7Dryc/7KCex2mmlHip?=
 =?us-ascii?Q?l635ZCalx4+FlqRWar2TtRFwaSKB/+ZNxQaFBcjF1cz/m5SUrwwXHU3VxS+y?=
 =?us-ascii?Q?0jZ9bsqkHmdklX5rsQbRA+w4MF6Fl/ERSg+Piw49ZRT6P19BKYCCymLvNzN7?=
 =?us-ascii?Q?dven7FOr6vzCJ2XqQy4aHjzZJDkwOMD6VLk4TKRD877j6dt9CNapMtazHdoa?=
 =?us-ascii?Q?s5t0xng5iqS04eNidaAYXdYE1LJTVTt6l3j0GVmNCnhYWK0DZYLod1czHqTo?=
 =?us-ascii?Q?6t0srTLJPW9UqRZwytTyXACNZrZWLB5I30xuDEzeGljP1YrAv+zwNxnIPsaD?=
 =?us-ascii?Q?3z4Ad0u/4vkiBpE6c/uyoG7fajoED+IDbhY9Uvtp0+BT856gUeN5o6fXF4un?=
 =?us-ascii?Q?mghiUSvg504puGjhEIeIQprMvhQImX2mtH3ii+zSMWVZoTqGRI4FwnzaXzGh?=
 =?us-ascii?Q?Cc0ycY+tn61yIDUsgj4NJRJFSDNvmdAqtQawLCNPv3vqoU09FA23OiLypBeh?=
 =?us-ascii?Q?PWl5FCrH5rNHrtyv8Yr5sG341SCVT2UmrY04SOhom4pSB8d0XBdjOIMKaT28?=
 =?us-ascii?Q?wHh+JbNbqRLotm32rKrsArsdWQP3k4enW1Vh6MZ2aL9ZkGLt+8BjL0KwwjW6?=
 =?us-ascii?Q?FsL0sYNhEjz1QsvBK7Y6Gfu0DWRMrGabtL9YJbzTj7tfj7sw3R42WYS3uhMx?=
 =?us-ascii?Q?pUL9vcCloIXB6INnHS8QMZVKkC/TE72Rv3sUHS079c7dx/9hLMl+1hIxigQt?=
 =?us-ascii?Q?AbhxU891hqEwt9PZlmg9HpPt18LoaKcE1uKxuObmomiGlAFSWc19VcziQTav?=
 =?us-ascii?Q?nJk5wd0Ru42zrxKJwLrW+gED8C0iOA0YVhF6haK2t9QoNRH/0h/ihzLORR2M?=
 =?us-ascii?Q?ylnrUFv9ZZgFBTNPUQKGKR4o8GAoBbiS0PGmpQya2uLWySW11zukv+N1tjM9?=
 =?us-ascii?Q?YrwyfJigF6aT9+dOMKMHdGMeT2xWel+GK+vi2Is9/Nu++Vxwh+kjI7791Gji?=
 =?us-ascii?Q?aDsHbIyghB6vHkSZAMqwSY1+Hg9vk1tVPZhIScpvbNXcb6t6XpdQEx32mbd/?=
 =?us-ascii?Q?vw/QNsdSkP/SOShd4Supa3rvTwPjtmoi9N5g6iFH2O1e6QtMCzQMcItU3o/a?=
 =?us-ascii?Q?DNAHcmihzLE0OEfchCZ/Uw7LLDsAhSKjHDJCXlmWobtjNTft3pSGpC/I68HB?=
 =?us-ascii?Q?2tDNAjxjOBs4Zm1hE+9XFP1MyNcKjMxz4UKN00M1g9XApYDcSJ7f7U4RheLQ?=
 =?us-ascii?Q?vdKsxEqg1Odp29Kqf1LTWczdV6dWVTPddFd5oe3c4sIuvjaBn2+nnp7YHXB1?=
 =?us-ascii?Q?DUDZR4Vl3mcddsDgCBY9E+jO5h6JUcqt7qq+Kki+s1Mdttnp0jLJQN3U4U6+?=
 =?us-ascii?Q?IZeekVDJi0w0vIMstHxPMyx9vh8MrSR/rBXxnt+ndTBOVcSrcfVrDDeuagAQ?=
 =?us-ascii?Q?n8L2CFA9L03zDreAUaRs4L+e/sEuB8Doam6DJDDa14LofCGPzNiDc2Wa5Z2a?=
 =?us-ascii?Q?8wwmkRZLxittu9VSqvhQEeGyZ9vXA8I=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f3e1cd-ef6a-4fba-cf06-08de69b3d97d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB8179.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 21:23:50.3160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FzwqpjPoIcxDR5C8aVBhn3E7IRBU8EwCCQPqalm7vKyEk2eqNeX80Z8ouR43cUqWzC+LNNG3mtpFYErfouPq6WiAU5j8gKbkMW9vHdMTXsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB994237

Change "Ampere-1" to "Ampere1", and "Ampere-1a" to "Ampere1a" in the
ampere_part table.

Signed-off-by: Paul Benoit <paul@os.amperecomputing.com>
---
 sys-utils/lscpu-arm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/lscpu-arm.c b/sys-utils/lscpu-arm.c
index f388080ad..0b0935402 100644
--- a/sys-utils/lscpu-arm.c
+++ b/sys-utils/lscpu-arm.c
@@ -276,8 +276,8 @@ static const struct id_part hisi_part[] = {
 };
 
 static const struct id_part ampere_part[] = {
-    { 0xac3, "Ampere-1" },
-    { 0xac4, "Ampere-1a" },
+    { 0xac3, "Ampere1" },
+    { 0xac4, "Ampere1a" },
     { -1, "unknown" },
 };
 
-- 
2.48.1

