Return-Path: <SRS0=eEJa=55=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C90DC2BA2B
	for <util-linux@archiver.kernel.org>; Mon, 13 Apr 2020 20:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A732206DA
	for <util-linux@archiver.kernel.org>; Mon, 13 Apr 2020 20:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388483AbgDMUlv convert rfc822-to-8bit (ORCPT
        <rfc822;util-linux@archiver.kernel.org>);
        Mon, 13 Apr 2020 16:41:51 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:53347 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388457AbgDMUlu (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 13 Apr 2020 16:41:50 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 9A4C15605E5
        for <util-linux@vger.kernel.org>; Mon, 13 Apr 2020 22:41:46 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id y12so3524069pll.2
        for <util-linux@vger.kernel.org>; Mon, 13 Apr 2020 13:41:46 -0700 (PDT)
X-Gm-Message-State: AGi0PuZYDJ2a0ELyFJ9VNsk+tj0DHMmUHnq9QSgqiVjlIMJV0C/wcmXW
        AG5gRfLKh7rIGtezBqHK+BQYjbRSBjQ3CvfxJyA=
X-Google-Smtp-Source: APiQypLiuzgyX2ty3UKjDc2ICXiGVie2JIEjKw3vg70IMYaVIBYfB1w7IjBJaL8fIIa0EabwdKpHZ6fPDn05bIET47o=
X-Received: by 2002:a17:902:ba89:: with SMTP id k9mr18787182pls.199.1586810505000;
 Mon, 13 Apr 2020 13:41:45 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Aur=C3=A9lien_Lajoie?= <orel@melix.net>
Date:   Mon, 13 Apr 2020 22:41:34 +0200
X-Gmail-Original-Message-ID: <CAA0A08U=eWWB5eyxg4vrD_yBdVohqVT0NQfm+DG+wjbZ8HmiZg@mail.gmail.com>
Message-ID: <CAA0A08U=eWWB5eyxg4vrD_yBdVohqVT0NQfm+DG+wjbZ8HmiZg@mail.gmail.com>
Subject: cal: column mode
To:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Apr 13 22:41:47 2020 +0200 (CEST))
X-Org-Mail: aurelien.lajoie.2000@polytechnique.org
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi,

As I have announced few days ago, I have started to work on ncal like for cal.
I have push a first working version on my github:
https://github.com/utix/util-linux/commits/cal_column

I will now add some tests, and improve my code.
Does anyone know which locale can have some width issue ?

I have tried to keep the same structure of the code between the column
mode and the row mode.
It is impossible to keep line width lower than 80.
I can try to split the big function `cal_output_months` this will make
it more readable, but will introduce a lot of change for no feature.
Any advice on this ?


Thanks
Ôrel

