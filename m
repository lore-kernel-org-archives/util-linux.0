Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752788AbeDJL4J (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 10 Apr 2018 07:56:09 -0400
Date: Tue, 10 Apr 2018 13:56:05 +0200
From: Karel Zak <kzak@redhat.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: util-linux@vger.kernel.org, mail@nh2.me
Subject: Re: [PATCH v2] setpriv: implement option to set parent death signal
Message-ID: <20180410115605.7t2fozayc6lk7jio@ws.net.home>
References: <20180410100023.yego5fwd552id2u6@ws.net.home>
 <ee7de238f29ee5ebc68733183ffc71239252cb3a.1523358390.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ee7de238f29ee5ebc68733183ffc71239252cb3a.1523358390.git.ps@pks.im>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 10, 2018 at 12:08:21PM +0100, Patrick Steinhardt wrote:
>  sys-utils/setpriv.1 |  6 ++++++
>  sys-utils/setpriv.c | 48 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)

Thanks! Merged.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
