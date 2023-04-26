Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570B7C7618E
	for <util-linux@archiver.kernel.org>; Wed, 26 Apr 2023 19:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239340AbjDZTLA (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 26 Apr 2023 15:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjDZTK7 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 26 Apr 2023 15:10:59 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A8549C9
        for <util-linux@vger.kernel.org>; Wed, 26 Apr 2023 12:10:50 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-b95c3b869dcso545322276.1
        for <util-linux@vger.kernel.org>; Wed, 26 Apr 2023 12:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682536249; x=1685128249;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzL2jDw5Ei31Amzu/mrjX2f0sIR/BZGNeFOlcPY+j5w=;
        b=hxN7cAFoQhhxr6pANC+hPq2lJFpiPBzmYVU20HU58WtRt3Q+G1G89AO0ZjvoxI+b9J
         R85Npq2XGAyOboeQELrjTQIL0ltEQ8k8YEA9XkNjHZ83pnPTBf/98ki7hGp3L+UiF6rN
         zHN0pMLPDuVF/XhlEMxhp/e65qY4/R2UaTpOhE9oXXrb6qu5lTrtu49J11NbR5uh6X7S
         5eqvT38zKZ2ezV1ksaEZQSkuZ7GG33YOI3GJYFV6ST8RF8YUAGqPCczQy1t9P/U8eLs5
         pmU4xRBHoK4jJD2IM5qZ/ka/tFI3lZQ2XU3CdRtK0RsqRLpB7XdrC6Z0qHUE0aaae/uo
         vI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682536249; x=1685128249;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QzL2jDw5Ei31Amzu/mrjX2f0sIR/BZGNeFOlcPY+j5w=;
        b=CUHky1T9JPXOSyLM6DI/tYtOlmM17eJxicgpnE2Ykq0HEmPmMryOM3ohHI1EQfmDQR
         S+eVPJnCRaD9qoF2fWRHhqP0EVLhKwP2zztP0b7ebOaAM5tTzR3+I6gmuiZGmz7LKwAB
         bhCCb/1opeQdSSKogp5hR+7zooArgJyLW2qTscZjxr+9nGiXsYn84uwe9Avvv2MJbxR1
         6id8XLaGLvjRy/wTrzcaqIovb5Zmbs1GGKOAkcE4dPjg/FCFFcgNnuTyHZWRq/VW/wco
         8j+c8sFVXKttYW1IDc5e6tEzTDb8ysmpDrYoUj5xmrsQju1sa2Vi6wsffkUVPg+aFAzO
         5rbw==
X-Gm-Message-State: AC+VfDwhwWkZ9nWrGjGxonBC4xEvCWk7dhQFXR2GaAOLGlmZLZOTNpRP
        VUFAxiCU7rBkjNekBcy4GLqtjBLd41DhP8+BUFooL5d8mwM=
X-Google-Smtp-Source: ACHHUZ5Lj46jUOUaJjh1OKfs/L5/WWcryRxGWEvu3IOhFZ1560flR6DZD3NR6hNcZmnLkscifDWWKMeWQXqmCJyfSiU=
X-Received: by 2002:a0d:d948:0:b0:541:6b00:f68d with SMTP id
 b69-20020a0dd948000000b005416b00f68dmr2469815ywe.16.1682536249371; Wed, 26
 Apr 2023 12:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAHi0vA9nvmh7qiWX2oWbOcanCesk2M9dS0Goef6772emz=uy4g@mail.gmail.com>
 <20230426102806.7w33zaheh3feuohg@ws.net.home>
In-Reply-To: <20230426102806.7w33zaheh3feuohg@ws.net.home>
From:   =?UTF-8?Q?Mario_Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Date:   Wed, 26 Apr 2023 21:10:38 +0200
Message-ID: <CAHi0vA9PyvgD6ij3cR6fQyfZPeKAFB-YHy=XRkLZwE6OLYe5cg@mail.gmail.com>
Subject: Re: util-linux v2.39 with translated man pages by default?
To:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello Karel,

Am Mi., 26. Apr. 2023 um 12:28 Uhr schrieb Karel Zak <kzak@redhat.com>:
>
> On Wed, Apr 19, 2023 at 08:24:47PM +0200, Mario Bl=C3=A4ttermann wrote:
> > Hello,
> >
> > when I run ./configure (without any option) on the current Git content,=
 I get:
> >
> >         Manual pages:              yes
> >         Manual pages translated:   no
> >
> > This means, creating and installing the translated man pages is still
> > not enabled by default. What may we expect for v2.39? If this remains
>
> Good point. I have enabled it:
>  https://github.com/util-linux/util-linux/commit/9acfc349e0ea68a92baf818c=
c659121f40ab9c04
>
Thanks.

> but as in other cases, the default is "check", and the result depends on
> if you have "po4a" installed, and if not installed, you will see a
> warning
>
>     configure: WARNING: po4a not found; not building translated man pages
>
> but ./configure will success.
>

This is OK so far.

> > disabled, no downstream packager will notice it, and the effort of the
> > translators (6 languages, more than 500 translated *.adoc files) was
> > for the trashscan.
>
> I need to think about how to push it to Fedora/RHEL; I'll probably
> create a sub-package with the translations, one for all or per
> language. Is there any good practice for man pages?
>

Please have a look at procps-ng. It ships *both* UI and man page
translations in a subpackage named procps-ng-l10n. This would be an
acceptable solution: Users who need translated user interfaces, should
also get the corresponding translated man pages. But this shouldn't be
treated as the "usual" way for command line tools. For example,
psmisc, dos2unix or wcd ship the translated man pages in the base
package.

On the other hand, have a look at Gnome packages. The help files (in
/usr/share/help/$LANG) reside in the base package; I haven't found any
separate packages for the localized user docs. Besides the above
approach with outsourcing all i18n-related files in a "-i18n"
subpackage, you could test how much bigger the packages become when
you ship the translated man pages along with their English originals
in the same package. I think the growth is acceptable, given the
nowadays' hard disk capacities.

Best Regards,
Mario
