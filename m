Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16918C4338F
	for <util-linux@archiver.kernel.org>; Tue, 27 Jul 2021 22:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0A2E60F6E
	for <util-linux@archiver.kernel.org>; Tue, 27 Jul 2021 22:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbhG0WMt (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 27 Jul 2021 18:12:49 -0400
Received: from cmyk.emenem.pl ([217.79.154.63]:32964 "EHLO smtp.emenem.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231989AbhG0WMs (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 27 Jul 2021 18:12:48 -0400
X-Greylist: delayed 1136 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Jul 2021 18:12:47 EDT
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (50-78-106-33-static.hfc.comcastbusiness.net [50.78.106.33])
        (authenticated bits=0)
        by cmyk.emenem.pl (8.16.1/8.16.1) with ESMTPSA id 16RLrV8m004890
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 27 Jul 2021 23:53:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
        t=1627422815; bh=b6EEIAUf66FgvRT/3W9ziJGlc0fpSHXkdrIidFnd3xs=;
        h=To:From:Subject:Cc:Date;
        b=VwCJIVYIA+1VqEUuEZpFPZfKx0EJtZ1wL9Kk2PMwo2QejV1aVQ2j75G0PcptJLnj4
         iKJQcD3Z+reHw7t6SwieRGr5lleJBInhLUE6gqlauh7pBQ9h489WSKx22Z/Gfg7M5H
         EPSN6dQaDU7PdVKRE3tW7C/yqDxc1vpjCChEQnb0=
To:     Sinan Kaya <sinan.kaya@microsoft.com>, Karel Zak <kzak@redhat.com>
From:   =?UTF-8?Q?Krzysztof_Ol=c4=99dzki?= <ole@ans.pl>
Subject: Commit d5fd456c88aba4fcf77d35fe38024a8d5c814686 - "loopdev: use
 LOOP_CONFIG ioctl" broke loop on x86-64 w/ 32 bit userspace
Cc:     util-linux@vger.kernel.org
Message-ID: <a797f527-4599-e986-a326-4bb141487f2c@ans.pl>
Date:   Tue, 27 Jul 2021 14:53:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi,

I have a number of (older) systems that are still based on 32 bit 
userspace but are running a relatively modern 64 bit kernel - 
5.4-stable, where BTW - LOOP_CONFIGURE is not yet available.

I noticed that starting with util-linux-2.37 it is no longer possible to 
mount images using loop:

# mount /usr/install/iso/systemrescue-8.04-amd64.iso /mnt/cdrom
mount: /mnt/cdrom: failed to setup loop device for 
/usr/install/iso/systemrescue-8.04-amd64.iso.

Reverting d5fd456c88aba4fcf77d35fe38024a8d5c814686 fixes the problem:

/tmp/util-linux-2.37# ./mount 
/usr/install/iso/systemrescue-8.04-amd64.iso /mnt/cdrom
mount: /mnt/cdrom: WARNING: source write-protected, mounted read-only.

I have not tested if 32 bit kernel + 32 bit userspace is also affected, 
but 64 bit kernel + 64 bit userspace works.

Thanks,
  Krzysztof
