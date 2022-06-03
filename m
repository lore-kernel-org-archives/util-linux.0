Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33864C433EF
	for <util-linux@archiver.kernel.org>; Fri,  3 Jun 2022 11:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242528AbiFCLty (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 3 Jun 2022 07:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241465AbiFCLtx (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 3 Jun 2022 07:49:53 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6964D3A183
        for <util-linux@vger.kernel.org>; Fri,  3 Jun 2022 04:49:52 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 61-20020a9d0bc3000000b0060b9bfcfe76so5340180oth.9
        for <util-linux@vger.kernel.org>; Fri, 03 Jun 2022 04:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JlcqGVJD/NmZW8rCf1iBvPbUnCGh6iQ2TyDUsLXCkew=;
        b=Yl9C/I0XVDfaqHvTlkqPpAtOIgkDo7e4+vVX6LKtntDhkmlIkfpzq5p8s/dc3tq5Wi
         uZlXD9OqniRUmypTqlUfpukC/6Z5kUup9IQv7LSAZq9OKEm5riIzw9cJjq7Sle1Tsdp3
         W+ZE/xYf2o0RvlFajd9RllWiH6t3Qha9jk9hIzunNi8rKH4vZM84fa6isLIY80suC8ci
         SMNVrB5SsHRtI4hu+R52i6TkSLI50qKHFWjEWDDpWeMYo+zk+2TEzkgzQ0eNKHuXdFig
         +H6l+6w57MwOI01WWVSz2fbGbthAs7jN3jQcwRUfcY2o4kwRs+sp3Tj2sB20oMXfPayZ
         3Hcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JlcqGVJD/NmZW8rCf1iBvPbUnCGh6iQ2TyDUsLXCkew=;
        b=k+ThSmDfSJeaSFs96mrCKswXsvB07JFIqJ6cxo/Sz4qxr2S56WR/AWsjCL7Igz6gyi
         qe7VptMv0+kq/m+00YhV0WLwDrXL16ub3Tf7yXXA/TcRESzHF7IsH71L2YW2rL8niBV2
         P65Pqr+pqJqDc4THZ8lU+CagGOK1pB7p1mN+BoB00ZaFAi/iq4MhcQGyYO/kjqNhBZsK
         ooBBKdoSnXEbrzC3OaN1oeCVNc3P7nfd8i5/wXEvgb6hRM91vll0kn6WeGCu6IHAvMhn
         RhuaxBAMPMxD3RfTIS9zeacMZmpowZL113A/H8afuCEC0YbpYn5qHzhM256GLXc1MQBI
         4imw==
X-Gm-Message-State: AOAM532tYamyHTNfMRU43lg00rc7sXRPTZOEsFYzqLfgC3OajEmTTH56
        vM7mxSBYPNIM7VBKPj5DTrlH+hKszsB7B/beTb1fQI0Fowk=
X-Google-Smtp-Source: ABdhPJyek5naaoFfse4VMRrdi07ty/LWQ6dmvOknwfTzNksgbA9dmZ5izZYoJlHqFoZYjJpmx+8C6bKOqyxWIZa2G+U=
X-Received: by 2002:a9d:6044:0:b0:60a:ec88:a218 with SMTP id
 v4-20020a9d6044000000b0060aec88a218mr3965561otj.72.1654256991710; Fri, 03 Jun
 2022 04:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220412045930.236051-1-nwsharp@live.com> <SN6PR04MB398387B3E32DD916801C6F93C2ED9@SN6PR04MB3983.namprd04.prod.outlook.com>
In-Reply-To: <SN6PR04MB398387B3E32DD916801C6F93C2ED9@SN6PR04MB3983.namprd04.prod.outlook.com>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Fri, 3 Jun 2022 14:49:41 +0300
Message-ID: <CADxRZqzipCFaFFAs-o=FDA_g=9NmrqzieXaYtWwbGCCXDeiM5g@mail.gmail.com>
Subject: Re: [PATCH RFC 2/4] pipesz: add tests
To:     Nathan Sharp <nwsharp@live.com>
Cc:     util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Nathan,

at least 2 of those tests is not BE (big-endian) friendly:

mator@gcc203:~/util-linux.git/tests$ ./run.sh misc/pipesz

-------------------- util-linux regression tests --------------------

                    For development purpose only.
                 Don't execute on production system!

       kernel: 5.15.0-2-powerpc64

      options: --srcdir=/home/mator/util-linux.git/tests/.. \
               --builddir=/home/mator/util-linux.git/tests/..

         misc: pipesz                         ...
                : set-fd-bad                  ... OK
                : set-fd                      ... OK
                : set-file-bad                ... OK
                : set-file                    ... OK
                : get-fd-bad                  ... OK
                : get-fd                      ... FAILED (misc/pipesz-get-fd)
                : get-file-bad                ... OK
                : get-file                    ... FAILED (misc/pipesz-get-file)
                : pipe-max-size               ... OK
                : exec                        ... OK
           ... FAILED (2 from 10 sub-tests)

---------------------------------------------------------------------
  1 tests of 1 FAILED

      misc/pipesz
---------------------------------------------------------------------

running on a sparc64 (gcc202) and on powerpc64 (gcc203) machines :

gcc202:~/util-linux$ echo -n | ./pipesz --check --get --stdin
fd 0    131072  0

gcc203:~/util-linux.git$ echo -n | ./pipesz --check --get --stdin
fd 0    1048576 0


So on x86_64 tests expect stdin file to be 64Kb:
gcc202:~/util-linux$ cat tests/expected/misc/pipesz-get-file
/dev/stdin      65536   0
but on sparc64 it is 128Kb and on powerpc64 it is 1Mb...
