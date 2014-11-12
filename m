Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37647 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752532AbaKLOZP (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 12 Nov 2014 09:25:15 -0500
Date: Wed, 12 Nov 2014 15:25:00 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: kerolasa@gmail.com, Boris Egorov <egorov@linux.com>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 0/6] pull: almost working AddressSanitizer support
Message-ID: <20141112142500.GB5530@x2.net.home>
References: <1415656195-20458-1-git-send-email-kerolasa@iki.fi>
 <5461B803.4050707@linux.com>
 <CAG27Bk1cDZUtAm26VpY5bugUWchzY7cjqfEDQYxdDJMYZo-q1w@mail.gmail.com>
 <alpine.LNX.2.03.1411112236560.23899@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.03.1411112236560.23899@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Nov 11, 2014 at 10:49:02PM +0000, Sami Kerola wrote:
>  	printf(_("Setting up swapspace version %d, size = %s (%ju bytes)\n"),
>  		version, strsz, sz);
> +	free(strsz);

 free-before-exit, you know what I think about it, right? :)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
