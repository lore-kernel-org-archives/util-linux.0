Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934875AbdKPNOI (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 16 Nov 2017 08:14:08 -0500
Date: Thu, 16 Nov 2017 14:14:04 +0100
From: Karel Zak <kzak@redhat.com>
To: Mikhail Vorobyov <m.vorobyov@cs.msu.ru>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2 1/2] libfdisk: (sun) move aligning of the first sector
 before availability check
Message-ID: <20171116131404.n62oa2zmfc23mby7@ws.net.home>
References: <adcf7175-1dff-231d-46fd-bc146c114317@cs.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <adcf7175-1dff-231d-46fd-bc146c114317@cs.msu.ru>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Nov 09, 2017 at 06:37:28AM +0300, Mikhail Vorobyov wrote:
>  libfdisk/src/sun.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)

Both applied.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
