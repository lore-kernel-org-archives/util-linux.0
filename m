Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DB5C4332F
	for <util-linux@archiver.kernel.org>; Wed,  1 Nov 2023 19:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347381AbjKATyq (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 1 Nov 2023 15:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347371AbjKATyp (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 1 Nov 2023 15:54:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049E5110
        for <util-linux@vger.kernel.org>; Wed,  1 Nov 2023 12:54:42 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1HiluB006462;
        Wed, 1 Nov 2023 19:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=u3gfzdFxhm3uY/uI1MxsU4+UOg6sCdv8xvKX7EEytp4=;
 b=vu2ci0VRokMbKlwFj4GIQwJb55aqrj675SqJGzTADC6p8bivgwK/S2+uhJMrJVW5XyiQ
 e+03PtHiVIehdd6Dc8LwUtaH6g4KbVbB0ao5o7huPWRz2tx5ZIK4E7XiLbIFik0bzVth
 hhj8YOf8E+vyFDK/tdDXLT1kNPgwjm3tO2+mayzpklVziteKHTxSP1VYi1L8Ie9iAbYW
 x4H2PMZnMmIsR5nME9J3pFwGUQHU5neQP/aSF2i91n5SYA8ZHHqrbUlboKynXPC1sjVW
 9dMxlr2d/U3JSUFdZCYfe+u2fcpEyUMy2Ha6bBvGIBQWaxQZ9+D/RpUBQbkZjLfRJ3hK rw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0t6b84f7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 19:54:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1JCDne001116;
        Wed, 1 Nov 2023 19:54:27 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr7vn0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 19:54:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1QFomTU3QTA/PcFQzXARGxh1+DEupEo9pAoRI1AI1XUOiSIfwaz5/RnMKj0GxYo1pAk76t9lK7nngv7+phxUJGwEwi+Drdpv08jjBY0FZVk7KwfGtZV2y9nqpR07AA335XF4v7s7MN7m57PG1KZVgG0A4VNgoeD4eiZQeB0e7tJlApqrHpfJ43PEmcQxhS28J/0bkla6N5PReDGGhQGlMF21wg8zKpzUaxkMcnh8sHEX0eVpVoVXm353WQDAeaR52LOHShjO+XD9oiHLvy6N19y4xQasSjUWPsTN8wgPZiGtn9TNWiUz4srn7WXEzdBdnRZ+9WIMiL2LxWIBFM9tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3gfzdFxhm3uY/uI1MxsU4+UOg6sCdv8xvKX7EEytp4=;
 b=G+zBxVSA4ict6sdI0bpZAvbpZOcXIXIMcwwfmAkaTKDi4APrePL+7tJ2BOuajkj0H5ny0AverimcB9r5y/dctCEBwDPWrS+tw6AUeq7AXHw29nTjf1suXFWYMcsItrJHn7OCTErBq3jsBBhFeGAagbRsrgsoakcKyNyn/fFMOmXTLMjPNA3SLAokWyvMQEdIC4GvBDSiWDQXSqAfGH4mKyVRMzsCA9A4/CpPU0sslie4c6IIzTNyoH/uhy5k56YmgUSp3Y+CckHJGsmwsnVfueb2U7dVK5UMkyUlEM8cdNZCm3tr6LPGti0VsuaQsIkbDDokEiPr/Q06epNN17OKbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3gfzdFxhm3uY/uI1MxsU4+UOg6sCdv8xvKX7EEytp4=;
 b=w5K+wx9d+X1GqfmUT3J9tD3kdpIsMIt8wgOmm/8+fZZ+UdG8ZLZFVQ+ZVcLnfl7nksTCCGuJZ+StAo8DhYjMi0Uq+zLi0EX9lBYAW3OYG+qyK/2JGmiwcKkUwZS5PX8avGsXm3iHeT9tOyca48jcFM0Dgbqs3bVO++HTDWd27Lc=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by PH7PR10MB6986.namprd10.prod.outlook.com (2603:10b6:510:27e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Wed, 1 Nov
 2023 19:54:20 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::915a:381e:a853:cf7f]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::915a:381e:a853:cf7f%3]) with mapi id 15.20.6907.032; Wed, 1 Nov 2023
 19:54:20 +0000
Message-ID: <00af5617-923e-41d8-8b23-60178bb6db7a@oracle.com>
Date:   Wed, 1 Nov 2023 12:54:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] loopdev: report lost loop device file error
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, thomas@t-8ch.de, dsimic@manjaro.org
References: <20231025203603.48584-1-junxiao.bi@oracle.com>
 <20231101115540.eqz6q3prnqhi43y5@ws.net.home>
Content-Language: en-US
From:   junxiao.bi@oracle.com
In-Reply-To: <20231101115540.eqz6q3prnqhi43y5@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0170.namprd03.prod.outlook.com
 (2603:10b6:208:32f::17) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|PH7PR10MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: f5324cda-fdc7-4e48-cf8d-08dbdb1456a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PnWdZDgId6ZHwvSeTxcOcMg2umzuAuzBvDuKWwcvoPMdWhJJFI5wmoXcfkgj0YLuK8mYJglFEHnJAYVM4RD5nkXoxrGlrr2UgMKXlOVcaSCIs4dFm/esRa09VJHO4g6T75xbVkDKrfNfTkZzAep3G74UzwRkAiEa9PVBSx263ru1ea2LzzNr9xM2sQzcQD+eZzT62tk4J86jPzJuRG8CsJrBWUqnE9Td/y3J5LCF9Qrj1FKwngJstzrb9fhWt7qUqpf5A+A96Z/BhQxCbM6cONPIazNBHqsRNBv5Q0555MsOTl6cW9wlk97Aj8RovNv8Q3tXwdLk+vCfs0HqqudZhLbvYd82UzQ6Q2hS5aTLSobVyWsOU7prC4P6i1DKU0PMYy9ovDXc6I4xOH1hWWUzOTIo1Bd42W0Uw9ezUWYsM6Z2aW28RM4ArLitYlL7muk4LZlnoYueh6mcpHio77QKOWxyoZlQAu1gDi+wyK3dW7Co9iZG7Ulmg7aW//gbKDtyiFL5h7K4IGSn3nbMkjDrDxwEfmJtANl9Z0i7I1CmFo5g/y6oZEgjUz4vIU1E/62pZpTx9Cbm+PKTWzvhdRumFhSuzMss+aIZKEO2sfrAuvaorrrN1AHC4rRJss8TRh+ShIt07noRaXj82qihZrsw2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(136003)(39860400002)(230273577357003)(230922051799003)(230173577357003)(1800799009)(186009)(451199024)(64100799003)(86362001)(966005)(6512007)(2616005)(41300700001)(9686003)(26005)(8936002)(478600001)(8676002)(6916009)(4326008)(36756003)(66476007)(316002)(66556008)(6506007)(66946007)(6486002)(6666004)(53546011)(5660300002)(2906002)(38100700002)(31696002)(31686004)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0FCdnA1cmU1ZjJtakJIRXBIQ0ZkVWRyVHhyRUxQUHUyWVB5STVzSnRuaHNt?=
 =?utf-8?B?TXBFSlZKbzJUR1ZtU2JvTGpZSjh6dzBYc1hsZGlITGV4UUJSZm1TSHNkUWdU?=
 =?utf-8?B?T0ZxMU1PR1RadThVV2lZbnIrcXViS0k3WDYrVVNySHdmWjl0cmxmZUtYUVNi?=
 =?utf-8?B?dmNrZjJqaXBzemgyakFaMXR3ZDNxZE5DcVp3Zzl6ZWFsRlA5ZExwdHJ6T28r?=
 =?utf-8?B?K1g4UGdERDFQaXZ0cGZ0SnBiNWR0ek15a3FRVDFuVXZVWnVkOFVYamI4QjhJ?=
 =?utf-8?B?OEJNMjF2U2RtazVKenJmZ0tyL2FsRVhneUk3QWVOaldUeFVUT1BCT05YRE16?=
 =?utf-8?B?L1JOZkJWNGwrYzFLSE1TRWZabXk0Y0RJTHUzQ2R5eW55LysxQXBHUHJORUlt?=
 =?utf-8?B?V2JoYmt5N09la21HUlFScVNQcjNwbnJlUjlSMTB1ellFeGVma0NIU2dJME9Z?=
 =?utf-8?B?OGFzVmV6Z2FKWlJjbDlnNm9TY2FuVDZPWHYyQWpxYVZxdmtYd2FLQWtOV3ln?=
 =?utf-8?B?Sk01d2FjaWc5Ly85Sm8wc1liMjVLd1dEY3lqZ01nNC9ZUXppenNLdnRYK01h?=
 =?utf-8?B?bTM3T09Kc1hqWE9KajhCaGluMUlRNXc2bGNvUURFR0JaL0NndzVJVjlMTnJT?=
 =?utf-8?B?NEpQU3FjRU9nQ1ZLbXpUai9vQWh3U2xFNE1wN0hQZ3hrNjdMSTYzbTZzQkJm?=
 =?utf-8?B?ZFlHdWt3QUdCNmtyZzhvdG5ZNG9pd25lKy9uYjFZQWVmS0FWRWNwSmhkb2Fk?=
 =?utf-8?B?TTRyV1FkRTVlS3dQbkpCdzcvRXViYmJjNXRlNUo4c201T1BkWFhMUnhIOWRs?=
 =?utf-8?B?bmlLUW92ZWVNK0RnOWRHTzJrR3c5WXJ2MEh0Z1hIYzRwcW5URjZDOG1Kekdt?=
 =?utf-8?B?TGswQzh4TFhQODZJYTlDSDl1b2hPNjg1UmdNUFpaemJJelYyQTVCeUhmWTNv?=
 =?utf-8?B?RG5oQ2wyczZEb3AyUFM1bTd0VC9BVGNaSGxhMDJVV2dVeW9xb2hlWUxNbFRD?=
 =?utf-8?B?RFRnQnRzQWpoU1lROC9YemtqSGZzRzdDczhjaWF0a21yeFlGWUp0Y1NSMWpO?=
 =?utf-8?B?VjVSaHJVY3V6T28yM1pQNDhvQU1SblpodmlISUZVZ2pYTEVrcmwxcEZCbVVW?=
 =?utf-8?B?aCsxU240blovZ0ZUSVdST2UzcDVZSzZhWjNScUdtNFFnMUFEc0JJQ1NJSUdl?=
 =?utf-8?B?RGt4WmFTTis4aWZuWlFvajQ0aUsxemxSSkhnTnBxTEt2dlpDVGRvZE1Edk1q?=
 =?utf-8?B?dWpqckpVcDNlbmlKRmJqaE9WbzBCTnVSWUtqUHgxVFk2OXRwSTh1ZTN5eTM0?=
 =?utf-8?B?QTJaU0d3YnBLR3ppZ2QralI1RUdQM09URkdNVTRqVG1La05XR1F5S3pEVHMr?=
 =?utf-8?B?dzVVVERWOFN2aDhDdmVidTljcHE5VGwvRUpyWEF3TXVVelV2YnZsZ2EwNmNi?=
 =?utf-8?B?OVE3MTlLaUc4UGhQUGdzZVJFL0hNb3NGMUR4MEZDZytoaGYxN1dxbHFYWXcv?=
 =?utf-8?B?emlGWHpGTjZTaUt1YU9kdm5FNjBxYUpjc2NsbklRb3RQellXb1pFcENINk1l?=
 =?utf-8?B?ODJlRHlLaXp2UnRaZXpFWCtZZ0JjMFJiY3N4M0pKYXh5bWlVSm03ZlNKNTBX?=
 =?utf-8?B?UHczUktYSlgyOWEwcld2Zy94d0IwbG1wMnpPZmQ5Zzh6cGZVdEVBMmlVeEd0?=
 =?utf-8?B?dmtLSXR5eGdNdGZnbVIvcEp3aXIwR2FxQU5jUFJrd0NqSFhVamJNUnpTaUlu?=
 =?utf-8?B?am5GZDNjUDZMQnJFT3BOazFiMDVQcVNLaC9EZWErTW0yMytwMUxzSVp3VWJL?=
 =?utf-8?B?S0psSCtpbVIyQ2Nwa3hLbW44S05VdWcwb0VVS3R1RlFFcXh6S0xDZFhtQmt2?=
 =?utf-8?B?akVWeVN6RGh1Snh2c1Z1RVo2VjFqNHY2QWxENFlRY1RQSldVOXlNSG9jVFRq?=
 =?utf-8?B?WVZJUlV1ZFBsRVBpVTh2QXpseE9iREJwSGlkY0lMMDRRdk1hOUlyUEhXb015?=
 =?utf-8?B?Y1dlRTNvNlowZGhMQUFURDc1SzVZeVpBZnpUcC9xUlAyRXRKbldzQUNsMDJX?=
 =?utf-8?B?TFZURnFpeThmK0IxY3BheFFDZi9pSERLblBOWkZwbEp3UzBJUEJRYUZ3YU8y?=
 =?utf-8?Q?hGPLh+YNnQ2bzJ9zLyeXYDKwo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 15f2spOQP99cUMzu7ke04TE916u+u7xenghhYlGs5iDTOxlTHewPYtPplAyw3CIN6Ck5bMHL+oRIWyRIpvQIR+gKt/j3mmQNP72YMQoofxohqVRn6kuGJKIdBarczKtIQoVV6Wbw5mKplPKGr/nWnkBd94e4LVFk+MG2abVTO1EgaXaUzx/kIl8XLYCGWVc9PYfifnTR5z5QX6qli/KWp24gVf+y6Pj0gyaZKN/n9Hmnfb4YfSrc/U9CHhiqB7imBz0T3BXQ3prKKUi2i+Y6/aEtwxHgllU1v6bPsKn5u/vZRNsqgGEox1PxUU7jE/3AwC7L75jLskQk+n2MlB25TtGhOZwx+XWUNj7ANlqq6aP4m1Mn8i5QmbeI4D33Dp4NJxiGbCWUC9NU3td/EQTSLNFjoJRsnCo61VErWLsDb8TLwkEoXZSv/pgd4d2Go+ZBNdwHEIlbcbcx4Dvr+/6Heum1RRYyvIZT3AEBb5XG7yLXC14VCCsimxMwSSYVeg9sNfyZLlGmnC0tYAH+kmtc2ZdmPjW5JNk1GJoO4N584NhmMNuHHiYlyhTonLAudFttK5azOtGV3DxiyhADid/RdXaRqeHR8L2MaO+gxgg8CcabSXl48jpwRB1dG2X49u+RGKjofGZrjF6bJEIU0rDQ5ep6y8JVBUh+B5D1zFllmzIfgssGMjJId8yuP6AWA7Z7cK3U8uCUwx4MZue8CWMhVFnShlImsW5zjeLG7h7qi8V0+1n1yxrmSsJLQuYQ46tLonB0PxijrF0OspaNhXm0+nChggbEa8qx5ApK1Pry+I2bG25axd6deUkCD3NA/CG9GuXIi0Aj7gSNwk/pxwFm708780AovBUqGvfXpyYJ60U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5324cda-fdc7-4e48-cf8d-08dbdb1456a1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 19:54:20.4872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MpMxxoOuDvz8YusbZh9vkrh2wwiOMpfF552E3Qmh3qMQ2toxtmWL2R5wNUst8PTDe6LN6fBT+eVkd2gEuuTeZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6986
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_18,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311010147
X-Proofpoint-GUID: 0iia7cSnscZ3xjgjSvJr3DC5JzE1khJd
X-Proofpoint-ORIG-GUID: 0iia7cSnscZ3xjgjSvJr3DC5JzE1khJd
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 11/1/23 4:55 AM, Karel Zak wrote:

> On Wed, Oct 25, 2023 at 01:36:03PM -0700, Junxiao Bi wrote:
>> If a /dev/loopX is lost because someone might have removed it by mistake,
>> future losetup operations on that loop device will fail.
>   Thanks Junxiao,
>
>   I has move aggressive with the changes and there is result:
>   https://github.com/util-linux/util-linux/pull/2566
Thanks a lot. The changes looks good to me.
>
>   For me the most important is to report used devices although there is
>   not /dev loop node.
>
>> +static void loopcxt_scan_lost_device_file(struct loopdev_cxt *lc)
>> +{
>> +	static int scanned = 0;
>> +	dev_t devno;
>> +
>> +	/*only scan sysfs once for losetup cmd*/
>> +	if (!scanned)
>> +		scanned = 1;
>> +	else
>> +		return;
>> +	devno = sysfs_devname_to_devno(lc->device);
>> +	if (devno <= 0)
>> +		return;
>> +
>> +	fprintf(stderr, "%s is lost, run \"mknod %s b %d %d\" to recover it.\n",
>> +			lc->device, lc->device, major(devno), minor(devno));
>> +}
>   The lib/loopdev.c code is also used in libmount, so it should not
>   directly print anything on stderr. It's application business to print
>   the warning. I have moved it to losetup.c

Should we patch mount to report that error? with current patch, it 
report this:

# ./mount -o loop /tmp/test.img /mnt/
lt-mount: /mnt/: mount failed: No such file or directory.

Thanks,

Junxiao.

>
>      Karel
>
