Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.126.131]:58887 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbbGXGYE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 24 Jul 2015 02:24:04 -0400
Message-ID: <55B1D9F7.4040109@bernhard-voelker.de>
Date: Fri, 24 Jul 2015 08:23:51 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Joel Holdsworth <joel.holdsworth@vcatechnology.com>,
        util-linux@vger.kernel.org
CC: Joel Holdsworth <joel@airwebreathe.org.uk>
Subject: Re: [PATCH] build-sys: cal requires both ncurses and tinfo
References: <1437692199-7557-1-git-send-email-joel.holdsworth@vcatechnology.com>
In-Reply-To: <1437692199-7557-1-git-send-email-joel.holdsworth@vcatechnology.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 07/24/2015 12:56 AM, Joel Holdsworth wrote:
> This fixes a bug in the build system when building without ncurses
> and tinfo. When cal is linked, it depends on both these libraries
> and will fail to link if either of them is not available.
> 
> This patch resolves the issue by explicitly declaring these
> dependencies in the confgure.ac.

wouldn't this invalidate configure's --without-ncurses option?

Have a nice day,
Berny
