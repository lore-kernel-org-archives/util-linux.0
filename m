Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BD3EB64DD
	for <util-linux@archiver.kernel.org>; Thu, 17 Aug 2023 09:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244779AbjHQJ6O (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 17 Aug 2023 05:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349877AbjHQJ6N (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 17 Aug 2023 05:58:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDBA12C
        for <util-linux@vger.kernel.org>; Thu, 17 Aug 2023 02:58:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3192E6409B
        for <util-linux@vger.kernel.org>; Thu, 17 Aug 2023 09:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA95C433C9
        for <util-linux@vger.kernel.org>; Thu, 17 Aug 2023 09:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692266291;
        bh=mMM/XHKPAR7XLILIpxt8zTbcHVgkDxUm3qw3i+6KGFg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=je0XNeeOdcSUgzepXu4hjJN/5Jhj5BD9Fst8ViHnZxO7DncwCSFKkRF6D9lXLXAqQ
         KKceb68EFiSkIrODipu2jrWzeoof06/HL7ytJ/nN1pD5uceDRcWVayubT8fY89U7Fu
         A3WbJjHCdvzdj7sslE2gLEtErIP8vvf/ppaxrC4socm/1CX7jQPUMd/B2scqBzwmR5
         cWJplxSA8YoONeJ2N7rWlz/xDvdedaYhHTEgk2EpkdJ94kq5ZfIjIjTro6FDno4pX/
         mORz109BAjm6Bky2c8tvev9WBlNkWIXWc6EvG9uvvm8N8dEFUFHoU0zBZ7ABrkfwvf
         HXlZDwjDViOAA==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6b9a2416b1cso6363572a34.2
        for <util-linux@vger.kernel.org>; Thu, 17 Aug 2023 02:58:11 -0700 (PDT)
X-Gm-Message-State: AOJu0YxL0oPkxYoJ6QVgvE9V4Ba8NaFlbfLtX7jUpb6CWKegEj6K3lYo
        K1V0vgDxY2KGgslMGksTYEMattv+sasUGmjDiXw=
X-Google-Smtp-Source: AGHT+IFZW0o78vgLrx2JmFsm/S9FC88I+18NhaB6/fWNsvl6W82+6hitXzdcSMoi/VdHsxEWvvtm+hygrFOPCUaKSG8=
X-Received: by 2002:a05:6871:727:b0:1bf:e1e9:a320 with SMTP id
 f39-20020a056871072700b001bfe1e9a320mr5531591oap.13.1692266290673; Thu, 17
 Aug 2023 02:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <aeef1a885d791881a6cf0e61e405f5490f060701.1692264006.git.fdmanana@suse.com>
 <20230817095401.ystzfnqn5udsbrij@ws.net.home>
In-Reply-To: <20230817095401.ystzfnqn5udsbrij@ws.net.home>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 17 Aug 2023 10:57:34 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6RE2CmJTKc96EL34Nqmfw_=CQ22jJMoUwshA2TQXCMDw@mail.gmail.com>
Message-ID: <CAL3q7H6RE2CmJTKc96EL34Nqmfw_=CQ22jJMoUwshA2TQXCMDw@mail.gmail.com>
Subject: Re: [PATCH] libmount: Fix regression when mounting with atime
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Aug 17, 2023 at 10:54=E2=80=AFAM Karel Zak <kzak@redhat.com> wrote:
>
> On Thu, Aug 17, 2023 at 10:20:13AM +0100, fdmanana@kernel.org wrote:
> > A regression was introduced in v2.39 that causes mounting with the atim=
e
> > option to fail:
> >
> >   $ mkfs.ext4 -F /dev/sdi
> >   $ mount -o atime /dev/sdi /mnt/sdi
> >   mount: /mnt/sdi: not mount point or bad option.
> >          dmesg(1) may have more information after failed mount system c=
all.
>
> Great timing! I just released bugfix tarball v2.39.2 a few minutes ago :-=
)

Ahaha yes!

I was supposed to send it yesterday, but I had to take some time to
figure out where to write a test case, so that's what took most of the
time actually :)

Thanks.


>
> > diff --git a/libmount/src/optlist.c b/libmount/src/optlist.c
> > index e93810b47..d0afc94f7 100644
> > --- a/libmount/src/optlist.c
> > +++ b/libmount/src/optlist.c
> > @@ -875,7 +875,18 @@ int mnt_optlist_get_attrs(struct libmnt_optlist *l=
s, uint64_t *set, uint64_t *cl
> >
> >               if (opt->ent->mask & MNT_INVERT) {
> >                       DBG(OPTLIST, ul_debugobj(ls, " clr: %s", opt->ent=
->name));
> > -                     *clr |=3D x;
> > +                     /*
> > +                      * All atime settings are mutually exclusive so *=
clr must
> > +                      * have MOUNT_ATTR__ATIME set.
> > +                      *
> > +                      * See the function fs/namespace.c:build_mount_ka=
ttr()
> > +                      * in the linux kernel source.
> > +                      */
> > +                     if (x =3D=3D MOUNT_ATTR_RELATIME || x =3D=3D MOUN=
T_ATTR_NOATIME ||
> > +                         x =3D=3D MOUNT_ATTR_STRICTATIME)
> > +                             *clr |=3D MOUNT_ATTR__ATIME;
> > +                     else
> > +                             *clr |=3D x;
>
> Ah, the libmount code does this, but only when set a new option. This is
> missing for inverted options (like atime).
>
> > +# Test that the atime option works after the migration to use the new =
kernel mount APIs.
> > +ts_run $TESTPROG --mount -o atime $DEVICE $MOUNTPOINT >> $TS_OUTPUT 2>=
> $TS_ERRLOG
> > +$TS_CMD_FINDMNT --kernel --mountpoint $MOUNTPOINT -o VFS-OPTIONS -n >>=
 $TS_OUTPUT 2>> $TS_ERRLOG
> > +is_mounted $DEVICE || echo "$DEVICE not mounted" >> $TS_OUTPUT 2>> $TS=
_ERRLOG
> > +ts_run $TESTPROG --umount $MOUNTPOINT >> $TS_OUTPUT 2>> $TS_ERRLOG
> > +is_mounted $DEVICE && echo "$DEVICE still mounted" >> $TS_OUTPUT 2>> $=
TS_ERRLOG
> > +
> > +ts_finalize_subtest
>
> Applied, thanks, and extra thanks for the tests!
>
>     Karel
>
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
>
