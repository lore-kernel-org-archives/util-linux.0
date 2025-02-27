Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFB3270023
	for <util-linux@vger.kernel.org>; Thu, 27 Feb 2025 18:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681060; cv=fail; b=l94/YPbJ8n+NhPbB/09qxjj0/LbjIRjtw/Bwyut4xPmfS5fk2hTexpEzzCBrEhLq644m0CnSRFK0uaWYfqM9LrIihNGC+Qxw7+LxKXv0q1t/WxpbTuGE5G+UWJjSitixOYMCYKRzcgyLB4Eo0uM74k+EKgpynXdyvNADPKMtKVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681060; c=relaxed/simple;
	bh=iuLlU0hJVHHb1YGWYEjBFmBq5klRAwPhor2kJNMnHJ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m4LLsIidwW37wOvBWIJJnxhHlyjYneSGr43z62dloDO1SPuefHigFeFHZAGpIFgtgMWHVG85ZykVdtGi33NX99jKWN37HH7LbQJBKlcVx6+pnJ1Khh6yd8/9dN20NC4/t4WSw7+9RedcBWGDRCWo5YHvSPZOcRB5WnkSWOroTdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SRs3BvV0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y+iCkO/R; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SRs3BvV0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y+iCkO/R"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RGfjap016080;
	Thu, 27 Feb 2025 18:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=36tQoP9gc4WTAe7UMsGxFHhmRVCsLEhCTuUeQfjY+JI=; b=
	SRs3BvV01P+wdgtdcHJbZgx27Po7uYvT3hiDtEtkeCsQqDlB36pT5w77J2x/BGrC
	BpmzhYPT86+b5N29ar8UBkxR3Gp+7bnCSMDmzynTfjqzpK69PbFOoRz21IcecVsO
	HmnH7T9HdGmFtjYY2KTy0FEFjJTJEs3Qb+kSmgCV8+VctnSCN+YUtDq27IX2mPIN
	t8ByOzPvVmjXXEU0bJJmhdR6V9UpHjOUMvpzOHf7za0V/s+/omw/b/qzFiOIGqhd
	UoejX/jI0QcfEUrf+lbKJqxq7qgcRTV32iztPByZ7ooGmVf47LDg2F/HndSM9FXY
	ggcE5EIKoUG/gIryRGRt4A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pse41x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 18:30:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51RH0w1Y002714;
	Thu, 27 Feb 2025 18:30:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51cqvts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 18:30:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oue1zUdSumlspM+dtKueLzu2rLhPCITdYfjODeN+qGv6jjTEekKXenxjknbXVg0K2uFA4BVoxGAfRbj8pKxNpaBVRYoapftVgAQtApk8NCanFtc5EKgmgv0NValeivO2s4lprsxw87aLzP4F9c1ovZoCGvyiLRAZ6JvzzLwE9X5gwRzhx2GdaZ/mUty1YKEFB+7z0D8dtNFFtomdeFR4rtF/rlmWKdo0E/1VzrCxfdT8HFvldODXIfipnAatEOclv2P++/RYmBmBxxcHbTU8oOk4/esjjOH1ie9ZhaV6otdEQlVrPu2hHXfwnwuaSugM8nbMXiav1XaxHC9Uxv+9FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36tQoP9gc4WTAe7UMsGxFHhmRVCsLEhCTuUeQfjY+JI=;
 b=uRV8r2jzW6MiTMjJgkkUVWYoqPvtuMr991G1wSHB5NgS/ksnfhJCo1zEQHkRAuxwmbRQdyMOWku7YekOfbPvjEAHjyrKEVhNg/PTo148dfmX0EkiCB5RRRsxNJdlvJeYiUYw7e8zs7uaYV7cZZ4iIZc5voZzqNwdgYTNaQpb2tuSFeoxDRSMUusgAx0623nzxbN5CLaH4v94v5irPvAWM6eOoycKgdNfEWDB4mgGAD6YY0W4rZ8ViaR7LOsvk+l/r7HW1YsJTKVKnLwTorhW1NnMV89Rzp1KKlB/ABIU1lYI7qqEJlaGd3ZnwFxC6cqtmUE6poa+5K5HxYEB9jmQ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36tQoP9gc4WTAe7UMsGxFHhmRVCsLEhCTuUeQfjY+JI=;
 b=Y+iCkO/R0rEZW34Bd07jvBDIcPNX7UZXuCobTRNfrVIHl5Gi+cAxzJx2gy5V3m6CMrNOgX91EuUxGbbJJ5G7jwKLihIj8tDfbGUVBA3CrzQQ7BgMX/kO31FMmpqp5BtBeUPp0+ynInFZ41y8xYSSXv7gm4hSWqf6YnLyYU8zzCI=
Received: from BLAPR10MB4931.namprd10.prod.outlook.com (2603:10b6:208:331::6)
 by DS0PR10MB7090.namprd10.prod.outlook.com (2603:10b6:8:141::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 18:30:39 +0000
Received: from BLAPR10MB4931.namprd10.prod.outlook.com
 ([fe80::2ec9:a98e:942c:3cbf]) by BLAPR10MB4931.namprd10.prod.outlook.com
 ([fe80::2ec9:a98e:942c:3cbf%7]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 18:30:39 +0000
Message-ID: <67875d29-f43b-4101-b2c7-f2057282f0ae@oracle.com>
Date: Thu, 27 Feb 2025 10:30:36 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] irqtop: add batch mode support
To: Karel Zak <kzak@redhat.com>
Cc: Zhenwei Pi <pizhenwei@bytedance.com>, Sami Kerola <kerolasa@iki.fi>,
        util-linux@vger.kernel.org
References: <20250227044916.89925-1-joe.jin@oracle.com>
 <20250227044916.89925-2-joe.jin@oracle.com>
 <3cip52rtte72zolbb2ta6ztl63p4ez7oo2wmi5fpqvjxz45jwk@akiqt56yf4vs>
Content-Language: en-US
From: Joe Jin <joe.jin@oracle.com>
In-Reply-To: <3cip52rtte72zolbb2ta6ztl63p4ez7oo2wmi5fpqvjxz45jwk@akiqt56yf4vs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0141.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::26) To BLAPR10MB4931.namprd10.prod.outlook.com
 (2603:10b6:208:331::6)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4931:EE_|DS0PR10MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bb7db9c-d899-4c6d-8a2f-08dd575cd586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WENqZHBva1ZBRkF4NkJhbjRyVDYwN0FCczV4VkJ1Y2UvRmthM01rS3k2YVZx?=
 =?utf-8?B?emJDZDZIczdUYUFNbWljK081OTZJQTZjVDRYeDZDcFpjSzkvd1VwUmVxMVV5?=
 =?utf-8?B?TEZJd2h3cmQ5ZElwMW9JYjVKK3JaRmZuZlpRK3E3ZzJRRExybmxPN3pVVStr?=
 =?utf-8?B?dlpFVFBUWDBuUWl6ZzVTZ1B4U0N0WXlzWXhnUW1iTDlNOVVMREpNUTJ5dHBx?=
 =?utf-8?B?bTVYajRycTJkTk1XWmpyenkvZGgzemgxWStQME8xVWNVQjlFb3lZTHpIL2d1?=
 =?utf-8?B?emdNWmNKQU1MbVdsbHZlaDZXTUdoVlAzdWc1SU14VURBWHhpV3ZkUWNEamt1?=
 =?utf-8?B?dU5aYVNRK0pEWlhTNng3QmpUSnpWUys2MWNLTW82NDBSVTdOWDkyTnpvYVk0?=
 =?utf-8?B?N21iVmJObGt6RGFHZlBkaEE4d0tIK3RUQ1cyUGJHeHBCWXVYT2tKMjlpenoz?=
 =?utf-8?B?RnA5a1JXdHlXdUhQQ1haWWprNnFqdWs2dGJKbC90czJoT1ArdExWcmtGbUh6?=
 =?utf-8?B?RU4yZExPcXEzbU1ZVUs2YUNpSGJoSGw2eXRWdXR6YWcySVU5VVlPU0d0bzFt?=
 =?utf-8?B?eWJzajVGcllzeWUreEJ0UUhXdXFrYmM3WHUxemxoVXdBWUNERGxSYkhvUzRv?=
 =?utf-8?B?Z0w4OU8reGJuYm9JTXlhTU1teTNzdlRxaWp0YlgxZkVvUWdsdWI3NjdSNnVK?=
 =?utf-8?B?ZWdrc291RXAyVC9DK0hVVUJwZ1NEMEo5SDNxTklEVS9MZDI4c2k5VW1kbmJV?=
 =?utf-8?B?K3MraDNBSXFHaWZHQU84VmE4NHMvLy9OamxEZVVzS3JuQktJWFY5OUNhbWJM?=
 =?utf-8?B?L1o2L3gxejVRcmdpMlFCdXpmYS9RcTB1NjY5RCsxTEszUzJIL0RVc1kvVWpK?=
 =?utf-8?B?aDFVeGpXVUJ6Z1NqOStNc1JhTk0rSGgrY0liSGJJVkxwcU5uQ2lJbDVsR2VO?=
 =?utf-8?B?dTl4QysvcW5Mdk5ZYlZCMkRQK3dJMGdaWFhEOC9OQ0wyT00zbEd2Y0VLcFpq?=
 =?utf-8?B?Qkt1UksyTVpVaUJvU21iR3RSbnJ6aDFDMGhra1QzWWxNdStjblZiaDBKZ0hz?=
 =?utf-8?B?cExqWUpLMks3R2k1bnpyNnAvYlQwdStKNkI5ai9FN0V5MW1HcTRKcGNJcVRj?=
 =?utf-8?B?UWZYc01WWnV6UWc0Uk5ES0tLYzA3QTNwS3FJcnRxemxXUi90Zkd1am1Takc2?=
 =?utf-8?B?NHIvbmxER1oyTERubWQwOWFPZmZTeVJ6bnBteEp3d2prSjNzZDNLNnhCZEdG?=
 =?utf-8?B?Q3JmckdCV2pPNVlQSFF5THJxVzVDRjhKeTVHNVJVN2FBNVA0MUFnQXZlRzJR?=
 =?utf-8?B?VlIya3I4cUlxSTRoT3NMUUU2QmhoMWZIRExNTURKUko4eUZVM21qaDk1VDNW?=
 =?utf-8?B?QzdTaXR0MzBSaEQxbjZkTTdhRjJZb05hbVI3RmJwVnl0U1o4aHQ2WWtlaXBV?=
 =?utf-8?B?aFJnUEIxVDNKQ2FaS3Fsdm1sejJBN1V1cGJQT0ZGU3lDcitJM0IrTmFiVFNv?=
 =?utf-8?B?U09UbW1BM3lxUE9DVGE5L0pXeHlmRzRYZk9aN04zTWlEOUdnay9MRW5FTEx1?=
 =?utf-8?B?U2FRbU1IVWYvUmxHa2MyZVA0akorU3ZESDk4b1VTT3R1a0FBUzlzM3VJNytJ?=
 =?utf-8?B?dXgzYmZuekJQOU9HSVh5eE5iZDVsdjZNNm1hbVRDeTVzUmJSdnVUbzh6UUox?=
 =?utf-8?B?MjZTaUhhcm5Dd1hueHNiZGlPY1dDTkNqOXllbUhhWjhFRHpkdGlZV1MxUU52?=
 =?utf-8?B?UWpIa3diYmhsZWZxaUZyV1h6S2NPdWYwbU04KzcwbUJlMWNlUGJDMzRkQUNy?=
 =?utf-8?B?Z2djL0w5YXZtVDlOWnp0RHA3elZDTWhxdXdxZDduY242RDhSbkZ3SERVdkV0?=
 =?utf-8?Q?LhKTNToU9/3QN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4931.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkJKMEZrYUpWUUhNRlJ6azU5dk41NUpJYmhEWlZQOVZBOVZsdkJHSkZzYSty?=
 =?utf-8?B?QUdjZkc4WXJwb2kyVUViK2NoQzNPcWYvY0dobUFrOHp6NTRVQm1TQjBWREZv?=
 =?utf-8?B?Zm1sbUVMazNSNXZBUThWWmYrSjFwM01oaUlWUy9UQWh1UEkrU2ZnVGxoTlo3?=
 =?utf-8?B?aTdtSmNhVlA0SmgxWVp4bFdqa0JxS25uMGk3SFFOUUV0UGtCOXIzNVVZNGRO?=
 =?utf-8?B?eVVvaElNZ2FqZ0ErNnZWb1Z4Um1XMm5kM09aQlU5TTZvcmpmTnluZ3RlYlBZ?=
 =?utf-8?B?Q0p6VitMZ3ppa2pQMHppcjRpU01QaElLdGNDUFdXSVFVQ0c4bXQwdGVqTHN5?=
 =?utf-8?B?NWNycHY5bGpLWjFNYW1WK0dYRmIwbHE1c0ZhaXlDYUo4VjhCU2tSQmtlMGZT?=
 =?utf-8?B?aFAydmtVb2JoY3FseTVkTzl1NmphM3BQcjA5ZWdyTzkxbWpoRURaKzJxM1Jl?=
 =?utf-8?B?aTZFR0ZiUFM0WkQ3NlZsL3ZJZTN0N2p6U2t4eE1PTmg5S0d6SkNCVGVEb1Zx?=
 =?utf-8?B?S0diL2dwa2JjTnl3ck95M1VIS2hLT2pBOU5HYUozU0NaN29QQzVtMzV6N2J1?=
 =?utf-8?B?bGROSXpQME5rTXRPOTR4VG9UOEJORWYwNmZXL3hlQkdUbElOR2srVzAwSVVi?=
 =?utf-8?B?SXkwanlBSHZuMnBzdDNTa1IwTHZncGR5UExRbERPZXlqbkhMVjJ2UFl3bVFV?=
 =?utf-8?B?eFk0cERDZmc1ZFRxaUNPdnpXVGd6UzVNaEtBSytQaXMvZHUzUVJQUnBoQUVT?=
 =?utf-8?B?U3lVNU5LRTV0bDdYS1N1K3UwT1RvUXZMa3hQcHB5VlNleG1pNHd4dm95NSti?=
 =?utf-8?B?eTJhV3YwU1BwS1BaV3BWa0pYanF0SlRiMkVkT1NUM1MvaXEvWnF5MUI3WU80?=
 =?utf-8?B?RjdFa2Q2aGNxT1RJcnNYTS9zVTdxdWIxRDRuNVUzcUk3Y3JkWmVJcnkxNlZO?=
 =?utf-8?B?K2pwQ1UydVZiY0hyc2Rpb2R6OFkvelFVUTVtY2ViRGZ3djBTdytlK3BqTC8v?=
 =?utf-8?B?dUlCRm1tajlwUFlaNm5wUHlIeU14UGFXeTQrNHZiUURXV2kzWElWQUxRL0xt?=
 =?utf-8?B?ZGt4dnVlbVQxeFlYazZET1ZuM2l3dmlnWEp0Z0hsMlRtUkxqRkkzdWI1czhO?=
 =?utf-8?B?bGt5QlljRHhDWWl4MWpKd1ByQ0hSa3dPdmZmaTJNUE5zcTdHRXMrVE1IU0JW?=
 =?utf-8?B?RFd2ZzVHNmFtWVJRaEFQL3RKTVNJOGRZOXlLT1lQS3U5a2tOb09xVGk4dzd5?=
 =?utf-8?B?bC8vQ1VoNXpaVFhjSVRaT3hzbjEwbng0VU0ybytTWTQ3RzVWbDk1enBIMmFo?=
 =?utf-8?B?RXI2WmRJS0lHS1JPUWFkUjFqbjBIVGxnZ3FYOW9zVkt4bWtMSXdiYldiRDkx?=
 =?utf-8?B?dkhtZ09ya0RJck96M1I4c1podDk0Q1kzblRocDZRVWpjSlg4TnU2TUxvbWFz?=
 =?utf-8?B?LzBGc29uREtzcHI2ZSt4VXVadkFnZWtaMGR6SkpNbXh4Wkp2MTJ4QTJGYW95?=
 =?utf-8?B?SHdwVUFvUFVvanNoYTFlVk9CcUxHSHZYSmp4VDN3ci9HbnJieWg0Q2VTUzFV?=
 =?utf-8?B?WjZDVlVWRWZiNzdPTUNXNTkyNDYxS3d6WTRCZUFlelVrYTlLTkFZbjhmRXJX?=
 =?utf-8?B?TjVjdFFlQ3dLamtPa2NTVnVHS1Y5bTlGQkxpZnpMWnJPV0kyR2JuVGF6MFpj?=
 =?utf-8?B?WFFYTFBlRmpQeW5oYXlNeHBjUC84Q3FnWmJZRHhzbFlrRzQ1NVZtT0VEMlU3?=
 =?utf-8?B?ZDJrU1JvYUU2dE9tdnlLbGZQOXdBMUVXbG5pWk04MU0rcWxpOHVxRDhoeHI4?=
 =?utf-8?B?NXU5WWlBY1ZIa3dsU2gwQ3BZTFI4cG9uNFRPSkNjRVJPbC83L1NkQU9VTmts?=
 =?utf-8?B?b1pBOWhua3JmNjduaGZ6OVFubEVyZExoV2gxaXB2ZWdwdERwOWpNc1VVSlA2?=
 =?utf-8?B?K0JHNXFlNXA1U2JCM3lWdGo4WGZuUUswQVpkWVVlR1EwcXh2a2hzV2IrNVoy?=
 =?utf-8?B?TEJaY2pUSHlOSkI3a091MmZtemNOS0VZWG1YdXlYMHo5cmZlSURWOUl5bWVi?=
 =?utf-8?B?NGs1VnUzZC8rYjlPYUdmeDZnMk4xaUp6MHp2ZlA2Rm1lL2paWHpzQjAwUmph?=
 =?utf-8?Q?M+fBQ9QfEPSxCLDTX3H1StSTS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MWGVdL2iGLR54UNBvtniKu+YB2iXpYXg/2TtRmC67HdH0ILOK0xANzGH1AdwSwMuD7TTzMyYkUuYZKewqt/vSaDUOkxjcYnDdQnzNyErCQpCt0aAOpMJC+gfGbK5CAns41VXxNZqTtPFfgSrpGr1sth16Vu/LgTnMvfhkWjYvESK0PP7MSrTt3TDaVnOfwQfUaI2mUgKqKvy8O93CmXw4Wv7qHGnoKgaPiAHweWFsREsFh030r3x9XL6KiWomR7XOhqO0EUsXq5xZi5vLnskSRgy/hMIgjktKO/GhNZepI+sGYhQvlbUeaRFv9FQ5wKeRPQqB357+sc3DYuns/QcNqiCgTvL9awUrfJNWeTogjHAx4Cfc/7DqFkoBJn2EWJpMvebPQkSLdLpbOfvI3vVAhmBJFDwakUae9782hR22mprG88K7yLscJO3VxYxJ6YnEGtB7V+VMme9DpB4nQqKBjV44a3TvEPXktrT9x+9suLFxb1aK8mixMcqbJN3l4i18K7NjMedQ8NeRT6aAp0a5pmT4EgjOoHK6XUTHMNuMs6nOC9Y/ywGXZiJWQVkmsdwq3nE/tUEDL+y9CI2dRYZT6JrAErvSwSWONwFIDTalw8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb7db9c-d899-4c6d-8a2f-08dd575cd586
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4931.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 18:30:39.0441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HLyy/ZM8IVTo6Hd4pFTnM1Q3pv/toEY4EVOKtuGC7FkyGhOVMO44NBr06kGvRhT4/fds2v/kuh5a2L2l9q8/NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7090
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_07,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=925 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502270137
X-Proofpoint-GUID: RdHhvcIzRC8QVc7Jmd09ZI7Lg9BM_s2I
X-Proofpoint-ORIG-GUID: RdHhvcIzRC8QVc7Jmd09ZI7Lg9BM_s2I

On 2/27/25 01:25, Karel Zak wrote:
> On Wed, Feb 26, 2025 at 08:49:14PM GMT, Joe Jin wrote:
>> +#define irqtop_batch_mode(ctl) ((ctl)->batch == true)
> Do we need this macro? I think use
>
>  if (ctl->batch)
>    ...
> or
>
>  if (!ctl->batch)
>    ...
>
> in the code is good enough.

I'll remove the macro.

>
>> +#define irqtop_printf(ctl, fmt, args...)		\
>> +	do { 						\
>> +		if (irqtop_batch_mode(ctl))		\
>> +			fprintf(stdout, fmt, ##args);	\
>> +		else {					\
>> +			wprintw(ctl->win, fmt, ##args);	\
>> +		}					\
>> +	}while(0)
> It would be more robust to use an inline function with vw_printw() and
> vfprintf() rather than a macro with a variadic number of arguments, or
> use __VA_ARGS__ in the macro.

Thanks for your suggestions, I'll create an inline function.

Thanks,
Joe

>
>     Karel
>

