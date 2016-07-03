Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oi0-f54.google.com ([209.85.218.54]:36334 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932160AbcGCWhk (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Jul 2016 18:37:40 -0400
Received: by mail-oi0-f54.google.com with SMTP id f189so174942682oig.3
        for <util-linux@vger.kernel.org>; Sun, 03 Jul 2016 15:37:40 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20160703212358.1218-12-kerolasa@iki.fi>
References: <20160703212358.1218-1-kerolasa@iki.fi> <20160703212358.1218-12-kerolasa@iki.fi>
From: Sami Kerola <kerolasa@iki.fi>
Date: Sun, 3 Jul 2016 23:37:39 +0100
Message-ID: <CAG27Bk3XWNLvqq-oS+v9rOKJPBWt_35Wpgk2nNjvTEKkUby6mA@mail.gmail.com>
Subject: Re: [PATCH 11/15] write: remove PUTC macro
To: util-linux <util-linux@vger.kernel.org>
Cc: Sami Kerola <kerolasa@iki.fi>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 3 July 2016 at 22:23, Sami Kerola <kerolasa@iki.fi> wrote:
> +               if (c == '\n' && fputc_careful('\r', stdout, '^') == EOF)
> +                       goto fail;
> +               if (fputc_careful(c, stdout, '^') == EOF)
> + fail:
> +                       err(EXIT_FAILURE, _("carefulputc failed"));

The two if statements can be merged, and goto becomes unnecessary. Fixed in.

https://github.com/kerolasa/lelux-utiliteetit/commit/a8031743eaea418a9512c426f5678ea53e943ceb

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
