Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEF9C433F5
	for <util-linux@archiver.kernel.org>; Tue, 14 Dec 2021 13:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbhLNN64 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 14 Dec 2021 08:58:56 -0500
Received: from mail-eopbgr10126.outbound.protection.outlook.com ([40.107.1.126]:15270
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232428AbhLNN6z (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 14 Dec 2021 08:58:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0euwYrAHlgVYcuEYF/BR9V5gIReYVDYlxIC3Vb+dQ/s6Z1v3PideN+/hflo99GkeYvSJcbsj0T+MsxF6P6nCXXIHEi4Y1wppC4vks5fjHc8AOFezoOknfGeFw0GTBEjTaggFpA4G0nNaTJaZuzheVn/xIA5rEaihIh2szh/RTgyVmVIG+Okjlwf4EdPGfmeYsvO2IsjfwLhd6Lt+R+dtoscYsmipnz/gcRMnRzh1qQKluqzeOlED5h+IYtcZhTUOhJq7X6/21h9IDdorSMnxok44TJJssY+RuyyWlzCWciWGU42Xl5bnXPFlEjbVGfMLyEE6OOocUu/lscE97Qwlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qY9yeLzIBy3YBkgvx8FMgCpUk501J+JBV1Z1XaadRuk=;
 b=kyyVL1gDT8TKIFvCTmqqtOmSfuB50OLcwzCRswffBJNC0jZyj3fZkKAHPdBuDno9sK6wCFmMT7EPng23BvBsrFK0whXO44gyx94zZM8MEUhTZRDw/2mjMBLjggyXxQTOZ652ZXHnqfXGjUSYE8Uiu+QLuB/Ht/4r7dFvU2lp5b9UBhV/15p3cBxlHE+EiPrCaGlzhGdoxQa4jyzPaYISs4+vXMKFQ+ChuiSEVz3rj3+PwtX2FsymXmO4r6KySl074Ot57RgPSS4fwrMcPiT069tG+E1JB0GGBqjmiUht7EbFeR9b31+XEbhf129+piJKrq1MYFjPsQQyaznJcjegkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qY9yeLzIBy3YBkgvx8FMgCpUk501J+JBV1Z1XaadRuk=;
 b=hRUM6NWmv7NCdQ2ATurhaJ4xYg1sKo7gZnoqvd9s+lmA/PG8yXXTPUsTIhZPjv21Waxnq2dJs0WynTI60lfMMOGVUZwwv6LjAIoX936sW2RuPcDeJ3XDB1nUl8iW3f+qaHQy5aK64rdTg9j8LUoHNDe0HThxdL94BTis+arVhmE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB6737.eurprd08.prod.outlook.com (2603:10a6:20b:304::18)
 by AM9PR08MB6050.eurprd08.prod.outlook.com (2603:10a6:20b:285::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Tue, 14 Dec
 2021 13:58:52 +0000
Received: from AM9PR08MB6737.eurprd08.prod.outlook.com
 ([fe80::2078:5a2:1898:d83a]) by AM9PR08MB6737.eurprd08.prod.outlook.com
 ([fe80::2078:5a2:1898:d83a%7]) with mapi id 15.20.4669.024; Tue, 14 Dec 2021
 13:58:52 +0000
Message-ID: <81af7eeb-f794-1ac2-40c2-81f4f7d79a16@virtuozzo.com>
Date:   Tue, 14 Dec 2021 16:58:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/2] libblkid: reopen floppy without O_NONBLOCK
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc:     util-linux@vger.kernel.org, jkosina@suse.cz, kzak@redhat.com,
        kurt@garloff.de, den@openvz.org, efremov@linux.com
References: <20211209141233.3774937-1-vsementsov@virtuozzo.com>
 <20211209141233.3774937-3-vsementsov@virtuozzo.com>
 <20211214114533.GW117207@kunlun.suse.cz>
From:   Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
In-Reply-To: <20211214114533.GW117207@kunlun.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9P194CA0008.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:20b:46d::27) To AM9PR08MB6737.eurprd08.prod.outlook.com
 (2603:10a6:20b:304::18)
MIME-Version: 1.0
Received: from [192.168.100.10] (185.215.60.230) by AS9P194CA0008.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:46d::27) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 14 Dec 2021 13:58:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa01fbfe-28cd-45da-14e6-08d9bf09dc73
X-MS-TrafficTypeDiagnostic: AM9PR08MB6050:EE_
X-Microsoft-Antispam-PRVS: <AM9PR08MB6050B69AE7203FA366883A64C1759@AM9PR08MB6050.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P5LWPxGAKuvEfzKzQ7UxETZJk8S6n4PS6NW8vNl5+KKsevvItXq90UfEaJ/N63rtvtiTwiKLlap0av3r7fNZGfqQXmhIJEaGFuLlvVQpVV5K5+IgOa4RNNkDS6wvaEWnlx/V0oSPz7J+9mp5fyffb1RSZd41whMxra90XG7YiPqdupVLGReHnl+QVzmXnsB1Kfma+8nmmhtRwkBPebNlbTZrIQsm0TtT6t6ydZHA8ik/Ci+jDhILt6kWPjqYgTD/IkGrNh3ODANIxFG+OQjoXfVQVD+qYAO5IziHqOiZANMXyTGW6vbsWQBUfx8Vdg95VrfjYGuWGytUPn6I92P6gqu3gQv7xkt/YO9eYTEXwabBPJ/0937H374Dxcv2PA4jKNVhGAdbQscPXb/H0a0RWaDJ1EbsRrsfB/ZNBHLKCzrPfoFKETuWh9RmjKLN1gW0ehr/6EA6b7kZRrpVZb5todAMqLRIe4gnLHSlvvdAY+WMMIPW56oqp8egTBpY67UqoUR9f+9PakEbQr5Eu5/guudKs6UIvaitcwzPAgf1VhBl8TQVDmpPDF7PBkQCzibQ/dV6qMmmwkrT5dzj2Gdf+9SUQ4pxclO4hspsRCZ+Mnk/K2zlvV1Bo5l3fegEc7S6z0X1ZXB4jcLQELw3M951gKs05XkW2BRCb+N/0R6QGtLp6spWCJfuu4sXueaOZM5EfBX8CPhVBfmY083Dw1bFi5PY3gRAIxcKC8lrAhwv7qrYji65oi+rFSAm/x2SJxiAbGUmurN8QVrqf1OtAN1gi6OlIcqiAb/7Kt3UYQdpgazy47hRI9ESa2GIkVTrXhS9AHaxkjauwC8jSD606NCayDIsMW8a/JGEb5wM6t24aE4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6737.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(16576012)(4326008)(966005)(26005)(8676002)(6916009)(316002)(52116002)(38350700002)(86362001)(66556008)(38100700002)(186003)(508600001)(36756003)(5660300002)(956004)(6486002)(66946007)(2616005)(8936002)(83380400001)(2906002)(31696002)(66574015)(31686004)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE9UcXkrQitrWXViVm9iODRLbTgzMC9YWFBMNXZOM2wwaW9SOVNLSHFhYmRY?=
 =?utf-8?B?M29PVDg1Y3ZZTWtNM24rdVNpZEpZbnpOV3hxMnpITytpYnl0d0QxUW9WN0Ix?=
 =?utf-8?B?aTdrWlVha3FxcDJzeXVLQU0rbHNIWmFxRS9lY0NLS3FYdXA2bHNlbEkrMnNa?=
 =?utf-8?B?bG1GOEsySC9MOW94U3NVQjR2akxwNHFFTjYwSURSbDdxejRDbDZFY2hyN2dQ?=
 =?utf-8?B?c2ZRS3lYMjd6dW5kaWZIYzhsN2RjVEphbTFYSUpvQ0ZhTGVEc3RLZjY4OFBX?=
 =?utf-8?B?UFZNZ05GL25pZVhMdXl0eHY5ZUpsbWIxdjhYUjc0cklQbG5DNWc0Vmxab1NT?=
 =?utf-8?B?bDkyVGxHTDVteHBsZ3REWlJFUlBsR3JRTzNWTytvQUdadmVSclZzRlhqcTFR?=
 =?utf-8?B?NXZzYWM5dERBWmhGcGNjR0pKcy9haG9tNFpKKzJTUHl3Ukd5ZklJVm1neU5I?=
 =?utf-8?B?aEdYSFdBclhNbUphYTQ3RUFFZ2MzN0xLZDlGWmZDU0NmbWZtZEMxWFFxWFBC?=
 =?utf-8?B?aG1sZXJoVEFSVTczWk9tWnNOOHZINGZHSnBIZmhIRTBTY3F5ZU5tL2FqeEhx?=
 =?utf-8?B?QlNJRHB0MUhlb2YxSUhFQzI1aWxoZ1RxT0VBT0ZvbWI2djlCb3FjclBEaDlH?=
 =?utf-8?B?bUErOUxvTGZjUURiSmhGZmErb2xzSzVFU1AzV050Sk9PRFhWUDZpYnFzRXVQ?=
 =?utf-8?B?S2FOa1ZQbS9oWnRab2JyQndiVHZWRzVVSHZCMkRJcE44ZmxDRmwrVytFelNH?=
 =?utf-8?B?L2JZMXlWNWIzNnM1RGdRc2w4TFFMZDFKZlJSaE9obE52ZE1XV2FOcitZd0sy?=
 =?utf-8?B?akticmpjRGVwamY1azJzTnhwOC9Hd0NRdUJXa043U2lydURpVTZZL3ozSm9X?=
 =?utf-8?B?NmhXV3N2ZHA1SGhvMnRvc2EvemxQZTJadWdaZkNEZldybFgxdS9MRHNFWU9h?=
 =?utf-8?B?d01YS1NOd1RGdlpPUEFUai8vaXBRSEF6L2I2Q0Z1RU5mSDZlVjR0Qm1Bc1Vp?=
 =?utf-8?B?dHVESjAwWWE0VVMxczF0enRiOGhQZm9KM1N0SENZb2p4dkZqTi9GMmM3c3I0?=
 =?utf-8?B?WUxQRVhUQnRwZTFNbk9FeGRaWC9LcmJBeVdKcVhUWC9YUTJodG9nV0M3RExY?=
 =?utf-8?B?UEdQTTR6QUliZW1LMGROdFEzUTlidnhmRmliYTk3eElmMDdlWndJREVkeE53?=
 =?utf-8?B?dk5iL1dVaXRJUWJPU1hOUFFOVnRzQnNYWEJ4VVNKZlVPQ3ZwVExxcVFVaW5w?=
 =?utf-8?B?dXYwWXJab09CUExPVGNrVWRUUm9OVDBWMVpKd29tWEdYOW55Z2hTVTFaUG1s?=
 =?utf-8?B?YTFJV3NrQWo1amZiQ2tNK0svSWlhd1YzTllWc0RYN0FNY0NsS0dsT2dCc2li?=
 =?utf-8?B?Qk9peFJjeU9YeHIwMEM4UGJhdU5sYjlqUTVRWlQ5QWxRbnkwUTJSR1A2UTVW?=
 =?utf-8?B?SFplaUZHckozWGwxWjhXQXFJcWZDcFZlSnV3dklVMkh0K1pFRkZtUERtQ2p6?=
 =?utf-8?B?bGVXZ09kbjhUc1B0cU9Zb3k3cVRiamEvT2ZYdFI5b1VuV2UzdnpQVUtWWkE3?=
 =?utf-8?B?ZVBSQ0w0SUpreVpyQU9XbFNCd2hSZzV3b3hlaDg4WUk0RUtKOHBrTU82NjZM?=
 =?utf-8?B?MzlZUXFWSkpFQVpkVGc3NmtvcVRSamswZ1NYTExKWHdxei9TQUp4VkwwRjha?=
 =?utf-8?B?TlB6TFhUaXdoRFU2eDdMQmxFWitPWDF2Sk1PS1ZxTVF6U0R6cEI3ejRsTkhU?=
 =?utf-8?B?c210TTRPQUN4OUtxU0pFc0UyT3NaNTdSaytaNWNHZUpRN1VjTEFOeWZOVjRq?=
 =?utf-8?B?Z0ZtOWk1VVJhUndJTWJINVlwVXhpL1VqRklwS24xanNSNDBpUlpxRmwxM1lk?=
 =?utf-8?B?RGZ1cGF0N01va0tqUExON3puaTFwQUV2M3l5aGZsSDdQZEZSUFd4OEUvZ3E1?=
 =?utf-8?B?WTlUM2dPUGs2Ti9ZOU1rc1FRcG1HWEVEb2szR3ZlN2NHM0M0SWdaTnNUbVcz?=
 =?utf-8?B?Zi9TSW9nR2Uva1FFRjlKNTZQd1ViVkdUT2xkVVVsTUlmekpMc3hmM2pzUmUx?=
 =?utf-8?B?eERDUXF2dFVWVlRnNkZzU2NUYVJnM21XNHZvSHExMDdFcXBLYjBhNGhWNnlm?=
 =?utf-8?B?WjVPRXFhdWtLc1RhNElTRjNER24vbDEzeExxeEdubDBQOTdWVDcrS2wvTlBn?=
 =?utf-8?B?UHVmcEhqTFhuSE0wMkRMZDFxbEdER0JlcFN2SGErUk5mbi90YUdBS2pHRVVU?=
 =?utf-8?B?Rll0c0xWS1NwcDN0V1NIbUw5Mit3PT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa01fbfe-28cd-45da-14e6-08d9bf09dc73
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6737.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 13:58:52.5488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eEVT22hFIUa/6jEorUUT2qaOkyA3MLqwUKRRPjs0DKsXwnf4R+01GLIH+UnsE7vthxMa7DxPnOii6+vUKz9SmEUtuki5UTAo+4dL4uaBZNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6050
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

14.12.2021 14:45, Michal Suchánek wrote:
> On Thu, Dec 09, 2021 at 03:12:33PM +0100, Vladimir Sementsov-Ogievskiy wrote:
>> Since c7e9d0020361f4308a70cdfd6d5335e273eb8717
>> "Revert "floppy: reintroduce O_NDELAY fix"" commit in linux kernel,
>> floppy drive works bad when opened with O_NONBLOCK: first read may
>> fail. This cause probing fail and leave error messages in dmesg. So, if
>> we detect that openedfd is floppy, reopen it without O_NONBLOCK flag.
>>
>> Reproduce is simple:
>> 1. start the linux system (kernel should include the mentioned commit)
>>     in QEMU virtual machine with floppy device and with floppy disk
>>     inserted.
>> 2. If floppy module is not inserted, modprobe it.
>> 3. Try "blkid /dev/fd9": it will show nothing, errors will appear in
>>     dmesg
>> 4. Try "mount /dev/fd0 /mnt": it may succeed (as mount not only probing
>>     but also try filesystems one by one, if you have vfat in
>>     /etc/filesytems or in /proc/filesystems, mount will succeed), but
>>     errors about failed read still appear in dmesg, as probing was done.
>>
>> Mentioned errors in dmesg looks like this:
>>   floppy0: disk absent or changed during operation
>>   blk_update_request: I/O error, dev fd0, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
>>   floppy0: disk absent or changed during operation
>>   blk_update_request: I/O error, dev fd0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
>>   Buffer I/O error on dev fd0, logical block 0, async page read
>>
>> Note also, that these errors also appear in early dmesg messages, if
>> probing is done on system startup. For example, it happens when
>> cloud-init package is installed.
>>
>> Note2: O_NONBLOCK flag for probing is used since
>> 39f5af25982d8b0244000e92a9d0e0e6557d0e17
>> "libblkid: open device in nonblock mode", which was done to fix the
>> issue with cdrom: if tray is open and we call open() without O_NONBLOCK
>> the tray may be automatically closed, which is not what we want in
>> blkid.
>>
>> Good discussion on this bug is here:
>> https://bugzilla.suse.com/show_bug.cgi?id=1181018
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>
>> Note, that this commit is done as a "minimal change", i.e. I only try to
>> rollback O_NONBLOCK for floppy. The other way is to detect CDROM
>> instead, and reopen with original flags for everything except CDROM.
>>
>> I also tried fcntl instead of close/open, and that didn't help.
>>
>>   libblkid/src/probe.c | 27 ++++++++++++++++++++++++++-
>>   1 file changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
>> index 70e3dc0eb..68a644597 100644
>> --- a/libblkid/src/probe.c
>> +++ b/libblkid/src/probe.c
>> @@ -94,6 +94,9 @@
>>   #ifdef HAVE_LINUX_CDROM_H
>>   #include <linux/cdrom.h>
>>   #endif
>> +#ifdef HAVE_LINUX_FD_H
>> +#include <linux/fd.h>
>> +#endif
>>   #ifdef HAVE_LINUX_BLKZONED_H
>>   #include <linux/blkzoned.h>
>>   #endif
>> @@ -200,10 +203,32 @@ blkid_probe blkid_clone_probe(blkid_probe parent)
>>    * We add O_NONBLOCK flag to the mode, as opening CDROM without this flag may
>>    * load to closing the rom (if it's open), which is bad thing in context of
>>    * blkid: we don't want to change the actual device state.
>> + *
>> + * Still, since c7e9d0020361f4308a70cdfd6d5335e273eb8717
>> + * "Revert "floppy: reintroduce O_NDELAY fix"" commit in linux kernel, floppy
>> + * drive works bad when opened with O_NONBLOCK: first read may fail. This cause
>> + * probing fail and leave error messages in dmesg. So, if we detect that opened
>> + * fd is floppy, reopen it without O_NONBLOCK flag.
>>    */
>>   int blkid_safe_open(const char *filename, int mode)
>>   {
>> -	return open(filename, mode | O_NONBLOCK);
>> +	int fd = open(filename, mode | O_NONBLOCK);
>> +	if (fd < 0) {
>> +		return fd;
>> +	}
>> +
>> +#ifdef FDGETDRVTYP
>> +	{
>> +		char name[1000];
> Hello,
> 
> I wonder if it's better to use FDGETFDCSTAT which seems to be meant as
> stable API.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/fd.h#n271
> 
> As is this allocates 1k from stack and can be presumably called from
> application context with arbitrarily deep stack so it seems a bit
> wasteful. floppy_fdc_state has under 60 bytes.
> 
> Also if you are not interested in the result you can make the buffer
> static. Not sure it makes sense to bother if the buffer size is
> reasonable.
> 

Thanks for advice, will do for v2. I'm rather far of kernel development, and not fan of floppy disks:) So my choice was "something I can understand from drivers/block/floppy.c and which never fail". I tried FDGETPRM (because it used somewhere else in util-linux), but it fails in described case.. and in kernel code it's obvious that it may fail.

> 
>> +
>> +		if (ioctl(fd, FDGETDRVTYP, &name) >= 0) {
>> +			close(fd);
>> +			fd = open(filename, mode);
>> +		}
>> +	}
>> +#endif /* FDGETDRVTYP */
>> +
>> +	return fd;
>>   }
>>   
>>   
>> -- 
>> 2.31.1
>>


-- 
Best regards,
Vladimir
