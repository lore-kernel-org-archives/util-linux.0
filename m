Return-Path: <SRS0=2g+Q=UD=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8ED4C282CE
	for <util-linux@archiver.kernel.org>; Tue,  4 Jun 2019 13:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B79F23A6C
	for <util-linux@archiver.kernel.org>; Tue,  4 Jun 2019 13:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfFDNzp (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:55:45 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:34598 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfFDNzp (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 4 Jun 2019 09:55:45 -0400
Received: by mail-wr1-f47.google.com with SMTP id e16so7686891wrn.1
        for <util-linux@vger.kernel.org>; Tue, 04 Jun 2019 06:55:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CgN8aabzAo4LfmPtWsyhV996XJHSr3gIHJFh5dth1RE=;
        b=t4YDndz3asdxmIdmuYuQkHmPHJBkJ3ch7mBf7GS+udMqG+F8Pl8dyzZQqzB9n9GqLg
         1r7DIvs/BVbhHTME6nt+i3BeC1lxGhhnUS52d9gMTQ514inpHUhfA/67cyScrQ+A785v
         oKc3/5DUX298h/zN0cWr5nW6erGaMZnSGJgK65iYvkbpAEm/rxR5I0v9HGaKwvlvYsMl
         qXKbVSR+cGAOCoJh/jxl38pqGOysuXzTXzx0yvp4B67BvzFAsI4HOZWox3ZAM2qjFJLw
         US7FEkycda09UN+JMKLxISlZII5wtv86fVc2xRtdVyd0Yxl+ke3XeSOUfhMKhThrhVvY
         5ALQ==
X-Gm-Message-State: APjAAAUmOO10tYitOJ74ZRzsahWatimbeW33rpRtrOwFqWSzxcTLEpp3
        aI3NNM5xQdJG716qmSxQ5EKa9a1bQLg=
X-Google-Smtp-Source: APXvYqxwH+qIxs6459sPcZwKsPchDCfFOpP97UssfQ/aeA8cFYJA29578z9bfbiUe7m/EgWnDZSTqg==
X-Received: by 2002:a05:6000:104e:: with SMTP id c14mr10257400wrx.71.1559656542536;
        Tue, 04 Jun 2019 06:55:42 -0700 (PDT)
Received: from [10.43.2.81] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id u13sm3504563wrq.62.2019.06.04.06.55.41
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 06:55:41 -0700 (PDT)
From:   =?UTF-8?Q?V=c3=a1clav_Dole=c5=beal?= <vdolezal@redhat.com>
Subject: Re: careful with that umount options, Eugene
To:     Harald Dunkel <harald.dunkel@aixigo.com>,
        util-linux@vger.kernel.org
References: <6c72d034-e172-9beb-e61b-bb74807ded0a@aixigo.com>
Message-ID: <717bc7fe-3179-98d3-ae2c-c0ab705a75c1@redhat.com>
Date:   Tue, 4 Jun 2019 15:55:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <6c72d034-e172-9beb-e61b-bb74807ded0a@aixigo.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi,
-a (--all) and -l (--lazy) are valid options and GNU getopt
reorders arguments (options first) so umount has seen

    umount --all --lazy ls /mnt/

and because --all mode doesn't take any arguments, it ignored
'ls /mnt/'. Modifying this to error on extra args should be
trivial.

As for the command unmounting /proc when it should be ignored,
it is caused by umounting root dir with --lazy (MNT_DETACH)
option. See umount2(2).

Regards,
Václav Doležal

On 2019-06-04 at 13:51 Harald Dunkel wrote:
> Hi folks
> 
> by accident I pasted
> 
>     umount ls -al /mnt/
> 
> into bash. My bad. AFAICT /proc was umounted immediately, the
> rest died slowly. Don't try this at home.
> 
> Point is, according to the man page this command line should
> have triggered an error message. "umount ls -al" doesn't make
> sense.
> 
> Do you think the command line parser could be fixed?
> 
> util-linux is version 2.29.2-1+deb9u1, as included in Debian.
> Of course I checked the diff for umount.c between 2.29 and
> 3.34-rc2. Apparently the getopt code has been improved, but I
> did not notice a fix for this particular problem.
> 
> 
> Thanx in advance. Keep on your good work
> Harri
