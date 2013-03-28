Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55668 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752593Ab3C1KFx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 28 Mar 2013 06:05:53 -0400
Date: Thu, 28 Mar 2013 11:05:43 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 04/10] bash-completion: login-utils
Message-ID: <20130328100543.GD24678@x2.net.home>
References: <1364422072-23552-1-git-send-email-kerolasa@iki.fi>
 <1364422072-23552-5-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1364422072-23552-5-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 27, 2013 at 10:07:46PM +0000, Sami Kerola wrote:
> +++ b/shell-completion/login
> @@ -0,0 +1,27 @@
> +_login_module()

 Unnecessary module, nobody calls login(1) from command line, it does
 not work, it's not supported :-)

> +++ b/shell-completion/sulogin
> @@ -0,0 +1,24 @@
> +_sulogin_module()

 the same thing, unnecessary

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
