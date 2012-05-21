Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:6085 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932141Ab2EUJ1d (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 21 May 2012 05:27:33 -0400
Date: Mon, 21 May 2012 11:27:05 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 3/6] fdisk: refactor -s option
Message-ID: <20120521092705.GA14390@x2.net.home>
References: <1337530289.2677.14.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337530289.2677.14.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, May 20, 2012 at 06:11:29PM +0200, Davidlohr Bueso wrote:
> +static unsigned long long get_dev_sz(char *dev)

It's number of blocks (1024-bytes) rather than size, what about

    get_dev_blocks()

or so...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
