Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42512 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752432Ab2CZImF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 26 Mar 2012 04:42:05 -0400
Date: Mon, 26 Mar 2012 10:41:57 +0200
From: Karel Zak <kzak@redhat.com>
To: "mail@bernhard-voelker.de" <mail@bernhard-voelker.de>
Cc: Simon de Vlieger <simon@ikanobori.jp>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH] hexdump: adjust -s and -n option in the man page [was:
 hexsyntax.c using strtol on the offset parameter]
Message-ID: <20120326084157.GJ2040@x2.net.home>
References: <4F6B13F9.4020108@bernhard-voelker.de>
 <20120323171936.GH2040@x2.net.home>
 <917665944.185472.1332746426227.JavaMail.open-xchange@email.1und1.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <917665944.185472.1332746426227.JavaMail.open-xchange@email.1und1.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Hi Berny,

On Mon, Mar 26, 2012 at 09:20:26AM +0200, mail@bernhard-voelker.de wrote:
> I have derived my patch proposal from the info pages of coreutils, as there
> has recently been a discussion about the clearest wording.
> I don't think all users are aware what's the difference between
> "binary (2^N) suffixes KiB" and "decimal (10^N) suffixes KB".

hmm, good point, send patch that fix the problem in all the man pages.

> BTW: why omitting the Z and the Y suffix in the man page?

Send patch ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
