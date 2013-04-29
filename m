Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vc0-f172.google.com ([209.85.220.172]:34472 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759198Ab3D2UVv convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 29 Apr 2013 16:21:51 -0400
Received: by mail-vc0-f172.google.com with SMTP id hx10so5809354vcb.17
        for <util-linux@vger.kernel.org>; Mon, 29 Apr 2013 13:21:50 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <517E8FFC.2040109@archlinux.org>
References: <1367169067-23705-1-git-send-email-kerolasa@iki.fi>
	<1367169067-23705-3-git-send-email-kerolasa@iki.fi>
	<517E8FFC.2040109@archlinux.org>
Date: Mon, 29 Apr 2013 21:21:50 +0100
Message-ID: <CAG27Bk3-sczegeV-N8Ybap5hkViqnUB4qij+f+JNBGLCFmXiAA@mail.gmail.com>
Subject: Re: [PATCH 02/11] cal: convert function like definitions to functions
From: Sami Kerola <kerolasa@iki.fi>
To: =?ISO-8859-1?Q?Thomas_B=E4chler?= <thomas@archlinux.org>
Cc: Sami Kerola <public-kerolasa-X3B1VOXEql0@plane.gmane.org>,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 29 April 2013 16:21, Thomas Bächler <thomas@archlinux.org> wrote:
> This formula is incorrect, there's a difference between the old version
> and yours. The original (correct) version is:
>
> ( !(year % 4) && (year % 100) ) || !(year % 400)

Indeed. Your version is now part of my git, which I will send later
when all feedback is reflected in code.

--
   Sami Kerola
   http://www.iki.fi/kerolasa/
