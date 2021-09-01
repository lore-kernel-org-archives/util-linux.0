Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81612C4320A
	for <util-linux@archiver.kernel.org>; Wed,  1 Sep 2021 17:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67D1C60295
	for <util-linux@archiver.kernel.org>; Wed,  1 Sep 2021 17:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344251AbhIARMT (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 1 Sep 2021 13:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344215AbhIARMT (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 1 Sep 2021 13:12:19 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF41C061575
        for <util-linux@vger.kernel.org>; Wed,  1 Sep 2021 10:11:22 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id s15so383212vst.13
        for <util-linux@vger.kernel.org>; Wed, 01 Sep 2021 10:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=zuGq5x4liHJb5KjL8hm5EjiF+RISQa4ZQ21Npmkc1Q0=;
        b=Q54U+fIZ7icYDyzDs8/owq9zPM1/3YNG3wGSI8s0C8Uty6MeMeWp9eACeWlq9C3l16
         7dQufk8uTRVLIXPaPsZKR3ORF76AdzqsApTlKBDEyPzqQcC/QK0Zbb4BsvreltzsEgJA
         M17B0XyTP/qI0E1FcyxpANiThnkKgEq2xGzq3dKBv8dVY1MpHekFoxm6/Mg253fhSfHA
         n/rbnC42cyjEvKsy0etDVCi/0/+y1vFyBk54njSiHQvSYWff2RUjxunc9b0jy+wKvJrx
         86VMlK2ez9tiOEWqpgWhwJjYnpnwMuWByCdRHDt9imcIwOUGVJoF8MOn8ou6Mii8CKme
         azLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=zuGq5x4liHJb5KjL8hm5EjiF+RISQa4ZQ21Npmkc1Q0=;
        b=U5vuYDzeiASDxKwMWP114bJUO+JwkChPgHqtpiO5RXI0oufGVngE0hNpDgB5lO1Z65
         H+p4Sic9S9gQx1XatoiRvuoMfwEbVj0p40ntPjuDAYP4YMyQcsgs2b/JhNvlKi+Gd8bn
         HowJ93e4BDXorsQIC8ZK0iTCqMYDjbMG9v4JveMYtjwhq+JsANQz8ok2CUlJeaNiLvJx
         /OzBqi77SGFvllXWarNceee90xkpp6pguagTJzLJlP/ZxiAjMJHUZGJdNBYhsOuahqgr
         nYClHehZtxYyJpR6q50pIFpj+42Gi699yRO9kbvgF9/QEQJxwhJNkMLGixDdzDUC8mVZ
         wytA==
X-Gm-Message-State: AOAM5329PbL9Ns1ZzUKAAQ4fLrIc2euG86HwBBcY4u5se6w/Vg1ghoh+
        11mMLiXzyC6VZBNcg6qxCLQrsXFbDO5QGJuKMiP/UXNz
X-Google-Smtp-Source: ABdhPJywoNmVSV+wnIkyihF5VPfs7uDo/hhcaPtIEPdV9AEn8CUQou0ZEhosk8BXUXx6lNFv4qeGli0WwXt+JyNZkoo=
X-Received: by 2002:a67:1c05:: with SMTP id c5mr316169vsc.25.1630516281437;
 Wed, 01 Sep 2021 10:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAFPa+S=yR41168UsfjoJ1NshK_EfAbrdpgmJiEy-Yzd6rEW14A@mail.gmail.com>
In-Reply-To: <CAFPa+S=yR41168UsfjoJ1NshK_EfAbrdpgmJiEy-Yzd6rEW14A@mail.gmail.com>
From:   =?UTF-8?Q?Mario_Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Date:   Wed, 1 Sep 2021 19:11:10 +0200
Message-ID: <CAHi0vA-2YpvY053tnh=-=VQeWPJd2FSM5Tk1Y3wtGz=9aNz1WQ@mail.gmail.com>
Subject: Re: Update translations in Translation Project
To:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello Rafael,

Am Mi., 1. Sept. 2021 um 18:34 Uhr schrieb Rafael Fontenelle
<rafaelff@gnome.org>:
>
> Hi there,
>
> Translation Project has util-linux-man domain POT in version 2.37-rc2,
> and it seems that a few strings are different from released 2.37.
> Please consider updating the POT version on the Translation Project to
> avoid losing translation effort.
>
The slightly outdated template at GNU TP will be updated with version
2.38 of util-linux (@Karel, any plans for the next release...?). As
far as I can see, there were not many changes in contents last time
(besides mount.8.adoc); most changes were needed in formatting. I
recommend to keep your current file as is and wait for the next one
from the TP robot.

Regarding the import of the current translations from manpages-l10n:
I'm almost finished with French and Spanish. The Dutch and Polish
files I already sent to the respective mailing lists, but haven't got
an answer yet. Regardless of the presence of the mentioned languages
at the util-linux-man TP domain, I would say we should activate the
man page translations with the next release.

Best Regards,
Mario
