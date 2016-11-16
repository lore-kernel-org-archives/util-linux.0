Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35550 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752985AbcKPROQ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 16 Nov 2016 12:14:16 -0500
Received: by mail-qk0-f193.google.com with SMTP id n204so22196849qke.2
        for <util-linux@vger.kernel.org>; Wed, 16 Nov 2016 09:14:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1479313936-10018-1-git-send-email-jimp@wegrok.net>
References: <1479313936-10018-1-git-send-email-jimp@wegrok.net>
From: Jim Patterson <jimp@wegrok.net>
Date: Wed, 16 Nov 2016 12:14:14 -0500
Message-ID: <CADBFhQcp6XOd3mCY71Omd1e9oZDEQJ+3R+sGGHr3bkZ+G1QLNQ@mail.gmail.com>
Subject: Re: [PATCH] wall: add --group option
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 16, 2016 at 11:32 AM, Jim Patterson <jimp@wegrok.net> wrote:
> The wall command on AIX supports a "-g" option to limit the message
> to a group of users by gid.  Add compatibility to the Linux version.
>
> Thanks to Sami Kerola <kerolasa@iki.fi> for an initial skeleton
> implementation.
>
> Reference: http://www.ibm.com/support/knowledgecenter/ssw_aix_61/com.ibm.aix.cmds6/wall.htm
> @@ -113,6 +168,7 @@ int main(int argc, char **argv)
>         static const struct option longopts[] = {
>                 { "nobanner",   no_argument,            0, 'n' },
>                 { "timeout",    required_argument,      0, 't' },
> +               { "group",      required_argument,      0, 'g' },
>                 { "version",    no_argument,            0, 'V' },
>                 { "help",       no_argument,            0, 'h' },
>                 { NULL, 0, 0, 0 }
> @@ -123,7 +179,7 @@ int main(int argc, char **argv)
>         textdomain(PACKAGE);
>         atexit(close_stdout);
>
> -       while ((ch = getopt_long(argc, argv, "nt:Vh", longopts, NULL)) != -1) {
> +       while ((ch = getopt_long(argc, argv, "nt:g:Vh", longopts, NULL)) != -1) {
>                 switch (ch) {
>                 case 'n':
>                         if (geteuid() == 0)

Wouldn't you know it.  Just after I send this, I noticed that I missed
the usage function.  I'll add that in just a moment and send a revised
patch.

Sorry,
Jim P
