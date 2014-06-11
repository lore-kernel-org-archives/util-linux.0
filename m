Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:57531 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752001AbaFKWSf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 11 Jun 2014 18:18:35 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Bruce Dubbs <bruce.dubbs@gmail.com>
Subject: Re: [PATCH] next try to update gettext version
Date: Thu, 12 Jun 2014 00:18:32 +0200
Cc: util-linux@vger.kernel.org
References: <1402394931-20416-1-git-send-email-sweet_f_a@gmx.de> <53974319.7040608@gmail.com>
In-Reply-To: <53974319.7040608@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201406120018.32418.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 10 June 2014, Bruce Dubbs wrote:
> Ruediger Meier wrote:
> > From: Ruediger Meier <ruediger.meier@ga-group.nl>
> >
> > This patch is just a proposal. Is it not too ugly to do it that
> > way? For a final patch I would improve shell portability and error
> > handling.
> >
> > Ruediger Meier (1):
> >    build-sys: use gettext 0.18.3 if possible
>
> gettext-0.19.1 was released a few hours ago.  It would be useful to
> check against that release.
>
>    -- Bruce

Thanks or reminding!

Our discussed changes shouldn't break with 0.19.x as we still force
<= 0.18.3. But I will check that in practice before next release.

cu,
Rudi
