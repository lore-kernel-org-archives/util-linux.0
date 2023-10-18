Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDD3CDB47E
	for <util-linux@archiver.kernel.org>; Wed, 18 Oct 2023 22:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjJRWIe (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 18 Oct 2023 18:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJRWId (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 18 Oct 2023 18:08:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4277CB6
        for <util-linux@vger.kernel.org>; Wed, 18 Oct 2023 15:08:32 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IIp7dI019586;
        Wed, 18 Oct 2023 22:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=yXzn6BPIjUu57Ib7nzlQM+yJnq7mhIC0xCbYo5Fouuw=;
 b=smWssjrZhRlFPo/WDnSPL0Xf6bqzhJmAkCIn+MEdpc/NtT5PdaFMABmvPpP0MR69D5RU
 6ZnBbRpEryY0YhFzXNhGbc/q1ABubI7Um7C0AP4bULrStudgG94k+9UqUDCYMVvBiA2X
 oxPirKeJfA7iu9dd40UNqSlqRx6JLsroM5EnGL7wHbRhz2VbQ9vK4aKDUAA0ksYEM6OQ
 cAnMFmX4DzDLVarVopaauDaQhfieus4l1/4g5Ofz7Ou6DNP4eYuqUEBKwo//eqfryFOH
 BFi6OYnWSJ2ayYRmCdao9pPgbSq8Fm6qxsJhDE33KEjo39KCqae43W3fpF1iIFjW6jlm hA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqjy1gn42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 22:08:29 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39IK03TU040709;
        Wed, 18 Oct 2023 22:08:28 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trfypcbkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 22:08:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFu8A9FngIYbWmOg4ToPnd+E/kjOPqJLc8Uq3R9pyDvV94n3BvPopf00n81HTupUaw/yxAzxs3KIv+LfM4Fr2EWv0cOTVGpivqTuT8UAWudQEcP++BUCNrD/WoSHDZUXvJ15MsgLcVO6eChO89X01uQDfqaMHSWE9PZtBwf1vHlx0nyo5wO+y9+n9kmU745SipR57C9g2DxU+ZcXIoX19uTuVdmTt5fwHNJdZ7CQQ6elEfu+fYToIdU0BsthRFke8uUBx3aFIjDm1TBNBwpyfXFPyYm5HOHP+tDblzxBt9xwUBvQImPv/oPZiN1KMzC21/DRCV/tg00Tbpt/W3a+bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXzn6BPIjUu57Ib7nzlQM+yJnq7mhIC0xCbYo5Fouuw=;
 b=lherVm0c6wQxXdeuHTKGNSUc7/vYp38A+02bWcFyRLwwoSlD2hH5zrRFXDuHCcJZmKiwjKHVzze3GNf3vWf3wWfI2wO9YPZYkHPe5tOSJJrgTINCely42eoz7hbm7UcYadbFavoQiwWgkAx2hiKaPD/LFLyk2YGiFdFWt4oK1w8fsVSk2pBS8FXxYPMgXpvx/xH3ufj6UDaBJaAvpDsLlPs9r7c/VVl7+vxWH1R0+q1oh4OBmsJPNlMGJXbi2bdJqN8hyqOXOI3rVwUn7ohRPHYsu1pfTFjFxDqbu+Tb5t7xVJNobsmuAPRF0z4ykxsyAsbEsgD07v7wzgs7RaMLFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXzn6BPIjUu57Ib7nzlQM+yJnq7mhIC0xCbYo5Fouuw=;
 b=n5N/J8sPOAO0BD0zDUmEzj6aOvo7S7xsMN85Ma6FlswbfldnLmFeOZ9TTmkfvdQrpyZ5C8H8sVjXKsj8JsfY3rzeDI9lVXHAASaqdsw4BqKv+Nz4X6hbBHM5UlsF0oJ1a4QalT15HEd/seRhzGir1ubT6RjqaK59fOcie7FxT9Q=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by CH3PR10MB7645.namprd10.prod.outlook.com (2603:10b6:610:17a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 22:08:15 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4aaf:c2b8:419e:d008]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4aaf:c2b8:419e:d008%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 22:08:15 +0000
Message-ID: <13252433-64a0-4d72-925a-5e32bc1af99c@oracle.com>
Date:   Wed, 18 Oct 2023 15:08:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loopdev: fix losetup failure with a lost device file
Content-Language: en-US
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
References: <20231012215524.44326-1-junxiao.bi@oracle.com>
 <20231018175941.f2zysgnq4ibwoyvl@ws.net.home>
From:   junxiao.bi@oracle.com
In-Reply-To: <20231018175941.f2zysgnq4ibwoyvl@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0149.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::34) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|CH3PR10MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: 1701f513-dae2-414c-f880-08dbd026ba09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0LOlIB62/16wr0gGfWEKjjam4MwN2vEFuvjGb7U26uHqpBUNqVw1/PXVUYSuD0cy9X6EhEgXMXCFekmXio8JhinzDp7GkE09YOzpdhXRLe4c301kgXCkeVpmKFkevQx+qE0prr0LlECeqgNmzpDi1JIq5vDC3em0/shw6VrK227fZ760TD2HuLESt+eevJlW1ow6Hspux7R+HLu488bxaOtKJX9ecBrD1xIK80GrOSZrSQ/szJntUwq9sG9eI6Qfo6EHslVwhg3cacx0lyKubd3QheV62VtM2BXYVLVl3utkkEoB6zWzEO3VzB1OEj/vdyzZWrFa00N3gozVjPm/MzyZyZYDWbyb2Ofldr7cr1oJBpnFTw43G2ar+NqAUZikaH/rG/ospSff29frfI+24K7nPTxgAwV0cn5iblUcHqtDnvUnRZcOFu5IlKGHqYhDxKfxzDcS47vHbGI9S8ILVhPxZ3MNT4xQj6iFEevxsPxgk47kIVpAM1FCxpzCy03SQKwkd02cUKWBp3AwA5YJ2KP0eE8SMqmF862rpZBNPH28HPlW4yTELkgDmQA9pTRhVXclLB2Seqp1KVCYhqq/RZ08CDz330aBgO4qlX2zmCs65IS/5rofUCpOsV8vky2l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(366004)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(478600001)(38100700002)(31686004)(9686003)(53546011)(6506007)(2616005)(6512007)(26005)(83380400001)(6486002)(5660300002)(4326008)(8676002)(8936002)(316002)(66946007)(66476007)(6916009)(4744005)(86362001)(31696002)(2906002)(66556008)(41300700001)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGZmTXBmc0F2UmptYkpYOGQvM0l6MnRjRkpwYUdPbXVLWTlMMTZnNmpHNmdh?=
 =?utf-8?B?eHdpUnpQbGlDRWNvWmp3Zm5SaFNMSUVBa29tamgvaVUyejl4ZWtxQm16enVW?=
 =?utf-8?B?TWtsd21xUVNtV2xiTXgxVFFCSzJUZnpjZ3NBL0ZsUFRpaVJ3Y3hVc1o1TUs0?=
 =?utf-8?B?N0hDUGdzYW9ZOUFqbUxmRWE5MHJwQWtuSlFkRm50ZUJlUVVnK0FGVkxybVV4?=
 =?utf-8?B?YXdMMEhMSmVBbURVdkg1NTY0c2ZON3JraENLR295VGpWNVlrZE51TnV4Vzk5?=
 =?utf-8?B?cFRqd25iTlNDcWxhNHpYUlVUL1VTdXEzbXNNUFFMMWNhdHhiVGxCQ2RkVU9r?=
 =?utf-8?B?WXJmbjRlcVEwTzNhQ0VBMUFNdmttdm9pdVpSaGNNTXFkd1lBbFFMaFB4Rytn?=
 =?utf-8?B?dXROSkczSEhaUlJPWGpXMWYwNmxlVGRwY0s1SEc5VmUvK0hFcXRSdUYyM0xi?=
 =?utf-8?B?UTdIeTZ3QmJFZmVpaTFvSDQ5aUVOVWdUVWp2WWIrNGlmSDBtWDNFNkcrTFhN?=
 =?utf-8?B?VE5RR0dYU3lRWEcxY1cySEJvQlBvRWNXL1Z1c0xiLzNMOVdybFZKbm4wWG9B?=
 =?utf-8?B?YUZpWHlqZkE1cmtnZ3Bwczljdlc5aGtmcnZQUFRvM1N5OHBHREtGNCtyb0pr?=
 =?utf-8?B?OTBDZGdQb0l3Zmx2TWdpaEFkNzdHSmF3YmNHTm1RcmFQeG5sT1J6TVFWc016?=
 =?utf-8?B?ZU8wdmNCTlZPK3lkODVpS2JVMlFIRUcrbmlPQWtlc3FKcjE1QUwrd1RCL2RB?=
 =?utf-8?B?ZjNVbm1GWnlreDFPcEZmWDdPeDMvSm83U1ZYemw2K0N1cnNxaUJ5NlNNR2FI?=
 =?utf-8?B?VHpocGxvUnVxS2ljWk9lOHEvSzBxcG52MTNjb2ZGSWdOYitLejdCNWZoSm5Y?=
 =?utf-8?B?SXFvNUhHSy9zR21YLzRzeGV0ZVA3T2FGTE8zR2FvT1JXajRoY3d5Z3VMc0Z3?=
 =?utf-8?B?dnFwTUZBbzR1UVgxZlc4RWt4VGZRb3NhdWh1T0JOU01IeENidTNwd1N6NkYv?=
 =?utf-8?B?cFZjdld6MGNmc3lQcFFNV1JXSGNINlRYNTAxRzhqRmgwYWVmVTluYk1CTzBs?=
 =?utf-8?B?TkdrcGpESzdJQk1YTVRvc3F6TTVVMXZwQ0NrWUlYRFJwZWNtcEl3YWFrVXFx?=
 =?utf-8?B?OXNnR00yaU1ZTUM0Y2xkWHF1NVBxeXZzUnl5cEVmOE9Uc1pWS2xMbUJtWDEw?=
 =?utf-8?B?R2ZxYzB3R0hCREFXYVI1Q0MrR2pBZHBHR0dabzVld01FaGUyNFN2S3YwbTZ0?=
 =?utf-8?B?SVBkdEVJZnNPZmhDTWRpODhBWitBd01TWENOM2ZtZTEzWVFiUEg2Q1dhV2V5?=
 =?utf-8?B?Z3p6TDFha1VEejYyL29FenRtdjRvckR6Rk9qWnVIUWNaZFpQalpWbThoL2VG?=
 =?utf-8?B?L21jMlRlN0QrTFJPVkdKWUI3OXo3SWwycnlscG5xSVViQ3JIL0tpR1BpK2Fh?=
 =?utf-8?B?eGxJN2tKamtEWk9Na0JpdWM5R1ZxOHJHT1ljTDBYL0lqSnAwNzJDdG5KOEJ4?=
 =?utf-8?B?KzlRWGdBVS9PR0I3VDhpQSsxSmZFckpheStsZFpCdEFZT2YxOVVaR2N6KzJl?=
 =?utf-8?B?V2szY3VOQlRGcjlVUnlUZWxDSHNpb3dZS0tBZDVJbkdsTEd0RXErOW50QnlQ?=
 =?utf-8?B?V0V4bjYza3JyTlpmMGZWSDF2NGdzTmc3RzdBNXZDT1RVeHJvQWtTSE1xZzNo?=
 =?utf-8?B?NmEwcFBtWmErVEhKTHFabFlzcHBMcDVVOXlvbEF4K1I5NGc2NU9zblQyK1Y2?=
 =?utf-8?B?YmlRT1hod3ZOL05PM2o0VS8zZGJ4RjdFTmpNSDJ1R01ISzRZd0F3K0xYL0lU?=
 =?utf-8?B?bGNhaFptWEdMRlZoMlYrOTlVbWQxTzl0ejV5cnhWdXo2MExMTFpHRnQ2VlBt?=
 =?utf-8?B?KzJtMzlId2RwdWZuanVnYTduS3lWTGVCaDdrYUxITnVicnFGcFpFWWVnbU1u?=
 =?utf-8?B?NDgyVTZlQm1saUVmYkl0YXRTV2lCMFZEUGFpS01LMmFJamhmRFVzYnAzWU5V?=
 =?utf-8?B?REtzdzd6enJXU3RQTzNET015aHBXT3JCM1JwaEsxTjNkNzF4bGhaMVNhajU3?=
 =?utf-8?B?WHlDN3d5OUlaelJsRnJkOG9uNGZncmFRWnFtUzRWcUltZ1lGbm9waDRTS0k5?=
 =?utf-8?Q?s21zGHw1ARoLLynR13ylTU5K9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SLNaxN070Yej+VX9u613zrhAh0SXOmr5irJAYbF9CS1eHmMj539J6EivQKQHq9rDvn5kfaFXjGl8eMD9V0dhiiuIsxO9BiuvN+lKqr0OjDAV5Q+1D3o6QAASYzY1mPqj6ajDjnsxkxSoXBAYPKSQsjOQpbuCfZViHT46Qv8uM6dDKhkl+g6NzbXY63YExZvgb4vOG+kdZjanDJ25Xzjs2j0EPwIgQdfOB0HZVD4G/3yiTCx2+6mOiVJTn+8VTNAsWix/CItLdlurC42AegtFyApf1ztictu31LrtnRrYTefX420qBeXLrjqiywsVYpUwyHL+Ij+YUgVSM9FHx7OhQMKPxI5VNkxUVS0JGZhs5PtSJhRthVQeWkM5vkeCYhj8adyctvMPtW186lQprd8JIysAW/jAt+V2xgQzBA25UorBZI1fjmbQSquiOe4dbr09CpTEfNAfWYv7LPBbtn6TQ4V6U/16gHas541XF46AY+/k24q8kFnxLqjID2B8bNYfhIlY7VU8wpm3aEw38sfe6lKhTp8FdGp8KIcQoPZpY++Eh2tkgZe17XcvkjOo3WU0z3KuFdCDHadke9zXw+8lyde0jAObqM3z7C3yyUyrkuVE9XnkC9RtkihtAJWmW+psEJvnj9+Tr/fj0s27RVH4k3Via6XBnMpL5k0IitSEP1xHe9Wn1nt/bFXqPRE+0uHZGPBpdsMfq6bKjoq3gpNX8Eaks02ceuwZ29qB2i2Zz5ECw2t8/fDLVv7nuBRMiw8/mTOxrQl4nTqbFmOdudsQPK8dF0WM2UA2r5dljQYLOXo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1701f513-dae2-414c-f880-08dbd026ba09
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 22:08:15.2837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WYm7YJHUXTREOYGbgiym0F+HkoOAYFz8LR8sr/LTz78ZDXK+cTDp26UUovzTOATJ4XaKurc9FSIaHOs2TqOZ+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7645
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_18,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180182
X-Proofpoint-GUID: YqhZNKFb-rZyn3lqlTlh70i1c1oCx74a
X-Proofpoint-ORIG-GUID: YqhZNKFb-rZyn3lqlTlh70i1c1oCx74a
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 10/18/23 10:59 AM, Karel Zak wrote:

>   Hi Junxiao,
>
> On Thu, Oct 12, 2023 at 02:55:24PM -0700, Junxiao Bi wrote:
>> +	sprintf(path, "/dev/loop%d", nr);
>> +	/* default loop device permission is "brw-rw----" */
>> +	umask(0003);
>> +	ret = mknod(path, S_IFBLK|0660, makedev(major, minor));
>> +	if (ret)
>> +		return -1;
> frankly, it will be challenging to convince me that using mknode in a
> tool like losetup is a good idea. After all these decades, it's still
> not a common practice (although I have see many attempts).  Nodes are
> typically created by udevd by default, following udev rules.
>
> IMHO, it's better to report the problem (perhaps with a helpful hint)
> as error message and assume that the administrator will address it.

Fair enough. I will make a V2 with only detailed error logging.

Thanks,

Junxiao.

>
>      Karel
>
