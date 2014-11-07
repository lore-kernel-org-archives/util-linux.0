Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44079 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090AbaKGMLo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 7 Nov 2014 07:11:44 -0500
Date: Fri, 7 Nov 2014 13:11:33 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/8] pull: mostly mkswap and one swapoff chanage
Message-ID: <20141107121133.GJ6880@x2.net.home>
References: <1414959991-8369-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1414959991-8369-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Nov 02, 2014 at 08:26:23PM +0000, Sami Kerola wrote:
>   mkswap: remove system architecture specific max swap size checks
>   mkswap: remove unnecessary size check
>   mkswap: use err() rather than perror() && exit()
>   mkswap: add struct mkswap_control to remove global variables
>   mkswap: make remaining functions to take control structure as argument
>   mkswap: set variable only when it's value is known
>   mkswap: various minor improvement

merged. I'll probably cleanup the mkswap code too.

>  disk-utils/mkswap.c     | 435 ++++++++++++++++--------------------------------

 Thanks! :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
