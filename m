Return-Path: <SRS0=VWBs=VK=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2505EC742D7
	for <util-linux@archiver.kernel.org>; Sat, 13 Jul 2019 05:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31A220989
	for <util-linux@archiver.kernel.org>; Sat, 13 Jul 2019 05:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3BQCLA9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfGMFal (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 13 Jul 2019 01:30:41 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41508 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfGMFal (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 13 Jul 2019 01:30:41 -0400
Received: by mail-lj1-f196.google.com with SMTP id d24so11263240ljg.8
        for <util-linux@vger.kernel.org>; Fri, 12 Jul 2019 22:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IWoA/1D02KANLGNOuJX/9j1s7Dkr/I3NAX2icEbz4uo=;
        b=P3BQCLA9or+NnacqbzP4/7QBw623gSKmxAYlESx/6jVYgutCryWeEII7/+SsvHeQO7
         GNlz2BaOfhW+asfhsWVkEBJLOsawhqQp69L5PVobLWHtJRi5CJ6UGm/x8isaTk313Db8
         Ccb0IwNiXf4tT+Hr5ukCIKXTCFtrSt7OK0eXcQHBfDxepjWlN6vwHtm46sd4zgbo4hzK
         Oux7NXtbPWJclI4VJsfjcwOBal9ISUvQ3t331nCeWhnz5/HwvUb+DgRuv2x45bEJ9kTV
         0mMkV67rgI1byhA07N+1LXvZBbUH0FLf8OfVxHRy/b9o8c5tcO2gxdXvoEjxw4E+l8P1
         rrtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IWoA/1D02KANLGNOuJX/9j1s7Dkr/I3NAX2icEbz4uo=;
        b=imJrKa8POsLHj0vHhutUhnKmvVK4Q7nwTAMfxrtjMCiTY0diACEw2+spgb/xMp17mV
         tAzEJKwFDPoWfCkievfUHeC/LfPPTzfWXyBmUlgFDOum1Vc3Gj7u0iEinrPD62/K0URY
         kvifq6C2WCEZnpE8eoJZgpTVioOkw9mQchm1R5DiGgH5tn4MZNORw3YWIjibzuAxr6k/
         mICJHmiwdPsjGUWIGFVFcaP1FTOTZgsGxBsb8eeaTGtiTniNZx3mUQK+Fg8f93FY/kfY
         h+mdxtZMkFMoL1mpO6uq1/E19FC/UEpIKOv48/YYz0oKxngWUPWhsHMy8BLjhEvWbCrD
         Lf6Q==
X-Gm-Message-State: APjAAAVIfo7+c2OV/cXsu/fAm/rVqbvTvmL5SvFYOxsp2iuOxwvrxt9L
        bZcBdu5wjBUFKI2OsUNtRw/Zi73VzRhwNApRk7I=
X-Google-Smtp-Source: APXvYqyjjs48iWbGLKPEWMsHwmFIuNtcqYaXlRXhJbgx8K1bryamxFI42EMf/Az7BDKNB9kKQIvVfgDEJG8jmka4znQ=
X-Received: by 2002:a2e:9b83:: with SMTP id z3mr7608418lji.84.1562995838944;
 Fri, 12 Jul 2019 22:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190627092235.36888-1-zhouyousong@yunionyun.com>
In-Reply-To: <20190627092235.36888-1-zhouyousong@yunionyun.com>
From:   Yousong Zhou <yszhou4tech@gmail.com>
Date:   Sat, 13 Jul 2019 13:30:27 +0800
Message-ID: <CAECwjAhM1FmCoxZnxUxJcE+vCN5=uBd_SuMZEQ6qj8OKfCf3oA@mail.gmail.com>
Subject: Re: [PATCH] column: fix outputing empty column at the end of line
To:     kzak@redhat.com
Cc:     util-linux@vger.kernel.org,
        Yousong Zhou <zhouyousong@yunionyun.com>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, 27 Jun 2019 at 17:22, Yousong Zhou <yszhou4tech@gmail.com> wrote:
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

Hi, do you think this is a real bug and the fix a proper one?  should
I post a pull request through the github project page?

Regards,
                yousong

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
>                 p = *state;
>         }
>         result = p;
> @@ -435,7 +436,7 @@ static int add_line_to_table(struct column_control *ctl, wchar_t *wcs)
>         if (!ctl->tab)
>                 init_table(ctl);
>
> -       while ((wcdata = local_wcstok(wcs, ctl->input_separator, ctl->greedy, &sv))) {
> +       while ((wcdata = local_wcstok(wcs, ctl->input_separator, ctl->greedy, &sv)) || sv) {
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
>                 if (scols_line_refer_data(ln, n, data))
>                         err(EXIT_FAILURE, _("failed to add output data"));
>                 n++;
