Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:19830 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932963Ab3CTM40 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 20 Mar 2013 08:56:26 -0400
Date: Wed, 20 Mar 2013 13:56:16 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 6/7] whereis: canonicalize files before printing
Message-ID: <20130320125616.GA14833@x2.net.home>
References: <1363477219-29245-1-git-send-email-kerolasa@iki.fi>
 <1363477219-29245-7-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363477219-29245-7-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Mar 16, 2013 at 11:40:18PM +0000, Sami Kerola wrote:
> The whereis gives promise to find files so it seems to be more correct
> print symlink destinations than locations of symlinks.

 Not sure. I think it's correct to canonicalize directory paths (to
 avoid problems like /bin -> /usr/bin symlinks), but I don't see
 a reason to canonicalize whole paths (filenames).

 For example

    $ whereis -b bzcat
    bzcat: /usr/bin/bzcat

 is expected answer, but

    $ whereis -b bzcat
    bzcat: /usr/bin/bzip2

 looks strange. The another story is that many things are redirected
 by symlinks to /etc/alternatives and then to pretty specific places.

 Maybe we can add an option to canonicalize, but from my point of view 
 it should not be enabled by default.

 I have applied patch to canonicalize directory names.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
