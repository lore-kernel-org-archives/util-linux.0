Return-Path: <SRS0=n+tz=V2=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA5FC7618F
	for <util-linux@archiver.kernel.org>; Mon, 29 Jul 2019 01:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E532070B
	for <util-linux@archiver.kernel.org>; Mon, 29 Jul 2019 01:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6sxCIoA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfG2BeP (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 28 Jul 2019 21:34:15 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42159 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfG2BeO (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 28 Jul 2019 21:34:14 -0400
Received: by mail-lj1-f193.google.com with SMTP id t28so56894877lje.9
        for <util-linux@vger.kernel.org>; Sun, 28 Jul 2019 18:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ojABzy2Ss6C9eJ3HiYwBgDA0ivgE/F70ASIFP8A/Co=;
        b=N6sxCIoAovRFo7+omcK+FkhKn3csDLkd/05sstnCjtKF35VRXCvM93oYiN2FOX4aiI
         /LGjbU2POAZLEN8bYZNnmG83gMY9at/SUQZz49eBvf4IGEzocZzsZwt2bgyn8wwYDU2X
         NhnXuTKoldIwc7D9nFtOVeNFIuPzA8hFquW9ilo5/u9W2gyxjI5SygrzC/I4I05bCA47
         35mLQkGwOcH7iVR9oo8RCh8MLPzzDfTx+ZnJYTA1UPFEhBF298vlAZX3Mngs05DUOi/L
         Ji7+YxsKRXleOmpnGVGtB7TQHzhPRVd1mERvyvcR4cZEoJ9GalKH0fvBfhJTwB35f1I8
         l+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ojABzy2Ss6C9eJ3HiYwBgDA0ivgE/F70ASIFP8A/Co=;
        b=MOejZ5TasR/86d2XO4UqSftmxPojOm0N6qC8jvN5aX+1rU9BK+ow36ZC9pr5UB0teM
         YJ8eQsnb6685wx3XcaupL8HuX4EXavLmMpx1fOzmOD+JKgGHdqYKWKCeNPJm7zi863C2
         4r6GtACIPVXCnWhF7WGXiD9fGsOdSI8qJxmoyfY/McvCj76N5Siz5EZlRp9niuEffKLQ
         cVCYiWieaJbJGLVKnbui9MpI6qLxCXzi02x8qF/joeZzZr3xqpNs1uoJ11fVR1yfKVbx
         rN4sM+/pgrg5UNwfm8Kl7GLseDBOXzuEpYfOvYAuqP+IcBcwIvGrZ1JpRw6JROK+dN8O
         NpSQ==
X-Gm-Message-State: APjAAAXrrpI/MT8McY7uldiU4ddD+rwBxJXpjEAp46ErF2XAhAxXH37T
        aFIsGyMT316h/8cegxgGEDyd92B4Vj6kWIqgOOE=
X-Google-Smtp-Source: APXvYqyFFJUUeV88PHuRwS43kOWGEwLFxQUxk+4MCczfl6AI/d1jioIRIMUbA4ySxZj0loiUeY2IEMv8a/G87F0vXI0=
X-Received: by 2002:a2e:8396:: with SMTP id x22mr57769440ljg.135.1564364051957;
 Sun, 28 Jul 2019 18:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190627092235.36888-1-zhouyousong@yunionyun.com> <CAG27Bk2Z8pqe+RdydZUzKH_yJ=+epy+OnjC+3CpyBS5Bf-BhuA@mail.gmail.com>
In-Reply-To: <CAG27Bk2Z8pqe+RdydZUzKH_yJ=+epy+OnjC+3CpyBS5Bf-BhuA@mail.gmail.com>
From:   Yousong Zhou <yszhou4tech@gmail.com>
Date:   Mon, 29 Jul 2019 09:34:00 +0800
Message-ID: <CAECwjAhriLec4s+D0OLgsg51CJfqdTM6=qdaFpkgYhqY+-O90Q@mail.gmail.com>
Subject: Re: [PATCH] column: fix outputing empty column at the end of line
To:     kerolasa@gmail.com
Cc:     Karel Zak <kzak@redhat.com>,
        util-linux <util-linux@vger.kernel.org>,
        Yousong Zhou <zhouyousong@yunionyun.com>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi Sami,

On Sun, 28 Jul 2019 at 02:49, Sami Kerola <kerolasa@iki.fi> wrote:
>
> On Thu, 27 Jun 2019 at 10:24, Yousong Zhou <yszhou4tech@gmail.com> wrote:
> >
> > The following commands manifests the problem.  In old versions before
> > commit 4762ae9d60 ("column: use libsmartcols for --table"), both of them
> > should output with 2 "|"
> >
> >         echo '||'  | column -o '|' -s '|' -t
> >         echo '|| ' | column -o '|' -s '|' -t
> >
> > Fixes: 4762ae9d60 ("column: use libsmartcols for --table")
> > Signed-off-by: Yousong Zhou <zhouyousong@yunionyun.com>
> > ---
> >  tests/expected/column/table-empty-column-at-eol  |  1 +
> >  tests/expected/column/table-empty-column-at-eol2 |  1 +
> >  tests/ts/column/table                            |  8 ++++++++
> >  text-utils/column.c                              | 15 ++++++++++-----
> >  4 files changed, 20 insertions(+), 5 deletions(-)
> >  create mode 100644 tests/expected/column/table-empty-column-at-eol
> >  create mode 100644 tests/expected/column/table-empty-column-at-eol2
> >
> > diff --git a/tests/expected/column/table-empty-column-at-eol b/tests/expected/column/table-empty-column-at-eol
> > new file mode 100644
> > index 000000000..948cf947f
> > --- /dev/null
> > +++ b/tests/expected/column/table-empty-column-at-eol
> > @@ -0,0 +1 @@
> > +|
> > diff --git a/tests/expected/column/table-empty-column-at-eol2 b/tests/expected/column/table-empty-column-at-eol2
> > new file mode 100644
> > index 000000000..7c4378506
> > --- /dev/null
> > +++ b/tests/expected/column/table-empty-column-at-eol2
> > @@ -0,0 +1 @@
> > +||
> > diff --git a/tests/ts/column/table b/tests/ts/column/table
> > index bd1f16f3f..e64dee746 100755
> > --- a/tests/ts/column/table
> > +++ b/tests/ts/column/table
> > @@ -116,4 +116,12 @@ ts_init_subtest "empty-column"
> >  printf ':a:b\n' | $TS_CMD_COLUMN --table --separator ':' --output-separator  ':' >> $TS_OUTPUT 2>&1
> >  ts_finalize_subtest
> >
> > +ts_init_subtest "empty-column-at-eol"
> > +printf '|' | $TS_CMD_COLUMN --separator '|' --output-separator '|' --table >> $TS_OUTPUT 2>&1
> > +ts_finalize_subtest
> > +
> > +ts_init_subtest "empty-column-at-eol2"
> > +printf '||' | $TS_CMD_COLUMN --separator '|' --output-separator '|' --table >> $TS_OUTPUT 2>&1
> > +ts_finalize_subtest
> > +
> >  ts_finalize
> > diff --git a/text-utils/column.c b/text-utils/column.c
> > index 13b39537e..64f1cf7e9 100644
> > --- a/text-utils/column.c
> > +++ b/text-utils/column.c
> > @@ -169,8 +169,9 @@ static wchar_t *local_wcstok(wchar_t *p, const wchar_t *separator, int greedy, w
> >                 return strtok_r(p, separator, state);
> >  #endif
> >         if (!p) {
> > -               if (!*state || !**state)
> > +               if (!*state) {
> >                         return NULL;
> > +               }
>
> This would be better without unnecessary curly braces.
>
> >                 p = *state;
> >         }
> >         result = p;
> > @@ -435,7 +436,7 @@ static int add_line_to_table(struct column_control *ctl, wchar_t *wcs)
> >         if (!ctl->tab)
> >                 init_table(ctl);
> >
> > -       while ((wcdata = local_wcstok(wcs, ctl->input_separator, ctl->greedy, &sv))) {
> > +       while ((wcdata = local_wcstok(wcs, ctl->input_separator, ctl->greedy, &sv)) || sv) {
>
> I don't think '|| sv' is needed.

Thanks, you are right.

Now I recall it it must be a leftover before I removed the "&&
!**data" check in local_wcstok()

>
> >                 char *data;
> >
> >                 if (scols_table_get_ncols(ctl->tab) < n + 1) {
> > @@ -452,9 +453,13 @@ static int add_line_to_table(struct column_control *ctl, wchar_t *wcs)
> >                                 err(EXIT_FAILURE, _("failed to allocate output line"));
> >                 }
> >
> > -               data = wcs_to_mbs(wcdata);
> > -               if (!data)
> > -                       err(EXIT_FAILURE, _("failed to allocate output data"));
> > +               if (wcdata) {
> > +                       data = wcs_to_mbs(wcdata);
> > +                       if (!data)
> > +                               err(EXIT_FAILURE, _("failed to allocate output data"));
> > +               } else {
> > +                       data = NULL;
> > +               }
>
> Another pair of unnecessary braces.
>
> >                 if (scols_line_refer_data(ln, n, data))
> >                         err(EXIT_FAILURE, _("failed to add output data"));
> >                 n++;
>
> If resubmitted feel free to add the following. Even if not resubmitted
> with fixes; looks pretty good.
>
> Reviewed-by: Sami Kerola <kerolasa@iki.fi>

Just sent a v2 patch.  It's simplified to only 1 line change.  Thank
you for the review ;)

Regards,
                yousong

>
> --
> Sami Kerola
> http://www.iki.fi/kerolasa/
