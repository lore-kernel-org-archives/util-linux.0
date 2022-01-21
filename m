Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A2CC433EF
	for <util-linux@archiver.kernel.org>; Fri, 21 Jan 2022 12:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237622AbiAUMNF (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 21 Jan 2022 07:13:05 -0500
Received: from mail-eopbgr40107.outbound.protection.outlook.com ([40.107.4.107]:39583
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1380318AbiAUMNE (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 21 Jan 2022 07:13:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=deEXwHZ3tX0JNiQ09qgkrVp1E0WdpMleO2oEFO4d+WMk+C7SrubvZZ1vhoEEf0lUrpSlUG6t/POJyqJLJk4KDfzrK38UrlA6ZwTv509Yp4+zIxmOMbJVjRNrysqq2XKw2h3F47qil8Ne49yaT1haJWvrYvf+58NdjHRz7DtM++qJ1JzFJwvc54LHlBkNpOExgsqkeaxA2McrdESGHKMi/p0bL3iu+KTyUGad7IadGmhY/rD2OQX1Gp2x3lHuK0nd4N8d2K5dNLwLJqL4Sg4gSsQgTMds7YCG1bJ4/EWrLJHkUPgfa9glRVmTRqUuTmMNWqWkKbI6ysV715Cc9Z4aUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzVkw0qr8npp4e2KCD5D/2HAX4f3l8+GaD5emGo4P5Y=;
 b=HmFvJr2DUEDuPRetgTTfIldD6IJyBL8YYOjjikKgiTGUHoQqesniWhPL+sot9EJ8IKRsrm9ASvYS+YTqSdG+Bv6Ob6eBrZnqBVt5nGrFhmyVfy9OI8YpQokcLVkGZDOlLKJmzdPoJxDQisVt3ZBGjHE1jURC3m42dE4FGL6tB9sF20Hy42/M/1Ht9sVU6/HnLlnmg/FLcO5ekikaFDSbQFwn5+kL3rM5OAz1gl7V01ZdN0MmYXuj5+mR/CZfzZOwgNYeC9CeQD2FC/ENQVkbo2N7h3lzPGZ5EzS1D0s0o1GLr2YaHwjLKzf3bcadwbQSVGsd5eWj3z13hVxeYKRxoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzVkw0qr8npp4e2KCD5D/2HAX4f3l8+GaD5emGo4P5Y=;
 b=lqzAxZJvpnYiOD9k3AWD/wJ7OuH6OgPod2c9+PpO5nknDTq/i64ezFVBdCCMMkLu76hjUgvWB8IfQl0Gxbvylw6D4s2TXd+LQ7rrGFtcVswJN4rvjPz9Wkn+x0WsMSOKpktS8KCgxuF9DfL2+XANTLK3+Ft7kaTZlMeQeg1maUw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB6737.eurprd08.prod.outlook.com (2603:10a6:20b:304::18)
 by DB6PR0802MB2455.eurprd08.prod.outlook.com (2603:10a6:4:a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Fri, 21 Jan
 2022 12:13:03 +0000
Received: from AM9PR08MB6737.eurprd08.prod.outlook.com
 ([fe80::4def:4b08:dfe6:b4bd]) by AM9PR08MB6737.eurprd08.prod.outlook.com
 ([fe80::4def:4b08:dfe6:b4bd%3]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 12:13:03 +0000
Message-ID: <867dfb54-accf-89e3-b2b3-1cec04e1c418@virtuozzo.com>
Date:   Fri, 21 Jan 2022 15:13:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/2] libblkid: reopen floppy without O_NONBLOCK
Content-Language: en-US
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, jkosina@suse.cz, kurt@garloff.de,
        den@openvz.org, msuchanek@suse.de, efremov@linux.com
References: <20211209141233.3774937-1-vsementsov@virtuozzo.com>
 <20211209141233.3774937-3-vsementsov@virtuozzo.com>
 <20220121101840.qaydaibbcphc4fja@ws.net.home>
From:   Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
In-Reply-To: <20220121101840.qaydaibbcphc4fja@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0235.eurprd06.prod.outlook.com
 (2603:10a6:20b:45e::34) To AM9PR08MB6737.eurprd08.prod.outlook.com
 (2603:10a6:20b:304::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d67869c-0b6d-4a6e-d1a0-08d9dcd75f76
X-MS-TrafficTypeDiagnostic: DB6PR0802MB2455:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0802MB2455049575A5B88AC42D0318C15B9@DB6PR0802MB2455.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QSm2SltUo+pfduns+0Bm67FPV2nuOj/CcT37QgmJwUJiPioydHF0XLkatmeAomRdFqvBW2AU+MqwsoWQq/ym34BhSAONsaRxYmNxJJTJqJBL42xExVPm0qIsJ2wHi8jgudZQ3Ex4BQ8Mq8+MFZ+EQ41Q4T1rlag5U3e02+qBLHCNyJauKnxFBM3hpnS1nWqabiHvNoUIelOZNiAtWP6WeyweZnl0goK8Xe+mibXF8XjVb3TqCr3dL1wOyVGvUCV7dXuRxFnktIVnB4hS9lZBi2hV3b5tQ2quF7Pdg5d7frBtGDu5/Fd08kiGse98OqzheDS5FgPH8hbLPQeS3PSXGxdvFkGpXFVTEp0S6YvVKGYxRG84T/sdu2fS43SQ/k1+dOQFxeqjMYUKfay10i6Up58vZhI5+yfxyC1DcRy6f5FVf/2ajGpGA1IFcgRQOQAOLqZ83FP7G3dwPKMX0eLmx5pwZI+Fs/yX3Mizqczqe1hD0GEOsyxToQGn4gcARRuM0wra7f9U2+9LcUF6wJ8rzIeIHv53RRLZC297QJOoknuv8I9++o1nJ6A6A2i/JbhK/2nxd5XELxcFcRGCC1dTFYiZ6R94K8P/tN8gd95S5V4418GQKfUOqa3vrIlRXg9ELlSawYCj1b3TtROAGyJcjzNH3QTqStBL29Y4j43k0Yg0ZCpRXNpj+wCcQUulF2uksQxMmCyATUs39EThxbbQpKl4OE5u9Hi8abJQnJNFElpMBqYw/GgOy+YMBnXIMQ94OmEWOqFvoup5qtrDG6YgIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6737.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(66556008)(26005)(66476007)(38350700002)(186003)(316002)(38100700002)(66946007)(508600001)(4744005)(31686004)(2906002)(36756003)(86362001)(8936002)(4326008)(31696002)(83380400001)(8676002)(52116002)(6506007)(6486002)(5660300002)(2616005)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0pVQmYyTGY0SFZIMnBld3BTNWNKSkU2Tldpb3g1VWkxSHlLZUMvdUV0SW0x?=
 =?utf-8?B?UCs0VlJhTGROb3VJdU1tZnlxSUJYZkF3dnBDVVI5aUVvUU9iTkNiMjNrNXdV?=
 =?utf-8?B?NDZ4Zm9Fa1Y5SmxteHFrWFZySTRSVmFBTXNIVkxIREc3Q3lQa3hsWlZpdnlp?=
 =?utf-8?B?MHdRU090MUtyeWRMV09YVGttNnF6THF0TlJKcmsrOVNJaE9EZDJDdGd3VDh1?=
 =?utf-8?B?di9RNC9rV01PdjlGWkxWOUVwSnF4VG9SY1pyZTBrTSsrZSttbjU3WXVqME1Q?=
 =?utf-8?B?dnhibVNZV0pPSDd6eVU1T2dsRGlwdmhwa2FxOXNmS3FPWnNvekVIT3o1L2Ry?=
 =?utf-8?B?NHpnbGJXSHlpN3VONGU5VjVGd2dzR0NUL3pOMHlKakZRdkpMd2Z3N1RlTERo?=
 =?utf-8?B?Sk8wUW9zQWRKc3c1ZmRKRmVZQlN1MzZuM3l2c0Y4QjEwVWhMTGdjWlF4eGU1?=
 =?utf-8?B?U1FOTWJ5N1BKbHpLT255cFprbXArWGxST2JaOHllRmZEakpma2djTVUvcWM1?=
 =?utf-8?B?djFOaTZicVBubkhxOXkxOUVtN1hjeUdkVWVUYSttWUtQZXEzekM2M0M0ZGtC?=
 =?utf-8?B?TCtJVWwvdVZucStaL1JtNUNVQ1g3YjRJNHMxTENQQlE5akNtUC9mNmc5eHZn?=
 =?utf-8?B?QVhpenJFVnh1RENVMmdqQTlSNWYxc1NsWVg3eElwVU5rUkJ6WVU0WU51NGZk?=
 =?utf-8?B?cG1HdkkzTnIzdkxRUlo0WFFDRGt5RGR2aTU1bnlIeDU1MlBweG8vMEZiZEhs?=
 =?utf-8?B?L0U3UDdVVEtBZGV0dG1VSUc5WlZOOGlvTXdnOTRrbkwwVlNSTlAyM2NaUzdl?=
 =?utf-8?B?d041T3JLVFhlOGpFZE5EdjhLaVN4MWRTV0tuaFQvODVmZUx2ci9FR05iSWhr?=
 =?utf-8?B?SGF0V2dIcDJkM3hJTUVySW8wb2lmTEJ6aUt3Z2YzVkNUMFNlWnEvbmNKVXpo?=
 =?utf-8?B?Z0NzRnZtRHBDMUFPdWpKUlNNV25LRno3U0ZKMUNXTFo0WERZaFQ1eXlGOVgw?=
 =?utf-8?B?TVBsWVZYeFNvZEhTQmpkTFVENjljbkdwdStmSks0L2pyNy9hUHIxS1RLR2Ji?=
 =?utf-8?B?TkJyc1dQWkZTZk4wNktXb2p4VnkvUDU3Nm04Z0dpanp5UGlTOFlORGd3ak9v?=
 =?utf-8?B?Wi9iUnE5TTg5TmYwS1p4U3FkL3U4d2JUVzY5VGlvbnBPYVBDeTRIeTZNb0h2?=
 =?utf-8?B?eEJSV1RiSWFreXhJcCtoSkdKSnlqeDErZ1ZWaGtYZ0hwSFRvK3BqcHpBeU5H?=
 =?utf-8?B?N0dhRXVHd2VPUkV5Q3c3eHNNaW4wWDdiRjhYK2gvbUQxSFdQa0R3bDlkVWdB?=
 =?utf-8?B?Tk5kZFNUc0RUdlNWQ3ZWZkZ5T0RDcWF6RWdzQmllSnY3end2ZHhRMXJaT29q?=
 =?utf-8?B?YjRhcmJpbVJYUTJMTHZ0UkR0aXJCcEhkR2pYV3ZmTWlhVzJ3b3NwOTFQeUoy?=
 =?utf-8?B?M3FwckxrdXRJaG5wV2pXODhKTVZZdVNOa3Z4NU9EV3BpRmJFNnFtbFZ0Kzdv?=
 =?utf-8?B?Y2Q3MEFqVXlpN3JualNFT1pXUHBQSG80VTVQdWE0ZWJaa2grS2trUTFlMzZ0?=
 =?utf-8?B?RzI1bmxvcnAyWVgvR0w1MklTNk1KZ1QwdDVhc1h1YlRCT3VnblFyUXNlQytK?=
 =?utf-8?B?ZGd2SUxoWExLTnpieHY3RVE5YUtiK0VId2xwQ3BqUGVXemJOQ2p2WXQ3T2RE?=
 =?utf-8?B?aklDMXZ5a3ZwemdndDVvUDVYd2g1YitydGhiS2lTeEQ1aWRtWjJOTnRhY2V5?=
 =?utf-8?B?ZFRncmt2amt6eEp3ay81VmZkNFJzbDI2VVVrS2d6ajdycDJzQy9pOVQvZXgz?=
 =?utf-8?B?dTBDbzlOVHkzMGNwZzNRU3lETVhYZm9taUF1eWJqbWtIYUVtN1p3ejFIUSsx?=
 =?utf-8?B?a1M4MXplRmFaSGxBdVM4YkxuUlIrRHQydk1NcHdydzNnWkNRK2dLUnFySW16?=
 =?utf-8?B?S2VBKzl4UHlWcUNPZzlYNCt2a3QrRE1jT1pDZ0hLWlh0VWlQYkdjUlAzYWVV?=
 =?utf-8?B?Z25lZXpkc3RxZ0VGalFDbCtJeUxOWFdUbEkyYmVoTU83SVpMeExrQzNxSVVL?=
 =?utf-8?B?S0RZR3Q0SnFNd0JpOXE3N3RmcU5KczhwMi9vYTR2ajlzRENWamhtRDV0SFRU?=
 =?utf-8?B?Nmg1OElIMDVFNWVwRk4xUDczM2s4QjZ6N1NrSHVmbzhmVUh3RUtYVy8xWlZj?=
 =?utf-8?B?SlBBZUxiZ0E0Z0ovTWtobm95UkZ0enhHWndLQ0k1SUg5Q0oyWG9qQzdOdUhW?=
 =?utf-8?B?aFVEdVFLTVRrNmdzQVFEbWV0RitRPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d67869c-0b6d-4a6e-d1a0-08d9dcd75f76
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6737.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 12:13:03.1243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4bk5mCqKH1Yqk5ZbSSynE5SczNAz2TYJx4gbh4aWzU2Wp0w+V9LMhQHqe1ywfTiPIkUj9TqjW/9qs8YZI94u+zB6wEivRAiPr9aFXoAK/IA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2455
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

21.01.2022 13:18, Karel Zak wrote:
> On Thu, Dec 09, 2021 at 03:12:33PM +0100, Vladimir Sementsov-Ogievskiy wrote:
>> Since c7e9d0020361f4308a70cdfd6d5335e273eb8717
>> "Revert "floppy: reintroduce O_NDELAY fix"" commit in linux kernel,
>> floppy drive works bad when opened with O_NONBLOCK: first read may
>> fail. This cause probing fail and leave error messages in dmesg. So, if
>> we detect that openedfd is floppy, reopen it without O_NONBLOCK flag.
> 
>   I'd like to a little bit optimize the code in libblkid and reduce
>   number of situations when we call FDGETFDCSTAT ioctl.
> 
>   If I good understand the problem is read() with O_NONBLOCK, right?

My understanding goes no further :)

> 
>   I'd like to call stat() before FDGETFDCSTAT ioctl to make sure that
>   the file descriptor is really block-device etc. (libmount supports
>   regular files too)
> 

Sounds good. I see, fstat() is called in blkid_probe_set_device(), so you just need to move your code below fstat() call.

-- 
Best regards,
Vladimir
