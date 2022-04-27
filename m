Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28D9C433F5
	for <util-linux@archiver.kernel.org>; Wed, 27 Apr 2022 04:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbiD0ENa (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 27 Apr 2022 00:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbiD0EN3 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 27 Apr 2022 00:13:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E20976376
        for <util-linux@vger.kernel.org>; Tue, 26 Apr 2022 21:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651032617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KE6cif7WBLcfx22PAnXCgtbqneKFBEUtlDrNMgZ5okI=;
        b=OBoBtZqRwlpAK5X/kO7MaHUkkmEMu9aszMOsDOyTymL+1qHkd+BNtpcoA22cn9GcA3OLui
        Zl0QxoygCmjimhqcN4k2bUcGQqSBMXqPHy7Q9WpC8LohrmlYjAzMR4kR6HcJRjeB+7NIHY
        ZdHm1hmrA8edulTMYG35aMwAK/nbYaE=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-424-gcXJwMfAOzmeZOF3Cz3m4g-1; Wed, 27 Apr 2022 00:10:16 -0400
X-MC-Unique: gcXJwMfAOzmeZOF3Cz3m4g-1
Received: by mail-io1-f72.google.com with SMTP id g16-20020a05660226d000b00638d8e1828bso1017960ioo.13
        for <util-linux@vger.kernel.org>; Tue, 26 Apr 2022 21:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KE6cif7WBLcfx22PAnXCgtbqneKFBEUtlDrNMgZ5okI=;
        b=mpAOZD+qRLrU7Hk9Ku+po1AQZNhyDIjVkYD0j2qYf/txbwjsWwSueve0asq9iN0G0g
         YdR5yG6bcdDmPJ5AReUK6UdZT8g5eqOgbS9uLRf3Kb3auPuZqOjjSlIvDRBrmtd4ABVa
         5cEQFt9oZvtxXo9DuYxDWn5u3q7ve5ksiA8mBesiHsGl5GDcupGmRBZFD/Uq/Dd3scEG
         szSIoTzX4XWEm0De+L5Vzz0MStKmTmb4X7C8GE6/dm227wiyto6zJRWYuAAJaETk2pTR
         QBXJDZTDAUOnhwEvPWaRzl+1oooD6bxNR0T/scdL3+kNR+TOH8SQKwEkZQLFjZU75NS2
         m6Kw==
X-Gm-Message-State: AOAM533lB2qaerO5PLvhESbge76loTuebxrQ7sEegwSfC063ddcXPqNj
        RNb4MVK3MkDYpD8wMm5YVpTXg6t70zgWVvLG1PX246en6zFPJzGShDZBcaGqkZdyUqqQJdQSYNc
        dSBlupLPcL/0ENyqYSaLeAg==
X-Received: by 2002:a6b:6e13:0:b0:654:a166:2251 with SMTP id d19-20020a6b6e13000000b00654a1662251mr10544653ioh.149.1651032614892;
        Tue, 26 Apr 2022 21:10:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXLJPd+LlOro1pZfZpcC7RIXAGsP5rxRnVWQevzpcnY+U2WM/2rwRInecb+PtnGhUCNnnrMQ==
X-Received: by 2002:a6b:6e13:0:b0:654:a166:2251 with SMTP id d19-20020a6b6e13000000b00654a1662251mr10544647ioh.149.1651032614625;
        Tue, 26 Apr 2022 21:10:14 -0700 (PDT)
Received: from [10.0.0.146] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id w15-20020a056e021a6f00b002cbfa8b4b9csm9007670ilv.61.2022.04.26.21.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 21:10:14 -0700 (PDT)
Message-ID: <facb3c36-0088-d645-6162-4d52fc94557f@redhat.com>
Date:   Tue, 26 Apr 2022 23:10:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH 0/2] libblkid: add FSSIZE with XFS implementation
Content-Language: en-US
To:     Andrey Albershteyn <aalbersh@redhat.com>,
        Karel Zak <kzak@redhat.com>
Cc:     esandeen@redhat.com, util-linux@vger.kernel.org
References: <20220421130946.318737-1-aalbersh@redhat.com>
 <20220425134329.ub3thxkscsniy74e@ws.net.home>
 <8b2a82b2-8890-1276-9948-d8c28fca3d9b@redhat.com>
 <20220426082104.fojzjdfprbb2dth7@ws.net.home>
 <YmfPPbgZtZi1iSXv@aalbersh.remote.csb>
From:   Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <YmfPPbgZtZi1iSXv@aalbersh.remote.csb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 4/26/22 5:53 AM, Andrey Albershteyn wrote:
> On Tue, Apr 26, 2022 at 10:21:04AM +0200, Karel Zak wrote:
>> On Mon, Apr 25, 2022 at 10:38:02AM -0500, Eric Sandeen wrote:
>>> On 4/25/22 8:43 AM, Karel Zak wrote:
>>>>
>>>>  Thanks Andrey,
>>>>
>>>> the code looks good.
>>>>
>>>> On Thu, Apr 21, 2022 at 03:09:44PM +0200, Andrey Albershteyn wrote:
>>>>> I had a look into other fs, like ext4 and btrfs, to implement FSSIZE
>>>>> for them, but I think I don't have enough expertize to do that as
>>>>> they have not so trivial metadata overhead calculation :)
>>>>
>>>> But it would be nice to have ext4 and btrfs too. Maybe Eric can help
>>>> you :-)
>>>>
>>>>     Karel
>>>
>>> For ext4 something like e2fsprogs does is probably ok:
>>>
>>> static __u64 e2p_free_blocks_count(struct ext2_super_block *super)
>>> {
>>>         return super->s_free_blocks_count |
>>>                 (ext2fs_has_feature_64bit(super) ?
>>>                 (__u64) super->s_free_blocks_hi << 32 : 0);
>>> }

Whoops, I mis-pasted, that should have been:

static __u64 e2p_blocks_count(struct ext2_super_block *super)
{
        return super->s_blocks_count |
                (ext2fs_has_feature_64bit(super) ?
                (__u64) super->s_blocks_count_hi << 32 : 0);
}

(blocks count, not free blocks count)

> If we want to mimic statfs(2) + lsblk, then, I think this one won't
> be exactly it. I suppose s_free_blocks_count contains number of not
> used blocks which will vary with utilization... The statfs()
> calculates total number of blocks as total_blocks - (journalsize +
> each group free space). As far as I got it, both journalsize and
> group free space is not so trivial to calculate.

(Sorry for mixing this up by pasting e2p_free_blocks_count)

Ok, so I'm remembering what FSSIZE does in lsblk now :) it simply returns:

	dev->fsstat.f_frsize * dev->fsstat.f_blocks

i.e. calculating the value based on statfs values.

This does get a little tricky for ext4, because statfs "f_blocks" is
affected by the minixdf/bsddf mount options.

ext4's f_blocks statfs calculation looks like this:

        buf->f_blocks = ext4_blocks_count(es) - EXT4_C2B(sbi, overhead);

the default behavior, bsddf, subtracts out the overhead.

The overhead is a little tricky to calculate, but I /think/ it's precomputed and
stored in the superblock as well for (newer?) ext4, in the s_overhead_clusters
field.

So I *think* you can just do:

(block size) * (blocks count - overhead)

and get the same answer as statfs and lsblk. Does that work?

(Getting block count is a little tricky, because it may be split across
2 fields; s_blocks_count_lo for the lower 32 bits on smaller filesystems,
and s_blocks_count_hi only if EXT4_FEATURE_INCOMPAT_64BIT is set.)

(ext2 is messier, as a precomputed overhead value is not stored on disk.
Perhaps returning FSSIZE only if the type is ext4 might make sense.)

If I'm wrong about s_overhead_clusters being pre-calculated and stored, perhaps
just ignoring "overhead' altogether and treating FSSIZE in the "minixdf"
sense, and simply return s_blocks_count_lo & s_blocks_count_hi for an
answer.

Thanks,
-Eric

