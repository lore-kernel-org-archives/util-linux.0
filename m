Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:24541 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751148AbaHFNbJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 6 Aug 2014 09:31:09 -0400
Date: Wed, 6 Aug 2014 15:31:03 +0200
From: Karel Zak <kzak@redhat.com>
To: Josh Triplett <josh@joshtriplett.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Link mkswap to mkfs.swap so mkfs -t swap works
Message-ID: <20140806133103.GJ19820@x2.net.home>
References: <20140803184813.GA20940@thin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140803184813.GA20940@thin>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Aug 03, 2014 at 11:48:14AM -0700, Josh Triplett wrote:
> This makes it easier to write generic code that deals with swap
> along with other filesystems.

 Hmm... mkfs wrapper is deprecated, it does not provide any
 functionality and it seems better when people use directly the FS
 specific tools to create filesystems.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
