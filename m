Return-Path: <SRS0=RNVe=XE=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D6CC4740A
	for <util-linux@archiver.kernel.org>; Mon,  9 Sep 2019 19:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB59C21924
	for <util-linux@archiver.kernel.org>; Mon,  9 Sep 2019 19:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTaE4BbP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbfIITH6 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 9 Sep 2019 15:07:58 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]:33984 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728836AbfIITH6 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 9 Sep 2019 15:07:58 -0400
Received: by mail-qk1-f181.google.com with SMTP id q203so14230575qke.1
        for <util-linux@vger.kernel.org>; Mon, 09 Sep 2019 12:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=m0FuZ6xIKGTOzOLcyHLs6NqkdmpV4heXC6VVSMkPytE=;
        b=qTaE4BbPqaBY/vo6b2dE+wOHF9XT8Lul4Y565UoyMNkPdpAbJUQuVJKyAQWNETakrl
         2W/uYqHVDoebIyLyloelyL/QpyP7G13WVGXAqFDyxxAfbA1HQfkfAQsWGEqvcuDalHsT
         QLhyrY6DKjtDbrYajK3sCyocTs3KCFrXQUsGBa+KCeOUsCTbFOHTa+9al/eZQKnfT1NV
         l4WqfutYSlfV1MWgIn5b3F3IOL8qDuRuONcdRyAgSCYCRMKvn+GrP/7UmPX/PgZsuB4q
         5VZq1oIfN4EBT2QoJRZb6VlUaU0tgEEbpDVyiMuRtu4NkJWtMBKqpPWH+BEB2EoxeKa/
         xb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=m0FuZ6xIKGTOzOLcyHLs6NqkdmpV4heXC6VVSMkPytE=;
        b=Lj5nP73rG5w+En5DBwPCGlxi7RPi9y50T6eMZqw6tLBzyDjYshfMebNKuu0tUZYF/o
         76X2iXAOszmzeVWW1BynXfyxDZWsFi4nKK+UeVPOy/GnxAazC5QNCuqa0dgCRy5pMe20
         gVoRm1ZjjfLJiM22H7oY1XaeO4eVAOCXFaiwh8wPHpGHyvn6uLd4rDY3yfR1MScySeJ/
         2e5uiqVRaDfq6StUGP+EDhzHve0o4ONX+hUR9JGyDwkc8miTTW9IC3oyPntqfMOVkDRb
         aHZhyKUqn1HA16pqve7FS+wVLB/3v40h2iUnggXXP2/WUUnx0JMtgPNo1kcm0weCQrQI
         /aGg==
X-Gm-Message-State: APjAAAUDEeOtIv5dRjU0v/WF7dlSdG6ICZ93MLlZ2VFOGFkY8lTowf3Z
        +4huddExqGgQYHW2DkrpBfoWugX8+UcD+LyQH3wFTQoo
X-Google-Smtp-Source: APXvYqxYtu/THJucV1qXRmiRolcqg2wc6zmsK8HnRiotS7BiYRw5ijcQf+P0Sj/VIo6mMgI2uTnoHLLX1lnx7jSgy7Y=
X-Received: by 2002:a05:620a:126f:: with SMTP id b15mr24895551qkl.483.1568056076600;
 Mon, 09 Sep 2019 12:07:56 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Thomas <pthomas8589@gmail.com>
Date:   Mon, 9 Sep 2019 15:07:44 -0400
Message-ID: <CAD56B7foOQ8UYuMYPBqaYUa4DQw_qc4QUJRRkgdeV1g1x0NfoA@mail.gmail.com>
Subject: last reboot
To:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello, 'last' is a handy tool, and using it for
'last reboot' provides a nice log.

I was wondering if there are currently any platforms where more
information about the reboot type is supported? For instance on the
Zynq UltraScale+ devices there are a variety of reboot reasons:
https://www.xilinx.com/html_docs/registers/ug1087/crl_apb___reset_reason.html#

So on each startup the reason could be read and logged before
resting the register[1].

I guess one tricky issue would be the kernel interface,
for a test I was just using memtool like this:
# memtool md 0xFF5E0220+1
ff5e0220: 00000001

Where 00000001 indicates an 'External POR', but this probably
isn't how we'd want to do it.

I'm not subscribed to the mailing-list so please cc me any response.

thanks,
Paul

[1] If the register is not reset then multiple bits can accumulate
so you wouldn't now which is correct for the current boot
