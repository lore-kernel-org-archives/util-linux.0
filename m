Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45620 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752054AbdC0LJQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 27 Mar 2017 07:09:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BAAED624C6
        for <util-linux@vger.kernel.org>; Mon, 27 Mar 2017 11:09:15 +0000 (UTC)
Date: Mon, 27 Mar 2017 13:09:11 +0200
From: Karel Zak <kzak@redhat.com>
To: Masatake YAMATO <yamato@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/4] fincore command
Message-ID: <20170327110911.6uyoprjf3n3ds5cy@ws.net.home>
References: <20170307023352.7340-1-yamato@redhat.com>
 <20170323115825.paxktr7xxgevrcju@ws.net.home>
 <20170323144523.24u45orqhq75oosj@ws.net.home>
 <20170327.094152.1904964943153919266.yamato@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170327.094152.1904964943153919266.yamato@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 27, 2017 at 09:41:52AM +0900, Masatake YAMATO wrote:
> About RES and RSS, I don't know which is better.
> As you know top command users RES and ps command uses RSS...

 Added column RES.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
