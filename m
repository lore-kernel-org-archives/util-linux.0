Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48255 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757869Ab3AINvM (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 9 Jan 2013 08:51:12 -0500
Date: Wed, 9 Jan 2013 14:51:08 +0100
From: Karel Zak <kzak@redhat.com>
To: Richard Tollerton <rich.tollerton@ni.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] mount: Fix -t in listing mode when run as non-root
Message-ID: <20130109135108.GO18204@x2.net.home>
References: <1357193134-26828-1-git-send-email-rich.tollerton@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1357193134-26828-1-git-send-email-rich.tollerton@ni.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jan 03, 2013 at 12:05:34AM -0600, Richard Tollerton wrote:
> Presently, libmount-mount completely prohibits the use of -t by non-root
> users.  This breaks using -t in listing mode as a user, which represents
> a regression against mount-deprecated, macosx and presumably *BSD.

 Applied, thanks.

 Note that suggested way is to use findmnt(8), mount(8) output is
 maintained only for backward compatibility.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
