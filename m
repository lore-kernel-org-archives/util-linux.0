Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:39760 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752390Ab1IGQGs (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 7 Sep 2011 12:06:48 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 832CA8C5DF
	for <util-linux@vger.kernel.org>; Wed,  7 Sep 2011 18:06:46 +0200 (CEST)
Date: Wed, 7 Sep 2011 09:05:07 +0200
From: "Dr. Werner Fink" <werner@suse.de>
To: Francesco Cosoleto <cosoleto@gmail.com>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: agetty: double equals sign typo in opentty()
Message-ID: <20110907070507.GA22531@boole.suse.de>
References: <CAMFXF50k2Q7JAQH8kkZkqVCf9SM9ava1EmxRmBzqhdhqO8uQLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAMFXF50k2Q7JAQH8kkZkqVCf9SM9ava1EmxRmBzqhdhqO8uQLA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Sep 06, 2011 at 10:50:58PM +0200, Francesco Cosoleto wrote:
> Hello.
> 
> agetty.c(988): warning #187: use of "=" where "==" may have been intended
>         if (ioctl(STDIN_FILENO, TIOCMGET, &serial) < 0 && (errno = EINVAL)) {
>                                                           ^
> This was spotted by Intel Compiler.

Wooh ... good catch :)

     Werner

-- 
  "Having a smoking section in a restaurant is like having
          a peeing section in a swimming pool." -- Edward Burr
