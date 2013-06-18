Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pb0-f43.google.com ([209.85.160.43]:35917 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448Ab3FRIVj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 18 Jun 2013 04:21:39 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so3670341pbc.2
        for <util-linux@vger.kernel.org>; Tue, 18 Jun 2013 01:21:39 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20130618051402.36DA3417C5@snark.thyrsus.com>
References: <20130618051402.36DA3417C5@snark.thyrsus.com>
Date: Tue, 18 Jun 2013 09:21:39 +0100
Message-ID: <CAG27Bk2Tba1+TtQ6yhyxraEuksKMb1hjpH6W0=zF-YSgkrRuWQ@mail.gmail.com>
Subject: Re: Problems in logger.1
From: Sami Kerola <kerolasa@iki.fi>
To: esr@thyrsus.com
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 18 June 2013 06:14,  <esr@thyrsus.com> wrote:
> This is automatically generated email about markup problems in a man
> page for which you appear to be responsible.

[snip]

> Problems with logger.1:
>
> My records indicate that you have accepted this patch, so this is just
> a reminder.
>
> Wrong order of arguments in .Dd macro.
>
> --- logger.1-unpatched  2012-06-29 10:17:28.914062782 -0400
> +++ logger.1    2012-06-29 10:18:16.278061896 -0400
> @@ -33,7 +33,7 @@
>  .\"
>  .\" Section on valid facility and level strings added by
>  .\" and1000@debian.org, 26 Oct 1997.
> -.Dd August 2011 "  "
> +.Dd August "  " 2011
>  .Dt LOGGER(1) "" "User Commands"
>  .Os util-linux
>  .Sh NAME

Hi Eric,

I have feeling you ran the test on system which has old util-linux.
The commit below changed the logger.1 to use macros groff_man rather
than mandoc.

$ git tag --contains c047c42d7adcad820fa2663b10f8cf7291935b30
v2.21
v2.21-rc1
v2.21-rc2
[...]
v2.23.1

--
   Sami Kerola
   http://www.iki.fi/kerolasa/
