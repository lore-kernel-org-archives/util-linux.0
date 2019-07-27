Return-Path: <SRS0=eKpO=VY=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF85C76186
	for <util-linux@archiver.kernel.org>; Sat, 27 Jul 2019 18:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61B0206E0
	for <util-linux@archiver.kernel.org>; Sat, 27 Jul 2019 18:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387893AbfG0Stv (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 27 Jul 2019 14:49:51 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:32943 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387794AbfG0Stv (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 27 Jul 2019 14:49:51 -0400
Received: by mail-io1-f68.google.com with SMTP id z3so1906098iog.0
        for <util-linux@vger.kernel.org>; Sat, 27 Jul 2019 11:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=EfsqFJ4afaYzZz5KVXva5PO8zSW0hvXeR0iYP84k4ug=;
        b=UUi0Z6jR6Gj0pyUAynUlKV6LuoO3/LZq2hG6f5SvM6MIywsjva5Eou+vZK5s+DwzWD
         tmAenJKFMvIve/Rw5qRV+LwLSTHJVnuw/ilBt2W36pwxC67pJDPgLbzv0qpDTMMgkpBh
         kw/Y0e9WeQHGfk8EENeWKuR/OVVbG56bW99sPy4L88UDT858qNhXxjsoImtaPd37iy9t
         Thuh6w2M7yaM4PpfXrBMvxqZxWnsFyF25EBeOiKjzf1AtPDZTaYq7K+XSFYVTkklxP2n
         oxxY1MHmlxchHwG6Y2H5ZEEYeR0A5SuTQsOiXal20fU0Mp61zerbMfz2G+CD3Qdwfo03
         Uyww==
X-Gm-Message-State: APjAAAXRQxzF43sh7FvpnGFFbaM1Uzl7YXlp1vn2h5nYIujCk0SjBtHm
        u1RLIJy2DQwdRSf/fkx8gpnSUVi60IHyBT4k3Bg=
X-Google-Smtp-Source: APXvYqyNdjH9R7hZ+oxCPCQ8QQtO/MIqB9BI/Pfl3pb/itomCPcOhQyrRXeszCBe/OiK6Qiuy3M13i5ZTw2lB/H91pk=
X-Received: by 2002:a02:3f0a:: with SMTP id d10mr30127712jaa.23.1564253390290;
 Sat, 27 Jul 2019 11:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190627092235.36888-1-zhouyousong@yunionyun.com>
In-Reply-To: <20190627092235.36888-1-zhouyousong@yunionyun.com>
Reply-To: kerolasa@gmail.com
From:   Sami Kerola <kerolasa@iki.fi>
Date:   Sat, 27 Jul 2019 19:49:39 +0100
Message-ID: <CAG27Bk2Z8pqe+RdydZUzKH_yJ=+epy+OnjC+3CpyBS5Bf-BhuA@mail.gmail.com>
Subject: Re: [PATCH] column: fix outputing empty column at the end of line
To:     Yousong Zhou <yszhou4tech@gmail.com>
Cc:     Karel Zak <kzak@redhat.com>,
        util-linux <util-linux@vger.kernel.org>,
        Yousong Zhou <zhouyousong@yunionyun.com>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, 27 Jun 2019 at 10:24, Yousong Zhou <yszhou4tech@gmail.com> wrote:
>
> The following commands manifests the problem.  In old versions before
> commit 4762ae9d60 ("column: use libsmartcols for --table"), both of them
> should output with 2 "|"
>
>         echo '||'  | column -o '|' -s '|' -t
>         echo '|| ' | column -o '|' -s '|' -t
>
> Fixes: 4762ae9d60 ("column: use libsmartcols for --table")
> Signed-off-by: Yousong Zhou <zhouyousong@yunionyun.com>
> ---
>  tests/expected/column/table-empty-column-at-eol  |  1 +
>  tests/expected/column/table-empty-column-at-eol2 |  1 +
>  tests/ts/column/table                            |  8 ++++++++
>  text-utils/column.c                              | 15 ++++++++++-----
>  4 files changed, 20 insertions(+), 5 deletions(-)
>  create mode 100644 tests/expected/column/table-empty-column-at-eol
>  create mode 100644 tests/expected/column/table-empty-column-at-eol2
>
> diff --git a/tests/expected/column/table-empty-column-at-eol b/tests/expected/column/table-empty-column-at-eol
> new file mode 100644
> index 000000000..948cf947f
> --- /dev/null
> +++ b/tests/expected/column/table-empty-column-at-eol
> @@ -0,0 +1 @@
> +|
> diff --git a/tests/expected/column/table-empty-column-at-eol2 b/tests/expected/column/table-empty-column-at-eol2
> new file mode 100644
> index 000000000..7c4378506
> --- /dev/null
> +++ b/tests/expected/column/table-empty-column-at-eol2
> @@ -0,0 +1 @@
> +||
> diff --git a/tests/ts/column/table b/tests/ts/column/table
> index bd1f16f3f..e64dee746 100755
> --- a/tests/ts/column/table
> +++ b/tests/ts/column/table
> @@ -116,4 +116,12 @@ ts_init_subtest "empty-column"
>  printf ':a:b\n' | $TS_CMD_COLUMN --table --separator ':' --output-separator  ':' >> $TS_OUTPUT 2>&1
>  ts_finalize_subtest
>
> +ts_init_subtest "empty-column-at-eol"
> +printf '|' | $TS_CMD_COLUMN --separator '|' --output-separator '|' --table >> $TS_OUTPUT 2>&1
> +ts_finalize_subtest
> +
> +ts_init_subtest "empty-column-at-eol2"
> +printf '||' | $TS_CMD_COLUMN --separator '|' --output-separator '|' --table >> $TS_OUTPUT 2>&1
> +ts_finalize_subtest
> +
>  ts_finalize
> diff --git a/text-utils/column.c b/text-utils/column.c
> index 13b39537e..64f1cf7e9 100644
> --- a/text-utils/column.c
> +++ b/text-utils/column.c
> @@ -169,8 +169,9 @@ static wchar_t *local_wcstok(wchar_t *p, const wchar_t *separator, int greedy, w
>                 return strtok_r(p, separator, state);
>  #endif
>         if (!p) {
> -               if (!*state || !**state)
> +               if (!*state) {
>                         return NULL;
> +               }

This would be better without unnecessary curly braces.

>                 p = *state;
>         }
>         result = p;
> @@ -435,7 +436,7 @@ static int add_line_to_table(struct column_control *ctl, wchar_t *wcs)
>         if (!ctl->tab)
>                 init_table(ctl);
>
> -       while ((wcdata = local_wcstok(wcs, ctl->input_separator, ctl->greedy, &sv))) {
> +       while ((wcdata = local_wcstok(wcs, ctl->input_separator, ctl->greedy, &sv)) || sv) {

I don't think '|| sv' is needed.

>                 char *data;
>
>                 if (scols_table_get_ncols(ctl->tab) < n + 1) {
> @@ -452,9 +453,13 @@ static int add_line_to_table(struct column_control *ctl, wchar_t *wcs)
>                                 err(EXIT_FAILURE, _("failed to allocate output line"));
>                 }
>
> -               data = wcs_to_mbs(wcdata);
> -               if (!data)
> -                       err(EXIT_FAILURE, _("failed to allocate output data"));
> +               if (wcdata) {
> +                       data = wcs_to_mbs(wcdata);
> +                       if (!data)
> +                               err(EXIT_FAILURE, _("failed to allocate output data"));
> +               } else {
> +                       data = NULL;
> +               }

Another pair of unnecessary braces.

>                 if (scols_line_refer_data(ln, n, data))
>                         err(EXIT_FAILURE, _("failed to add output data"));
>                 n++;

If resubmitted feel free to add the following. Even if not resubmitted
with fixes; looks pretty good.

Reviewed-by: Sami Kerola <kerolasa@iki.fi>

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
