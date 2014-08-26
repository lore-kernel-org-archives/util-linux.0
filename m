Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:3362 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754049AbaHZUXu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 26 Aug 2014 16:23:50 -0400
Date: Tue, 26 Aug 2014 22:23:41 +0200
From: Karel Zak <kzak@redhat.com>
To: tnut@nutyx.org
Cc: util-linux@vger.kernel.org
Subject: Re: cfdisk, wrong interpretation of yes in non-english language
Message-ID: <20140826202341.GB30359@x2.net.home>
References: <d8263f3bc98929c82bbd0962ca77a159@nutyx.org>
 <20140826175817.GA30359@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140826175817.GA30359@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 26, 2014 at 07:58:17PM +0200, Karel Zak wrote:
> On Tue, Aug 26, 2014 at 11:18:09AM +0200, tnut@nutyx.org wrote:
> > -               if (rc <= 0 || strcasecmp(buf, "yes") != 0
> > -                           || strcasecmp(buf, _("yes")) != 0) {
> > +               if (rc <= 0 ||  (strcasecmp(buf, "yes") != 0
> > +                           && strcasecmp(buf, _("yes")) != 0)) {
> 
>  Fixed, thanks!

 Sorry, committed with typo, should be fixed now.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
