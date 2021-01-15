Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2705CC433E0
	for <util-linux@archiver.kernel.org>; Fri, 15 Jan 2021 21:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6620239EE
	for <util-linux@archiver.kernel.org>; Fri, 15 Jan 2021 21:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbhAOVgh (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 15 Jan 2021 16:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbhAOVgg (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 15 Jan 2021 16:36:36 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8904C061757
        for <util-linux@vger.kernel.org>; Fri, 15 Jan 2021 13:35:55 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id q18so10691177wrn.1
        for <util-linux@vger.kernel.org>; Fri, 15 Jan 2021 13:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jguk.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8nWBh+hV5QoTiWZ/eI2DiiR9Se8UaZdu4RrJ6WBasb8=;
        b=NLXerF68NTIYueDgZ1kmS9+BB5aFL34u6TQgqvZNCeqaUsgKzMBcqorU6icMWb+Ffp
         Bhcn0dRC99mbj6tF+827hZs7X/F+Ct7uLIjtH2GDyMr6zBaGZDYK5dTaoKAg3Ek80wa7
         b9e2HcNG6cajekokk12D/xq3vNl9UECen8HkPy+jwnTkPj94DaPiAY33a3OLJrIiiHBm
         kjswT//zvrowZEpIxfxAfZpwnbZLSIMHGdu7cepufnNLnxUcrmpHb1hXfDmwGKGIf/Kj
         6LZnFbL2L31A7mEJDZkGxW49N1Ec85a0FzohD5mU9d81srmNWoBPRd0HFB2l2bcAWTSj
         XvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8nWBh+hV5QoTiWZ/eI2DiiR9Se8UaZdu4RrJ6WBasb8=;
        b=L9gJg6wFP8vFapMtPhe/3mv1muWIzpH5eDoL+DZlRLBJE3rjaU+FGN0gPM9HyY3UrT
         RfbSHHYUZyXs5MXVGd0JaxgDDXSjiH7oAL2Hmxy+oR0PsbFQhU/Eu8rN7OI3Nw+Qohnc
         PNAtkLsMY9WG+O1XO3JU/w8dK4/xDz3njycuT1FbPy/umX+ie6sePABiN8RiVhZfso45
         ibbj2vBHjUf8LBMjbjjxT2P+LF1XEYvvaGCcNLER/Y6Hfx3NN8WloWewR0BYXBmMbrsA
         g2c7sACDHme0g1mdl21bCXDXUTemdttABRMWYBoYloAzJsGp+somT8y9lCcXmgbsC1gD
         yQxg==
X-Gm-Message-State: AOAM533FH1vz4kHwa/afaKtxLzLKemO/tiBjSWfJngNUnqmKVnEDRjYu
        TkmEzqmQkWNp0zzko74ohdFnDtWgZ4P6Qg==
X-Google-Smtp-Source: ABdhPJylWvKlVXPZ2yCiWO6dHx5TLk9EN2TndcipL1xwPOH5FutnPkIzEkl5mBzrt3TSGYu1eRjhJA==
X-Received: by 2002:adf:e512:: with SMTP id j18mr14959174wrm.52.1610746554707;
        Fri, 15 Jan 2021 13:35:54 -0800 (PST)
Received: from [192.168.0.12] (cpc87345-slou4-2-0-cust172.17-4.cable.virginm.net. [81.101.252.173])
        by smtp.gmail.com with ESMTPSA id p15sm16362438wrt.15.2021.01.15.13.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 13:35:53 -0800 (PST)
Subject: Re: fsck needs /dev in path to check an ext4 partition
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     util-linux@vger.kernel.org
References: <5483a74b-106e-1c6c-0265-55ed960826d8@jguk.org>
 <4930f03e-dbd0-7a2f-4b56-9f7cef88d9d2@physik.fu-berlin.de>
From:   Jonny Grant <jg@jguk.org>
Message-ID: <e2c4f517-95ca-1a1d-4fc3-3f6777e58001@jguk.org>
Date:   Fri, 15 Jan 2021 21:35:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4930f03e-dbd0-7a2f-4b56-9f7cef88d9d2@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello Adrian!

On 15/01/2021 20:15, John Paul Adrian Glaubitz wrote:
> Hello Jonny!
> 
> On 1/15/21 9:06 PM, Jonny Grant wrote:
>> Apologies I am not using 2.36.1 yet. I'm on latest Ubuntu LTS, but it's using 2.34
>>
>> I noticed fsck only works if I write as "/dev/sdb1" not just "sdb1" I was in /dev/ as
>> root, so it shouldn't need long path?
>>
>> These work as expected when called from /dev/ as user root
>>
>> # fsck.ext4 sdb1  
>> # fsck.ext4 /dev/sdb1  
>>
>> This does not work:
>> # fsck sdb1
> 
> That's because it must be:
> 
> # fsck.ext4 ./sdb1
> 
> Filenames are expanded by your shell in this case, not by the fsck utilities.
> 
> Adrian

My apologies, I had just used # fdisk sdb
that does work # fsck.ext4 ./sdb1

However, fsck still has the issue even with # fsck ./sdb1
It only works with the full path. I'm sure I used to always just call fsck.

root@abc:/dev# fsck ./sdb1
fsck from util-linux 2.34
Usage: fsck.ext4 [-panyrcdfktvDFV] [-b superblock] [-B blocksize]
		[-l|-L bad_blocks_file] [-C fd] [-j external_journal]
		[-E extended-options] [-z undo_file] device

Emergency help:
 -p                   Automatic repair (no questions)
 -n                   Make no changes to the filesystem
 -y                   Assume "yes" to all questions
 -c                   Check for bad blocks and add them to the badblock list
 -f                   Force checking even if filesystem is marked clean
 -v                   Be verbose
 -b superblock        Use alternative superblock
 -B blocksize         Force blocksize when looking for superblock
 -j external_journal  Set location of the external journal
 -l bad_blocks_file   Add to badblocks list
 -L bad_blocks_file   Set badblocks list
 -z undo_file         Create an undo file
root@abc:/dev#
root@abc:/dev# fsck /dev/sdb1
fsck from util-linux 2.34
e2fsck 1.45.5 (07-Jan-2020)
Ext4fs: clean, 458/237104 files, 117884/947120 blocks


