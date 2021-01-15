Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD88C433DB
	for <util-linux@archiver.kernel.org>; Fri, 15 Jan 2021 20:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14646238D7
	for <util-linux@archiver.kernel.org>; Fri, 15 Jan 2021 20:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbhAOUHp (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 15 Jan 2021 15:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbhAOUHl (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 15 Jan 2021 15:07:41 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3C2C061757
        for <util-linux@vger.kernel.org>; Fri, 15 Jan 2021 12:07:01 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id y17so10468709wrr.10
        for <util-linux@vger.kernel.org>; Fri, 15 Jan 2021 12:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jguk.org; s=google;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=chr6RqGx1i39i0Kh6aQYcXLmu/colnOVxWZUt3bMwMk=;
        b=bg5erktw8xA+Iib7k6l86GNuyY1Mqo+Uanp0IIkT/9EJVRbu4kLmNgntzYXf8IyhxO
         Kplx0ay4gbAm3xEAG6mXpqFfOb4HZu0VRKIYgzdo944nkRsSJiRK+9AnS2+zgf/M5nQd
         oDu9Zu4Zu5Gd9RVpUBfhz4wQiCgwzDtXUeyN0A1H/BJrdZRHaEuRS3eKdLIiKtk+z0IN
         0IqUqFyaGmiZsm0q54ssk8ry0VNKzO+2zm413Q8jkyEhFf/I0+cuqfXot6e1zi9f1QOr
         q5SpxNAmS+uZtcemKs1P00M5lHFAXjlHt4pXM+xQuQ2Wj4d4S2/W1p57rZcGTdWpUCut
         5xtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=chr6RqGx1i39i0Kh6aQYcXLmu/colnOVxWZUt3bMwMk=;
        b=c8gtPLjRgMS8e75A/i18IlTlbCO/9Qftp++vPmpanAazMdxyxPfIJ4z/g+q/jr8Fp5
         zAfgLAYpZMmTdxR6PBPsZqMFlla9loYjgmi0cHHFSV0s9bPE37yL/pY0qm1hESfPwYkf
         nvKzmxNmIIgzydso29ninjBrubgrzD0iNZu84s1j5R1x104NefgJSRxoqZcCyHuK5z9D
         HLhTYc+Y7RAsfRfSM/B890zaPZ2G3+QRnBetlCPtZnupGd/KsB/MnZ//bzE1/0/Iw9DW
         4Fju4k4VgqXLCnS+rnZW8ubwa+r3eDs2ie/NapGA4WB0JBabyJ/ijR+Ahwh2VLKtuDiW
         PaHg==
X-Gm-Message-State: AOAM532rVpBhmS365wiikAWFUntqaJpb52rm4eqA8ckmPsjzAlfXD/Y5
        DCmQFBLN3A0E0aZBRdLxdOJpXz/Sj3cccw==
X-Google-Smtp-Source: ABdhPJwjWoDDj28I5VEJnILtaAkg2cp1Kk/NeQ1vG6ux69RE/Pbo29YwZ6WbsNFQewMLFhfk8vKkjQ==
X-Received: by 2002:adf:e94c:: with SMTP id m12mr14875512wrn.141.1610741220077;
        Fri, 15 Jan 2021 12:07:00 -0800 (PST)
Received: from [192.168.0.12] (cpc87345-slou4-2-0-cust172.17-4.cable.virginm.net. [81.101.252.173])
        by smtp.gmail.com with ESMTPSA id g19sm7617369wmk.20.2021.01.15.12.06.59
        for <util-linux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 12:06:59 -0800 (PST)
From:   Jonny Grant <jg@jguk.org>
To:     util-linux@vger.kernel.org
Subject: fsck needs /dev in path to check an ext4 partition
Message-ID: <5483a74b-106e-1c6c-0265-55ed960826d8@jguk.org>
Date:   Fri, 15 Jan 2021 20:06:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello

Apologies I am not using 2.36.1 yet. I'm on latest Ubuntu LTS, but it's using 2.34



I noticed fsck only works if I write as "/dev/sdb1" not just "sdb1" I was in /dev/ as root, so it shouldn't need long path?


These work as expected when called from /dev/ as user root

# fsck.ext4 sdb1  
# fsck.ext4 /dev/sdb1  

This does not work:
# fsck sdb1

Looking at the output, it seems like fsck sometimes goes through to e2fsck and otherwise goes through to fsck.ext4 and then fails.
If I call fsck.ext4 directly it does work.

Could fsck be changed to not require the full /dev/sdb1 path?

Seems a bit risky it defaults to trying to check a device without anything being specified.

# fsck
fsck from util-linux 2.34
e2fsck 1.45.5 (07-Jan-2020)
/dev/sda5 is mounted.
e2fsck: Cannot continue, aborting.


root@abc:/dev# fsck sdb1
fsck from util-linux 2.34
Usage: fsck.ext4 [-panyrcdfktvDFV] [-b superblock] [-B blocksize]
		[-l|-L bad_blocks_file] [-C fd] [-j external_journal]
		[-E extended-options] [-z undo_file] device

Emergency help:
 -p                   Automatic repair (no questions)
 -n                   Make no changes to the filesystem
 -y                   Assume "yes" to all questions
 -c                   Check for bad blocks and add them to the badblock list
 -f                   Force checking even if filesystem is marked clean
 -v                   Be verbose
 -b superblock        Use alternative superblock
 -B blocksize         Force blocksize when looking for superblock
 -j external_journal  Set location of the external journal
 -l bad_blocks_file   Add to badblocks list
 -L bad_blocks_file   Set badblocks list
 -z undo_file         Create an undo file



root@abc:/dev# fsck -p /dev/sdb1
fsck from util-linux 2.34
Ext4fste: clean, 458/237104 files, 117884/947120 blocks

Cheers, Jonny
