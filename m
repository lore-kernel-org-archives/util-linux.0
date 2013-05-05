Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vb0-f45.google.com ([209.85.212.45]:48654 "EHLO
	mail-vb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613Ab3EER5m convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 5 May 2013 13:57:42 -0400
Received: by mail-vb0-f45.google.com with SMTP id 12so2486165vbf.32
        for <util-linux@vger.kernel.org>; Sun, 05 May 2013 10:57:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130505161231.GA7764@type.youpi.perso.aquilenet.fr>
References: <CAGXs5wVLX+aq2D5D5SOaSYSjt1i3V_RNy9XXv1ti8vZdBoDCEg@mail.gmail.com>
	<20130505161231.GA7764@type.youpi.perso.aquilenet.fr>
Date: Sun, 5 May 2013 20:57:40 +0300
Message-ID: <CAGXs5wU+m3utoCQapgGfd4fOaTnJTQ+5Bmj0bOZwA8Wx2R8_Kw@mail.gmail.com>
Subject: Re: error with util-linux from git
From: Kevin Wilson <wkevils@gmail.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Kevin Wilson <wkevils@gmail.com>, util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,
Thanks, apt-get install pkg-config solved it
rgs
Kevin


On Sun, May 5, 2013 at 7:12 PM, Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
> Kevin Wilson, le Sun 05 May 2013 19:08:42 +0300, a écrit :
>> any ideas?
>
> Install pkg-config on your system, or anything which would ship
> pkg.m4
>
> Samuel
