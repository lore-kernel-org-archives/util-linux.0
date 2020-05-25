Return-Path: <SRS0=uTWB=7H=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2131C433DF
	for <util-linux@archiver.kernel.org>; Mon, 25 May 2020 13:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEE6E2071A
	for <util-linux@archiver.kernel.org>; Mon, 25 May 2020 13:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtglPl7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403798AbgEYNNY (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 25 May 2020 09:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403767AbgEYNNX (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 25 May 2020 09:13:23 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297FCC061A0E
        for <util-linux@vger.kernel.org>; Mon, 25 May 2020 06:13:23 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id h16so14973633eds.5
        for <util-linux@vger.kernel.org>; Mon, 25 May 2020 06:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TZO9PEfnzwBHW1DeceZMenmj7x+hXiH46PdxwR0CVzA=;
        b=gtglPl7aRJsy2f6EyrmoVwCV/6xPXRTYVm02GPWXVuuBgdNRdBvKC2yhGZWRSrnD0X
         JtEZOdT2Dj1Fu6IEkeCmBE9jlJmmq7XJkjpnOcPtNWM99afQxjgjk4gU5WzeiFz2sEyj
         9jhXob5h4Nb/pKA2ppjGmyy9VJFEhzuyXgp4mD/ZAud9M5eP1Zp2G4dCEopcFjfIdus0
         v5L3hTSCdcNuXGt7qvfAAI3t7ZRHXH8q9eYzYdo3+LSVPo8Kz9DlfQ04mjexqqQhYrhp
         2E1DybQMQXIRrTfaDYIxrBJ8Vs3wjgggH5vvlQKYGWvQjHKkqYiENSEbIL6/uKJ76iK7
         TGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TZO9PEfnzwBHW1DeceZMenmj7x+hXiH46PdxwR0CVzA=;
        b=lytXP7xrp1wCJD7zMAC2fS2EsaRBPJV6Uw1088YP+NfGANk1Efp6/j1m8bGlB8JIAl
         IvR6TmInhrnZ9VYKmTk1fanJSigvJgW8Gz44jqlzRZR7H2kzX8STD6lkfqCHPZPdtqxX
         9yMYA6j/MO9nNCBqbcdSkihjkl3CFdZHAIWg/uEHGeudz3OVeVbPtVrxb9vSA74IrZr2
         yemfygLDgtDrB5TjvLxT8dXvx1+qempao9iiDf+fkakVXzWFqA/S9MQ6uxHQaQCI4NLe
         SmszkDEz0mMyuM7RR/4HCRFLGlGTpsvjPP//Lj+7eChqlPfaKidT7rfJELy3B9/zcXbv
         tJrA==
X-Gm-Message-State: AOAM533E9Xb2W7tm0e5Ed5fHbzcl17HeQqQavw3nlS2EKdeP/Jb2dQyM
        ewy6kgs37MH3AIWt9iXovGRql2ZAl5k=
X-Google-Smtp-Source: ABdhPJyK9FK2Sb52Ct4zPz/hGsughyN/qKUnneqU/AqwQqiXXRH8rNoRZoU2WMhBrTmdQAhIQpu/+A==
X-Received: by 2002:a50:d7d1:: with SMTP id m17mr2362851edj.126.1590412401815;
        Mon, 25 May 2020 06:13:21 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id d15sm15677605edr.3.2020.05.25.06.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 06:13:21 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, util-linux@vger.kernel.org
Subject: Re: [PATCH 1/9] Manual pages: nsenter.1, unshare.1: update references
 to *_namespaces(7) pages
To:     Karel Zak <kzak@redhat.com>
References: <20200523064325.78491-1-mtk.manpages@gmail.com>
 <20200525121745.rmdn47zlchtf76fh@ws.net.home>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <4d4bb487-4a9c-1fcb-71a6-059379597d15@gmail.com>
Date:   Mon, 25 May 2020 15:13:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200525121745.rmdn47zlchtf76fh@ws.net.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 5/25/20 2:17 PM, Karel Zak wrote:
> On Sat, May 23, 2020 at 08:43:17AM +0200, Michael Kerrisk wrote:
>>  sys-utils/nsenter.1 | 6 +++---
>>  sys-utils/unshare.1 | 6 +++---
>>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> Applied all 9 patches, thanks.

Thanks, Karel.

A follow-up question. There was one piece of the unshare(1) examples
that I did not try to rework, because I simply don't understand it:

       Establish  a  persistent  mount  namespace  referenced by the bind
       mount /root/namespaces/mnt.  This example shows a  portable  solu‐
       tion,  because  it  makes sure that the bind mount is created on a
       shared filesystem.

           # mount --bind /root/namespaces /root/namespaces
           # mount --make-private /root/namespaces
           # touch /root/namespaces/mnt
           # unshare --mount=/root/namespaces/mnt

I think you wrote this example. What does the sentence "This example shows
a portable solution, because it makes sure that the bind mount is created
on a shared filesystem" mean? I think this needs clarification, and I'd try
to do so, but it's not clear to me what the sentence is trying to say.

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
