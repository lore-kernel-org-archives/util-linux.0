Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46873 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753107AbaG2J4P (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 29 Jul 2014 05:56:15 -0400
Date: Tue, 29 Jul 2014 11:55:57 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org, Kodiak Firesmith <ksf@sei.cmu.edu>
Subject: Re: [PATCH 00/10] pull: logger changes
Message-ID: <20140729095557.GR8533@x2.net.home>
References: <1406066459-4816-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406066459-4816-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 22, 2014 at 11:00:49PM +0100, Sami Kerola wrote:
>  audit_getloginuid      |   0
>  bash-completion/logger |   2 +-
>  misc-utils/logger.1    |  98 ++++++++++++----
>  misc-utils/logger.c    | 300 ++++++++++++++++++++++++++++++++++++-------------
>  4 files changed, 295 insertions(+), 105 deletions(-)
>  create mode 100644 audit_getloginuid

 Merged & modified. Thanks.

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
