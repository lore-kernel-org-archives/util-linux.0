Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ot0-f178.google.com ([74.125.82.178]:45669 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750785AbeEBCxt (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 1 May 2018 22:53:49 -0400
Received: by mail-ot0-f178.google.com with SMTP id 15-v6so109750otn.12
        for <util-linux@vger.kernel.org>; Tue, 01 May 2018 19:53:49 -0700 (PDT)
Subject: Re: configure output seems confusing in util-linux-2.32
To: L A Walsh <lkml@tlinx.org>, util-linux@vger.kernel.org
References: <5AE908A7.2010900@tlinx.org>
From: Bruce Dubbs <bruce.dubbs@gmail.com>
Message-ID: <0a977638-61e0-2ffc-8b3e-e4c9dcbaea2a@gmail.com>
Date: Tue, 1 May 2018 21:53:47 -0500
MIME-Version: 1.0
In-Reply-To: <5AE908A7.2010900@tlinx.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 05/01/2018 07:39 PM, L A Walsh wrote:
> Looked at configure help, saw:
> 
> Optional packages:
> ...
>   --with-systemd          build with support for systemd
> 
> to me, this means systemd is optional and may be
> included using a 'with'.
> 
> Conversely, one could use:
>   --without-systemd

Works for me,  but you also need to use --without-systemdsystemunitdir

   -- Bruce
