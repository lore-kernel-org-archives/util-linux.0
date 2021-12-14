Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B296CC433FE
	for <util-linux@archiver.kernel.org>; Tue, 14 Dec 2021 14:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbhLNOYt (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 14 Dec 2021 09:24:49 -0500
Received: from mail-eopbgr70120.outbound.protection.outlook.com ([40.107.7.120]:2690
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234916AbhLNOYs (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 14 Dec 2021 09:24:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDOf000xSL+4Wi1oBLQw+dF1UxTK/Mmqo9txpwq2BVkaroPlRA4k2MPCV0APVZKnZF+4soTkgxIsD0jSICrDbvmsfeOqJvPrEs3qD/zjjz5xHu0BOuTcb5ZsPkLuGoUMpnNWI2zGdFJs072zwnFqXngzt5DU4gfIlFlS52Bt5VEGs+bt7Za2qdXwFcbL8/QxPSE0EwkUfvHcL4b4Dwewe6Igm6elUf91zKA3Hz027hEUq5MqaRrwyUCQ9cnI03+wqadHWKBWw2RZkKhxI/VMuwkkxk5cqeRjQPeEGO6Tq21a+IY5SoVM1EYtZW2mgn+bXLut9rWNM7iEWWDPyhY/XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rj/W+eFyBPOcx29HBFhNsNcbjKoTOUPL3vLXmqJB0t0=;
 b=U5bfLHPhXyOEenLOBNv7Hy8cN+1BzNKycBSieNyITJ0YUuGXdKZ1RT4L57hAxPkglvq9zxz4ucTnV60aFuBQWu7lod3O07O3VAzXYD8kUr+55/FSDJzed2ibAmEoiInINc+ypTvU+Z7CXzrW2841t+94RcckGNfLoMGJuTU4kZGpM5nL6UYh+WApemMa8O2wntmHZ9UZEmoitV6a/6DWwB9AO91BFIvSWScsgvclEoPnfF5hUZg8egy7memujLcqVKdgqtitr2RZF7OUe7WCtE90K+fkgyo/Su49jcaT6jsBPqyF5YkcDiwPXowVFH8/snYfslL55vfaUdzsuBc/bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rj/W+eFyBPOcx29HBFhNsNcbjKoTOUPL3vLXmqJB0t0=;
 b=GgcVaNAawjfvm3XNwrAuIf7X4TG/nw1FcfOf9CI5vmDg/iUDjQd6+MP1LTTIdlaqv0YSSfCWye4Gi1jDzmZPQ2AamDkAFiVPjD73G/+Q3mq9AUAFxYeSi+KgFht89ZMa53d0lmG+njvvsVpFuk+IvGjZcsgTZXvGIJrK/ganZSM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB6737.eurprd08.prod.outlook.com (2603:10a6:20b:304::18)
 by AM0PR08MB4514.eurprd08.prod.outlook.com (2603:10a6:208:13a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 14:24:46 +0000
Received: from AM9PR08MB6737.eurprd08.prod.outlook.com
 ([fe80::2078:5a2:1898:d83a]) by AM9PR08MB6737.eurprd08.prod.outlook.com
 ([fe80::2078:5a2:1898:d83a%7]) with mapi id 15.20.4669.024; Tue, 14 Dec 2021
 14:24:46 +0000
Message-ID: <a378a167-fd41-f74d-1b0d-b997b82df05c@virtuozzo.com>
Date:   Tue, 14 Dec 2021 17:24:44 +0300
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
From:   Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
In-Reply-To: <20211214120349.kntr7gza5flma5tc@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P194CA0040.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:84::17) To AM9PR08MB6737.eurprd08.prod.outlook.com
 (2603:10a6:20b:304::18)
MIME-Version: 1.0
Received: from [192.168.100.10] (185.215.60.230) by AM6P194CA0040.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:84::17) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 14 Dec 2021 14:24:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c91f5fa-4e55-4458-54bd-08d9bf0d7aae
X-MS-TrafficTypeDiagnostic: AM0PR08MB4514:EE_
X-Microsoft-Antispam-PRVS: <AM0PR08MB4514628F1A7CDE7EEB57B265C1759@AM0PR08MB4514.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tpQrhINQ2iG9Dy5b7F9QQx4olCo4pQkCyOdFFlcpfg3vqxf2tcqr3ljRr9yavfVuZTWc1NaQxaIeTHbt4xj7CreEYS+CTlwFwjQcWNaKe4jtf0qmAlPVHxqNG2jxhOkjWegq42ecEa8rx8QCWCSVt2+HFWtSQJJ+M+BdI2MKeZdnKs+J6z1qmbLJKrrytm595hZe8cKmd/N1s4uzVijoZpxYPMRgeE0jw7U4UDUboCAlvmMYJE843wR5Mtb61Wtw6mpXO66jte39u6WV37y9G7bm1tKIbuDK4zC71RUOFdvChWhRbkk2HRqhYBgbEEb9ftqbe8zmlBDyrmhyXSToUAMk0dhDS2z3LQcBp/J/483uQCFiqdj98a76xbZmPTqtmFgEHeKVYF3vvsmy37oAV1S29eT3b/0A7UGVki5jE/GrPZKFfxpy3KtCfTm1RZPWoViz1Gwjuf7OXTkkOWvoeADQ8puo2rTkb70VKS1Fsq/RTHzRCIKIbVkEYxErCTK7Ye/SI6gIJPt/GVyHJFfh8d8EsPUYgwmODwzYfRziMBPy3n7CH2eLzuuds7RfDez44bf+/TVtdjFdEsCKlDDojASrSQMUR8RT6yGHxikX5B1F3wjgtggI16/Br+5y4W3MU/TrOKqYWkPDrA99FA6Ftm1glvvC59gIDJFXzFuI6XNL7lx/Y+uCNLIiVQS+UWzpg0fVuLjVTjxAilv8cFkp6c+kfbEtjuAaxysE7dcscqiI6Iu9ZWNx/+qjKTg6mRFrSGEPVn7UXblnQ6jjQ+7dUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6737.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(4326008)(83380400001)(38100700002)(8676002)(2616005)(38350700002)(8936002)(5660300002)(52116002)(31696002)(86362001)(2906002)(66556008)(66476007)(66946007)(508600001)(31686004)(6916009)(6486002)(316002)(26005)(186003)(16576012)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlJFSDF0UTFnQjUxNk5CaXh5SXdxUXkyYXVkYW1ybnhkaW1HWld5d2IveS9Z?=
 =?utf-8?B?bW1GRktIRldEeG5OWk1HMUNOR0NjNjVFdkJmejg1MjExY3kveUFjR1NzQnVE?=
 =?utf-8?B?ZDhPUFFWcnAxTDYrU1ZKUUswc1ZNdkRvbFRzUUhTMGMxM1Y2YS91ZTF3OGJ5?=
 =?utf-8?B?NGFDZUFaS1hFMzJFdDRUQUdiaTgrSmxrMHNFUi9yUVRvUTVoRzVyZTVjM3No?=
 =?utf-8?B?N21ZWFZIbnN6M2VsU0diVjVqVjEzeFdsNDdiVVJmVXJ1NU1oVVBRN3lNUHd3?=
 =?utf-8?B?MEtnS0xEczVZRE4xc1VBem43UGNVRHhoYUpMU2I2ajhsdkk3Y3dyYjRPUU55?=
 =?utf-8?B?Vk15MExNNGNEdUZhUTZHS1N2TWdBRWpKeWlMbXdrbjZiWWhPTFRTbHdkeW5O?=
 =?utf-8?B?VXZwS2hFTFViYmpiWDFtSk1PemJycEYxenh4aVJLWnhxYkNTelBFRWNLRVR3?=
 =?utf-8?B?c3ZhbzJIeDFHaytURnFsMWl5dUsrU0pxamoxalQ5Ny8wRWw1bGl4Q0FXVjVP?=
 =?utf-8?B?d1BqeXNyMTZPM0V2WjVqU1k5ME1YaDh5RXBsVHprVXdweDFZeXNXWStRUzRj?=
 =?utf-8?B?elU5OXI3dmF2YTFBQmpHTUlpczBJT2tLdkFqdTdTcmJVUjdoL0szT1ZRUC92?=
 =?utf-8?B?Z3UweWI5aVlxU2piRkY2ekpZOStKeWt5bnBWeHM0aktYYXErbU4vZEdYSDVJ?=
 =?utf-8?B?SDRsd2dpK0MyR2N5cWJOUXN2YXZvZlJKS2p0ZGtzNlp6YjMyc2Y3cHFlR2tr?=
 =?utf-8?B?bjYrUTdUbDFqckRFYUw2R0tTaXNTOThGbDJueWpHanNkNjdzNHcyaXRKMXR0?=
 =?utf-8?B?S2pTVzExc29QQzBwQ3VWSFBSSW1vUWdlbUNmeVRScVlNNEpjYWhlNjBjVW5z?=
 =?utf-8?B?clFHY0Z2QVZLdThKNTZpbkF3NlA0eExnOU5yL3l1RWtIMlFYaG9ZYmt1RmNB?=
 =?utf-8?B?R051dTJwU0NrRHAzVVoycTBLYXE0T2lVbDhFVm43SUJpc2xqNDBHdFZMSkhD?=
 =?utf-8?B?QW1MUXAzeXZVSGdrZllPRWh2RFF0SURvTzk3WEt4OXc4Z0NCT1RwZHlSdk9X?=
 =?utf-8?B?eE41czhlU0hLaGJPR0Q0TzZpcTlDNHFrMk1tdWtWQmgyUHRwSlRlc2lhRWlI?=
 =?utf-8?B?Tkt1RDg1eXJXRzg5TEZpN1Y3aUIrVU9adGZ5cXU1MWlQTGVLZVh6ZURwRXBM?=
 =?utf-8?B?TTBtK3pMZ0s1cCtnMnJZd2ZhQ0hOeTVUdVJEU3JRdkVLUldQU0NpS1d1NHJP?=
 =?utf-8?B?ajZMMllxMVljaklaekZYZit4Z1VkdnZZMlZkSWVFalFLdFlJNWZGZS9mYi85?=
 =?utf-8?B?emIxdDc3YkVQdnhCZnAyNUVrZkxvdzJsSFo5aVBraFUxbGQ0NUhrWVAwZ0Yz?=
 =?utf-8?B?d1c5U2liUzNHY0Y5R0RXV1pzRlBhbXJoRWM2UVlBWkNmYUQ2cEVEMWljVzhj?=
 =?utf-8?B?R0o0UjBRQVVJUnZpQUZRbzJPZjZWZGxZbDZXUUsrV3lCVy9HbkFVcDVXZXIw?=
 =?utf-8?B?dGd0MmZFeEF2Qndndmh6Mk8rWlFQT1lJWXVGRTlKbnptLzZKcEtaT09QNDVt?=
 =?utf-8?B?T2RJTElQVDFiN0pFR0RBSHRjNW4vL1RWZUVPbkRDTUFqMXlpTE9UbzM2VENl?=
 =?utf-8?B?K3gzQVFxa3dhZmFJSWVHSy9xTVhwYVdvUmZOM0NzS1FnMmVTeTlONUs1Z01y?=
 =?utf-8?B?UnIwcGNjdEZEd3pwcGttTzBHdXNtUDB3QjM4eFBzYWtuV09BV2d0cDQ0ZlVK?=
 =?utf-8?B?RWpFNG9hZXVMeHZEM1c0cytuTlRkU0JzRVlVbzFMNkhHV1FhRUJBaVRtZXlU?=
 =?utf-8?B?ZkZsQkM1VTlHNE9ud3dZbGZZUmpEc0hibzQyWmhseFpnNEEweXhLTlN0Sk90?=
 =?utf-8?B?QnE3ekJYM3pxMk1XaWs2VEJSclBrWms5NDQwbkNTWWR1alVPK0swY2Nla3Vq?=
 =?utf-8?B?NUlBTWVTVUN1Z1UzZERWanZtL3ZvdDM3YnhEdkpqdGVKQTI2eUo4dHVSRzRQ?=
 =?utf-8?B?L2dRVG9aWmRrSnYwQXdna1FCK3d6NGlDbnJkazI2ZkpiM3dnVmw1enVnRi8w?=
 =?utf-8?B?NFFsZGo4OWVkN0VQcVFtTkFxUDkxWHpHQ1JNc1FsZk5xamhrTXZQd3VaZTZU?=
 =?utf-8?B?b0ZvMTBSb08wb24xUFdYVEpOdjJLVjZxeVN2ekltT0l5R2FlbWdiREhkemhQ?=
 =?utf-8?B?UHo3c2dKdjd6aUxxQVJDL3ZOR3NMc0tTOUIxZit0ejJ5dHB6OE1FWHNrUFZZ?=
 =?utf-8?B?anM0cGF2ZUp4TXpaZUhMeFFCY3pRPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c91f5fa-4e55-4458-54bd-08d9bf0d7aae
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6737.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 14:24:46.4107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cnTNuUQM5/Zitgo8vsVRfvA+g3qs2FH+we+EnjgojOQak3RRh+R5Aw2I2GZn/beJ3v5QSNo7u7YkxN4yIT4Fzrsdd5uUoljJUNS6Pzq+fcg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4514
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

14.12.2021 15:03, Karel Zak wrote:
> 
>   Hi Vladimir,
> 
> On Thu, Dec 09, 2021 at 03:12:33PM +0100, Vladimir Sementsov-Ogievskiy wrote:
>> Note, that this commit is done as a "minimal change", i.e. I only try to
>> rollback O_NONBLOCK for floppy. The other way is to detect CDROM
>> instead, and reopen with original flags for everything except CDROM.
>>
>> I also tried fcntl instead of close/open, and that didn't help.
> 
> What does it mean didn't help?

I tried it, but the bug remains as it was.. As I understand, dropping O_NONBLOCK by fcntl just removes this flag, to change further behavior of device to non-blocking. But it doesn't do any additional actions in driver.

In floppy.c the only place where FMODE_NDELAY take place is floppy_open(). So, we want to change the behavior exactly of thet open() call. As I understand fcntl() doesn't trigger floppy_open() call, that's why it can't help.

> 
> I guess that drop O_NONBLOCk in blkid_probe_set_device() for floppies
> would be enough, something like:
> 
> int blkid_probe_set_device(blkid_probe pr, int fd,
>                  blkid_loff_t off, blkid_loff_t size)
> {
>     ...
> 
>      if (ioctl(fd, FDGETDRVTYP, &name) >= 0) {
>          int flags;
> 
>          if ((flags = fcntl(fd, F_GETFL, 0)) != -1)
>              fcntl(fd, F_SETFL, flags & ~O_NONBLOCK);
>      }
>     ...
> }
> 
> Yes, it's a little bit dirty to modify FD in the library (if the FD is
> provided by the application), but if O_NONBLOCK is wrong in all cases for
> floppies, then it seems like a good thing.
> 
> This solution will fix the problem without libblkid API change, and it
> will fix it in all current applications.
> 
> The solution based on blkid_safe_open() means that we have to modify
> many applications. For example, systemd/udevd uses
>                                             
> 
>      fd = open(devnode, O_RDONLY|O_CLOEXEC|O_NONBLOCK);
>      r = blkid_probe_set_device(pr, fd, offset, 0);

Hmm, yes, that's not very good :(

> 
> The same is probably in many other places (mkfs-like programs, etc.).
> 
> What do you think?
> 

Maybe be we can get filename from fd reading it from /proc, then do open() and than dup() to old fd.. But that's even more dirty to do in a library call.



-- 
Best regards,
Vladimir
