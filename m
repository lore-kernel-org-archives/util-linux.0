Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49407 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753290Ab3JOJvG convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 Oct 2013 05:51:06 -0400
Message-Id: <1381830660.19586.34144785.7C200E19@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Karel Zak <kzak@redhat.com>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <20131015082731.GA31477@x2.net.home>
References: <1381783511.18298.33939989.442C9894@webmail.messagingengine.com>
 <20131015082731.GA31477@x2.net.home>
Subject: Re: [patches] a few more man-page improvements
Date: Tue, 15 Oct 2013 11:51:00 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Tue, Oct 15, 2013, at 10:27, Karel Zak wrote:
> On Mon, Oct 14, 2013 at 10:45:11PM +0200, Benno Schulenberg wrote:
> > rm: cannot remove 'mount': Is a directory
> > make[2]: *** [mount] Error 1
> > rm: cannot remove 'getopt': Is a directory
> > make[2]: *** [getopt] Error 1
> 
>  Oh, it seems you have very old stuff in your work tree, try:
>  
>     git clean -xdf

Thanks, that worked:

$ git clean -dxf
Removing getopt/
Removing mount/

Now it compiles fine, with only those five warnings in libfdisk/src/ask.c:
«format '%zd' expects argument of type 'signed size_t', but...» and two
unused variables in misc-utils/cal.c (when compiled without ncurses).

Benno

-- 
http://www.fastmail.fm - Choose from over 50 domains or use your own

