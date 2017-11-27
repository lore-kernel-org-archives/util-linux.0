Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752796AbdK0Qqm (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 27 Nov 2017 11:46:42 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9507B4ACA0
        for <util-linux@vger.kernel.org>; Mon, 27 Nov 2017 16:46:42 +0000 (UTC)
Date: Mon, 27 Nov 2017 17:46:39 +0100
From: Karel Zak <kzak@redhat.com>
To: Masatake YAMATO <yamato@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Add netnsid and nsfs columns to lsns
Message-ID: <20171127164639.3thyhe7c6fohoeyt@ws.net.home>
References: <20171124103110.17077-1-yamato@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171124103110.17077-1-yamato@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Nov 24, 2017 at 07:31:02PM +0900, Masatake YAMATO wrote:
>   lsns: add netnsid column
>   lsns: disable netnsid column by default
>   lsns: add a case for testing netnsid column
>   lsns: add nsfs column
>   lsns: add --nowrap(-W) option
>   lsns: add a case for testing nsfs column
>   man: write about using multi-line in NSFS cell of lsns

Merged; I have merged also some additional changes to cleanup a little
bit the code. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
