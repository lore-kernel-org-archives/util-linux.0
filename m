Return-Path: <SRS0=eIzx=56=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048EEC352BE
	for <util-linux@archiver.kernel.org>; Tue, 14 Apr 2020 20:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E03EB206E9
	for <util-linux@archiver.kernel.org>; Tue, 14 Apr 2020 20:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632987AbgDNUSd convert rfc822-to-8bit (ORCPT
        <rfc822;util-linux@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:18:33 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:50541 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2632993AbgDNUS2 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 14 Apr 2020 16:18:28 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 57AAB5612C0
        for <util-linux@vger.kernel.org>; Tue, 14 Apr 2020 22:18:24 +0200 (CEST)
Received: by mail-pf1-f180.google.com with SMTP id x3so449713pfp.7
        for <util-linux@vger.kernel.org>; Tue, 14 Apr 2020 13:18:24 -0700 (PDT)
X-Gm-Message-State: AGi0Pubrr01eE9SjB81Z6DsPMZZjZH60YM7uizwIhSSKf/u9iLp/SOA9
        VS1GuYo2tyrztyjYpfdf08ffZllvMDPFbepVE48=
X-Google-Smtp-Source: APiQypLzQCBhH/xj4oP9GRxvykCpyjhaazXfBWoCtuF7sKL6/ho4/pryeucIPtxnLa+6Qg1FjNOTTOhYK6snJbONyVo=
X-Received: by 2002:a62:87c7:: with SMTP id i190mr10305605pfe.326.1586895502490;
 Tue, 14 Apr 2020 13:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAA0A08U=eWWB5eyxg4vrD_yBdVohqVT0NQfm+DG+wjbZ8HmiZg@mail.gmail.com>
 <20200414113827.xp2etrdev2oom4qc@ws.net.home>
In-Reply-To: <20200414113827.xp2etrdev2oom4qc@ws.net.home>
From:   =?UTF-8?Q?Aur=C3=A9lien_Lajoie?= <orel@melix.net>
Date:   Tue, 14 Apr 2020 22:18:11 +0200
X-Gmail-Original-Message-ID: <CAA0A08W8JjTYx-ymnsBvbRHBW+WxucobBWVfyt4XdXh7Of8wMA@mail.gmail.com>
Message-ID: <CAA0A08W8JjTYx-ymnsBvbRHBW+WxucobBWVfyt4XdXh7Of8wMA@mail.gmail.com>
Subject: Re: cal: column mode
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Apr 14 22:18:24 2020 +0200 (CEST))
X-Org-Mail: aurelien.lajoie.2000@polytechnique.org
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Apr 14, 2020 at 1:38 PM Karel Zak <kzak@redhat.com> wrote:
>
> On Mon, Apr 13, 2020 at 10:41:34PM +0200, Aurélien Lajoie wrote:
> > As I have announced few days ago, I have started to work on ncal like for cal.
> > I have push a first working version on my github:
> > https://github.com/utix/util-linux/commits/cal_column
>
> Is the option --column the best name? We use "column" pretty often to
> address output in columns or number of columns, etc.
>
> What about --vertical?

sure, no preference for me, ( -v is not used )
How or who decides this kind of stuff (sorry I am a newbie)

> > Does anyone know which locale can have some width issue ?
>
>  LC_ALL=ja_JP.utf8 cal
>
> or another with multibyte letters.
ja_JP seems very compact, I think mongolian locale is a good one with month like
Арванхоёрдугаар сар

ja_JP is:
                               2020

         1月                    2月                    3月
日 月 火 水 木 金 土   日 月 火 水 木 金 土   日 月 火 水 木 金 土
          1  2  3  4                      1    1  2  3  4  5  6  7
 5  6  7  8  9 10 11    2  3  4  5  6  7  8    8  9 10 11 12 13 14
12 13 14 15 16 17 18    9 10 11 12 13 14 15   15 16 17 18 19 20 21
19 20 21 22 23 24 25   16 17 18 19 20 21 22   22 23 24 25 26 27 28
26 27 28 29 30 31      23 24 25 26 27 28 29   29 30 31

         4月                    5月                    6月
日 月 火 水 木 金 土   日 月 火 水 木 金 土   日 月 火 水 木 金 土
          1  2  3  4                   1  2       1  2  3  4  5  6
 5  6  7  8  9 10 11    3  4  5  6  7  8  9    7  8  9 10 11 12 13
12 13 14 15 16 17 18   10 11 12 13 14 15 16   14 15 16 17 18 19 20
19 20 21 22 23 24 25   17 18 19 20 21 22 23   21 22 23 24 25 26 27
26 27 28 29 30         24 25 26 27 28 29 30   28 29 30
                       31
         7月                    8月                    9月
日 月 火 水 木 金 土   日 月 火 水 木 金 土   日 月 火 水 木 金 土
          1  2  3  4                      1          1  2  3  4  5
 5  6  7  8  9 10 11    2  3  4  5  6  7  8    6  7  8  9 10 11 12
12 13 14 15 16 17 18    9 10 11 12 13 14 15   13 14 15 16 17 18 19
19 20 21 22 23 24 25   16 17 18 19 20 21 22   20 21 22 23 24 25 26
26 27 28 29 30 31      23 24 25 26 27 28 29   27 28 29 30
                       30 31
        10月                   11月                   12月
日 月 火 水 木 金 土   日 月 火 水 木 金 土   日 月 火 水 木 金 土
             1  2  3    1  2  3  4  5  6  7          1  2  3  4  5
 4  5  6  7  8  9 10    8  9 10 11 12 13 14    6  7  8  9 10 11 12
11 12 13 14 15 16 17   15 16 17 18 19 20 21   13 14 15 16 17 18 19
18 19 20 21 22 23 24   22 23 24 25 26 27 28   20 21 22 23 24 25 26
25 26 27 28 29 30 31   29 30                  27 28 29 30 31

>
> > I have tried to keep the same structure of the code between the column
> > mode and the row mode.
> > It is impossible to keep line width lower than 80.
>
> Do you mean source code line? ... 80 is not a strict rule, keep it
> readable.
Yeap speaking about code line, with tab width set to 8, 80 is quickly reached.

>
> > I can try to split the big function `cal_output_months` this will make
> > it more readable, but will introduce a lot of change for no feature.
> > Any advice on this ?
>
> Your cal_col_output_months() does not look like any huge monster.
>
> I have added one comment to your commits/cal_column at github.
Thanks I will do the modification
>
>     Karel
>
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
>

