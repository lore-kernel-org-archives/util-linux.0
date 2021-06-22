Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_20,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8117C2B9F4
	for <util-linux@archiver.kernel.org>; Tue, 22 Jun 2021 10:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B60EA613AE
	for <util-linux@archiver.kernel.org>; Tue, 22 Jun 2021 10:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhFVKZg (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 22 Jun 2021 06:25:36 -0400
Received: from mx.swemel.ru ([95.143.211.150]:59382 "EHLO mx.swemel.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229787AbhFVKZb (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 22 Jun 2021 06:25:31 -0400
X-Greylist: delayed 316 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Jun 2021 06:25:31 EDT
To:     util-linux@vger.kernel.org
From:   =?UTF-8?B?0JDQvdC00YDQtdC5INCf0LXRgtGA0L7Qsg==?= 
        <a.petrov@swemel.ru>
Subject: Question
Message-ID: <84051527-c1c5-371b-a4ae-f6482508c547@swemel.ru>
Date:   Tue, 22 Jun 2021 13:17:56 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-OriginalArrivalTime: 22 Jun 2021 10:17:55.0808 (UTC) FILETIME=[DE29D600:01D7674F]
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi, i have a question about devname.c 
https://github.com/karelzak/util-linux/blob/master/libblkid/src/devname.c#L377

Why is there size is equal 110? Can't the device name be greater then 110?
In linux 
https://github.com/torvalds/linux/blob/13311e74253fe64329390df80bed3f07314ddd61/include/linux/genhd.h#L27 

DEVICE_NAME_LEN is defined as 32, wouldn't be better if you use this 
define in your program?
