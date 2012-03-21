Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40442 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751125Ab2CUSoY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 21 Mar 2012 14:44:24 -0400
Date: Wed, 21 Mar 2012 19:44:19 +0100
From: Karel Zak <kzak@redhat.com>
To: Simon de Vlieger <simon@ikanobori.jp>
Cc: util-linux@vger.kernel.org
Subject: Re: hexsyntax.c using strtol on the offset parameter
Message-ID: <20120321184419.GE2040@x2.net.home>
References: <CANXSoSB_JTjcwfCPu6vJLdtLtR5e1M4VHJiDu2NpGo=hp6SMrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANXSoSB_JTjcwfCPu6vJLdtLtR5e1M4VHJiDu2NpGo=hp6SMrA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 21, 2012 at 03:53:55PM +0100, Simon de Vlieger wrote:
> The line I think I have it narrowed down to is line 92 of
> util-linux/hexsyntax.c where the -s parameter is converted to a long.

 Fixed. The code (as well as -n) was stupid. Now it supports all
 possible suffixes (K,M,G,T,P,E,Y,Z) and the number is parsed as
 uintmax_t.

> Sadly the size of a 1 TB disk overflows the size of a long. Can the
> off_t maybe be changed to use off64_t (if this is relevant) and use

 The problem is not off_t, but strtol().

 Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
