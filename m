Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:59403 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750738AbdFFIKL (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 6 Jun 2017 04:10:11 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: J William Piggott <elseifthen@gmx.com>
Subject: Re: [PATCH 6/6] misc: fix some warnings
Date: Tue, 6 Jun 2017 10:10:07 +0200
Cc: util-linux@vger.kernel.org
References: <1496279320-14541-1-git-send-email-sweet_f_a@gmx.de> <1496279320-14541-7-git-send-email-sweet_f_a@gmx.de> <0035d164-75ac-f892-2cbe-0fb8184116cb@gmx.com>
In-Reply-To: <0035d164-75ac-f892-2cbe-0fb8184116cb@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Message-Id: <201706061010.07911.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 01 June 2017, J William Piggott wrote:
> On 05/31/2017 09:08 PM, Ruediger Meier wrote:
> > From: Ruediger Meier <ruediger.meier@ga-group.nl>
>
>  8< ---
>
> > diff --git a/lib/plymouth-ctrl.c b/lib/plymouth-ctrl.c
> > index 75d8b93..0e60341 100644
> > --- a/lib/plymouth-ctrl.c
> > +++ b/lib/plymouth-ctrl.c
> > @@ -85,7 +85,8 @@ static int open_un_socket_and_connect(void)
> >  	 * Please note that the PLYMOUTH_SOCKET_PATH has a
> >  	 * leading NULL byte to mark it as an abstract socket
> >  	 */
> > -	ret = connect(fd, &su, offsetof(struct sockaddr_un, sun_path) + 1
> > + strlen(su.sun_path+1)); +	ret = connect(fd, (const struct
> > sockaddr *) &su,
> > +	              offsetof(struct sockaddr_un, sun_path) + 1 +
> > strlen(su.sun_path+1));
>
>         ^^^^^^^^^^^^^^ whitespace
>
>  8< ---

What would be the right whitespace style? I've made one indentation 
(tab) and some spaces to align the broken line regarding  "connect(".

I'm using tab only for indentation but not for alignment, to let it look 
nice independently of editors tab witdth. Is that wrong?

cu,
Rudi


