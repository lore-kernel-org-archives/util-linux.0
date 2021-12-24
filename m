Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3E4C433F5
	for <util-linux@archiver.kernel.org>; Fri, 24 Dec 2021 15:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353081AbhLXPbn (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 24 Dec 2021 10:31:43 -0500
Received: from mail-eopbgr60119.outbound.protection.outlook.com ([40.107.6.119]:42213
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353080AbhLXPbm (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 24 Dec 2021 10:31:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njuTAhQyVnZZctG4DUQn3BCU2waBPNenbwX6gaE2IccM0rcXGH2gCxVyY7WGVpisk61JT6qJpjGaI2g3EvOoib8MtdOxgXf8DQOMkRHAvc6iS5rKlLQBkwQZsukKU9Ky2yLXTe0q6LZr2AsoHd8WK+1LOoANqAfiNBNnao1F+rCKAxMwSvr+P45dEXxnEzplASJNNVMaqnQUgFrQFvwx4OmchE51zrF/huwW85XXLwb3NjRJVizTh72IavCMUB7MYicglqrZLVhk1Vdqmy5JSWvU1r2f3eERJo23OJmSor5GInIjx/Vh83X4yM8CSW7wigJTD9EbPiI/VTK9JwZVPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEXC3Co9d8ylC1J/GgcQEnbBgQNfzfZJs0vAdEV8MH8=;
 b=N5cefenUIZ1cjy5TyJ03k7VvvI5PsdD359kgpp6hvIkA1i0CK3AkVYKLRZYB+D2XyQJOgkhy/3fodiKwMPeDjN3e4ORHh+Pl2zKzBsa5HxrounmiLi8l2+HGDNd8sUR+CRozaqZqhUoT737dyjDuWMKea1tJKDtmS/hG/Hqmur90xYS5UtqRlHrxcg+CU1KqdcKMYBygqtULvQV2AkcspTQbN8NB3We09bSwJN1KyFesbyCsL77Gh61zaWH7vaDwd2ytkz0qcw01HayYypIm2gSZzY26+qzTwIvuZswulxaxgnhil3GH0n6ir8jRVPa3xmRwphCtZa5AvYW2WQ6ESw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEXC3Co9d8ylC1J/GgcQEnbBgQNfzfZJs0vAdEV8MH8=;
 b=EEnSWOorDGRK5oVU0MJGGnbaZQ3Zq5ETjbDWtkFVFx0Kx32Zj9TQco6f225h+zRC0uGtsrS66FNAtLN65vJ5vhgCVUXeOUec17aVSMcxCzX7pruQRdaF5vLSzmqtBToAKkEeItpESvZe7MtQscKWwh1GZMwe4jOrWt0epwiq3QI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB6737.eurprd08.prod.outlook.com (2603:10a6:20b:304::18)
 by AM0PR08MB4962.eurprd08.prod.outlook.com (2603:10a6:208:15a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.14; Fri, 24 Dec
 2021 15:31:40 +0000
Received: from AM9PR08MB6737.eurprd08.prod.outlook.com
 ([fe80::b118:483a:d003:3112]) by AM9PR08MB6737.eurprd08.prod.outlook.com
 ([fe80::b118:483a:d003:3112%5]) with mapi id 15.20.4823.021; Fri, 24 Dec 2021
 15:31:40 +0000
Message-ID: <23719c29-9668-1edc-e60c-a30bd821c7fa@virtuozzo.com>
Date:   Fri, 24 Dec 2021 18:31:39 +0300
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
In-Reply-To: <9dc07586-5471-ee5e-fae4-e177ceb114f4@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0113.eurprd06.prod.outlook.com
 (2603:10a6:20b:465::30) To AM9PR08MB6737.eurprd08.prod.outlook.com
 (2603:10a6:20b:304::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82b06a08-a844-4de3-0e93-08d9c6f27b7f
X-MS-TrafficTypeDiagnostic: AM0PR08MB4962:EE_
X-Microsoft-Antispam-PRVS: <AM0PR08MB49626946E6BCD3858CC6C88EC17F9@AM0PR08MB4962.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 73jaRuHoixkYTbcFwgZyqQwSXEIlZdGiOlcQBCC2kotw1mpFUaWgC7t5oMuCwWW9xHMOrdo+4u5zy4ZxL8uNx3qRp5rUbYRe06GSt6msyAXd7L4VOPkN0ZQpkMNRB4Ixu3s1okPLQxPnHQ1D6KkoTAUVOLMaLAOpoFNk3BHsnPsXw8NpYLEV1MRzyH9KfzxML5UQW2On0hX1ilmmoJxGTKU0kyb9qeJWWFDasgOpD5w3rKjzTnFg5MyUWNSDmC/dzZZDxgxO4xyhM2mGrBzgQwY4kurYoed+KF5OKAo+ID+b7tXykfwjmoUCU2AfVXhxQM+pPTpZW8BC050TQvQIbRe5X3yHLQtr1Y9Kl9I4QWOTIaBTzwmmM8oMP6l7SODbAM3sZcZrxy4iVrkf2XRyTY7z3CtX77c66xxdYEyA6kSWLBehq6L2iGRnkgDNpGDSUuwWQBc2PskZvWL5zOgI5fPNuGlj0O+Owha6M0gIUvPV/c/myfEr5y6Gkbp+FF2d55ciQJx81KO3jRnkqPkBWgPa2Wp2gI5u0SBguSEiFkb0d7ZrcUmkSpwN0NQYwGDMRRgjDWovQIG+YD30a5YeNXLnBjsBEm63u2JZjVUCuTf98akXqAuy6lSTu1qyME3yCNxKKwwu9ksyWSJbSeqwQhz+5ltEtEjl43GH62vNWDg2aewM9oQj2zXZv6fW7p2MLtT0HbtjhxG/48yCXgVY3uxGmtp+gMKg5HQMyopYiYFBgb+F0kky99F7pQP46xyLTMnWCx5xSJM3cUt9behdmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6737.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(83380400001)(316002)(36756003)(86362001)(6506007)(31696002)(186003)(6486002)(38350700002)(26005)(52116002)(508600001)(5660300002)(8936002)(6916009)(31686004)(2616005)(2906002)(66946007)(38100700002)(66476007)(66556008)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1pQUlhrcERodnB5WU5kNE10SjAwL0tkRTVETDByaFpCRnRqbjI2dnlnQlI4?=
 =?utf-8?B?QXloRFc4UlFYLzU1eTcwTEhlMkRIOVQybXVnUFc2WkdhUnlQNG9BOURlbDZa?=
 =?utf-8?B?QUFZRGpKUFBmZzY5TmM1bytSUjdtdUc5MnFaYzhObzVMN2pyWWRET1IveFVr?=
 =?utf-8?B?Q0VpdmJERGRWU3ltTFpIa2R5Skh3SkhhTTZYUEh6MEY4SEJEK2pUeDVPUXJj?=
 =?utf-8?B?L2VwZnZRaG82a2RhUDd2TllsenFzelRBUEx5ZTBJc2c2NzFiZFhwb3Z1M3NI?=
 =?utf-8?B?bkFKcVV0RlgyaklWQ0pPcEVmMXNmRUxBb1hMSUQyZGt1RGY4ckVkb0prcWdC?=
 =?utf-8?B?RWhDTEswMG83Y01qZXM1a00xMzN3SmVuU3RwaVNWSTFxOEpYZ3NJNU5ycFNR?=
 =?utf-8?B?cHpSeEJQbEozQStpUmhmMG11UUR6MjNjdE9IOFcyZmhwRm40azlTenppMXBi?=
 =?utf-8?B?M1FuNDVHcXJyTXovbkdPZXZXbStraEJPMDIwWS9HV3VkaGpEcnpUYlJ3Ujdy?=
 =?utf-8?B?ejhvV1ZuaFphY1FhS2o3SjJZWVBlUS9FU1VFaFJ6bWhreEF1QkVmTzE4WVNT?=
 =?utf-8?B?TGRSRlFVYnJjb2wvczY4cDI1QVMwL3o3akFvUk52dkpqUk92clFIRm9BMkpz?=
 =?utf-8?B?OGpWK1dyVFZCNTRxVDA0V1dpVmFRWUs2c3gvNlBrYjNCaU4rOVBMYzVhMEVs?=
 =?utf-8?B?N0tSenFFa05zZjAyNjhkNzV4d1dreDRGVEljZE8rbXdkVzA5QVowU0pLYlBJ?=
 =?utf-8?B?RGwzRWhla1l1amFrRVVqSzg1YjhPVExlYnJOSlhhZW15RjZ3dy9ROVpYSmts?=
 =?utf-8?B?eDA1dUJYU3VsZ0dodmNUMldVUW1GU2hRWVRiT3dPRGJjdHJEMmpyZVFCaHA5?=
 =?utf-8?B?d0JCQUp6ODl1TFYvTzFtalFBRlc5REJjVzU3S2Z5VjkyU0UrcUNxUzdGc2tW?=
 =?utf-8?B?S0hyM05RMnRWRllJQys1SHRDaFVRMlRxdmxIYmg1ZUNvMjY4YzVGMHI0cUtL?=
 =?utf-8?B?K1lHTmtSdkl3WTlJRlppSitmY2F4UUM4c3NVMmlWVUhwNmFNWDZ6WVFpRXZS?=
 =?utf-8?B?QzZSZGtHcWlOQnpyNzB2aUxEOTZ2ckpaZVN3M3JPYjJTZjFrTVpZbnhYVXBI?=
 =?utf-8?B?UWVLNDczRkdMSnBGTk5ZdSt1QUVXUHlNb1RVaXM1b0RQUy9xQURyZXdWdEJp?=
 =?utf-8?B?ZUU4bzI0K3VnODdZdXpKYzBxTWhXV2kzWGFKQWQ2MG9hdGRCZGEyZjI5SSs4?=
 =?utf-8?B?UC9IZnd6MDRySzNSZjBlcFJaWGk4QWc2U3JiT2Z3anhqOWgrbDF4T2NTV2cy?=
 =?utf-8?B?Um83WXptMlBiMVhIL3R3cGJHSjNrVlZaRm05VDJUeis4NEIxUW9wWUYrUFpw?=
 =?utf-8?B?TStsbktPSUZRV3BYMnF0ZVN3cmpOTW5DQXhod0VGZWN5KzZWSHdWbzdsS2Ux?=
 =?utf-8?B?bzJRN00xWGhYTGZYVXNrMXZib0N1WUd5Y05ydnlSa2lNZ3YraFYvZEhZUW9i?=
 =?utf-8?B?a3BlYVUxK0R2LythYXA4MklMNUlIcG9ZUlZERDRnVFZTcGdTeksvR08yR0tU?=
 =?utf-8?B?Z3YzZHhKNWt3VmZpRVpWbjA1TXY1bm9xL3FOVUg5NmJ2ZlRNUEhMUkN5dWpB?=
 =?utf-8?B?VGhJb3A4VTN2UlVVWCtSVDNaM245eUR2TnROc0NObXNpNVhtclIxMFNhcnIx?=
 =?utf-8?B?VVlHTmkzQkNaYi9xbmhtaDdWTS84MVB2UnIwcmRzM0N3SEJtcm93dlc1U0RL?=
 =?utf-8?B?VkxQVEQ0eUp1QlROK3pVT0xRMllzM2loQS9DbGFiQ3YxL1Bqc1RTbFNzdDdJ?=
 =?utf-8?B?dExOZWNleWdEd1NzbDBuNlB5Q2t1WFNYM2NtWTUzc1VYdXlieFF3Z0tWNVR3?=
 =?utf-8?B?Tm0rRU1lNlRIS1VUdlJOWmR5TC9RcmF0SjdiOEg3VHFVbll6bmhxc0tyR1Ux?=
 =?utf-8?B?RUZ3UHkwWXdIQm84WTB5cUVVMnVRZGFaOWNMN2tlbXpNa1RUM2xUN2w1RU1C?=
 =?utf-8?B?THFHVXoydEtVYWdwNXlKeU9SMXFLOXlIc3FHdDgyazFieFpEazhLUGhhTlVX?=
 =?utf-8?B?V2ZHaVhXN29TQU9kNVlzQUFGS1o5RE4vODVKdHRxSUliY2RJaDVvWURTVFlW?=
 =?utf-8?B?aEpMNjRScGZ4TURGNkpMRWloY0RRNkU0NktFV1U3U0tMS2Zmb0NyU1ZnY2Nq?=
 =?utf-8?B?SE1XU2hsVEpmamVpOGhRbXhhZTVmVkwwRlUrNHVoTVNYdmZENE5UbDhheDdC?=
 =?utf-8?Q?3FF7sPsyUfoB5k29tzP/SNNxjCSkuV42jYgvmZGk6M=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b06a08-a844-4de3-0e93-08d9c6f27b7f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6737.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2021 15:31:40.7663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: faVwS2px0ZnGodi4W9HOqqTKHij+El9nrFDdV/hot5znxDmTtxjEYwsy5UnHq0XCa+IjRlt+gzwcRVLRADrQy3PiOqIOzNIe9vPrD+6gb9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4962
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

16.12.2021 11:47, Vladimir Sementsov-Ogievskiy wrote:
> 15.12.2021 15:56, Karel Zak wrote:
>> On Tue, Dec 14, 2021 at 05:24:44PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>> What does it mean didn't help?
>>>
>>> I tried it, but the bug remains as it was.. As I understand,
>>> dropping O_NONBLOCK by fcntl just removes this flag, to change
>>> further behavior of device to non-blocking. But it doesn't do any
>>> additional actions in driver.
>>
>> Hmm ...
>>
>>>> The solution based on blkid_safe_open() means that we have to modify
>>>> many applications. For example, systemd/udevd uses
>>>>
>>>>       fd = open(devnode, O_RDONLY|O_CLOEXEC|O_NONBLOCK);
>>>>       r = blkid_probe_set_device(pr, fd, offset, 0);
>>>
>>> Hmm, yes, that's not very good :(
>>>
>>>>
>>>> The same is probably in many other places (mkfs-like programs, etc.).
>>>>
>>>> What do you think?
>>>>
>>>
>>> Maybe be we can get filename from fd reading it from /proc, then do
>>> open() and than dup() to old fd.. But that's even more dirty to do
>>> in a library call.
>>
>> Yes, re-open() sounds like a possible way.
>>
>> The dup() is not necessary. The library already support private FD for
>> probing. See blkid_new_probe_from_filename() and BLKID_FL_PRIVATE_FD.
>>
>> It's also often used when the library probe whole-disk device (when you
>> probe sda1 than it also reads data from partition table on sda). In
>> this case it opens a separate FD.
>>
>> It's for floppies (0.001% of all cases). IMHO re-open is good enough and
>> better than force changes in all applications :-)> I'll try to prepare a patch and ask you for test/review. Thanks!
>>
> 
> Great!
> 

Hi! Are you working on this? If not I can try to make a v2.

-- 
Best regards,
Vladimir
