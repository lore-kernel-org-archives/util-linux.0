Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41577EB64D8
	for <util-linux@archiver.kernel.org>; Tue, 20 Jun 2023 11:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjFTLWU (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 20 Jun 2023 07:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjFTLWT (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 20 Jun 2023 07:22:19 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2104.outbound.protection.outlook.com [40.107.7.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB6510D2
        for <util-linux@vger.kernel.org>; Tue, 20 Jun 2023 04:22:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2eEOdKJor/TfesCRJbp5WFuy2wCst/hBQWlUOdAiul3d/+o9kVZMBroX4dv3aadEVVCXcBjonph/vXpJdUPNkkY4pbfqCKNEx3SOVXYWJgarRB2prA9rCywXtYIWxd1UcqJPszJu1IMg3gquVLZ19ll7lI5fjx3HPTlAQKL9yE8taxRzFnd8NvylfjWa+0UkYS+VwpmOdVU80FybjANEZd92s+sJaVays4ABtgi3rs+rRkRgvkDG/6J90eHWf/K129rlUMAAlLI3s/xNCLceGSsLJ02624fzaPU9yAYN3CWvkcZUkANC6ENBFC9O+phK6UEq+s96ZJuAaAbWRU0ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V83zxaJyAF+NXYUoPfzrL707+DZQYqF63glJMeQcz+M=;
 b=BZO4V9xZqw3f1g3ZZHDm/Wxr24lXVwsRbeeOz0A8it8ojOauqJYFYnwfbzvbtfG3kswI5JqZdqtLXDu2SmNQWE3AAgYYbpUYSjcpdQtY3sizPbxIDonNPY4EaWucluCOwI1MNA+q/O5+pARYJX76zDAM4xJnrOiqvd+kCRjHptIdYgLUdb5Q1zib6dw1XYx2NJqZ4440pMZukvALftuYJRIVuVQMwzxeeg7cUXxCL4147YWu/Yvd9LV3eV/RyL0F4RXy9xaI2kwlC5Pkc0uQ4z3JNsrKYZmXNTfbWHBgwatsswF+UKwamSWAiG+XT4jlzalHKwdHjptm+Ni+HAIFuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V83zxaJyAF+NXYUoPfzrL707+DZQYqF63glJMeQcz+M=;
 b=TxV/ZVvCDhgwQTnhXe4UGcMUdmsDgn7plTRUHUmNh7J+vC9c71alZYOnKqtSN4RJDV5BaWzRmgyMnXPLz8LNBZtf3/wfpF5h1knJ6A0xfcIV4X/xWCNLHJUfjFgUBnjD7t8f9wCpOwsYASPqo/WUvyU7U0BnLfavaherqHNy8Ec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PAWPR10MB8238.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:386::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Tue, 20 Jun
 2023 11:22:11 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d66c:ec:aa54:f318]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d66c:ec:aa54:f318%5]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 11:22:12 +0000
Message-ID: <5bbf3d35-d74f-0abb-094a-0762c93f1fb6@prevas.dk>
Date:   Tue, 20 Jun 2023 13:22:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] hwclock: add support for RTC_VL_READ/RTC_VL_CLR ioctls
Content-Language: en-US, da
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
References: <20230613101428.294827-1-rasmus.villemoes@prevas.dk>
 <20230620092628.klpqbr5qw2rdysqh@ws.net.home>
 <e5407336-9330-01f6-1f40-f70c92a256ad@prevas.dk>
 <20230620102235.x4ltsqsaw5gtnvib@ws.net.home>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20230620102235.x4ltsqsaw5gtnvib@ws.net.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0120.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::26) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PAWPR10MB8238:EE_
X-MS-Office365-Filtering-Correlation-Id: 514c553c-ae44-40b6-3506-08db718097ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JAwY6/Tj2zYHNPAMBLEyAPHwH6tMoP2RPGVI75jb7Pj9TkgmY/811UvXIoGM8hTyjiocOe7KABjO6miyszZM5Wo7BIX1w28+9mLTpK86h5ZrMHjjgpiUF+2PXggUs7FqwRBQKtEB1v3PJT9cmwMvxAoKNG5yGocxKRkTyfii1X3cdZavoeh0xsQYgOWRLMNx7IrbPy50xjtVwXLnDAHKOoC1W044Q6Z1RqgBF6PlJUoNrDq5eC9VRnfp9+7Wl76pDq3TLjSudZ0Yg1+g5apw2a2PbLefUQsLZxojajS26UCfYYUWwOdnyn+Q/fnomOBn6PzzrVaUypk4k6aVe8IxHVYiNIQk8B3p1I2Ple3uTcfcfZCetcxxHhnu56h53xvwQ33uXjrobRmYPDNI4Hk+aMzxCrot9ZLnqtnz89iKNQHNrMmmPaQF2N5hHs1yvNEuCO3yOoQaZko5t9omHjQxB6NdpVhodHnLXzIU/ZZZ/t5XAEI2r8xh55H1DJmNzzj7iEhymWrvl6icvb4zeKPFkjKMZXEX3PTFOksJZLRidnsf0rzsFw89Key0f7iROzRvJVB7C1v+RSknjM0a37JX3WsigTzbDtTzrT3pucqn7HKyF0306sEVXGZPPFij4ZN4T//l/i6ZLYDO3f/vETSjzpGTz0JlVifTPgnB7AqDnNBZNZ8DU5ZcTSl46wJrZvnF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(136003)(366004)(396003)(346002)(376002)(451199021)(83380400001)(2616005)(186003)(6506007)(26005)(6512007)(38100700002)(478600001)(52116002)(6666004)(6486002)(31686004)(38350700002)(31696002)(86362001)(8676002)(44832011)(41300700001)(8976002)(66476007)(316002)(4326008)(66946007)(66556008)(5660300002)(8936002)(6916009)(2906002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVpXeVk1bVhFc2hoN0RrRFFDa0E1ZHR1TVo5OEI3WkxpNXN2aXBES1F2TkRK?=
 =?utf-8?B?eW1zT1orZ3VQYVU3RCs3NGxITlVuQzVORFlsTVd1N1R2YUdxMzBxeGEwMm9G?=
 =?utf-8?B?M2JWaGV3eU1sK0ZrdW5tUys0NUpTV2ZPemZSZGVZZmN0alN0NCt5NnRxc214?=
 =?utf-8?B?K0JETFFNcThQaWlWRFpVS2JscWJYNWk5em9tZUo3K3NwWXQwRWwrR2FnT3Fy?=
 =?utf-8?B?VzJFdlEzR3lzNXhlWkZLekx2a0tReW53UXJ3VTZGUzJvc2RzSUdxSkRmZ0VT?=
 =?utf-8?B?d2dtczZwYzFFdXJSdmVBWXNRQmp1NjljTGJLUm9QZlh3K3R4OUlNdTVWdkNK?=
 =?utf-8?B?K3FsSmREVm5CK0wzbEVOakVWNHA3L1FtUnY5YVpNSEQ4ODJoeDBXekpMaWVl?=
 =?utf-8?B?RFkxa1Z0Nm5BT29YeC9aU1Jnd0lmTGsyckN1WEtvYkN5WVBzaHhYQ000by9j?=
 =?utf-8?B?L2tCSGQ2elJma1lxK2JMeFUxTVcwUGdndGVFR1ptSnNWd1B6Z2RtYS9pZVEv?=
 =?utf-8?B?dUUyVUJXc0tITmE4Rk9hK1ZxZVd4WnorVGRDTzVQRi9vaS9rT0NmQmkzbFg2?=
 =?utf-8?B?anRJWi9DTnRTSjdzaFFvSHdpR2kzZ080Tld4cnNDK1lEdEdiK2ZhKzdTRlNp?=
 =?utf-8?B?UDJBWjZhdFdWNk1QN2d3VnExQUJaZDZJdTBjYVYwQXBIdzdoNWNVeC96Z2wv?=
 =?utf-8?B?SUtkMkRTS2E2dVRDcHQ2U0JMMm45NjJmN0YwZWI1ZVhTL1RnYXBaOGx0Z3p0?=
 =?utf-8?B?bGNMb2hhdm5PSGhybWpjYVppeUUwVkpmZHhnTWRkTHRPRWZFcWRab2dmQ3Jj?=
 =?utf-8?B?UXV2ZzlDY1RKZkdtVG03SFVGdk8yM243T0hVcXQ5N0FCQmpZRVI3VnppbWVF?=
 =?utf-8?B?dHJ3bXhLekFGRTVKUnJab250MGZBZCt5elh5RVJKbEZlWUtIb1pqcFMzWkQv?=
 =?utf-8?B?TDF0V1VwWTErZ3FGdXNkTHhNSW10bUwwZUZKYm1PVGMwejJhcGhGOHJDWVRT?=
 =?utf-8?B?aExXWEJ5VERHOWwzdko1bkczSmZUYUhqeDZCTE8vUFFvNTArK1E0czJLa3pi?=
 =?utf-8?B?eWdqK3dPVEdJR2lJUzZwMGFzV2ZMNVRSYmN1enFBSU0wQUhkNWwzZy90dWxG?=
 =?utf-8?B?V2lSUU1uWTBmZWJEL3pYTjBhMG5CUXoyRmJmUFNCd3NudWhEa2hpd2c5Z3l1?=
 =?utf-8?B?aVV3eHduQUtyRnRpRUI0RjZpMWVMVEZzNGIrS25mSmJNTkEyeUpKWGg0Y1dM?=
 =?utf-8?B?RitnSWZWWks0Zm5iMGVtektNUFdRZ2FJL1dlRFV3d0N0WmJRRjljRmZ4eVlJ?=
 =?utf-8?B?ZWFYa0N0ZjdHbkcwd1I3Yk9CQmdRRVVncDVJaGlKTDNZSVQyeXBneDcySUZy?=
 =?utf-8?B?ZVJVeVhzMnBGRVhzRWtvOTR1SGsxblM4OElpTm5oZTBLUGFhZHRhL3cyYzNQ?=
 =?utf-8?B?emtUY2dIY0o4a3kyWW5lVmVHNmVVUEIzMzhQa1JOMzhsaXhERUhMRS9nKzBx?=
 =?utf-8?B?Rkx4VjNsVVNjaXFYc1RsRk9VeXpDSGdMRXp4M0JjeFdKbjdJT2tWUXJ4SklU?=
 =?utf-8?B?NGxHZ01Hb1JpbUR2T1doenJqcWJ3YTdIOFZaWnNlTFVvUisyUG1JSjRJcDNW?=
 =?utf-8?B?dDByK3lIenV6b0E3WmFqU1VqSkFya0l0eTlQcWVNUVJtRFlxTEw0R3dOd0hv?=
 =?utf-8?B?dUNGbDJJdSt4OG1tSkhvQ0dvQ21Lb3dLcWc4WUZSSTdIWmJWQUdscHBPQ3Nw?=
 =?utf-8?B?cUxDY3lZeGp5cVZBcTZ4K0szL2JTcldKZWVIUkJPRWhId3NHTk5ITzFzRXdx?=
 =?utf-8?B?RVBMT1pIY2crMXg1TXhFRFNrTnVXY2dXMlA0M2QvMEFHZlNJUGdHVE1WK2hS?=
 =?utf-8?B?OEU3UVpab0lRalAwMUJ3V3J6MGswcTdiZEdTQzBwN3M5eWFlcVlYOGxJSklP?=
 =?utf-8?B?eHp0VTljcTMwbDJDVFhsUTZwclNydmFVMFlNaVpXK0RHM2ZiQTF2a2t0VzlO?=
 =?utf-8?B?d3o0ZDViWmV6SDArTktpVkJqZ2gwbGZUeUdHdVY1T3F5VU9ZL3I5cVR4VFgz?=
 =?utf-8?B?ZmlFUW93KzBLK29BU096VW9IcUN1aCtNNkhZeDYrRHRLandVWGtaRU0yYkxj?=
 =?utf-8?B?THZDQnVIMVBGYnpweWdaWVFZOGd1Q2tUWTVuRWs3M0VWQWUxcStTdWRnRlFG?=
 =?utf-8?B?U2c9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 514c553c-ae44-40b6-3506-08db718097ec
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 11:22:12.2790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e9s8qwfgr5/M9NofQY8FxRvlja/RZ13uR+O9UoP22SoGqxMauwQjowzRxZBezIJhwTsqmbhpTYwHuQEHQzHf9UrwQjDlE5cq/GuumBIHWcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8238
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 20/06/2023 12.22, Karel Zak wrote:
> On Tue, Jun 20, 2023 at 11:30:07AM +0200, Rasmus Villemoes wrote:
>> On 20/06/2023 11.26, Karel Zak wrote:
>>> On Tue, Jun 13, 2023 at 12:14:28PM +0200, Rasmus Villemoes wrote:
>>>>  sys-utils/hwclock-rtc.c | 86 +++++++++++++++++++++++++++++++++++++++++
>>>>  sys-utils/hwclock.c     | 35 +++++++++++++++++
>>>>  sys-utils/hwclock.h     |  5 +++
>>>>  3 files changed, 126 insertions(+)
>>>
>>> The patch looks good. Can we also get something for sys-utils/hwclock.8.adoc
>>> (man page) and bash-completion/hwclock? ;-)
>>
>> Absolutely. I just didn't want to spend too much time on docs if the
>> feature was deemed out-of-scope or if significant changes to e.g. the
>> option names or other API was required.
> 
> Good point. Option names are always the funny part ;-). 
> 
> At first glance, I thought that --voltage-low-clear was too long and
> that it would be better to follow the ioctl names. However, upon
> further consideration, I realize that we already have longer options
> in util-linux. So perhaps, choosing --voltage-low-clear and
> --voltage-low-read wouldn't be such a bad choice after all.
> 
> What do you think?

I prefer the current, shorter names. There's also precedent in the form
of --param-get, which isn't --parameter-get.

>> Can I send the docs as a separate follow-up patch, or should I send a v2
>> with all changes in one?
> 
> Select what is better for you ;-)

OK, thanks. I won't get to it anyway until probably tomorrow, and unless
I hear otherwise, I'll just keep the current names etc. and send a
separate doc update patch.

Rasmus

