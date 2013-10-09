Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42621 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752484Ab3JIJrR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 9 Oct 2013 05:47:17 -0400
Date: Wed, 9 Oct 2013 11:47:12 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [patches] standardizing the error messages "cannot read %s" and
 "seek on %s failed"
Message-ID: <20131009094712.GK13559@x2.net.home>
References: <1381246807.30460.31493077.03F09F4B@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381246807.30460.31493077.03F09F4B@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Oct 08, 2013 at 05:40:07PM +0200, Benno Schulenberg wrote:
> First patch standardizes the plain "cannot read %s" and "seek on %s failed"
> error messages.  Second, third and fourth make some tiny textual corrections.
> Fifth patch slices up also the first third of the help text of losetup; the
> rest of the text is already sliced.

 Applied, thanks. 
 
 So I guess we're ready for -rc2, right? (probably tomorrow/Friday)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
