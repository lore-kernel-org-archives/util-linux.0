Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:28725 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750712Ab3IYRyi (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 25 Sep 2013 13:54:38 -0400
Date: Wed, 25 Sep 2013 19:54:35 +0200
From: Karel Zak <kzak@redhat.com>
To: Matthew Horsfall <alh@akamai.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Possible security issue with mount()
Message-ID: <20130925175435.GC30761@x2.net.home>
References: <5242FF60.1030805@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5242FF60.1030805@akamai.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Sep 25, 2013 at 11:21:04AM -0400, Matthew Horsfall wrote:
> Hello,
> 
> I've discovered a possible security issue with mount and I was wondering
> where I should report it.

  mount(2) syscall           --> linux kernel list
  mount(8) command line util --> this list

and really ugly security bugs are usually reported privately (rather
than on mailing lists), so maintainers have time to fix distributions
before the thing is public.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
