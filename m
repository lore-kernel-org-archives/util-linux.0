Return-Path: <SRS0=vWqr=7J=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E60BC433DF
	for <util-linux@archiver.kernel.org>; Wed, 27 May 2020 03:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E7E9206C3
	for <util-linux@archiver.kernel.org>; Wed, 27 May 2020 03:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgE0DLa convert rfc822-to-8bit (ORCPT
        <rfc822;util-linux@archiver.kernel.org>);
        Tue, 26 May 2020 23:11:30 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:55054 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgE0DL3 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 26 May 2020 23:11:29 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 2C5E65611DC
        for <util-linux@vger.kernel.org>; Wed, 27 May 2020 05:11:26 +0200 (CEST)
Received: by mail-pl1-f169.google.com with SMTP id t7so9548793plr.0
        for <util-linux@vger.kernel.org>; Tue, 26 May 2020 20:11:26 -0700 (PDT)
X-Gm-Message-State: AOAM5324U8+KJ2wJ6oHWK5o89s33GXCdRouDW3o3PEiEfKgSXBMi47ow
        iI5OT4wX1mez0sU0xJq3Ffhl+TUNAK6zzajmhsA=
X-Google-Smtp-Source: ABdhPJwfKGVPGtFiaCbqoDkbdGAdj5tZvMI5ZI3iEUuYvJFXAcxKH7/jWt00LzrGBvWDaje66TiHYZhy/K1gwO6p67Q=
X-Received: by 2002:a17:90a:348e:: with SMTP id p14mr2424801pjb.235.1590549084385;
 Tue, 26 May 2020 20:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <6b88784c-b130-27d4-2ec5-0d25320dd6fb@gmail.com>
 <CAA0A08W0S8ZnZXJ1D0VDnC6qZ4F0sYP_tr9qK7_7Fxi5HGOqAw@mail.gmail.com> <4999c47d-969a-a103-3d6a-60498f1fc959@gmail.com>
In-Reply-To: <4999c47d-969a-a103-3d6a-60498f1fc959@gmail.com>
From:   =?UTF-8?Q?Aur=C3=A9lien_Lajoie?= <orel@melix.net>
Date:   Wed, 27 May 2020 05:11:13 +0200
X-Gmail-Original-Message-ID: <CAA0A08VitXbWL8A7ZP5ZaQM+dKWpwsaKzYVYeask1VfbU4LmCw@mail.gmail.com>
Message-ID: <CAA0A08VitXbWL8A7ZP5ZaQM+dKWpwsaKzYVYeask1VfbU4LmCw@mail.gmail.com>
Subject: Re: util-linux-2.35.2 test failures
To:     Util-Linux <util-linux@vger.kernel.org>
Cc:     Bruce Dubbs <bruce.dubbs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed May 27 05:11:26 2020 +0200 (CEST))
X-Org-Mail: aurelien.lajoie.2000@polytechnique.org
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, May 27, 2020 at 1:36 AM Bruce Dubbs <bruce.dubbs@gmail.com> wrote:
>
> On 5/26/20 6:07 PM, Aurélien Lajoie wrote:
> > On Wed, May 27, 2020 at 12:34 AM Bruce Dubbs <bruce.dubbs@gmail.com> wrote:
> >>
> >> I'm getting three test failures and hope I can get someone to help.
> >>
> >> The test failures are  ipcs/mk-rm-msg, ipcs/mk-rm-sem, and ipcs/mk-rm-shm.
> >>
> >> Concentrating on mk-rm-msg, I found on the system:
> >>
> >> ./tests/output/ipcs/mk-rm-msg
> >> ./tests/ts/ipcs/mk-rm-msg
> >> ./tests/expected/ipcs/mk-rm-msg
> >>
> >> The contents of the output and the expected files are identical:
> >
> > How have you checked it ?
>
> Yes.  cmp ./tests/output/ipcs/mk-rm-msg ./tests/expected/ipcs/mk-rm-msg
> gives no output.
>
> > Can be trailing spaces, final break line or other thing like this.
> > Can you share the files and the result of ./run.sh ipcs launch from
> > tests directory?
>
> -------------------- util-linux regression tests --------------------
>
>                      For development purpose only.
>                   Don't execute on production system!
>
>         kernel: 5.6.11-lfs-9.1
>
>        options: --srcdir=/sources/util-linux-2.35.2/tests/.. \
>                 --builddir=/sources/util-linux-2.35.2/tests/..
>
>           ipcs: headers                        ... OK
>           ipcs: limits overflow
> .../sources/util-linux-2.35.2/tests/../tests/ts/ipcs/limits: line 42:
> echo: write error: Invalid argument
>   OK
>           ipcs: basic limits               ... OK
>           ipcs: mk-rm-msg                  ... FAILED (ipcs/mk-rm-msg)
>           ipcs: mk-rm-sem                  ... FAILED (ipcs/mk-rm-sem)
>           ipcs: mk-rm-shm                  ... FAILED (ipcs/mk-rm-shm)
>
> ---------------------------------------------------------------------
>    3 tests of 6 FAILED
>
> I'll note that I am not running as root, line 42 of ts/ipcs/limits seems
> to want to write to:
>
> $ ls -l /proc/sys/kernel/shm*
> -rw-r--r-- 1 root root 0 May 26 18:27 /proc/sys/kernel/shm_rmid_forced
> -rw-r--r-- 1 root root 0 May 26 14:32 /proc/sys/kernel/shmall
> -rw-r--r-- 1 root root 0 May 26 14:32 /proc/sys/kernel/shmmax
> -rw-r--r-- 1 root root 0 May 26 14:32 /proc/sys/kernel/shmmni
>
I get this output as a non root user
 ./run.sh ipcs

-------------------- util-linux regression tests --------------------

                    For development purpose only.
                 Don't execute on production system!

       kernel: 5.3.0-53-generic

      options: --srcdir=/home/aurelienl/dev/util-linux/tests/.. \
               --builddir=/home/aurelienl/dev/util-linux/tests/..

         ipcs: headers                        ... OK
         ipcs: limits overflow                ... SKIPPED (no root permissions)
         ipcs: basic limits                   ... OK
         ipcs: mk-rm-msg                      ... OK
         ipcs: mk-rm-sem                      ... OK
         ipcs: mk-rm-shm                      ... OK

---------------------------------------------------------------------
  All 6 tests PASSED
---------------------------------------------------------------------


>
>    -- Bruce
>
>
>
>

