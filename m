Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.187]:52370 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752652Ab2HFGON convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 6 Aug 2012 02:14:13 -0400
Date: Mon, 6 Aug 2012 08:14:12 +0200 (CEST)
From: Bernhard Voelker <mail@bernhard-voelker.de>
Reply-To: Bernhard Voelker <mail@bernhard-voelker.de>
To: util-linux@vger.kernel.org, Sami Kerola <kerolasa@iki.fi>
Message-ID: <1407718255.1271532.1344233652072.JavaMail.open-xchange@email.1und1.de>
In-Reply-To: <1344065620-17480-6-git-send-email-kerolasa@iki.fi>
References: <1344065620-17480-1-git-send-email-kerolasa@iki.fi> <1344065620-17480-6-git-send-email-kerolasa@iki.fi>
Subject: Re: [PATCH 5/5] vipw: make vim writebackup mode work
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On August 4, 2012 at 9:33 AM Sami Kerola <kerolasa@iki.fi> wrote:

> Some editors, such as Vim with 'writebackup' mode enabled, use "atomic
> save" in which the old file is deleted and a new one with the same name
> created in its place.  The vipw tries to detect if such happen by
> looking hard temporary file link count, when it is zero reopen
> temporary file by using it's path.
>
> Reported-by: Mantas Mikulėnas <grawity@gmail.com>
> References: http://www.spinics.net/lists/util-linux-ng/msg06666.html
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  login-utils/vipw.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/login-utils/vipw.c b/login-utils/vipw.c
> index ed3f43b..1eeeb0d 100644
> --- a/login-utils/vipw.c
> +++ b/login-utils/vipw.c
> @@ -275,6 +275,18 @@ static void edit_file(int is_shadow)
> 
>          if (fstat(fileno(tmp_fd), &end))
>                  pw_error(tmp_file, 1, 1);
> +        /* Some editors, such as Vim with 'writebackup' mode enabled,
> +         * use "atomic save" in which the old file is deleted and a new
> +         * one with the same name created in its place.  */
> +        if (end.st_nlink == 0) {
> +                if (close_stream(tmp_fd) != 0)
> +                        err(EXIT_FAILURE, _("write error"));
> +                tmp_fd = fopen(tmp_file, "r");
> +                if (!tmp_file)
> +                        err(EXIT_FAILURE, _("cannot open %s"), tmp_file);
> +                if (fstat(fileno(tmp_fd), &end))
> +                        pw_error(tmp_file, 1, 1);
> +        }
>          if (begin.st_mtime == end.st_mtime) {
>                  warnx(_("no changes made"));
>                  pw_error((char *)NULL, 0, 0);
> --
> 1.7.11.4

Hi Sami,

wasn't the discussion about additionally prompting the user that
"the file vanished and a a new file with the same name has
been created" for security reasons?

We're talking about the intermediate file (in /tmp), but as it's
name is visible e.g. in ps listings, I'd recommend to be cautious
about it.

Have a nice day,
Berny

