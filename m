Return-Path: util-linux-owner@vger.kernel.org
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:20270 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897Ab1F3Ixa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 30 Jun 2011 04:53:30 -0400
Date: Thu, 30 Jun 2011 10:53:27 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Marc-Antoine Perennou <Marc-Antoine@Perennou.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Don't try to chgrp write or wall if they are not built
Message-ID: <20110630085327.GA8274@aepfle.de>
References: <BANLkTikpHa-0aVp7G7cpRw_ePOQQiuXSEYnrV-AgssjhFEf2zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <BANLkTikpHa-0aVp7G7cpRw_ePOQQiuXSEYnrV-AgssjhFEf2zg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 30, Marc-Antoine Perennou wrote:

> Fix regression from commit 4aa9d65bfa76afd0d886ca410ae83428a490d4ea
> 
> Signed-off-by: Marc-Antoine Perennou <Marc-Antoine@Perennou.com>
> ---
>  term-utils/Makefile.am |   10 ++++++++--

> -       chgrp tty $(DESTDIR)$(usrbin_execdir)/wall
> $(DESTDIR)$(usrbin_execdir)/write
> -       chmod g+s $(DESTDIR)$(usrbin_execdir)/wall
> $(DESTDIR)$(usrbin_execdir)/write
> +if BUILD_WALL
> +       chgrp tty $(DESTDIR)$(usrbin_execdir)/wall

This is wrong and should part of the packaging system, not part of make
install. The userid building util-linux is not neccessary part of the
tty group.

Olaf
