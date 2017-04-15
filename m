Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33204 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751511AbdDOInC (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 15 Apr 2017 04:43:02 -0400
Received: by mail-qt0-f196.google.com with SMTP id c45so13467185qtb.0
        for <util-linux@vger.kernel.org>; Sat, 15 Apr 2017 01:43:02 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20170414203948.12295-1-kerolasa@iki.fi>
References: <20170414203948.12295-1-kerolasa@iki.fi>
From: Sami Kerola <kerolasa@iki.fi>
Date: Sat, 15 Apr 2017 09:43:01 +0100
Message-ID: <CAG27Bk3dgmzJyFRCxB8w1YqOS8V2deobmg6Z6CiokKaat6dnYw@mail.gmail.com>
Subject: Re: [PATCH] scriptreplay: determine if script --quiet was used to
 create typescript
To: util-linux <util-linux@vger.kernel.org>
Cc: Sami Kerola <kerolasa@iki.fi>, Rui Zhao <renyuneyun@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 14 April 2017 at 21:39, Sami Kerola <kerolasa@iki.fi> wrote:
> diff --git a/term-utils/scriptreplay.c b/term-utils/scriptreplay.c
> index 5fd3ecb16..365b73de4 100644
> --- a/term-utils/scriptreplay.c
> +++ b/term-utils/scriptreplay.c
> @@ -58,6 +59,25 @@ usage(FILE *out)
>         exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
>  }
>
> +static int
> +sfile_has_header(FILE *sfile, FILE *tfile)
> +{
> +       double delay;
> +       size_t blk, total = 0;
> +       char nl;
> +       struct stat st;
> +
> +       if (fstat(fileno(sfile), &st) < 0)
> +               return 0;
> +       while (fscanf(tfile, "%lf %zu%c\n", &delay, &blk, &nl) == 3)
> +               total += blk;
> +       fseek(sfile, 0, SEEK_SET);

sfile file position does not need updating, fixed in:

https://github.com/kerolasa/lelux-utiliteetit/commit/419a5cb277068eea395fdbdf41d9f8cad9296357

branch name: script

> +       fseek(tfile, 0, SEEK_SET);
> +       if ((size_t)st.st_size <= total)
> +               return 0;
> +       return 1;
> +}
> +
>  static double
>  getnum(const char *s)
>  {

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
