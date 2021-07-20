Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7B3C07E95
	for <util-linux@archiver.kernel.org>; Tue, 20 Jul 2021 12:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3016C60C41
	for <util-linux@archiver.kernel.org>; Tue, 20 Jul 2021 12:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238401AbhGTMDs (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 20 Jul 2021 08:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238330AbhGTMDo (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 20 Jul 2021 08:03:44 -0400
X-Greylist: delayed 383 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Jul 2021 05:44:20 PDT
Received: from forward106p.mail.yandex.net (forward106p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB368C061762
        for <util-linux@vger.kernel.org>; Tue, 20 Jul 2021 05:44:20 -0700 (PDT)
Received: from forward103q.mail.yandex.net (forward103q.mail.yandex.net [IPv6:2a02:6b8:c0e:50:0:640:b21c:d009])
        by forward106p.mail.yandex.net (Yandex) with ESMTP id 858201C81C47
        for <util-linux@vger.kernel.org>; Tue, 20 Jul 2021 15:37:48 +0300 (MSK)
Received: from vla1-700fb1e46924.qloud-c.yandex.net (vla1-700fb1e46924.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:1386:0:640:700f:b1e4])
        by forward103q.mail.yandex.net (Yandex) with ESMTP id 808CF61E0009
        for <util-linux@vger.kernel.org>; Tue, 20 Jul 2021 15:37:48 +0300 (MSK)
Received: from vla5-8422ddc3185d.qloud-c.yandex.net (vla5-8422ddc3185d.qloud-c.yandex.net [2a02:6b8:c18:3495:0:640:8422:ddc3])
        by vla1-700fb1e46924.qloud-c.yandex.net (mxback/Yandex) with ESMTP id bNLeWJiSSI-bmHKdVBv;
        Tue, 20 Jul 2021 15:37:48 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=brighterdan.com; s=mail;
        t=1626784668; bh=Hj/avOuqzLlRb8atv0cAV2ZWaglq88iiom15KYCFLKo=;
        h=Date:Message-ID:Subject:From:To;
        b=c9WYRWdh8nv5JOjMZzaKEq9wz+ZLr0/mrCKJ0etZiQQUdahFn0vsGSVwA7A+ai1pO
         K+Zaf/0EQAGDA/ByCzgR4TBK0yyIavMryc8yfTtCgnmM06y1UhJfq0q+FFS3pa1mdZ
         Hy1cXIZ3C7kLQhkBQhauxivDcJETy7Q62vh5C4QU=
Authentication-Results: vla1-700fb1e46924.qloud-c.yandex.net; dkim=pass header.i=@brighterdan.com
Received: by vla5-8422ddc3185d.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id KwMkCvVDY8-bl2mJKDh;
        Tue, 20 Jul 2021 15:37:48 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
To:     util-linux@vger.kernel.org
From:   Daniel Santos <hello@brighterdan.com>
Subject: Portuguese cal uncapitalized problem
Message-ID: <7495c66f-4114-3ed7-fcfb-839cdfa8a9db@brighterdan.com>
Date:   Tue, 20 Jul 2021 13:37:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi everyone.
I would like for the Portuguese months and days of the week of `cal`, to 
be capitalized.
  . Can anyone do this?
  . Should I do this? Where can I find the days of the week and the 
months translation? (it does no seem to be in the 
https://translationproject.org/POT-files/util-linux-2.37-rc2.pot file)
