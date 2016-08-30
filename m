Return-Path: util-linux-owner@vger.kernel.org
Received: from ex13.tuxera.com ([178.16.184.72]:50071 "EHLO ex13.tuxera.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751629AbcH3KyP (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 30 Aug 2016 06:54:15 -0400
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] libblkid exfat.c: Limit maximum number of iterations in find_label
From: Rostislav <rostislav@tuxera.com>
In-Reply-To: <5af8ca2ea7cc4a77b41171b457d32229@nebula-exfe-01.nebula.local>
Date: Tue, 30 Aug 2016 13:54:11 +0300
CC: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Message-ID: <ACC7F605-BFA7-4939-8310-A9548B00B234@tuxera.com>
References: <1472551669-14450-1-git-send-email-rostislav@tuxera.com> <5af8ca2ea7cc4a77b41171b457d32229@nebula-exfe-01.nebula.local>
To: Karel Zak <kzak@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


> On Aug 30, 2016, at 1:45 PM, Karel Zak <kzak@redhat.com> wrote:
> 
> On Tue, Aug 30, 2016 at 10:07:49AM +0000, Rostislav Skudnov wrote:
>> Do not hang if there is a cluster chain loop in rootdir
>> ---
>> libblkid/src/superblocks/exfat.c | 4 +++-
>> 1 file changed, 3 insertions(+), 1 deletion(-)
>> 
>> diff --git a/libblkid/src/superblocks/exfat.c b/libblkid/src/superblocks/exfat.c
>> index 01ed30b..e058423 100644
>> --- a/libblkid/src/superblocks/exfat.c
>> +++ b/libblkid/src/superblocks/exfat.c
>> @@ -86,8 +86,10 @@ static struct exfat_entry_label *find_label(blkid_probe pr,
>> 	uint32_t cluster = le32_to_cpu(sb->rootdir_cluster);
>> 	uint64_t offset = cluster_to_offset(sb, cluster);
>> 	uint8_t *entry;
>> +	const size_t max_iter = 10000;
> 
> for FAT we have 100 as the limit, would be this smaller number
> better?
> 
>    Karel
> 
> -- 
> Karel Zak  <kzak@redhat.com>
> http://karelzak.blogspot.com
As far as I understand, in vfat we walk over 100 clusters, each of which may have many direntries. Here 10000 is the max number of direntries we visit.