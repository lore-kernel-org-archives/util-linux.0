Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39974 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753741Ab3C1KHJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 28 Mar 2013 06:07:09 -0400
Date: Thu, 28 Mar 2013 11:06:59 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 08/10] bash-completion: term-utils
Message-ID: <20130328100659.GE24678@x2.net.home>
References: <1364422072-23552-1-git-send-email-kerolasa@iki.fi>
 <1364422072-23552-9-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1364422072-23552-9-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 27, 2013 at 10:07:50PM +0000, Sami Kerola wrote:
> +++ b/shell-completion/agetty
> @@ -0,0 +1,70 @@
> +_agetty_module()

 You don't want to use agetty from command line :-)

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
