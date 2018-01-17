Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37862 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752612AbeAQNjt (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 17 Jan 2018 08:39:49 -0500
Date: Wed, 17 Jan 2018 14:39:44 +0100
From: Karel Zak <kzak@redhat.com>
To: Carlos Santos <casantos@datacom.ind.br>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] docs: add ISC licence
Message-ID: <20180117133944.wltrmm2ixo32ctoo@ws.net.home>
References: <20180114183931.10494-1-casantos@datacom.ind.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180114183931.10494-1-casantos@datacom.ind.br>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jan 14, 2018 at 04:39:31PM -0200, Carlos Santos wrote:
> Save the top 21 lines of sys-utils/rfkill.c as COPYING.ISC. This is
> useful for Linux distributions an integration tools like Buildroot,
> to collect detailed legal information for each package.
> 
> Signed-off-by: Carlos Santos <casantos@datacom.ind.br>
> ---
>  Documentation/licenses/COPYING.ISC | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/licenses/COPYING.ISC

Applied (without C-comments and rfkill stuff), thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
