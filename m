Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1CAC433F5
	for <util-linux@archiver.kernel.org>; Mon, 17 Jan 2022 18:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242283AbiAQSKY (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 17 Jan 2022 13:10:24 -0500
Received: from mail-eopbgr70104.outbound.protection.outlook.com ([40.107.7.104]:60571
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241679AbiAQSKM (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 17 Jan 2022 13:10:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThJlRy1J45qduYXMDEEJ3Rn30B8rG7qrELLv7L87Vl5ed4ntbJSJQuvrjL+FDAtjnUtehoTnLFpota0unZczxQnPB2fTFrMiHBXfGy2KvF14rZzsDYAHftX38U4PtFAme+aAB3vTNHdjryEPLiKyet+jDmxsN6H7clo/CN4u/X+dqWMSWGwY4qNJx4+rL7ayehDc02HMKbTIwsWbFFqZuMNBbsPDtc7NkezYFumM2QxMaoift9vdbvbSwe8fYuBucPatRmwz+SxIEii3eqhazBx2Ta2d4xahraTCW9DraeBxiBf6dloTVUfkBT0crD+MkdCsZeykjlUL9cvEypk+Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wl7gSHKkWmpqccbd+T3qHZkSduaz1MjFxeqD7nOITk=;
 b=PRWKJYk8/ttXQa/WDBBNAg+vrLFZPj/8KlNAnHM0ry2dpRwYU2vl5NYPtchYpR+9ZHGOph42RXANa5EtgTEruwLS4OvYNErW89tyTDnz4YD/+aytW26jEdqLlmzSpTBQrEsI1S3QFiv1x5L9QhBIq+n8JGU49bA3mWpfL3pOESaGONEHlbUzGoV0C7JByRvTKh00ZLJNLze94kdLZaQVeLNPGc0GB86dok3ctq4ifxPtMN2PNlhLDjHJj9Ctc94NGcb/yPjBZKth6cUzgadV9BcszdcmuGfrUau0WZV6fSltR2sd/Lsk03PqNk50032vitIKie9L9S0kw0K3xs+Eng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wl7gSHKkWmpqccbd+T3qHZkSduaz1MjFxeqD7nOITk=;
 b=CDHoRYaC7uMZewnIbc4sNTC7uPgAxkmZA38x/IAoDSHWY464UdJpL+TRP8qat0jbyFOfCj63fbMF4T3u+kQ0168rrNDOqqpm4OL3KurV5Bt8MDjOz19A1dYq0YLBmNcb7Mma3LWKZCC9A0b0EELzQaN9wjgsYRcQjUJvo3/ZBtk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB6737.eurprd08.prod.outlook.com (2603:10a6:20b:304::18)
 by VI1PR0802MB2480.eurprd08.prod.outlook.com (2603:10a6:800:ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Mon, 17 Jan
 2022 18:10:08 +0000
Received: from AM9PR08MB6737.eurprd08.prod.outlook.com
 ([fe80::b435:c0de:ef6b:5917]) by AM9PR08MB6737.eurprd08.prod.outlook.com
 ([fe80::b435:c0de:ef6b:5917%7]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 18:10:08 +0000
Message-ID: <5db920b8-5df7-d968-5d5c-25d81615ad79@virtuozzo.com>
Date:   Mon, 17 Jan 2022 21:10:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/2] libblkid: reopen floppy without O_NONBLOCK
Content-Language: en-US
From:   Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, jkosina@suse.cz, kurt@garloff.de,
        den@openvz.org, msuchanek@suse.de, efremov@linux.com
References: <20211209141233.3774937-1-vsementsov@virtuozzo.com>
 <20211209141233.3774937-3-vsementsov@virtuozzo.com>
 <20211214120349.kntr7gza5flma5tc@ws.net.home>
 <a378a167-fd41-f74d-1b0d-b997b82df05c@virtuozzo.com>
 <20211215125605.4tg7ugdnlbb3i3v7@ws.net.home>
 <9dc07586-5471-ee5e-fae4-e177ceb114f4@virtuozzo.com>
 <23719c29-9668-1edc-e60c-a30bd821c7fa@virtuozzo.com>
 <20220103084311.beuxa6fcjtzn74a3@ws.net.home>
 <20220117115030.ci5z5jtgyl2clvud@ws.net.home>
 <2ed2e26f-7500-2ddd-a3b3-450f22ef6e67@virtuozzo.com>
In-Reply-To: <2ed2e26f-7500-2ddd-a3b3-450f22ef6e67@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::6) To AM9PR08MB6737.eurprd08.prod.outlook.com
 (2603:10a6:20b:304::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31a6e984-6953-4143-70d2-08d9d9e4988d
X-MS-TrafficTypeDiagnostic: VI1PR0802MB2480:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0802MB248087C85D4D90F10B55490FC1579@VI1PR0802MB2480.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V6+EfrSOESw3MU2ZEyfkYu9VJN7o0tpH395mSPCKDJLbyTrmEilDTfDNGrbto7wDvCbVhI+XT1Bjlwk4GaNMS2ETnG7VTrg8yQReQUt1qma8ezdwAAxe40QVdjphiNkkKhAEJGzNgIUJMbEEA9DllaYJ+1cNrOC6U4BPNzQO7w2HdfYR6yvbrUAq/b279nRpvggvnVr/TtgRlN1xF8oNdlnRZ+oHTIZo8kZaFfaWbshpy9X4uJc4bCYIZfD+42OZ3xY/nsELxc3PfZFc57Andg5ps/1cJrq+Mvmq8Kvg3Fnjc60ATOWOgvf1P9s+Akj005YRFQ7msS1S8yfaNJ/rDIeLao6veAyrjh05IABq6AjTq0kRsrwVtd8ml9A1YyeYN7AmAxwydBCQawVXcJ4nFDd/cOgKK+nJU9htBvn4X3X066otz7FW3tne09qv8JgbCC5WGS+fsEgJsVcz6vTy1nMS3Or7Lours93zYkZ+u7hNMCTtaWQEduvZKoK8s0aigcDJkgtBrc2bd3NfYueroEZQRv4X+YizYDJ4SQycIQjRCqejZo5Yl5kfBuyEw6LkatwReTpd8FFCzddUCdpkzIQUK2889LG8uHpVr3sKd+qBoxLeh3w/vppQ2FUy3KEUyK6s0Gh64yZOHU/kFceGgWmQKa06CsPSn2evFFaPgvqpwQvJuTTSesiesB0rPds52OsLmARRRbLTPTJeCn4JaBcGbjPBfDtLbpiARopw22cd1jcV1Yjr+wyI+vEks3EkK6Lm4CoXbZxk0nCbOifwPl1H2EbkCGzCfB7OBq21bbF1ZXxvF2jLIYBAK0MEb3o1eB4tLMDkhiom7vY2eaxdw56iX0Pj9Z86UAsbREMnikI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6737.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(26005)(2616005)(6916009)(186003)(38350700002)(38100700002)(4326008)(6512007)(6486002)(8676002)(8936002)(966005)(36756003)(6506007)(53546011)(31696002)(508600001)(83380400001)(2906002)(86362001)(316002)(6666004)(52116002)(66556008)(66476007)(31686004)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTRzbGllYjdhUlhJdVhIa09nd2VoeWRsQzBGZnpwVkk3eldSajFtR1NoeHJR?=
 =?utf-8?B?US9DLy9qSGpjK3dDOVNhRXh3TEt5Wk9udDVuS0NxRW12Y2VkRzg2clNia1Fz?=
 =?utf-8?B?SURvcW5EQXFkcisybk1EU3hYc25VQkJER29Nb0xlQTI5ODVJQUwwNGxnY1hC?=
 =?utf-8?B?bFJ3WFZYazIzNFJJK2hWT2VjRVB2TU1pODB0eGRCa0Zjdmw1VzNNUkowa3hX?=
 =?utf-8?B?UVBrNGZiZHpLOEU4cUcyek9lcTRhanZnc2R6STZoL0I3SEltdFFzeTFNU0FQ?=
 =?utf-8?B?TkRwOE9MNXdOQzRiTHdEakExZWh3K1hwNW1vVk91R1ZTSitYOFVpTEltbFlp?=
 =?utf-8?B?Y3NENHcvNWtpWUhxeUJjVzZEcEphWDRKOUhydm5NY3V5LytuQzNOTjRtTDJG?=
 =?utf-8?B?WlBaR3pISVl2UlRrckxCM25QZGRKT2t1bmNhcGpHUmhSK1YxN3NLSFk0NWJ1?=
 =?utf-8?B?VUwvTEFGeUpxaGtjZmFSVUUxWlhld25xTGYzQVl2dnF2di9HeVN0cm80eVh3?=
 =?utf-8?B?RXloc1NBa3N1aGxCMDhJRlJiU243RWFGWlgwMTVwSDJkTVJKRUlhQWtYd1gw?=
 =?utf-8?B?RTJYL0ZhM2R6bFFycGZSTEwrUTNabGVwcnhWQXUzOElreCthREt2NVVueHlv?=
 =?utf-8?B?enRJaHhJdWVkd1dtQzNBL014b1Z4bGtaSW53Ky9VYUhyRHJVcmVoalFYNXd2?=
 =?utf-8?B?dmZRRVdwalhlMTh5alBhcGdMVitJbTFQcUtHU09oRGRnYjRNL2VtUG4vRG9I?=
 =?utf-8?B?NlVmeUtycGk2STdCb202WjlSc256Q083YW5XWTFmZ1J4ZmpsTldCbHVhY3Yx?=
 =?utf-8?B?SmswS25IMVhNV0tZSzduNlFQZFJVQ0p1SE9rT3RBZWRTVDFHUUFhSFN4Y29o?=
 =?utf-8?B?NlRRZHhCZjJIbjRnVllVU2tZdkRNanFMYVdmSUZ2cExySk1UK3lyc09SRnor?=
 =?utf-8?B?K1VwcFRwOVlrOVFjV1RXUXZURHg0N2FjbnJtd2VURk1mSHhIQ0c1Y081TUE3?=
 =?utf-8?B?R2lPNXRvcjZsK3FIanVLZ3pnQUF0bUxFWkhobzA2bzV5OEYxRy9BZE5IZG1O?=
 =?utf-8?B?Z0h5eU5YVW9FSHJBU0VuSmZTTTlRM2FjdmFtUkhJY3VJd2xnR1FFU0w5ckJw?=
 =?utf-8?B?ODBUbDhIQU5SSmZmN3Y2bGZ1K0lnVXBLZkRHL2RtN3oza250NlR6NWdvNlE0?=
 =?utf-8?B?WG5RT3V4NElVSS9BcTRKQ2xXWTZEWENkV1FJWHRaaG9FQlA1c1BjNllqWmtx?=
 =?utf-8?B?UFNRb3FZVklkT2QvMnFvSlJmQU02TWE0dUhBSU5SUkRRNkR0SmY4WUlTK0JC?=
 =?utf-8?B?YWJGenZaRXdWRGdFSEJ5MUd5MlFiUzZGNlNIOUxETTB5MkVVTmg2NHFVZEJz?=
 =?utf-8?B?a2tMSU5LbkZFclJFUlRjZUt5eDBpa2FtOHV5WkxhaGUwdUl4OHN0ZzhhNDN2?=
 =?utf-8?B?ZVljOS9ObFZtUnVmY3dCNTUvOFRNZFhGZlZjR25CL3N1dFpmSDJwTWVnVHp4?=
 =?utf-8?B?emJvS1FvdE96V1Blb1Fra3ZHRUhFT24rbXVnT3NwRFp1eE9TUE51ZG9heUVn?=
 =?utf-8?B?NlNyNTBVMXhJZEN2YUlScHhldDZPWTZGRWxlYXluUGdhOERyTjVIbWUrZUNI?=
 =?utf-8?B?OWhJL0ZFUkw3ZEdFNXRBMWpuWDVIcTBDTlE4ZU1hNEZsaXdKVE5WRHVvRDN3?=
 =?utf-8?B?RHUrWjR0d0poZ1dMckVGQXlKYlk0YkFmQ043dlRjbFRTZ0I2QUZSbHRTNi9n?=
 =?utf-8?B?STNGSzlhL3dGYXJGTFRPWWZwbG00NkVzZ0lEc1AyYXNDMnpxemRGRVpzMUN1?=
 =?utf-8?B?UkorWVJBNE0zZVlzaVkzUXlpU3JJdUVmY2FiVjE5T0VteFJwTGxvWkRUWDU4?=
 =?utf-8?B?d0EyUGhDeUdvTVNpZGE3Z1g2YTJFcHJnR1hYQ0Z4bXJDdGlXT3JhRnJ0ZU44?=
 =?utf-8?B?Q0R3TUpNTkQrVTdzZC9IcnBGenEzQjJOZ3h6MG1KMzZDVm5ReHdhNWNXNnFz?=
 =?utf-8?B?UjdiSEREVU1mZkJTTzNwNXNTeHdMRFlsLzZhai9Ia2FhZTFYczd6YXRXQUJ3?=
 =?utf-8?B?RkIvdDdoYkptVndYZndISEZNdkw4eUhXYjMyMW5DVXZ2OFJTREVZV21wOXc3?=
 =?utf-8?B?WjNvd0NZb0wvekdkTnoxb0syT3NyRkdBYTBLYzlQUlMvWEk2SUV6U2hYTHpD?=
 =?utf-8?B?eENWVFE1MC9Rb05lMEZxTlV3UkhSKzlHSUMvVTF3ak1Ia0xuZTRTRnB2S0pX?=
 =?utf-8?Q?YX/DsAttryb4d3tKQ2002sb6OcpXRdiTTeOz0Kei3A=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a6e984-6953-4143-70d2-08d9d9e4988d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6737.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 18:10:08.7937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d8d4yDCCbgRCTofCFt5sdBDCfh84/IPHMTanIMzU19hamuXtBtZ40N60VsihhHKAM18QvHwhl1kpRSxLfc4AUTCZAXPR8eU0oaDGAUmcsXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2480
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

17.01.2022 18:46, Vladimir Sementsov-Ogievskiy wrote:
> 17.01.2022 14:50, Karel Zak wrote:
>> On Mon, Jan 03, 2022 at 09:43:11AM +0100, Karel Zak wrote:
>>>> Hi! Are you working on this? If not I can try to make a v2.
>>>
>>> I had a vacation in the last 14 days; nothing is done. Go ahead if you
>>> have time for this task. I'm going to work on something else this
>>> week.
>>
>> It seems you're busy with something else ;-), so I have implemented it,
>> but it's not tested yet.
> 
> Oh seems yes ;) Great that you've done it!
> 
>>
>> Please, please, can you review and test it with your environment?
> 
> Ohh. Will try to remember and restore the environment this week :)
> 
>>
>> Thanks!
>>
>> See the patch bellow or topic/blkid-floppy branch on github.
>>
>>   Karel
>>
>>
>>  From 49be1b256ad351cde2e0cf5000c7046e7010cc02 Mon Sep 17 00:00:00 2001
>> From: Karel Zak <kzak@redhat.com>
>> Date: Mon, 17 Jan 2022 12:37:13 +0100
>> Subject: [PATCH] libblkid: reopen floppy without O_NONBLOCK
>>
>> Vladimir Sementsov-Ogievskiy wrote:
>>> The commit "floppy: reintroduce O_NDELAY fix" was removed from kernel,
>>> so we faced the bug described and discussed here:
>>> https://bugzilla.suse.com/show_bug.cgi?id=3D1181018
>>>
>>> Discussion in kernel list on reverting the commit:
>>> https://www.spinics.net/lists/stable/msg493061.html
>>>
>>> In short, I can quote Jiri Kosina's comment:
>>>
>>>    opening floppy device node with O_NONBLOCK is asking for all kinds
>>>    of trouble
>>>
>>> So opening floppy with O_NONBLOCK in blkid leads to failure of blkid,
>>> probable failure of mount and unpleasant error messages in dmesg (see
>>> also patch 02 for details).
>>
>> Based on patch from Vladimir.
>>
>> CC: Jiri Kosina <jkosina@suse.cz>
>> Reported-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Signed-off-by: Karel Zak <kzak@redhat.com>
>> ---
>>   include/fileutils.h  |  3 +++
>>   lib/fileutils.c      | 17 +++++++++++++++++
>>   libblkid/src/probe.c | 33 +++++++++++++++++++++++++++++++++
>>   3 files changed, 53 insertions(+)
>>
>> diff --git a/include/fileutils.h b/include/fileutils.h
>> index c36ce6353..8722ed59b 100644
>> --- a/include/fileutils.h
>> +++ b/include/fileutils.h
>> @@ -97,4 +97,7 @@ extern void ul_close_all_fds(unsigned int first, unsigned int last);
>>   #define UL_COPY_WRITE_ERROR (-2)
>>   int ul_copy_file(int from, int to);
>> +
>> +extern int ul_reopen(int fd, int flags);
>> +
>>   #endif /* UTIL_LINUX_FILEUTILS */
>> diff --git a/lib/fileutils.c b/lib/fileutils.c
>> index 7a8fce26f..5b15d4916 100644
>> --- a/lib/fileutils.c
>> +++ b/lib/fileutils.c
>> @@ -288,3 +288,20 @@ int ul_copy_file(int from, int to)
>>       return copy_file_simple(from, to);
>>   #endif
>>   }
>> +
>> +int ul_reopen(int fd, int flags)
> 
> "reopen" sounds a bit like we are going to close old fd, but we don't... No better suggestion :(
> 
>> +{
>> +    ssize_t ssz;
>> +    char buf[PATH_MAX];
>> +    char fdpath[ sizeof(_PATH_PROC_FDDIR) +  sizeof(stringify_value(INT_MAX)) ];
> 
> Extra whitespace after '+'
> 
> Also, I think you should add +1 for '/' (you use it below), and +1 for finishing \0.
> 
> Or alternatively we may just use PATH_MAX here too and not care.
> 
>> +
>> +    snprintf(fdpath, sizeof(fdpath), _PATH_PROC_FDDIR "/%d", fd);
>> +
>> +    ssz = readlink(fdpath, buf, sizeof(buf) - 1);
>> +    if (ssz <= 0)
>> +        return -EINVAL;
> 
> alternatively you may return -errno on ssz < 0, and assert that ssz > 0, I hope 0 can't be returned.
> 
>> +
>> +    buf[ssz] = '\0';
>> +
>> +    return open(buf, flags);
>> +}
>> diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
>> index 6168370e2..d69ff530f 100644
>> --- a/libblkid/src/probe.c
>> +++ b/libblkid/src/probe.c
>> @@ -103,6 +103,9 @@
>>   #ifdef HAVE_ERRNO_H
>>   #include <errno.h>
>>   #endif
>> +#ifdef HAVE_LINUX_FD_H
>> +#include <linux/fd.h>
>> +#endif
>>   #include <inttypes.h>
>>   #include <stdint.h>
>>   #include <stdarg.h>
>> @@ -113,6 +116,7 @@
>>   #include "sysfs.h"
>>   #include "strutils.h"
>>   #include "list.h"
>> +#include "fileutils.h"
>>   /*
>>    * All supported chains
>> @@ -907,6 +911,35 @@ int blkid_probe_set_device(blkid_probe pr, int fd,
>>       if (fd < 0)
>>           return 1;
>> +#ifdef FDGETFDCSTAT
>> +    {
>> +        /*
>> +         * Re-open without O_NONBLOCK for floppy device.
>> +         *
>> +         * Since kernel commit c7e9d0020361f4308a70cdfd6d5335e273eb8717
>> +         * floppy drive works bad when opened with O_NONBLOCK.
>> +         */
>> +        struct floppy_fdc_state  flst;
> 
> hmm, extra whitespace?
> 
>> +
>> +        if (ioctl(fd, FDGETFDCSTAT, &flst) >= 0) {
>> +            int flags = fcntl(fd, F_GETFL, 0);
>> +
>> +            if (flags < 0)
>> +                goto err;
>> +            if (flags & O_NONBLOCK) {
>> +                flags &= ~O_NONBLOCK;
>> +
>> +                fd = ul_reopen(fd, flags | O_CLOEXEC);
>> +                if (fd < 0)
>> +                    goto err;
>> +
>> +                pr->flags |= BLKID_FL_PRIVATE_FD;
>> +                pr->fd = fd;
>> +            }
>> +        }
>> +    }
>> +#endif
>> +
>>   #if defined(POSIX_FADV_RANDOM) && defined(HAVE_POSIX_FADVISE)
>>       /* Disable read-ahead */
>>       posix_fadvise(fd, 0, 0, POSIX_FADV_RANDOM);
>>
> 
> 
> Looks good to me. I hope I'll be able also to test it soon.
> 

OK, seems that works (I tested the branch topic/blkid-floppy):

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


-- 
Best regards,
Vladimir
