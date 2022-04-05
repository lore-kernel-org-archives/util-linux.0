Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F12C433EF
	for <util-linux@archiver.kernel.org>; Tue,  5 Apr 2022 08:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbiDEJAO (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 5 Apr 2022 05:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236883AbiDEIlX (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 5 Apr 2022 04:41:23 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30477EA
        for <util-linux@vger.kernel.org>; Tue,  5 Apr 2022 01:34:17 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id w4so18090784wrg.12
        for <util-linux@vger.kernel.org>; Tue, 05 Apr 2022 01:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BNzvuZcgicTBqbhlj2//0UbgliwQppO+j8GwlwqQT5Y=;
        b=2lQ4Vca9TSdlfhtxn2UpthlKMBAHtCSH4M9aY/ro/OWeI6mn5UqubCrNGrpOSAFwok
         jRjn+WCmejoYic2d2NwzkWZ+CzD8JKy5oC36UdnSjNoYEe+j+CP8W1gG2fo+NFQmAULW
         6Ez7sFp5D1hiWP/qmv9YeGWBLl32yX7kbpB5N81WcLrKEiURzxt0WH2WuF4uOo0gJSe8
         oe875z4F4eTpjXdxM0cw45jydRd9JWLwhwllhan3JljENLXcok41QdFa+IyAy7Rshypw
         l87OCxLvBLs+vNC6T3qIFoFMfG9NVaY8ma9ILNFmFw+Q+b2kbLVpa+SIOPt9VlgEGo7M
         sBbg==
X-Gm-Message-State: AOAM532xbLEPR7ilJnIM496xvHPE4PQHvbxS97H5+OOAE8E1BiB4bX94
        m/UtQqbFIl2Fk9tdb6mwc7M=
X-Google-Smtp-Source: ABdhPJy0n5EjzUDkdbgSbTmRW3+zV9fqhwBDWrVpjotQW6bQpZt2BYEZ2wCeO1d075I1lHxqdJs9hg==
X-Received: by 2002:a05:6000:1883:b0:205:c0cb:33c6 with SMTP id a3-20020a056000188300b00205c0cb33c6mr1802756wri.39.1649147655658;
        Tue, 05 Apr 2022 01:34:15 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f18-20020a5d6652000000b001e669ebd528sm11209607wrw.91.2022.04.05.01.34.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 01:34:14 -0700 (PDT)
Message-ID: <b997ceac-a391-cc5a-a397-0d68f91736eb@grimberg.me>
Date:   Tue, 5 Apr 2022 11:34:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] nvme: add namespace paths links
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Cc:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        util-linux@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
References: <20220401092855.90652-1-hare@suse.de>
 <20220405054205.GA23466@lst.de>
 <289ee526-8f3f-9a2b-eef4-70816eb4f42e@suse.de>
 <20220405054836.GA23647@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220405054836.GA23647@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


>>>> It is really annoying to always have to loop through the entire
>>>> /sys/block directory just to find the namespace path links for
>>>> a single namespace in libnvme/nvme-cli.
>>>> So provide links to the namespace paths for efficient lookup.
>>>
>>> I think having some form of links would be useful.  Quite a while ago
>>> Thadeu looked into adding some form of relationship for lsblk and
>>> friends.  Maybe it would be good to sync up and make sure whatever
>>> links we are adding would be useful for all users?
>>>
>> Care to elaborate?
>> Using the block device name is the most straightforward way here; we don't
>> have a good enumeration to leverage as the paths are essentially just a
>> linked list.
>>
>> We sure can have a subdirectory 'paths', and stick the links in there.
>> If that helps with lsblk ...
> 
> I personally don't care.  But I've added Thadeu and the util-linux list
> to get everyone on board.

Why not stick to slaves/ like the device mapper?
