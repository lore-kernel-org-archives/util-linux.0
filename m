Return-Path: <SRS0=cduA=PR=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188CBC43444
	for <util-linux@archiver.kernel.org>; Wed,  9 Jan 2019 18:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A9F20685
	for <util-linux@archiver.kernel.org>; Wed,  9 Jan 2019 18:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=jguk-org.20150623.gappssmtp.com header.i=@jguk-org.20150623.gappssmtp.com header.b="O9cQF+mD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfAISBW (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:01:22 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:51521 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbfAISBW (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 9 Jan 2019 13:01:22 -0500
Received: by mail-wm1-f51.google.com with SMTP id b11so8638257wmj.1
        for <util-linux@vger.kernel.org>; Wed, 09 Jan 2019 10:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jguk-org.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Qe1mapmprBMNMefheIrrX3cgiwYSTUdDZtQ1jjxmOMM=;
        b=O9cQF+mDylqsVcNvo1zLu+M0CnnShw7Mw4yer2kmVHCxNxaT2+P9Yi2MM8JNkNLaDB
         kPwdnoFFN2aOmio9SLgkjF9Y/sZKBN61AmM9hN/3iq3Ri6+oKi5Zp3/MGMTacvYlKSqv
         15q83VX9SUNnxwnNwjP8iC84K8Oj0+6qSDx75zI6RpH5RtSnvep7/3GRZ+JalJAgpokL
         IYJfK8tbMwJptOVKiK5hMcNzx0mkQhfUyEItSC78tIB73QzeXjnGiFB/l3nXJPQ6N57s
         fGL//2KNW4UkH9fIxzbycl//bd4BEDXEhAxF15To21buSM4IzX8UGvJWgE9VAHMoCYv8
         cujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Qe1mapmprBMNMefheIrrX3cgiwYSTUdDZtQ1jjxmOMM=;
        b=KP4hHbjdVnv4GjWm2QU8hzL41woTAqzyJVoFrUkOJPRP3QeepPkBU7Qh4lqcVKae0b
         2Fd+eVk3XdjgANMn1Aw3MIo5hZmnuoMISVvbKsRQZUPVq7DRfY3CAq2Hhnuvv4tnRYx7
         mkBOTFxnVznEOXaJU2dvWWt/ZnmtSjVUjVOLpEjYM+HE2Mo7c7F/A3BY+b3I0WKohjnI
         WL5QZj2M9aGMxeS2Fl2TJgfRu1YlNpTRgA4wO4uUtQCflKwZk2ya6IOrC03KuPVgUgcb
         XvP868C3Q2D+IhRg3V8hQV73jj5IRBFtuRqpwBDl6zznJQX6yNE1Jgl/70HCw00/CKTF
         GYww==
X-Gm-Message-State: AJcUukd+dm8SCrVJ1dcQ88mxEQt5UpS913wwNZz6bevM5gBooFOXKu0B
        4NEF1osmtdqOqDyDLDQIIshCpA==
X-Google-Smtp-Source: ALg8bN51MXYMiI5i9UvbJk+m1UUxBYVKu0/ttvSU+TYuunPZhzZ2akoSvkaXsI32Cnsyfd35siGp9A==
X-Received: by 2002:a1c:e287:: with SMTP id z129mr6533632wmg.71.1547056879603;
        Wed, 09 Jan 2019 10:01:19 -0800 (PST)
Received: from [192.168.1.64] (147.98.189.80.dyn.plus.net. [80.189.98.147])
        by smtp.gmail.com with ESMTPSA id g198sm20482162wmd.23.2019.01.09.10.01.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 10:01:18 -0800 (PST)
To:     util-linux@vger.kernel.org
Cc:     Karel Zak <kzak@redhat.com>
From:   Jonny Grant <jg@jguk.org>
Subject: fdisk Ctrl+C
Message-ID: <9bf2cc25-1b6a-88ae-c293-7a613b1255d8@jguk.org>
Date:   Wed, 9 Jan 2019 18:01:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello!

A few questions, ideas

1. Could Ctrl+C be added to get out of changing a partition type?

2 Could the partition code check that it is hex. At the moment if I type 
'q' I get partition type 0.

3.
For partition type 0, which is called "Empty" probably this message 
should say "Empty" and not 'unknown' ?

=======
Changed type of partition 'W95 FAT32 (LBA)' to 'unknown'.
=======

Would a patch be accepted for this?


NB. See log below for more info.

Regards, Jonny




$ fdisk --version
fdisk from util-linux 2.31.1


# fdisk /dev/sdb

Welcome to fdisk (util-linux 2.31.1).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.


Command (m for help): p
Disk /dev/sdb: 114.6 GiB, 123010547712 bytes, 240254976 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x00000000

Device     Boot Start       End   Sectors   Size Id Type
/dev/sdb1          32 240254975 240254944 114.6G  c W95 FAT32 (LBA)

Command (m for help): t
Selected partition 1
Hex code (type L to list all codes): ^CHex code (type L to list all codes):


Hex code (type L to list all codes): q
Type 0 means free space to many systems. Having partitions of type 0 is 
probably unwise.

Changed type of partition 'W95 FAT32 (LBA)' to 'unknown'.

Command (m for help):

