Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42037C433F5
	for <util-linux@archiver.kernel.org>; Mon, 25 Apr 2022 15:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242631AbiDYPlN (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 25 Apr 2022 11:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiDYPlM (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 25 Apr 2022 11:41:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FB8E25E94
        for <util-linux@vger.kernel.org>; Mon, 25 Apr 2022 08:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650901087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2IG0+MJAEX/qlzZeTVKoOjDB3faWsnC/kbND2Vjv7Wc=;
        b=DZc9FwPDQtgk0YFR9mFlISzJky624WTK9zgdmjbMtkh24WZ7E5G1ICYqk4fM4g/gvI04Sq
        uWmnTCkm373CkAmMrcsz4mkglD9vJbcHd/ibsVSqArcpoI1pg5IknSZehxTbnOOnnAC8/t
        LfiOiOlFk808N1y+keIeJeJgxCSpMZo=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-82-QNJj4uM8NVup1Br4LerlAw-1; Mon, 25 Apr 2022 11:38:06 -0400
X-MC-Unique: QNJj4uM8NVup1Br4LerlAw-1
Received: by mail-io1-f69.google.com with SMTP id i19-20020a5d9353000000b006495ab76af6so11863847ioo.0
        for <util-linux@vger.kernel.org>; Mon, 25 Apr 2022 08:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2IG0+MJAEX/qlzZeTVKoOjDB3faWsnC/kbND2Vjv7Wc=;
        b=8KerGf8TIXMlFwbPrEzGNhhPkuD9pVOxgfa5yO5+cC7Ih1p/jmvEqvHjdcANqdAZjw
         bryhob8KCiYeBivreJwN0bqONLX+jmaiQaVszV5Hk4Vg7xBRqPfHlKm83eLezu6oFwqw
         nVDZQwO90PhBKE5henuDZRhmZ57HKKAEY6iJH1aO9I2IG69qNh25BWPHgNrHObG+4wB4
         rw+xZw+D/u8Gq5dIOS/ZvEkcFZGBlV+pV/rerc7l3iEiR1C5VA30M9JJ66GFODDRCvwc
         zh/PszVdXbjI/QjzzNYnfMji5x+LjAO4izCSUO3S6IeRRRbVotKhTafbUj5Wf7s+Qgnx
         Bmcw==
X-Gm-Message-State: AOAM532lEZS848eSPps2bxjdwt+s6+lthr/rxxUDSbHEgyt54NAKaFNt
        VDoQrXEYKQxInWkhBorg1adpEsh0SMhYy05TqAecYv2voomiQkC0LXjlTdUIOSgKkuAOVutxF0H
        Q0y/JTIkV12KKYLFghfd8oA==
X-Received: by 2002:a5d:81cb:0:b0:653:7cec:64aa with SMTP id t11-20020a5d81cb000000b006537cec64aamr7620406iol.208.1650901084997;
        Mon, 25 Apr 2022 08:38:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwr4Y6m3SzJsMOUvbFmeKAcyPDCHnnot3jqsPiJNttmaj/dhJZtrvZDHQ5yN9QzwBKvF+nBbw==
X-Received: by 2002:a5d:81cb:0:b0:653:7cec:64aa with SMTP id t11-20020a5d81cb000000b006537cec64aamr7620398iol.208.1650901084720;
        Mon, 25 Apr 2022 08:38:04 -0700 (PDT)
Received: from [10.0.0.146] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id k6-20020a6b4006000000b00649d7111ebasm7662443ioa.0.2022.04.25.08.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 08:38:04 -0700 (PDT)
Message-ID: <8b2a82b2-8890-1276-9948-d8c28fca3d9b@redhat.com>
Date:   Mon, 25 Apr 2022 10:38:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH 0/2] libblkid: add FSSIZE with XFS implementation
Content-Language: en-US
To:     Karel Zak <kzak@redhat.com>,
        Andrey Albershteyn <aalbersh@redhat.com>
Cc:     util-linux@vger.kernel.org
References: <20220421130946.318737-1-aalbersh@redhat.com>
 <20220425134329.ub3thxkscsniy74e@ws.net.home>
From:   Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20220425134329.ub3thxkscsniy74e@ws.net.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 4/25/22 8:43 AM, Karel Zak wrote:
> 
>  Thanks Andrey,
> 
> the code looks good.
> 
> On Thu, Apr 21, 2022 at 03:09:44PM +0200, Andrey Albershteyn wrote:
>> I had a look into other fs, like ext4 and btrfs, to implement FSSIZE
>> for them, but I think I don't have enough expertize to do that as
>> they have not so trivial metadata overhead calculation :)
> 
> But it would be nice to have ext4 and btrfs too. Maybe Eric can help
> you :-)
> 
>     Karel

For ext4 something like e2fsprogs does is probably ok:

static __u64 e2p_free_blocks_count(struct ext2_super_block *super)
{
        return super->s_free_blocks_count |
                (ext2fs_has_feature_64bit(super) ?
                (__u64) super->s_free_blocks_hi << 32 : 0);
}

though I wonder if a little documentation on the intent of the flag is
in order; ext4 can return "df" in different ways (see the minixdf and
bsddf mount options.)

I think best effort seems fine here, and reporting the same number
as the ext4 utilities do should be fine.

As for btrfs - I'm really not sure what this should return on a
multi-device filesystem?

-Eric

