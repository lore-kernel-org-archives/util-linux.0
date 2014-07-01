Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:17306 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755562AbaGAIwm (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 1 Jul 2014 04:52:42 -0400
Date: Tue, 1 Jul 2014 10:52:39 +0200
From: Karel Zak <kzak@redhat.com>
To: Eric Rannaud <e@nanocritical.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/4] libmount: mnt_resolve_path: don't canonicalize
 fs->target for swap
Message-ID: <20140701085239.GC24337@x2.net.home>
References: <747e9f8de90dc1e906d2f84f3952a801e70ef3d0.1403845374.git.e@nanocritical.com>
 <bc63685a3d056044034ee5c78119313498ad46b1.1403845374.git.e@nanocritical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bc63685a3d056044034ee5c78119313498ad46b1.1403845374.git.e@nanocritical.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 26, 2014 at 10:17:17PM -0700, Eric Rannaud wrote:
>  libmount/src/fs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
