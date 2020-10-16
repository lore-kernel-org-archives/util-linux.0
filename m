Return-Path: <SRS0=UJE+=DX=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864A5C433DF
	for <util-linux@archiver.kernel.org>; Fri, 16 Oct 2020 18:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D3B320878
	for <util-linux@archiver.kernel.org>; Fri, 16 Oct 2020 18:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeeRd63p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgJPSaq (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 16 Oct 2020 14:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391614AbgJPSaP (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 16 Oct 2020 14:30:15 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BF0C061755
        for <util-linux@vger.kernel.org>; Fri, 16 Oct 2020 11:30:15 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e17so3991596wru.12
        for <util-linux@vger.kernel.org>; Fri, 16 Oct 2020 11:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=v1bFrzJ3vph3uBK7NFFRfoFbLHPd4Owo3d4raHwdPZs=;
        b=WeeRd63pjqUmmtXoqE8eeXLPwIN8sSIoqtK3F7xiST7DZcgUPXT6jHkDAEarlstB9M
         lRvVn/GyNo7mE+Ult++IXIQ6Fa6cc0JpMmSG6Lc1aJg27w2J7jA+wCwtG6IPqfUVdpkC
         VMutM/80/mhsbttbOOshDW8DSaKktroxU0EsMp1S5lmBCigEnJL9NPMd6hJmWK14+/Fm
         HsCY9syQlKkaXlorFwuWNB+EmLbHhoh/I0YT3p6P8eQHt0Ltb8RBBjNUBAb/E+LaXkuV
         6usEoWT9KtuGVJkBIaqSrmkHvsbNt/m6zlMVWAYZkIafj6RxBqKh0Y6DT10Bh/TffC6b
         9mBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=v1bFrzJ3vph3uBK7NFFRfoFbLHPd4Owo3d4raHwdPZs=;
        b=tWfiL67OFVJc3dXw53UDD3pNMchKK5RMTRKmCepBqQkLebWGukJg3/sJl+whFCYB5/
         oX8BfJ8omY7XmlQylnhnTRkoiM7m0yhft74dmO+nUxEkPbeQrHPtI7hjO5olSC7Xg/Wd
         efmUVv1rOp2c5Cgj4vupVQGTJjUT79zgO15oUAVfnIMjOxMBCSZTCAnMEWOubl9Q2mbD
         sM7hIv4qO02aNuYSNWI2ocH0eEBAQ+U9gqdTwLHbd02CONSVQzvlS6fE9Sakq2Y0zKKj
         FNxURFD93wCFYCqtE8D/0M/2AdIwEAZyoq0rUduBFGmprhDpRFt3wdykoaGJRPt9bm1x
         4hXA==
X-Gm-Message-State: AOAM532A2GrxlafuJ9PpLheLEYRX4JE8QAUWYhpBzr+uimDsnFglJ5QO
        ab7jQBeRYMOrAygEZX1LH/j9B0Rrtbhrdw==
X-Google-Smtp-Source: ABdhPJzR9/KMqu2/N5EwQKDTYUOG+Ro9eHm0Xn2EFXzaGTRNwcu97rf2uCFwMdAs8Q/TmDfijlYtwg==
X-Received: by 2002:adf:e801:: with SMTP id o1mr5492289wrm.359.1602873013601;
        Fri, 16 Oct 2020 11:30:13 -0700 (PDT)
Received: from ?IPv6:2601:196:181:38c0::2da2? ([2601:196:181:38c0::2da2])
        by smtp.gmail.com with ESMTPSA id 88sm4927351wrl.76.2020.10.16.11.30.12
        for <util-linux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 11:30:12 -0700 (PDT)
To:     util-linux@vger.kernel.org
From:   Thomas Stringer <trstringer@gmail.com>
Subject: fallocate on ext4 creating holes
Message-ID: <58f7cb75-1e2b-ec2b-221f-0af2c80b2728@gmail.com>
Date:   Fri, 16 Oct 2020 14:30:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

I've found that in recent kernel versions (5.7+) that fallocate creates 
files on ext4 filesystem with holes. Here is a repo:

$ sudo fallocate -l 512MiB /mnt/swapfile
$ sudo filefrag -e /mnt/swapfile
Filesystem type is: ef53
File size of /mnt/swapfile is 536870912 (131072 blocks of 4096 bytes)
  ext:     logical_offset:        physical_offset: length: expected: flags:
    0:        0..   63487:      34816..     98303: 63488:             
unwritten
    1:    63488..  126975:     100352..    163839:  63488: 98304: unwritten
    2:   126976..  131071:     165888..    169983:   4096: 163840: 
last,unwritten,eof
/mnt/swapfile: 3 extents found
$ sudo chmod 0600 /mnt/swapfile
$ sudo mkswap /mnt/swapfile
$ sudo swapon /mnt/swapfile
swapon: /mnt/swapfile: swapon failed: Invalid argument
$ sudo journalctl | grep hole
Oct 15 15:42:59 hostname kernel: swapon: swapfile has holes
Oct 15 15:43:09 hostname kernel: swapon: swapfile has holes
Oct 15 15:43:23 hostname kernel: swapon: swapfile has holes

But in previous versions (4.19 verified) this operation succeeds and 
swapon doesn't indicate holes in the file.

Is the behavior of creating files with fallocate on ext4 filesystems 
with holes expected and by-design?

Thank you in advance for any insight!
Thomas
