Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2790C433FE
	for <util-linux@archiver.kernel.org>; Tue,  5 Apr 2022 11:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349623AbiDELKE (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 5 Apr 2022 07:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243604AbiDEKhF (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 5 Apr 2022 06:37:05 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982E05548D
        for <util-linux@vger.kernel.org>; Tue,  5 Apr 2022 03:22:42 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id k124-20020a1ca182000000b0038c9cf6e2a6so1345747wme.0
        for <util-linux@vger.kernel.org>; Tue, 05 Apr 2022 03:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=plsFhNPT2nAQaT+BVTZqkhvH58bKHg1xVmV0bMSQzis=;
        b=MEHUb1u6+A5gQsqRkEZWfZNRSjfgsirFJ/MVPKkDX/C+DgP29beDfobQBcj1/Htdms
         hmlhJlc+9SXq2L3eI1QPI6k51dOk6+E5omQnrYv2q6bB1aNTqo1fnRwcOrtn3/Vu88rj
         7cjBjma+EJ4dMGxEC5le+5kKNVSkEA1xAdnYjgwVBvEphWGsxkHHNpe0Ek30n3jJpBU3
         8r/ONLMGq/+mxB8NgBW8gmPNH4mwqNQQhXfi3TlYgKGAfOmWtaSuutKwbBIymXCngABe
         nHzLZUDGwDHS9qmoSN+Po23UG199Q6lh4WdZ0OFsudRnX4J1AOqMDdExBtouipamKWFS
         MUNQ==
X-Gm-Message-State: AOAM530LX6AMhZB/RADxOEpDchhRdobzHqFNoSY3VsmjR3dpaTavY84a
        M+gdZNmmIHKbhO7rAOFSbNw=
X-Google-Smtp-Source: ABdhPJwSZmAgbLANOfDy4dlsDindjkNMaQP5a2QXAL3sZUYFd009VAzB5m5LsyoL8U/2q/04AZ28WQ==
X-Received: by 2002:a05:600c:1d9b:b0:38c:af70:9998 with SMTP id p27-20020a05600c1d9b00b0038caf709998mr2398458wms.169.1649154160871;
        Tue, 05 Apr 2022 03:22:40 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id 185-20020a1c19c2000000b0038a1d06e862sm1773616wmz.14.2022.04.05.03.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 03:22:40 -0700 (PDT)
Message-ID: <1105c039-372f-f105-8d69-887a62e0223e@grimberg.me>
Date:   Tue, 5 Apr 2022 13:22:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] nvme: add namespace paths links
Content-Language: en-US
To:     Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        util-linux@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
References: <20220401092855.90652-1-hare@suse.de>
 <20220405054205.GA23466@lst.de>
 <289ee526-8f3f-9a2b-eef4-70816eb4f42e@suse.de>
 <20220405054836.GA23647@lst.de>
 <b997ceac-a391-cc5a-a397-0d68f91736eb@grimberg.me>
 <0d53d5cb-a22d-c620-1a35-1ab408e0f747@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <0d53d5cb-a22d-c620-1a35-1ab408e0f747@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


>> Why not stick to slaves/ like the device mapper?
> 
> Because:
> 
> /**
>   * bd_link_disk_holder - create symlinks between holding disk and slave 
> bdev
>   * @bdev: the claimed slave bdev
>   * @disk: the holding disk
>   *
>   * DON'T USE THIS UNLESS YOU'RE ALREADY USING IT.
>   *
> 
> Not sure _why_ it's there, but it is there.

Fair enough
