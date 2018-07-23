Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43206 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388005AbeGWN4L (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 23 Jul 2018 09:56:11 -0400
Date: Mon, 23 Jul 2018 14:55:01 +0200
From: Karel Zak <kzak@redhat.com>
To: Edward Diener <eldlistmailingz@tropicsoft.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Documentation for libraries
Message-ID: <20180723125501.55wryt66kjqazt7f@ws.net.home>
References: <c1ad48a2-46b9-c694-7610-c463ba453f4d@tropicsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c1ad48a2-46b9-c694-7610-c463ba453f4d@tropicsoft.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 23, 2018 at 08:33:52AM -0400, Edward Diener wrote:
> Where is there documentation for using libblkid and libfdisk, either online
> or part of the util-linux package ?

See lib*-docs dirs for generated reference manual:

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.32/

we have also lib*/samples/ dirs with some very basic stuff in our
source tree.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
