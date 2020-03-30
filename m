Return-Path: <SRS0=/M4+=5P=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F879C43331
	for <util-linux@archiver.kernel.org>; Mon, 30 Mar 2020 11:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498F920675
	for <util-linux@archiver.kernel.org>; Mon, 30 Mar 2020 11:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgC3LOd convert rfc822-to-8bit (ORCPT
        <rfc822;util-linux@archiver.kernel.org>);
        Mon, 30 Mar 2020 07:14:33 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:33510 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729263AbgC3LOd (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 30 Mar 2020 07:14:33 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id F2E1C561220
        for <util-linux@vger.kernel.org>; Mon, 30 Mar 2020 13:14:29 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id v13so7419006pjb.0
        for <util-linux@vger.kernel.org>; Mon, 30 Mar 2020 04:14:29 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2DIAkU0Jo0NIyXgXxdw6LR/9+0krcTGb6zL09G3F1Cr4bOsqgb
        eHtwEHrwLZ3bZGXYnKA+etSOiSvIj+sQvTkXP+Q=
X-Google-Smtp-Source: ADFU+vtFLoy52fL+jkGFXWKhoH/lBx/+VmABoqiJhuXoLbNFi+cslIclI0Wew3pL70HE3nHZBs+jyHYrPzWoopmXLQM=
X-Received: by 2002:a17:902:bc4a:: with SMTP id t10mr12088724plz.199.1585566867933;
 Mon, 30 Mar 2020 04:14:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200328223341.11463-1-orel@melix.net> <20200328223341.11463-2-orel@melix.net>
 <nycvar.YAK.7.77.849.2003291015150.1315@zhn.tzk.pbz>
In-Reply-To: <nycvar.YAK.7.77.849.2003291015150.1315@zhn.tzk.pbz>
From:   =?UTF-8?Q?Aur=C3=A9lien_Lajoie?= <orel@melix.net>
Date:   Mon, 30 Mar 2020 13:14:16 +0200
X-Gmail-Original-Message-ID: <CAA0A08Vm=f-tU1z4puHxVKvs1pdHKeAS1PyKHwjEPEE8ScPqBw@mail.gmail.com>
Message-ID: <CAA0A08Vm=f-tU1z4puHxVKvs1pdHKeAS1PyKHwjEPEE8ScPqBw@mail.gmail.com>
Subject: Re: [PATCH 2/3] cal: Correctly center the year
To:     J William Piggott <elseifthen@gmx.com>
Cc:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Mar 30 13:14:30 2020 +0200 (CEST))
X-Org-Mail: aurelien.lajoie.2000@polytechnique.org
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

I agree with you, this is weird,

My goal is to rework all the computations on size and padding,  they
are not easy to understand and there is some magic formula.
I will try to remove the trailing spaces in a second time.

Perhaps we can add a flag to force year with month name to avoid to
change the previous behavior.

ncal is more often the year header.

╭(11:23)──{~}──
╰┤suze ▶ ncal -B1 -A8
    February 2020     March 2020        April 2020        May 2020
Su     2  9 16 23     1  8 15 22 29        5 12 19 26        3 10 17 24 31
Mo     3 10 17 24     2  9 16 23 30        6 13 20 27        4 11 18 25
Tu     4 11 18 25     3 10 17 24 31        7 14 21 28        5 12 19 26
We     5 12 19 26     4 11 18 25        1  8 15 22 29        6 13 20 27
Th     6 13 20 27     5 12 19 26        2  9 16 23 30        7 14 21 28
Fr     7 14 21 28     6 13 20 27        3 10 17 24        1  8 15 22 29
Sa  1  8 15 22 29     7 14 21 28        4 11 18 25        2  9 16 23 30

    June 2020         July 2020         August 2020       September 2020
Su     7 14 21 28        5 12 19 26        2  9 16 23 30     6 13 20 27
Mo  1  8 15 22 29        6 13 20 27        3 10 17 24 31     7 14 21 28
Tu  2  9 16 23 30        7 14 21 28        4 11 18 25     1  8 15 22 29
We  3 10 17 24        1  8 15 22 29        5 12 19 26     2  9 16 23 30
Th  4 11 18 25        2  9 16 23 30        6 13 20 27     3 10 17 24
Fr  5 12 19 26        3 10 17 24 31        7 14 21 28     4 11 18 25
Sa  6 13 20 27        4 11 18 25        1  8 15 22 29     5 12 19 26

    October 2020      November 2020
Su     4 11 18 25     1  8 15 22 29
Mo     5 12 19 26     2  9 16 23 30
Tu     6 13 20 27     3 10 17 24
We     7 14 21 28     4 11 18 25
Th  1  8 15 22 29     5 12 19 26
Fr  2  9 16 23 30     6 13 20 27
Sa  3 10 17 24 31     7 14 21 28

╭(11:23)──{~}──
╰┤suze ▶ ncal -B2 -A8
                                  2020
    January           February          March             April
Su     5 12 19 26        2  9 16 23     1  8 15 22 29        5 12 19 26
Mo     6 13 20 27        3 10 17 24     2  9 16 23 30        6 13 20 27
Tu     7 14 21 28        4 11 18 25     3 10 17 24 31        7 14 21 28
We  1  8 15 22 29        5 12 19 26     4 11 18 25        1  8 15 22 29
Th  2  9 16 23 30        6 13 20 27     5 12 19 26        2  9 16 23 30
Fr  3 10 17 24 31        7 14 21 28     6 13 20 27        3 10 17 24
Sa  4 11 18 25        1  8 15 22 29     7 14 21 28        4 11 18 25

    May               June              July              August
Su     3 10 17 24 31     7 14 21 28        5 12 19 26        2  9 16 23 30
Mo     4 11 18 25     1  8 15 22 29        6 13 20 27        3 10 17 24 31
Tu     5 12 19 26     2  9 16 23 30        7 14 21 28        4 11 18 25
We     6 13 20 27     3 10 17 24        1  8 15 22 29        5 12 19 26
Th     7 14 21 28     4 11 18 25        2  9 16 23 30        6 13 20 27
Fr  1  8 15 22 29     5 12 19 26        3 10 17 24 31        7 14 21 28
Sa  2  9 16 23 30     6 13 20 27        4 11 18 25        1  8 15 22 29

    September         October           November
Su     6 13 20 27        4 11 18 25     1  8 15 22 29
Mo     7 14 21 28        5 12 19 26     2  9 16 23 30
Tu  1  8 15 22 29        6 13 20 27     3 10 17 24
We  2  9 16 23 30        7 14 21 28     4 11 18 25
Th  3 10 17 24        1  8 15 22 29     5 12 19 26
Fr  4 11 18 25        2  9 16 23 30     6 13 20 27
Sa  5 12 19 26        3 10 17 24 31     7 14 21 28

On Sun, Mar 29, 2020 at 4:39 PM J William Piggott <elseifthen@gmx.com> wrote:
>
> This is not intended to be a blocker for the submitted patch; more a
> general comment.
>
> I still believe the year header is nonsense. IIRC, when I brought this
> up last time nobody replied with any justification for it.
>
> On a standard terminal it scrolls off the screen; this means the user is
> unable to tell what year they are looking at. For example, I often have
> multiple years open, and when tabbing between them there is nothing
> visible to differentiate them. So I have to use 'cal -n 12 1 2020'.
>
> Why is it for 11 months we have 'month year', for 13 months we have
> 'month year', but for 12 months we have a year header? What is special
> about 12 month output. I think this is just a throwback to old printed
> calendars with 12 months on a single page.
>
> So what is the justification? What is the use case for having -y drop
> the 'month year' format that is used for all other output?

