Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460D7C2B9F4
	for <util-linux@archiver.kernel.org>; Thu, 17 Jun 2021 16:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16C136102A
	for <util-linux@archiver.kernel.org>; Thu, 17 Jun 2021 16:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhFQQwx (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 17 Jun 2021 12:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhFQQwx (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 17 Jun 2021 12:52:53 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461B0C061574
        for <util-linux@vger.kernel.org>; Thu, 17 Jun 2021 09:50:44 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id x196so7192060oif.10
        for <util-linux@vger.kernel.org>; Thu, 17 Jun 2021 09:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sMZMCL5bs2EtIl5wTXj5ohbWyLTWCx3oyZjwCSrls5Q=;
        b=HuiulJlewiCrll48IVCedDvoWHpaHLz+7fzbaHEnpe5FnpdcShpHpn+DbIBnH1vqun
         Mk+njHMz4OAyS2A+kSiRah4FO9o8wzdYKm8sRn5fqQa3rHfQ+D2zaQgwthYxGL1rT8m+
         8WctqCEbPr+N/l5XxPRMSO4+GcpNjV7puahiSDBSLlL45Y2R3KvKRpVCHg1XAR1+EX+Z
         HQ6MAPE/uA7HBtXgEsJYNSGcswgARTX6fRiYvDmjrEOpksakajzMzFEjgT2GfSLxnP/x
         HNm+oRUGvITNcSSW8ojpaj6z4pr9GfwG1ufBe5O159SNPLvD+SrsRZI5Ri4nrV3J93Fj
         y6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sMZMCL5bs2EtIl5wTXj5ohbWyLTWCx3oyZjwCSrls5Q=;
        b=AjQFgcq1YLE69lWolcYkLfpYX1alFt8hlgRCPSjfJ+AOruOCLZzVG+96y0tZQ1tmKk
         VBlq5yPBTZAJr+Usm15m/by8FLGQp0oUXlKLv8DwZiXWMCoachVJftdU9ZDHQLDfzk2U
         qEXDnugxfuwlgvQYodsCzF3kZ6pkuZX2gR0Wd0b2pH43QMDKBC2EV5+n9kLff6iwYi85
         0+1bAyZUQuH9nrFX58cmjN7cFvb+AMvVtzmIsz1/ALaGgpAz/Pjqo63jlS4TmcOOz1pp
         UHBaQcySeyNdmIcHV9CT1ZJ9VSUZNM/ZMJetRSxkZPRxpmvK4BvUk+JTFwNesFnrfTTO
         XkDw==
X-Gm-Message-State: AOAM532ys3HXBBztTdvAHvYoPsKgphbV0pDVrgIVYEBQkMAU8G6GxY9T
        sU6o6TOJknohjpCn2qcTdOcAIWjTFIY=
X-Google-Smtp-Source: ABdhPJx1pk7E3L5Qx1mI0q8L1dKdtiEeh2QmpbbDoFkgXHLMNuRDs7URkcs1g41HPEcVW7L90zV3YQ==
X-Received: by 2002:aca:2204:: with SMTP id b4mr4071671oic.76.1623948643556;
        Thu, 17 Jun 2021 09:50:43 -0700 (PDT)
Received: from [192.168.0.92] (cpe-70-94-157-206.satx.res.rr.com. [70.94.157.206])
        by smtp.gmail.com with ESMTPSA id t14sm1251882ooh.39.2021.06.17.09.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 09:50:42 -0700 (PDT)
Subject: Re: An obscure problem with v2.37 make check
To:     Anatoly Pugachev <matorola@gmail.com>, Karel Zak <kzak@redhat.com>
Cc:     util-linux <util-linux@vger.kernel.org>
References: <cdfa712c-c918-c5bd-e320-b3dbe8599bbd@gmail.com>
 <20210617085901.l45esa2fuzinn44w@ws.net.home>
 <CADxRZqwwfA7KWirH5XxdAHN_PprGFzqKOi2q_6MBA39MfB2+Qw@mail.gmail.com>
From:   Bruce Dubbs <bruce.dubbs@gmail.com>
Message-ID: <27bff31c-d6d5-478d-f63d-e121750b259d@gmail.com>
Date:   Thu, 17 Jun 2021 11:50:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CADxRZqwwfA7KWirH5XxdAHN_PprGFzqKOi2q_6MBA39MfB2+Qw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 6/17/21 6:37 AM, Anatoly Pugachev wrote:
> On Thu, Jun 17, 2021 at 12:00 PM Karel Zak <kzak@redhat.com> wrote:
>>> One solution to this problem may be to test for the existence of the file
>>> before running 'stat' similar to the tests for programs like 'touch' and
>>
>> Sounds good. Please, send patch.
> 
> Bruce, Karel,
> 
> something like this?
> 
> util-linux$ git diff
> diff --git a/tests/ts/lsns/ioctl_ns b/tests/ts/lsns/ioctl_ns
> index e91f6743f..b8f35e2e5 100755
> --- a/tests/ts/lsns/ioctl_ns
> +++ b/tests/ts/lsns/ioctl_ns
> @@ -24,6 +24,9 @@ ts_init "$*"
>   # ts_skip_nonroot
>   grep -q '#define HAVE_LINUX_NSFS_H' ${top_builddir}/config.h ||
> ts_skip "no ioctl_ns support"
> 
> +[ -a /proc/self/ns/user ] || ts_skip "no USER namespace kernel support"
> +[ -a /proc/self/ns/pid ] || ts_skip "no PID namespace kernel support"
> +
>   ts_check_test_command "$TS_CMD_LSNS"
>   ts_check_test_command "$TS_CMD_UNSHARE"
>   ts_check_prog "stat"
> 

Looks pretty good to me, but I would use -r instead of -a.

   -- Bruce

