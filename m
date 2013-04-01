Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f169.google.com ([209.85.212.169]:41967 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758835Ab3DAQGZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 1 Apr 2013 12:06:25 -0400
Received: by mail-wi0-f169.google.com with SMTP id c10so2301356wiw.0
        for <util-linux@vger.kernel.org>; Mon, 01 Apr 2013 09:06:24 -0700 (PDT)
Date: Mon, 1 Apr 2013 17:06:19 +0100
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 04/10] bash-completion: login-utils
Message-ID: <20130401160605.GD20549@gmail.com>
References: <1364422072-23552-1-git-send-email-kerolasa@iki.fi>
 <1364422072-23552-5-git-send-email-kerolasa@iki.fi>
 <20130328100543.GD24678@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130328100543.GD24678@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Mar 28, 2013 at 11:05:43AM +0100, Karel Zak wrote:
> On Wed, Mar 27, 2013 at 10:07:46PM +0000, Sami Kerola wrote:
> > +++ b/shell-completion/login
> > @@ -0,0 +1,27 @@
> > +_login_module()
> 
>  Unnecessary module, nobody calls login(1) from command line, it does
>  not work, it's not supported :-)
> 
> > +++ b/shell-completion/sulogin
> > @@ -0,0 +1,24 @@
> > +_sulogin_module()
> 
>  the same thing, unnecessary

Both are removed, and the agetty as well which is mentioned in later message.

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
