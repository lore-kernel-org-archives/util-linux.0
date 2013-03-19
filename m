Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49750 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755733Ab3CSIwJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 19 Mar 2013 04:52:09 -0400
Date: Tue, 19 Mar 2013 09:52:05 +0100
From: Karel Zak <kzak@redhat.com>
To: Roger Leigh <rleigh@codelibre.net>
Cc: util-linux@vger.kernel.org
Subject: Re: newgrp(1) and sg(1)
Message-ID: <20130319085205.GA2603@x2.net.home>
References: <20130318154225.GF2172@x2.net.home>
 <20130318223840.GW23093@codelibre.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130318223840.GW23093@codelibre.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 18, 2013 at 10:38:40PM +0000, Roger Leigh wrote:
> I don't think that deprecation is really appropriate--the system
> interface, NSS and /etc/gshadow are not really the purview of
> util-linux, though tools using the interfaces certainly are.

 Well, gpasswd uses /etc/gshadow, what else?

> newgrp(1) is specified by POSIX/SUS, so I think this is worth
> retaining for compatibility reasons.  Making it use NSS would be
> a good improvement though, since it's currently limited to flat
> files.

 I'm talking about group paswords. I don't see a problem to support
 newgrp(1) as a way how to switch groups, but the question is if we
 really need to support the passwords.

 BTW, posix:

   There is no convenient way to enter a password into the group
   database. Use of group passwords is not encouraged, because by their
   very nature they encourage poor security practices. Group passwords
   may disappear in the future.
 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
