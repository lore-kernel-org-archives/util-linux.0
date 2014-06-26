Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:28289 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755233AbaFZMtp (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Jun 2014 08:49:45 -0400
Date: Thu, 26 Jun 2014 14:49:37 +0200
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: fallocate: --punch option parsing error diagnostics irritating
Message-ID: <20140626124937.GB750@x2.net.home>
References: <53AB2E36.5060405@bernhard-voelker.de>
 <20140626101009.GD30418@x2.net.home>
 <53ABFB5A.9020005@draigBrady.com>
 <20140626110702.GA750@x2.net.home>
 <53AC0E89.4020300@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53AC0E89.4020300@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 26, 2014 at 02:14:01PM +0200, Bernhard Voelker wrote:
> The patch below fixes it.

 Applied, thanks.

> BTW: I think fallocate(1) shouldn't open(...,O_CREAT)
> with -d, -p, and maybe with -z, should it?

Good catch, I think O_CREAT makes sense only for the default
fallocate(2) behavior when no mode is specified and new file is
allocated. All another modes work with existing data/holes. 

Fixed.

    Karel


PS. I love this on-line development and brain storming, git & OSS is
    the best :-)

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
