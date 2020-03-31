Return-Path: <SRS0=mypX=5Q=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C543C43331
	for <util-linux@archiver.kernel.org>; Tue, 31 Mar 2020 16:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA405206CC
	for <util-linux@archiver.kernel.org>; Tue, 31 Mar 2020 16:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbgCaQz0 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:55:26 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:58066 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730099AbgCaQz0 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 31 Mar 2020 12:55:26 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 92ACF560787
        for <util-linux@vger.kernel.org>; Tue, 31 Mar 2020 18:55:22 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id w3so8331199plz.5
        for <util-linux@vger.kernel.org>; Tue, 31 Mar 2020 09:55:22 -0700 (PDT)
X-Gm-Message-State: AGi0PuZOboqFfH+oZf+HVABEDfoi8mDSj2ZUTAJf61T5CoIkwdxTp/Kt
        WcVNmXJNm0GdiJnKwkWel4PTpQUzB9NM0XWAcD0=
X-Google-Smtp-Source: APiQypKtsNPhwzsKj+a16hokWs0jRVbaYcUSvgT+pQXOOcfQvAnwbZDU+rRX/d7aHdd+6+37XQaiHK4xLuzk64XeMSI=
X-Received: by 2002:a17:90a:1b22:: with SMTP id q31mr5227630pjq.109.1585673720806;
 Tue, 31 Mar 2020 09:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200328223341.11463-1-orel@melix.net> <20200328223341.11463-2-orel@melix.net>
 <nycvar.YAK.7.77.849.2003291015150.1315@zhn.tzk.pbz> <20200331134154.ok6zuym6w5p5sa2o@ws.net.home>
 <nycvar.YAK.7.77.849.2003311031020.1544@zhn.tzk.pbz>
In-Reply-To: <nycvar.YAK.7.77.849.2003311031020.1544@zhn.tzk.pbz>
From:   =?UTF-8?Q?Aur=C3=A9lien_Lajoie?= <orel@melix.net>
Date:   Tue, 31 Mar 2020 18:55:09 +0200
X-Gmail-Original-Message-ID: <CAA0A08WGSa1CxbtHt_qZHPStKcgoW37+KaYrZ9mqUUqKv4Bk7A@mail.gmail.com>
Message-ID: <CAA0A08WGSa1CxbtHt_qZHPStKcgoW37+KaYrZ9mqUUqKv4Bk7A@mail.gmail.com>
Subject: Re: [PATCH 2/3] cal: Correctly center the year
To:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Mar 31 18:55:23 2020 +0200 (CEST))
X-Org-Mail: aurelien.lajoie.2000@polytechnique.org
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Mar 31, 2020 at 5:07 PM J William Piggott <elseifthen@gmx.com> wrote:
>
> It seems like this trend stems from Apple. Jobs was fanatical about
> form; but what seems have been lost, is that he was equally fanatical
> about function. He required that both be satisfied. I cannot find any
> function in cal's year header. Can anyone offer any?

I was not thinking triggering such discussion about cal.

I don't know if my argument is a good one, reading the code I have found that
 for some locale the room available is not enough to put the month and
the year on a single line.

If someone can give me example of one or two locales with this issue
to do some test, I will appreciate it.

So I think for such locale it is better to have the year only at the top.

And this behavior is closed to the physical calendar and classic year
calendar as you can see on google image "year calendar" search.

So I think we can keep it as it and add an option to change the
behavior (--noyear-header as Karel has proposed)

What do you think about adding options -A and -B as in ncal ?
[-A months] [-B months]

