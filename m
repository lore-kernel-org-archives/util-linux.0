Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ig0-f173.google.com ([209.85.213.173]:34677 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbbCPLWw (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 16 Mar 2015 07:22:52 -0400
Received: by igbue6 with SMTP id ue6so30542064igb.1
        for <util-linux@vger.kernel.org>; Mon, 16 Mar 2015 04:22:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1426424094-25451-2-git-send-email-kerolasa@iki.fi>
References: <1426424094-25451-1-git-send-email-kerolasa@iki.fi>
	<1426424094-25451-2-git-send-email-kerolasa@iki.fi>
Date: Mon, 16 Mar 2015 12:22:51 +0100
Message-ID: <CAP-up9DHpM8Xye6y7LptG4bNUeW_Kx22R80Q6nAgv0v8kzi+VQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] logger: tidy few indentation issues
From: Rainer Gerhards <rgerhards@gmail.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Mar 15, 2015 at 1:54 PM, Sami Kerola <kerolasa@iki.fi> wrote:

Quick question on this (especially for future work):

> @@ -387,29 +386,35 @@ static void syslog_rfc3164_header(struct logger_ctl *const ctl)
>  #define NILVALUE "-"
>  static void syslog_rfc5424_header(struct logger_ctl *const ctl)
>  {
> +       char *time;
> +       char *hostname;
> +       char *const app_name = ctl->tag;
> +       char *procid;
> +       char *const msgid = xstrdup(ctl->msgid ? ctl->msgid : NILVALUE);
> +       char *structured_data;

Is it project policy to always define variables at the beginning of
the function? I ask because I used to do that as well, before I got
educated last year that it helps the compiler to produce better code
if variables are declared where needed.

Also on the idention: I assume indention via tabs with tabwidth 4. Is
there a style document I an look at?

Thanks and sorry for the extra effort.

Rainer
