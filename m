Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38993 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751648AbaCGKok (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 7 Mar 2014 05:44:40 -0500
Date: Fri, 7 Mar 2014 11:44:29 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/4] pull: allow disabling command builds
Message-ID: <20140307104429.GC9303@x2.net.home>
References: <1392564176-11596-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392564176-11596-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 16, 2014 at 03:22:52PM +0000, Sami Kerola wrote:
> This pull request has four patches that will allow a builder to disable
> all commands. 

Note that I don't silently ignore these patches, but I'd like to play
with it later and try to provide better granularity, maybe something
like

  --enable-util=<list>
  --disable-util=<list>
  --enable-all
  --disable-all

where <list> is comma separated list of the utils names (we already
use thing like this for static programs), then we can avoid huge
number of --enable-* options.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
