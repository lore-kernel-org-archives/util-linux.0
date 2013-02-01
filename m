Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:2181 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756871Ab3BAQwZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 1 Feb 2013 11:52:25 -0500
Date: Fri, 1 Feb 2013 17:31:02 +0100
From: Karel Zak <kzak@redhat.com>
To: Henrik Grindal Bakken <hgb@ifi.uio.no>
Cc: util-linux@vger.kernel.org
Subject: Re: login/telnet problems
Message-ID: <20130201163102.GJ3741@x2.net.home>
References: <x2efw1iyk1r.fsf@diamant.ifi.uio.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <x2efw1iyk1r.fsf@diamant.ifi.uio.no>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 30, 2013 at 12:41:52PM +0100, Henrik Grindal Bakken wrote:
> Hi.  I'm working on a product which (sadly) requires telnet, and after
> an upgrade from util-linux-2.20 to 2.22.2, telnet starts acting up by
> dropping the first character (at least that's the easiest problem to
> spot).

Seems like a kernel problem: https://lkml.org/lkml/2013/1/15/641

> It's not a huge problem for me to keep a local revert of this commit,
> but I thought perhaps you wanted to know it did actually break
> something (although one can argue the very existence of telnet these
> days is a bug...).

In https://bugzilla.redhat.com/show_bug.cgi?id=904182 someone
suggested -D for telned as workaround :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
