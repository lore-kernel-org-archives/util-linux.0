Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49255 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751471Ab1H3Int (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 30 Aug 2011 04:43:49 -0400
Date: Tue, 30 Aug 2011 10:43:46 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [git pull] documentation directory
Message-ID: <20110830084346.GO1855@nb.net.home>
References: <CAG27Bk0wyFiELxMA2Rj9DyqqMkP9dGm4J1Y=yU4S7gZFo00QFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk0wyFiELxMA2Rj9DyqqMkP9dGm4J1Y=yU4S7gZFo00QFw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Aug 06, 2011 at 07:57:53PM +0200, Sami Kerola wrote:
> are available in the git repository at:
>   https://github.com/kerolasa/lelux-utiliteetit docs-dir

 I found a small problem... IMHO there should be some COPYING
 file in the libmount/ libblkid/ and libuuid/ directories.

 It's probably overkill to duplicate the text on all places (or in
 Documentation/licenses directory), so what about to add lib*/COPYING
 with:

        This library is free software; you can redistribute it and/or
        modify it under the terms of the GNU Lesser General Public
        License as published by the Free Software Foundation; either
        version 2.1 of the License, or (at your option) any later version.

        The complete text of the license is available at the 
        Documentation/licenses/COPYING.LGPL file.


 and add one Documentation/licenses/COPYING.LGPL file for all libraries.

 I'm not sure if we need the LICENSE.pg file, the same text is at the
 begin of the pg.c.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
