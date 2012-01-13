Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51231 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759442Ab2AMXMa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 13 Jan 2012 18:12:30 -0500
Received: by ghbg16 with SMTP id g16so1155913ghb.19
        for <util-linux@vger.kernel.org>; Fri, 13 Jan 2012 15:12:30 -0800 (PST)
Message-ID: <4F10BA5A.6020001@gmail.com>
Date: Fri, 13 Jan 2012 17:12:26 -0600
From: Bruce Dubbs <bruce.dubbs@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: getting a modern `more`
References: <201201130128.49700.vapier@gentoo.org>
In-Reply-To: <201201130128.49700.vapier@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Mike Frysinger wrote:
> in a random conversation, Eric mentioned that he still maintains his own 
> version of more (which at this point, has been rewritten a time or two).  i 
> mentioned that the `more` found in util-linux dates back to his original 
> version.  i'm hoping there can be a melding of minds here so we can all benefit 
> from his work :).

Does anyone still use 'more'?  The only thing needed is a symlink to 
'less': http://www.greenwoodsoftware.com/less/

Are there any distros that don't provide 'less' by default?

What value added does 'more' provide?  I'd think development time would 
be better used elsewhere.  To me, 'more' was developed in the era of 
paper terminals (e.g. Teletype) and it is time to retire it.

   -- Bruce
