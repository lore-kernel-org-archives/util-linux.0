Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71DBC433F5
	for <util-linux@archiver.kernel.org>; Mon, 17 Jan 2022 15:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240627AbiAQPqZ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 17 Jan 2022 10:46:25 -0500
Received: from mail-eopbgr60111.outbound.protection.outlook.com ([40.107.6.111]:12357
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237369AbiAQPqX (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 17 Jan 2022 10:46:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=och//gfrvI8atBIxGCkEc3sNCI4Bb5EHI/C69zZZ9YIqbfIQ/HG5tJlmnHYLKtzLT53NQ6C3gGLAsb+69Y1gvq2LWoO5iFGjTFg2BlU62UxDrgVA+5NqBM6iX600CrMjfqkiLmfHlLnuPlnJRZNer6NnZQNqSdv/mmpdvruc0K0oyUSQl4hLT0/wIhxu5WiCFXsqrO52dLSL+DaL+p9kHtPoGwlGj2QVY2Y/m3eYw3VrLUPTB+yDMJr9y8v4d4QmEj/6X4T+RF6Tkh/SWQNVGz9+ptx7EDIzY6IWow7R4By32QBgt+/5XRiA8P5ENK3U+tqSGNCx6pMk54Wcx16Pww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FK+M04SeigoA1yxIuhiTfZwUDT1NZYyIxaCzaN6y2qc=;
 b=IlwncwWXMlFsSTNem16/SDsK+w9r9RLjCtoxjHqfJMbzSXHw+1KI43MkNpQ3QE99zGx42o/WI1f6RVPzJVOBBrsE7BrzOb7UxfNGEKDfSIH1dekSkzfs55cQA+e9UmDeUMrsKqBaeRswfPEGuazbZ1iZHZtpbzoZ9TYtzcTSLyJ157zywu/aY59i7y34FVNE9vrYIl/iazopVlR6qUsjlr3EE8jbXX2/isqQBz5RZjHROhgGnIfXJhqWJRu2qlOercmk+Hbv9Vc9DgrIL78CMgyReSMFE6DYPkZjbGaNUz7In76dZeZgXICziVBK5cNvpDlAIQ2XI9Wps4XQVaIuAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FK+M04SeigoA1yxIuhiTfZwUDT1NZYyIxaCzaN6y2qc=;
 b=UnrHu1H35fyGTuipIghmV8UHLq+z9NOOxFSiUCP7qyKUbSV72PNQ6Xfgj5ro1WoQY+CEqfbmBgCs9q6cvjRikWuJkGqOvWGMBuTDMnKsv0qNPfxBMiwyD/rBlaxDQaSkk7Kd/68t1YU4zRPaujxEjVKIE8AgBiZw4h0jJ1+IOgk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB6737.eurprd08.prod.outlook.com (2603:10a6:20b:304::18)
 by VE1PR08MB5085.eurprd08.prod.outlook.com (2603:10a6:803:106::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Mon, 17 Jan
 2022 15:46:19 +0000
Received: from AM9PR08MB6737.eurprd08.prod.outlook.com
 ([fe80::b435:c0de:ef6b:5917]) by AM9PR08MB6737.eurprd08.prod.outlook.com
 ([fe80::b435:c0de:ef6b:5917%7]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 15:46:19 +0000
Message-ID: <2ed2e26f-7500-2ddd-a3b3-450f22ef6e67@virtuozzo.com>
Date:   Mon, 17 Jan 2022 18:46:17 +0300
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
 <9dc07586-5471-ee5e-fae4-e177ceb114f4@virtuozzo.com>
 <23719c29-9668-1edc-e60c-a30bd821c7fa@virtuozzo.com>
 <20220103084311.beuxa6fcjtzn74a3@ws.net.home>
 <20220117115030.ci5z5jtgyl2clvud@ws.net.home>
From:   Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
In-Reply-To: <20220117115030.ci5z5jtgyl2clvud@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::7) To AM9PR08MB6737.eurprd08.prod.outlook.com
 (2603:10a6:20b:304::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98a4d73c-ea52-4642-6def-08d9d9d08157
X-MS-TrafficTypeDiagnostic: VE1PR08MB5085:EE_
X-Microsoft-Antispam-PRVS: <VE1PR08MB508543E2C6DECD094A96857DC1579@VE1PR08MB5085.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sxl1SthTrtnuc0KPVoGyeMZdIrVrIWdlyLQDsV/Tq8Zw99C+T8CpZaZR8CTxxT1XlzcIuMOL2Pb1QN6CHnjPdyL7r6ggca9d3wLNM7cigGt54UThGdlmZXHCaNnpll4v18jYTRQhJ2O9fePRaP19da/7m1QxruV9PQwkG3Q5IZDRF0Kuu/lNzw0qJf10ITS/yTjcDoZV4mUndUKvQLl/p4/YsCo5NGIlPyMU29Ep/rw8EmqWCThaf/2CLwLiCnFqYg1zf46qIQ96UI8TN/JaeN3UEs6QxHuInrfiLBi3UauUFyhTV6yjecmW6VQX0vKS9xjwjWK3l8sRH1YHOOGlLEI/YiIi68FOCa8AhLvvBhxdpmzH2wkimDPgKiCvnbx9XnaUFc1GZttzH9GAmoD8Rnd21CeK5XSojlb2Ul3vLKzYfOkLx7C4KS2EbYX0u7fIW1ILE5eqLBmuXBOAtnpii8XN1uEwMuKjTLjxGtzrxG5fzHkqoaYnJy7rYw5IAZ1/EGvjVKzXAsENX0VwGJgqhOsX0aFBnwEc+TD/C21U3vTetG50sE/CX8oGkGwIfaHVS09n4Qj7GC+KhM7cqGXz7ZtYuyQL4+U56eJ5w6i+Qgngoqkj146i5nUaJE1o8fInJIfxKq+k1iQxzqDTJE11bFT+kQyESkPh+PzfmzkSZzAqjXandxy1wX+Hbi7Y6at5E1mnMTGbS+khBFyAHrdpLL7X14xKX+BMjYkx5vrcyY7n3T2Eny9sUcKBeM0GC72dFU0h86ngejevweXcMRz+wGvfoxE3+XxVGscAGnLLBk4yvQo8BQs1LI0uIVj3mDiVenVnCiRUR2zwcZvHVUWfHFnA3XMNv4OFEEpBR4ceRyEipF5op15mS0wqlfj2qWNFBTpoJFDxFhrkutRze+y9yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6737.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(6512007)(186003)(8936002)(6506007)(36756003)(316002)(38350700002)(38100700002)(83380400001)(6916009)(86362001)(26005)(8676002)(6486002)(2616005)(31686004)(31696002)(2906002)(5660300002)(66476007)(66556008)(66946007)(52116002)(53546011)(508600001)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUU5ZTl4SG8zaDMxVjJUK0FRRG90b2k0YXhVNVZ2ekZyb2x5Ti84SmtCWHNW?=
 =?utf-8?B?andGdDJDclV0Kytra2o0V0p6TFUzU0pTQXRlOFNlVVlMeEQzeXpMNTFvMDRj?=
 =?utf-8?B?QVJVVWV6NEFUWElYUzVJVmlqRGxORGs0clJLbllxSEVIM1MrRzZEa3VoY0NF?=
 =?utf-8?B?cXJZM2tua2xSU2RNZ1FwUHN1N1o0UlNrMElWQTdvRXBONlZadzZkMUc3QTEy?=
 =?utf-8?B?K21DS25iczU2bVdhcEdsNEVXNVc1VVNvK0lzRS9Za0ZOWUFnYUhnYW9GV0Jk?=
 =?utf-8?B?L3lWbHl1NERMajc4bWtKRS82bjg4Q1FKa0VnT0d3RE5MbFhhd21tQlUyWjFi?=
 =?utf-8?B?TjViR1dqMHg5ZUprNnNvV0RZallQZnhhRGMybDZ3UjgyWTI0SXdHYkkvWE1i?=
 =?utf-8?B?dVp5c3BHNUo3Uld1a3RoQXREdHlSa3Bya2txRk9yYytOWGhFYnRUYlJ4aWlW?=
 =?utf-8?B?a0RIL2QvT2djeFZ4N3Btd1VGd3kza0tyWklwUjAvcmlEL3NQZXpyTlp0ckV3?=
 =?utf-8?B?SS9oMWJRbzRiRkNGcFZqSWtvWDl0U3A4R09oRkpuQTB6N1BhZ2lKK1VQcnYy?=
 =?utf-8?B?cnZJSXdYYXpIMldmcGVGekp1UE1mUW9LOVJLQXhFMnIzNHZjZEpPam8xVzVM?=
 =?utf-8?B?M1o5ZkcvTDduUEV5dE42K3dZQjQ3cll5elJVY3dGbDhibEpybm91eVNueUdi?=
 =?utf-8?B?K3JFN0RHZEdzbUx1L3c3NnRnU2wrOUpvVVh3dnRiSk1pbFRvK1lkOGhiNEtn?=
 =?utf-8?B?UDQvenMzMXc1ajlldXlpQlV6UVRUUHJyd2tJNDNqS1pPTW1HNVpYVkhZakM3?=
 =?utf-8?B?OFdpUVZmM0R5WDhwcnNEbnZRUUtSanN6VENFd0lybVJ2dXZtak8wb1V2SklJ?=
 =?utf-8?B?WU5YQ1FxcFBXVzU0aStpZVcyVVpVay9Gd2d5dDU1N3plSk1Ja1ozVDlPaGRD?=
 =?utf-8?B?RHBVZHpoYzhUNWg2dEJxZjdrN2hwR0xQdGRXRmQvZnlJSzR2MzdFVTh0eGdT?=
 =?utf-8?B?cHpvUElLb0hwTFBBb3NtdERlZzkzbTJVRVB4eHlIVVVTWDBsYU5ud0RGQlQy?=
 =?utf-8?B?anZWb0V4QlVLd2VNT2J5MTBJdDAraXZROFIrRG5qWDYyNUNrOXVRdHdiWXZM?=
 =?utf-8?B?RWphZkRjOXo0RmdHaDc3NEZlUXlIRzJkNDd1TFNDbUZrQnAzOWtLVkp3WVdV?=
 =?utf-8?B?TVZzK3Z0UWtkc1FvTC8vSUd6Y3piMmdrNTM0YXliNmh5YnJkdVI0RnJ4Qmtz?=
 =?utf-8?B?M2RrV1ZjWmNxL0ExMWx6MXNDQ1F0Q1RqdEFRZEQ4aExwTUdKbnpyekFkaVJo?=
 =?utf-8?B?RnpDcFRPVEwvU1dVSFhEbkFIcEowdFNhcWZXTzN5bVZWb04waVczbzNxdG91?=
 =?utf-8?B?RHZ1TmxmOEJkWHFuclpPT1lUVStsRnBQeE40eEdlcWhtbThxNWhiOXFUejJQ?=
 =?utf-8?B?c2VTL1hnUnhBbWdrL0g5NXRoY1htN3ZPQUVkWVo3enVWUFAxVTZXSWJFSk5r?=
 =?utf-8?B?ZDFoc1ROZnNNTm5VVms0M1VBZzJ4a0lHMU9oRmhwR1JwUktVeFgxeS9kVHEy?=
 =?utf-8?B?WU85bkFlVi84MUNiZFZrSTJYRWtYL2NXNENPdlJIbjhkUDV6dC9EbmxiU3Qv?=
 =?utf-8?B?WVpHbWxzU0ErZE1TUjF2MUJ1eFR6ZytLUGNSUjY3dktjVm9IYXlsdkNzeUR5?=
 =?utf-8?B?V0NOeWJ3Q1Vuazk3TEhMaWQ1aXo3Zll5dkRJSUdNVVhncnpUZHRCWTE4R2Fu?=
 =?utf-8?B?VU9lRzNNWDlkVE5heGtQZG1mUHJ6OEJkZ3JsdUhpYm5GYVlLaGd4M0d3R2M5?=
 =?utf-8?B?Z1J0Y25GL3dBbHJwRkhTRnV0dTZkd1hlSzFYQTdyMER1UE9xUFBYbHB5QTV4?=
 =?utf-8?B?RGk4bzBPWHR3M2ptQndHWXZEVDA5MWwwbjlSWjFEQWQrTXh0NGdMRnhCZm95?=
 =?utf-8?B?T0xPc1BzL0ZJQnlWY0dkUGo0K0l6MUtkdDVKSWJHb2dUemRYckhzWU16VWNF?=
 =?utf-8?B?aDlIaWh0MHBPajZibHNpY2hxYzZxenJEbDlPblN5czg2aWcwN28yTTVEUHlx?=
 =?utf-8?B?c1cxRXNpZ3NFejFSRDlCYy9WN0JqbjNkdHo5M0RINEVna0NGQ011UTJ3ZUdj?=
 =?utf-8?B?UGVVd0ptMlU3aFlNK2ZMT3BQTmlyQXNhNzZoM29tdU5VZlh4c01XZWt5MElj?=
 =?utf-8?B?Rm9FSE0zV1oyaVFnaTdoZmxhUjFTSDJCNjV6MXp2N1VNOEdTbVNaQXlQVFVD?=
 =?utf-8?Q?FUYt7UsYxrtPwZO9bIUrhGdczxHQCre61CTite57Eo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a4d73c-ea52-4642-6def-08d9d9d08157
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6737.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 15:46:19.7457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U7ybkBC3QeM3a6xchfZAxrIQRA7dtIQ1EF2am5xf5icGrky5phzfsALNDfvGl6FfRKacHaTx0HUV3eeI6h+QMaE9+j4XZ4XETq3Nl+P3uU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5085
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

17.01.2022 14:50, Karel Zak wrote:
> On Mon, Jan 03, 2022 at 09:43:11AM +0100, Karel Zak wrote:
>>> Hi! Are you working on this? If not I can try to make a v2.
>>
>> I had a vacation in the last 14 days; nothing is done. Go ahead if you
>> have time for this task. I'm going to work on something else this
>> week.
> 
> It seems you're busy with something else ;-), so I have implemented it,
> but it's not tested yet.

Oh seems yes ;) Great that you've done it!

> 
> Please, please, can you review and test it with your environment?

Ohh. Will try to remember and restore the environment this week :)

> 
> Thanks!
> 
> See the patch bellow or topic/blkid-floppy branch on github.
> 
>   Karel
> 
> 
>  From 49be1b256ad351cde2e0cf5000c7046e7010cc02 Mon Sep 17 00:00:00 2001
> From: Karel Zak <kzak@redhat.com>
> Date: Mon, 17 Jan 2022 12:37:13 +0100
> Subject: [PATCH] libblkid: reopen floppy without O_NONBLOCK
> 
> Vladimir Sementsov-Ogievskiy wrote:
>> The commit "floppy: reintroduce O_NDELAY fix" was removed from kernel,
>> so we faced the bug described and discussed here:
>> https://bugzilla.suse.com/show_bug.cgi?id=3D1181018
>>
>> Discussion in kernel list on reverting the commit:
>> https://www.spinics.net/lists/stable/msg493061.html
>>
>> In short, I can quote Jiri Kosina's comment:
>>
>>    opening floppy device node with O_NONBLOCK is asking for all kinds
>>    of trouble
>>
>> So opening floppy with O_NONBLOCK in blkid leads to failure of blkid,
>> probable failure of mount and unpleasant error messages in dmesg (see
>> also patch 02 for details).
> 
> Based on patch from Vladimir.
> 
> CC: Jiri Kosina <jkosina@suse.cz>
> Reported-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Karel Zak <kzak@redhat.com>
> ---
>   include/fileutils.h  |  3 +++
>   lib/fileutils.c      | 17 +++++++++++++++++
>   libblkid/src/probe.c | 33 +++++++++++++++++++++++++++++++++
>   3 files changed, 53 insertions(+)
> 
> diff --git a/include/fileutils.h b/include/fileutils.h
> index c36ce6353..8722ed59b 100644
> --- a/include/fileutils.h
> +++ b/include/fileutils.h
> @@ -97,4 +97,7 @@ extern void ul_close_all_fds(unsigned int first, unsigned int last);
>   #define UL_COPY_WRITE_ERROR (-2)
>   int ul_copy_file(int from, int to);
>   
> +
> +extern int ul_reopen(int fd, int flags);
> +
>   #endif /* UTIL_LINUX_FILEUTILS */
> diff --git a/lib/fileutils.c b/lib/fileutils.c
> index 7a8fce26f..5b15d4916 100644
> --- a/lib/fileutils.c
> +++ b/lib/fileutils.c
> @@ -288,3 +288,20 @@ int ul_copy_file(int from, int to)
>   	return copy_file_simple(from, to);
>   #endif
>   }
> +
> +int ul_reopen(int fd, int flags)

"reopen" sounds a bit like we are going to close old fd, but we don't... No better suggestion :(

> +{
> +	ssize_t ssz;
> +	char buf[PATH_MAX];
> +	char fdpath[ sizeof(_PATH_PROC_FDDIR) +  sizeof(stringify_value(INT_MAX)) ];

Extra whitespace after '+'

Also, I think you should add +1 for '/' (you use it below), and +1 for finishing \0.

Or alternatively we may just use PATH_MAX here too and not care.

> +
> +	snprintf(fdpath, sizeof(fdpath), _PATH_PROC_FDDIR "/%d", fd);
> +
> +	ssz = readlink(fdpath, buf, sizeof(buf) - 1);
> +	if (ssz <= 0)
> +		return -EINVAL;

alternatively you may return -errno on ssz < 0, and assert that ssz > 0, I hope 0 can't be returned.

> +
> +	buf[ssz] = '\0';
> +
> +	return open(buf, flags);
> +}
> diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
> index 6168370e2..d69ff530f 100644
> --- a/libblkid/src/probe.c
> +++ b/libblkid/src/probe.c
> @@ -103,6 +103,9 @@
>   #ifdef HAVE_ERRNO_H
>   #include <errno.h>
>   #endif
> +#ifdef HAVE_LINUX_FD_H
> +#include <linux/fd.h>
> +#endif
>   #include <inttypes.h>
>   #include <stdint.h>
>   #include <stdarg.h>
> @@ -113,6 +116,7 @@
>   #include "sysfs.h"
>   #include "strutils.h"
>   #include "list.h"
> +#include "fileutils.h"
>   
>   /*
>    * All supported chains
> @@ -907,6 +911,35 @@ int blkid_probe_set_device(blkid_probe pr, int fd,
>   	if (fd < 0)
>   		return 1;
>   
> +#ifdef FDGETFDCSTAT
> +	{
> +		/*
> +		 * Re-open without O_NONBLOCK for floppy device.
> +		 *
> +		 * Since kernel commit c7e9d0020361f4308a70cdfd6d5335e273eb8717
> +		 * floppy drive works bad when opened with O_NONBLOCK.
> +		 */
> +		struct floppy_fdc_state  flst;

hmm, extra whitespace?

> +
> +		if (ioctl(fd, FDGETFDCSTAT, &flst) >= 0) {
> +			int flags = fcntl(fd, F_GETFL, 0);
> +
> +			if (flags < 0)
> +				goto err;
> +			if (flags & O_NONBLOCK) {
> +				flags &= ~O_NONBLOCK;
> +
> +				fd = ul_reopen(fd, flags | O_CLOEXEC);
> +				if (fd < 0)
> +					goto err;
> +
> +				pr->flags |= BLKID_FL_PRIVATE_FD;
> +				pr->fd = fd;
> +			}
> +		}
> +	}
> +#endif
> +
>   #if defined(POSIX_FADV_RANDOM) && defined(HAVE_POSIX_FADVISE)
>   	/* Disable read-ahead */
>   	posix_fadvise(fd, 0, 0, POSIX_FADV_RANDOM);
> 


Looks good to me. I hope I'll be able also to test it soon.

-- 
Best regards,
Vladimir
