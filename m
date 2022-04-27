Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CFCC433F5
	for <util-linux@archiver.kernel.org>; Wed, 27 Apr 2022 17:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243990AbiD0ReK (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 27 Apr 2022 13:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244246AbiD0ReI (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 27 Apr 2022 13:34:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DCDC1B12EB
        for <util-linux@vger.kernel.org>; Wed, 27 Apr 2022 10:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651080655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BSEKWAhY01jeZTqy5BhP7b9LdwP7MFnjmbeX6FHLQQ4=;
        b=aQsXOJbciETmeAtP+d8q9SPKxhEdSRBcp8rlSB6O8IhXdOHJGGg+IAtmc8uuus1eItIpkj
        Z6ylrCbe35t0+icwfI0/IgKZL9Yary88ToRqXDCDZZ7kKh972fFtKxtW1v5bB7/gZ4h/hL
        bnP9s50/hw2/sxG4qsJwyZlk+cyYAG4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-150-bW06uiOsOuKRyXszw4kFVg-1; Wed, 27 Apr 2022 13:30:53 -0400
X-MC-Unique: bW06uiOsOuKRyXszw4kFVg-1
Received: by mail-wr1-f71.google.com with SMTP id b10-20020adfc74a000000b0020ab029d5edso973174wrh.18
        for <util-linux@vger.kernel.org>; Wed, 27 Apr 2022 10:30:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BSEKWAhY01jeZTqy5BhP7b9LdwP7MFnjmbeX6FHLQQ4=;
        b=J9r8ZDCZVCfrboIBVvqD0FCyGF7PaD/UuG1wZICT6kOIs77HdfV01KqaNC/+9r8t7h
         /mO4oXksQwoqCRixCdoN5B48PsQ3+WTl0CyU0K8QSxQR+Tm4EDli7X1KLoKF9FpYGPkb
         JfBdF0gvn0MctrSlz9krnSRMkWhKOZS1CAURyMg7wfDjwHuPe/ZpR4gI7+9gLozWpvrE
         oVNcK9lifi0MQUez6Fe2mZ+Brwc/eqeW+5PiB1pdq6/JaMAQGbYdOk8VAZiwcFSuWYBM
         sm0k9PloofY5rXS0PqXSDiCeUyqudJkOhNLV1RndmfQkQYqpvhw/f/gjCynMQIB/Vklc
         qt2A==
X-Gm-Message-State: AOAM532FbQv98N0fn3C4L3CG9n4+pK5QPE4Gr3Mrrx0KuH+bOIKB9UGU
        HWzt24FP+nsD5IyEJWXx62c5SR4q7zSl21Er3r66+LuUILFx7WHKK+AigOiRH4jUGEj/B7C2PAV
        H+ZJD5dLIrb8BnWyCAQo++5/PxAoB5XG2qAlTJpuBxOtZEXn6c9LKcXCbgp9JNg1+6nBZ2u5J
X-Received: by 2002:a5d:4744:0:b0:20a:ea5a:dc39 with SMTP id o4-20020a5d4744000000b0020aea5adc39mr5636676wrs.236.1651080652546;
        Wed, 27 Apr 2022 10:30:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzc/WcA6/iXvZJMP6Z0fRXz7aHRzaQf+ZXlaCpZ2jJpB4Kamg0z9NCmupGNf/ZzPXaqSLwYKQ==
X-Received: by 2002:a5d:4744:0:b0:20a:ea5a:dc39 with SMTP id o4-20020a5d4744000000b0020aea5adc39mr5636664wrs.236.1651080652357;
        Wed, 27 Apr 2022 10:30:52 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id z6-20020a05600c0a0600b00393d831bf15sm2612330wmp.46.2022.04.27.10.30.51
        for <util-linux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 10:30:51 -0700 (PDT)
Date:   Wed, 27 Apr 2022 19:30:50 +0200
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     util-linux@vger.kernel.org
Subject: Re: [PATCH 0/4] Add FSLASTBLOCK tag and blkid with btrfs test
Message-ID: <Yml9yq64WpGzwZZ5@aalbersh.remote.csb>
References: <20220427170514.317720-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427170514.317720-1-aalbersh@redhat.com>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Oh well the 3rd patch haven't passed message length check (as it
contains binary image for BTRFS - too long message). I will create
GitHub pull request for that.

-- 
- Andrey

