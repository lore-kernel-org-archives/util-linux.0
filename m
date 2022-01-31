Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44921C433EF
	for <util-linux@archiver.kernel.org>; Mon, 31 Jan 2022 20:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378497AbiAaURh (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 31 Jan 2022 15:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357590AbiAaURe (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 31 Jan 2022 15:17:34 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CE7C06173B
        for <util-linux@vger.kernel.org>; Mon, 31 Jan 2022 12:17:33 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d187so13833026pfa.10
        for <util-linux@vger.kernel.org>; Mon, 31 Jan 2022 12:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=bestwentulH5u2NNvQMC8TackhZ6//Z6vXmXmn021p4=;
        b=SeEMcUVxVR5Rr3znBYzcSYNhR0soVrrLqDCQIQa0BWxtfT3OyiDs6T19mo/V3JYzHo
         hJmaC90gJSoCywcQf20HSVATn3npW/aDHlMcJG1y/xoASYoqRK+i4j8BUDL34yQayVyZ
         8Na2Rdhea5Y4VYUDnI2LuiO0fMx6+yPs15h3IsaNmb9VzvVp/01sAZvqlSF4nlgNfPyC
         2hywbXJS0nLF1qzerBOqMZ0QJIkuxq8n+mqPejs8YVdrVG7QDtLTzsnif7SRBNVR5QKp
         Q046r7jXdM/PtTnb4dehE99HmWi/hVVXMGATnvhqRu1IBujx4H4D9bdkojRs1jFpUQZT
         FEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=bestwentulH5u2NNvQMC8TackhZ6//Z6vXmXmn021p4=;
        b=WxUrrw+DxLevbd2bZz3nFjQ2ko/nayO1hTn1HEQcL/gf9WN6Bh+RZk7+I/AY9m9EBR
         TqW7pNNY1fkBeJ/bLg+5HYtBA/qpGSQ472vxI4ZbRIRl5u/9eROCepDKVnbIc2OzdEez
         XzqtvRqdZPFUDapetjicY+/qq0AHHqSnamYb+w88GqdbZk5mmlbN2GmqZyQbPYLq+SN4
         vU6i7ItqN1I4ke8/FBCGa0+HifYDqV4EXjfLx3SoWJ62SWJUQ0scVddzLKLi2UYthT7x
         1I2gORsiUmkAGFuJWW+fQL9I0IseHZmQr0KomuHjX1ZgyxMArxUyV5HFWkNMyJVDtHLT
         nqTw==
X-Gm-Message-State: AOAM532BlzQmkZlHuIXBLuVgbBvyCEOKU3clFCXGmHod4T+Cv6HjiFO/
        MH2v5xHXmFM1B6vgOSxQHoJqfMCpPxcpcdtdFoRKUjqw9eU=
X-Google-Smtp-Source: ABdhPJy+U6PrsYTRwh1EpPlKknhcV6wapZVnMDvO9cmYOI9Y8NB7dZ8rBOeYWDXddiZxPgULPn5EV7reW40m6SrGwY8=
X-Received: by 2002:a65:4c87:: with SMTP id m7mr17969231pgt.509.1643660253366;
 Mon, 31 Jan 2022 12:17:33 -0800 (PST)
MIME-Version: 1.0
References: <CAHi0vA9rJS=+KT2PxTQ9bBeutt9KqpmgvmhJq3VASrKke_h+NQ@mail.gmail.com>
 <20220131093510.onug66aufuadj2ed@ws.net.home>
In-Reply-To: <20220131093510.onug66aufuadj2ed@ws.net.home>
From:   =?UTF-8?Q?Mario_Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Date:   Mon, 31 Jan 2022 21:17:22 +0100
Message-ID: <CAHi0vA-8RYm88aYbLAuTcwBLYuH+GsVWP2WEqucFQXCsg2CKpg@mail.gmail.com>
Subject: Re: Unify the --help and --version descriptions in man pages?
To:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello Karel,

Am Mo., 31. Jan. 2022 um 10:35 Uhr schrieb Karel Zak <kzak@redhat.com>:
>
> On Sat, Jan 29, 2022 at 12:57:12PM +0100, Mario Bl=C3=A4ttermann wrote:
> > I've just noticed the commit =C2=BBdocs: add man-common/in-bytes.adoc=
=C2=AB.
> > What about to unify the descriptions of the --help and the --version
> > options in the man pages in a similar manner? Besides to simplify the
> > ma=C3=ADntenance, it would also shrink the .po file of the man pages a =
bit.
>
> Arbitrary unification and consolidation is wanted, go ahead ;-)
>
> > --- blockdev.8.adoc     2021-11-26 17:40:06.931013901 +0100
> > +++ blockdev.8.adoc    2022-01-29 12:47:43.087144014 +0100
> > @@ -40,10 +40,10 @@
> > Print a report for the specified device. It is possible to give multipl=
e device
> > s. If none is given, all devices which appear in _/proc/partitions_ are=
 shown. N
> > ote that the partition StartSec is in 512-byte sectors.
> >
> > *-h*, *--help*::
> > -Display help text and exit.
> > +include::man-common/help-description.adoc[]
> >
> > *-V*, *--version*::
> > -Print version and exit.
> > +include::man-common/version-description.adoc[]
>
> Do we need to separate help & version? Maybe we can use
>
>   include::man-common/help-and-version.adoc[]
>
> where will be everything.
>
>       *-h*, *--help*
>               Display help text and exit.
>
>       *-V*, *--version*
>               Display version information and exit.
>
> We use the same in usage() function (--help output) where both
> items are printed together by USAGE_HELP_OPTIONS macro. (see 'git grep
> USAGE_HELP_OPTIONS')
>
> IMHO --help and --version is so generic that we do not need to keep it
> sorted in man pages. I guess it's OK to keep it at the end of the list
> of options like we use in usage().


OK, this is possible for --help without any other changes; all our
tools have the same options (*-h*, *--help*). But for --version, the
single-letter option differs. While most of the tools have *-V*,
*--version*, it is *-v*, *--version* for the following ones:

sfdisk.8.adoc
chsh.1.adoc
chfn.1.adoc

For sfdisk, -V has a different meaning, and for chsh and chfn the
option -V is unknown (invalid). So we could change chsh and chfn to
accept -V (and maybe drop -v in turn), and we leave the --help and
--version part of sfdisk.8.adoc untouched.

 >
> > BTW, are there any plans for the next release 2.38? I'm planning to
>
> The last remaining patch is x-fstrim from Stanislav and than I'll
> release v2.38-rc1 :-) (so today).
>
> > add direct support for Fedora 36 in manpages-l10n (once it is
> > available from the servers), in addition to Rawhide. If v2.38 will
> > come with Fedora 36, I could adjust the package lists appropriately,
> > to avoid file conflicts.
>
> F36 beta freeze is 2022-03-15, it seems we have enough time.
>
So I assume you plan to release the final v2.38 until this Fedora Beta
gets rolled out, including the translated man pages?

Best Regards,
Mario
