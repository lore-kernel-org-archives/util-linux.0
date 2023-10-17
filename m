Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F538CDB474
	for <util-linux@archiver.kernel.org>; Tue, 17 Oct 2023 23:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjJQXGe (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 17 Oct 2023 19:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQXGd (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 17 Oct 2023 19:06:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB0DA4
        for <util-linux@vger.kernel.org>; Tue, 17 Oct 2023 16:06:31 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HJxIRw018416
        for <util-linux@vger.kernel.org>; Tue, 17 Oct 2023 23:06:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=b3wDt5rqAb0KG6Ci043000vprBaZzJyEw2ckmnwTvyc=;
 b=seOdUby7k1nF0nUUGCXBbzJUjKWBFa9mIhtHy61lfPoQFaVS54Vuo61TrbKQEO3Pqewc
 7O+E/z/cBqGGLmvfaPfBf6CUXq3uWufz+VHK0Zq82umMKw2DpVuIDSf+Lnvzv9CAAyBu
 Z2CqUiIcmcrGYexmjYYtZdd+bLRtYKRhKa7i7V3Q9J4h5EXFz50OLrzH2zWx9F7d6TNT
 cYqEd6uVS5lGP/0C5SWD3itUnB9vbH5udB6Sg8O3+6w8qDdI5zOg5oh58GRonlOcgexA
 XnvlRySk60KF5Ii8fhmNvfhCzkQSNlj7vPoOJnYrC8hDeYJFJrzYStqtVa++OnvC4aDa Bg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqkhu6cpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <util-linux@vger.kernel.org>; Tue, 17 Oct 2023 23:06:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39HKuxiT015185
        for <util-linux@vger.kernel.org>; Tue, 17 Oct 2023 23:06:29 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trg1fqmmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <util-linux@vger.kernel.org>; Tue, 17 Oct 2023 23:06:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1BvrqPBEWj5H45jJkQyqEoMiYNN7tWroRmIUugJn8e5+32rvIwvNiUYKIBt52zfkLAIzId7P0G0RctkUVlZW5ECm2pPd5suzGvgMJeXlbxqgkOhL0YgsGdUzTnS17TsLQNhUOchCA6KbyyIagx7FTPJ5BqO0zqebGgSjG9/lGr5xiS3cFoeXeYJoNwYPJ7wBm2Oj/IEj6+QQA3OlY7oSuP8xLIXs8RYoEPP0GRBwO8tkvT0+NelqWYhE2CSqFtwtjeP0R5MThVBPtZOznHSvIxofm0CT1HivJKhnUvBkkYlr2BBWRPzIUq04rxv93Maq3sQxXt8tt4yYFuejmYBeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3wDt5rqAb0KG6Ci043000vprBaZzJyEw2ckmnwTvyc=;
 b=a+QWUxdHcYnuzeADX9OuqE8tlpmCPzpev13gLMUMpPgR+TTemhEqx6D8bg4OpWhP3luCb4133w4nauc8hkNMj83VSrNxWlV0MoBa394x7xbVegewXGmxEmt95t9Im4HZuFDiTIMr9XzdE5A4iZKcy+iVMxGPPza7o5w+5Te3tPBZh8fwZApK/+xGZNao/kz+ajGhVLXQzsKM40Z2Bj7tRiTBewjyWbR1HLk7OWpy7K7jGvw/napoMeivRhtNstYCqOdJl0+D3wqbq1accM76ZoDnnFDNj/rgvsuRqXnkuBsjKXt7ksX/Z+BItHcIJ0//7No+xiompViq/8isaVnw2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3wDt5rqAb0KG6Ci043000vprBaZzJyEw2ckmnwTvyc=;
 b=YMbdjT6PvqlOJNw+fcXAT6IhEd0uabzbrFNssfB0mZadWlFkJeXA/2UdZzqC9U7L5SbtzbrS1hdQrvZu2fj/hszjA3dXoI9uv8ZFY9pyeN+grHgDEk3J67j0lqB/5nR2iBS3uj5xpFCnwWwOfl63giyUAyHuMQYXkSLH2r08EL4=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by PH7PR10MB6228.namprd10.prod.outlook.com (2603:10b6:510:213::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 23:06:26 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4aaf:c2b8:419e:d008]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4aaf:c2b8:419e:d008%4]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 23:06:26 +0000
Message-ID: <1457484d-5d28-47c2-b5b5-94f8b016023d@oracle.com>
Date:   Tue, 17 Oct 2023 16:06:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loopdev: fix losetup failure with a lost device file
Content-Language: en-US
To:     util-linux@vger.kernel.org
References: <20231012215524.44326-1-junxiao.bi@oracle.com>
From:   junxiao.bi@oracle.com
In-Reply-To: <20231012215524.44326-1-junxiao.bi@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0426.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::11) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|PH7PR10MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d5a05fa-95c9-4e64-cf85-08dbcf65b05e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GGID/xY+7mJKkckuIwroOBJOOhoAFbePWKdeRpEz5tZXctQpM6S7/4pJx69HQOyvE3mDRV+hajBvgDS5aK15QiEJjk++dmjCLudfykLnRh7tv2qp44KfaPsYJc0SMg3xRTzl7ktA6eZghn7hHwCt8RA8qYGckZBILdwnDMoRsIDNOMx3PxQgt54VcgoWcYQ0UYV2oM6rNBKSCX2za4C1oFQIN1XrttTyckQHmXzd9ikI7NA/cPApb+2/8gVMt+AR0vXF1wpB2r19xEDhcXYYCm8CIr2datxsU4CG4hQIyn99NLJNopxkgXegYKJY3m/3mDvlvgTLm4eYyDdRIk5bofkTdxilHQ6Vjmqz2J8J0EdTkpn1uJYjSrBHVUFPIm6rI0lCwoeRMEwl3gn0JsdeIGJ4GGVh61zap1Xd6mncVGD+ksNeEJyvdbzyuELde+h6IyAGQcqMa7sAIxRDPAvn5bhLR/no9XIao8NYbhBu4oz7YRgksQKXJ1040y4V8IvTb9w+lgvhHyQfBKkxBRVQ4BFloZZf6oxMX5ppX7Zq1W4VolA96ypIMv9CeooFKhJDhdC3PafXXMzeld6F5Fmf/EFo5jl7sAQ3o2jrjVAW+DBNjgrjjjnq41ux9MP+xKCr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(396003)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(2906002)(36756003)(86362001)(31696002)(2616005)(9686003)(6512007)(83380400001)(26005)(53546011)(478600001)(6506007)(31686004)(6486002)(5660300002)(38100700002)(8936002)(8676002)(316002)(6916009)(66946007)(66556008)(41300700001)(66476007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjBNN01pREZNdXZVVFU0dWwyYVRLY0FKL3I2ZUYrM2V0Yk1IMnBkOTFpdnRh?=
 =?utf-8?B?TEpqUmhMN3RzMTBBb1U5MS9GOUI4MFordkprS1FUUEQ5KzVhZnYrN1llZTA0?=
 =?utf-8?B?ZmVRemovN2hBK3A2bkIrS096QzJ0RzZWRWZIdnNmMTdWczQxZ25KMHdKQlVQ?=
 =?utf-8?B?Vyt5L0hjRjRSTnZjNjIzQmZiaTh6V0IreVQxNGRFTmlhYVNZbGFPQ1F3dXBZ?=
 =?utf-8?B?YzQ1M0Y0d3RXbkgxTFVJVWk3bit5dFMvaHFZVmJnVW5zbG5GcmxESXJORTFu?=
 =?utf-8?B?MjVRU0dQS1orNEhKdUhsVUQvVk85clNqYm9QZXJVS1pRVWx5dERNcnlMcXo0?=
 =?utf-8?B?aFVVbGQ3R0E0WGkxcVhYUHFCYXBqMnlhQ1lWQnlDbk9wbWplUmZibnphVlVo?=
 =?utf-8?B?RnNIZkZQbU1LZmIyWUFXWnkybjYvOSt2YzJMN0pHbzg1c1ZWdkd0ZSt4cm41?=
 =?utf-8?B?WHB0WlRWOE14eFNhSTM2QjhGbzVtSDA2RVR2UmVOMlMwcnJnVnNlazFoK0Vy?=
 =?utf-8?B?QXU3aHdKZGlFamZtL2g2alg0M2d6RlVTcmhpeVI3SVhUYUdtc1VlQmdmMTJZ?=
 =?utf-8?B?ZWhhZ1dlcG8vZW9DcWowU1Jpa3EvbGZkQVU3QVZNRUZsZExiT3FGU1FvZy9M?=
 =?utf-8?B?OFFoN2MyYjVvUVZGR2wyT2JBbi9xd2prVmxrWHF5a0ZVTnZ6SFZub1hMa2Ni?=
 =?utf-8?B?NGJnckZlanZYMHZtVXVLTUU0S1hua0xsUjlXSzd6SG5Cbk5iUmZPcEZIQlUw?=
 =?utf-8?B?Z0lYMmZscTZOazFiU3YrZEp0UzBzUWEwdG15YzNiQ3EwVVZRRDNjbGtGOG1P?=
 =?utf-8?B?SGtndXd1L0JVOU1vTVdUK250UFZjVW9TYXkwck1iY0dqVGM1aWQwUHZHa0xm?=
 =?utf-8?B?VlpkRTY3R2x5bVU2Rlg4cHNjOUtOOUFaemNGU0N4WUJqalRXK2hHU0V2dXRD?=
 =?utf-8?B?SjJsRE9veURNZFhjNHBORGl2NzdKNy9adU54ZzFBZ2pNeEk1YVVWV0Jocjh1?=
 =?utf-8?B?dWF4YTNrN2p0UzN2cmx0TUdkd2ZaRHB1cU9CWmRlMEw5L0E1T1VhRGNQdWls?=
 =?utf-8?B?KzJTaitmbFJBNUtvK0lNU2I0d1RrdzVLSTdsem9wejF2TElNdlFaVmo1ays5?=
 =?utf-8?B?Z3hyT011V2QrRitZamVDcFRLbHFOSHdELzc2alFlQUtibUJvS3ZsK1haU2FY?=
 =?utf-8?B?a2VrTkNNVTlLM3dTTEpGb3EyZ09VNUJWaUNVd2xLZXAvSHZlY2JBelVnNjZl?=
 =?utf-8?B?Q3VoazgxR0hDcW9udlh0UlZLYTBpbDRzeTN3Y00xNXRTSUpLT3JYS3NkdkM1?=
 =?utf-8?B?OHNiVW5nV09GQkNRNk0wcjYvejdkZEpyeEpmK3lBMkJKdEZSVXFoZ0FOSHg2?=
 =?utf-8?B?eXB2SEJIQzNxZGdyY1EvYkhON0dsSi91d0I1RFhySjE1c08xK2V5WXBIWm11?=
 =?utf-8?B?azM0ckEyNXJxYWRVTlNva2prbmdCaFQyQ29sZUw4V3RPRDUzTFd0V0tsWFNG?=
 =?utf-8?B?aTkzN2Fwamc3WW9BbWVuK3d0TEVHRDVSbzF3YmhQWWFOMDcxdERKenJKUXVI?=
 =?utf-8?B?N1lRdy9qSkc0MURrNmxnV3hjRXJ2NGNxZmR6a3lMTkhqaUlLNGV4S3ZCbzlm?=
 =?utf-8?B?M1ZlVVhLdjBKRG9tSnY5d2w1Mm9kcjRTNTZ4UVRMeGNEWlFKclZlRCt0eXoz?=
 =?utf-8?B?SkpBQThuQlZHeG4xdUtKczE0cjVZSmtZQjFQeUx4M3RVT21MWFFhRVo4K2lq?=
 =?utf-8?B?TzhIU2hRYVRFYjFxbnROTlNPUnJROTB5Ni8yWDlOU0dUY1Vra0NLRzMvUUtF?=
 =?utf-8?B?QkVWZDB0THZHazlwaWc2SFMzcmYyd3dDak1qL1BhQVNtYnFON2c4eVFLeGhB?=
 =?utf-8?B?L0swdGN3N3owaDJvQ1JlNnljUkpsS2ZRemNva2FTd1oyM3BnTk5Idm81blVM?=
 =?utf-8?B?ZmVucUUxZGJJRWtuMDZIRlY0TFVVY2VBZmNUUWk5NGdMUjljK1ZQSk9Xa01Q?=
 =?utf-8?B?TmpVODQrMFVlZVlORXRaQ0NhcmFuOWt5a0xLVlJPSkpSVEU2T0ozOTRtWUNQ?=
 =?utf-8?B?Z1Y0ZUsrdEZTOGJGVHk2dzBhemV2anVmRW1FTWt5R1NWUjlycEtmajFSQWVv?=
 =?utf-8?Q?9sIFk7xRbb7E3s8UqIm2fQ/C9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: p14cZ3And2rs+9qXC7NSJoHJbbLcldWstJs0Pe+jgYpgB36J07ttRA51s+47eSdEzKWzBcxJtN89g1Ud+70JpTd9b2dtTfr/mLr1U6DY63HGvsSm65trA5jqRDrv5vMEZbL47jSlChgo67Q+eTD1btkc+xGgIxvULzIuhtwx3/lY4W7ZA3bfUdtCkBnU9imWZsDTWKEsUbEQbBlrEXy+oRjFYjmkhfoOZ7nRzoD5ZIISku2jjYf/25r+aUkufku8JT/9EBboIG+qvHVFo/MWQKUKoUEHOu+7yHsHwp9y/Whje377i3VlmGNLrdnrJ4C5SF7Ti+csjO0fnbDnkIfk9fifR4cFO6PYa0XiFE9xV5dWOEpW0w4fUFI7HfRU1t3au7L7o1385/dLoX4/VkJrJmTpYw8dFC8cAGfN1OVdEJWZxe4EHVAgFZqX06OLLYwmdEpRZfg4SQX4spLtewtyKxePHb2XBfwdmp9tq+0gpZE6exEZsd8MTfC7wKKS4D9kDMxzhnimAuFQZtKo4wliy4eKhkE7PBel3cPzBmtwdFewMq6pmnEiwlSbnGZlzC783psd3zhvsy4YfzTSdW0I66mAK8guwpsq7AczlAKlRQfyr6LDsm2UQfnwDaY3tMVnnGAfDw8QjzJeQci465X4T0YdzMEu6PuFjBiLctnnCzi3obsifWNGfxT/fJ1v5+nhfocTooOu2zBFyrXoihg9PK1BEOD483/znco25IGy+I1BIYtambfqbfLRWUZgDbMh/qOFjOpafbxSbaRwAJtsFg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d5a05fa-95c9-4e64-cf85-08dbcf65b05e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 23:06:26.2353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QRP/cOc7xUD0gUO/0yyITPlaGPKXyuQTWp3eReQRd7quVMaEkdCPkozafMwzLuewMuoJwWfpha7ojmEoRgz5tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6228
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_06,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310170195
X-Proofpoint-GUID: mtw_PwWASdF4i9-U9sHXmFAp7yB9qjkb
X-Proofpoint-ORIG-GUID: mtw_PwWASdF4i9-U9sHXmFAp7yB9qjkb
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Anybody can help take a look at this patch?

On 10/12/23 2:55 PM, Junxiao Bi wrote:
> If a /dev/loopX is lost because someone might have removed it by mistake,
> future losetup operations on that loop device will fail.
> For examples, following cmds will fail when loop device file is lost.
> - "losetup -d $loop_device"
> - "losetup -f $file" or "mount $file $dev"
>
> Users can resurrect the loop device by recreating the device using mknod,
> but regular users might not be aware. Since /sysfs still have the loop
> device intact, this commit will detect that case by scanning sysfs and
> recreate the lost device file.
>
> Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
> ---
>   lib/loopdev.c       | 100 ++++++++++++++++++++++++++++++++++++++++----
>   sys-utils/losetup.c |  14 +++----
>   2 files changed, 97 insertions(+), 17 deletions(-)
>
> diff --git a/lib/loopdev.c b/lib/loopdev.c
> index dae499f256fa..4fc617830bae 100644
> --- a/lib/loopdev.c
> +++ b/lib/loopdev.c
> @@ -279,6 +279,87 @@ static struct path_cxt *loopcxt_get_sysfs(struct loopdev_cxt *lc)
>   	return lc->sysfs;
>   }
>   
> +static int loopcxt_get_devid(struct loopdev_cxt *lc)
> +{
> +	int devid = -1;
> +	const char *p, *dev = loopcxt_get_device(lc);
> +
> +	if (!dev)
> +		return -EINVAL;
> +
> +	p = strrchr(dev, '/');
> +	if (!p || (sscanf(p, "/loop%d", &devid) != 1
> +				&& sscanf(p, "/%d", &devid) != 1))
> +		return -EINVAL;
> +
> +	return devid;
> +}
> +
> +/* scan sysfs entry for loop device. */
> +static int loopcxt_scan_sysfs(struct loopdev_cxt *lc)
> +{
> +	struct dirent *d;
> +	DIR *sysblock;
> +	int nr;
> +	char name[256];
> +
> +	if (!loopcxt_sysfs_available(lc))
> +		return 0;
> +
> +	sysblock = opendir(_PATH_SYS_BLOCK);
> +	if (!sysblock)
> +		return 0;
> +
> +	nr = loopcxt_get_devid(lc);
> +	sprintf(name, "loop%d", nr);
> +
> +	while ((d = readdir(sysblock))) {
> +		if (!strcmp(d->d_name, name))
> +			return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * losetup cmds could fail if /dev/loopX is removed by mistake.
> + * This function will try to detect whether that is case,
> + * if so, it will recreate the device file and open it.
> + * Return fd if succeed, otherwise negative error code.
> + */
> +static int loopcxt_fix_lost_device_file(struct loopdev_cxt *lc)
> +{
> +	char path[PATH_MAX];
> +	int nr, ret;
> +	FILE *fp;
> +	unsigned int major, minor;
> +
> +	if (!loopcxt_scan_sysfs(lc))
> +		return -1;
> +
> +	nr = loopcxt_get_devid(lc);
> +	if (nr < 0)
> +		return -1;
> +	ret = snprintf(path, PATH_MAX, "%s/loop%d/dev",
> +			_PATH_SYS_BLOCK, nr);
> +	if (ret <= 0 || ret >= PATH_MAX)
> +		return -1;
> +	fp = fopen(path, "r");
> +	if (!fp)
> +		return -1;
> +	ret = fscanf(fp, "%d:%d", &major, &minor);
> +	fclose(fp);
> +	if (ret != 2)
> +		return -1;
> +	sprintf(path, "/dev/loop%d", nr);
> +	/* default loop device permission is "brw-rw----" */
> +	umask(0003);
> +	ret = mknod(path, S_IFBLK|0660, makedev(major, minor));
> +	if (ret)
> +		return -1;
> +	return open(path, lc->mode | O_CLOEXEC);
> +}
> +
>   static int __loopcxt_get_fd(struct loopdev_cxt *lc, mode_t mode)
>   {
>   	int old = -1;
> @@ -303,7 +384,17 @@ static int __loopcxt_get_fd(struct loopdev_cxt *lc, mode_t mode)
>   		DBG(CXT, ul_debugobj(lc, "open %s [%s]: %m", lc->device,
>   				mode == O_RDONLY ? "ro" :
>   			        mode == O_RDWR ? "rw" : "??"));
> -
> +		/* loop device file not exist. */
> +		if (lc->fd < 0 && errno == ENOENT) {
> +			lc->fd = loopcxt_fix_lost_device_file(lc);
> +			DBG(CXT, ul_debugobj(lc, "recreate %s fd %d",
> +						lc->device, lc->fd));
> +			/* loop file is not lost but doesn't exist,
> +			 * reset errno to have user know.
> +			 */
> +			if (lc->fd < 0)
> +				errno = ENOENT;
> +		}
>   		if (lc->fd < 0 && old >= 0) {
>   			/* restore original on error */
>   			lc->fd = old;
> @@ -416,13 +507,6 @@ static int loopiter_set_device(struct loopdev_cxt *lc, const char *device)
>   	    !(lc->iter.flags & LOOPITER_FL_FREE))
>   		return 0;	/* caller does not care about device status */
>   
> -	if (!is_loopdev(lc->device)) {
> -		DBG(ITER, ul_debugobj(&lc->iter, "%s does not exist", lc->device));
> -		return -errno;
> -	}
> -
> -	DBG(ITER, ul_debugobj(&lc->iter, "%s exist", lc->device));
> -
>   	used = loopcxt_get_offset(lc, NULL) == 0;
>   
>   	if ((lc->iter.flags & LOOPITER_FL_USED) && used)
> diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
> index 0ca910ae3347..b45cc2ee8f3c 100644
> --- a/sys-utils/losetup.c
> +++ b/sys-utils/losetup.c
> @@ -653,7 +653,7 @@ static int create_loop(struct loopdev_cxt *lc,
>   		}
>   
>   		/* errors */
> -		errpre = hasdev && loopcxt_get_fd(lc) < 0 ?
> +		errpre = hasdev && lc->fd < 0 ?
>   				 loopcxt_get_device(lc) : file;
>   		warn(_("%s: failed to set up loop device"), errpre);
>   		break;
> @@ -741,8 +741,7 @@ int main(int argc, char **argv)
>   			break;
>   		case 'c':
>   			act = A_SET_CAPACITY;
> -			if (!is_loopdev(optarg) ||
> -			    loopcxt_set_device(&lc, optarg))
> +			if (loopcxt_set_device(&lc, optarg))
>   				err(EXIT_FAILURE, _("%s: failed to use device"),
>   						optarg);
>   			break;
> @@ -754,8 +753,7 @@ int main(int argc, char **argv)
>   			break;
>   		case 'd':
>   			act = A_DELETE;
> -			if (!is_loopdev(optarg) ||
> -			    loopcxt_set_device(&lc, optarg))
> +			if (loopcxt_set_device(&lc, optarg))
>   				err(EXIT_FAILURE, _("%s: failed to use device"),
>   						optarg);
>   			break;
> @@ -883,8 +881,7 @@ int main(int argc, char **argv)
>   		else
>   			act = A_SHOW_ONE;
>   
> -		if (!is_loopdev(argv[optind]) ||
> -		    loopcxt_set_device(&lc, argv[optind]))
> +		if (loopcxt_set_device(&lc, argv[optind]))
>   			err(EXIT_FAILURE, _("%s: failed to use device"),
>   					argv[optind]);
>   		optind++;
> @@ -935,8 +932,7 @@ int main(int argc, char **argv)
>   	case A_DELETE:
>   		res = delete_loop(&lc);
>   		while (optind < argc) {
> -			if (!is_loopdev(argv[optind]) ||
> -			    loopcxt_set_device(&lc, argv[optind]))
> +			if (loopcxt_set_device(&lc, argv[optind]))
>   				warn(_("%s: failed to use device"),
>   						argv[optind]);
>   			optind++;
