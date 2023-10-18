Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65031CDB483
	for <util-linux@archiver.kernel.org>; Wed, 18 Oct 2023 22:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjJRWGP (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 18 Oct 2023 18:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjJRWGO (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 18 Oct 2023 18:06:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C7BB6
        for <util-linux@vger.kernel.org>; Wed, 18 Oct 2023 15:06:11 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IIorGq012508;
        Wed, 18 Oct 2023 22:06:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=o1g2Gf2XiY6XAaz222KEKaTr1vtaV2MQMuFi4fmc43E=;
 b=wc/36q0+T5Yb3eYfttreBCgPMxti0jUWe4Q2WevWUGgykKYG0v7lZF1+GRp5/Nm/WEfR
 y/JW32qc2CRR3EHZYYm850shiBFeU3HVY09R5AI0nH09xtWG6CTe2DAs+aZ3/0Q1cfnZ
 QHeF6b1ARh7GNbCJA6VDfn9aYfC2EaorxebiPAVjtxbxy7SwDCmKRktWob9+llOwCH91
 glcR6y5higymVctkdbfH/Z9lR9tO3qpuSz/+WrxRvx8vQTe8RzI3nNRdiw0aqNI0NrlD
 X0bFd7bPDCXpI6rGbkJ6aYyZ6Ezc8BI97Y4xTfM6bsxHQ9c+2a/9d3Oho3qfCqBXnEjC lQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk3jrr6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 22:06:07 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39IKUQMM027187;
        Wed, 18 Oct 2023 22:06:07 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3trg55wmm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 22:06:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmznAWNbKj/M6zBzGDPjhwKHjDSRPM2tBDqfM8kq8o1P0q9XFa20T6k5U97vDt0ePj3Co6Nblym/e0qZuXqHJwfDdFkDKDJ1Ywls0bxrwLjSGr2UsOftEeI4ZZndH2ttyEXySllNxXoslhnRRwPb2B87CUPRdkCPbgdL4XZpmY7ZccJwo0uQ3WSnnqWvkmI05/w4DlWr8VtVzbFYdsPX9dml80rDm9dimSnEWHhLxov3P9KdEH1HFDO9IQGlHTZC67owRpM5VtG1xzezXGxnHTsNgUNV+TaGCiKmUTSR86lTxyIFXt4NY/kwS8X8DUMBWVzgVGzYlbZmQN1+nIMi4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1g2Gf2XiY6XAaz222KEKaTr1vtaV2MQMuFi4fmc43E=;
 b=gr8thVFr3ttcnL/p1MdZ867kQT14szEqFO9FLZTcC1JXKYffFGHCj5rEGo9dhqWCmCvyJayyHJC6e6WIGq9iQ7m6PmJ6NpdSNreEpHlc9w28HeZAoeh9R+9piEfQ7JIL6PHtsct+O2Q/MyWAh7Pc0KjitlojyejhFvWfKGYenpac/mzaKPaYzr/rC6ouU7moFx8wqZw7wcLQNjqOFNnrBnMneLQ7vjMln3sWM48ufFl7UDHusjb/GmuN/TivgWWL2ylwTLQ0+hh6r+h48bOJ9E/cjydYPJ9VxeFcEdGnPJjPjUvknHBw1nDjozuHpchb8hrfyDh7/PyX5uJzF3nosw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1g2Gf2XiY6XAaz222KEKaTr1vtaV2MQMuFi4fmc43E=;
 b=Br0NqKBgc6jCXHwa1FuEruL3ON1zdX6r1Qyl2ZEbg6yYUXpnuk+FuqCLft+m/2DkxCmpp7kMDZoYctv5sUP0KF2oHZPwbdlEKBn4MvbtACCrw974k34/GuNH7x26bPN2zMeeq6p3FbKbeTBLoNDDE68cyLT/JpHSpCKjInHJil8=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by CH3PR10MB7645.namprd10.prod.outlook.com (2603:10b6:610:17a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 22:06:05 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4aaf:c2b8:419e:d008]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::4aaf:c2b8:419e:d008%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 22:06:05 +0000
Message-ID: <496ba5c3-e539-4f99-92d8-cb61f1f306cf@oracle.com>
Date:   Wed, 18 Oct 2023 15:06:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loopdev: fix losetup failure with a lost device file
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     util-linux@vger.kernel.org
References: <20231012215524.44326-1-junxiao.bi@oracle.com>
 <01bda825-9b75-4bd9-91c9-49cd4df3e3b9@t-8ch.de>
Content-Language: en-US
From:   junxiao.bi@oracle.com
In-Reply-To: <01bda825-9b75-4bd9-91c9-49cd4df3e3b9@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR05CA0076.namprd05.prod.outlook.com
 (2603:10b6:8:57::13) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|CH3PR10MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: 55fd0224-82e9-41e6-0f6b-08dbd0266c69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o67D1iORhwkKC+3m+OaoBkU1+4OK7U0DPuRZVjtKh8MY9/7guq0kj13J4d/hwX+aoi/nnV4fKnfSxQDTfXhQUNjr8GkmKs79jMIlpPzrSpRpTmBDqpViUY7rr9zS7GIjfOcZHy8tXOv+jzi2M2OVsd/ImCEdzTm3N4JpsgHt3820wKhL7qjz8xzM/3r3y5f/1l0deeFhclU95zTIdLvCWzYFFIt1KSgM5ErfTVkNcJfKxvS8yj+kD2zHsGcc4BNx1XMSDBtPeY+ScgyV2pfEsPN7ZSu/e26/kF8z/kLd1P79TgcvWH2jil495bFNpEx6bhXwsskO6LHokGGMK6ZOU4c6XcVZ3dRtZCfTqDfpd82Dp1nq6dHkra5xK8niADHCr/QHk9j65gcszKnPT88dhprUYMx9dqBK1B6e+Q51tiVIwOGxEkZU823+laZOYYS9ZD0uQi85cTCDEqtednRO3muNXZ9El/8Gn/wg62hjR+EAqOb6N5knGa4YvIptIcjmpHEtBlBZvyQdpb4znsDOrlgk06hmWUcYVvNyMLEe7UgrIBunQFOYxloutX/phu0qfNHy3RYycMW4Bzw7A46fyexUq9FQRxH2wxZG3pEp0cC/fsWKeGcoeMgviqU+R4G9G4T/DarkrX515dHtDbziPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(366004)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(478600001)(38100700002)(31686004)(9686003)(53546011)(6506007)(2616005)(6512007)(26005)(83380400001)(6486002)(6666004)(66574015)(5660300002)(4326008)(8676002)(8936002)(316002)(66946007)(66476007)(6916009)(86362001)(4001150100001)(31696002)(2906002)(66556008)(41300700001)(36756003)(46800400005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bndGNnJ4NkZqQ1F3NmpmeWtxOGpndHFJTkpubTE1V1lEMGFCbk1CRWdva1NY?=
 =?utf-8?B?RExocUVFWVM2VU5RNkNRSThZZUFQMnlLb1paUWVuMkpya1h4LzAvUi8wMW5j?=
 =?utf-8?B?MkJxRG55V2lzZXRpSHlBeUgzY0R6OWxOdjQvYUphSUNkbkU0UG5SU0VBMEYx?=
 =?utf-8?B?bXk0U2g1TnJpeFBSampjNUg2Y2Roc3VyZTk0MnVJYWhuS1VmcWhQTkQwQUp0?=
 =?utf-8?B?WTYvazF0czRsb3lRalpyTEtwNVgvLzhIbVN0LzBwYm1nMEl6cWVUWVBPc3N1?=
 =?utf-8?B?RnlDTzM1aXdyVEVIeS9tV0hKTk5DdzJmTjF6UWNnSDcyMmFBaTJ6OVM4SW1D?=
 =?utf-8?B?WStCMGFDU2FqTVZNcGFIRm85YWNVTDlLd3k4WUF4aVRUTmZTa1BweHNpK25x?=
 =?utf-8?B?dkRwR3JVYzJuMnh0dlRCVGxjL1JldnYzbG1IamdJNHJsM0VpUXhXdnh2dnBZ?=
 =?utf-8?B?UmlrcVIwNkF5ZlB0NllQcGcrNUJnMk84dGVnVUNjaUxDNEQwYUJ4dnVZaS9s?=
 =?utf-8?B?UVg4OGtweXoxQ1ZRbEVZbU44MWhFbm8xeStpMVZMUXpKZUFmYWprUHZnK2t2?=
 =?utf-8?B?L2x5Z1BHbWFkanZ0SmttbG9XSU1mbWVDZ0tWa2REOEMwY3dJSmJWZjkvQ0Rk?=
 =?utf-8?B?eWRzV0dybkRLOVBCazcyUXBGNnRrdGJ4QnQrR3o4QnN5ZnFobkszYkFQV1M5?=
 =?utf-8?B?OHhKVjI3amVMdmxIWk5qUlRiUU14U1NOYzZEMmdkS0lOOE5wbW02RHdhL3VM?=
 =?utf-8?B?dFJvQ1pOLzYxeWtNTDM3NWFOUWRqam9SREFlbnNISzFwYVBVdTJkREQ3R2ph?=
 =?utf-8?B?MFNUS0FqYk9aUG01Z3BGeWgzTVhXbk5lVWk3UGtOeVdMWURLOVdSUGRMODRT?=
 =?utf-8?B?ZWxWanY4RVBJb25ieXB5TGg4NU40a21OUDAwUTA1TytGTVVOREVlUEZxTVFy?=
 =?utf-8?B?cjlyMTdxbXh5cWlGQVVYbi9iWjl5d0hIQ1BiUjZMM0QxYWlVa2pVWjdHU2xp?=
 =?utf-8?B?ZldIbGtjeVFVbmtVbW1OeTRJcjhubDMvUTZyK1RSNUZjRnFUZzlDMkJ5RExK?=
 =?utf-8?B?ZUNneU1BdkxUQjRudC9kZlRrdDdFb3NIQWJmbHhxa0VZK2tIVVBVaytzYVhS?=
 =?utf-8?B?bUZxdTlicG1CVHdZTEYyRG44Y3AvejY1S3kwaWZBOVNheEsvalhCUVVuNTl4?=
 =?utf-8?B?ajU3L2FkYXVpYVZCRkhWS1Fnc3Z0bzc4bTViZE5vbW9rS0p1RUp1dy8xb2JB?=
 =?utf-8?B?bE1VcGZKaTdCMkZwTEw2ZThCcGtyMlM5ZXVWL0xmZi9zMnJ5TGt4aFJpYUx4?=
 =?utf-8?B?S0ttMW5WVWVyTHNlSVNheFI5dDFNbGVIdmlPejNNZ3NhaEt6WERWV3Zra3FZ?=
 =?utf-8?B?NmpqOC9Hc2M3ZFJEODU4WnlTdlhkNVhiZ2c3UUpSMnh3T0FWdlQzRTkxNkJt?=
 =?utf-8?B?aGJaNyszVzU2UTNxWk5Hc2NicTFvN0tjS1R2YzgvYXFoUFpBNnhtdFIweGNH?=
 =?utf-8?B?OHVnU3lxSy9iNkNFdldqYXJheU9jQVhXQ2d6Q3F5TlAwTE5jMXpzK0NBSFZj?=
 =?utf-8?B?QmJiSTBLRUVGOFVScm8za3BHdFlta2dJTGF0QnBPZzNyTFlSd3o1L2JDaGNP?=
 =?utf-8?B?MmhaTG1FR2wwRnNab1daVDZIYys5WkZLWEtmd29WN1BscytxeGpuUFNiUkxX?=
 =?utf-8?B?WE40YlBLcGFwSkNDWVY1WGdRWDQzSmJWNEtxU3dMY1ErUkFxdTR6RmEvWHlt?=
 =?utf-8?B?Tyt5UUMvWEJOQjFRbkoxSkV2YUl5N0RlMDdaemphaVJhZmdIK045V1FzY1Jz?=
 =?utf-8?B?QTVOVUZ4VDJiQVR3KzFVOHJSK2ZQUm9ublg0SVloQm4rcWQ2NFJUNXpQSHF6?=
 =?utf-8?B?M1JZKzRoUVRoM0FwRGZwVFFtR0F2SXdQek4zaVBJWlNZWlI5azhiM1ZVaEpL?=
 =?utf-8?B?ekVpNm8yV3FXTnZtdFZ1M09LN1pQUHNFNTgwejhOOGJPeXNuMys4dDc1cVF3?=
 =?utf-8?B?d3hZa1lzaFpYQWhyaWVreEcrSnlkWW5FTndHbW5wa3h5NHplLzBHRmlhRmVK?=
 =?utf-8?B?ZW02a09PcEZFbXRVbFg3c1B6cmYreDBDYjlsSDRBTUNlT281VTFNQzQ2ODlq?=
 =?utf-8?Q?cVYV0xvSB2HFUrE8+IiN6pYu2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Otj4IQFRoWeo2R4OHxaaaIPBWMHjCDxEi7uumFyIcWGnr4gMFkEa86lJUtvEi6CkpQDCmlG/hNe3bbTvMzFmzoXzreD0olKKRJkegm8r22sucjJ9hLMBieVWdwja04/daTN1Vgmd0Y5vrnxIMhCjAozcKLmpcLWZTa1azEbCI9z1/nVHUtXKpRojh2UaNOHkZlKd3ZoJz06CGsQmQoKikeB1w/QKFEcwrNDe/D3N5IMeve2InvtS9qrgwmxnuyrniIUgEpQNWkIcC7rSyEH8PrFbpM6zoY0GLYXXMMjxg+kVIYe8hHx8cjEoG66k+aM+TG4OPMdcbNbOYMj2/rlsTl5d2wDq16ss1MLR5JyHC4mZTwy+4jRCpmUNFL1/v3IW1iwBl1qRqUEW5ILeVrMD9TJPCzXHGPFYWXfpj2iooJY8+ejw5C2oBI3F1d/6gDyUFU8WgGCr0GYawWndWddc6EbhJL/y1WEaQakZRwnlAWrinH3XjKkFFu+F2A0kvl+jECwMVWo278zxion4oLKR7SWoTKZb1Ezj8vUULfIJ4FHH/V4fWjiFMwspkItHU5J9Bl/JoQfN+3W8dIF+Gd2PFT9rCsuihXSLnoNtRpaBwFtO6v2jGTl5kJpA7+0ZRn2fsxb94dLCvnRikPdcpsjBHTDHxoRaPL2pqApvGn87qaZ81xSWLpC+Z1NXN7zixgG8pgcqlTAy4TyBWNi8L4lm7oW9RbtPZtHZKN6Kicc+eCprk5cQUfWHoofi9sjo0koM7bR14zbBwjx8P0Wfr9gGZYrkVXYxvPRwdXd110Pc7AM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55fd0224-82e9-41e6-0f6b-08dbd0266c69
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 22:06:05.0938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JM6d0rvR6qp9YVdegpIj1fklPZAGhnYAIzB70ivjOGiqUjCgPdpLwslfGfpcFOEEQhSxu+YjkUtfoC1GQ8POFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7645
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_18,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310180181
X-Proofpoint-GUID: cRi_O9mC9W0tH4jwIbmZAIx8IW8MGz22
X-Proofpoint-ORIG-GUID: cRi_O9mC9W0tH4jwIbmZAIx8IW8MGz22
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi Thomas,

Thank you for the review.

On 10/17/23 11:18 PM, Thomas Weißschuh wrote:
> Hi Junxiao,
>
> On 2023-10-12 14:55:24-0700, Junxiao Bi wrote:
>> If a /dev/loopX is lost because someone might have removed it by mistake,
>> future losetup operations on that loop device will fail.
>> For examples, following cmds will fail when loop device file is lost.
>> - "losetup -d $loop_device"
>> - "losetup -f $file" or "mount $file $dev"
> What makes /dev/loopX more prone to accidental deletion than say
> /dev/loop-control or /dev/sda?

I can't see /dev/loopX is more prone to be deleted than other files. The 
issue was triggered by one customer, somehow the lost loop device file 
caused their automation script failure, they don't know how that loop 
device file get lost. I think it would be good to support this to make 
losetup more resilient.

>
>> Users can resurrect the loop device by recreating the device using mknod,
>> but regular users might not be aware. Since /sysfs still have the loop
>> device intact, this commit will detect that case by scanning sysfs and
>> recreate the lost device file.
>>
>> Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
>> ---
>>   lib/loopdev.c       | 100 ++++++++++++++++++++++++++++++++++++++++----
>>   sys-utils/losetup.c |  14 +++----
>>   2 files changed, 97 insertions(+), 17 deletions(-)
>>
>> diff --git a/lib/loopdev.c b/lib/loopdev.c
>> index dae499f256fa..4fc617830bae 100644
>> --- a/lib/loopdev.c
>> +++ b/lib/loopdev.c
>> @@ -279,6 +279,87 @@ static struct path_cxt *loopcxt_get_sysfs(struct loopdev_cxt *lc)
>>   	return lc->sysfs;
>>   }
>>   
>> +static int loopcxt_get_devid(struct loopdev_cxt *lc)
>> +{
> The only use of this function is to directly format the numer extracted
> from loopX back into loopX.
> Why not use the loopX string directly?
This function can be used in other function to remove duplicated code, 
for example loopcxt_add_device(), i can add a new patch to do that in V2.
>
>> +	int devid = -1;
>> +	const char *p, *dev = loopcxt_get_device(lc);
>> +
>> +	if (!dev)
>> +		return -EINVAL;
>> +
>> +	p = strrchr(dev, '/');
>> +	if (!p || (sscanf(p, "/loop%d", &devid) != 1
>> +				&& sscanf(p, "/%d", &devid) != 1))
>> +		return -EINVAL;
>> +
>> +	return devid;
>> +}
>> +
>> +/* scan sysfs entry for loop device. */
>> +static int loopcxt_scan_sysfs(struct loopdev_cxt *lc)
>> +{
>> +	struct dirent *d;
>> +	DIR *sysblock;
>> +	int nr;
>> +	char name[256];
>> +
>> +	if (!loopcxt_sysfs_available(lc))
>> +		return 0;
>> +
>> +	sysblock = opendir(_PATH_SYS_BLOCK);
>> +	if (!sysblock)
>> +		return 0;
>> +
>> +	nr = loopcxt_get_devid(lc);
>> +	sprintf(name, "loop%d", nr);
>> +
>> +	while ((d = readdir(sysblock))) {
>> +		if (!strcmp(d->d_name, name))
>> +			return 1;
>> +	}
>> +
>> +	return 0;
> All of this could be replaced by ul_path_accessf().
I will see how to do it in v2.
>
>> +}
>> +
>> +/*
>> + * losetup cmds could fail if /dev/loopX is removed by mistake.
>> + * This function will try to detect whether that is case,
>> + * if so, it will recreate the device file and open it.:q
>> + * Return fd if succeed, otherwise negative error code.
>> + */
>> +static int loopcxt_fix_lost_device_file(struct loopdev_cxt *lc)
>> +{
>> +	char path[PATH_MAX];
>> +	int nr, ret;
>> +	FILE *fp;
>> +	unsigned int major, minor;
>> +
>> +	if (!loopcxt_scan_sysfs(lc))
>> +		return -1;
>> +
>> +	nr = loopcxt_get_devid(lc);
>> +	if (nr < 0)
>> +		return -1;
>> +	ret = snprintf(path, PATH_MAX, "%s/loop%d/dev",
>> +			_PATH_SYS_BLOCK, nr);
>> +	if (ret <= 0 || ret >= PATH_MAX)
>> +		return -1;
>> +	fp = fopen(path, "r");
>> +	if (!fp)
>> +		return -1;
>> +	ret = fscanf(fp, "%d:%d", &major, &minor);
> sysfs_devname_to_devno()

This function only works when /dev/loopX exist. Anyway this part of code 
will be removed in V2, as Karel suggested we should not do mknod in losetup.

Thanks,

Junxiao.

>
>> +	fclose(fp);
>> +	if (ret != 2)
>> +		return -1;
>> +	sprintf(path, "/dev/loop%d", nr);
>> +	/* default loop device permission is "brw-rw----" */
>> +	umask(0003);
>> +	ret = mknod(path, S_IFBLK|0660, makedev(major, minor));
>> +	if (ret)
>> +		return -1;
>> +	return open(path, lc->mode | O_CLOEXEC);
>> +}
>> +
>>   static int __loopcxt_get_fd(struct loopdev_cxt *lc, mode_t mode)
>>   {
>>   	int old = -1;
>> @@ -303,7 +384,17 @@ static int __loopcxt_get_fd(struct loopdev_cxt *lc, mode_t mode)
>>   		DBG(CXT, ul_debugobj(lc, "open %s [%s]: %m", lc->device,
>>   				mode == O_RDONLY ? "ro" :
>>   			        mode == O_RDWR ? "rw" : "??"));
>> -
>> +		/* loop device file not exist. */
>> +		if (lc->fd < 0 && errno == ENOENT) {
>> +			lc->fd = loopcxt_fix_lost_device_file(lc);
>> +			DBG(CXT, ul_debugobj(lc, "recreate %s fd %d",
>> +						lc->device, lc->fd));
>> +			/* loop file is not lost but doesn't exist,
>> +			 * reset errno to have user know.
>> +			 */
>> +			if (lc->fd < 0)
>> +				errno = ENOENT;
>> +		}
>>   		if (lc->fd < 0 && old >= 0) {
>>   			/* restore original on error */
>>   			lc->fd = old;
>> @@ -416,13 +507,6 @@ static int loopiter_set_device(struct loopdev_cxt *lc, const char *device)
>>   	    !(lc->iter.flags & LOOPITER_FL_FREE))
>>   		return 0;	/* caller does not care about device status */
>>   
>> -	if (!is_loopdev(lc->device)) {
>> -		DBG(ITER, ul_debugobj(&lc->iter, "%s does not exist", lc->device));
>> -		return -errno;
>> -	}
>> -
>> -	DBG(ITER, ul_debugobj(&lc->iter, "%s exist", lc->device));
>> -
>>   	used = loopcxt_get_offset(lc, NULL) == 0;
>>   
>>   	if ((lc->iter.flags & LOOPITER_FL_USED) && used)
>> diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
>> index 0ca910ae3347..b45cc2ee8f3c 100644
>> --- a/sys-utils/losetup.c
>> +++ b/sys-utils/losetup.c
>> @@ -653,7 +653,7 @@ static int create_loop(struct loopdev_cxt *lc,
>>   		}
>>   
>>   		/* errors */
>> -		errpre = hasdev && loopcxt_get_fd(lc) < 0 ?
>> +		errpre = hasdev && lc->fd < 0 ?
>>   				 loopcxt_get_device(lc) : file;
>>   		warn(_("%s: failed to set up loop device"), errpre);
>>   		break;
>> @@ -741,8 +741,7 @@ int main(int argc, char **argv)
>>   			break;
>>   		case 'c':
>>   			act = A_SET_CAPACITY;
>> -			if (!is_loopdev(optarg) ||
>> -			    loopcxt_set_device(&lc, optarg))
>> +			if (loopcxt_set_device(&lc, optarg))
>>   				err(EXIT_FAILURE, _("%s: failed to use device"),
>>   						optarg);
>>   			break;
>> @@ -754,8 +753,7 @@ int main(int argc, char **argv)
>>   			break;
>>   		case 'd':
>>   			act = A_DELETE;
>> -			if (!is_loopdev(optarg) ||
>> -			    loopcxt_set_device(&lc, optarg))
>> +			if (loopcxt_set_device(&lc, optarg))
>>   				err(EXIT_FAILURE, _("%s: failed to use device"),
>>   						optarg);
>>   			break;
>> @@ -883,8 +881,7 @@ int main(int argc, char **argv)
>>   		else
>>   			act = A_SHOW_ONE;
>>   
>> -		if (!is_loopdev(argv[optind]) ||
>> -		    loopcxt_set_device(&lc, argv[optind]))
>> +		if (loopcxt_set_device(&lc, argv[optind]))
>>   			err(EXIT_FAILURE, _("%s: failed to use device"),
>>   					argv[optind]);
>>   		optind++;
>> @@ -935,8 +932,7 @@ int main(int argc, char **argv)
>>   	case A_DELETE:
>>   		res = delete_loop(&lc);
>>   		while (optind < argc) {
>> -			if (!is_loopdev(argv[optind]) ||
>> -			    loopcxt_set_device(&lc, argv[optind]))
>> +			if (loopcxt_set_device(&lc, argv[optind]))
>>   				warn(_("%s: failed to use device"),
>>   						argv[optind]);
>>   			optind++;
>> -- 
>> 2.39.3 (Apple Git-145)
>>
