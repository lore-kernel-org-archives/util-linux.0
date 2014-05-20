Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:61535 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295AbaETNQ0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 20 May 2014 09:16:26 -0400
Date: Tue, 20 May 2014 15:16:21 +0200
From: Karel Zak <kzak@redhat.com>
To: Shakur Shams Mullick <shakursmullick@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v3 1/5] libsmartcols/src/libsmartcols.h.in: add function
Message-ID: <20140520131621.GP26357@x2.net.home>
References: <1400044200-9196-1-git-send-email-shakursmullick@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1400044200-9196-1-git-send-email-shakursmullick@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, May 14, 2014 at 11:09:56AM +0600, Shakur Shams Mullick wrote:
>  libsmartcols/src/libsmartcols.h.in | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

 OK, I have changed many things and merged all. Now lsblk supports
 sort by arbitrary output column, for example:

    $ lsblk --sort SIZE
    $ lsblk --topology --sort OPT-IO

 Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
