Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7917AC07E9B
	for <util-linux@archiver.kernel.org>; Tue, 20 Jul 2021 15:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 616EE60FF2
	for <util-linux@archiver.kernel.org>; Tue, 20 Jul 2021 15:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239573AbhGTOdW (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 20 Jul 2021 10:33:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21752 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238832AbhGTOLZ (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 20 Jul 2021 10:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626792694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8VmG+m83jEjT+ELpZMH25kIi/kAY0QNFvXNZdR2Kkbw=;
        b=Ai6fg8k9sfYT3SCkmvmvAnZ3MYygOkF5mm1CiMhre5Fet/D8/zxZ+23ufrxBpI/0OC4wVc
        /5Qgcnrrd6LVtAu/tQTrwsVT6HzCZC99dnBtPOErskSVdF1vSNHtRqoos5nCxvbM0yIb+P
        SyLj+XvfkP5ejV1vFrjAHJHlckGJpdY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-iVuPrAqCP5ON6pKpcnFduQ-1; Tue, 20 Jul 2021 10:43:21 -0400
X-MC-Unique: iVuPrAqCP5ON6pKpcnFduQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0B08106B7D6;
        Tue, 20 Jul 2021 14:43:20 +0000 (UTC)
Received: from ws.net.home (ovpn-113-182.ams2.redhat.com [10.36.113.182])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 101D85C1CF;
        Tue, 20 Jul 2021 14:43:19 +0000 (UTC)
Date:   Tue, 20 Jul 2021 16:43:17 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Daniel Santos <hello@brighterdan.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: Portuguese cal uncapitalized problem
Message-ID: <20210720144317.kk5mq4fexxtmaeyg@ws.net.home>
References: <7495c66f-4114-3ed7-fcfb-839cdfa8a9db@brighterdan.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7495c66f-4114-3ed7-fcfb-839cdfa8a9db@brighterdan.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Jul 20, 2021 at 01:37:46PM +0100, Daniel Santos wrote:
> Hi everyone.
> I would like for the Portuguese months and days of the week of `cal`, to be
> capitalized.
>  . Can anyone do this?
>  . Should I do this? Where can I find the days of the week and the months
> translation? (it does no seem to be in the
> https://translationproject.org/POT-files/util-linux-2.37-rc2.pot file)

It uses nl_langinfo(ABDAY_*) libc call to get the weekday name. So,
this is not maintained by util-linux.

For more details see 'man nl_langinfo' and ABDAY_{1–7} (LC_TIME)
section.

Frankly, the best would be to resolve it by a small shell script where
you convert second line of the cal(1) output from a-z to A-Z.

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

