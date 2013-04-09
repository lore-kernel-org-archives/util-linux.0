Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:5130 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935228Ab3DIKp4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 9 Apr 2013 06:45:56 -0400
Date: Tue, 9 Apr 2013 12:30:18 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 00/14] [pull] smatch scan, and manual tooling
Message-ID: <20130409103018.GR14350@x2.net.home>
References: <1365449579-13238-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365449579-13238-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Apr 08, 2013 at 08:32:45PM +0100, Sami Kerola wrote:
> Sami Kerola (14):

 All applied, thanks.

>       setarch: clean up usage()
>       bash-completion: setarch: use correct list for architectures
>       bash-completion: swapon: add options and fix argument
>       various: fix variable and function declarations [smatch scan]
>       various: fix shadow declarations [smatch scan]
>       libmount, col: remove redundant null checks [smatch scan]
>       libblkid: number of functions should not be declared extern [smatch scan]
>       tools: add checks to manual page test script
>       docs: mount.8: make propagation flags adjustable [checkmans.sh]
>       docs: col.1: fix manual page name section [checkmans.sh]
>       docs: remove repeated words [checkmans.sh]
>       tools: make checkmans.sh to find missing manuals

>       docs: add mkfs.cramfs manual page
>       docs: add fsck.cramfs manual page

 extra thanks for the new man pages!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
