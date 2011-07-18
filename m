Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61487 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754299Ab1GRSLg convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 18 Jul 2011 14:11:36 -0400
Received: by iyb12 with SMTP id 12so3327507iyb.19
        for <util-linux@vger.kernel.org>; Mon, 18 Jul 2011 11:11:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACpTwpGZHf4dY72T6-nNLWCEU9CM2h58OQvCVgDZiKxsOorxVw@mail.gmail.com>
References: <CACpTwpGZHf4dY72T6-nNLWCEU9CM2h58OQvCVgDZiKxsOorxVw@mail.gmail.com>
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 18 Jul 2011 14:11:15 -0400
Message-ID: <CAJaTeTrdvGBpMf8quzORSjkcnVt=ZWeJ2DvPZDChZ+hO_W60Vw@mail.gmail.com>
Subject: Re: dmesg: fix segfqult
To: Marc-Antoine Perennou <Marc-Antoine@perennou.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 18, 2011 at 12:45, Marc-Antoine Perennou wrote:
> -               size_t len = mbrtowc(&wc, p, size - i, &s);
> +               int len = mbrtowc(&wc, p, size - i, &s);

this is wrong for systems where sizeof(size_t) != sizeof(int).  i
think you want to fix the code like the man page indicates ... do "if
(len < (size_t)-1) ....."
-mike
