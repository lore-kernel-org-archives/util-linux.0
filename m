Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013083.outbound.protection.outlook.com [52.103.43.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A91F219FC
	for <util-linux@vger.kernel.org>; Sun,  1 Feb 2026 14:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769957258; cv=fail; b=cWwLjTRqTfe8YhRlkgvroiU1iPYY1xyio9BUqTq7YsMEKZtO/dmi253H+damtkPbl6i107bMWMoEFVYKti3WfeUeDtHsKDZUsF/ZwltsG+FR7EjAT0087TrD+HBE82C4tDUKPKKRf4CZzyMzJgwzpZrznkqoJfrppzfrzQjHRAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769957258; c=relaxed/simple;
	bh=PlkVOU1Q5pn3UtEQUSnptbfuv369JI9988z2R0f+HmU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ckvP+aL+1B6NNZel1Yp0S5PKeYBEjIOtDO79Ram2qOdkYccUQq6iM/YnK9poHvwTTcWgV3DvdPeXqF9oC5ELJqBdjKUH3+WLiAbYol8zSOtRGJK9sE2xq3LDAL2QXjK4hepCCE9+T0KggwROMxR5R04hulDWXNtG4KTMCIQ0ZDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=WO52XGef; arc=fail smtp.client-ip=52.103.43.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="WO52XGef"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iw2ffvTkWLe+CUrDX1+RLcNeUts5/McQ4GenDK4Ho26YeizHdDapyP6/YKIrCFddixZ1qqbpoU3dCGtI17a5ciLWZR0qLw1o8qbsElCdo0i0AafgEEuXIJ/i2QPMlyUk3JgzP7m1IwEgkn3Jtb2AZmULs3mpT+Mx/3alvo3DhoEATSG3uaALT3OwLk+bYXGjgeTxW5QIb7/7hTUlImQp8f8uvxlLvavq3CR2n6HOvAdRQDY5MUBx8cLb31LrArnLJK3RL7xCndAiY4WQBN09RnL1Sh1ireoU2VCUGDv6Qp0SSBzxBwgyaiidM69eX/rdejKJh88E/rzMDv40KzCQNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXr+6ZfR/9SUdWJNRReg1sqwUHMe22SXA1A27SVo6JE=;
 b=qhLX50Sm1dxj1Q+YUIOsyOLo98W/dTx47huXhoTgNEFngwLjbI8JC39p64O7rZYlzdAtDCxLac9izW5lQetSO4+rbEgLvzEcglp6D7tceYECHnLfR3yvYL6YL0v11cBsDhkvFVsqX83WQ1+Pz9gcYZX9jDskCnFrVWy0KKljG9B1bLpS5Kz8q5zb5OjBwPATdqQ1ScIckD+qhUzANL/lruQDkJZ4UTh1PZ5gtPBJuQyhrh0p9DW3uROVizx0dWrq4ruY6BorVE8i56XbI5xafUU1SgxkBGwrzybALjQXkpzD2sJ/NdSchGOFp+571aFL0fmA8Y5wDFXgSHVmDxTbJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXr+6ZfR/9SUdWJNRReg1sqwUHMe22SXA1A27SVo6JE=;
 b=WO52XGefWY0QxjH/f/pfPTA5Iq2rvA2udpRNWuEf5K8IoAy1/DKxVmstfMSm6rdtwwjCPBSNbpWNyy3rjlPkD5F1BdMG3FmvrfB+Qs/IKpqdxCpKzJSRup52CDMksz1y9EWyAAjIRWPFqxIZbo7/W+2CYXuhYdHgbpTYU0MBgJrsAXdEgjADxgoSGmCYH9B/0Dh70HQ1LJdWbaEEmVgUrt2kfXbD8L8OWE1hanS0j2BAjagEH5HkvfQZTKUqVT94txUgxiVm4YyS3RLJRHl0vw6GDCdogBMwkWiG+cYRcxiCowGgcQF5bNjpAYUentClIIugTNeSIMORoZobyJZxMg==
Received: from SEZPR06MB7389.apcprd06.prod.outlook.com (2603:1096:101:24f::14)
 by TYSPR06MB6767.apcprd06.prod.outlook.com (2603:1096:400:471::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Sun, 1 Feb
 2026 14:47:33 +0000
Received: from SEZPR06MB7389.apcprd06.prod.outlook.com
 ([fe80::5bf3:ff51:546a:2b2b]) by SEZPR06MB7389.apcprd06.prod.outlook.com
 ([fe80::5bf3:ff51:546a:2b2b%4]) with mapi id 15.20.9564.006; Sun, 1 Feb 2026
 14:47:33 +0000
From: Yashashree Gund <yash_gund@live.com>
To: "kzak@redhat.com" <kzak@redhat.com>, "util-linux@vger.kernel.org"
	<util-linux@vger.kernel.org>
Subject: Security issue in util-linux: out-of-bounds read in ul_parse_size()
Thread-Topic: Security issue in util-linux: out-of-bounds read in
 ul_parse_size()
Thread-Index: AQHck4IKnUdj90n0dE2ygHTtaEY6KA==
Date: Sun, 1 Feb 2026 14:47:33 +0000
Message-ID:
 <SEZPR06MB738980A2799CFE3F45B32785E79DA@SEZPR06MB7389.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7389:EE_|TYSPR06MB6767:EE_
x-ms-office365-filtering-correlation-id: e7602753-0b33-4cd5-2701-08de61a0d546
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|31061999003|39105399006|8060799015|8062599012|15030799006|15080799012|6092099016|461199028|21061999006|40105399003|440099028|3412199025|102099032|26115399003|26104999006;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?6hB89sLrOrKieErevFNF7JyKH98jN2MwOakUvGt4s0xOx1F/5gMIRqY+XE?=
 =?iso-8859-1?Q?yTN3q7ugaZ2IKWbUjYp8gDZ4gL64EF/P5LflHmc9Al02O7isSJ7f69DQrI?=
 =?iso-8859-1?Q?v8bscQdbvqwhflkQW0LHtj+i6foJY32rub0Wj7IMOGPVJfGK+EIvn0iNp4?=
 =?iso-8859-1?Q?8J4Z+MAg9K1OaQseSfYMVrMRiNgh9qujxrc/dbenyKKCjUiCljO3jPOedK?=
 =?iso-8859-1?Q?juLq766LSNxMG0ffzhwqnK8uIEsYF27XMy3jhAZ7fzmAtobX2RkechQJfZ?=
 =?iso-8859-1?Q?yn9MIVwabFOTh6RzBteWNe5LAniKgYLGmyTptVbmbIQba/bc9Bn575DmfR?=
 =?iso-8859-1?Q?KTdFoC3qrmO9petGtf3jtbdzX3UpXXfl2wBivFVPwctntZAMLf8EJUn7qx?=
 =?iso-8859-1?Q?xHn8zyQagS4W8tPFEWemrxhITk/9nz7WXWOIrGqOpxRjPQ+QyZyUn4tB9d?=
 =?iso-8859-1?Q?5M9u6048vNEecn1hsCX4aYbRRtgSUEdSUhN+1gT2MdG6yINTCRLoN1aUrU?=
 =?iso-8859-1?Q?QUJqTRYwbmXw1Y2fEknkgCsZxMzg3Qe+uzfiYDfK02BLRqJ+nfo6p/jH/p?=
 =?iso-8859-1?Q?PL5GuoFSjJo1c4/BSE00pUGBLzKGechrGY+ilJlkZ0y59rpmtWkQYT6cVu?=
 =?iso-8859-1?Q?W01W05l4JlCXi7onQWATfLXydS3Ti20xb6W1H+A/cXbjjjwfIaqJN3IZf3?=
 =?iso-8859-1?Q?uDQF0CnAU3PH8HN/naZGmyyITaSpx26uOTmrwLUdtzYbn16Duue4X1P0Nu?=
 =?iso-8859-1?Q?3t68tOtPMM9fUKIUMsbv9NpGy3fhlaZPlGJwQr47tBrzuyFv+hnRvL1z8z?=
 =?iso-8859-1?Q?PzvMwNQg4dClHVr47Uq+Oj9MIq4F4J+jfM/ehESEQV3stRGg6emiCcUvAa?=
 =?iso-8859-1?Q?VV5G+DO3hLTihewmEeRLBVZHfZND4V9lVKMrCZDWP4UC2bo74I6kW1sufr?=
 =?iso-8859-1?Q?lSrrG0SgoxpD+Y7G12H5nq2dOex1K+7gbfknn5g6B/K0SC92DvJapays3S?=
 =?iso-8859-1?Q?wCUFrUx2ZWNYaAZxFbj8oPKp0mQrw1awiUNKcyBBVrPqKInfrNEPfAcbsN?=
 =?iso-8859-1?Q?fA391hwMGMOVBtpSdoUsKto3QVIT3GC5FyR0qb5txNpQqzM0g9PbkemHIr?=
 =?iso-8859-1?Q?2YSAp2QTVY/fSAFj+/GfDVei/LAnVwxmkpej4xN9CUuPEkvL+H1nh5UwdJ?=
 =?iso-8859-1?Q?qzWvjB0WrrVPEdfOKsb9jaEOTXSqRuFLCn/V+tpD1dshrsZxXg9qgxA7fy?=
 =?iso-8859-1?Q?Sywo09CxU4qzIJ4DciP/EirM1hAICLb2H+APsihWt0Y2v/DIZDk3nqWmos?=
 =?iso-8859-1?Q?WxurYA8ruSWe3SvD6Pj93BnOWnBohkSKFSusqsPylERarosnNeZVJ543mi?=
 =?iso-8859-1?Q?/7SEvtmmXbr2fMgi0KhljuuCOOk6KSBg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?eTMcbFW1/1VEiMSw7mX9HY3k96X3Gi0xIhzNC7wW4imRah3ZwH/OND2yIj?=
 =?iso-8859-1?Q?ji0/MmHm5tnZMZPIY/iYvhH/+O75Q8a0PGYYadTVv/8S+I2LgI4yyhNMOP?=
 =?iso-8859-1?Q?6u6DV/wlzaZakgZa9NbZYMXhNufj+/tyx1Ks+Pj41FjdRGVEaW311Xu9Ot?=
 =?iso-8859-1?Q?cmZKAFEJrBOyNPWoS6iB00JmjSO0PY1XixdYXpe44TxaPsWByQR5CYJ9ak?=
 =?iso-8859-1?Q?I4O6zkS48z25EnScv2ocB/vOK3C4HUFhD3fbtqEjiS38f5wZmGDpxl0LRQ?=
 =?iso-8859-1?Q?1W+DeZIxF4fjBnolCoKGt/ZnRyOKfIrJG3UeewlY2JlCbOwjM1gDgUZrrP?=
 =?iso-8859-1?Q?AWGF/J48SwsrC3vXBPIq2UlTPeKQ+l09IukmzWwiLc8kpIrUWwfrSNd203?=
 =?iso-8859-1?Q?V8RGmo+tRRpwGNHcXh4lH3QViLwDKCmdPSePnxjXbKtJEKePsd4beYjEuT?=
 =?iso-8859-1?Q?5tMBdkbi/4+ejO+JjCepfWQSk+tJ90y8vMethEZMqx5hV5lucrO7EH0np4?=
 =?iso-8859-1?Q?c2vtiE2x/bMch6Kk0JTFJorAIFl0lwFaVTkHgTy6Osp9USWHWsnncyjSM2?=
 =?iso-8859-1?Q?PI8gGQOBVXakHsSnC6uY/wFaoMxdEWcThsr+DMaolEFxxO+CWbPoDjE+eE?=
 =?iso-8859-1?Q?atEoL7QvSZnJT5XF6GQB7llo7OhZzR1WYYHa3v/AAO1Dzf2rOUuxiFUlNV?=
 =?iso-8859-1?Q?lrpVVcm8oZJrXzb4MkmTxjtE7kgPvXDxD8fZkxuY9nixwIEn7qWJNfL3ex?=
 =?iso-8859-1?Q?xOAWdUmo/UxvR0o2eY0Q2uPK/Hy5MeKzvG9J+mNjNAM8BfUZPRUN9pfXz4?=
 =?iso-8859-1?Q?5Q/i98pyMNJGCuV4WqHA/cgFE7MwzFxifiUcsNcOjNtCkvJYG1h10KQVj5?=
 =?iso-8859-1?Q?yWyQwTs+lU4hK6nZOY/b5ydEuzRqJSFS6BQp5vzkdKL6CDPIkOxXk1w+7B?=
 =?iso-8859-1?Q?Fq+9hXIdLSEEsPdup9QG2P5AKsHoTa2hKAt8kyyO2G6cQdrJjC6INDvUes?=
 =?iso-8859-1?Q?gkhEqmsQ6GfXUQEUiqGx45VWXuA7O7Ox6WU0FxC4ANpkh0a0jQNBlyO6hm?=
 =?iso-8859-1?Q?RLGAC4UH8WeNFTWKf2gVSgeXrFCSWE/JAYDZnc1bBucsV39JP3pWmTCqcp?=
 =?iso-8859-1?Q?Ybl4er4WIsrkfgO521mGSkMI4VCiCDcNJFH3xRtp4gAW1JpzQ7D+s2ZDA3?=
 =?iso-8859-1?Q?+Ln94aVgZwQO5uXA3Qjyd5z0L3iEPM7NZUqlxnTjW+13q7qgQ07ZBoH5HN?=
 =?iso-8859-1?Q?vqZ1QFfxw246VIA/rcLFivBJLlkJiVKW0coCRU0kbfJzLwSauklCTlOmcZ?=
 =?iso-8859-1?Q?lCcn1GL7XGCxPiDj8MQmJcJtOpxINrgXVmxUfgWk7rZ2jtB8wcLU+WL2kV?=
 =?iso-8859-1?Q?w1jnQ+yKD92Pcg/R4EvnA8jlK6WZRHUFuZ7d6oEeY5vHMKV5QBKro=3D?=
Content-Type: multipart/mixed;
	boundary="_006_SEZPR06MB738980A2799CFE3F45B32785E79DASEZPR06MB7389apcp_"
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-7141d.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7389.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e7602753-0b33-4cd5-2701-08de61a0d546
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2026 14:47:33.3596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6767

--_006_SEZPR06MB738980A2799CFE3F45B32785E79DASEZPR06MB7389apcp_
Content-Type: multipart/alternative;
	boundary="_000_SEZPR06MB738980A2799CFE3F45B32785E79DASEZPR06MB7389apcp_"

--_000_SEZPR06MB738980A2799CFE3F45B32785E79DASEZPR06MB7389apcp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello util-linux maintainers,

I would like to report a security issue in util-linux involving a memory sa=
fety flaw in ul_parse_size() that is reachable via libmount during mount op=
tion processing.
The issue is an out-of-bounds read caused by unchecked lookahead accesses w=
hen parsing malformed decimal size strings.

The crash is reliably triggered by inputs such as sizelimit=3D00000.000, wh=
ich cause ul_parse_size() to read past the end of the input buffer.
This occurs even when the input string is properly NUL-terminated. The prob=
lem was initially discovered via libFuzzer while fuzzing libmount and was l=
ater confirmed with a minimal standalone reproducer that directly calls ul_=
parse_size(), demonstrating that the issue is intrinsic to the function and=
 not dependent on higher-level parsing behavior.

Impact:

This bug can lead to process crashes and out-of-bounds memory reads in priv=
ileged contexts where util-linux or libmount parse attacker-influenced moun=
t options (e.g., mount helpers, containers, or namespace-aware tools). The =
issue is therefore security-relevant.

Attachments included:


  *   A minimized reproducer input that triggers the crash
  *   The full AddressSanitizer crash report
  *   Execution-path notes describing how the input reaches ul_parse_size()
  *   A minimal standalone reproducer (verify.c)

Standalone reproducer details:

The attached verify-repro.c is a small test program that directly invokes u=
l_parse_size() with a crafted decimal size string and checks the result.

When built with AddressSanitizer enabled and linked against the util-linux =
source tree, running the program reliably triggers an out-of-bounds read in=
 ul_parse_size(), confirming the issue independently of libmount or fuzzing=
 infrastructure.

Please let me know if you would like the reproducer adapted further or if a=
dditional information would be helpful. I am happy to assist with validatio=
n or testing of a fix.

Thank you for your time and for maintaining util-linux.

Best Regards
Yashashree Gund





--_000_SEZPR06MB738980A2799CFE3F45B32785E79DASEZPR06MB7389apcp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
Hello util-linux maintainers,</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"line-height: 120%; margin: 0cm; font-family: Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToPr=
oof" id=3D"geom_inter_1769956824577_70_2">
I would like to report a security issue in util-linux involving a memory sa=
fety flaw in ul_parse_size()&nbsp;that is reachable via libmount during mou=
nt option processing.</div>
<div style=3D"line-height: 120%; margin: 0cm; font-family: Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToPr=
oof" id=3D"geom_inter_1769956824577_88_3">
The issue is an out-of-bounds read caused by unchecked lookahead accesses w=
hen parsing malformed decimal size strings.&nbsp;</div>
<div style=3D"line-height: 120%; margin: 0cm; font-family: Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToPr=
oof">
<br>
</div>
<div style=3D"line-height: 120%; margin: 0cm; font-family: Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToPr=
oof" id=3D"geom_inter_1769956824577_43_4">
The crash is reliably triggered by inputs such as sizelimit=3D00000.000, wh=
ich cause ul_parse_size()&nbsp;to read past the end of the input buffer.&nb=
sp;</div>
<div style=3D"line-height: 120%; margin: 0cm; font-family: Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToPr=
oof" id=3D"geom_inter_1769956824577_97_6">
This occurs even when the input string is properly NUL-terminated. The prob=
lem was initially discovered via libFuzzer while fuzzing libmount and was l=
ater confirmed with a minimal standalone reproducer that directly calls ul_=
parse_size(), demonstrating that
 the issue is intrinsic to the function and not dependent on higher-level p=
arsing behavior.</div>
<div style=3D"line-height: 120%; margin: 0cm; font-family: Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToPr=
oof">
&nbsp;</div>
<div style=3D"line-height: 120%; margin: 0cm; font-family: Calibri, Helveti=
ca, sans-serif; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 14pt;"><b>Impact:</b><br>
</span><span style=3D"font-size: 12pt;"><br>
</span></div>
<div style=3D"line-height: 120%; margin: 0cm; font-family: Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToPr=
oof">
This bug can lead to process crashes and out-of-bounds memory reads in priv=
ileged contexts where util-linux or libmount parse attacker-influenced moun=
t options (e.g., mount helpers, containers, or namespace-aware tools). The =
issue is therefore security-relevant.</div>
<div style=3D"line-height: 120%; margin: 0cm; font-family: Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToPr=
oof">
<b><br>
</b></div>
<div style=3D"line-height: 120%; margin: 0cm; font-family: Calibri, Helveti=
ca, sans-serif; font-size: 14pt; color: rgb(0, 0, 0);" class=3D"elementToPr=
oof">
<b>Attachments included:</b></div>
<div style=3D"line-height: 120%; margin: 0cm; font-family: Calibri, Helveti=
ca, sans-serif; font-size: 14pt; color: rgb(0, 0, 0);" class=3D"elementToPr=
oof">
<b><br>
</b></div>
<ul style=3D"margin-top: 0cm; margin-right: 0cm;">
<li style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; =
color: rgb(0, 0, 0); line-height: normal; margin: 0cm 0cm 8pt;">
A minimized reproducer input that triggers the crash</li><li style=3D"font-=
family: Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0=
); line-height: normal; margin: 0cm 0cm 8pt;">
The full AddressSanitizer crash report</li><li style=3D"font-family: Calibr=
i, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); line-height=
: normal; margin: 0cm 0cm 8pt;">
Execution-path notes describing how the input reaches ul_parse_size()</li><=
li style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0); line-height: normal; margin: 0cm 0cm 8pt;">
A minimal standalone reproducer (verify.c)</li></ul>
<div style=3D"line-height: 120%; margin: 0cm; font-family: Calibri, Helveti=
ca, sans-serif; color: rgb(0, 0, 0);" class=3D"elementToProof">
<span style=3D"font-size: 14pt;"><b>Standalone reproducer details:</b></spa=
n><span style=3D"font-size: 12pt;"><br>
<br>
</span></div>
<div style=3D"line-height: 120%; margin: 0cm; font-family: Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToPr=
oof">
The attached verify-repro.c&nbsp;is a small test program that directly invo=
kes ul_parse_size()&nbsp;with a crafted decimal size string and checks the =
result.&nbsp;</div>
<div style=3D"line-height: 120%; margin: 0cm; font-family: Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToPr=
oof">
<br>
</div>
<div style=3D"line-height: 120%; margin: 0cm; font-family: Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToPr=
oof">
When built with AddressSanitizer enabled and linked against the util-linux =
source tree, running the program reliably triggers an out-of-bounds read in=
 ul_parse_size(), confirming the issue independently of libmount or fuzzing=
 infrastructure.</div>
<div style=3D"line-height: 120%; margin: 0cm; font-family: Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToPr=
oof">
<br>
</div>
<div style=3D"line-height: 120%; margin: 0cm; font-family: Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToPr=
oof">
Please let me know if you would like the reproducer adapted further or if a=
dditional information would be helpful. I am happy to assist with validatio=
n or testing of a fix.</div>
<div style=3D"line-height: 120%; margin: 0cm; font-family: Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToPr=
oof">
<br>
</div>
<div style=3D"line-height: 120%; margin: 0cm; font-family: Calibri, Helveti=
ca, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToPr=
oof">
Thank you for your time and for maintaining util-linux.</div>
<div style=3D"line-height: 1.38; margin: 0cm 0cm 8pt; font-family: Calibri,=
 Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"ele=
mentToProof">
&nbsp;</div>
<div style=3D"line-height: 1.38; margin: 0cm 0cm 8pt; font-family: Calibri,=
 Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"ele=
mentToProof">
Best Regards</div>
<div style=3D"line-height: 1.38; margin: 0cm 0cm 8pt; font-family: Calibri,=
 Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"ele=
mentToProof">
Yashashree Gund</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
<br>
</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
<br>
</div>
<div style=3D"margin-top: 1em; margin-bottom: 1em; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elemen=
tToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 12pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_SEZPR06MB738980A2799CFE3F45B32785E79DASEZPR06MB7389apcp_--

--_006_SEZPR06MB738980A2799CFE3F45B32785E79DASEZPR06MB7389apcp_
Content-Type: text/plain; name="ul_parse_size_asan_report.txt"
Content-Description: ul_parse_size_asan_report.txt
Content-Disposition: attachment; filename="ul_parse_size_asan_report.txt";
	size=8049; creation-date="Sun, 01 Feb 2026 14:40:03 GMT";
	modification-date="Sun, 01 Feb 2026 14:40:48 GMT"
Content-Transfer-Encoding: base64

PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0KPT0yOTA0NzI9PUVSUk9SOiBBZGRyZXNzU2FuaXRpemVyOiBoZWFwLWJ1ZmZlci1v
dmVyZmxvdyBvbiBhZGRyZXNzIDB4NTAyMDAwODkyNGZhIGF0IHBjIDB4YzI1ZDAwOTBmY2RjIGJw
IDB4ZmZmZmRjZmE5NjMwIHNwIDB4ZmZmZmRjZmE5NjI4ClJFQUQgb2Ygc2l6ZSAxIGF0IDB4NTAy
MDAwODkyNGZhIHRocmVhZCBUMAogICAgIzAgMHhjMjVkMDA5MGZjZDggaW4gdWxfcGFyc2Vfc2l6
ZSAvaG9tZS9wYXJhbGxlbHMvdXRpbC1saW51eC9saWIvc3RydXRpbHMuYzoxMTY6NgogICAgIzEg
MHhjMjVkMDA4ZDFiZDAgaW4gc2V0dXBfbG9vcGRldiAvaG9tZS9wYXJhbGxlbHMvdXRpbC1saW51
eC9saWJtb3VudC9zcmMvaG9va19sb29wZGV2LmM6MTcwOjcKICAgICMyIDB4YzI1ZDAwOGQxYmQw
IGluIGhvb2tfcHJlcGFyZV9sb29wZGV2IC9ob21lL3BhcmFsbGVscy91dGlsLWxpbnV4L2xpYm1v
dW50L3NyYy9ob29rX2xvb3BkZXYuYzo1NDE6NwogICAgIzMgMHhjMjVkMDA4YjE0NDAgaW4gbW50
X2NvbnRleHRfY2FsbF9ob29rcyAvaG9tZS9wYXJhbGxlbHMvdXRpbC1saW51eC9saWJtb3VudC9z
cmMvaG9va3MuYzozNjk6OQogICAgIzQgMHhjMjVkMDA4NzgzODQgaW4gbW50X2NvbnRleHRfcHJl
cGFyZV9zcmNwYXRoIC9ob21lL3BhcmFsbGVscy91dGlsLWxpbnV4L2xpYm1vdW50L3NyYy9jb250
ZXh0LmM6MjAwMjo3CiAgICAjNSAweGMyNWQwMDg4YWRmNCBpbiBtbnRfY29udGV4dF9wcmVwYXJl
X21vdW50IC9ob21lL3BhcmFsbGVscy91dGlsLWxpbnV4L2xpYm1vdW50L3NyYy9jb250ZXh0X21v
dW50LmM6NzkyOjgKICAgICM2IDB4YzI1ZDAwODJhYjQ0IGluIExMVk1GdXp6ZXJUZXN0T25lSW5w
dXQgL2hvbWUvcGFyYWxsZWxzL3V0aWwtbGludXgvbGlibW91bnRfZnV6emVyLmM6NDA6MjcKICAg
ICM3IDB4YzI1ZDAwNzM1YzBjIGluIGZ1enplcjo6RnV6emVyOjpFeGVjdXRlQ2FsbGJhY2sodW5z
aWduZWQgY2hhciBjb25zdCosIHVuc2lnbmVkIGxvbmcpICgvaG9tZS9wYXJhbGxlbHMvdXRpbC1s
aW51eC9saWJtb3VudF9mdXp6ZXJfZGVlcCsweDIyNWMwYykgKEJ1aWxkSWQ6IGNkMzY2ZDgyMTIw
MmNhOTg1MjhiZjc5Yjk5NDFlNDMxMTUzZTRjYzMpCiAgICAjOCAweGMyNWQwMDczNTM2NCBpbiBm
dXp6ZXI6OkZ1enplcjo6UnVuT25lKHVuc2lnbmVkIGNoYXIgY29uc3QqLCB1bnNpZ25lZCBsb25n
LCBib29sLCBmdXp6ZXI6OklucHV0SW5mbyosIGJvb2wsIGJvb2wqKSAoL2hvbWUvcGFyYWxsZWxz
L3V0aWwtbGludXgvbGlibW91bnRfZnV6emVyX2RlZXArMHgyMjUzNjQpIChCdWlsZElkOiBjZDM2
NmQ4MjEyMDJjYTk4NTI4YmY3OWI5OTQxZTQzMTE1M2U0Y2MzKQogICAgIzkgMHhjMjVkMDA3MzZi
MzAgaW4gZnV6emVyOjpGdXp6ZXI6Ok11dGF0ZUFuZFRlc3RPbmUoKSAoL2hvbWUvcGFyYWxsZWxz
L3V0aWwtbGludXgvbGlibW91bnRfZnV6emVyX2RlZXArMHgyMjZiMzApIChCdWlsZElkOiBjZDM2
NmQ4MjEyMDJjYTk4NTI4YmY3OWI5OTQxZTQzMTE1M2U0Y2MzKQogICAgIzEwIDB4YzI1ZDAwNzM3
ODk0IGluIGZ1enplcjo6RnV6emVyOjpMb29wKHN0ZDo6dmVjdG9yPGZ1enplcjo6U2l6ZWRGaWxl
LCBzdGQ6OmFsbG9jYXRvcjxmdXp6ZXI6OlNpemVkRmlsZT4+JikgKC9ob21lL3BhcmFsbGVscy91
dGlsLWxpbnV4L2xpYm1vdW50X2Z1enplcl9kZWVwKzB4MjI3ODk0KSAoQnVpbGRJZDogY2QzNjZk
ODIxMjAyY2E5ODUyOGJmNzliOTk0MWU0MzExNTNlNGNjMykKICAgICMxMSAweGMyNWQwMDcyNTcz
MCBpbiBmdXp6ZXI6OkZ1enplckRyaXZlcihpbnQqLCBjaGFyKioqLCBpbnQgKCopKHVuc2lnbmVk
IGNoYXIgY29uc3QqLCB1bnNpZ25lZCBsb25nKSkgKC9ob21lL3BhcmFsbGVscy91dGlsLWxpbnV4
L2xpYm1vdW50X2Z1enplcl9kZWVwKzB4MjE1NzMwKSAoQnVpbGRJZDogY2QzNjZkODIxMjAyY2E5
ODUyOGJmNzliOTk0MWU0MzExNTNlNGNjMykKICAgICMxMiAweGMyNWQwMDc0ZTU5NCBpbiBtYWlu
ICgvaG9tZS9wYXJhbGxlbHMvdXRpbC1saW51eC9saWJtb3VudF9mdXp6ZXJfZGVlcCsweDIzZTU5
NCkgKEJ1aWxkSWQ6IGNkMzY2ZDgyMTIwMmNhOTg1MjhiZjc5Yjk5NDFlNDMxMTUzZTRjYzMpCiAg
ICAjMTMgMHhlOGZjYTg4ODg0YzAgaW4gX19saWJjX3N0YXJ0X2NhbGxfbWFpbiBjc3UvLi4vc3lz
ZGVwcy9ucHRsL2xpYmNfc3RhcnRfY2FsbF9tYWluLmg6NTg6MTYKICAgICMxNCAweGU4ZmNhODg4
ODU5NCBpbiBfX2xpYmNfc3RhcnRfbWFpbiBjc3UvLi4vY3N1L2xpYmMtc3RhcnQuYzozNjA6Mwog
ICAgIzE1IDB4YzI1ZDAwNzFiYTZjIGluIF9zdGFydCAoL2hvbWUvcGFyYWxsZWxzL3V0aWwtbGlu
dXgvbGlibW91bnRfZnV6emVyX2RlZXArMHgyMGJhNmMpIChCdWlsZElkOiBjZDM2NmQ4MjEyMDJj
YTk4NTI4YmY3OWI5OTQxZTQzMTE1M2U0Y2MzKQoKMHg1MDIwMDA4OTI0ZmEgaXMgbG9jYXRlZCAw
IGJ5dGVzIGFmdGVyIDEwLWJ5dGUgcmVnaW9uIFsweDUwMjAwMDg5MjRmMCwweDUwMjAwMDg5MjRm
YSkKYWxsb2NhdGVkIGJ5IHRocmVhZCBUMCBoZXJlOgogICAgIzAgMHhjMjVkMDA3ZWQwZDQgaW4g
bWFsbG9jICgvaG9tZS9wYXJhbGxlbHMvdXRpbC1saW51eC9saWJtb3VudF9mdXp6ZXJfZGVlcCsw
eDJkZDBkNCkgKEJ1aWxkSWQ6IGNkMzY2ZDgyMTIwMmNhOTg1MjhiZjc5Yjk5NDFlNDMxMTUzZTRj
YzMpCiAgICAjMSAweGMyNWQwMDc2M2I5OCBpbiBzdHJuZHVwICgvaG9tZS9wYXJhbGxlbHMvdXRp
bC1saW51eC9saWJtb3VudF9mdXp6ZXJfZGVlcCsweDI1M2I5OCkgKEJ1aWxkSWQ6IGNkMzY2ZDgy
MTIwMmNhOTg1MjhiZjc5Yjk5NDFlNDMxMTUzZTRjYzMpCiAgICAjMiAweGMyNWQwMDk2ZTZiYyBp
biBvcHRsaXN0X25ld19vcHQgL2hvbWUvcGFyYWxsZWxzL3V0aWwtbGludXgvbGlibW91bnQvc3Jj
L29wdGxpc3QuYzo0Mzg6MTYKICAgICMzIDB4YzI1ZDAwOTYzNDI0IGluIG9wdGxpc3RfYWRkX29w
dHN0ciAvaG9tZS9wYXJhbGxlbHMvdXRpbC1saW51eC9saWJtb3VudC9zcmMvb3B0bGlzdC5jOjUy
NDo5CiAgICAjNCAweGMyNWQwMDg4MGY4NCBpbiBhcHBseV9mcyAvaG9tZS9wYXJhbGxlbHMvdXRp
bC1saW51eC9saWJtb3VudC9zcmMvY29udGV4dC5jOjI0NjA6OAogICAgIzUgMHhjMjVkMDA4ODJh
MjQgaW4gbW50X2NvbnRleHRfYXBwbHlfZnN0YWIgL2hvbWUvcGFyYWxsZWxzL3V0aWwtbGludXgv
bGlibW91bnQvc3JjL2NvbnRleHQuYzoyNjEwOjkKICAgICM2IDB4YzI1ZDAwODhhYTUwIGluIG1u
dF9jb250ZXh0X3ByZXBhcmVfbW91bnQgL2hvbWUvcGFyYWxsZWxzL3V0aWwtbGludXgvbGlibW91
bnQvc3JjL2NvbnRleHRfbW91bnQuYzo3ODI6NwogICAgIzcgMHhjMjVkMDA4MmFiNDQgaW4gTExW
TUZ1enplclRlc3RPbmVJbnB1dCAvaG9tZS9wYXJhbGxlbHMvdXRpbC1saW51eC9saWJtb3VudF9m
dXp6ZXIuYzo0MDoyNwogICAgIzggMHhjMjVkMDA3MzVjMGMgaW4gZnV6emVyOjpGdXp6ZXI6OkV4
ZWN1dGVDYWxsYmFjayh1bnNpZ25lZCBjaGFyIGNvbnN0KiwgdW5zaWduZWQgbG9uZykgKC9ob21l
L3BhcmFsbGVscy91dGlsLWxpbnV4L2xpYm1vdW50X2Z1enplcl9kZWVwKzB4MjI1YzBjKSAoQnVp
bGRJZDogY2QzNjZkODIxMjAyY2E5ODUyOGJmNzliOTk0MWU0MzExNTNlNGNjMykKICAgICM5IDB4
YzI1ZDAwNzM1MzY0IGluIGZ1enplcjo6RnV6emVyOjpSdW5PbmUodW5zaWduZWQgY2hhciBjb25z
dCosIHVuc2lnbmVkIGxvbmcsIGJvb2wsIGZ1enplcjo6SW5wdXRJbmZvKiwgYm9vbCwgYm9vbCop
ICgvaG9tZS9wYXJhbGxlbHMvdXRpbC1saW51eC9saWJtb3VudF9mdXp6ZXJfZGVlcCsweDIyNTM2
NCkgKEJ1aWxkSWQ6IGNkMzY2ZDgyMTIwMmNhOTg1MjhiZjc5Yjk5NDFlNDMxMTUzZTRjYzMpCiAg
ICAjMTAgMHhjMjVkMDA3MzZiMzAgaW4gZnV6emVyOjpGdXp6ZXI6Ok11dGF0ZUFuZFRlc3RPbmUo
KSAoL2hvbWUvcGFyYWxsZWxzL3V0aWwtbGludXgvbGlibW91bnRfZnV6emVyX2RlZXArMHgyMjZi
MzApIChCdWlsZElkOiBjZDM2NmQ4MjEyMDJjYTk4NTI4YmY3OWI5OTQxZTQzMTE1M2U0Y2MzKQog
ICAgIzExIDB4YzI1ZDAwNzM3ODk0IGluIGZ1enplcjo6RnV6emVyOjpMb29wKHN0ZDo6dmVjdG9y
PGZ1enplcjo6U2l6ZWRGaWxlLCBzdGQ6OmFsbG9jYXRvcjxmdXp6ZXI6OlNpemVkRmlsZT4+Jikg
KC9ob21lL3BhcmFsbGVscy91dGlsLWxpbnV4L2xpYm1vdW50X2Z1enplcl9kZWVwKzB4MjI3ODk0
KSAoQnVpbGRJZDogY2QzNjZkODIxMjAyY2E5ODUyOGJmNzliOTk0MWU0MzExNTNlNGNjMykKICAg
ICMxMiAweGMyNWQwMDcyNTczMCBpbiBmdXp6ZXI6OkZ1enplckRyaXZlcihpbnQqLCBjaGFyKioq
LCBpbnQgKCopKHVuc2lnbmVkIGNoYXIgY29uc3QqLCB1bnNpZ25lZCBsb25nKSkgKC9ob21lL3Bh
cmFsbGVscy91dGlsLWxpbnV4L2xpYm1vdW50X2Z1enplcl9kZWVwKzB4MjE1NzMwKSAoQnVpbGRJ
ZDogY2QzNjZkODIxMjAyY2E5ODUyOGJmNzliOTk0MWU0MzExNTNlNGNjMykKICAgICMxMyAweGMy
NWQwMDc0ZTU5NCBpbiBtYWluICgvaG9tZS9wYXJhbGxlbHMvdXRpbC1saW51eC9saWJtb3VudF9m
dXp6ZXJfZGVlcCsweDIzZTU5NCkgKEJ1aWxkSWQ6IGNkMzY2ZDgyMTIwMmNhOTg1MjhiZjc5Yjk5
NDFlNDMxMTUzZTRjYzMpCiAgICAjMTQgMHhlOGZjYTg4ODg0YzAgaW4gX19saWJjX3N0YXJ0X2Nh
bGxfbWFpbiBjc3UvLi4vc3lzZGVwcy9ucHRsL2xpYmNfc3RhcnRfY2FsbF9tYWluLmg6NTg6MTYK
ICAgICMxNSAweGU4ZmNhODg4ODU5NCBpbiBfX2xpYmNfc3RhcnRfbWFpbiBjc3UvLi4vY3N1L2xp
YmMtc3RhcnQuYzozNjA6MwogICAgIzE2IDB4YzI1ZDAwNzFiYTZjIGluIF9zdGFydCAoL2hvbWUv
cGFyYWxsZWxzL3V0aWwtbGludXgvbGlibW91bnRfZnV6emVyX2RlZXArMHgyMGJhNmMpIChCdWls
ZElkOiBjZDM2NmQ4MjEyMDJjYTk4NTI4YmY3OWI5OTQxZTQzMTE1M2U0Y2MzKQoKU1VNTUFSWTog
QWRkcmVzc1Nhbml0aXplcjogaGVhcC1idWZmZXItb3ZlcmZsb3cgL2hvbWUvcGFyYWxsZWxzL3V0
aWwtbGludXgvbGliL3N0cnV0aWxzLmM6MTE2OjYgaW4gdWxfcGFyc2Vfc2l6ZQpTaGFkb3cgYnl0
ZXMgYXJvdW5kIHRoZSBidWdneSBhZGRyZXNzOgogIDB4NTAyMDAwODkyMjAwOiBmYSBmYSBmYSBm
YSBmYSBmYSBmYSBmYSBmYSBmYSBmYSBmYSBmYSBmYSBmYSBmYQogIDB4NTAyMDAwODkyMjgwOiBm
YSBmYSBmYSBmYSBmYSBmYSBmYSBmYSBmYSBmYSBmYSBmYSBmYSBmYSBmYSBmYQogIDB4NTAyMDAw
ODkyMzAwOiBmYSBmYSBmYSBmYSBmYSBmYSBmYSBmYSBmYSBmYSBmYSBmYSBmYSBmYSBmYSBmYQog
IDB4NTAyMDAwODkyMzgwOiBmYSBmYSBmYSBmYSBmYSBmYSBmZCBmYSBmYSBmYSBmYSBmYSBmYSBm
YSBmYSBmYQogIDB4NTAyMDAwODkyNDAwOiBmYSBmYSBmYSBmYSBmYSBmYSBmZCBmYSBmYSBmYSBm
YSBmYSBmYSBmYSBmYSBmYQo9PjB4NTAyMDAwODkyNDgwOiBmYSBmYSBmYSBmYSBmYSBmYSBmZCBm
ZCBmYSBmYSBmYSBmYSBmYSBmYSAwMFswMl0KICAweDUwMjAwMDg5MjUwMDogZmEgZmEgZmEgZmEg
ZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEKICAweDUwMjAwMDg5MjU4MDogZmEg
ZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEKICAweDUwMjAwMDg5
MjYwMDogZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEKICAw
eDUwMjAwMDg5MjY4MDogZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEg
ZmEgZmEKICAweDUwMjAwMDg5MjcwMDogZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmQg
ZmQgZmEgZmEgZmEgZmEKU2hhZG93IGJ5dGUgbGVnZW5kIChvbmUgc2hhZG93IGJ5dGUgcmVwcmVz
ZW50cyA4IGFwcGxpY2F0aW9uIGJ5dGVzKToKICBBZGRyZXNzYWJsZTogICAgICAgICAgIDAwCiAg
UGFydGlhbGx5IGFkZHJlc3NhYmxlOiAwMSAwMiAwMyAwNCAwNSAwNiAwNyAKICBIZWFwIGxlZnQg
cmVkem9uZTogICAgICAgZmEKICBGcmVlZCBoZWFwIHJlZ2lvbjogICAgICAgZmQKICBTdGFjayBs
ZWZ0IHJlZHpvbmU6ICAgICAgZjEKICBTdGFjayBtaWQgcmVkem9uZTogICAgICAgZjIKICBTdGFj
ayByaWdodCByZWR6b25lOiAgICAgZjMKICBTdGFjayBhZnRlciByZXR1cm46ICAgICAgZjUKICBT
dGFjayB1c2UgYWZ0ZXIgc2NvcGU6ICAgZjgKICBHbG9iYWwgcmVkem9uZTogICAgICAgICAgZjkK
ICBHbG9iYWwgaW5pdCBvcmRlcjogICAgICAgZjYKICBQb2lzb25lZCBieSB1c2VyOiAgICAgICAg
ZjcKICBDb250YWluZXIgb3ZlcmZsb3c6ICAgICAgZmMKICBBcnJheSBjb29raWU6ICAgICAgICAg
ICAgYWMKICBJbnRyYSBvYmplY3QgcmVkem9uZTogICAgYmIKICBBU2FuIGludGVybmFsOiAgICAg
ICAgICAgZmUKICBMZWZ0IGFsbG9jYSByZWR6b25lOiAgICAgY2EKICBSaWdodCBhbGxvY2EgcmVk
em9uZTogICAgY2IKPT0yOTA0NzI9PUFCT1JUSU5HCk1TOiAxMCBNYW51YWxEaWN0LUN1c3RvbS1D
b3B5UGFydC1DdXN0b20tQ2hhbmdlQnl0ZS1DdXN0b20tU2h1ZmZsZUJ5dGVzLUN1c3RvbS1Dcm9z
c092ZXItQ3VzdG9tLSBERTogIml2ZXJzaW9uIi07IGJhc2UgdW5pdDogYWVkMDRiY2Y4ZjA0Yzli
NDIwYmQwNmU5YmQwMDU0MzQxZTlhZDkxZAoweDY5LDB4NzYsMHg2NSwweDcyLDB4NzMsMHg2OSww
eDZmLDB4NmUsMHgzMSwweDM3LDB4MzMsMHgyMCwweDMwLDB4MzUsMHg2NCwweDMwLDB4YSwweDM3
LDB4MjAsMHgzMiwweDM1LDB4MjAsMHg2ZSwweDMxLDB4MzcsMHgzMywweDIwLDB4MzAsMHgzNSww
eDY0LDB4MzAsMHhhLDB4MzcsMHgyMCwweDcyLDB4YmYsMHg2NywweDY1LDB4NzgsMHg2NSwweGE4
LDB4MjAsMHgyZCwweDIwLDB4NmUsMHg2NiwweDczLDB4MzgsMHgyMCwweGEsMHgzMCwweDM1LDB4
MzAsMHg3MiwweDJlLDB4MmUsMHgyZiwweDJlLDB4MmYsMHg2ZCwweDI4LDB4MzEsMHhlNCwweDIw
LDB4MmYsMHgyMCwweGIyLDB4NmQsMHg3MCwweDY2LDB4NzMsMHgyMCwweGYyLDB4MmMsMHg3Miww
eDc3LDB4M2QsMHgyMiwweDIyLDB4MmMsMHg3NSwweDIyLDB4MjIsMHgyYywweDJjLDB4NzIsMHg3
NywweDNkLDB4MjIsMHgyMiwweDJjLDB4NzUsMHg3MywweDY1LDB4NzIsMHgyYywweDZlLDB4NmYs
MHg2MSwweDc1LDB4NzQsMHg2ZiwweDJjLDB4NTgsMHg3NSwweDZkLDB4NjEsMHg2YiwweDY1LDB4
MmQsMHg3MywweDY4LDB4NjEsMHg3MiwweDY1LDB4NjQsMHgyMiwweDIyLDB4MmMsMHg3MywweDY5
LDB4N2EsMHg2NSwweDZjLDB4NjksMHg2ZCwweDY5LDB4NzQsMHgzZCwweDMwLDB4MzAsMHgzMCww
eDMwLDB4MzAsMHgyZSwweDMwLDB4MzAsMHgzMCwweGEsMHgzMCwweDMwLDB4MzAsMHgzMCwweDMw
LDB4MzAsMHgzMCwweDMwLDB4MzEsMHgzMCwweDMzLDB4MzAsMHgzNiwweDMyLDB4MzIsMHgzNiww
eDMxLDB4MzYsMHgyYywweDY4LDB4NjUsMHg2YywweDcwLDB4MmMsMHg2NCwweDY5LDB4MzIsCml2
ZXJzaW9uMTczIDA1ZDBcMDEyNyAyNSBuMTczIDA1ZDBcMDEyNyByXDI3N2dleGVcMjUwIC0gbmZz
OCBcMDEyMDUwci4uLy4vbSgxXDM0NCAvIFwyNjJtcGZzIFwzNjIscnc9XCJcIix1XCJcIiwscnc9
XCJcIix1c2VyLG5vYXV0byxYdW1ha2Utc2hhcmVkXCJcIixzaXplbGltaXQ9MDAwMDAuMDAwXDAx
MjAwMDAwMDAwMTAzMDYyMjYxNixoZWxwLGRpMgphcnRpZmFjdF9wcmVmaXg9Jy4vJzsgVGVzdCB1
bml0IHdyaXR0ZW4gdG8gLi9jcmFzaC1lZWNkZjNiNjBlOWU3Mjc5NWIzY2VhNjJiNjNkNTlhNjFi
NzcwYzQyCkJhc2U2NDogYVhabGNuTnBiMjR4TnpNZ01EVmtNQW8zSURJMUlHNHhOek1nTURWa01B
bzNJSEsvWjJWNFphZ2dMU0J1Wm5NNElBb3dOVEJ5TGk0dkxpOXRLREhrSUM4Z3NtMXdabk1nOGl4
eWR6MGlJaXgxSWlJc0xISjNQU0lpTEhWelpYSXNibTloZFhSdkxGaDFiV0ZyWlMxemFHRnlaV1Fp
SWl4emFYcGxiR2x0YVhROU1EQXdNREF1TURBd0NqQXdNREF3TURBd01UQXpNRFl5TWpZeE5peG9a
V3h3TEdScE1nPT0K

--_006_SEZPR06MB738980A2799CFE3F45B32785E79DASEZPR06MB7389apcp_
Content-Type: text/plain; name="verify-repro.c"
Content-Description: verify-repro.c
Content-Disposition: attachment; filename="verify-repro.c"; size=293;
	creation-date="Sun, 01 Feb 2026 14:40:08 GMT";
	modification-date="Sun, 01 Feb 2026 14:40:48 GMT"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRpbnQuaD4KI2luY2x1ZGUgPGVycm5vLmg+
CiNpbmNsdWRlICJzdHJ1dGlscy5oIgoKaW50IG1haW4odm9pZCkKewogICAgdWludG1heF90IHJl
czsKICAgIGNvbnN0IGNoYXIgKnMgPSAiMDAwMDAuMDAwIjsKCiAgICBpbnQgcmMgPSB1bF9wYXJz
ZV9zaXplKHMsICZyZXMsIE5VTEwpOwoKICAgIHByaW50ZigiaW5wdXQ9JyVzJyByYz0lZCBlcnJu
bz0lZCByZXM9JWp1XG4iLAogICAgICAgICAgIHMsIHJjLCBlcnJubywgcmVzKTsKCiAgICByZXR1
cm4gMDsKfQo=

--_006_SEZPR06MB738980A2799CFE3F45B32785E79DASEZPR06MB7389apcp_
Content-Type: text/plain; name="ul_parse_size_execution_path.txt"
Content-Description: ul_parse_size_execution_path.txt
Content-Disposition: attachment; filename="ul_parse_size_execution_path.txt";
	size=1342; creation-date="Sun, 01 Feb 2026 14:43:27 GMT";
	modification-date="Sun, 01 Feb 2026 14:45:48 GMT"
Content-Transfer-Encoding: base64

RXhlY3V0aW9uIHBhdGggbm90ZXMg4oCTIHVsX3BhcnNlX3NpemUgaGVhcCBPT0IgcmVhZAoKT3Zl
cnZpZXcKClRoZSBhdHRhY2hlZCByZXByb2R1Y2VyIGlucHV0IHRyaWdnZXJzIGEgaGVhcCBvdXQt
b2YtYm91bmRzIHJlYWQgaW4KdWxfcGFyc2Vfc2l6ZSgpIGR1cmluZyBtb3VudCBvcHRpb24gcGFy
c2luZyBpbiBsaWJtb3VudC4KCkhpZ2gtbGV2ZWwgZmxvdwoKVGhlIHJlcHJvZHVjZXIgaW5wdXQg
aXMgY29uc3VtZWQgYnkgbGlibW91bnQgYXMgcGFydCBvZiBtb3VudCBvcHRpb24KcHJvY2Vzc2lu
ZyAoZS5nLiB2aWEgb3B0aW9ucyBzdWNoIGFzIHNpemVsaW1pdD0pLgoKbGlibW91bnQgcGFyc2Vz
IG1vdW50IG9wdGlvbnMgaW50byBhbiBvcHRpb24gbGlzdC4KClNpemUtcmVsYXRlZCBvcHRpb25z
IGFyZSBwYXNzZWQgdG8gdWxfcGFyc2Vfc2l6ZSgpIGZvciBudW1lcmljIHBhcnNpbmcuCgpDYWxs
IHBhdGggKHRyaW1tZWQpCgptbnRfY29udGV4dF9wcmVwYXJlX21vdW50KCkKIOKUlOKUgCBtbnRf
Y29udGV4dF9hcHBseV9mc3RhYigpCiAgICDilJTilIAgYXBwbHlfZnMoKQogICAgICAg4pSU4pSA
IG9wdGxpc3RfYWRkX29wdHN0cigpCiAgICAgICAgICDilJTilIAgb3B0bGlzdF9uZXdfb3B0KCkK
ICAgICAgICAgICAgIOKUlOKUgCB1bF9wYXJzZV9zaXplKCkKCgpGYXVsdCBkZXRhaWxzCgpJbnB1
dCB2YWx1ZSBleGFtcGxlOiBzaXplbGltaXQ9MDAwMDAuMDAwCgpJbnNpZGUgdWxfcGFyc2Vfc2l6
ZSgpOgoKc3RydG91bWF4KCkgcGFyc2VzIHRoZSBpbnRlZ2VyIHBhcnQgYW5kIHNldHMgZW5kIHRv
IHRoZSBkZWNpbWFsIHBvaW50LgoKRGVjaW1hbCBwYXJzaW5nIGFkdmFuY2VzIHRoZSBwb2ludGVy
IHAgdG8gdGhlIGxhc3QgZnJhY3Rpb25hbCBkaWdpdC4KClRoZSBzdWZmaXgtY2hlY2tpbmcgbG9n
aWMgdGhlbiB1bmNvbmRpdGlvbmFsbHkgZGVyZWZlcmVuY2VzIHAgKyAxCihhbmQgcG90ZW50aWFs
bHkgZnVydGhlciBvZmZzZXRzKS4KCldoZW4gcCBwb2ludHMgdG8gdGhlIGZpbmFsIGJ5dGUgb2Yg
YSBoZWFwLWFsbG9jYXRlZCBzdHJpbmcgKGFsbG9jYXRlZCB2aWEKc3RybmR1cCgpKSwgZGVyZWZl
cmVuY2luZyBwICsgMSByZXN1bHRzIGluIGEgaGVhcCBvdXQtb2YtYm91bmRzIHJlYWQuCgpSZXN1
bHQKCkFkZHJlc3NTYW5pdGl6ZXIgcmVwb3J0cyBhIHJlcHJvZHVjaWJsZSBoZWFwIGJ1ZmZlciBv
dmVyZmxvdyAocmVhZCBvZiBzaXplIDEpCmluIHVsX3BhcnNlX3NpemUoKS4gVGhlIGlzc3VlIGlz
IGlucHV0LWRyaXZlbiBhbmQgZG9lcyBub3QgZGVwZW5kIG9uCnVuaW5pdGlhbGl6ZWQgbWVtb3J5
IG9yIHVzZS1hZnRlci1mcmVlIGNvbmRpdGlvbnMuCg==

--_006_SEZPR06MB738980A2799CFE3F45B32785E79DASEZPR06MB7389apcp_--
