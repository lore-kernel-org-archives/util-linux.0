Return-Path: <SRS0=ak8c=UF=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4880C04AB5
	for <util-linux@archiver.kernel.org>; Thu,  6 Jun 2019 14:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71ADC20665
	for <util-linux@archiver.kernel.org>; Thu,  6 Jun 2019 14:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyTv87Tc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfFFOOr (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 6 Jun 2019 10:14:47 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:44597 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfFFOOr (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 6 Jun 2019 10:14:47 -0400
Received: by mail-io1-f54.google.com with SMTP id s7so281850iob.11
        for <util-linux@vger.kernel.org>; Thu, 06 Jun 2019 07:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=vAuxFqud/lhrr1wGBSQ/AmhLhcbc4T3Nc+YI7BMqNKA=;
        b=KyTv87TchbEBdwra86VZBeIRfy+cOR5urFZmvOpkEAeIBT1fGm6bv9MfrfHppYp3CQ
         L5izswL4gbEC0sx5d05W5R0ItSA4Au8sfnz8/j5qEjtOcnurWfInMWWI25a2paWEXr/8
         18zvEpHOsSOtc9ONMFG9Fwe6e0VTWlbILHmmMz7AH9kCrDOZ4HUWJqlV8HNhRCDaIV95
         LvETDt7qvo0yVkgmbSzzfJDFZQQuwL+B9yy2wzo9fdIkG3+iMdm3XQgCbiXoSiclb0dj
         WReAQDnhlPCJgXwzcKN7LUEp2ybvFlR0SQaXPwPo4LNyLEAnltjEXnq8Pz82tsU5ZLCk
         xeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vAuxFqud/lhrr1wGBSQ/AmhLhcbc4T3Nc+YI7BMqNKA=;
        b=Dlzn6gRTWa1WuQEGa96DfqeOBkM1+wm8RAD1GqEpreJFUSTIKZX21J6xXbw5gqQUeh
         xkoRdfawCDjRvA8WPL1G58hJSdcydt9booiE1SdzCxotEIFLQDqhITVdA/jHlVgofv/T
         qg7+gEh7XJD2/u4b8NanNzCzd2Il0v7qmuB6zTabiVV4CHddNo4rLaPZZPQj+w6+1pbh
         SBzqNVoKH6tvBys1khZMrAMI1JrXjPMLgfqdoB7lR3vum3cIRkjhGf92jDu+KDKhn4ID
         WyACm0xTNTit0EbEkfVyhx3GlstHAssF8StaRTJ2dF93PL7pwsQsfR5kgBRSFtT1C7Do
         kzUQ==
X-Gm-Message-State: APjAAAXbcbcfIkPcbsvo0lyeLuL+d9qRrqvpMg8pXQ7NkThoYXU0yb98
        IAflDtv/Jdpj7fiJr3uTfs9ArRanGRWHCq9AC4whYsCR
X-Google-Smtp-Source: APXvYqyJKG1XfWaAa8LlP14mz/8D1lYxQKFjsXkkQ9go6tAQ6OcVpsmWfUwrkeGf4Ib+CneUu0FKo3otWkjSxqIVmNI=
X-Received: by 2002:a5e:c605:: with SMTP id f5mr1274033iok.78.1559830486737;
 Thu, 06 Jun 2019 07:14:46 -0700 (PDT)
MIME-Version: 1.0
From:   Dan MacDonald <allcoms@gmail.com>
Date:   Thu, 6 Jun 2019 15:14:35 +0100
Message-ID: <CANOoOjvoz4q32tphKo-HwCmNLpugb8DvfSkzkToXRqpwVkve2Q@mail.gmail.com>
Subject: lsblk full disk id output column
To:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

I need a tool that makes it simple to correlate disk device names with
their ids, as can be seen under . The main reason for this is when
administrating ZFS (replacing failed disks etc)  it doesn't deal with
device names (sda, sdb etc) but uses disk id's instead and I often
struggle to marry them up.

I know lsblk already has the "-o model" output column which prints
part of the disk id but I want to see the full disk id (the full
device name, with or without its /dev/disk/by-id prefix) printed under
a column called ID, DISKID or similar.

Thanks
