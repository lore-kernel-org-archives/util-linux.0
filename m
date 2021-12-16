Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CAFC433EF
	for <util-linux@archiver.kernel.org>; Thu, 16 Dec 2021 08:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbhLPIrL (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 16 Dec 2021 03:47:11 -0500
Received: from mail-eopbgr00096.outbound.protection.outlook.com ([40.107.0.96]:40330
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232569AbhLPIrK (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 16 Dec 2021 03:47:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1SCLUYpe9DbWs3h8uNFOo7sDlqeV0SGGf4K48f6LrtS5VW1E+AFykKfgM4HL7tZs8gRRV03Rkag0E0PYygG3hkbvX/R8K9lYyWOOmoDj31lqOKD8cbgsiyxsCKNe08js4BolOwCA+A2uyv9HIlZNwvsDt3ns0g0lUfvOAq/vAf7R6Y/ymqqi1l6ug3d2PviM7n1fY6Dw93xP4l9iAe6apseIFd/YOB0zHeIfg9z+c01TjmDlRtSt25L6yzgaO9v9vqlaSszMFmS3ht/apuEV13rONHn1U+qHGTkJLyWf60CwE0Alq4zQAUrdLXnmNC7afsJeK6SqMHQ4C26Mz+naw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvOYeMDZ5zGmGULc6TX/b4XX34AohmV18a45drH5Js4=;
 b=d9Ma4dD4OtZxJ+4juwYumYs3c0dWOgcvIVM2GZpZU0GsW7+0XndJFBZ59mUaEGur22iv+YYjO1K8QIDMCqNGdElY/b919YE8yY8V6Kv3e79L3x5BLQw4MnZUc7530IfL1/2JLXWKp6T/P1Zz1b9xxeSFBqdprhMUQxpLb3ETf4eQbdZ27n3fgq0rD5QUg5F7uPbe+H4HrvVQKT/zye6xxsuzDshy2I4+KK06wIyrcOZruclspboOkS9ovxeB+RXwErKxtUQCaD+PYPJTFe7wSnhprTp6SdafIhL9/erNe8YQXp20km15NytAwds/+Xh12YZPwG/YTIkijoyjKn7xJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvOYeMDZ5zGmGULc6TX/b4XX34AohmV18a45drH5Js4=;
 b=DAr+8BRWQ+gJISg13T280sGjgemQe/sgwlw1jdHZeyJ8yxVLSAvieU0q7ezut1v9gwpiN60gCgcBAjnVM4c1Nie6egZ/t022OVVlsUF+l+Osa8H4QVjco6wcEXphhIYZhMNtg+issadXAORHaDv5+wSgPh00Y2WUuzAZ4I/m88U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB6737.eurprd08.prod.outlook.com (2603:10a6:20b:304::18)
 by AM9PR08MB6740.eurprd08.prod.outlook.com (2603:10a6:20b:305::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Thu, 16 Dec
 2021 08:47:08 +0000
Received: from AM9PR08MB6737.eurprd08.prod.outlook.com
 ([fe80::2078:5a2:1898:d83a]) by AM9PR08MB6737.eurprd08.prod.outlook.com
 ([fe80::2078:5a2:1898:d83a%7]) with mapi id 15.20.4669.024; Thu, 16 Dec 2021
 08:47:08 +0000
Message-ID: <9dc07586-5471-ee5e-fae4-e177ceb114f4@virtuozzo.com>
Date:   Thu, 16 Dec 2021 11:47:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/2] libblkid: reopen floppy without O_NONBLOCK
Content-Language: en-US
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, jkosina@suse.cz, kurt@garloff.de,
        den@openvz.org, msuchanek@suse.de, efremov@linux.com
References: <20211209141233.3774937-1-vsementsov@virtuozzo.com>
 <20211209141233.3774937-3-vsementsov@virtuozzo.com>
 <20211214120349.kntr7gza5flma5tc@ws.net.home>
 <a378a167-fd41-f74d-1b0d-b997b82df05c@virtuozzo.com>
 <20211215125605.4tg7ugdnlbb3i3v7@ws.net.home>
From:   Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
In-Reply-To: <20211215125605.4tg7ugdnlbb3i3v7@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::17) To AM9PR08MB6737.eurprd08.prod.outlook.com
 (2603:10a6:20b:304::18)
MIME-Version: 1.0
Received: from [192.168.100.10] (185.215.60.230) by FR3P281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1d::17) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Thu, 16 Dec 2021 08:47:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b23fb0d-19d1-4e6a-99a7-08d9c070a471
X-MS-TrafficTypeDiagnostic: AM9PR08MB6740:EE_
X-Microsoft-Antispam-PRVS: <AM9PR08MB67404A66E783702416C33288C1779@AM9PR08MB6740.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qa6BmKelb/o3EiJeJsyCKTbjp+gFxBc3Jsh5QZa+djpnGakT5EcWCD46C4LSwMcGhWdznovpjmxiA2NU/1rF5T9iS/2NXFoYh8Gvn2eBMgfxWX3BtwwbC8r2KrdFItXNwfHRWf/gPZQHl0NUpfaqhwND/K0N+fkv8HKUWgymAqdvLUVucs9caOQiKHy3d7xW3lA6/6AWgxy2k3v7o1h14FRvW9eZwikdn1u+aEsWJIaIdV/0FCroomQrzUe/PdfW/mP13AuCtMRnGDCj8b5ifjZfZSGrp78NsQ/iShP686Y2LOmzkdMXDbWA96RAt7twzpmNgUmz5vLHHF38vRHbW1chB1sJcr8OpM7LD+2xjUU4shGT34cTOYiiRUukbLvSS2z2j4jROp3zmtb1eo4cfBXJqQWgQQ0L2evOaQbBvCkR08kNQFPkXJpeclx2oBswsOAHIKlS9rkQg+RDA5gL7mo/RZkAf2c6T8vXxo7udF9a45kek9AjZIaTCI4BylpLZL7Mmj/0InfcRvuco8eDs/yYn4zQPTG5JrOH2PlIbzn+3wj5uWvWF5LSYBUnl516s+L3FMLM+4y21ljc01mIAu+TeMHIdclbH6l52AZg7RyvRfwzdeyOaFdQ1lChnJSoiA13/8uFN+SPosFm2LFXxapwjZseIvhV/5K94aL6n4pcm7NPg3+X0KhjMuWU1kEeWLKWbgLqvSkV6TEN7pUSHCRvVbcGCID9NB4p56coBQzdw139xeL4cK1mecZ1wfqMFZM1ze69nygsUYoAzu+uZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6737.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(316002)(508600001)(36756003)(38100700002)(6486002)(38350700002)(4326008)(956004)(5660300002)(2616005)(52116002)(66946007)(16576012)(186003)(8936002)(31696002)(26005)(83380400001)(6916009)(66476007)(2906002)(86362001)(66556008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmVFTkpzMnFMalFPdWRsM09aQ1NvdXFhTWNNU3ZVamJwWXVkMW16RlRCWWJL?=
 =?utf-8?B?VC8rL3l2a1VRdE9pM1pBNEZlcHJXWlZpQ0FtYUd4bmVpRnlUenRCSm1JSGJk?=
 =?utf-8?B?blhKTTRhc3NjcnJhTmI2a3FpK0JidUE1dFdrZjB0UVlGbzdpd01ydEt2cVNO?=
 =?utf-8?B?MEFaZDk5VStGSks0VWkxUS9pcThBRFAvU0dtY1Y2dkZHclpHd0IzTmhqb0tK?=
 =?utf-8?B?RE1uQStPN1FaU2h2WmZOSncyZ014ajJFQ3RhNXpBbC9CVkZZdUxOYnM4Skxj?=
 =?utf-8?B?eU5QN2JOL282SVpuM212NHFMbFVsZXdRUzlUZndkOExaSWxpNlQzSUhTSTBt?=
 =?utf-8?B?b0c1U2UyT3E3TlMrbjNraDE3akxGQmQ3clZSY0pkZ3BET0RnUlRqZWRoNDJZ?=
 =?utf-8?B?ZTVIQkdrWTZIL2RMT2t2TU1zV0p2dEE5a09GSDEwZUdKTWxRbDRJUzNXSk4y?=
 =?utf-8?B?dXhnS2ZMdEw5K2NmeUZPaFE5ek5ERU1UeUNmVFA4K1MzMzRVaUR1VDhvRldp?=
 =?utf-8?B?TGxNTWxGaVBEWTJsZnFjenBCUGpVWXRWWGpDVC9XVUhBVFhNd2JhYWxWcWQ5?=
 =?utf-8?B?MkxaWi90RWphVFBOVnFyK1R0WENpNjJKNlA2Mkh6V2hIQWs5U2Y3eTNIdVp5?=
 =?utf-8?B?WHE4N0tBenUwWDBVakV3NXplb0Viem9TK3kweE9laVg3UHJ6N3d0N1dZT3pn?=
 =?utf-8?B?Sm1Lb0w2N2VadVdIcERVS2VyRFltRnkxOVJMaFd3UDlwbnNtVkNEWDA0ZGk4?=
 =?utf-8?B?TU9jNEk1YVBGS2gyc0tUR0R1SERQSXlPOEJReDRWaG42amttRzZBYU55L1Ja?=
 =?utf-8?B?anl3TFVHbFBMVTV2bkgxMlE1K1MyT0ZuNE9MNkl5bEpEWitRWmdvSHR0WGJB?=
 =?utf-8?B?Z2kwTitmaVNxZk1kdzhIOWNtZk1IQTR2UlpSK095Wko5dStFVTdRSURwVFFP?=
 =?utf-8?B?eHYzd252TGgyeVZsWGtPckNqQnBhRU1rRHpNcDM4M1dCcTk5MVFZQTZSS2JB?=
 =?utf-8?B?UVp5NDYwbXJnVmNwaU1nMExTTkxLc0FJNGpTVWcwaHJBQ2VJM3k2Y2ZWc1Fh?=
 =?utf-8?B?VWNtdFBUVnJWNTE1MHllL1BFNVlMSUphVXpHOElWNSsrQ1IwRnhYczJNZ3lI?=
 =?utf-8?B?WUw5dUVOZ2JyV2V1NEU0YyswbzJ2STZpZ011dCt3Sm5IZXR1ZlJzdXlYU1NQ?=
 =?utf-8?B?TUtrblZBeGZxQTRqdGhDdUMxdWM2YWhkbVhjbldCZkM0TmxlRjlCK25IRGlD?=
 =?utf-8?B?OG9TNlcrd0NXWG9lcWZQczBSWUtaN1hTbGdlWVRtSzRyK29qbGh3RXlOTm1s?=
 =?utf-8?B?U2E4TGJWOU0yUnc0SlYvbTFFdE5VK2hpVVBudFZBVTMvRWtqYjI4Q2E4NzRo?=
 =?utf-8?B?R1JiRG5WU3VCSEUyU3dJZERQYnIvZ1VOeTVFUGVEcUdrelBDc2V4dnFuaWlx?=
 =?utf-8?B?QzdwOUh6aVd0ZExtYm5XRmJHS0YyaUxBYnI3c2g4WnBTU1ZTZkZSNjV6K0Z6?=
 =?utf-8?B?dzZIaUFRZzFPSFd0REVHRFNpVml1eFFTd0htc0I2UTBkdUxMcU9oNXB6bDJR?=
 =?utf-8?B?d0VxRk5nV01QWi9Xby9QU1lsT3RTUjBFLzBrMEs5eStpRlNYNFhUMjl4OG1U?=
 =?utf-8?B?MWN4Ry81dk4zKy8vSjBlVlhPU3ljRDU0TDBiMVVFbkxENGE5dHp1OUFZQ0dX?=
 =?utf-8?B?THd4aUduTEhLaEFjK3g4SUkraFZrU0NPVU93bDNDRmhNMUZYLzdyMnNFNjNp?=
 =?utf-8?B?d0pGKzZsbjRZOWd0SEZWOC81VjBXdnFFdEdpMlM5MmtuODRxWFgyeUYwVFMz?=
 =?utf-8?B?b3FlNDhFS1FCOHJsZVN6aDk5YjltUE5mSHEycUZOTHdjY0l1SEhoRnRPa09B?=
 =?utf-8?B?Z0Y5NWZnenZBV3ZPd1lZaHY1cmNwMWRjYVdwbGhzQXdWTXdBRE95WlJBVXJ2?=
 =?utf-8?B?Y09YR1QzSUx6N3FncnhUR0lvdFNtcm9ucWNNVzJMQkJqZ2JmQThXRHIydmt6?=
 =?utf-8?B?K0V3dzFaVDNHS3BlSmIrcnBWYzNoOURNNkF2Z1QyNjQyT2VFS05KdnZhNlRU?=
 =?utf-8?B?Vkdzb2Z0UzlYOVN2czd6eWdXWGZPYzJaUFM5ZHpHQmtydkJqdFVVWG53bHFD?=
 =?utf-8?B?MTc2SUx2TUcvRkpsQzZscFBlaHNBWUh6Nzdwc0ZOM2RVbGRFTytNLzJBVXZX?=
 =?utf-8?B?dHU1b3NqNFJiVk1aQUU5TEc5QVAwTjIxYUlNM2FrZDd2cjBwT01pLzVGZUkw?=
 =?utf-8?B?YTlZd21TdWR1cTdTT3BjcHp0c0FnPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b23fb0d-19d1-4e6a-99a7-08d9c070a471
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6737.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 08:47:08.0361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0nkR7O4lCcMasgjXtMeCDgg9VF4SgZMPeHw288cV+ZWXF3DFd8E68QCPFlKE/iKr2S24t7g3W/evK00gThLszhTnhI1sHdyaZvVZ4zq9z8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6740
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

15.12.2021 15:56, Karel Zak wrote:
> On Tue, Dec 14, 2021 at 05:24:44PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>> What does it mean didn't help?
>>
>> I tried it, but the bug remains as it was.. As I understand,
>> dropping O_NONBLOCK by fcntl just removes this flag, to change
>> further behavior of device to non-blocking. But it doesn't do any
>> additional actions in driver.
> 
> Hmm ...
> 
>>> The solution based on blkid_safe_open() means that we have to modify
>>> many applications. For example, systemd/udevd uses
>>>
>>>       fd = open(devnode, O_RDONLY|O_CLOEXEC|O_NONBLOCK);
>>>       r = blkid_probe_set_device(pr, fd, offset, 0);
>>
>> Hmm, yes, that's not very good :(
>>
>>>
>>> The same is probably in many other places (mkfs-like programs, etc.).
>>>
>>> What do you think?
>>>
>>
>> Maybe be we can get filename from fd reading it from /proc, then do
>> open() and than dup() to old fd.. But that's even more dirty to do
>> in a library call.
> 
> Yes, re-open() sounds like a possible way.
> 
> The dup() is not necessary. The library already support private FD for
> probing. See blkid_new_probe_from_filename() and BLKID_FL_PRIVATE_FD.
> 
> It's also often used when the library probe whole-disk device (when you
> probe sda1 than it also reads data from partition table on sda). In
> this case it opens a separate FD.
> 
> It's for floppies (0.001% of all cases). IMHO re-open is good enough and
> better than force changes in all applications :-)> 
> I'll try to prepare a patch and ask you for test/review. Thanks!
> 

Great!

-- 
Best regards,
Vladimir
