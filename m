Return-Path: util-linux-owner@vger.kernel.org
Received: from wp221.webpack.hosteurope.de ([80.237.132.228]:51321 "EHLO
	wp221.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752031Ab2ATJRp (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Fri, 20 Jan 2012 04:17:45 -0500
Received: by jue.netz (masqmail 0.3.4, from userid 500)
	id 1RoAIm-2uK-00
	for <util-linux@vger.kernel.org>; Fri, 20 Jan 2012 09:58:28 +0100
Date: Fri, 20 Jan 2012 09:58:28 +0100
From: Juergen Daubert <jue@jue.li>
To: util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.21-rc1
Message-ID: <20120120085828.GA11139@jue.netz>
References: <20120119092858.GC2371@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120119092858.GC2371@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jan 19, 2012 at 10:28:58AM +0100, Karel Zak wrote:
> 
> The first util-linux 2.21 release candidate is available at
> 

[...]

> findmnt(8):
>    - supports alternative location of the fstab file
>

This is a incompatible change that might break existing scripts.
Currently it's possible to combine the -s option with other options
like -snr, which leads to an error now. IMO it's not a good idea to 
change existing program options in such a way.


Greetings
Juergen

