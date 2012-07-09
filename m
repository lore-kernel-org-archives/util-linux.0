Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:14415 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752976Ab2GIU20 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 9 Jul 2012 16:28:26 -0400
Date: Mon, 9 Jul 2012 22:28:23 +0200
From: Karel Zak <kzak@redhat.com>
To: Sergei Antonov <saproj@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Buffer overrun in some calls to sscanf
Message-ID: <20120709202823.GA5281@x2.net.home>
References: <CABikg9y0q1onOb2vzuxtOJt4QQL+gXR7FzNjHJffxQCJWsL5RQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABikg9y0q1onOb2vzuxtOJt4QQL+gXR7FzNjHJffxQCJWsL5RQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 09, 2012 at 07:15:57PM +0200, Sergei Antonov wrote:
> Take a look at these 7 places where sscanf may write 1 zero byte past
> the end of the array.
> To fix this either decrease the %N limit or increase array size.

 Fixed, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
