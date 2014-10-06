Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38761 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753099AbaJFRkp (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 6 Oct 2014 13:40:45 -0400
Date: Mon, 6 Oct 2014 19:40:41 +0200
From: Karel Zak <kzak@redhat.com>
To: Francis Moreau <francis.moro@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: losetup: failed to setup loop device > 1
Message-ID: <20141006174041.GA8057@x2.net.home>
References: <5432C4C8.30101@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5432C4C8.30101@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 06, 2014 at 06:35:20PM +0200, Francis Moreau wrote:
> One last details is that the system uses pretty old stuff: kernel
> 3.4.50, util-linux 2.21.1.

$ git log --oneline v2.21.. -- lib/loopdev.c sys-utils/losetup.c | wc -l
62

> Could anybody give me some help ?

update, this is upstream mailing list I have doubts anyone is ready
to help you with code released 2 years ago.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
