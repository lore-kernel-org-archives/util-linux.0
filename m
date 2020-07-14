Return-Path: <SRS0=vFYQ=AZ=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A76C433E4
	for <util-linux@archiver.kernel.org>; Tue, 14 Jul 2020 12:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C34C02242C
	for <util-linux@archiver.kernel.org>; Tue, 14 Jul 2020 12:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lprMbQny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgGNMkh (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbgGNMkh (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 14 Jul 2020 08:40:37 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469CFC061755
        for <util-linux@vger.kernel.org>; Tue, 14 Jul 2020 05:40:37 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id c25so12907607otf.7
        for <util-linux@vger.kernel.org>; Tue, 14 Jul 2020 05:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=DHAZwTDxvlgx7880U9Tys95GapV9ueTvkdyWFJA+Wkg=;
        b=lprMbQny8QtdqCc1/r9wjOAiZb+k5HpHaLYX03ZxoosRc3Cpv9z6XKeuPAWleJgEoz
         tUafuO00QsZa/a2ZwQy6Q5tt9nylUQgX2TMF2HNaImq1dJUQCHWWFs0HsRYs7nWnxbyc
         TMWb+JUah5XExp8VrtXo02JBf7A+4yCjbGl/9IT7oa/UNT5xRe2opH6ZNkVguy7mCaIq
         QroGnQxRHduHmMXun8RrMGnzBrGyTAlLA17+SAYUm7zFe2yYexq/6Ut78/V4Bc7PViNu
         Lw5wCO89f3q0CwXzLzpk140R8SZ+z5nGZPXEhg05ofclhaeaA6alnAemnYwMuCkVDm2F
         9jYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=DHAZwTDxvlgx7880U9Tys95GapV9ueTvkdyWFJA+Wkg=;
        b=izVstCkknt508CwNGb2VSmhn7zERDfU8Kp88REpcQ+ymRQBANw4w8Fy0SzyElfhYE9
         2nlxz2zkWMnwh0/ZsS6zmMwtPXgFun+jMbSQk2QjZtzNv9OMoFRwI5jPwXrEUbiUycDY
         f+Oznp47oWA6Mp9aHWbnLASPrI+EQNbQ3/sexQHkI2gkur0u0z0qaGNpSv5zVBxDBDO4
         FX3IMLQxQklIReab5y9hhADio7mabaoqVJqRBSyvAVN3AZ8pVxn3q99tlZQHIsvlUb8L
         EVmX0HM+vVE9L9f4vN7UmAuckwYtFkKbh5xInKgwLEhLNGTh65WuOrR75fBGCc8tIaq1
         pFqg==
X-Gm-Message-State: AOAM530tA3CMsOvqO+r6MwfBLjVix4sEDDnZRX9S5ewfejz/cO0yZscZ
        UcbExZx1q0KfGYZxQiFFVejM1Agv7sc17OCpP0I=
X-Google-Smtp-Source: ABdhPJwwvRSeX3xpAgEejp028/nW/+dgs5gYidZyDGcTqhuZV2JC6DkwtzoABQxZezlBZ2CONwJ/GOwtJZu3h+lRg8w=
X-Received: by 2002:a9d:66d7:: with SMTP id t23mr4017796otm.323.1594730436714;
 Tue, 14 Jul 2020 05:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200714095741.45292-1-mtk.manpages@gmail.com>
 <20200714095741.45292-5-mtk.manpages@gmail.com> <CAKgNAkhWAe-VDRQwkXC=crfZ117EfRd0Vw3keU2WYdrXkOSsTw@mail.gmail.com>
 <20200714123830.2tn46t3iv5yyd4r7@ws.net.home>
In-Reply-To: <20200714123830.2tn46t3iv5yyd4r7@ws.net.home>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Tue, 14 Jul 2020 14:40:25 +0200
Message-ID: <CAKgNAkgSJJxRd7K-DfK0PCNV2Aed2_T8J2TFMP+Bkgzh5ciEFQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] Manual pages: various: reword "allow(s) to"
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, 14 Jul 2020 at 14:38, Karel Zak <kzak@redhat.com> wrote:
>
> On Tue, Jul 14, 2020 at 02:13:01PM +0200, Michael Kerrisk (man-pages) wrote:
> > +allows commands to be run with a substitute user and group ID.
> >
> > Shall I resend the patch, or will you edit?
>
> Fixed.

Okay -- we crossed mails on that one. Ignore my patchlet ;-).
-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
