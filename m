Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35600 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529Ab1GEVIU convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 5 Jul 2011 17:08:20 -0400
Received: by yxi11 with SMTP id 11so2054011yxi.19
        for <util-linux@vger.kernel.org>; Tue, 05 Jul 2011 14:08:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CABVT_geJbR477C0OBrT1_Mn+iz0sUEE7mLuG56JytoF15uMHTg@mail.gmail.com>
References: <CABVT_geJbR477C0OBrT1_Mn+iz0sUEE7mLuG56JytoF15uMHTg@mail.gmail.com>
From: Kirill Elagin <kirelagin@gmail.com>
Date: Wed, 6 Jul 2011 01:07:59 +0400
Message-ID: <CABVT_geyUifDf5Kcn-fwHv46XPmoBa=3Cx7hB9kV9i+XeCK3xg@mail.gmail.com>
Subject: Re: [PATCH] Fix install-exec-hook to check whether wall and write
 were built
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Sorry for this, didn't notice another thread.

--
Кирилл Елагин



2011/7/5 Kirill Elagin <kirelagin@gmail.com>:
> Signed-off-by: Kirill Elagin <kirelagin@gmail.com>
> ---
>  term-utils/Makefile.am |   12 +++++++++---
>  1 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/term-utils/Makefile.am b/term-utils/Makefile.am
> index 5e03560..8ab9d0b 100644
> --- a/term-utils/Makefile.am
> +++ b/term-utils/Makefile.am
> @@ -66,9 +66,15 @@ endif
>
>  if USE_TTY_GROUP
>  if MAKEINSTALL_DO_CHOWN
> +if BUILD_WALL
>  install-exec-hook::
> -   chgrp tty $(DESTDIR)$(usrbin_execdir)/wall $(DESTDIR)$(usrbin_execdir)/write
> -   chmod g+s $(DESTDIR)$(usrbin_execdir)/wall $(DESTDIR)$(usrbin_execdir)/write
> -
> +   chgrp tty $(DESTDIR)$(usrbin_execdir)/wall
> +   chmod g+s $(DESTDIR)$(usrbin_execdir)/wall
> +endif
> +if BUILD_WRITE
> +install-exec-hook::
> +   chgrp tty $(DESTDIR)$(usrbin_execdir)/write
> +   chmod g+s $(DESTDIR)$(usrbin_execdir)/write
> +endif
>  endif
>  endif
> --
> 1.7.3.4
>
