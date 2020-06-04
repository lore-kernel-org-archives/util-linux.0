Return-Path: <SRS0=aW19=7R=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1615FC433E0
	for <util-linux@archiver.kernel.org>; Thu,  4 Jun 2020 09:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAB9D206C3
	for <util-linux@archiver.kernel.org>; Thu,  4 Jun 2020 09:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="xChTMe0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgFDJoC (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 4 Jun 2020 05:44:02 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:53458 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728066AbgFDJoB (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 4 Jun 2020 05:44:01 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 8BD552E1515;
        Thu,  4 Jun 2020 12:43:53 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id 8Ys540NFgH-hqx8xeXM;
        Thu, 04 Jun 2020 12:43:53 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1591263833; bh=b3DXVvqT1EzaVn2igQ1Ig47zD0kPzfJszibVFHtFWY8=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=xChTMe0DYr9bpfYQnnCLir/iieno7gmgT86rM/Vx5f+krqOL9OelVU3b/dKKX3Xgo
         vmoOJSA6pGVOpObpJE5v/aOkQi9dwTuBd1AAOpJTNV45QEEnulRh9Yxi6agbtXuHrB
         AQj/HGnGA1fLLJI1RNqy4WcKtB/z5TyKVYA+za5A=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b081:717::1:10])
        by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id rb3AdYrtMr-hqWGl6mq;
        Thu, 04 Jun 2020 12:43:52 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH util-linux] dmesg: adjust timestamps according to
 suspended time
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <159103929487.199093.15757669576783156290.stgit@buzz>
 <20200604093043.55a4zzo2hewhcwru@ws.net.home>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <c1ec31ea-494b-5d3e-3c0c-c3d8bb1a6c9c@yandex-team.ru>
Date:   Thu, 4 Jun 2020 12:43:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200604093043.55a4zzo2hewhcwru@ws.net.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 04/06/2020 12.30, Karel Zak wrote:
> On Mon, Jun 01, 2020 at 10:21:34PM +0300, Konstantin Khlebnikov wrote:
>> Timestamps in kernel log comes from monotonic clocksource which does not
>> tick when system suspended. Suspended time easily sums into hours and days
>> rendering human readable timestamps in dmesg useless.
>>
>> Adjusting timestamps accouring to current delta between boottime and
>> monotonic clocksources produces accurate timestamps for messages printed
>> since last resume. Which are supposed to be most interesting.
> 
> It's definitely better than the current broken timestamps, but the real
> and final solution is to have exact information about system suspends.
> 
> It would be enough to maintain in kernel memory a simple log with
>     <bootime> <monotonic> <state_change>
> and export this info by /proc/suspendlog, after that we can all
> re-count /dev/kmsg timestamps to something useful.

Boottime or real time could be simply printed into kernel log at
suspend and resume. So demsg could detect current offset while reading.

But for older kernel dmesg still needs guessing like this.

> 
>    Karel
> 
> 
