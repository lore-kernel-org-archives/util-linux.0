Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA041754B
	for <util-linux@vger.kernel.org>; Tue,  4 Mar 2025 01:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741052416; cv=fail; b=cTy0+5QWU2UMqTZxjpo7Z8jBx8oMfXTeihd5RH1jYpORMuvFDr66cWwhOs2rK1EYlls1VGQXOKEsJ0AE/blIEgSkeo+rh5/Vm9aUiDtO366ARqb2BpqXSc1aPLh9+phvWDxlfWyZlR6wjgI1B/iRfGMZBBBsBN8/fcqpdBH9/dE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741052416; c=relaxed/simple;
	bh=WJB86LDdENCtSEw4qq1OJNEmdH0+IhKLSJV4WOOfE3g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pOwCZM8I8Cq6A+JtYfxjRLl0vh2fcDMOznu/atnesgP2w4jCovp+rc1EokCP6GHlx02mvHRhKDMScZFa2t1xpG98jWiRRFb8IEMNTI9uSh/Bjdi7QDsriOBdiYUqPX7IKqXT65gnpx9XngtyOemJahlRpGxxonGh2KVv5NtAOK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L/Qz4rZP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EzY+IPDK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L/Qz4rZP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EzY+IPDK"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5241MmmM013458;
	Tue, 4 Mar 2025 01:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=WJB86LDdENCtSEw4qq1OJNEmdH0+IhKLSJV4WOOfE3g=; b=
	L/Qz4rZP0yunB7Yy+nSbeBA4V5fvsrBiRVQf8WgnBeWoPtkEIgq6UiePAA3TeBD6
	fSk8Rkag66HXCPzyTTWyDNl5H1AZI4+NlKk6e0H8tFZCi0meU1T+5dElFHt3Zm1x
	mZ5Scxa8MSR7/1bf05N8+2tWwWdePbqbLVnTF1KvfBqgcqjVzEu1XfxtzPKvrKhL
	O8BpfXmqwJNBTYaZ3vIulJJYHKrf7ODWpYl8FCRYyKNmDBZTHk03bvoeyNEUffDY
	NUjo6cDsVUs5yapQIErey6cWbKJ7yplJRiPj847zOuQgLvxVRL+7/oMQZnVrfxC6
	qaOkKyHfKcEpmVcLIKhbNQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453ub740mr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 01:39:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523NHDqt021934;
	Tue, 4 Mar 2025 01:39:56 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rwu8k4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 01:39:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfj7mX8siVEk8KEBpTjy0/TuXWqXmXxnmWAxgTeV6jAtjEpWOZp1eoV8ef01ZAFgj66vTVL3g9xAqBonws3s3uMMGWXNoNznRKdRLzdahot/jZlMU+rHfcp5K3BrWfmp1lpKciYYHny76XJHOG+VYDm5tPk4QRgBMmxOBgbtAVnnaAUx3Sh7/gzMXe10mJGh3iI9BkVlcrfom0ciZ3aWip8YZWZJrzky+7ROr99ZbIApG4YhfjQF+O0Yk+x0zVAx59UBcjRqzcoMQUoE1xZK/mhhOlTEc8GuhMK/Q5WjiCnWlslT3oJPxLvG9i7sYaLWciJK6aa7LnC5h1QFdlgEIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJB86LDdENCtSEw4qq1OJNEmdH0+IhKLSJV4WOOfE3g=;
 b=VTPxH2lYvb9g+YW0JbRvepfGs4csM18hDGgzjneCVZSQFrYY+JNVh4xjBqNi2vNc7tJD/P98K2QHyQnTRy8EVH901hmu8dqdxa5p4uYpn+HyQrzcUu+zXM5l4MMpoG5mjNKWUMF1BOvOPXhqGqdzs8cnQulaNRIBjLFcgwNFP5B+mFlqu4YUUjQoptphm09Wn7C8O4LvTFaeSayDhC7GG5KZ13fTlvfqD5y4Q5CGA+6DUP+G5JNXZJf3TfFKZYMpJsSK/TVeMXuaoYirg8qIZTV8U3mnb2FxnmYex3w7PgVgiAt504iMpTmbC2K2he2y+3zLexqpVTkLcNWGRm+JnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJB86LDdENCtSEw4qq1OJNEmdH0+IhKLSJV4WOOfE3g=;
 b=EzY+IPDKNmU7qfIoowVfLozHII66c+kmQgwAkC4AKyJu4ls0kD4yQBd67Pant4y8tx7n84SD039pcdioMS4eJ1ekskpYu5Q7UHv5PI96WNz8ZIsnavDXSPahvb+obohTaJaJYgTTQ9Ho7/feXvR+dQu8TRBoFc/pnWtuCXpz9vE=
Received: from DS7PR10MB4944.namprd10.prod.outlook.com (2603:10b6:5:38d::15)
 by DS7PR10MB7226.namprd10.prod.outlook.com (2603:10b6:8:ed::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.28; Tue, 4 Mar 2025 01:39:53 +0000
Received: from DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5]) by DS7PR10MB4944.namprd10.prod.outlook.com
 ([fe80::5088:d2e8:c30b:43e5%3]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 01:39:53 +0000
Message-ID: <5c7df987-2c12-4716-ad7a-f553e6c01a1f@oracle.com>
Date: Mon, 3 Mar 2025 17:39:50 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/4] irqtop: add max iteration support
To: zhenwei pi <pizhenwei@bytedance.com>, Karel Zak <kzak@redhat.com>,
        Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
References: <20250228161334.82987-1-joe.jin@oracle.com>
 <20250228161334.82987-3-joe.jin@oracle.com>
 <db814aa0-e91b-4a37-81fb-4c849c4a6c0d@bytedance.com>
Content-Language: en-US
From: Joe Jin <joe.jin@oracle.com>
In-Reply-To: <db814aa0-e91b-4a37-81fb-4c849c4a6c0d@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9P222CA0017.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::22) To DS7PR10MB4944.namprd10.prod.outlook.com
 (2603:10b6:5:38d::15)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4944:EE_|DS7PR10MB7226:EE_
X-MS-Office365-Filtering-Correlation-Id: 504ff4fe-c623-4397-9aea-08dd5abd7631
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azNOZWhJZFpDVlhQeDM2UmkzVzAzcjZaRW9WcE95a3poQzB1NU82R21zbkdy?=
 =?utf-8?B?QTJyMWR0OTlkZjRRV0l3L21RaWFmcS9yZFVlTHhsNXpIN1FraDA2TDhPZmJY?=
 =?utf-8?B?YnhyVmFnZzdtZG9FUlRPTmlCWVI5VG16c0ZPS1NwckxCTmcvT0ltMEwzUHZw?=
 =?utf-8?B?YVNpRzZpYUQyMkRQdWlDTnpFMER5UmxCOTBRZGw0RXB2WitDeVh2MWtidVJt?=
 =?utf-8?B?UXEwc3grTWUxYlBxUis2N0I3ZlVQdm5OZVZRK3BKYWplTnJOM1YxRVBqdS8w?=
 =?utf-8?B?Sm05WjFjT3N4QXJtb0xmMlFDNkszdUFaZXV5OUo2WXR0SlE1VjYvdHN0RFdh?=
 =?utf-8?B?SHZua2NSZUlYem9QVEU3SGNYd1h3b0xaL0k0a21WZGhuZjVBUnVMTjNBYlBG?=
 =?utf-8?B?M3g3NHdocWRESmk5S3hPRWhkUnlXL01KUzBQemVjUmYzNnZ5d1grb2FyVzNi?=
 =?utf-8?B?ZHh1c0lGRGw4RTcwUGdqUkR4UVdYSDJMTWluVGdjKzZyYUh6b3JIV0s2cGdY?=
 =?utf-8?B?cTVBTUFLOUFoTGg4YzNTOGtNdkE5cUFsaE0ya1hJblpGMExuenJTeGNEY1A0?=
 =?utf-8?B?ZjZFdUxDcWU4TlJ0bjdvLys0YWQ3MjFsYUNyaG4rVElZWnNPU1pnTlZMekYr?=
 =?utf-8?B?RlE5alpCNnhnVmwyK1k5RUk1MnBmNjY0ellyWXFWSmQvOFJWalVNQXJPWVpp?=
 =?utf-8?B?TFhsVnc3QUh4Zy9LSFBCS3FBR1NybXM3WTdIYk1xMHF1VDhPeVNFVFVScWxo?=
 =?utf-8?B?UDgyNzFuakhMdHRRV1dyakUvdGlRT0RubnBnSmxYMTNFZEJZMDQrRjhYVzBU?=
 =?utf-8?B?NEVtd05QNVhXL0ZDTzFVUXowQTVPNi9aOUhRc2tvVTBPNDE3S1lpcFpCZE9l?=
 =?utf-8?B?MEdWTXF5bUJXbW9ENHd2dVRxeG1TRW5UYVhWTVI1U3NCUFRMMlZabmhmQWFZ?=
 =?utf-8?B?UEJxOFpaUjNBSElVWjU3NkJaUlMxU25TbG5LQk5MblJIR3pObnRJcFZWdExH?=
 =?utf-8?B?c0RUK3MvZ1NPa2Q3Zi9hS3NDOFRYenpvNklVbkRUbW92OU1RM0JHZFZZdE9V?=
 =?utf-8?B?Tmd4ekQwSlNKcWswS3ZTcmlqc2ZHaFBCbVZpTURyUXBsL09BM0pvaTQzNWlr?=
 =?utf-8?B?N1M2K0lTbDlhZjZwVjlONVY4T2ZpTU5UWXZEWVhuVVMrNnJJV2JIWU15VWN4?=
 =?utf-8?B?Wk51ZlNhbVV1cU9jMlU4a2tDcUFVaTNQRVgvVXc4ZVZJZDNTeGtQS1ZtMEtV?=
 =?utf-8?B?bE1lZENYOFFrdkVKTmZlUVUvaUgvUnhOWUFkS25wYVNkbDliR2pwUWlrZjJI?=
 =?utf-8?B?NTZKTWMwVE1DWTN5NHRGUGxMb01hQ2NSTlg1VHBnbURNMi9xdXMraXFSTGtw?=
 =?utf-8?B?UUhzK1lxeXVrTEpxMit0L2JLUmFZS2VibXNja2QraTRGS2xCZGlhcEU3alZo?=
 =?utf-8?B?dFpzd1d2Tzc5WEI1N0lBbDZ6cnBpT0I3NFJLRmJMRTByVzdSSHVoaHdBSUJl?=
 =?utf-8?B?SDM3blZpbXYrLzZsdVJLUVF3SGZIZ2xwRStLemprR3NPUE5QakhIMGQyTkNs?=
 =?utf-8?B?UGt3QjhxaE8wVFp5cVJkMlFPemMyV0txNE1Ub0lOVXZwZWFWcmhQUS9JVFB4?=
 =?utf-8?B?a1pWdkU0aFBCY0J1VW15aVhMMmdBY29DdDcvc0NGdFhOZGJ3bXJzcUpPSWdv?=
 =?utf-8?B?Y1plTUFyYWpua2gyUTM0Wm5kdFBQMUNKbWFsQ3lSMGd2My81UzlvWnlLbUFC?=
 =?utf-8?B?ZHV5dEh1QjJpWlVNUVJXZTd5NzNZQW5FRjJSc0dBNlJad2lZelBkNjFXazU5?=
 =?utf-8?B?QkMxUmpNTkh4VjBFUURITUxHdlF0ZTVPQUZ3QkNBY3BURHFSeWFEb2RZSnRS?=
 =?utf-8?Q?lXUfPy/CpytTU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4944.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0x0bzRMUjJSZTY5ZytwY3EyN1dnbjIxdmZTcEFKeklocXJzZ3FqWkV0K0Ji?=
 =?utf-8?B?ZUJLb2dWQ0prREMvSEcwRjJURVY1aU96RFkrcUlvK0Rsc092RUE0bm5NU2RG?=
 =?utf-8?B?U241M1Q3YUdRZjBJejVpTTl6bzZsZThnbC9JcXdzeU8rQUpoRkNkTmttWGpQ?=
 =?utf-8?B?TVVTUG1JbXJZTkE0Nm5yV3NWWklKUTNvYi9EZUhJUFpsei9QQ0FMT1JHaTcz?=
 =?utf-8?B?Q3dJYjkxTTllWWZHK2w4QnBSTVRMT0JKUEZNU016VGcxN2NTWnJxUlkxZUo2?=
 =?utf-8?B?UkI4SEtrKzIrQlFhVW1IZXZ3NmtnQnhvaVEvODFNWXZyV3JzZFQ4OGgzV0lp?=
 =?utf-8?B?a2xtZytBVDZURTkyWHNxRncweVRrNmZ4R2g4TFlmUnZ3OVAvU1IyTnpGQmta?=
 =?utf-8?B?RXUzL0hUamV4emdHR3dLYi9keks1Y25iRlpWSXdYZHo3dVMyb0owMjk5T3dH?=
 =?utf-8?B?OVZVZU5MRjJpMGRabEQ5VjJwK0w2R05VRjRkM3cvNGFKbHJtSk9JZyt0STVH?=
 =?utf-8?B?eDRRSHlrZDdYdURzM3o3eGVkdlJzUGlwcEVOZXBEMWxJSmR3SWFDV2VMcUlU?=
 =?utf-8?B?bG96MEw5N05TbzdPWkZuaHAzVlpqQXNOT1RlUHNmdmR2NGt4NHo5Vy9YaVBE?=
 =?utf-8?B?eHpFM21LVUh6UitFMjhoeGRuaEc0cnBtY1FHejNMVkQ3QkM5Z0ovQlNlbVJY?=
 =?utf-8?B?QkhRWmdBWjEzREl5K0F4UUwzc2ZFV3p3Q1pRN2x6SGx3KzdXQy9nOFJuWXNI?=
 =?utf-8?B?UWZVRGNFVlBpa2VKQ1pDcGNsTVpqRFV2WmcrU3QrV2RuMHh6MmZpdEROajFr?=
 =?utf-8?B?aXlzdlk5NGs3OG9ZYTkwUTk2Z3haKy9OZnQ2YU9TSUl5WlBTU21weWViRVB5?=
 =?utf-8?B?SDNsdDB0VVBkTmJzZThhS0NTQ0J4VDN0NnMraWdybDJGMXVZMThtMU04cVpv?=
 =?utf-8?B?QUhiaVZsS0ZFamFTY2gzdm5yMWtmUjJZcXh5YWIvM1E1QVYrSjdPc25vS2lE?=
 =?utf-8?B?OWdGSGpTcXpzM2ovN1B6Rlg3NE9Ra3RDMUkxSXRWUzRnVzFQc21sTCtCZHc2?=
 =?utf-8?B?ZHlSc1JuRVovdk1OYnZXdnFWMlc2RWRUNXRCZGdqRUR2SW9MOCtqbitNZ0M1?=
 =?utf-8?B?bHZrQ3M4TnRsSGdHUTFlVWNkSm03UEFFbFU1ZnpqaHhBeTd1SDJqbjBXdVpU?=
 =?utf-8?B?bzhibnRmRkUwUXpqaWFwdlpjUmF3SDNHZjJBN0N0dWJBM1BzZnlKZTJ2YWlh?=
 =?utf-8?B?UDZsdXA0RjlQZEFMaWlLZms3OHhLNWMvYzRNTVVVblphYTBYdXE3THV4MXJM?=
 =?utf-8?B?Q2hzTm0zaW9EcHVZdXZlL1V5QUVyckdjYUoyVHRvVmtOaTdvV1dWVHV6M2NQ?=
 =?utf-8?B?bnRSTEFoZ3AwdjVqbTFzZk16L3piRVFhcVpRNWVobi94enpkSVRFTWYyaVc1?=
 =?utf-8?B?aTI0clJEZmN2WWNwVmNkbjg3d0d1QllqNHZiU0ZERFZlQzhnWUE0WFhKb254?=
 =?utf-8?B?ZkkvZkVZbFhPV3k2MGZCWXZpNGhXU2NqRXdnRXg1TWxHb2EwQVlWMTdNWSt6?=
 =?utf-8?B?YXkyTHlOejcrR20veTNVZGJiSk5FanRPT0wwWUVPVmFwWTVpNGNGS2NJMlVk?=
 =?utf-8?B?QUliQW1oS2FaMEJhclBMOHNwVVd5MzFLUld0Y2NwMlNaajhSYXVXYXpwNTM0?=
 =?utf-8?B?RkczQnFMZjFlWXViSU9BWGNyVlpTamRIYVNSaDdGRzYyNHZhZ2IxVDQ3Uk5r?=
 =?utf-8?B?Y3lZZGRER2p0MThhVWIwUmxDM3RkTkJMRzNBL24zMk1neDBlSDRWM3hCOUJ0?=
 =?utf-8?B?eXlOYmhQMnE5bS9QdVhHQUUvSHB2dzRMekZNNWh2ZVEyS291bWFOLzliOW1o?=
 =?utf-8?B?YmZhZnhlYldFZWJRS2tCOWl3UE8xU1E2RkJMR1hPdEwraGdVK2xZbmJ5RVhw?=
 =?utf-8?B?ZzhKQkhlelJ1am0ycXpIaXhGaDdxenZpUHAxcjZibEJPN3MxY00yMDhKSGxR?=
 =?utf-8?B?OGVrbXk4M2lSNzlNVmcyR0U0NXhjbkpUWStlZllhQStSZEo4MWw5ek1wZngy?=
 =?utf-8?B?N0xvR09wcGhKcU5keHBRU3o3eFZrRFMwcmlueC83ODNsTW04Q0JVZHRCUzNK?=
 =?utf-8?Q?u+utzIedBIgJxxneY0bnJgfgI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6+Pg/glA4JNtJRK7hpvJV/ml0Htile5qG01zchtPdO1SIOqm7yzXJOJhoJA9lPs8Y2gr2o1TH8Jr5GLw427HTZKVxGLG7cUB8dhnLydgbJ59xC6/SnRQYFVKlD1HvZ5nGSM7qql/X2V0tJHRp8TSpXPQRporBoCXr83ni47SRxVl/VSNANlpDadwjtiBZ4ouD3X4x09qijAcMORkbKABHWK8eYDvDEc5ZPJNDqnsxmsOdUlV1Vpqu7yPUNVEtQ7BJuEK28f+ii9me8FCCo3hlszstfYihFXngqSgmcoeoVaYUzDmx9Ws9E1vJVsaQaGhQ/CC9zvuPUmUFJe6CmxHXglGGxqA+SszA8dR+9zAu+AjpkNySLNG3oPhzmaoHHuAJsKj5ycWXZKfRviZYqfj43V7ScOBZ6Et0zk0fevbrkYbY4mXgTlq9rEPdPa6JE75uAO6znNoHTyqb4OKdJAc2iWcyDaoBQtpUcLwcz4KAJgxmFVBVEljlt6MyIjgVwDzpF7BDV2ARU299rtMqauuGXnvxXfdC24R7syO7U8HMqhvFEzmrmP3YsNeKvP48QlNBQ+kr41a7JiJd0XiZIkFOyFYXanO8rH6JV2WysxOhVU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 504ff4fe-c623-4397-9aea-08dd5abd7631
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4944.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 01:39:53.6308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dKvcX1huYZLh+XmdIxdGYnbQKcvv/3EMnQmC7+Xvm+Cx65xsz4VgWZ+Ok69+lB4MCSJ97gfXMw+0tA4COMwS9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7226
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_01,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2503040012
X-Proofpoint-GUID: dx1NmgCdYjyaRHtlVnwl0whzfX0bDhVK
X-Proofpoint-ORIG-GUID: dx1NmgCdYjyaRHtlVnwl0whzfX0bDhVK

On 3/3/25 01:39, zhenwei pi wrote:
>
>
> On 3/1/25 00:13, Joe Jin wrote:
>> Add support for setting the number of iterations. This is useful in
>> non-interactive mode.
>>
>> Signed-off-by: Joe Jin <joe.jin@oracle.com>
>> Cc: Zhenwei Pi <pizhenwei@bytedance.com>
>> Cc: Sami Kerola <kerolasa@iki.fi>
>> Cc: Karel Zak <kzak@redhat.com>
>> ---
>>   bash-completion/irqtop  |  5 +++++
>>   sys-utils/irqtop.1.adoc |  3 +++
>>   sys-utils/irqtop.c      | 19 +++++++++++++++++--
>>   3 files changed, 25 insertions(+), 2 deletions(-)
>>
>> diff --git a/bash-completion/irqtop b/bash-completion/irqtop
>> index 215281ee8..d18ef99bb 100644
>> --- a/bash-completion/irqtop
>> +++ b/bash-completion/irqtop
>> @@ -22,6 +22,10 @@ _irqtop_module()
>>               COMPREPLY=( $(compgen -W "secs" -- $cur) )
>>               return 0
>>               ;;
>> +        '-n'|'--iter')
>> +            COMPREPLY=( $(compgen -W "the max iterations" -- $cur) )
>> +            return 0
>> +            ;;
>>           '-s'|'--sort')
>>               COMPREPLY=( $(compgen -W "irq total delta name" -- $cur) )
>>               return 0
>> @@ -47,6 +51,7 @@ _irqtop_module()
>>           --cpu-stat
>>           --cpu-list
>>           --delay
>> +        --iter
>>           --sort
>>           --output
>>           --softirq
>> diff --git a/sys-utils/irqtop.1.adoc b/sys-utils/irqtop.1.adoc
>> index e81f4fbb6..75930f5cf 100644
>> --- a/sys-utils/irqtop.1.adoc
>> +++ b/sys-utils/irqtop.1.adoc
>> @@ -37,6 +37,9 @@ Specify cpus in list format to show.
>>   *-d*, *--delay* _seconds_::
>>   Update interrupt output every _seconds_ intervals.
>>   +*-n*, *--iter* _number_::
>> +Specifies the maximum iterations before quitting.
>> +
>>   *-s*, *--sort* _column_::
>>   Specify sort criteria by column name. See *--help* output to get column names. The sort criteria may be changes in interactive mode.
>>   diff --git a/sys-utils/irqtop.c b/sys-utils/irqtop.c
>> index 81a137be0..17c7d72cb 100644
>> --- a/sys-utils/irqtop.c
>> +++ b/sys-utils/irqtop.c
>> @@ -83,6 +83,7 @@ struct irqtop_ctl {
>>       cpu_set_t *cpuset;
>>         enum irqtop_cpustat_mode cpustat_mode;
>> +    int64_t    iter;
>>       bool    batch;
>>       bool    request_exit,
>>           softirq;
>> @@ -190,6 +191,12 @@ static int update_screen(struct irqtop_ctl *ctl, struct irq_output *out)
>>       if (ctl->prev_stat)
>>           free_irqstat(ctl->prev_stat);
>>       ctl->prev_stat = stat;
>> +
>> +    if (ctl->iter > 0) {
>> +        ctl->iter--;
>> +        if (ctl->iter == 0)
>> +            ctl->request_exit = 1;
>> +    }
>>       return 0;
>>   }
>
> If ctl->iter is initialized as int64_max, then we have codes like:
>
> if (--ctl->iter == 0) {
>     ctl->request_exit = 1;
> }

Yes they are exactly same.
As Karel has queued for CI test, maybe keep current code?

Thanks,
Joe
>
>>   @@ -295,6 +302,7 @@ static void __attribute__((__noreturn__)) usage(void)
>>       fputs(_(" -c, --cpu-stat <mode> show per-cpu stat (auto, enable, disable)\n"), stdout);
>>       fputs(_(" -C, --cpu-list <list> specify cpus in list format\n"), stdout);
>>       fputs(_(" -d, --delay <secs>   delay updates\n"), stdout);
>> +    fputs(_(" -n, --iter <number>  the maximum number of iterations\n"), stdout);
>>       fputs(_(" -o, --output <list>  define which output columns to use\n"), stdout);
>>       fputs(_(" -s, --sort <column>  specify sort column\n"), stdout);
>>       fputs(_(" -S, --softirq        show softirqs instead of interrupts\n"), stdout);
>> @@ -327,6 +335,7 @@ static void parse_args(    struct irqtop_ctl *ctl,
>>           {"cpu-stat", required_argument, NULL, 'c'},
>>           {"cpu-list", required_argument, NULL, 'C'},
>>           {"delay", required_argument, NULL, 'd'},
>> +        {"iter", required_argument, NULL, 'n'},
>>           {"sort", required_argument, NULL, 's'},
>>           {"output", required_argument, NULL, 'o'},
>>           {"softirq", no_argument, NULL, 'S'},
>> @@ -337,7 +346,7 @@ static void parse_args(    struct irqtop_ctl *ctl,
>>       };
>>       int o;
>>   -    while ((o = getopt_long(argc, argv, "bc:C:d:o:s:St:hV", longopts, NULL)) != -1) {
>> +    while ((o = getopt_long(argc, argv, "bc:C:d:n:o:s:St:hV", longopts, NULL)) != -1) {
>>           switch (o) {
>>           case 'b':
>>               ctl->batch = 1;
>> @@ -377,6 +386,11 @@ static void parse_args(    struct irqtop_ctl *ctl,
>>                   ctl->timer.it_value = ctl->timer.it_interval;
>>               }
>>               break;
>> +        case 'n':
>> +            ctl->iter = str2num_or_err(optarg, 10,
>> +                    _("failed to parse iter argument"),
>> +                    0, INT_MAX);
>> +            break;
>>           case 's':
>>               set_sort_func_by_name(out, optarg);
>>               break;
>> @@ -423,7 +437,8 @@ int main(int argc, char **argv)
>>       };
>>       struct irqtop_ctl ctl = {
>>           .timer.it_interval = {3, 0},
>> -        .timer.it_value = {3, 0}
>> +        .timer.it_value = {3, 0},
>> +        .iter = -1
>>       };
>>         setlocale(LC_ALL, "");
>

