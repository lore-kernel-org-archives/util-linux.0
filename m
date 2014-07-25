Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:23157 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478AbaGYLLs (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 25 Jul 2014 07:11:48 -0400
Date: Fri, 25 Jul 2014 13:11:43 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: when specifying multiple types, mount will mount
Message-ID: <20140725111143.GR26781@x2.net.home>
References: <1406233871.13212.145356397.0035B2A9@webmail.messagingengine.com>
 <20140725083216.GO26781@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140725083216.GO26781@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jul 25, 2014 at 10:32:16AM +0200, Karel Zak wrote:
> > I find this surprising.  If -t does not support a comma-separated
> > list, it should report an error.  If it does, it should, IMO, only
> > try the specified types and not any others.
> 
>  yes, I'm just working on patch and regression test for all -t
>  use-cases.

 Fixed, git pull.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
