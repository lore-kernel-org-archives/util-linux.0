Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:17323 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771Ab1LTMOg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 20 Dec 2011 07:14:36 -0500
Date: Tue, 20 Dec 2011 13:14:29 +0100
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] prlimit: use xalloc libs
Message-ID: <20111220121429.GA10373@x2.net.home>
References: <1324382296.3316.0.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1324382296.3316.0.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Dec 20, 2011 at 12:58:16PM +0100, Davidlohr Bueso wrote:
> +	struct prlimit *lim = xcalloc(1, sizeof(*lim));

 Applied, thanks.

 It would be nice to have a script tools/checkxalloc.sh to check if
 all code where we include "xalloc.h" use stuff from this file only.
 Volunteers? :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
