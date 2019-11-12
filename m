Return-Path: <SRS0=I8Gw=ZE=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E239C43331
	for <util-linux@archiver.kernel.org>; Tue, 12 Nov 2019 08:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084A32084F
	for <util-linux@archiver.kernel.org>; Tue, 12 Nov 2019 08:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlSPNV8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbfKLI1n (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 12 Nov 2019 03:27:43 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33505 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfKLI1n (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 12 Nov 2019 03:27:43 -0500
Received: by mail-ed1-f65.google.com with SMTP id a24so10540915edt.0
        for <util-linux@vger.kernel.org>; Tue, 12 Nov 2019 00:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i2/zelHFWZr+5tP2ULiXq2wWcLOSXV+53f7tNiYKqE8=;
        b=BlSPNV8WfbppZ0rBRow6GePP9jyTfQ9P4AgVDhUIsvEn7+3N0UD+VKZnZxSbOyQCmb
         4AZoY28eG9fFJhJgfi0gVKfcDywPDafSjjpyUKmREWzBWY4yQSKB2nOgTxn3rc8fXrEc
         Js/s52cXVmc2tjsmZ70rtPrNie1+1yuwF3CHbkJPcL65ZcmRGHuYmhiHEs3QcKoyrv5I
         XH5pljMxGuM3yF93bt2TF4iID7eemk1BDBd0QRigqEkvM/D3Twbgk2LFUCMTeeBPSgJJ
         zo29vk6W9l1oOy5I156x54NBAUyqebClR5EShA3jN4xw6Thz7otLlTFimsFHC1eDbCL5
         ZuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i2/zelHFWZr+5tP2ULiXq2wWcLOSXV+53f7tNiYKqE8=;
        b=hU+rR8w9Mw7tLknXvV1rYoIv1BoukmmEEk1ug30Asf3K587EhYugPlxEkJavGz9YKK
         xUZ2fYGo2gVsXU0NnsCLYcDHGuNGHeHbBCNBEZW8/nCsFNbZY3yP0td9/S8wGTm9pmZK
         I1xZ2ef+d0imKro8mUuM5d7k1GqEMzbu6DGJTVPRyU23hoq6xJBRajG/ks3cbWY8EThD
         kAdU3Lh6Pzu7l/qiA2Xk8l6r4vt0pnMPthmhb8H+SxMY2KuBJssGHiIQdsk8gLbHzC8X
         8jnX7x3EhEn9ba7Nq3aGOed4X7An9pcIk1eg+0h31Y0SFsuRdmD2Bh+vf92hZSNN7mrj
         oZEQ==
X-Gm-Message-State: APjAAAVbdjOoqpF4i31oYg7GS/nVnPNfPW1u1mL4SwfYhechBJcF3txs
        VEnen1hRizUdj9f9O6TeaPLLlQScGjwOa28GJuqDYfZ8hys=
X-Google-Smtp-Source: APXvYqxZR1LyMD9v+bxmiJmS1GZK3GC1J29hgWeq+CWqOqs+8L2ZLwzuQKUlEbdkxw0QM/rdjKXNkcKgczghgcF9KNc=
X-Received: by 2002:aa7:c94b:: with SMTP id h11mr31593372edt.252.1573547259275;
 Tue, 12 Nov 2019 00:27:39 -0800 (PST)
MIME-Version: 1.0
References: <20191104202315.4879-1-msuchanek@suse.de> <20191105114122.o3cjzfnoy3hp2rbm@10.255.255.10>
 <20191105171357.GV1384@kitsune.suse.cz> <20191106080256.GA19254@kitsune.suse.cz>
 <20191106084833.nx3agnj36brw7i42@10.255.255.10>
In-Reply-To: <20191106084833.nx3agnj36brw7i42@10.255.255.10>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Tue, 12 Nov 2019 11:27:28 +0300
Message-ID: <CADxRZqxToUUgwR4DqEnS84TBQ7y8hy+s0fBoZYn3_Q-Zit1Ktg@mail.gmail.com>
Subject: Re: [PATCH] blkid: open device in nonblock mode.
To:     Karel Zak <kzak@redhat.com>
Cc:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Nov 6, 2019 at 11:52 AM Karel Zak <kzak@redhat.com> wrote:
>> On Wed, Nov 06, 2019 at 09:02:56AM +0100, Michal Such=C3=A1nek wrote:
> > > First off you need to explain it to all authors of all random scripts
> > > out there.
>
> That's what I'm doing for years :)

considering lsblk / findmnt , how they are supposed to replace blkid
in the following example (taken from os-prober):

                output=3D"$(blkid -o device -t LABEL=3D"$1")" || return 1

i wasn't able to find lsblk alternative to match things (label, uuid,
partition, whatever) - maybe i just don't carefully read manual page
for it ? Of course it is possible to use grep in pipe after lsblk, but
anyway.

Thanks.
