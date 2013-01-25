Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:26912 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751605Ab3AYJRW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 25 Jan 2013 04:17:22 -0500
Date: Fri, 25 Jan 2013 10:17:12 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 17/22] docs: mkswap.8: recommend fallocate(1)
Message-ID: <20130125091712.GE27413@x2.net.home>
References: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
 <1358554151-25985-18-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1358554151-25985-18-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jan 19, 2013 at 12:09:06AM +0000, Sami Kerola wrote:
> +# fallocate -l 8GB swapfile

 Applied. It seems more readable to use long option in examples:

   fallocate --length 8GiB swapfile

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
