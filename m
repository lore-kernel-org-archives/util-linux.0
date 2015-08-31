Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.126.130]:63652 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbbHaG4p (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 31 Aug 2015 02:56:45 -0400
Subject: Re: fdisk
To: Bruce Dubbs <bruce.dubbs@gmail.com>, util-linux@vger.kernel.org
References: <55E3B640.2060606@gmail.com>
From: Bernhard Voelker <mail@bernhard-voelker.de>
Message-ID: <55E3FAA9.5060204@bernhard-voelker.de>
Date: Mon, 31 Aug 2015 08:56:41 +0200
MIME-Version: 1.0
In-Reply-To: <55E3B640.2060606@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 08/31/2015 04:04 AM, Bruce Dubbs wrote:
> I have a question about (or a enhancement request) running fdisk.  When 
> asking to list known partition types, I get about 70 lines of output. 
> Generally that would not be a problem, but I was running in a Debian 
> install/rescue iso that uses busybox in a 25 line terminal.  I do not 
> have a way to scroll up and thus cannot see the first 40 or so partition 
> types.
> 
> Is there a way to use a pager for this?  In this situation 'more' is 
> available but 'less' is not.  Otherwise I think an automatic pause every 
> 20 lines or so would be appropriate to build into the partition type 
> listing.

hmm, I'm getting 27 lines (at a maximum line length of 79 characters) as
output of the 'l' command  here - even if I resize the xterm to 20x80
characters.
OTOH, the main help output via the 'm' command uses 38 lines.  Shouldn't
you also have issues with that one in your environment?

Have a nice day,
Berny
