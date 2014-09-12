Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57598 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752263AbaILIpI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 12 Sep 2014 04:45:08 -0400
Date: Fri, 12 Sep 2014 10:44:51 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 05/17] newgrp: use xgetpass() and memset_s() to group
 password validation
Message-ID: <20140912084451.GT21325@x2.net.home>
References: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
 <1410093785-17537-6-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1410093785-17537-6-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Sep 07, 2014 at 01:42:53PM +0100, Sami Kerola wrote:
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  login-utils/newgrp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

 If we really want to support passwords for groups then it would be
 better to add support for this to PAM. But it seems it's so crazy and
 unnecessary that nobody has been motivated to do this change in last
 20 years.
 
 It would be better to remove support for /etc/gshadow from newgrp at
 all.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
